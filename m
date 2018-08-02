Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069DBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ACD21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QXgYpf50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ACD21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeHBMKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:10:13 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:32778 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeHBMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:10:13 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B975D10C0C34;
        Thu,  2 Aug 2018 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533205183; bh=MxLrjxLdjniRNVpEie01yY2O1D7wG5DUvthm5o1rnGY=;
        h=From:To:Cc:Subject:Date:From;
        b=QXgYpf50pnu0nrFYhmueBTNx0qPGeTCY2hdkS+D6Oq1LbLzQ9PgjfHJbbxKwzJh5S
         MS7KFZORd2TmmvF0xhU/U5iOd6A9Wnw+3B4cv7L41vOnFySonOt7a1eCMVi88id9Ed
         GwlPrQoOxHGH8GVqO5Y76L27hTx4jyFz5WIjHRvBXBepjnU+YjMcpN6ufplzzXRzlX
         GXj3XiG78ZsWBQllKEfy0nswHU/eW3ceYYzK9qwOjnMOKGSTudmw6vT3hfQm8nwT8P
         b6KJe9X4scg8Tc3NC6yduxtTtmeA9ypdUxM7RzGS1toSBdAXWYFj+2/f3CoqD0GZeP
         BPBkkRvQ02qCQ==
Received: from abrodkin-7480l.internal.synopsys.com (abrodkin-7480l.internal.synopsys.com [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id DA3623BF7;
        Thu,  2 Aug 2018 03:19:41 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, stable@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] ARC: AXS10x/HSDK: Allow U-Boot to pass MAC-address to the kernel
Date:   Thu,  2 Aug 2018 13:19:37 +0300
Message-Id: <20180802101937.6202-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/arc/boot/dts/axs10x_mb.dtsi | 7 ++++++-
 arch/arc/boot/dts/hsdk.dts       | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 47b74fbc403c..37bafd44e36d 100644
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
diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 006aa3de5348..d00f283094d3 100644
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
-- 
2.17.1

