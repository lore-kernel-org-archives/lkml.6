Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2007D20864
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="atUt0vs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2007D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbeGKLDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:03:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732540AbeGKLDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ef0PEPWZqjZMscTRihFN2Om5ync3piPZPytjWu1Zaqg=; b=atUt0vs8CrOb
        PvCYFD460jdWqno3CHo2uNST6x3XsIRnQnQpm/wNnW1OJzuWiP/ZGQaCUE5Rk8uXGtFRWxfw6fq2w
        EaNLmG0Kpf+1mY1mMZyKysSMY2o8JBDylNSxNllLOHxJiocKPfeMDLDsPDedUu+Z782fwRSyeUszD
        Vikvo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdCq3-0002qJ-Qr; Wed, 11 Jul 2018 10:59:15 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdCq2-0007z5-D1; Wed, 11 Jul 2018 11:59:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Applied "regmap: slimbus: add support to multi read/write" to the regmap tree
In-Reply-To:  <20180706150527.8811-1-srinivas.kandagatla@linaro.org>
Message-Id: <E1fdCq2-0007z5-D1@debutante>
Date:   Wed, 11 Jul 2018 11:59:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: slimbus: add support to multi read/write

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e76ad18b56775aa20c0fb8e6203fae2aaee57e5c Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 6 Jul 2018 16:05:27 +0100
Subject: [PATCH] regmap: slimbus: add support to multi read/write

SLIMbus supports upto 16 bytes in value management messages,
so add support to read/writes upto 16 bytes.

This also removes redundant single register reg_read/reg_write.

Also useful for paged register access on SLIMbus interfaced codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-slimbus.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 91d501eda8a9..0968059f1ef5 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -7,33 +7,24 @@
 
 #include "internal.h"
 
-static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
-					unsigned int *val)
+static int regmap_slimbus_write(void *context, const void *data, size_t count)
 {
 	struct slim_device *sdev = context;
-	int v;
 
-	v = slim_readb(sdev, reg);
-
-	if (v < 0)
-		return v;
-
-	*val = v;
-
-	return 0;
+	return slim_write(sdev, *(u16 *)data, count - 2, (u8 *)data + 2);
 }
 
-static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
-					 unsigned int val)
+static int regmap_slimbus_read(void *context, const void *reg, size_t reg_size,
+			       void *val, size_t val_size)
 {
 	struct slim_device *sdev = context;
 
-	return slim_writeb(sdev, reg, val);
+	return slim_read(sdev, *(u16 *)reg, val_size, val);
 }
 
 static struct regmap_bus regmap_slimbus_bus = {
-	.reg_write = regmap_slimbus_byte_reg_write,
-	.reg_read = regmap_slimbus_byte_reg_read,
+	.write = regmap_slimbus_write,
+	.read = regmap_slimbus_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
 	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
 };
-- 
2.18.0.rc2

