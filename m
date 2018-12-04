Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB5C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B939214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vyQqtMza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B939214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeLDK4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeLDK4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:56:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD42A214D9;
        Tue,  4 Dec 2018 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921000;
        bh=RdL0LSlUOAuVtqt/N+1KTdXLzqA5bAxRE3xVB4fvv/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyQqtMzaD1S9U0VIoDwnN7ael4maRUVs7wmxUdofX2LKbVyRSFCPz4sxljv7N1qD4
         5WcMr5XDCf0LNZp7hImYIxRqM8ObFdU9HsOA6Y4b80YpMNvFtqLRt0mwh0T2XKtHSz
         W3+LdgCNmemWEHd7+I2KJo4K1nyDflU45+Wnbl6I=
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
Subject: [PATCH 4.19 009/139] mm/khugepaged: collapse_shmem() do not crash on Compound
Date:   Tue,  4 Dec 2018 11:48:10 +0100
Message-Id: <20181204103650.366384496@linuxfoundation.org>
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

commit 06a5e1268a5fb9c2b346a3da6b97e85f2eba0f07 upstream.

collapse_shmem()'s VM_BUG_ON_PAGE(PageTransCompound) was unsafe: before
it holds page lock of the first page, racing truncation then extension
might conceivably have inserted a hugepage there already.  Fail with the
SCAN_PAGE_COMPOUND result, instead of crashing (CONFIG_DEBUG_VM=y) or
otherwise mishandling the unexpected hugepage - though later we might
code up a more constructive way of handling it, with SCAN_SUCCESS.

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1811261529310.2275@eggly.anvils
Fixes: f3f0e1d2150b2 ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e2b13c04626e..fde5820be24d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1398,7 +1398,15 @@ static void collapse_shmem(struct mm_struct *mm,
 		 */
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(!PageUptodate(page), page);
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
+
+		/*
+		 * If file was truncated then extended, or hole-punched, before
+		 * we locked the first page, then a THP might be there already.
+		 */
+		if (PageTransCompound(page)) {
+			result = SCAN_PAGE_COMPOUND;
+			goto out_unlock;
+		}
 
 		if (page_mapping(page) != mapping) {
 			result = SCAN_TRUNCATED;
-- 
2.17.1



