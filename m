Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C4ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2EC20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="s2lK36Id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2EC20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKIByu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:54:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45864 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeKIByu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lp8rYOSmREf3JJYK+1R8iTBwioWETEU+TxDlqYf4hPE=; b=s2lK36IdT1cZ
        OQHzGbO+8XnTg5qVVb5OnGVLRYu/Ah6tMeepukCEQlRlajRS62kq17if69E5G6XW8jFLcrY0exvpM
        Lc/8nXdOMNNQEbNDUnS5hoGXxoOdNFl23oKt8tfhUD0gpazQbY3pJrFxXUyuP7CYDnqS2xuKPL2R6
        CQNQA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKn0u-0000Bz-93; Thu, 08 Nov 2018 16:18:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0744C1124D9E; Thu,  8 Nov 2018 16:18:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Decouple regulators on regulator_unregister()" to the regulator tree
In-Reply-To: 
Message-Id: <20181108161836.0744C1124D9E@debutante.sirena.org.uk>
Date:   Thu,  8 Nov 2018 16:18:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Decouple regulators on regulator_unregister()

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 7b450009d89298e423c1478524519dc0dec5242a Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 5 Oct 2018 18:36:36 +0300
Subject: [PATCH] regulator: core: Decouple regulators on
 regulator_unregister()

Regulators shall be uncoupled if one of the couples disappear.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ba03bdf3716f..783ec9c74104 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4518,6 +4518,43 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 	}
 }
 
+static void regulator_remove_coupling(struct regulator_dev *rdev)
+{
+	struct coupling_desc *__c_desc, *c_desc = &rdev->coupling_desc;
+	struct regulator_dev *__c_rdev, *c_rdev;
+	unsigned int __n_coupled, n_coupled;
+	int i, k;
+
+	n_coupled = c_desc->n_coupled;
+
+	for (i = 1; i < n_coupled; i++) {
+		c_rdev = c_desc->coupled_rdevs[i];
+
+		if (!c_rdev)
+			continue;
+
+		regulator_lock(c_rdev);
+
+		__c_desc = &c_rdev->coupling_desc;
+		__n_coupled = __c_desc->n_coupled;
+
+		for (k = 1; k < __n_coupled; k++) {
+			__c_rdev = __c_desc->coupled_rdevs[k];
+
+			if (__c_rdev == rdev) {
+				__c_desc->coupled_rdevs[k] = NULL;
+				__c_desc->n_resolved--;
+				break;
+			}
+		}
+
+		regulator_unlock(c_rdev);
+
+		c_desc->coupled_rdevs[i] = NULL;
+		c_desc->n_resolved--;
+	}
+}
+
 static int regulator_init_coupling(struct regulator_dev *rdev)
 {
 	int n_phandles;
@@ -4776,6 +4813,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 	debugfs_remove_recursive(rdev->debugfs);
 	flush_work(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
+	regulator_remove_coupling(rdev);
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
 	regulator_ena_gpio_free(rdev);
-- 
2.19.0.rc2

