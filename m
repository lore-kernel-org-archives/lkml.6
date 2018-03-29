Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeC2LNT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:13:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:19024 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeC2LLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:11:17 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517900400";
   d="scan'208";a="13376168"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <thierry.reding@gmail.com>, <shc_work@mail.ru>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 5/9] pwm: add PWM modes
Date: Thu, 29 Mar 2018 14:10:31 +0300
Message-ID: <1522321835-6460-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
References: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM normal and complementary modes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/pwm/pwm.txt |  9 +++++++--
 Documentation/pwm.txt                         | 26 +++++++++++++++++++++++---
 include/dt-bindings/pwm/pwm.h                 |  1 +
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 8556263b8502..7c8aaac43f92 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -46,11 +46,16 @@ period in nanoseconds.
 Optionally, the pwm-specifier can encode a number of flags (defined in
 <dt-bindings/pwm/pwm.h>) in a third cell:
 - PWM_POLARITY_INVERTED: invert the PWM signal polarity
+- PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM channels
+with two outputs); if not specified, the default for PWM channel will be
+used
 
-Example with optional PWM specifier for inverse polarity
+Example with optional PWM specifier for inverse polarity and complementary
+mode:
 
 	bl: backlight {
-		pwms = <&pwm 0 5000000 PWM_POLARITY_INVERTED>;
+		pwms = <&pwm 0 5000000
+			(PWM_MODE_COMPLEMENTARY | PWM_POLARITY_INVERTED)>;
 		pwm-names = "backlight";
 	};
 
diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa3ba2d..912c43da8b48 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -61,9 +61,9 @@ In addition to the PWM state, the PWM API also exposes PWM arguments, which
 are the reference PWM config one should use on this PWM.
 PWM arguments are usually platform-specific and allows the PWM user to only
 care about dutycycle relatively to the full period (like, duty = 50% of the
-period). struct pwm_args contains 2 fields (period and polarity) and should
-be used to set the initial PWM config (usually done in the probe function
-of the PWM user). PWM arguments are retrieved with pwm_get_args().
+period). struct pwm_args contains 3 fields (period, polarity and mode) and
+should be used to set the initial PWM config (usually done in the probe
+function of the PWM user). PWM arguments are retrieved with pwm_get_args().
 
 Using PWMs with the sysfs interface
 -----------------------------------
@@ -110,6 +110,26 @@ channel that was exported. The following properties will then be available:
 	- 0 - disabled
 	- 1 - enabled
 
+  mode
+    Get/set PWM channel working mode.
+
+    Normal mode - for PWM channels with one output; this should be the
+        default working mode for every PWM channel; output waveforms looks
+        like this:
+             __    __    __    __
+    PWM   __|  |__|  |__|  |__|  |__
+            <--T-->
+
+    Complementary mode - for PWM channels with two outputs; output waveforms
+        looks line this:
+             __    __    __    __
+    PWMH1 __|  |__|  |__|  |__|  |__
+          __    __    __    __    __
+    PWML1   |__|  |__|  |__|  |__|
+            <--T-->
+
+    Where T is the signal period.
+
 Implementing a PWM driver
 -------------------------
 
diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..b82279cc1787 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -11,5 +11,6 @@
 #define _DT_BINDINGS_PWM_PWM_H
 
 #define PWM_POLARITY_INVERTED			(1 << 0)
+#define PWM_MODE_COMPLEMENTARY			(1 << 1)
 
 #endif
-- 
2.7.4
