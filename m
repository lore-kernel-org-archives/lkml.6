Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B83CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16F9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544088;
	bh=cKlsRjBtTO0tdrvWu8as5ASsT5xD2cy5isI8ooG6Tak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iht7RHKdwUpixbuaIrjPR+0+Wk26MaXHxmpWcMD17AXXMmylHB8hFDSKAmvulQiTH
	 h+efaPnLPAIHbI+COmcwHqEJl3rX4pB4cCoxsJ2nyHV7QDp4XlD0sN1k/Ln6APFMY/
	 +ro8QoW9SrR+o3Cy/qMX7QaK6fEMJ3MxlOCv3XAU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16F9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbeLKP5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbeLKP5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DE420855;
        Tue, 11 Dec 2018 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543856;
        bh=cKlsRjBtTO0tdrvWu8as5ASsT5xD2cy5isI8ooG6Tak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7kLosV8Uo5C/8Uiyl1lIg8/J3E+7xNw5SDlsR8RHGiWGzL596ekDB0AHZvtEgLUb
         2IERCrQMF+3EWs4aaIbU9f1qbMGRQ6Nvp0vFejHL03lktgT9KD7P+MnWx0Z+PjKpOu
         aRexDmCM2/ncTAt6w6aVRS40zK74hFqzFG78TSpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/118] arm64: dts: rockchip: remove vdd_log from rock960 to fix a stability issues
Date:   Tue, 11 Dec 2018 16:41:50 +0100
Message-Id: <20181211151647.941975738@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 13682e524167cbd7e2a26c5e91bec765f0f96273 ]

When the performance governor is set as default, the rock960 hangs
around one minute after booting, whatever the activity is (idle, key
pressed, loaded, ...).

Based on the commit log found at https://patchwork.kernel.org/patch/10092377/

"vdd_log has no consumer and therefore will not be set to a specific
voltage. Still the PWM output pin gets configured and thence the vdd_log
output voltage will changed from it's default. Depending on the idle
state of the PWM this will slightly over or undervoltage the logic supply
of the RK3399 and cause instability with GbE (undervoltage) and PCIe
(overvoltage). Since the default value set by a voltage divider is the
correct supply voltage and we don't need to change it during runtime we
remove the rail from the devicetree completely so the PWM pin will not
be configured."

After removing the vdd-log from the rock960's specific DT, the board
does no longer hang and shows a stable behavior.

Apply the same change for the rock960 by removing the vdd-log from the
DT.

Fixes: 874846f1fccd ("arm64: dts: rockchip: add 96boards RK3399 Ficus board")
Cc: stable@vger.kernel.org
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
[sl: adjust filename for 4.19]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index 8978d924eb83..85cf0b6bdda9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -75,18 +75,6 @@
 		regulator-always-on;
 		vin-supply = <&vcc_sys>;
 	};
-
-	vdd_log: vdd-log {
-		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 0>;
-		regulator-name = "vdd_log";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
 };
 
 &cpu_l0 {
-- 
2.19.1



