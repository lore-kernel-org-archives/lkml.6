Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE531ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95BC2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95BC2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbeIREhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbeIREhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:46 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1D67C7D;
        Mon, 17 Sep 2018 23:08:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.18 031/158] ARC: [plat-axs*/plat-hsdk]: Allow U-Boot to pass MAC-address to the kernel
Date:   Tue, 18 Sep 2018 00:41:01 +0200
Message-Id: <20180917211712.435728565@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Brodkin <abrodkin@synopsys.com>

commit 5c0920897af59779546e9ea0e89c5db45c8aff33 upstream.

Otherwise kernel uses random MAC which is not very conveniet.
With that change in place use might set desired MAC in U-Boot
with "setenv ethaddr 11:22:33:44:55:66", save environment and
then from boot to boot the same MAC will be used by the kernel.

One other note for this to happen it's required to pass
board's .dtb in U-Boot's "bootm" command like that:
------------------->8-----------------
bootm 0x82000000 - 0x84000000
------------------->8-----------------

Here 0x82000000 is location of uImage while
0x80000000 is location of either axs10x.dtb or hsdk.dtb
previously loaded from SD-card, USB storage or TFTP server.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: stable@vger.kernel.org # 4.14
Cc: devicetree@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/boot/dts/axs10x_mb.dtsi |    7 ++++++-
 arch/arc/boot/dts/hsdk.dts       |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -9,6 +9,10 @@
  */
 
 / {
+	aliases {
+		ethernet = &gmac;
+	};
+
 	axs10x_mb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -68,7 +72,7 @@
 			};
 		};
 
-		ethernet@0x18000 {
+		gmac: ethernet@0x18000 {
 			#interrupt-cells = <1>;
 			compatible = "snps,dwmac";
 			reg = < 0x18000 0x2000 >;
@@ -81,6 +85,7 @@
 			max-speed = <100>;
 			resets = <&creg_rst 5>;
 			reset-names = "stmmaceth";
+			mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
 		};
 
 		ehci@0x40000 {
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -25,6 +25,10 @@
 		bootargs = "earlycon=uart8250,mmio32,0xf0005000,115200n8 console=ttyS0,115200n8 debug print-fatal-signals=1";
 	};
 
+	aliases {
+		ethernet = &gmac;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -163,7 +167,7 @@
 			#clock-cells = <0>;
 		};
 
-		ethernet@8000 {
+		gmac: ethernet@8000 {
 			#interrupt-cells = <1>;
 			compatible = "snps,dwmac";
 			reg = <0x8000 0x2000>;
@@ -176,6 +180,7 @@
 			phy-handle = <&phy0>;
 			resets = <&cgu_rst HSDK_ETH_RESET>;
 			reset-names = "stmmaceth";
+			mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
 
 			mdio {
 				#address-cells = <1>;


