Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0802148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDg0qNhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfA2Fif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:38:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfA2Fif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t8fkzWMHxXDIkytKtq4mCKfuJ+XlIbmSP26+VZ3R6Tw=; b=jDg0qNhQ8VD/4F9eDb3TAcCXx
        KgrHXFD4VUcQ7FG4aqXzx+03Sz9cGxs8Fu1XTbjulAd4M9G9ltw8J72wpUM4eG8/t3t26w6TYpkZ+
        9j0Di4upLo9PJrngncDKQ60gYIFuZITAk1kfiOHP6UwoEHolJKTbn3p4iK2STBQpOh+bhac4NIyhr
        Srd2fjPNNoh/yaxeszJy1KPd41ffdRnUZ0VEWvUHxnsiAkVS2CI2HQaqK+6A9DdWP0pGCsjSU1rkA
        wuDjExz/IA8gHWwZ0TjoqfdZ7sVZ1TM3TjwAyCAaSW2NrFESAE5jqaGaCohDGut/W01IpjUZFZdZz
        W3aRK/IkA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goM6T-0000zO-1P; Tue, 29 Jan 2019 05:38:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] mm: Prevent mapping typed pages to userspace
Date:   Mon, 28 Jan 2019 21:38:30 -0800
Message-Id: <20190129053830.3749-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages which use page_type must never be mapped to userspace as it would
destroy their page type.  Add an explicit check for this instead of
assuming that kernel drivers always get this right.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index ce8c90b752be..db3534bbd652 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1451,7 +1451,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	spinlock_t *ptl;
 
 	retval = -EINVAL;
-	if (PageAnon(page) || PageSlab(page))
+	if (PageAnon(page) || PageSlab(page) || page_has_type(page))
 		goto out;
 	retval = -ENOMEM;
 	flush_dcache_page(page);
-- 
2.20.1

