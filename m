Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4922C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeLQEGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:06:44 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:53072 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeLQEFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:05:09 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 3F3825FADF; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
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
Subject: [PATCH v3 01/15] dt-bindings: net: broadcom-bluetooth: Fix external clock names
Date:   Mon, 17 Dec 2018 12:04:35 +0800
Message-Id: <20181217040449.31437-2-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom Bluetooth controllers can take up to two external clocks:
an external frequency reference, substituting the main crystal, and a
LPO clock at 32.768 kHz substituting the internal LPO clock.

In particular, the external LPO clock must be used when the controller
does not have NVRAM connected, and the main reference frequency is not
the default 20 MHz. This is described in detail in the datasheet.

The original "extclk" clock name is ambiguous as to which of these it
refers to, and some designs might even require both.

This patch deprecates the existing name, and adds "txco" and "lpo".

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 4194ff7e6ee6..711c75ac2bb5 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -18,8 +18,11 @@ Optional properties:
  - shutdown-gpios: GPIO specifier, used to enable the BT module
  - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
  - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
- - clocks: clock specifier if external clock provided to the controller
- - clock-names: should be "extclk"
+ - clocks: 1 or 2 clocks as defined in clock-names below, in that order
+ - clock-names: names for clock inputs, matching the clocks given
+   - "extclk": deprecated, replaced by "txco"
+   - "txco": external reference clock (not a standalone crystal)
+   - "lpo": external low power 32.768 kHz clock
 
 
 Example:
-- 
2.20.0

