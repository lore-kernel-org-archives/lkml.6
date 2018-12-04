Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E877BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE272082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vzKOi7lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE272082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeLDLLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:11:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbeLDLI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E029214DB;
        Tue,  4 Dec 2018 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921738;
        bh=kSwrj/y6N1gLvfnF3l6UGNZ+cWKblqNB7gBF1VGcL0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzKOi7loN21ugae9pT1mafJHdtuLx/vrfyh820/Fa/VLgwnpUpZma20//MeRBsRi+
         R027LX7Yy3rIOiYroOhHamzn48Q1TuauHa+o/3ZjKnv01Y85q46sKWAckcFo7dicHE
         MnXjd6BnE4zYBDptVln78Nq6i/9k2TK4Brwqkj8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/50] mm/khugepaged: collapse_shmem() stop if punched or truncated
Date:   Tue,  4 Dec 2018 11:50:00 +0100
Message-Id: <20181204103714.772372883@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 701270fa193aadf00bdcf607738f64997275d4c7 upstream.

Huge tmpfs testing showed that although collapse_shmem() recognizes a
concurrently truncated or hole-punched page correctly, its handling of
holes was liable to refill an emptied extent.  Add check to stop that.

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1811261522040.2275@eggly.anvils
Fixes: f3f0e1d2150b2 ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1df37ee996d5..62de24194f24 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1351,6 +1351,16 @@ static void collapse_shmem(struct mm_struct *mm,
 	radix_tree_for_each_slot(slot, &mapping->page_tree, &iter, start) {
 		int n = min(iter.index, end) - index;
 
+		/*
+		 * Stop if extent has been hole-punched, and is now completely
+		 * empty (the more obvious i_size_read() check would take an
+		 * irq-unsafe seqlock on 32-bit).
+		 */
+		if (n >= HPAGE_PMD_NR) {
+			result = SCAN_TRUNCATED;
+			goto tree_locked;
+		}
+
 		/*
 		 * Handle holes in the radix tree: charge it from shmem and
 		 * insert relevant subpage of new_page into the radix-tree.
@@ -1462,6 +1472,11 @@ static void collapse_shmem(struct mm_struct *mm,
 	if (result == SCAN_SUCCEED && index < end) {
 		int n = end - index;
 
+		/* Stop if extent has been truncated, and is now empty */
+		if (n >= HPAGE_PMD_NR) {
+			result = SCAN_TRUNCATED;
+			goto tree_locked;
+		}
 		if (!shmem_charge(mapping->host, n)) {
 			result = SCAN_FAIL;
 			goto tree_locked;
-- 
2.17.1



