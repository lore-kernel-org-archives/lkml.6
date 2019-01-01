Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E92BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD9218D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546351694;
	bh=I5zPdeLbsHFSSIDgfb0GymjFlkl7W3afotp2h60tVFI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cj6pXkgLbBGdMDvP3SO0sh7k6BioLT1sdpiJtI2+LedDTxpOh/koElfriH5rsYeN
	 3zt0QGrTl5njwlKpzFY5FfCs0bMa//ys1Zdtj2Q6teOhlvADmKKtD9T+glVtEm8Wm2
	 TJxvjNUlSHmrI/slFXohLPv/ry8kLxG5Zidy+04M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfAAOIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfAAOIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:08:12 -0500
Received: from localhost.localdomain (unknown [194.230.155.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3212D218AE;
        Tue,  1 Jan 2019 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546351691;
        bh=I5zPdeLbsHFSSIDgfb0GymjFlkl7W3afotp2h60tVFI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=trqCzni5Ik+UucUzOkWXwDtn0F7szzxSp6FGsVABrc1QFxxweTVkU65dsUbTYkixk
         8dZwiiaS68t/gJfnivNsmEmp2TIRHFeZbuMiPt7URmkGkwzJ0d62/nBsn90BPtLZ1x
         fMwobi32MYwnyq2Lqep2VP6+qhHJYknY3s0HekUc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: leds: Add pattern initialization from Device Tree
Date:   Tue,  1 Jan 2019 15:07:13 +0100
Message-Id: <20190101140717.13564-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101140717.13564-1-krzk@kernel.org>
References: <20190101140717.13564-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new led-pattern property for initialization of LED triggers.
The property format is trigger-specific (except being array of
integers).  For pattern trigger, the explanation of pattern format was
moved to a common file shared with sysfs ABI.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../testing/sysfs-class-led-trigger-pattern   | 51 ++-----------------
 .../devicetree/bindings/leds/common.txt       | 12 +++++
 .../bindings/leds/leds-trigger-pattern.txt    | 49 ++++++++++++++++++
 3 files changed, 64 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
index 1e5d172e0646..bd92ef9d6faa 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -7,55 +7,10 @@ Description:
 		timer. It can do gradual dimming and step change of brightness.
 
 		The pattern is given by a series of tuples, of brightness and
-		duration (ms). The LED is expected to traverse the series and
-		each brightness value for the specified duration. Duration of
-		0 means brightness should immediately change to new value, and
-		writing malformed pattern deactivates any active one.
+		duration (ms).
 
-		1. For gradual dimming, the dimming interval now is set as 50
-		milliseconds. So the tuple with duration less than dimming
-		interval (50ms) is treated as a step change of brightness,
-		i.e. the subsequent brightness will be applied without adding
-		intervening dimming intervals.
-
-		The gradual dimming format of the software pattern values should be:
-		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
-		duration_3 ...". For example:
-
-		echo 0 1000 255 2000 > pattern
-
-		It will make the LED go gradually from zero-intensity to max (255)
-		intensity in 1000 milliseconds, then back to zero intensity in 2000
-		milliseconds:
-
-		LED brightness
-		    ^
-		255-|       / \            / \            /
-		    |      /    \         /    \         /
-		    |     /       \      /       \      /
-		    |    /          \   /          \   /
-		  0-|   /             \/             \/
-		    +---0----1----2----3----4----5----6------------> time (s)
-
-		2. To make the LED go instantly from one brightness value to another,
-		we should use zero-time lengths (the brightness must be same as
-		the previous tuple's). So the format should be:
-		"brightness_1 duration_1 brightness_1 0 brightness_2 duration_2
-		brightness_2 0 ...". For example:
-
-		echo 0 1000 0 0 255 2000 255 0 > pattern
-
-		It will make the LED stay off for one second, then stay at max brightness
-		for two seconds:
-
-		LED brightness
-		    ^
-		255-|        +---------+    +---------+
-		    |        |         |    |         |
-		    |        |         |    |         |
-		    |        |         |    |         |
-		  0-|   -----+         +----+         +----
-		    +---0----1----2----3----4----5----6------------> time (s)
+		The exact format is described in:
+		Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
 
 What:		/sys/class/leds/<led>/hw_pattern
 Date:		September 2018
diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index aa1399814a2a..70876ac11367 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -37,6 +37,18 @@ Optional properties for child nodes:
      "ide-disk" - LED indicates IDE disk activity (deprecated),
                   in new implementations use "disk-activity"
      "timer" - LED flashes at a fixed, configurable rate
+     "pattern" - LED alters the brightness for the specified duration with one
+                 software timer (requires "led-pattern" property)
+
+- led-pattern : Array of integers with default pattern for certain triggers.
+                Each trigger may parse this property differently:
+                - one-shot : two numbers specifying delay on and delay off (in ms),
+                - timer : two numbers specifying delay on and delay off (in ms),
+                - pattern : the pattern is given by a series of tuples, of
+                  brightness and duration (in ms).  The exact format is
+                  described in:
+                  Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
+
 
 - led-max-microamp : Maximum LED supply current in microamperes. This property
                      can be made mandatory for the board configurations
diff --git a/Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt b/Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
new file mode 100644
index 000000000000..d3696680bfc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
@@ -0,0 +1,49 @@
+* Pattern format for LED pattern trigger
+
+The pattern is given by a series of tuples, of brightness and duration (ms).
+The LED is expected to traverse the series and each brightness value for the
+specified duration. Duration of 0 means brightness should immediately change to
+new value, and writing malformed pattern deactivates any active one.
+
+1. For gradual dimming, the dimming interval now is set as 50 milliseconds. So
+the tuple with duration less than dimming interval (50ms) is treated as a step
+change of brightness, i.e. the subsequent brightness will be applied without
+adding intervening dimming intervals.
+
+The gradual dimming format of the software pattern values should be:
+"brightness_1 duration_1 brightness_2 duration_2 brightness_3 duration_3 ...".
+For example (using sysfs interface):
+
+echo 0 1000 255 2000 > pattern
+
+It will make the LED go gradually from zero-intensity to max (255) intensity in
+1000 milliseconds, then back to zero intensity in 2000 milliseconds:
+
+LED brightness
+    ^
+255-|       / \            / \            /
+    |      /    \         /    \         /
+    |     /       \      /       \      /
+    |    /          \   /          \   /
+  0-|   /             \/             \/
+    +---0----1----2----3----4----5----6------------> time (s)
+
+2. To make the LED go instantly from one brightness value to another, we should
+use zero-time lengths (the brightness must be same as the previous tuple's). So
+the format should be: "brightness_1 duration_1 brightness_1 0 brightness_2
+duration_2 brightness_2 0 ...".
+For example (using sysfs interface):
+
+echo 0 1000 0 0 255 2000 255 0 > pattern
+
+It will make the LED stay off for one second, then stay at max brightness for
+two seconds:
+
+LED brightness
+    ^
+255-|        +---------+    +---------+
+    |        |         |    |         |
+    |        |         |    |         |
+    |        |         |    |         |
+  0-|   -----+         +----+         +----
+    +---0----1----2----3----4----5----6------------> time (s)
-- 
2.17.1

