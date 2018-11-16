Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1537F20818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1537F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbeKPRt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:49:59 -0500
Received: from ms.tdt.de ([195.243.126.94]:36875 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727380AbeKPRt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:49:59 -0500
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 0C910218E8;
        Fri, 16 Nov 2018 07:38:44 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     andrew@lunn.ch, sergei.shtylyov@cogentembedded.com,
        f.fainelli@gmail.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH v6] net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs
Date:   Fri, 16 Nov 2018 08:38:36 +0100
Message-Id: <20181116073836.6013-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181114061703.11026-1-ms@dev.tdt.de>
References: <20181114061703.11026-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until commit 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod
functions where possible"), the _cansleep variants of the gpio_ API was
used. After that commit and the change to gpiod_ API, the _cansleep()
was dropped. This then results in WARN_ON() when used with GPIO
devices which do sleep. Add back the _cansleep() to avoid this.

Fixes: 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod functions where possible")
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
v6:
 - dropped warning about slow GPIO pins
 
v5:
 - reworked commit message
 - added "Fixes:" tag
 - based on DaveM net tree instead of mainline
 
v4:
 - remove linewrap of kernel message
 
v3:
 - modified commit summary
 - fixed commit cites in commit message
 - fixed line continuation
 
v2:
 - fixed copy/paste bug in warning about slow GPIO pins
---
 drivers/net/phy/mdio-gpio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-gpio.c b/drivers/net/phy/mdio-gpio.c
index 33265747bf39..0fbcedcdf6e2 100644
--- a/drivers/net/phy/mdio-gpio.c
+++ b/drivers/net/phy/mdio-gpio.c
@@ -63,7 +63,7 @@ static void mdio_dir(struct mdiobb_ctrl *ctrl, int dir)
 		 * assume the pin serves as pull-up. If direction is
 		 * output, the default value is high.
 		 */
-		gpiod_set_value(bitbang->mdo, 1);
+		gpiod_set_value_cansleep(bitbang->mdo, 1);
 		return;
 	}
 
@@ -78,7 +78,7 @@ static int mdio_get(struct mdiobb_ctrl *ctrl)
 	struct mdio_gpio_info *bitbang =
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
-	return gpiod_get_value(bitbang->mdio);
+	return gpiod_get_value_cansleep(bitbang->mdio);
 }
 
 static void mdio_set(struct mdiobb_ctrl *ctrl, int what)
@@ -87,9 +87,9 @@ static void mdio_set(struct mdiobb_ctrl *ctrl, int what)
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
 	if (bitbang->mdo)
-		gpiod_set_value(bitbang->mdo, what);
+		gpiod_set_value_cansleep(bitbang->mdo, what);
 	else
-		gpiod_set_value(bitbang->mdio, what);
+		gpiod_set_value_cansleep(bitbang->mdio, what);
 }
 
 static void mdc_set(struct mdiobb_ctrl *ctrl, int what)
@@ -97,7 +97,7 @@ static void mdc_set(struct mdiobb_ctrl *ctrl, int what)
 	struct mdio_gpio_info *bitbang =
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
-	gpiod_set_value(bitbang->mdc, what);
+	gpiod_set_value_cansleep(bitbang->mdc, what);
 }
 
 static const struct mdiobb_ops mdio_gpio_ops = {
-- 
2.11.0

