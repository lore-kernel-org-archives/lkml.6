Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeBSPNo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:13:44 -0500
Received: from mout.perfora.net ([74.208.4.196]:36635 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbeBSPNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:13:37 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: tegra: fix ulpi regression on tegra20
Date: Mon, 19 Feb 2018 16:12:52 +0100
Message-Id: <20180219151252.29289-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:8lcreEhGjcde02gtsipUR0Fy5W4OtMRFBvrDOtk9a51em1YKV91
 be7RvXzNwNXb76bbk/kMHLc4ss2M/rRUJrfSKAfCmu/Wj4ebA6nH5Avm4QwGboj2nfmqlKf
 /jetoyseK0znq2ucwkCfEmu3bAjtyEnT0VszuvZjX4Zv3+qN/J47+32Yyibx3Jg91D8DnbO
 cU+PvdaYF+KSb+XHz4O/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XirestIvFCQ=:ERFu6vDugAVb5bMFAZ+Oo9
 LV8z7/Q1aOROihsvp/KtbZSRjQV0U1TaFKZCBvSCoaL+wncl1vfsP5yulOlsCOp2uZnfRMuqy
 1O744XoTVjMZZUu0lm/JMr2KyWgqmWRJINPywqI5IWHurzPv8D4CE9wwKsVcvjKXrNgr+HfB8
 Mtp10W7+v0kbUdpxPMAB614bf9rxDwkvJD3L8sQwX6qq6D97EcaAeDWty6rzt16KuxRD91kQ8
 IvRuNYQz3smqC29V11KqnmqT3bb4G9uScFxRJWc3+90CNSNLm8ZL6q345Ple75AgV4REiPXnO
 Z7A+i95m+0eX68UcPUQx2838Cb1s0wpye7RKi73+8uvFGXREYvDVwQ2N/bnPFHnlbZ/Ykaotp
 gIqxK9wvpI2H8Sz6tAOFz5idfNtR4GZzu9YB6T1vjd6QTWdvQmf7xN8b9piwx82VGGGFTJDTf
 bw4rIgxmrTwWCBduPOxc3M4p2IxdvvmvawolXGRqmSzR537W2+cYnDt6yHbhzBNlKIHTYJ7O8
 +91suzGgvCD8/GDsJK366nxdKAKPxEbuY6yiIB39d6+dgdR6IpQ3yfXZe9p0eM4VRLwupn+4P
 gCSum++NoeCp/FfEpYZqkRJ/JcOJgWCULXHdGYP1/C1M1/T6Ar+GJseGlf4NiPVfNYJVH/t8E
 wG33P+Y4Q1oKdaYOWUb4D9puXOaqD+jkH1uUraYwgZXGbLP0SOr8H5HpL3Sl4+e/Oj40bOfYN
 JKO7b21wT03zS572Sz3NMJ3dg2ILI4VKzkOI9Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Since commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting
during registration") ULPI has been broken on Tegra20 leading to the
following error message during boot:

[    1.974698] ulpi_phy_power_on: ulpi write failed
[    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
[    1.985434] tegra-ehci: probe of c5004000.usb failed with error -110

Debugging through the changes and finally also consulting the TRM
revealed that rather than the CDEV2 clock off OSC requiring such pin
muxing actually the PLL_P_OUT4 clock is in use. It looks like so far it
just worked by chance of that one having been enabled which Stephen's
commit now changed when reparenting sclk away from pll_p_out4 leaving
that one disabled. Fix this by properly assigning the PLL_P_OUT4 clock
as the ULPI PHY clock.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 864a95872b8d..e05b6bb2599f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -741,7 +741,7 @@
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA20_CLK_USB2>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
-			 <&tegra_car TEGRA20_CLK_CDEV2>;
+			 <&tegra_car TEGRA20_CLK_PLL_P_OUT4>;
 		clock-names = "reg", "pll_u", "ulpi-link";
 		resets = <&tegra_car 58>, <&tegra_car 22>;
 		reset-names = "usb", "utmi-pads";
-- 
2.14.3
