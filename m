Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DA1C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C4B2450D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JK0cR6d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C4B2450D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934294AbeFVPjD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:39:03 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52931 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933977AbeFVPjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:39:00 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c85d39f4;
        Fri, 22 Jun 2018 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id; s=mail; bh=rYikv6ptkzdE6TLr0Amjt+aPpRw
        =; b=JK0cR6d3IT4+2/pv2Yo7tkcdok28iWOqd8DZdVTzi9N6Q5CTih5ortiG4kS
        1Y5qe92FO6OkxyTb0U1xTxFXxEj0bEs7aQohwzepg/ypPMcg/fFZM+7iHL4vRGY8
        xTNuYU3j9WFzc7M3E0NjWCpJXGO8G1i3EHaae4/zHF3LkjTBFa23BmMaT87lPxtB
        zCI9zdFZK6GIfr6N0iR4z9iCBvjE4TRKUwvFDFHqk27DKQpsXz+2SUVVfkWe45EZ
        4l3k67Zn1rTqYz2OyKw6EkqoEvCnl3D+5uQEJcn5jVirvOvILMPu1ICpmB8iYt7D
        zXvGkp56RTVg9KUlyvIVf7ZCLYg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21ec1527 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 22 Jun 2018 15:32:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] module: print sensible error code
Date:   Fri, 22 Jun 2018 17:38:50 +0200
Message-Id: <20180622153850.24240-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing "err 0" to the user in the warning message is not particularly
useful, especially when this gets transformed into a -ENOENT for the
remainder of the call chain.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index f475f30eed8c..c666ab4139f4 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2282,9 +2282,9 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 			if (!ksym && ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
 				break;
 
-			pr_warn("%s: Unknown symbol %s (err %li)\n",
-				mod->name, name, PTR_ERR(ksym));
 			ret = PTR_ERR(ksym) ?: -ENOENT;
+			pr_warn("%s: Unknown symbol %s (err %d)\n",
+				mod->name, name, ret);
 			break;
 
 		default:
-- 
2.17.1

