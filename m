Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7C1C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CFF2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CFF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbeLKEwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 23:52:25 -0500
Received: from muru.com ([72.249.23.125]:57268 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbeLKEwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 23:52:25 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2CF6680F0;
        Tue, 11 Dec 2018 04:52:27 +0000 (UTC)
Date:   Mon, 10 Dec 2018 20:52:20 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Message-ID: <20181211045220.GI6707@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181211 03:31]:
> 
> Hi Tony
> 
> > Here are two fixes that allow me to have multiple endpoints defined in
> > the dts file for audio-graph-card. To do that, we need to fix up few
> > issues as the graph binding Documentation/devicetree/bindings/graph.txt
> > allows multiple endpoints per port. This allows configuring TDM codecs
> > for I2S for example.
> > 
> > Kuninori-san, can you please check if this makes sense to you and
> > compare against the graph binding?
> 
> This looks a little bit strange for me.
> Can you show me your DT for it ?

Sure, adding also Sebastian to Cc. Here's what I currently have for droid 4
dts with two codecs on I2S. Please just ignore the GNSS parts there..

The TDM configuration is all done in the cpcap_audio_codec via set_tdm_slot().
The modem voice call codec is a serdev driver :) I'll need some more time to
be able to post patches but it's basically working for voice calls.

Regards,

Tony

8< ---------
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -653,6 +653,28 @@
 	pinctrl-0 = <&uart1_pins>;
 	interrupts-extended = <&wakeupgen GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0xfc>;
+
+	modem {
+		compatible = "motorola,mapphone-mdm6600-serdev";
+		phys = <&fsusb1_phy>;
+		phy-names = "usb";
+
+		mot_mdm6600_audio: audio-codec {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#sound-dai-cells = <1>;
+
+			port@0 {
+				mot_mdm6600_audio_codec0: endpoint {
+					remote-endpoint = <&cpu_dai_mdm>;
+				};
+			};
+		};
+
+		gnss {
+			compatible = "motorola,mapphone-mdm6600-gnss";
+		};
+	};
 };
 
 &uart3 {
@@ -746,12 +768,18 @@
 	status = "okay";
 
 	mcbsp3_port: port {
-		cpu_dai3: endpoint {
+		cpu_dai3: endpoint@0 {
 			dai-format = "dsp_a";
 			frame-master = <&cpcap_audio_codec1>;
 			bitclock-master = <&cpcap_audio_codec1>;
 			remote-endpoint = <&cpcap_audio_codec1>;
 		};
+		cpu_dai_mdm: endpoint@1 {
+			dai-format = "dsp_a";
+			frame-master = <&cpcap_audio_codec1>;
+			bitclock-master = <&cpcap_audio_codec1>;
+			remote-endpoint = <&mot_mdm6600_audio_codec0>;
+		};
 	};
 };
 
