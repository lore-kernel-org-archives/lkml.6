Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933520AbeCBVGZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:06:25 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39439 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeCBVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:05:50 -0500
X-Google-Smtp-Source: AG47ELuucJhHdJQaG+3cGwBJkRztC1skAPXhf2BEZUNjyH/Kg1q2YL257E6kFBQhclP80m2H1lQM9g==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com
Subject: [PATCH v6 3/4] of: convert unittest overlay devicetree source to sugar syntax
Date: Fri,  2 Mar 2018 13:04:59 -0800
Message-Id: <1520024700-31315-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520024700-31315-1-git-send-email-frowand.list@gmail.com>
References: <1520024700-31315-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The unittest-data overlays have been pulled into proper overlay
devicetree source files without changing their format.  The
next step is to convert them to use sugar syntax instead of
hand coding overlay fragments structure.

A few of the overlays can not be converted because they test
absolute target paths in the overlay fragment.  dtc does not
generate this type of target:
  overlay_0.dts
  overlay_1.dts
  overlay_12.dts
  overlay_13.dts

Two pre-existing unittest overlay devicetree source files are
also converted:
  overlay_bad_phandle.dts
  overlay_bad_symbol.dts

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

There are checkpatch warnings.  I have reviewed them and feel they
can be ignored.  They are pre-existing warnings of un-documented
bindings of made up (fake) compatibles in devicetree source for
test overlays.

 drivers/of/unittest-data/overlay.dts             | 101 ++++++++++-------------
 drivers/of/unittest-data/overlay_10.dts          |  39 ++++-----
 drivers/of/unittest-data/overlay_11.dts          |  40 ++++-----
 drivers/of/unittest-data/overlay_15.dts          |  41 ++++-----
 drivers/of/unittest-data/overlay_2.dts           |  11 +--
 drivers/of/unittest-data/overlay_3.dts           |  11 +--
 drivers/of/unittest-data/overlay_4.dts           |  23 ++----
 drivers/of/unittest-data/overlay_5.dts           |  11 +--
 drivers/of/unittest-data/overlay_6.dts           |  13 +--
 drivers/of/unittest-data/overlay_7.dts           |  13 +--
 drivers/of/unittest-data/overlay_8.dts           |  13 +--
 drivers/of/unittest-data/overlay_9.dts           |  13 +--
 drivers/of/unittest-data/overlay_bad_phandle.dts |  23 ++----
 drivers/of/unittest-data/overlay_bad_symbol.dts  |  25 ++----
 drivers/of/unittest-data/tests-overlay.dtsi      |   4 +-
 15 files changed, 148 insertions(+), 233 deletions(-)

diff --git a/drivers/of/unittest-data/overlay.dts b/drivers/of/unittest-data/overlay.dts
index ab5e89b5e27e..3bbc59e922fe 100644
--- a/drivers/of/unittest-data/overlay.dts
+++ b/drivers/of/unittest-data/overlay.dts
@@ -2,76 +2,63 @@
 /dts-v1/;
 /plugin/;
 
-/ {
+&electric_1 {
 
-	fragment@0 {
-		target = <&electric_1>;
+	status = "okay";
 
-		__overlay__ {
-			status = "okay";
-
-			hvac_2: hvac-large-1 {
-				compatible = "ot,hvac-large";
-				heat-range = < 40 75 >;
-				cool-range = < 65 80 >;
-			};
-		};
+	hvac_2: hvac-large-1 {
+		compatible = "ot,hvac-large";
+		heat-range = < 40 75 >;
+		cool-range = < 65 80 >;
 	};
+};
 
-	fragment@1 {
-		target = <&rides_1>;
-
-		__overlay__ {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			status = "okay";
-
-			ride@100 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-
-				track@30 {
-					incline-up = < 48 32 16 >;
-				};
+&rides_1 {
 
-				track@40 {
-					incline-up = < 47 31 15 >;
-				};
-			};
+	#address-cells = <1>;
+	#size-cells = <1>;
+	status = "okay";
 
-			ride_200: ride@200 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "ot,ferris-wheel";
-				reg = < 0x00000200 0x100 >;
-				hvac-provider = < &hvac_2 >;
-				hvac-thermostat = < 27 32 > ;
-				hvac-zones = < 12 5 >;
-				hvac-zone-names = "operator", "snack-bar";
-				spin-controller = < &spin_ctrl_1 3 >;
-				spin-rph = < 30 >;
-				gondolas = < 16 >;
-				gondola-capacity = < 6 >;
+	ride@100 {
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-				ride_200_left: track@10 {
-					reg = < 0x00000010 0x10 >;
-				};
+		track@30 {
+			incline-up = < 48 32 16 >;
+		};
 
-				ride_200_right: track@20 {
-					reg = < 0x00000020 0x10 >;
-				};
-			};
+		track@40 {
+			incline-up = < 47 31 15 >;
 		};
 	};
 
-	fragment@2 {
-		target = <&lights_2>;
+	ride_200: ride@200 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "ot,ferris-wheel";
+		reg = < 0x00000200 0x100 >;
+		hvac-provider = < &hvac_2 >;
+		hvac-thermostat = < 27 32 > ;
+		hvac-zones = < 12 5 >;
+		hvac-zone-names = "operator", "snack-bar";
+		spin-controller = < &spin_ctrl_1 3 >;
+		spin-rph = < 30 >;
+		gondolas = < 16 >;
+		gondola-capacity = < 6 >;
+
+		ride_200_left: track@10 {
+			reg = < 0x00000010 0x10 >;
+		};
 
-		__overlay__ {
-			status = "okay";
-			color = "purple", "white", "red", "green";
-			rate = < 3 256 >;
+		ride_200_right: track@20 {
+			reg = < 0x00000020 0x10 >;
 		};
 	};
+};
+
+&lights_2 {
 
+	status = "okay";
+	color = "purple", "white", "red", "green";
+	rate = < 3 256 >;
 };
diff --git a/drivers/of/unittest-data/overlay_10.dts b/drivers/of/unittest-data/overlay_10.dts
index 445925a10cd3..73993bf23bf8 100644
--- a/drivers/of/unittest-data/overlay_10.dts
+++ b/drivers/of/unittest-data/overlay_10.dts
@@ -2,33 +2,26 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_10 */
-	/* overlays 8, 9, 10, 11 application and removal in bad sequence */
+/* overlay_10 */
+/* overlays 8, 9, 10, 11 application and removal in bad sequence */
 
-	fragment@0 {
-		target-path = "/testcase-data/overlay-node/test-bus";
-		__overlay__ {
+&unittest_test_bus {
+	/* suppress DTC warning */
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-			/* suppress DTC warning */
-			#address-cells = <1>;
-			#size-cells = <0>;
+	test-unittest10 {
+		compatible = "unittest";
+		status = "okay";
+		reg = <10>;
 
-			test-unittest10 {
-				compatible = "unittest";
-				status = "okay";
-				reg = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				test-unittest101 {
-					compatible = "unittest";
-					status = "okay";
-					reg = <1>;
-				};
-
-			};
+		test-unittest101 {
+			compatible = "unittest";
+			status = "okay";
+			reg = <1>;
 		};
 	};
 };
diff --git a/drivers/of/unittest-data/overlay_11.dts b/drivers/of/unittest-data/overlay_11.dts
index c1d14f34359e..9a79b253a809 100644
--- a/drivers/of/unittest-data/overlay_11.dts
+++ b/drivers/of/unittest-data/overlay_11.dts
@@ -2,33 +2,27 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_11 */
-	/* overlays 8, 9, 10, 11 application and removal in bad sequence */
+/* overlay_11 */
+/* overlays 8, 9, 10, 11 application and removal in bad sequence */
 
-	fragment@0 {
-		target-path = "/testcase-data/overlay-node/test-bus";
-		__overlay__ {
+&unittest_test_bus {
+	/* suppress DTC warning */
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-			/* suppress DTC warning */
-			#address-cells = <1>;
-			#size-cells = <0>;
+	test-unittest11 {
+		compatible = "unittest";
+		status = "okay";
+		reg = <11>;
 
-			test-unittest11 {
-				compatible = "unittest";
-				status = "okay";
-				reg = <11>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				test-unittest111 {
-					compatible = "unittest";
-					status = "okay";
-					reg = <1>;
-				};
-
-			};
+		test-unittest111 {
+			compatible = "unittest";
+			status = "okay";
+			reg = <1>;
 		};
+
 	};
 };
diff --git a/drivers/of/unittest-data/overlay_15.dts b/drivers/of/unittest-data/overlay_15.dts
index 44e44c62b739..b98f2514df4b 100644
--- a/drivers/of/unittest-data/overlay_15.dts
+++ b/drivers/of/unittest-data/overlay_15.dts
@@ -2,33 +2,28 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_15 - mux overlay */
+/* overlay_15 - mux overlay */
 
-	fragment@0 {
-		target-path = "/testcase-data/overlay-node/test-bus/i2c-test-bus";
-		__overlay__ {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			test-unittest15 {
-				reg = <11>;
-				compatible = "unittest-i2c-mux";
-				status = "okay";
+&unittest_i2c_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	test-unittest15 {
+		reg = <11>;
+		compatible = "unittest-i2c-mux";
+		status = "okay";
 
-				#address-cells = <1>;
-				#size-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-				i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-					test-mux-dev {
-						reg = <32>;
-						compatible = "unittest-i2c-dev";
-						status = "okay";
-					};
-				};
+			test-mux-dev {
+				reg = <32>;
+				compatible = "unittest-i2c-dev";
+				status = "okay";
 			};
 		};
 	};
diff --git a/drivers/of/unittest-data/overlay_2.dts b/drivers/of/unittest-data/overlay_2.dts
index cf1e4245b7ce..db8684ba89d9 100644
--- a/drivers/of/unittest-data/overlay_2.dts
+++ b/drivers/of/unittest-data/overlay_2.dts
@@ -2,13 +2,8 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_2 -  enable using label */
+/* overlay_2 -  enable using label */
 
-	fragment@0 {
-		target = <&unittest2>;
-		__overlay__ {
-			status = "okay";
-		};
-	};
+&unittest2 {
+	status = "okay";
 };
diff --git a/drivers/of/unittest-data/overlay_3.dts b/drivers/of/unittest-data/overlay_3.dts
index 158dc44fc20a..40f289e7c237 100644
--- a/drivers/of/unittest-data/overlay_3.dts
+++ b/drivers/of/unittest-data/overlay_3.dts
@@ -2,13 +2,8 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_3 - disable using label */
+/* overlay_3 - disable using label */
 
-	fragment@0 {
-		target = <&unittest3>;
-		__overlay__ {
-			status = "disabled";
-		};
-	};
+&unittest3 {
+	status = "disabled";
 };
diff --git a/drivers/of/unittest-data/overlay_4.dts b/drivers/of/unittest-data/overlay_4.dts
index b4a2e6c6b016..a8a77ddf9abe 100644
--- a/drivers/of/unittest-data/overlay_4.dts
+++ b/drivers/of/unittest-data/overlay_4.dts
@@ -2,22 +2,17 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_4 - test insertion of a full node */
+/* overlay_4 - test insertion of a full node */
 
-	fragment@0 {
-		target = <&unittestbus>;
-		__overlay__ {
+&unittest_test_bus {
 
-			/* suppress DTC warning */
-			#address-cells = <1>;
-			#size-cells = <0>;
+	/* suppress DTC warning */
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-			test-unittest4 {
-				compatible = "unittest";
-				status = "okay";
-				reg = <4>;
-			};
-		};
+	test-unittest4 {
+		compatible = "unittest";
+		status = "okay";
+		reg = <4>;
 	};
 };
diff --git a/drivers/of/unittest-data/overlay_5.dts b/drivers/of/unittest-data/overlay_5.dts
index 02ad25c1f19c..706f5f1b737c 100644
--- a/drivers/of/unittest-data/overlay_5.dts
+++ b/drivers/of/unittest-data/overlay_5.dts
@@ -2,13 +2,8 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_5 - test overlay apply revert */
+/* overlay_5 - test overlay apply revert */
 
-	fragment@0 {
-		target-path = "/testcase-data/overlay-node/test-bus/test-unittest5";
-		__overlay__ {
-			status = "okay";
-		};
-	};
+&unittest5 {
+	status = "okay";
 };
diff --git a/drivers/of/unittest-data/overlay_6.dts b/drivers/of/unittest-data/overlay_6.dts
index a14e965f5497..21a7fa4ca45e 100644
--- a/drivers/of/unittest-data/overlay_6.dts
+++ b/drivers/of/unittest-data/overlay_6.dts
@@ -2,14 +2,9 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_6 */
-	/* overlays 6, 7 application and removal in sequence */
+/* overlay_6 */
+/* overlays 6, 7 application and removal in sequence */
 
-	fragment@0 {
-		target-path = "/testcase-data/overlay-node/test-bus/test-unittest6";
-		__overlay__ {
-			status = "okay";
-		};
-	};
+&unittest6 {
+	status = "okay";
 };
diff --git a/drivers/of/unittest-data/overlay_7.dts b/drivers/of/unittest-data/overlay_7.dts
index 4bd7e423209c..58ba1bb51b50 100644
--- a/drivers/of/unittest-data/overlay_7.dts
+++ b/drivers/of/unittest-data/overlay_7.dts
@@ -2,14 +2,9 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_7 */
-	/* overlays 6, 7 application and removal in sequence */
+/* overlay_7 */
+/* overlays 6, 7 application and removal in sequence */
 
-	fragment@0 {
-		target-path = "/testcase-data/overlay-node/test-bus/test-unittest7";
-		__overlay__ {
-			status = "okay";
-		};
-	};
+&unittest7 {
+	status = "okay";
 };
diff --git a/drivers/of/unittest-data/overlay_8.dts b/drivers/of/unittest-data/overlay_8.dts
index 5b21c53945a9..e9718d118e38 100644
--- a/drivers/of/unittest-data/overlay_8.dts
+++ b/drivers/of/unittest-data/overlay_8.dts
@@ -2,14 +2,9 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_8 */
-	/* overlays 8, 9, 10, 11 application and removal in bad sequence */
+/* overlay_8 */
+/* overlays 8, 9, 10, 11 application and removal in bad sequence */
 
-	fragment@0 {
-		target-path = "/testcase-data/overlay-node/test-bus/test-unittest8";
-		__overlay__ {
-			status = "okay";
-		};
-	};
+&unittest8 {
+	status = "okay";
 };
diff --git a/drivers/of/unittest-data/overlay_9.dts b/drivers/of/unittest-data/overlay_9.dts
index 20ff055a5349..b35e23edae50 100644
--- a/drivers/of/unittest-data/overlay_9.dts
+++ b/drivers/of/unittest-data/overlay_9.dts
@@ -2,14 +2,9 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	/* overlay_9 */
-	/* overlays 8, 9, 10, 11 application and removal in bad sequence */
+/* overlay_9 */
+/* overlays 8, 9, 10, 11 application and removal in bad sequence */
 
-	fragment@0 {
-		target-path = "/testcase-data/overlay-node/test-bus/test-unittest8";
-		__overlay__ {
-			property-foo = "bar";
-		};
-	};
+&unittest8 {
+	property-foo = "bar";
 };
diff --git a/drivers/of/unittest-data/overlay_bad_phandle.dts b/drivers/of/unittest-data/overlay_bad_phandle.dts
index 4d5b99723bad..83b797360318 100644
--- a/drivers/of/unittest-data/overlay_bad_phandle.dts
+++ b/drivers/of/unittest-data/overlay_bad_phandle.dts
@@ -2,20 +2,13 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-
-	fragment@0 {
-		target = <&electric_1>;
-
-		__overlay__ {
-
-			// This label should cause an error when the overlay
-			// is applied.  There is already a phandle value
-			// in the base tree for motor-1.
-			spin_ctrl_1_conflict: motor-1 {
-				accelerate = < 3 >;
-				decelerate = < 5 >;
-			};
-		};
+&electric_1 {
+
+	// This label should cause an error when the overlay
+	// is applied.  There is already a phandle value
+	// in the base tree for motor-1.
+	spin_ctrl_1_conflict: motor-1 {
+		accelerate = < 3 >;
+		decelerate = < 5 >;
 	};
 };
diff --git a/drivers/of/unittest-data/overlay_bad_symbol.dts b/drivers/of/unittest-data/overlay_bad_symbol.dts
index 135052ee1517..98c6d1de144a 100644
--- a/drivers/of/unittest-data/overlay_bad_symbol.dts
+++ b/drivers/of/unittest-data/overlay_bad_symbol.dts
@@ -2,22 +2,15 @@
 /dts-v1/;
 /plugin/;
 
-/ {
+&electric_1 {
 
-	fragment@0 {
-		target = <&electric_1>;
-
-		__overlay__ {
-
-			// This label should cause an error when the overlay
-			// is applied.  There is already a symbol hvac_1
-			// in the base tree
-			hvac_1: hvac-medium-2 {
-				compatible = "ot,hvac-medium";
-				heat-range = < 50 75 >;
-				cool-range = < 60 80 >;
-			};
-
-		};
+	// This label should cause an error when the overlay
+	// is applied.  There is already a symbol hvac_1
+	// in the base tree
+	hvac_1: hvac-medium-2 {
+		compatible = "ot,hvac-medium";
+		heat-range = < 50 75 >;
+		cool-range = < 60 80 >;
 	};
+
 };
diff --git a/drivers/of/unittest-data/tests-overlay.dtsi b/drivers/of/unittest-data/tests-overlay.dtsi
index fa2fb43bccac..25cf397b8f6b 100644
--- a/drivers/of/unittest-data/tests-overlay.dtsi
+++ b/drivers/of/unittest-data/tests-overlay.dtsi
@@ -5,7 +5,7 @@
 		overlay-node {
 
 			/* test bus */
-			unittestbus: test-bus {
+			unittest_test_bus: test-bus {
 				compatible = "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -70,7 +70,7 @@
 					reg = <8>;
 				};
 
-				i2c-test-bus {
+				unittest_i2c_test_bus: i2c-test-bus {
 					compatible = "unittest-i2c-bus";
 					status = "okay";
 					reg = <50>;
-- 
Frank Rowand <frank.rowand@sony.com>
