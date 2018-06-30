Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59010C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8BA24478
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8BA24478
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030381AbeF3LbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 07:31:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936139AbeF3La6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 07:30:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZE5a-0002b8-1X; Sat, 30 Jun 2018 11:30:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jan Glauber <jglauber@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: zip: make several functions static
Date:   Sat, 30 Jun 2018 12:30:49 +0100
Message-Id: <20180630113049.4402-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The functions zip_ctx_exit, zip_compress, zip_decompress and zip_ctx_init
are local to the source and do not need to be in global scope, so make
them static.

Cleans up sparse warnings:
symbol 'zip_ctx_exit' was not declared. Should it be static?
symbol 'zip_compress' was not declared. Should it be static?
symbol 'zip_decompress' was not declared. Should it be static?
symbol 'zip_ctx_init' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/cavium/zip/zip_crypto.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/cavium/zip/zip_crypto.c b/drivers/crypto/cavium/zip/zip_crypto.c
index b92b6e7e100f..f9e99a15d2a0 100644
--- a/drivers/crypto/cavium/zip/zip_crypto.c
+++ b/drivers/crypto/cavium/zip/zip_crypto.c
@@ -69,7 +69,7 @@ static void zip_static_init_zip_ops(struct zip_operation *zip_ops,
 	zip_ops->csum	      = 1; /* Adler checksum desired */
 }
 
-int zip_ctx_init(struct zip_kernel_ctx *zip_ctx, int lzs_flag)
+static int zip_ctx_init(struct zip_kernel_ctx *zip_ctx, int lzs_flag)
 {
 	struct zip_operation  *comp_ctx   = &zip_ctx->zip_comp;
 	struct zip_operation  *decomp_ctx = &zip_ctx->zip_decomp;
@@ -107,7 +107,7 @@ int zip_ctx_init(struct zip_kernel_ctx *zip_ctx, int lzs_flag)
 	return -ENOMEM;
 }
 
-void zip_ctx_exit(struct zip_kernel_ctx *zip_ctx)
+static void zip_ctx_exit(struct zip_kernel_ctx *zip_ctx)
 {
 	struct zip_operation  *comp_ctx   = &zip_ctx->zip_comp;
 	struct zip_operation  *dec_ctx = &zip_ctx->zip_decomp;
@@ -119,9 +119,9 @@ void zip_ctx_exit(struct zip_kernel_ctx *zip_ctx)
 	zip_data_buf_free(dec_ctx->output, MAX_OUTPUT_BUFFER_SIZE);
 }
 
-int zip_compress(const u8 *src, unsigned int slen,
-		 u8 *dst, unsigned int *dlen,
-		 struct zip_kernel_ctx *zip_ctx)
+static int zip_compress(const u8 *src, unsigned int slen,
+			u8 *dst, unsigned int *dlen,
+			struct zip_kernel_ctx *zip_ctx)
 {
 	struct zip_operation  *zip_ops   = NULL;
 	struct zip_state      *zip_state;
@@ -155,9 +155,9 @@ int zip_compress(const u8 *src, unsigned int slen,
 	return ret;
 }
 
-int zip_decompress(const u8 *src, unsigned int slen,
-		   u8 *dst, unsigned int *dlen,
-		   struct zip_kernel_ctx *zip_ctx)
+static int zip_decompress(const u8 *src, unsigned int slen,
+			  u8 *dst, unsigned int *dlen,
+			  struct zip_kernel_ctx *zip_ctx)
 {
 	struct zip_operation  *zip_ops   = NULL;
 	struct zip_state      *zip_state;
-- 
2.17.1

