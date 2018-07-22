Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4AECDE5F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 02:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25D220854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 02:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TfZBxA1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25D220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeGVDwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 23:52:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbeGVDwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 23:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7L8sTRbX4q3IoJGqagvE3N6GEgOo1odsKcIm2zIu2kU=; b=TfZBxA1T6SxSSL1NYDo91J/z9
        Jb1fA33gis3Ha1p2sck284PZgyP7dUmeVe0c3M57otGh7EYdh4oeKgRdUfB49mJ7k3zpp3uFFPpZv
        bX0UpjdAA1y+aZNTRty700n1AVzLIkTi8g3lAwM3E7lfU1UWzg9S3SsQ5KV4PxiFyveqKrXCpw1U+
        o87WYiWjFF6R1vyX3ne35DQZQpb+4xLaP3X8l6O1lZW47jz0dY7MN22YAbBl2wxDElzP2rYrZbp72
        3JTZ5609Lw0oGYREJlJ86ac5xfuzMqKpmwe2A1QLCqOLJwsZubo73wFmHtOU3DmkHvWQkzG7wH0V5
        +fdJJNsVQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fh4Yk-0002zq-23; Sun, 22 Jul 2018 02:57:22 +0000
To:     LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org,
        David Miller <davem@davemloft.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sparc: fix header problem in sparc32 build
Message-ID: <42f344e6-73c1-87c5-ea2f-b3299675266b@infradead.org>
Date:   Sat, 21 Jul 2018 19:57:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add a "struct page;" "stub" to fix a build error in sparc32.
Fixes this error:

../include/linux/highmem.h: In function 'clear_user_highpage':
../include/linux/highmem.h:137:31: error: passing argument 1 of 'sparc_flush_page_to_ram' from incompatible pointer type [-Werror=incompatible-pointer-types]
  clear_user_page(addr, vaddr, page);
                               ^~~~
../arch/sparc/include/asm/page_32.h:24:27: note: in definition of macro 'clear_user_page'
   sparc_flush_page_to_ram(page); \
                           ^~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/sparc/include/asm/cacheflush_32.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180717.orig/arch/sparc/include/asm/cacheflush_32.h
+++ linux-next-20180717/arch/sparc/include/asm/cacheflush_32.h
@@ -37,6 +37,7 @@
 #define flush_page_for_dma(addr) \
 	sparc32_cachetlb_ops->page_for_dma(addr)
 
+struct page;
 void sparc_flush_page_to_ram(struct page *page);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1


