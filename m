Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeCUVnE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:43:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:50753 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753704AbeCUVnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:43:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="26452249"
Date: Wed, 21 Mar 2018 14:35:06 -0700
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 1/2] of: Documentation: Specify local APIC ID in "reg"
Message-ID: <1372456377308653dcb11fe10dafa45dda057f9b.1521667677.git.ivan.gorinov@intel.com>
References: <cover.1521667677.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1521667677.git.ivan.gorinov@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "reg" property to specify the processor's local APIC ID instead of
setting it to the "cpu" node index in Device Tree.

Local APIC ID is assigned by hardware and visible in the APIC ID register.
Some processor models allow APIC ID to be changed by software, but CPUID
instruction executed with %eax = 0x0b always returns the initial ID in %edx.

Local APIC ID does not match the DT "cpu" node index in many systems.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++++++------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
index b49ae59..4bbfed1 100644
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
+		cpu@0x00 {
+			device_type = "cpu";
+			compatible = "intel,ce4100";
+			reg = <0x00>;
+		};
+
+		cpu@0x02 {
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
-- 
2.7.4
