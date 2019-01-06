Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303F2C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099172070B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfAFNg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 08:36:58 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53102 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfAFNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 08:36:54 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1386E72CC6C;
        Sun,  6 Jan 2019 16:36:52 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id D75FB4A4A14;
        Sun,  6 Jan 2019 16:36:51 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] KEYS: set correct flags for keyctl if encrypt is not supported
Date:   Sun,  6 Jan 2019 16:36:07 +0300
Message-Id: <20190106133608.820-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190106133608.820-1-vt@altlinux.org>
References: <20190106133608.820-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/asymmetric_keys/public_key.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 51dc1c858c7c..382cf67f510e 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -136,8 +136,9 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	info->max_sig_size = len;
 	info->max_enc_size = len;
 	info->max_dec_size = len;
-	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
-			       KEYCTL_SUPPORTS_VERIFY);
+	info->supported_ops = KEYCTL_SUPPORTS_VERIFY;
+	if (crypto_akcipher_alg(tfm)->encrypt)
+		info->supported_ops |= KEYCTL_SUPPORTS_ENCRYPT;
 	if (pkey->key_is_private)
 		info->supported_ops |= (KEYCTL_SUPPORTS_DECRYPT |
 					KEYCTL_SUPPORTS_SIGN);
-- 
2.11.0

