Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9332CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535E420859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547045125;
	bh=UiIQ+OZhh8VZmhLVQS3RYV8X91UlafKxpWNqbDA1jJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B+XC5IqBit0Vhs+LcH3uUBnHzfEk6o00Sf/4RPSpjSWNPON1MpGqY0T29HTZgqRpX
	 lmseq73umW5cofDG4FmOKAkKAT3IJEs7Av2RpldSFfcCbPPKYA+jQVzURa9Qy5oAOi
	 Dzemq/3/FjoHMO1pTgSMpIrlUUdr5d2uh5rLav+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfAIOpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731752AbfAIOo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:44:59 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCDDB20883;
        Wed,  9 Jan 2019 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547045098;
        bh=UiIQ+OZhh8VZmhLVQS3RYV8X91UlafKxpWNqbDA1jJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2iqzury+TFS5ROijSNA+YvB+kaioKcxZj5lMXyWUJwxRwEtT6Oc8XpH68w7xCKoB
         7/GwHae1TkESFD+4Kq5BiyEoukR512xas5Az/8bGsJiekNug+nqYJx1SG+0sOxh8vl
         ijfbmy5HomdH8ktE6+ZeE9idAQe4jxrVLulolq3c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: leds: Add pattern initialization from Device Tree
Date:   Wed,  9 Jan 2019 15:44:45 +0100
Message-Id: <1547045089-19128-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547045089-19128-1-git-send-email-krzk@kernel.org>
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new led-pattern property for initialization of LED triggers.
The property format is trigger-specific (except being array of
integers).  For pattern trigger, the explanation of pattern format was
moved to a common file shared with sysfs ABI.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 .../ABI/testing/sysfs-class-led-trigger-pattern    | 51 ++--------------------
 Documentation/devicetree/bindings/leds/common.txt  | 12 +++++
 .../bindings/leds/leds-trigger-pattern.txt         | 49 +++++++++++++++++++++
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
2.7.4

