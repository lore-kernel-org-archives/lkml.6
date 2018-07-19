Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8451C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F74D20857
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDfFJvLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F74D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeGSQpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbeGSQpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:45:22 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0785220856;
        Thu, 19 Jul 2018 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532016093;
        bh=91rWWIiKHNVXXRYVfmTQWnydZhLCoSp+ZLGfP5qKiwo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CDfFJvLoky3bg8trK63nHj1OkspLzXY04nkydavAjBzXQfROsHu8Rwh+/NxsgOBHB
         QLEoC53y8xHRXc/f4845Qn7mkmhBb7rXdlQGIlrO10RVSE9cLy/wMzfEeEeWTlbPOd
         Hx2Z4g8twKUs+U5jY7TAfvNjw/MwuAWwGws5PXX4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 03/10] pinctrl: samsung: Document hidden requirement about one external wakeup
Date:   Thu, 19 Jul 2018 18:00:43 +0200
Message-Id: <20180719160050.22566-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware (S5Pv210 and all Exynos SoCs) provides only 32 external
interrupts which can wakeup device from deep sleep modes.  On S5Pv210
these are gph0-gph3.  On all Exynos designs these are gpx0-gpx3.
There is only pne 32-bit register for controlling the external wakeup
interrupt mask (masking and unmasking waking capability of these
interrupts).

This lead to implementation in pinctrl driver and machine code which was
using static memory for storing the mask value and not caring about
multiple devices of pin controller... because only one pin controller
device will be handling these.

This corresponds to hidden assumption in parsing the Device Tree.  Make
this assumption an explicit requirement.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 5e00a21de2bf..f7700c9e0d0b 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -145,8 +145,13 @@ A. External GPIO Interrupts: For supporting external gpio interrupts, the
 
 B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
    child node representing the external wakeup interrupt controller should be
-   included in the pin-controller device node. This child node should include
-   the following properties.
+   included in the pin-controller device node.
+
+   Only one pin-controller device node can include external wakeup interrupts
+   child node (in other words, only one External Wakeup Interrupts
+   pin-controller is supported).
+
+   This child node should include following properties:
 
    - compatible: identifies the type of the external wakeup interrupt controller
      The possible values are:
-- 
2.14.1

