Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EA72152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EA72152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeI0PeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:34:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeI0Pd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:33:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF3881117;
        Thu, 27 Sep 2018 09:16:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 11/64] tls: dont copy the key out of tls12_crypto_info_aes_gcm_128
Date:   Thu, 27 Sep 2018 11:03:28 +0200
Message-Id: <20180927090251.258066557@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 7cba09c6d5bc73ebbd25a353742d9ddb7a713b95 ]

There's no need to copy the key to an on-stack buffer before calling
crypto_aead_setkey().

Fixes: 3c4d7559159b ("tls: kernel TLS support")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -661,7 +661,6 @@ static void tls_sw_free_resources(struct
 
 int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx)
 {
-	char keyval[TLS_CIPHER_AES_GCM_128_KEY_SIZE];
 	struct tls_crypto_info *crypto_info;
 	struct tls12_crypto_info_aes_gcm_128 *gcm_128_info;
 	struct tls_sw_context *sw_ctx;
@@ -753,9 +752,7 @@ int tls_set_sw_offload(struct sock *sk,
 
 	ctx->push_pending_record = tls_sw_push_pending_record;
 
-	memcpy(keyval, gcm_128_info->key, TLS_CIPHER_AES_GCM_128_KEY_SIZE);
-
-	rc = crypto_aead_setkey(sw_ctx->aead_send, keyval,
+	rc = crypto_aead_setkey(sw_ctx->aead_send, gcm_128_info->key,
 				TLS_CIPHER_AES_GCM_128_KEY_SIZE);
 	if (rc)
 		goto free_aead;


