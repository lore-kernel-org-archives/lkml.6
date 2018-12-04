Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B00CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7F1214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1E/aduf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7F1214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeLDLBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbeLDLBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80311214DE;
        Tue,  4 Dec 2018 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921312;
        bh=X+GOatQ+RRzQJv189kGBHFuIlMJW02zaW6uFprc9x6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1E/aduf2iBTn8xxR5g7eQg7IHzPwVm266I9BgDiKrbjSrBaq+pKeKP0NkCo5n2Mf
         7SGi7RLk5pWV5MVh0dzb3FvHjnVyt+m9W2K1DJ9vfoKgWKJj6XlRsre5mVLSWNqzsk
         sCN3H8YpHjad6CTYdDyyV87/d3fQ9KN5AxvawK/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Lesokhin <ilyal@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 022/146] tls: Avoid copying crypto_info again after cipher_type check.
Date:   Tue,  4 Dec 2018 11:48:28 +0100
Message-Id: <20181204103727.705966671@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 196c31b4b54474b31dee3c30352c45c2a93e9226 upstream.

Avoid copying crypto_info again after cipher_type check
to avoid a TOCTOU exploits.
The temporary array on the stack is removed as we don't really need it

Fixes: 3c4d7559159b ('tls: kernel TLS support')
Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 4.14: Preserve changes made by earlier backports of
 "tls: return -EBUSY if crypto_info is already set" and "tls: zero the
 crypto information from tls_context before freeing"]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_main.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b5f9c578bcf0..f88df514ad5f 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -381,7 +381,7 @@ static int tls_getsockopt(struct sock *sk, int level, int optname,
 static int do_tls_setsockopt_tx(struct sock *sk, char __user *optval,
 				unsigned int optlen)
 {
-	struct tls_crypto_info *crypto_info, tmp_crypto_info;
+	struct tls_crypto_info *crypto_info;
 	struct tls_context *ctx = tls_get_ctx(sk);
 	int rc = 0;
 	int tx_conf;
@@ -391,38 +391,33 @@ static int do_tls_setsockopt_tx(struct sock *sk, char __user *optval,
 		goto out;
 	}
 
-	rc = copy_from_user(&tmp_crypto_info, optval, sizeof(*crypto_info));
+	crypto_info = &ctx->crypto_send.info;
+	/* Currently we don't support set crypto info more than one time */
+	if (TLS_CRYPTO_INFO_READY(crypto_info)) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	rc = copy_from_user(crypto_info, optval, sizeof(*crypto_info));
 	if (rc) {
 		rc = -EFAULT;
 		goto out;
 	}
 
 	/* check version */
-	if (tmp_crypto_info.version != TLS_1_2_VERSION) {
+	if (crypto_info->version != TLS_1_2_VERSION) {
 		rc = -ENOTSUPP;
-		goto out;
-	}
-
-	/* get user crypto info */
-	crypto_info = &ctx->crypto_send.info;
-
-	/* Currently we don't support set crypto info more than one time */
-	if (TLS_CRYPTO_INFO_READY(crypto_info)) {
-		rc = -EBUSY;
-		goto out;
+		goto err_crypto_info;
 	}
 
-	switch (tmp_crypto_info.cipher_type) {
+	switch (crypto_info->cipher_type) {
 	case TLS_CIPHER_AES_GCM_128: {
 		if (optlen != sizeof(struct tls12_crypto_info_aes_gcm_128)) {
 			rc = -EINVAL;
 			goto err_crypto_info;
 		}
-		rc = copy_from_user(
-		  crypto_info,
-		  optval,
-		  sizeof(struct tls12_crypto_info_aes_gcm_128));
-
+		rc = copy_from_user(crypto_info + 1, optval + sizeof(*crypto_info),
+				    optlen - sizeof(*crypto_info));
 		if (rc) {
 			rc = -EFAULT;
 			goto err_crypto_info;
-- 
2.17.1



