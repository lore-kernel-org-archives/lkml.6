Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5B662C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0836820864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3uXFc9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0836820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936360AbeFNOxX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964808AbeFNOGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FC70208CB;
        Thu, 14 Jun 2018 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985196;
        bh=Vuv3Z8NkMiV0DZaGSFB2REUmBNg47CNIl/OCMqS0TQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3uXFc9Mx4qWzz4O/vDP90zZyBA6ryjox1tARilKgRILzqDdxx9g34xM9R1Ug2ffy
         u7Jug4MaMAOPU8xLqTtJi5pQ9J1ASsQrz/NJL2VkIP69GispqgCOqYe9PAfIcvv5jW
         X7XdEmhK9YV+bOZ8WrnKO8iG/cdfve8H9n56BO4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.17 33/45] crypto: ccree - correct host regs offset
Date:   Thu, 14 Jun 2018 16:04:24 +0200
Message-Id: <20180614132128.631396532@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 281a58c8326ca62ca6341f9d2cc2eb08044670e8 upstream.

The product signature and HW revision register have different offset on the
older HW revisions.
This fixes the problem of the driver failing sanity check on silicon
despite working on the FPGA emulation systems.

Fixes: 27b3b22dd98c ("crypto: ccree - add support for older HW revs")
Cc: stable@vger.kernel.org
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_debugfs.c   |    7 +++++--
 drivers/crypto/ccree/cc_driver.c    |    8 ++++++--
 drivers/crypto/ccree/cc_driver.h    |    2 ++
 drivers/crypto/ccree/cc_host_regs.h |    6 ++++--
 4 files changed, 17 insertions(+), 6 deletions(-)

--- a/drivers/crypto/ccree/cc_debugfs.c
+++ b/drivers/crypto/ccree/cc_debugfs.c
@@ -26,7 +26,8 @@ struct cc_debugfs_ctx {
 static struct dentry *cc_debugfs_dir;
 
 static struct debugfs_reg32 debug_regs[] = {
-	CC_DEBUG_REG(HOST_SIGNATURE),
+	{ .name = "SIGNATURE" }, /* Must be 0th */
+	{ .name = "VERSION" }, /* Must be 1st */
 	CC_DEBUG_REG(HOST_IRR),
 	CC_DEBUG_REG(HOST_POWER_DOWN_EN),
 	CC_DEBUG_REG(AXIM_MON_ERR),
@@ -34,7 +35,6 @@ static struct debugfs_reg32 debug_regs[]
 	CC_DEBUG_REG(HOST_IMR),
 	CC_DEBUG_REG(AXIM_CFG),
 	CC_DEBUG_REG(AXIM_CACHE_PARAMS),
-	CC_DEBUG_REG(HOST_VERSION),
 	CC_DEBUG_REG(GPR_HOST),
 	CC_DEBUG_REG(AXIM_MON_COMP),
 };
@@ -58,6 +58,9 @@ int cc_debugfs_init(struct cc_drvdata *d
 	struct debugfs_regset32 *regset;
 	struct dentry *file;
 
+	debug_regs[0].offset = drvdata->sig_offset;
+	debug_regs[1].offset = drvdata->ver_offset;
+
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -207,9 +207,13 @@ static int init_cc_resources(struct plat
 	if (hw_rev->rev >= CC_HW_REV_712) {
 		new_drvdata->hash_len_sz = HASH_LEN_SIZE_712;
 		new_drvdata->axim_mon_offset = CC_REG(AXIM_MON_COMP);
+		new_drvdata->sig_offset = CC_REG(HOST_SIGNATURE_712);
+		new_drvdata->ver_offset = CC_REG(HOST_VERSION_712);
 	} else {
 		new_drvdata->hash_len_sz = HASH_LEN_SIZE_630;
 		new_drvdata->axim_mon_offset = CC_REG(AXIM_MON_COMP8);
+		new_drvdata->sig_offset = CC_REG(HOST_SIGNATURE_630);
+		new_drvdata->ver_offset = CC_REG(HOST_VERSION_630);
 	}
 
 	platform_set_drvdata(plat_dev, new_drvdata);
@@ -276,7 +280,7 @@ static int init_cc_resources(struct plat
 	}
 
 	/* Verify correct mapping */
-	signature_val = cc_ioread(new_drvdata, CC_REG(HOST_SIGNATURE));
+	signature_val = cc_ioread(new_drvdata, new_drvdata->sig_offset);
 	if (signature_val != hw_rev->sig) {
 		dev_err(dev, "Invalid CC signature: SIGNATURE=0x%08X != expected=0x%08X\n",
 			signature_val, hw_rev->sig);
@@ -287,7 +291,7 @@ static int init_cc_resources(struct plat
 
 	/* Display HW versions */
 	dev_info(dev, "ARM CryptoCell %s Driver: HW version 0x%08X, Driver version %s\n",
-		 hw_rev->name, cc_ioread(new_drvdata, CC_REG(HOST_VERSION)),
+		 hw_rev->name, cc_ioread(new_drvdata, new_drvdata->ver_offset),
 		 DRV_MODULE_VERSION);
 
 	rc = init_cc_regs(new_drvdata, true);
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -129,6 +129,8 @@ struct cc_drvdata {
 	enum cc_hw_rev hw_rev;
 	u32 hash_len_sz;
 	u32 axim_mon_offset;
+	u32 sig_offset;
+	u32 ver_offset;
 };
 
 struct cc_crypto_alg {
--- a/drivers/crypto/ccree/cc_host_regs.h
+++ b/drivers/crypto/ccree/cc_host_regs.h
@@ -45,7 +45,8 @@
 #define CC_HOST_ICR_DSCRPTR_WATERMARK_QUEUE0_CLEAR_BIT_SIZE	0x1UL
 #define CC_HOST_ICR_AXIM_COMP_INT_CLEAR_BIT_SHIFT	0x17UL
 #define CC_HOST_ICR_AXIM_COMP_INT_CLEAR_BIT_SIZE	0x1UL
-#define CC_HOST_SIGNATURE_REG_OFFSET	0xA24UL
+#define CC_HOST_SIGNATURE_712_REG_OFFSET	0xA24UL
+#define CC_HOST_SIGNATURE_630_REG_OFFSET	0xAC8UL
 #define CC_HOST_SIGNATURE_VALUE_BIT_SHIFT	0x0UL
 #define CC_HOST_SIGNATURE_VALUE_BIT_SIZE	0x20UL
 #define CC_HOST_BOOT_REG_OFFSET	0xA28UL
@@ -105,7 +106,8 @@
 #define CC_HOST_BOOT_ONLY_ENCRYPT_LOCAL_BIT_SIZE	0x1UL
 #define CC_HOST_BOOT_AES_EXISTS_LOCAL_BIT_SHIFT	0x1EUL
 #define CC_HOST_BOOT_AES_EXISTS_LOCAL_BIT_SIZE	0x1UL
-#define CC_HOST_VERSION_REG_OFFSET	0xA40UL
+#define CC_HOST_VERSION_712_REG_OFFSET	0xA40UL
+#define CC_HOST_VERSION_630_REG_OFFSET	0xAD8UL
 #define CC_HOST_VERSION_VALUE_BIT_SHIFT	0x0UL
 #define CC_HOST_VERSION_VALUE_BIT_SIZE	0x20UL
 #define CC_HOST_KFDE0_VALID_REG_OFFSET	0xA60UL


