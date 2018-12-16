Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8507EC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC75217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="jck7DHjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbeLPKUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:20:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38328 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeLPKUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:20:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so4761635plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 02:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9bxDl9pnkPU4UWJ81FDZxIJTWAGg4Ybv97XuisUKKM=;
        b=jck7DHjzcNzDhwE8MJ42jv6Q7BwcVI3GuAMmmaH1U+ejaxhjdeaCk9T8qGbRQRLEp2
         YNfM97odG7+A7NTO4Twhkj56tyTdW2bkhl+BuHLmA0rLX6EG4j2Eej5iQtFSmhRTVWYi
         hTHAXzxe2iR3PQhnl+JVOVUJzsL8YwK2bUol4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9bxDl9pnkPU4UWJ81FDZxIJTWAGg4Ybv97XuisUKKM=;
        b=pff3dudhbDGWL/aRmO7W/O31ns4F6s39eGvZh0k6yIglxMx6ZE30nmnuaW9XEmH5mT
         vQFifLhYMZaXNtFVyQiq7J0HY8qOUqGawx9rPYPE1mAmla8aZsPKSnxvBh+OWiFpC5W8
         69eB/0N2NhQHBA+XMtM8Lyg2c+ybT7wbAtCVtRhBi689yNYbFPKlFDKETkKT+VS82bHA
         QMo/qPYuyIQCjQQQkZsNufyHn+RSjbL0EsEaDiaJBjlaj88t3sMC3dMDsME78m6TLgug
         KeIbJsoG9Mz7kOov8dT8MSqxnFlra+qz5//9JRUZO1n9KNzeiIJYH2OWLAGtyhksJecT
         htGA==
X-Gm-Message-State: AA+aEWYtfcWJP5JbzYXqnEtANLn/whVaV3WC230PlrQ1n8Z955Ps21k9
        G3TmJGN2/maPdBu4gIowP37BHg==
X-Google-Smtp-Source: AFSGD/WcpEvIpLauXM5y80XUxrk23k4oe7i/4gH9ijoEDUTWodlx3M4IhfsEnstOWMNEjq1Lxfn9OA==
X-Received: by 2002:a17:902:bc44:: with SMTP id t4mr8289842plz.260.1544955610798;
        Sun, 16 Dec 2018 02:20:10 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id d21sm14964454pgv.37.2018.12.16.02.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 02:20:10 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH v5 4/6] net: maclorawan: Implement the crypto of maclorawan module
Date:   Sun, 16 Dec 2018 18:18:58 +0800
Message-Id: <20181216101858.9585-5-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the crypto for encryption/decryption and message integrity
code (MIC) according to LoRaWAN(TM) Specification Ver. 1.0.2.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules
- Rename the lrwsec files to crypto files
- Modify for Big/Little-Endian
- Use SPDX license identifiers

V3:
- Order local variables from longest to shortest line in the functions

V4:
- Fix by coding style report from scripts/checkpatch.pl

 net/maclorawan/crypto.c | 212 ++++++++++++++++++++++++++++++++++++++++
 net/maclorawan/crypto.h |  27 +++++
 2 files changed, 239 insertions(+)
 create mode 100644 net/maclorawan/crypto.c
 create mode 100644 net/maclorawan/crypto.h

diff --git a/net/maclorawan/crypto.c b/net/maclorawan/crypto.c
new file mode 100644
index 000000000000..0ae9d211cd14
--- /dev/null
+++ b/net/maclorawan/crypto.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#include <linux/scatterlist.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include "crypto.h"
+
+struct crypto_shash *
+lrw_mic_key_setup(u8 *k, size_t k_len)
+{
+	struct crypto_shash *tfm;
+	char *algo = "cmac(aes)";
+	int err;
+
+	tfm = crypto_alloc_shash(algo, 0, 0);
+	if (!IS_ERR(tfm)) {
+		err = crypto_shash_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_shash(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+int
+lrw_aes_cmac(struct crypto_shash *tfm, u8 *bz, u8 *data, size_t len, u8 *out)
+{
+	SHASH_DESC_ON_STACK(desc, tfm);
+	int err;
+
+	desc->tfm = tfm;
+
+	err = crypto_shash_init(desc);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, bz, 16);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, data, len);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_final(desc, out);
+
+lrw_aes_cmac_end:
+	return err;
+}
+
+int
+lrw_set_bzero(u8 dir, u32 devaddr, u32 fcnt, u8 len, u8 *bz)
+{
+	__le32 le_devaddr = cpu_to_le32(devaddr);
+	__le32 le_fcnt = cpu_to_le32(fcnt);
+
+	bz[0] = 0x49;
+	memset(bz + 1, 0x00, 4);
+	bz[5] = dir;
+	memcpy(bz + 6, &le_devaddr, 4);
+	memcpy(bz + 10, &le_fcnt, 4);
+	bz[14] = 0x00;
+	bz[15] = len;
+
+	return 0;
+}
+
+int
+lrw_calc_mic(struct crypto_shash *tfm,
+	     u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len, u8 *mic4)
+{
+	u8 mic[16];
+	u8 bz[16];
+	int err;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.4 Massege Integrity Code (MIC)
+	 */
+	lrw_set_bzero(dir, devaddr, fcnt, len, bz);
+	err = lrw_aes_cmac(tfm, bz, buf, len, mic);
+	if (!err)
+		memcpy(mic4, mic, 4);
+
+	return err;
+}
+
+void
+lrw_mic_key_free(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
+
+struct crypto_sync_skcipher *
+lrw_aes_enc_key_setup(char *algo, u8 *k, size_t k_len)
+{
+	struct crypto_sync_skcipher *tfm;
+	int err;
+
+	tfm = crypto_alloc_sync_skcipher(algo, 0, CRYPTO_ALG_ASYNC);
+	if (!IS_ERR(tfm)) {
+		err = crypto_sync_skcipher_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_sync_skcipher(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+struct crypto_sync_skcipher *
+lrw_encrypt_key_setup(u8 *k, size_t k_len)
+{
+	return lrw_aes_enc_key_setup("cbc(aes)", k, k_len);
+}
+
+int
+lrw_aes_enc(struct crypto_sync_skcipher *tfm, u8 *in, size_t len, u8 *out)
+{
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct scatterlist src, dst;
+	u8 iv[16];
+	int err;
+
+	memset(iv, 0, 16);
+	/* The buffer for sg_init_one cannot be a global or const local
+	 * (will confuse the scatterlist)
+	 */
+	sg_init_one(&src, in, len);
+	sg_init_one(&dst, out, len);
+
+	skcipher_request_set_sync_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, &src, &dst, len, iv);
+	err = crypto_skcipher_encrypt(req);
+	skcipher_request_zero(req);
+
+	return err;
+}
+
+#define	LRW_SEQUENCE_OF_BLOCK_LEN	16
+
+int
+lrw_set_sob(u8 dir, u32 devaddr, u32 fcnt, u8 index, u8 *sob)
+{
+	__le32 le_devaddr = cpu_to_le32(devaddr);
+	__le32 _fcnt = cpu_to_le32(fcnt);
+
+	sob[0] = 0x01;
+	memset(sob + 1, 0x00, 4);
+	sob[5] = dir;
+	memcpy(sob + 6, &le_devaddr, 4);
+	memcpy(sob + 10, &_fcnt, 4);
+	sob[14] = 0x00;
+	sob[15] = index;
+
+	return 0;
+}
+
+int
+lrw_encrypt_sob(struct crypto_sync_skcipher *tfm, u8 *sob)
+{
+	return lrw_aes_enc(tfm, sob, LRW_SEQUENCE_OF_BLOCK_LEN, sob);
+}
+
+int
+lrw_encrypt_buf(struct crypto_sync_skcipher *tfm,
+		u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	u8 sob[LRW_SEQUENCE_OF_BLOCK_LEN];
+	u8 i, j;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.3.3 MAC Frame Payload Encryption (FRMPayload)
+	 */
+	for (i = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN) < len; i++) {
+		lrw_set_sob(dir, devaddr, fcnt, i, sob);
+		lrw_encrypt_sob(tfm, sob);
+		for (j = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN + j) < len; j++)
+			buf[i * LRW_SEQUENCE_OF_BLOCK_LEN + j] ^= sob[j];
+	}
+
+	return 0;
+}
+
+int
+lrw_decrypt_buf(struct crypto_sync_skcipher *tfm,
+		u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	/* According to XOR swap algorithm */
+	return lrw_encrypt_buf(tfm, dir, devaddr, fcnt, buf, len);
+}
+
+void
+lrw_aes_enc_key_free(struct crypto_sync_skcipher *tfm)
+{
+	crypto_free_sync_skcipher(tfm);
+}
+
+void
+lrw_encrypt_key_free(struct crypto_sync_skcipher *tfm)
+{
+	lrw_aes_enc_key_free(tfm);
+}
diff --git a/net/maclorawan/crypto.h b/net/maclorawan/crypto.h
new file mode 100644
index 000000000000..22dd810040c0
--- /dev/null
+++ b/net/maclorawan/crypto.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#ifndef __LORAWAN_CRYPTO_H__
+#define __LORAWAN_CRYPTO_H__
+
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+
+struct crypto_shash *lrw_mic_key_setup(u8 *k, size_t k_len);
+int lrw_calc_mic(struct crypto_shash *tfm,
+		 u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len, u8 *mic4);
+void lrw_mic_key_free(struct crypto_shash *tfm);
+
+struct crypto_sync_skcipher *lrw_encrypt_key_setup(u8 *k, size_t k_len);
+int lrw_encrypt_buf(struct crypto_sync_skcipher *tfm,
+		    u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len);
+int lrw_decrypt_buf(struct crypto_sync_skcipher *tfm,
+		    u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len);
+void lrw_encrypt_key_free(struct crypto_sync_skcipher *tfm);
+
+#endif
-- 
2.20.0

