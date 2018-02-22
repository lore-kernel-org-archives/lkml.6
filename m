Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeBVOjY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:39:24 -0500
Received: from mout.perfora.net ([74.208.4.194]:34079 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932675AbeBVOjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:39:22 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
Date: Thu, 22 Feb 2018 15:38:25 +0100
Message-Id: <20180222143825.1517-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:7JWEIyTJJ+6LX+0UvjV56zkDMMsYqLwMdjiSYtVhc5YC0QElClT
 6ni6kZwy5DKqyovUhsbsSBM5Wta9w6S2EPg7ZAZOi/vvqfhM8afpH3kU70aK4Lg05luKXM2
 fbqNbA+1C49Lcqq3GSO5S2Z08ElYUJc/dd3IwPMoEav8GVi0rDKRWEfxJCaPtgqTkbY4VXL
 D+f8AVz8ZbQerElUJoShg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BwTCNeIyN7g=:dXHpvtoBkr9XbcRVOGhUFe
 TUDk1N1/Sg2WBuwC0tfPOANVokZi400N8PJybLQHBFzQiF+n52broT45AtrC3mO6QSf3U62+r
 B0VnPvf/35R0WeS46+XJ7OJVylUcIASu8kfUP37zmRNMjcR7FkjI6mhIYoWTyVEtOdveGidjl
 MCMDmxjwVwappx+GSJmTtlZ0V+XctOtfZfWbsMhTIxeAZgARzflpUXqOk3ME1GLu/EUezALCJ
 DSBv3tT5tZBl31QTk/nsaB3vxSkY62Pu5k+L95lu3NSVJawNGXA7mideLy5bze/O8igDCLEji
 wN3D/0VkIPP7eJyl7S9bdjZHO9FZJhHMiBkeCzksFbBl3msc9jPBucFoeGNa6e9ch2ZQthzUp
 +pWyoPfu8wqETbkx3PDDdy7TROpYVYBPoO8st9P4LLfwL15d8UGqLRjH+4ytXwjHA0Dt1Fm5x
 aL0zKi7WVPRfxTPq1NDBZbx5P6BA+ZhlDMCfJ937OreldLHaOve/jFWnp99ChgTsA8yxqz+y7
 1oSbFZ/Yq7u9Hcm9rGB9v9icAuLW6qkXkMrwNQ6ejScufrWgjwKfr7fq6AQtjeEpBex555V8b
 2+UqXLtbm0yKHTkYnXiU1sCH0nY6GDLGwxzX2FhvWe5UtdUZ1fQayoFVTJWA9cGi3bQUsOFUX
 kjJ+8qQJWu5BoFbtzcK5AsEQEzowDCcaERTE87J1ANvtU6Z/KBjUVBJOgdGSYMlo2JOmgiI9r
 DJCkQCHhMFOs7phKWEKfyJ2eEYrBVJzlpJv2Og==
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

Changes in v2:
- Updated device tree binding documentation as well.
- CCing Dmitry as well.

 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt | 4 +++-
 arch/arm/boot/dts/tegra20.dtsi                                   | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
index a9aa79fb90ed..1aa6f2674af5 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
@@ -21,7 +21,9 @@ Required properties :
    - timer: The timeout clock (clk_m). Present if phy_type == utmi.
    - utmi-pads: The clock needed to access the UTMI pad control registers.
      Present if phy_type == utmi.
-   - ulpi-link: The clock Tegra provides to the ULPI PHY (cdev2).
+   - ulpi-link: The clock Tegra provides to the ULPI PHY (usually pad DAP_MCLK2
+     with pad group aka "nvidia,pins" cdev2 and pin mux option config aka
+     "nvidia,function" pllp_out4).
      Present if phy_type == ulpi, and ULPI link mode is in use.
  - resets : Must contain an entry for each entry in reset-names.
    See ../reset/reset.txt for details.
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
