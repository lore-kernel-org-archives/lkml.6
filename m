Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56791C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2709E20660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfAJN6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:58:33 -0500
Received: from inva021.nxp.com ([92.121.34.21]:59258 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfAJN6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:58:33 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68E1D2000AC;
        Thu, 10 Jan 2019 14:58:30 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C5672001C5;
        Thu, 10 Jan 2019 14:58:30 +0100 (CET)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net [10.171.81.110])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 092C2205F8;
        Thu, 10 Jan 2019 14:58:30 +0100 (CET)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND] crypto: caam - move shared symbols in a common location
Date:   Thu, 10 Jan 2019 15:58:12 +0200
Message-Id: <20190110135812.12457-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several issues with symbols shared b/w:
-caam/jr and caam/qi drivers on one hand
-caam/qi2 driver on the other hand

Commit 52813ab24959 ("crypto: caam/qi2 - avoid double export") fixed
some of them, however compilation still fails for CRYPTO_DEV_FSL_CAAM=m
and CRYPTO_DEV_FSL_DPAA2_CAAM=y.

Another issue is related to dependency cycles reported by depmod when
CRYPTO_DEV_FSL_CAAM=n and CRYPTO_DEV_FSL_DPAA2_CAAM=m, as mentioned in
82c7b351be3f ("Revert "arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO"")

To fix all these, move the symbols shared by these drivers in a common
location. The only existing possibility is error.c file (note that naming
doesn't help and should probably change).

Fixes: 52813ab24959 ("crypto: caam/qi2 - avoid double export")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---

Resending to fix patchwork tracking.
Initial submission done inline here:
https://patchwork.kernel.org/patch/10739071/

 drivers/crypto/caam/caamalg_qi2.c | 7 -------
 drivers/crypto/caam/ctrl.c        | 4 ----
 drivers/crypto/caam/error.c       | 6 ++++++
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 425d5d974613..cc59814afd29 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -25,13 +25,6 @@
 #define CAAM_MAX_KEY_SIZE	(AES_MAX_KEY_SIZE + CTR_RFC3686_NONCE_SIZE + \
 				 SHA512_DIGEST_SIZE * 2)
 
-#if !IS_ENABLED(CONFIG_CRYPTO_DEV_FSL_CAAM)
-bool caam_little_end;
-EXPORT_SYMBOL(caam_little_end);
-bool caam_imx;
-EXPORT_SYMBOL(caam_imx);
-#endif
-
 /*
  * This is a a cache of buffers, from which the users of CAAM QI driver
  * can allocate short buffers. It's speedier than doing kmalloc on the hotpath.
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 16bbc72f041a..14fb09223156 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -18,12 +18,8 @@
 #include "desc_constr.h"
 #include "ctrl.h"
 
-bool caam_little_end;
-EXPORT_SYMBOL(caam_little_end);
 bool caam_dpaa2;
 EXPORT_SYMBOL(caam_dpaa2);
-bool caam_imx;
-EXPORT_SYMBOL(caam_imx);
 
 #ifdef CONFIG_CAAM_QI
 #include "qi.h"
diff --git a/drivers/crypto/caam/error.c b/drivers/crypto/caam/error.c
index 7e8d690f2827..21a70fd32f5d 100644
--- a/drivers/crypto/caam/error.c
+++ b/drivers/crypto/caam/error.c
@@ -50,6 +50,12 @@ void caam_dump_sg(const char *level, const char *prefix_str, int prefix_type,
 #endif /* DEBUG */
 EXPORT_SYMBOL(caam_dump_sg);
 
+bool caam_little_end;
+EXPORT_SYMBOL(caam_little_end);
+
+bool caam_imx;
+EXPORT_SYMBOL(caam_imx);
+
 static const struct {
 	u8 value;
 	const char *error_text;
-- 
2.16.2

