Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A858B214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x5DqBkq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A858B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbeKTDJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387628AbeKTDJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:09:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121DF2148E;
        Mon, 19 Nov 2018 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645920;
        bh=Qul0pBlNyqaiAOfQSv6Hp9YtdNwii4fsFzqvM5jDzM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5DqBkq57Dsie8ISZxONhhzH/vzWqmbIf82OJAdxwJZoC5GHnH/ogjjkjMWP9l59Y
         26/sP/AA+7m13W6PokPnugQ79+OIGX9W86SKAdOr7Z5H9RdFuzlZz2g/7NRduODGtN
         zLUh8zvHUdwpdCn9qe0W5W4iVRlthMs4MJb3AXKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 139/171] crypto: user - fix leaking uninitialized memory to userspace
Date:   Mon, 19 Nov 2018 17:28:55 +0100
Message-Id: <20181119162638.713493993@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit f43f39958beb206b53292801e216d9b8a660f087 upstream.

All bytes of the NETLINK_CRYPTO report structures must be initialized,
since they are copied to userspace.  The change from strncpy() to
strlcpy() broke this.  As a minimal fix, change it back.

Fixes: 4473710df1f8 ("crypto: user - Prepare for CRYPTO_MAX_ALG_NAME expansion")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/crypto_user.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/crypto/crypto_user.c
+++ b/crypto/crypto_user.c
@@ -83,7 +83,7 @@ static int crypto_report_cipher(struct s
 {
 	struct crypto_report_cipher rcipher;
 
-	strlcpy(rcipher.type, "cipher", sizeof(rcipher.type));
+	strncpy(rcipher.type, "cipher", sizeof(rcipher.type));
 
 	rcipher.blocksize = alg->cra_blocksize;
 	rcipher.min_keysize = alg->cra_cipher.cia_min_keysize;
@@ -102,7 +102,7 @@ static int crypto_report_comp(struct sk_
 {
 	struct crypto_report_comp rcomp;
 
-	strlcpy(rcomp.type, "compression", sizeof(rcomp.type));
+	strncpy(rcomp.type, "compression", sizeof(rcomp.type));
 	if (nla_put(skb, CRYPTOCFGA_REPORT_COMPRESS,
 		    sizeof(struct crypto_report_comp), &rcomp))
 		goto nla_put_failure;
@@ -116,7 +116,7 @@ static int crypto_report_acomp(struct sk
 {
 	struct crypto_report_acomp racomp;
 
-	strlcpy(racomp.type, "acomp", sizeof(racomp.type));
+	strncpy(racomp.type, "acomp", sizeof(racomp.type));
 
 	if (nla_put(skb, CRYPTOCFGA_REPORT_ACOMP,
 		    sizeof(struct crypto_report_acomp), &racomp))
@@ -131,7 +131,7 @@ static int crypto_report_akcipher(struct
 {
 	struct crypto_report_akcipher rakcipher;
 
-	strlcpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
+	strncpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
 
 	if (nla_put(skb, CRYPTOCFGA_REPORT_AKCIPHER,
 		    sizeof(struct crypto_report_akcipher), &rakcipher))
@@ -146,7 +146,7 @@ static int crypto_report_kpp(struct sk_b
 {
 	struct crypto_report_kpp rkpp;
 
-	strlcpy(rkpp.type, "kpp", sizeof(rkpp.type));
+	strncpy(rkpp.type, "kpp", sizeof(rkpp.type));
 
 	if (nla_put(skb, CRYPTOCFGA_REPORT_KPP,
 		    sizeof(struct crypto_report_kpp), &rkpp))
@@ -160,10 +160,10 @@ nla_put_failure:
 static int crypto_report_one(struct crypto_alg *alg,
 			     struct crypto_user_alg *ualg, struct sk_buff *skb)
 {
-	strlcpy(ualg->cru_name, alg->cra_name, sizeof(ualg->cru_name));
-	strlcpy(ualg->cru_driver_name, alg->cra_driver_name,
+	strncpy(ualg->cru_name, alg->cra_name, sizeof(ualg->cru_name));
+	strncpy(ualg->cru_driver_name, alg->cra_driver_name,
 		sizeof(ualg->cru_driver_name));
-	strlcpy(ualg->cru_module_name, module_name(alg->cra_module),
+	strncpy(ualg->cru_module_name, module_name(alg->cra_module),
 		sizeof(ualg->cru_module_name));
 
 	ualg->cru_type = 0;
@@ -176,7 +176,7 @@ static int crypto_report_one(struct cryp
 	if (alg->cra_flags & CRYPTO_ALG_LARVAL) {
 		struct crypto_report_larval rl;
 
-		strlcpy(rl.type, "larval", sizeof(rl.type));
+		strncpy(rl.type, "larval", sizeof(rl.type));
 		if (nla_put(skb, CRYPTOCFGA_REPORT_LARVAL,
 			    sizeof(struct crypto_report_larval), &rl))
 			goto nla_put_failure;


