Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD28B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e5cmBaFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBUDdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 22:33:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfBUDdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 22:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ccW8NFDQ9aJez3uVBCk8mz57hd+pg+VBYOFPu0d+Xws=; b=e5cmBaFo8HdTL+C2Viy+Ba5d+
        /JCQ6gCbsmqfy3xgxyWBnPCcaz/vYrVui8EvDsXTEYgPODdMZIKYosWyjPAHpedG7cd1qUb9/l8BX
        VzSHVjhAy3eaKy7XWud4+8nCe33tN6DFBRJMdUXnGjzOsHH8BXNDM1jxX5PIhoVajQ88UzgwJryEb
        pMGe8qBa34Qo/AcK4Zp5T3Y1TyQYWQFugOFe0lDFTCpgO/Ebj4L/09dicmwBSdNJwq40iyITVmbAa
        TrMaBefUMpp0SPzGtS3AR/vabvcjbaYb7OiA/wgmNWG7fN9WK1C+dxzJhrVa/1qyLrktw0/Ni0Fio
        7EwYYq37w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwf7I-00009B-8O; Thu, 21 Feb 2019 03:33:44 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] <linux/kernel.h>: drop the gcc-3.3 'const' hack in roundup()
Message-ID: <ec5dcf72-7c3e-3513-af0c-4003ed598854@infradead.org>
Date:   Wed, 20 Feb 2019 19:33:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

The single quotation marks around "const" were causing a
documentation markup warning with reST.  Instead of fixing that
warning, just delete that comment line and the gcc-3.3 hack of
using "const" in the roundup() macro since gcc-3.3 is no longer
supported for kernel builds.

I did around 20 different $arch builds with no problems, but
we'll just have to see if this causes problems for anyone else
out there.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/kernel.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- lnx-50-rc7.orig/include/linux/kernel.h
+++ lnx-50-rc7/include/linux/kernel.h
@@ -133,12 +133,10 @@
  *
  * Rounds @x up to next multiple of @y. If @y will always be a power
  * of 2, consider using the faster round_up().
- *
- * The `const' here prevents gcc-3.3 from calling __divdi3
  */
 #define roundup(x, y) (					\
 {							\
-	const typeof(y) __y = y;			\
+	typeof(y) __y = y;				\
 	(((x) + (__y - 1)) / __y) * __y;		\
 }							\
 )


