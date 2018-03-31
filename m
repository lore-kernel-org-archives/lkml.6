Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeCaHpq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:45:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:10007 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751538AbeCaHpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:45:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,383,1517904000";
   d="scan'208";a="42835305"
From: Haiyue Wang <haiyue.wang@linux.intel.com>
To: joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [PATCH dts/arm/aspeed-g5 v1] ARM: dts: aspeed-g5: Add IPMI KCS nodes for SMS and SMM mode
Date: Sat, 31 Mar 2018 15:46:38 +0800
Message-Id: <1522482398-6248-1-git-send-email-haiyue.wang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPMI KCS device part of the LPC interface and is used for
communication with the host processor.

Keyboard Controller Style Interfaces:
The KCS channel number is assigned by AST_usrGuide_KCS.pdf
Name          | Use          | Address       | KCS Channel |
SMS Interface | SMS          | 0CA2h – 0CA3h | kcs3        |
SMM Interface | SMI handling | 0CA4h – 0CA5h | kcs4        |

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
The kcs_bmc_aspeed driver is in linux-next now:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/char/ipmi/kcs_bmc_aspeed.c?h=next-20180329
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 17ee0fa3..8d6c4af 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -268,8 +268,22 @@
 				ranges = <0x0 0x1e789000 0x1000>;
 
 				lpc_bmc: lpc-bmc@0 {
-					compatible = "aspeed,ast2500-lpc-bmc";
+					compatible = "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
 					reg = <0x0 0x80>;
+					reg-io-width = <4>;
+
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0x0 0x0 0x80>;
+
+					kcs3: kcs3@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						kcs_chan = <3>;
+						kcs_addr = <0xca2>;
+						status = "disabled";
+					};
 				};
 
 				lpc_host: lpc-host@80 {
@@ -281,6 +295,15 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
+					kcs4: kcs4@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0xa0>;
+						interrupts = <8>;
+						kcs_chan = <4>;
+						kcs_addr = <0xca4>;
+						status = "disabled";
+					};
+
 					lpc_ctrl: lpc-ctrl@0 {
 						compatible = "aspeed,ast2500-lpc-ctrl";
 						reg = <0x0 0x80>;
-- 
2.7.4
