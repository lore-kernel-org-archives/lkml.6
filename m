Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6D7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9FA217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866267;
	bh=kj3o1FX3f7dIHo7fM9/39UdgPQQt5P4SkaMf22cBrs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R0OokNLWiAy0gsPD5QDqJ5MIH/kgGzsWF2RMMUZRArTI39k/pczOLLlo6KEha75UU
	 Tdsdg2Zxzjim1Ke/638SnPNGW+l73Dsc1eB3CpgShJmj2yaelfYW21Tg8RMWCz7bQL
	 Hp095A783pjd0yYVgWwj+BImbB8D105fXFbl6HMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfAGNE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731367AbfAGNEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D832089F;
        Mon,  7 Jan 2019 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866262;
        bh=kj3o1FX3f7dIHo7fM9/39UdgPQQt5P4SkaMf22cBrs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O80fAtwvOKOdeuplleaUCQdQTcJOegOAi8y3zgcKzqpXlu8vNI6HYt1LYcJ9qjNIr
         3JnFPHCpVWU6blHNf7XanbQwhrdILhChnh3xkpwHdxxzF/PGEYLhgQuiB35PkDvsKt
         CptMrFUV5yYgh7F1Brc0vupVpC0gLaDL9Pcn4GQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 101/101] ARM: dts: exynos: Specify I2S assigned clocks in proper node
Date:   Mon,  7 Jan 2019 13:33:29 +0100
Message-Id: <20190107105338.234917895@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

commit 8ac686d7dfed721102860ff2571e6b9f529ae81a upstream.

The assigned parent clocks should be normally specified in the consumer
device's DT node, this ensures respective driver always sees correct clock
settings when required.

This patch fixes regression in audio subsystem on Odroid XU3/XU4 boards
that appeared after commits:

commit 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")
commit 995e73e55f46 ("ASoC: samsung: i2s: Fix rclk_srcrate handling")
commit 48279c53fd1d ("ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access")

Without this patch the driver gets wrong clock as the I2S function clock
(op_clk) in probe() and effectively the clock which is finally assigned
from DT is not being enabled/disabled in the runtime resume/suspend ops.

Without the above listed commits the EXYNOS_I2S_BUS clock was always set
as parent of CLK_I2S_RCLK_SRC regardless of DT settings so there was no issue
with not enabled EXYNOS_SCLK_I2S.

Cc: <stable@vger.kernel.org> # 4.17.x
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index 03611d50c5a9..e84544b220b9 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -26,8 +26,7 @@
 			"Speakers", "SPKL",
 			"Speakers", "SPKR";
 
-		assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>,
-				<&clock CLK_MOUT_EPLL>,
+		assigned-clocks = <&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MOUT_USER_MAU_EPLL>,
 				<&clock_audss EXYNOS_MOUT_AUDSS>,
@@ -36,8 +35,7 @@
 				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
 				<&clock_audss EXYNOS_DOUT_I2S>;
 
-		assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>,
-				<&clock CLK_FOUT_EPLL>,
+		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
 				<&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MAU_EPLL>,
@@ -48,7 +46,6 @@
 				<0>,
 				<0>,
 				<0>,
-				<0>,
 				<196608001>,
 				<(196608002 / 2)>,
 				<196608000>;
@@ -84,4 +81,6 @@
 
 &i2s0 {
 	status = "okay";
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
 };
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 4a30cc849b00..122174ea9e0a 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -33,8 +33,7 @@
 		compatible = "samsung,odroid-xu3-audio";
 		model = "Odroid-XU4";
 
-		assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>,
-				<&clock CLK_MOUT_EPLL>,
+		assigned-clocks = <&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MOUT_USER_MAU_EPLL>,
 				<&clock_audss EXYNOS_MOUT_AUDSS>,
@@ -43,8 +42,7 @@
 				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
 				<&clock_audss EXYNOS_DOUT_I2S>;
 
-		assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>,
-				<&clock CLK_FOUT_EPLL>,
+		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
 				<&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MAU_EPLL>,
@@ -55,7 +53,6 @@
 				<0>,
 				<0>,
 				<0>,
-				<0>,
 				<196608001>,
 				<(196608002 / 2)>,
 				<196608000>;
@@ -79,6 +76,8 @@
 
 &i2s0 {
 	status = "okay";
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
 };
 
 &pwm {


