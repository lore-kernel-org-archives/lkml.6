Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCZNTg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:19:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCZNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:19:34 -0400
Date: Mon, 26 Mar 2018 06:19:20 -0700
From: tip-bot for Ivan Gorinov <tipbot@zytor.com>
Message-ID: <tip-7f2e85840871f199057e65232ebde846192ed989@git.kernel.org>
Cc: andy.shevchenko@gmail.com, mark.rutland@arm.com,
        frowand.list@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        robh+dt@kernel.org, ivan.gorinov@intel.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        robh@kernel.org, ivan.gorinov@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, andy.shevchenko@gmail.com, frowand.list@gmail.com,
        mark.rutland@arm.com
In-Reply-To: <4b1a471a56ac0ebd7510f4759afce9104595d6da.1521753738.git.ivan.gorinov@intel.com>
References: <4b1a471a56ac0ebd7510f4759afce9104595d6da.1521753738.git.ivan.gorinov@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] of/Documentation: Specify local APIC ID in "reg"
Git-Commit-ID: 7f2e85840871f199057e65232ebde846192ed989
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7f2e85840871f199057e65232ebde846192ed989
Gitweb:     https://git.kernel.org/tip/7f2e85840871f199057e65232ebde846192ed989
Author:     Ivan Gorinov <ivan.gorinov@intel.com>
AuthorDate: Thu, 22 Mar 2018 14:35:33 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 26 Mar 2018 15:13:32 +0200

of/Documentation: Specify local APIC ID in "reg"

Use the "reg" property to specify the processor's local APIC ID instead of
setting it to the CPU node index in Device Tree.

Local APIC ID is assigned by hardware and visible in the APIC ID register.
Some processor models allow APIC ID to be changed by software, but CPUID
instruction executed with %eax = 0x0b always returns the initial ID in %edx.

Local APIC ID does not match the node index in many systems.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Link: https://lkml.kernel.org/r/4b1a471a56ac0ebd7510f4759afce9104595d6da.1521753738.git.ivan.gorinov@intel.com

---
 Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++++++------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
index b49ae593a60b..cd1221bfb539 100644
--- a/Documentation/devicetree/bindings/x86/ce4100.txt
+++ b/Documentation/devicetree/bindings/x86/ce4100.txt
@@ -7,17 +7,36 @@ Many of the "generic" devices like HPET or IO APIC have the ce4100
 name in their compatible property because they first appeared in this
 SoC.
 
-The CPU node
-------------
-	cpu@0 {
-		device_type = "cpu";
-		compatible = "intel,ce4100";
-		reg = <0>;
-		lapic = <&lapic0>;
+The CPU nodes
+-------------
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "intel,ce4100";
+			reg = <0x00>;
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			compatible = "intel,ce4100";
+			reg = <0x02>;
+		};
 	};
 
-The reg property describes the CPU number. The lapic property points to
-the local APIC timer.
+A "cpu" node describes one logical processor (hardware thread).
+
+Required properties:
+
+- device_type
+	Device type, must be "cpu".
+
+- reg
+	Local APIC ID, the unique number assigned to each processor by
+	system hardware.
 
 The SoC node
 ------------
