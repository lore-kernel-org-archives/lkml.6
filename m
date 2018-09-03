Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EA2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E45C20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E45C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeICVxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:53:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47508 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbeICVxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:34 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A9DFD1B;
        Mon,  3 Sep 2018 17:32:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Reichl <hias@horus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.18 023/123] regulator: arizona-ldo1: Use correct device to get enable GPIO
Date:   Mon,  3 Sep 2018 18:56:07 +0200
Message-Id: <20180903165720.479439043@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit a9191579ba1086d91842199263e6fe6bb5eec1ba upstream.

Currently the enable GPIO is being looked up on the regulator
device itself but that does not have its own DT node, this causes
the lookup to fail and the regulator not to get its GPIO. The DT
node is shared across the whole MFD and as such the lookup needs
to happen on that parent device. Moving the lookup to the parent
device also means devres can no longer be used as the life time
would attach to the wrong device.

Additionally, the enable GPIO is active high so we should be passing
GPIOD_OUT_LOW to ensure the regulator starts in its off state allowing
the driver to enable it when it is ready.

Fixes: e1739e86f0cb ("regulator: arizona-ldo1: Look up a descriptor and pass to the core")
Reported-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Matthias Reichl <hias@horus.com>

---
 drivers/regulator/arizona-ldo1.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -36,6 +36,8 @@ struct arizona_ldo1 {
 
 	struct regulator_consumer_supply supply;
 	struct regulator_init_data init_data;
+
+	struct gpio_desc *ena_gpiod;
 };
 
 static int arizona_ldo1_hc_list_voltage(struct regulator_dev *rdev,
@@ -253,12 +255,17 @@ static int arizona_ldo1_common_init(stru
 		}
 	}
 
-	/* We assume that high output = regulator off */
-	config.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "wlf,ldoena",
-						   GPIOD_OUT_HIGH);
+	/* We assume that high output = regulator off
+	 * Don't use devm, since we need to get against the parent device
+	 * so clean up would happen at the wrong time
+	 */
+	config.ena_gpiod = gpiod_get_optional(parent_dev, "wlf,ldoena",
+					      GPIOD_OUT_LOW);
 	if (IS_ERR(config.ena_gpiod))
 		return PTR_ERR(config.ena_gpiod);
 
+	ldo1->ena_gpiod = config.ena_gpiod;
+
 	if (pdata->init_data)
 		config.init_data = pdata->init_data;
 	else
@@ -276,6 +283,9 @@ static int arizona_ldo1_common_init(stru
 	of_node_put(config.of_node);
 
 	if (IS_ERR(ldo1->regulator)) {
+		if (config.ena_gpiod)
+			gpiod_put(config.ena_gpiod);
+
 		ret = PTR_ERR(ldo1->regulator);
 		dev_err(&pdev->dev, "Failed to register LDO1 supply: %d\n",
 			ret);
@@ -334,8 +344,19 @@ static int arizona_ldo1_probe(struct pla
 	return ret;
 }
 
+static int arizona_ldo1_remove(struct platform_device *pdev)
+{
+	struct arizona_ldo1 *ldo1 = platform_get_drvdata(pdev);
+
+	if (ldo1->ena_gpiod)
+		gpiod_put(ldo1->ena_gpiod);
+
+	return 0;
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
+	.remove = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "arizona-ldo1",
 	},


