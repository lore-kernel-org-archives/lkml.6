Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C6FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6486120851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/Qm0+AZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6486120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeLDLbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:31:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeLDK42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:56:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA139214ED;
        Tue,  4 Dec 2018 10:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920988;
        bh=Zb/Uh5jkgfSc5bzzGsdljo3iPPqEzjWvgolqSAALcgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/Qm0+AZR1dMJMQQHYvE/INUp76oOJdrxBwfKtbUweajMJtpQIkN9OKI5mrKeA96p
         5PA/hRKxylJ2IvPNJ653oDYBROoH+UeHrnG7ZuyGMEIQPQmHx2Q/yfRv78X+K0AnMJ
         4aQNCHIt2nxjRzz00Y6KKY2zmAP1Zpv0+i2uAsDw=
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
Subject: [PATCH 4.19 004/139] mm/khugepaged: collapse_shmem() stop if punched or truncated
Date:   Tue,  4 Dec 2018 11:48:05 +0100
Message-Id: <20181204103650.134100005@linuxfoundation.org>
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
index a31d740e6cd1..0378f758b065 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1349,6 +1349,16 @@ static void collapse_shmem(struct mm_struct *mm,
 	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
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
@@ -1459,6 +1469,11 @@ static void collapse_shmem(struct mm_struct *mm,
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



