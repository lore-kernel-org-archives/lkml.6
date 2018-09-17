Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25215ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A6B214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A6B214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeIQRy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:54:28 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:33368 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbeIQRy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:54:27 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8HCQeHE074486;
        Mon, 17 Sep 2018 21:26:40 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Mon, 17 Sep 2018 21:26:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from localhost.localdomain (239.166.151.153.ap.dti.ne.jp [153.151.166.239])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8HCQZ52074459
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 17 Sep 2018 21:26:40 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2] arm64: dts: rockchip: add spdif sound node for rock64
Date:   Mon, 17 Sep 2018 21:26:33 +0900
Message-Id: <20180917122633.31401-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds sound card node for rock64. Currently we can support
S/PDIF only. It seems the lack of codec driver of rk3328 to enable
analog audio out.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5852061e497b..9ee4f57557f3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -62,6 +62,23 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "rockchip,rk3328";
+		dais = <&spdif_p0>;
+	};
+
+	spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port {
+			dit_p0_0: endpoint {
+				remote-endpoint = <&spdif_p0_0>;
+			};
+		};
+	};
 };
 
 &cpu0 {
@@ -261,6 +278,18 @@
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-0 = <&spdifm0_tx>;
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	spdif_p0: port {
+		spdif_p0_0: endpoint {
+			remote-endpoint = <&dit_p0_0>;
+		};
+	};
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <0>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.18.0

