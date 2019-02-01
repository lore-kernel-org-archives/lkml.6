Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6AEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3785218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCz5E6SW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfBAMcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:32:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36080 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfBAMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:32:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so5321046edb.3;
        Fri, 01 Feb 2019 04:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mfx8EngpD21F4beHFI4xnlcyVYLWy3PUGs790NCYd/k=;
        b=gCz5E6SWpg5ROaHec2f+peOAT4i5hMwL2a/A5uflM6xGh5XlzG74/qBxJEzkbpK/bh
         yBunrUM9GPysUE2hXjiBFglv1LaP6zbudawQ6lPfl2ACnE5oTp1yS4t+Lc9oBbTDIYZq
         OoNgVCrXIPU1zz4jTurmieGnSdiYCdnAG5QniN2Ufa5RmGm/UJjkrrSy8K63vRLPmdV0
         hmd5US6Mcnrx6VEfORR8NUj71o4p5sW0VdhmwH0oQFS6hKoQtmOFNynqXd9fTohPpwkG
         x8T4KAu/vtLVMZAM0c1vkkOse/5DfjA79YxwO+StlzERDyXKZKrLFjJg/j0ispqNZqrQ
         Bkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mfx8EngpD21F4beHFI4xnlcyVYLWy3PUGs790NCYd/k=;
        b=Iuk/SN7aFnrRcj62eLr2HhwTJJ/UOsOl8vYdfLmtTyVMJJn/z08TzJCbmGEci2/Ee6
         wncuvFzI7hTzF5s9bLZp8tNS+aVC6Ayq7cg72gmcFKDCaI1V81WzTE4W29cU8f3lQcgq
         knqhujSoxOR8scv9aTYlP9qkvYDdhfePCuihpGnUXozFNhNTxUO5I895lRzqyZFIWYHi
         EPha0dznu+h234hDyvbH24odx8whtZo8wdJQnPRPmIB0LxZxF3AJOIb8Hgodm8vFh56Z
         lKlAgy41/g90JNh3+e8tYqc5WGf9Ks4e7lJ0/kUdCtqq2p2ZvtkKhAaHPasGKc0HaNov
         EHcg==
X-Gm-Message-State: AJcUukfyhreia7C39+M4w5ve3wBbUJw8mnVDb97g03BRCHEzXnFHXWlS
        UqikUPId9noTpo0JdxZ9CFY=
X-Google-Smtp-Source: ALg8bN6bAk2/kdTEEUEmQ5FKhX+c/OHqI4ZSEhFW/F1mKvzw3hnQ5hctz3KmYnK9gdfAXyc7SyJocQ==
X-Received: by 2002:a17:906:914a:: with SMTP id y10mr35335385ejw.124.1549024366907;
        Fri, 01 Feb 2019 04:32:46 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v6sm1221472eja.51.2019.02.01.04.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 04:32:46 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH] dt-bindings: display: rockchip: add document for rk3066 hdmi
Date:   Fri,  1 Feb 2019 13:32:35 +0100
Message-Id: <20190201123235.1693-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a binding that describes the HDMI controller for
rk3066.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../display/rockchip/rk3066_hdmi-rockchip.txt      | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
new file mode 100644
index 000000000..6a8f3754f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
@@ -0,0 +1,60 @@
+Rockchip specific extensions for rk3066 HDMI
+============================================
+
+Required properties:
+- compatible:
+	"rockchip,rk3066-hdmi";
+- reg:
+	Physical base address and length of the controller's registers.
+- clocks, clock-names:
+	Phandle to HDMI controller clock, name should be "hclk".
+- interrupts:
+	HDMI interrupt number.
+- power-domains:
+	Phandle to the RK3066_PD_VIO power domain.
+- rockchip,grf:
+	This soc uses GRF regs to switch the HDMI TX input between vop0 and vop1.
+- ports:
+	Contains one port node with two endpoints, numbered 0 and 1,
+	connected respectively to vop0 and vop1.
+- pinctrl-0, pinctrl-name:
+	Switch the iomux for the HPD/I2C pins to HDMI function.
+
+Example:
+	hdmi: hdmi@10116000 {
+		compatible = "rockchip,rk3066-hdmi";
+		reg = <0x10116000 0x2000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HDMI>;
+		clock-names = "hclk";
+		power-domains = <&power RK3066_PD_VIO>;
+		rockchip,grf = <&grf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
+		status = "disabled";
+
+		hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hdmi_in_vop0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&vop0_out_hdmi>;
+			};
+			hdmi_in_vop1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&vop1_out_hdmi>;
+			};
+		};
+	};
+
+&pinctrl {
+		hdmi {
+			hdmi_hpd: hdmi-hpd {
+				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
+			};
+			hdmii2c_xfer: hdmii2c-xfer {
+				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
+						<0 RK_PA2 1 &pcfg_pull_none>;
+			};
+		};
+};
-- 
2.11.0

