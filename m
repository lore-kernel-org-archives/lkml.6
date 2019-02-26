Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3A4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E789C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfBZJNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:13:40 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:36818 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJNk (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 26 Feb 2019 04:13:40 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 26 Feb 2019 10:13:38 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 26 Feb 2019 09:13:28 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, hughd@google.com, kirill@shutemov.name,
        vbabka@suse.cz, joel@joelfernandes.org, jglisse@redhat.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm,mremap: Bail out earlier in mremap_to under map pressure
Date:   Tue, 26 Feb 2019 10:13:14 +0100
Message-Id: <20190226091314.18446-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using mremap() syscall in addition to MREMAP_FIXED flag,
mremap() calls mremap_to() which does the following:

1) unmaps the destination region where we are going to move the map
2) If the new region is going to be smaller, we unmap the last part
   of the old region

Then, we will eventually call move_vma() to do the actual move.

move_vma() checks whether we are at least 4 maps below max_map_count
before going further, otherwise it bails out with -ENOMEM.
The problem is that we might have already unmapped the vma's in steps
1) and 2), so it is not possible for userspace to figure out the state
of the vma's after it gets -ENOMEM, and it gets tricky for userspace
to clean up properly on error path.

While it is true that we can return -ENOMEM for more reasons
(e.g: see may_expand_vm() or move_page_tables()), I think that we can
avoid this scenario in concret if we check early in mremap_to() if the
operation has high chances to succeed map-wise.

Should not be that the case, we can bail out before we even try to unmap
anything, so we make sure the vma's are left untouched in case we are likely
to be short of maps.

The thumb-rule now is to rely on the worst-scenario case we can have.
That is when both vma's (old region and new region) are going to be split
in 3, so we get two more maps to the ones we already hold (one per each).
If current map count + 2 maps still leads us to 4 maps below the threshold,
we are going to pass the check in move_vma().

Of course, this is not free, as it might generate false positives when it is
true that we are tight map-wise, but the unmap operation can release several
vma's leading us to a good state.

Another approach was also investigated [1], but it may be too much hassle
for what it brings.

[1] https://lore.kernel.org/lkml/20190219155320.tkfkwvqk53tfdojt@d104.suse.de/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/mremap.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 3320616ed93f..e3edef6b7a12 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -516,6 +516,23 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if (addr + old_len > new_addr && new_addr + new_len > addr)
 		goto out;
 
+	/*
+	 * move_vma() need us to stay 4 maps below the threshold, otherwise
+	 * it will bail out at the very beginning.
+	 * That is a problem if we have already unmaped the regions here
+	 * (new_addr, and old_addr), because userspace will not know the
+	 * state of the vma's after it gets -ENOMEM.
+	 * So, to avoid such scenario we can pre-compute if the whole
+	 * operation has high chances to success map-wise.
+	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
+	 * split in 3 before unmaping it.
+	 * That means 2 more maps (1 for each) to the ones we already hold.
+	 * Check whether current map count plus 2 still leads us to 4 maps below
+	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 */
+	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
+		return -ENOMEM;
+
 	ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
 	if (ret)
 		goto out;
-- 
2.13.7

