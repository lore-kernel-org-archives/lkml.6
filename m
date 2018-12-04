Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239CE2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZgeg8GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239CE2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeLDK4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbeLDK4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:56:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8916521508;
        Tue,  4 Dec 2018 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920993;
        bh=GQYbBTYiA6s/AOZMS87ly6cILcsApi0hOsMREvY4TYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZgeg8GBbueEcRdcWG2TYs3UeUxLskbkcxcy/Pz1uVa6+qsOU+Xh0sN8JbDHg6iiI
         9zQIaJ46id1yb1OKFvglz09Tvgk/yw6fGDtR/gEAmVXC4I3JQfAGHPNpWoHASoeLnZ
         KwSvq+U6L/JPNKiSnScWYwyB3LLscbIJ2jW+3tuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 006/139] mm/khugepaged: collapse_shmem() remember to clear holes
Date:   Tue,  4 Dec 2018 11:48:07 +0100
Message-Id: <20181204103650.219807209@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 2af8ff291848cc4b1cce24b6c943394eb2c761e8 upstream.

Huge tmpfs testing reminds us that there is no __GFP_ZERO in the gfp
flags khugepaged uses to allocate a huge page - in all common cases it
would just be a waste of effort - so collapse_shmem() must remember to
clear out any holes that it instantiates.

The obvious place to do so, where they are put into the page cache tree,
is not a good choice: because interrupts are disabled there.  Leave it
until further down, once success is assured, where the other pages are
copied (before setting PageUptodate).

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1811261525080.2275@eggly.anvils
Fixes: f3f0e1d2150b2 ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 87dbb0fcfa1a..068868763b78 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1498,7 +1498,12 @@ static void collapse_shmem(struct mm_struct *mm,
 		 * Replacing old pages with new one has succeed, now we need to
 		 * copy the content and free old pages.
 		 */
+		index = start;
 		list_for_each_entry_safe(page, tmp, &pagelist, lru) {
+			while (index < page->index) {
+				clear_highpage(new_page + (index % HPAGE_PMD_NR));
+				index++;
+			}
 			copy_highpage(new_page + (page->index % HPAGE_PMD_NR),
 					page);
 			list_del(&page->lru);
@@ -1508,6 +1513,11 @@ static void collapse_shmem(struct mm_struct *mm,
 			ClearPageActive(page);
 			ClearPageUnevictable(page);
 			put_page(page);
+			index++;
+		}
+		while (index < end) {
+			clear_highpage(new_page + (index % HPAGE_PMD_NR));
+			index++;
 		}
 
 		local_irq_save(flags);
-- 
2.17.1



