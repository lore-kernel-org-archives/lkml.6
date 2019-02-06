Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC962080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBFPUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:20:48 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:50822 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBFPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:20:48 -0500
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x16FKXHe048702;
        Thu, 7 Feb 2019 00:20:33 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Thu, 07 Feb 2019 00:20:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x16FKUuc048692
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 7 Feb 2019 00:20:33 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add HDMI sound node for rk3328-rock64
Date:   Thu,  7 Feb 2019 00:20:27 +0900
Message-Id: <20190206152027.8002-2-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206152027.8002-1-katsuhiro@katsuster.net>
References: <20190206152027.8002-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds HDMI sound (I2S0) node and remove dma properties
from UART2 node for rock64.

The DMAC of rk3328 connected to 16 DMA sources. Each sources have ID
number that is called 'Req number' in rk3328 TRM. Currently, total
7 sources has been activated as follows:

| Req number | Source | Required  |
|            |        | channels  |
|------------+--------+-----------|
| 14, 15     | I2S1   | 2ch       |
|  6,  7     | UART2  | 2ch       |
|     10     | SPDIF  | 1ch       |
|  8,  9     | SPI0   | 2ch       |
|------------+--------+-----------|
|            | Total  | 7ch       |

HDMI audio needs to activate new source I2S0 (Req number 11 and 12).
I2S0 can work concurrently with other sources, but rk3328 DMAC can
use max 8 channels at same time. If I2S0 is simply activated,
required DMAC channels are 9. It does not work.

UART2 can work without DMA resources, so this patch removes 2 DMA
channel allocation for UART2. These released channels can be used
for I2S0.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 2157a528276b..e21645aa3fa5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -68,7 +68,8 @@
 	sound {
 		compatible = "audio-graph-card";
 		label = "rockchip,rk3328";
-		dais = <&i2s1_p0
+		dais = <&i2s0_p0
+			&i2s1_p0
 			&spdif_p0>;
 	};
 
@@ -141,6 +142,12 @@
 
 &hdmi {
 	status = "okay";
+
+	port@0 {
+		hdmi_p0_0: endpoint {
+			remote-endpoint = <&i2s0_p0_0>;
+		};
+	};
 };
 
 &hdmiphy {
@@ -256,6 +263,18 @@
 	};
 };
 
+&i2s0 {
+	status = "okay";
+
+	i2s0_p0: port {
+		i2s0_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&hdmi_p0_0>;
+		};
+	};
+};
+
 &i2s1 {
 	status = "okay";
 
@@ -343,6 +362,9 @@
 
 &uart2 {
 	status = "okay";
+
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
 };
 
 &u2phy {
-- 
2.20.1

