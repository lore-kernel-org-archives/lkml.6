Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CECCC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93AF2250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEz873R/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93AF2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeKMPsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbeKMPsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:23 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F282250E;
        Tue, 13 Nov 2018 05:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088315;
        bh=qvhnOLe0Amh57SirA8Nn66irwBqaiSvMQYW06ao7ULA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEz873R/l1uWUV6t4y/pVwd/icU39bD9HAyo7KIRzsoLNrgYJNUFjUYaO+TjOAiG9
         45CkFS0ryv/gEbbbd9E7y+my1m6ifBjCw/4jjVMWmDZ0bMv4r2V5B7bXS7MBpxPsRm
         cR33vnPlVDn59tC5QAjOyi1hlqSSfRh68UgCAqw8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.14 07/26] mm: Fix warning in insert_pfn()
Date:   Tue, 13 Nov 2018 00:51:31 -0500
Message-Id: <20181113055150.78773-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit f2c57d91b0d96aa13ccff4e3b178038f17b00658 ]

In DAX mode a write pagefault can race with write(2) in the following
way:

CPU0                            CPU1
                                write fault for mapped zero page (hole)
dax_iomap_rw()
  iomap_apply()
    xfs_file_iomap_begin()
      - allocates blocks
    dax_iomap_actor()
      invalidate_inode_pages2_range()
        - invalidates radix tree entries in given range
                                dax_iomap_pte_fault()
                                  grab_mapping_entry()
                                    - no entry found, creates empty
                                  ...
                                  xfs_file_iomap_begin()
                                    - finds already allocated block
                                  ...
                                  vmf_insert_mixed_mkwrite()
                                    - WARNs and does nothing because there
                                      is still zero page mapped in PTE
        unmap_mapping_pages()

This race results in WARN_ON from insert_pfn() and is occasionally
triggered by fstest generic/344. Note that the race is otherwise
harmless as before write(2) on CPU0 is finished, we will invalidate page
tables properly and thus user of mmap will see modified data from
write(2) from that point on. So just restrict the warning only to the
case when the PFN in PTE is not zero page.

Link: http://lkml.kernel.org/r/20180824154542.26872-1-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 93d5d324904b..9c0172a4d9bf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1804,10 +1804,15 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			 * in may not match the PFN we have mapped if the
 			 * mapped PFN is a writeable COW page.  In the mkwrite
 			 * case we are creating a writable PTE for a shared
-			 * mapping and we expect the PFNs to match.
+			 * mapping and we expect the PFNs to match. If they
+			 * don't match, we are likely racing with block
+			 * allocation and mapping invalidation so just skip the
+			 * update.
 			 */
-			if (WARN_ON_ONCE(pte_pfn(*pte) != pfn_t_to_pfn(pfn)))
+			if (pte_pfn(*pte) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(*pte)));
 				goto out_unlock;
+			}
 			entry = *pte;
 			goto out_mkwrite;
 		} else
-- 
2.17.1

