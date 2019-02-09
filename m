Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF18C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 03:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974F8217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 03:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fRpytnAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBIDSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 22:18:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfBIDSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 22:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h8f8smstUZQLCufTi9qiwOHuCg8qK2omLGGgf3XFc8Y=; b=fRpytnAqeIRYAO0nIK4sbTtwt
        08CRQu7K8fjpFnNRHKZVWJAzIpfpOaapNXTnMm6ukDUeTm+rVQbvY7q1z0d5BgkYC7VLAxEZwECh8
        T9vYI4WoEQVNycyNsvQy9+KiuBn+7Ilg1WCCVZiPsArV5rPFczmlnxAtL1e+bvGCXytagFPLCVhaO
        P5eoK3oHOs+1gXoYdRhPS2TzwxdbeL4OxLLGQAMRkh0P3GzE+gJ6bLJ7d+wDjUMbA9yxsboVuYhPv
        z1kwkV/vaiXf4Aa8Rp55acLVKC2x8JlZhZMsLEU0h7DhnlHfpzelKfME/mWItoN0chJWpfyZBH3ve
        y/a5fflbA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gsJ9e-0005Cu-26; Sat, 09 Feb 2019 03:18:10 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -mmotm/-next] fs: fs_parser: fix printk format warning
Message-ID: <19432668-ffd3-fbb2-af4f-1c8e48f6cc81@infradead.org>
Date:   Fri, 8 Feb 2019 19:18:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warning (seen on i386 builds) by using ptrdiff
format specifier (%t):

../fs/fs_parser.c:413:6: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘int’ [-Wformat=]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/fs_parser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- mmotm-2019-0208-1633.orig/fs/fs_parser.c
+++ mmotm-2019-0208-1633/fs/fs_parser.c
@@ -410,7 +410,7 @@ bool fs_validate_description(const struc
 			for (param = desc->specs; param->name; param++) {
 				if (param->opt == e->opt &&
 				    param->type != fs_param_is_enum) {
-					pr_err("VALIDATE %s: e[%lu] enum val for %s\n",
+					pr_err("VALIDATE %s: e[%tu] enum val for %s\n",
 					       name, e - desc->enums, param->name);
 					good = false;
 				}


