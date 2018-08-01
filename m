Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D937EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD4A20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD4A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405013AbeHATFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:05:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403817AbeHATFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:05:19 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4E7ECC6;
        Wed,  1 Aug 2018 17:18:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nguyen Viet Dung <nv-dung@jinso.co.jp>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 136/246] arm64: dts: renesas: salvator-common: use audio-graph-card for Sound
Date:   Wed,  1 Aug 2018 18:50:46 +0200
Message-Id: <20180801165018.244151303@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 06a574c7ef69bd0bd26ed08e35967acb76622ab3 ]

Current Sound is using simple-audio-card which can't support HDMI.
To use HDMI sound, we need to use audio-graph-card.
But, one note is that r8a7795 has 2 HDMI ports, but r8a7796 has 1.
Because of this mismatch, supporting HDMI on salvator-common is
impossible.
Thus, this patch exchange sound card to audio-graph-card and keep
supporting ak4613 as 1st sound node.
r8a7795/r8a7796 salvator-x{s} need to add HDMI sound individually.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |   38 +++++++++++++----------
 1 file changed, 22 insertions(+), 16 deletions(-)

--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -93,20 +93,12 @@
 		regulator-always-on;
 	};
 
-	rsnd_ak4613: sound {
-		compatible = "simple-audio-card";
+	sound_card: sound {
+		compatible = "audio-graph-card";
 
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcpu>;
-		simple-audio-card,frame-master = <&sndcpu>;
+		label = "rcar-sound";
 
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&ak4613>;
-		};
+		dais = <&rsnd_port0>;
 	};
 
 	vbus0_usb2: regulator-vbus0-usb2 {
@@ -320,6 +312,12 @@
 		asahi-kasei,out4-single-end;
 		asahi-kasei,out5-single-end;
 		asahi-kasei,out6-single-end;
+
+		port {
+			ak4613_endpoint: endpoint {
+				remote-endpoint = <&rsnd_endpoint0>;
+			};
+		};
 	};
 
 	cs2000: clk_multiplier@4f {
@@ -538,10 +536,18 @@
 		 <&audio_clk_c>,
 		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
 
-	rcar_sound,dai {
-		dai0 {
-			playback = <&ssi0 &src0 &dvc0>;
-			capture  = <&ssi1 &src1 &dvc1>;
+	ports {
+		rsnd_port0: port@0 {
+			rsnd_endpoint0: endpoint {
+				remote-endpoint = <&ak4613_endpoint>;
+
+				dai-format = "left_j";
+				bitclock-master = <&rsnd_endpoint0>;
+				frame-master = <&rsnd_endpoint0>;
+
+				playback = <&ssi0 &src0 &dvc0>;
+				capture  = <&ssi1 &src1 &dvc1>;
+			};
 		};
 	};
 };


