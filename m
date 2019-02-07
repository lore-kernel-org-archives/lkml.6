Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA389C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0C52175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBGGpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:45:47 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34038 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfBGGpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:45:44 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id A6C875FD5E; Thu,  7 Feb 2019 14:45:39 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RFT PATCH 3/9] power: supply: axp20x_usb_power: allow disabling input current limiting
Date:   Thu,  7 Feb 2019 14:45:29 +0800
Message-Id: <20190207064535.9226-4-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207064535.9226-1-wens@csie.org>
References: <20190207064535.9226-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP PMICs allow the user to disable current limiting on the VBUS
input. While read-out of this setting was already supported by the
driver, it did not allow the user to configure the PMIC to disable
current limiting.

Add support for this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index cd9b90d79839..e2f353906bb1 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -230,6 +230,11 @@ static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 		return regmap_update_bits(power->regmap,
 					  AXP20X_VBUS_IPSOUT_MGMT,
 					  AXP20X_VBUS_CLIMIT_MASK, val);
+	case -1:
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK,
+					  AXP20X_VBUS_CLIMIT_NONE);
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1

