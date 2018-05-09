Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965287AbeEIUFp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 16:05:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41334 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935535AbeEIUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 16:05:43 -0400
X-Google-Smtp-Source: AB8JxZpcVEFAdICUmU4Pey3x0gRXCfRG4d+Z0e028xDg46GxosDMsdDA7D0FHaUDJ+1EtidtPJG5uw==
From: Douglas Anderson <dianders@chromium.org>
To: andy.gross@linaro.org
Cc: sboyd@kernel.org, tdas@codeaurora.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-soc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: sdm845: Fix xo_board clock name and speed
Date: Wed,  9 May 2018 13:05:28 -0700
Message-Id: <20180509200528.233451-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPMh clock driver assumes that the xo_board clock is named
"xo_board", not "xo-board".  Add a "clock-output-names" property to
the device tree to get the right name.

Also add the proper speed for the xo-clock as 38400000.  This is
internally divided in RPMh clock driver to get "bi_tcxo" at 19200000.

After this change the clock tree in /sys/kernel/debug/clk/clk_summary
looks much better.

NOTES:
- Technically you could argue that this clock could belong in board
  .dts files, not in the SoC one.  However at the moment it's believed
  that 100% of sdm845 boards will have an external clock at 38.4.  It
  can always be moved later if necessary.
- We could rename the "xo-board" device tree node to "xo_board" to
  achieve the same effect as this patch.  Presumably device-tree folks
  would rather keep node names using dashes though.
- We could change the RPMh clock driver to use a dash to achieve the
  same effect as this patch, but all other clocks in the clock tree
  use underscores.  It seems silly to change just this one.

Fixes: 7bafa643647f ("arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 486ace9a9e8b..4945f8cccd6c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -137,7 +137,8 @@
 		xo_board: xo-board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <19200000>;
+			clock-frequency = <38400000>;
+			clock-output-names = "xo_board";
 		};
 
 		sleep_clk: sleep-clk {
-- 
2.17.0.441.gb46fe60e1d-goog
