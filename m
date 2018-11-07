Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB2BC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119322081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119322081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbeKGTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:48:53 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:45512 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbeKGTsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:48:50 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 46F395F863; Wed,  7 Nov 2018 18:13:16 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] dt-bindings: net: broadcom-bluetooth: Fix external clock names
Date:   Wed,  7 Nov 2018 18:12:54 +0800
Message-Id: <20181107101308.7626-2-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107101308.7626-1-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 4194ff7e6ee6..2535e54219af 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -18,7 +18,10 @@ Optional properties:
  - shutdown-gpios: GPIO specifier, used to enable the BT module
  - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
  - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
- - clocks: clock specifier if external clock provided to the controller
+ - clocks and clock-names: clock specifier if external clocks are provided
+   - "txco": external reference clock
+   - "extclk": deprecated, replaced by "txco"
+   - "lpo": external low power 32.768 kHz clock
  - clock-names: should be "extclk"
 
 
-- 
2.19.1

