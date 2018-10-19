Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FFECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76CB214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gEJScNfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76CB214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJSUfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:35:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nYBKH8KQVvnkLlrTR3gJ3d4MtYEJLLVAMM53bDn5e6E=; b=gEJScNfRx+Gi
        uIQiRxpQvkmC3L5sS6fuImR/w5A+DxGzUaBOxHWGL25CYr2vmrQOmQH6pq/lFPdV0coD8fhYrRDO6
        yGbBH/gCbzuTq19jOqWLwbUej5dWypUDJbaON0lacSexrRpBQWaH261TLVMeypSDWjW9Z9ShZAaJ4
        OXXUo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTuC-0008WE-CS; Fri, 19 Oct 2018 12:29:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1F1C51122548; Fri, 19 Oct 2018 13:29:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: use less #ifdef for LOG_DEVICE" to the regmap tree
In-Reply-To: 
Message-Id: <20181019122928.1F1C51122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:29:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: use less #ifdef for LOG_DEVICE

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

From 950937624079f8ab78939f1effbe21df8e39d420 Mon Sep 17 00:00:00 2001
From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 2 Oct 2018 11:42:05 +0100
Subject: [PATCH] regmap: use less #ifdef for LOG_DEVICE

Move the checking of the LOG_DEVICE into a function to reduce the
number of #ifdefs and  ensure more of the code gets compiled/checked,
and make it easier to change this for internal debugging purposes
(such as checking >1 device).

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0360a90ad6b6..0d9ad7c07d51 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -35,6 +35,16 @@
  */
 #undef LOG_DEVICE
 
+#ifdef LOG_DEVICE
+static inline bool regmap_should_log(struct regmap *map)
+{
+	return (map->dev && strcmp(dev_name(map->dev), LOG_DEVICE) == 0);
+}
+#else
+static inline bool regmap_should_log(struct regmap *map) { return false; }
+#endif
+
+
 static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 			       unsigned int mask, unsigned int val,
 			       bool *change, bool force_write);
@@ -1755,10 +1765,8 @@ int _regmap_write(struct regmap *map, unsigned int reg,
 		}
 	}
 
-#ifdef LOG_DEVICE
-	if (map->dev && strcmp(dev_name(map->dev), LOG_DEVICE) == 0)
+	if (regmap_should_log(map))
 		dev_info(map->dev, "%x <= %x\n", reg, val);
-#endif
 
 	trace_regmap_reg_write(map, reg, val);
 
@@ -2450,10 +2458,8 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 
 	ret = map->reg_read(context, reg, val);
 	if (ret == 0) {
-#ifdef LOG_DEVICE
-		if (map->dev && strcmp(dev_name(map->dev), LOG_DEVICE) == 0)
+		if (regmap_should_log(map))
 			dev_info(map->dev, "%x => %x\n", reg, *val);
-#endif
 
 		trace_regmap_reg_read(map, reg, *val);
 
-- 
2.19.0.rc2

