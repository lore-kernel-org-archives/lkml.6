Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FDB2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vnyc4ofX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FDB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeLDR1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:27:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44050 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeLDR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZHtM1Jba8q8x+UthTE1J60fPktm07IlheFTf+zQFf4g=; b=vnyc4ofX5WCy
        1bFH0LBDvupN8DYO+Ni2QLxfmxDASC4IAopl4hKBDi5HKr6krsH+o7NiG7GHdDicaB7BgFJyAiRZM
        stoM/ntr06N97+pbiNdbonfQuWzz/RCoojIgYuxI/Wc65xUwtf2VuSRBOY70zvd/5uchE4fLxWrHg
        oOz2o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUETm-0007xV-AT; Tue, 04 Dec 2018 17:27:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F140111251E3; Tue,  4 Dec 2018 17:27:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Factor out location of init data OF node" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181204172725.F140111251E3@debutante.sirena.org.uk>
Date:   Tue,  4 Dec 2018 17:27:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Factor out location of init data OF node

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

From 925c85e21ed8773c8b0ab01d60618b862847a10f Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 29 Nov 2018 10:28:20 +0000
Subject: [PATCH] regulator: Factor out location of init data OF node

To support future additions factor out the location of the OF node
containing the init data for the regulator from the code that parses the
init data.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/of_regulator.c | 64 ++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c711a0a2bc4b..4bb8928bdb3f 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -371,13 +371,10 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(of_regulator_match);
 
-struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
-					    const struct regulator_desc *desc,
-					    struct regulator_config *config,
-					    struct device_node **node)
+struct device_node *regulator_of_get_init_node(struct device *dev,
+					       const struct regulator_desc *desc)
 {
 	struct device_node *search, *child;
-	struct regulator_init_data *init_data = NULL;
 	const char *name;
 
 	if (!dev->of_node || !desc->of_match)
@@ -400,35 +397,48 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 		if (!name)
 			name = child->name;
 
-		if (strcmp(desc->of_match, name))
-			continue;
+		if (!strcmp(desc->of_match, name))
+			return of_node_get(child);
+	}
 
-		init_data = of_get_regulator_init_data(dev, child, desc);
-		if (!init_data) {
-			dev_err(dev,
-				"failed to parse DT for regulator %pOFn\n",
-				child);
-			break;
-		}
+	of_node_put(search);
 
-		if (desc->of_parse_cb) {
-			if (desc->of_parse_cb(child, desc, config)) {
-				dev_err(dev,
-					"driver callback failed to parse DT for regulator %pOFn\n",
-					child);
-				init_data = NULL;
-				break;
-			}
-		}
+	return NULL;
+}
 
-		of_node_get(child);
-		*node = child;
-		break;
+struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
+					    const struct regulator_desc *desc,
+					    struct regulator_config *config,
+					    struct device_node **node)
+{
+	struct device_node *child;
+	struct regulator_init_data *init_data = NULL;
+
+	child = regulator_of_get_init_node(dev, desc);
+	if (!child)
+		return NULL;
+
+	init_data = of_get_regulator_init_data(dev, child, desc);
+	if (!init_data) {
+		dev_err(dev, "failed to parse DT for regulator %pOFn\n", child);
+		goto error;
 	}
 
-	of_node_put(search);
+	if (desc->of_parse_cb && desc->of_parse_cb(child, desc, config)) {
+		dev_err(dev,
+			"driver callback failed to parse DT for regulator %pOFn\n",
+			child);
+		goto error;
+	}
+
+	*node = child;
 
 	return init_data;
+
+error:
+	of_node_put(child);
+
+	return NULL;
 }
 
 static int of_node_match(struct device *dev, const void *data)
-- 
2.19.0.rc2

