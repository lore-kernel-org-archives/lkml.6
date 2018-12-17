Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6DC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB39217FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeLQEFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:05:13 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:53260 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731377AbeLQEFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:05:12 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 8670C5FDB8; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH v3 10/15] Bluetooth: hci_bcm: Wait for device to come out of reset after power on
Date:   Mon, 17 Dec 2018 12:04:44 +0800
Message-Id: <20181217040449.31437-11-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheets for BCM20702 and BCM43438 both have power up time
sequence graphs, however they are slightly different. Both chips
also have an internal power-on-reset, which holds the chip in reset
for a short time after the regulators are enabled.

For the BCM20702, the time period from when the regulators are enabled,
until the chip settles and comes out of sleep state, is 6564 ~ 8171 us.

For the BCM43438, the graph only shows the time period from when the
regulators are enabled until the chip responds by driving the host's
CTS line low, assuming the host has already driven its RTS line low.
This is shown to be 6.5 sleep cycles, with the sleep clock at 32.768
kHz. This is around 2 ms.

Wait a full 10 ms after the regulators are enabled to account for signal
rising times.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f2101038284e..538ce8059bff 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -256,6 +256,9 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 		regulator_bulk_disable(BCM_NUM_SUPPLIES, dev->supplies);
 	}
 
+	/* wait for device to power on and come out of reset */
+	usleep_range(10000, 20000);
+
 	dev->res_enabled = powered;
 
 	return 0;
-- 
2.20.0

