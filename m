Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 99283C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5EB208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk82AmSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5EB208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965699AbeFNOK4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965656AbeFNOKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:10:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D32208DD;
        Thu, 14 Jun 2018 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985452;
        bh=ozNL30cG2ItOnnBub2SbcDzwUa1y+uqG6jOrv7x0WHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hk82AmSWs6K/RfrOenJoeZhOXh849ljJ+loHYhuFnVx2DVasanUKREWyzD2aaGqzl
         B7dCS9a+js1FetCBslc1KuZe4eh+RbsCq24oIm1vrT0ZAAn3kEMesS89f9Ne6UvmHg
         Po7yv7aqKIdDPC2rPRgVQ1LiP8BOJcGA61effEoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Glauber <jglauber@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 32/36] crypto: cavium - Fix fallout from CONFIG_VMAP_STACK
Date:   Thu, 14 Jun 2018 16:04:55 +0200
Message-Id: <20180614132158.714204464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Glauber <jglauber@cavium.com>

commit 37ff02acaa3d7be87ecb89f198a549ffd3ae2403 upstream.

Enabling virtual mapped kernel stacks breaks the thunderx_zip
driver. On compression or decompression the executing CPU hangs
in an endless loop. The reason for this is the usage of __pa
by the driver which does no longer work for an address that is
not part of the 1:1 mapping.

The zip driver allocates a result struct on the stack and needs
to tell the hardware the physical address within this struct
that is used to signal the completion of the request.

As the hardware gets the wrong address after the broken __pa
conversion it writes to an arbitrary address. The zip driver then
waits forever for the completion byte to contain a non-zero value.

Allocating the result struct from 1:1 mapped memory resolves this
bug.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Reviewed-by: Robert Richter <rrichter@cavium.com>
Cc: stable <stable@vger.kernel.org> # 4.14
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/cavium/zip/zip_crypto.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/crypto/cavium/zip/zip_crypto.c
+++ b/drivers/crypto/cavium/zip/zip_crypto.c
@@ -124,7 +124,7 @@ int zip_compress(const u8 *src, unsigned
 		 struct zip_kernel_ctx *zip_ctx)
 {
 	struct zip_operation  *zip_ops   = NULL;
-	struct zip_state      zip_state;
+	struct zip_state      *zip_state;
 	struct zip_device     *zip = NULL;
 	int ret;
 
@@ -135,20 +135,23 @@ int zip_compress(const u8 *src, unsigned
 	if (!zip)
 		return -ENODEV;
 
-	memset(&zip_state, 0, sizeof(struct zip_state));
+	zip_state = kzalloc(sizeof(*zip_state), GFP_ATOMIC);
+	if (!zip_state)
+		return -ENOMEM;
+
 	zip_ops = &zip_ctx->zip_comp;
 
 	zip_ops->input_len  = slen;
 	zip_ops->output_len = *dlen;
 	memcpy(zip_ops->input, src, slen);
 
-	ret = zip_deflate(zip_ops, &zip_state, zip);
+	ret = zip_deflate(zip_ops, zip_state, zip);
 
 	if (!ret) {
 		*dlen = zip_ops->output_len;
 		memcpy(dst, zip_ops->output, *dlen);
 	}
-
+	kfree(zip_state);
 	return ret;
 }
 
@@ -157,7 +160,7 @@ int zip_decompress(const u8 *src, unsign
 		   struct zip_kernel_ctx *zip_ctx)
 {
 	struct zip_operation  *zip_ops   = NULL;
-	struct zip_state      zip_state;
+	struct zip_state      *zip_state;
 	struct zip_device     *zip = NULL;
 	int ret;
 
@@ -168,7 +171,10 @@ int zip_decompress(const u8 *src, unsign
 	if (!zip)
 		return -ENODEV;
 
-	memset(&zip_state, 0, sizeof(struct zip_state));
+	zip_state = kzalloc(sizeof(*zip_state), GFP_ATOMIC);
+	if (!zip_state)
+		return -ENOMEM;
+
 	zip_ops = &zip_ctx->zip_decomp;
 	memcpy(zip_ops->input, src, slen);
 
@@ -179,13 +185,13 @@ int zip_decompress(const u8 *src, unsign
 	zip_ops->input_len  = slen;
 	zip_ops->output_len = *dlen;
 
-	ret = zip_inflate(zip_ops, &zip_state, zip);
+	ret = zip_inflate(zip_ops, zip_state, zip);
 
 	if (!ret) {
 		*dlen = zip_ops->output_len;
 		memcpy(dst, zip_ops->output, *dlen);
 	}
-
+	kfree(zip_state);
 	return ret;
 }
 


