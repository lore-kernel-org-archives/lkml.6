Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546E0C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E622204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeLWKKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:10:52 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:17268 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLWKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 05:10:51 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBNAAUBL079349;
        Sun, 23 Dec 2018 19:10:30 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Sun, 23 Dec 2018 19:10:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from localhost.localdomain (183.38.232.153.ap.dti.ne.jp [153.232.38.183])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBNAARd8079332
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 23 Dec 2018 19:10:30 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] arm64: dts: rockchip: enable analog audio node for rock64
Date:   Sun, 23 Dec 2018 19:10:26 +0900
Message-Id: <20181223101026.12998-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rock64 boards has analog audio jack on it. RK3328 can output
analog audio signal using I2S1 and ACODEC core.

This patch adds sound node for analog audio for Rock64.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---

This patch depends on the following ACODEC node patch. If ACODEC
patch is not good to you, please drop this patch too.
  https://lkml.org/lkml/2018/12/23/53

 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index bd937d68ca3b..0a71e1287a1b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -66,7 +66,8 @@
 	sound {
 		compatible = "audio-graph-card";
 		label = "rockchip,rk3328";
-		dais = <&spdif_p0>;
+		dais = <&i2s1_p0
+			&spdif_p0>;
 	};
 
 	spdif-dit {
@@ -81,6 +82,17 @@
 	};
 };
 
+&codec {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	port@0 {
+		codec_p0_0: endpoint {
+			remote-endpoint = <&i2s1_p0_0>;
+		};
+	};
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_arm>;
 };
@@ -243,6 +255,19 @@
 	};
 };
 
+&i2s1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	i2s1_p0: port {
+		i2s1_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&codec_p0_0>;
+		};
+	};
+};
+
 &io_domains {
 	status = "okay";
 
-- 
2.19.2

