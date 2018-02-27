Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeB0KXW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:23:22 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40839 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeB0KXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:23:20 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au,
        sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] R-Car M3-N: Enable EtherAVB device node
Date: Tue, 27 Feb 2018 11:22:44 +0100
Message-Id: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon, Geert,
   in this second iteration I have dropped iommu dependencies for EtherAVB
and have changed "phy-mode" for all mainlines Gen-3 boards, this time including
ULCB, Draak, Eagle and V3MSK.

The series add phy-mode as a board property to the following board files:
- salvator-common.dtsi
- ulcb.dtsi
- r8a77995-draak.dts
- r8a77970-eagle.dts
- r8a77970-v3msk.dts

And reset the EtherAVB phy-mode to "rgmii" in the following SoC DTSI:
- r8a7795.dtsi
- r8a7796.dtsi
- r8a77995.dtsi
- r8a77970.dtsi

And finally, I added EtherAVB device node for M3-N on top.

I have verified with scripts/dtc/dtx_diff that the only difference compared to
the previous version for all DTS files is the newly introduced EtherAVB node for
r8a77965 Salvator-X board.

------------------------------------------------------------------------------
$ for i in `ls dts-new/*.dtb`; do
	dt=`basename $i`;
	echo $dt;
	./scripts/dtc/dtx_diff dts-old/$dt dts-new/$dt;
  done

$ r8a7795-es1-h3ulcb.dtb
 r8a7795-es1-h3ulcb-kf.dtb
 r8a7795-es1-salvator-x.dtb
 r8a7795-h3ulcb.dtb
 r8a7795-h3ulcb-kf.dtb
 r8a7795-salvator-x.dtb
 r8a7795-salvator-xs.dtb
 r8a77965-salvator-x.dtb
 --- dts-old/r8a77965-salvator-x.dtb
 +++ dts-new/r8a77965-salvator-x.dtb
 @@ -413,10 +413,17 @@
  		ethernet@e6800000 {
  			#address-cells = <0x1>;
  			#size-cells = <0x0>;
 +			clocks = <0x6 0x1 0x32c>;
 +			compatible = "renesas,etheravb-r8a77965", "renesas,etheravb-rcar-gen3";
 +			interrupt-names = "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6", "ch7", "ch8", "ch9", "ch10", "ch11", "ch12", "ch13", "ch14", "ch15", "ch16", "ch17", "ch18", "ch19", "ch20", "ch21", "ch22", "ch23", "ch24";
 +			interrupts = <0x0 0x27 0x4 0x0 0x28 0x4 0x0 0x29 0x4 0x0 0x2a 0x4 0x0 0x2b 0x4 0x0 0x2c 0x4 0x0 0x2d 0x4 0x0 0x2e 0x4 0x0 0x2f 0x4 0x0 0x30 0x4 0x0 0x31 0x4 0x0 0x32 0x4 0x0 0x33 0x4 0x0 0x34 0x4 0x0 0x35 0x4 0x0 0x36 0x4 0x0 0x37 0x4 0x0 0x38 0x4 0x0 0x39 0x4 0x0 0x3a 0x4 0x0 0x3b 0x4 0x0 0x3c 0x4 0x0 0x3d 0x4 0x0 0x3e 0x4 0x0 0x3f 0x4>;
  			phy-handle = <0x12>;
 +			phy-mode = "rgmii-txid";
  			pinctrl-0 = <0x11>;
  			pinctrl-names = "default";
 +			power-domains = <0x1 0x20>;
  			reg = <0x0 0xe6800000 0x0 0x800 0x0 0xe6a00000 0x0 0x10000>;
 +			resets = <0x6 0x32c>;
  			status = "okay";

  			ethernet-phy@0 {
 r8a7796-m3ulcb.dtb
 r8a7796-m3ulcb-kf.dtb
 r8a7796-salvator-x.dtb
 r8a7796-salvator-xs.dtb
 r8a77970-eagle.dtb
 r8a77970-v3msk.dtb
 r8a77995-draak.dtb
------------------------------------------------------------------------------

As per the previous version, this is based on what Simon already picked in his
development branch.

Branch for testing available at:
git://jmondi.org/linux m3-n/renesas-drivers-2018-02-13-v4.16-rc1/v2-simon

Thanks
   j

v1 -> v2:
- Change rgmii mode in ULCB, Draak, Eagle and V3MSK
- Reset rgmii mode for r8a77970
- Drop iommu dependencies and associated patches

Jacopo Mondi (10):
  arm64: dts: renesas: salvator-common: Override EtherAVB phy-mode
  arm64: dts: renesas: ulcb: Override EtherAVB phy-mode
  arm64: dts: renesas: draak: Override EtherAVB phy-mode
  arm64: dts: renesas: eagle: Override EtherAVB phy-mode
  arm64: dts: renesas: v3msk: Override EtherAVB phy-mode
  arm64: dts: renesas: r8a7796: Set EtherAVB phy mode to "rgmii"
  arm64: dts: renesas: r8a7795: Set EtherAVB phy mode to "rgmii"
  arm64: dts: renesas: r8a77995: Set EtherAVB phy mode to "rgmii"
  arm64: dts: renesas: r8a77970: Set EtherAVB phy mode to "rgmii"
  arm64: dts: renesas: r8a77965: Add EtherAVB device node

 arch/arm64/boot/dts/renesas/r8a7795.dtsi         |  2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi         |  2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi        | 43 ++++++++++++++++++++++--
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts   |  1 +
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts   |  1 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi        |  2 +-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts   |  1 +
 arch/arm64/boot/dts/renesas/r8a77995.dtsi        |  2 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |  1 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi            |  1 +
 10 files changed, 49 insertions(+), 7 deletions(-)

--
2.7.4
