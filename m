Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F91208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="vwJVlTVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfARN7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:59:50 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36908 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfARN7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:59:46 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 631065C1762;
        Fri, 18 Jan 2019 14:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547819984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtrJNYPEiZir795tmif5LYJPP7L4fS6d11YP/Uv0kv0=;
        b=vwJVlTVWgn9lqJVrybY7+ud3mPUXE9yuB/mvQH9j/nrXZesgBCfYjEwkY6Rx4SAxf84/L/
        1nD0yAoTFsIe6CqYAwcVaCbwdy7aqOxAfFyXG5ABOPkGPYz5gSHIWQQXm1Yrj/WIZCPeKX
        ph+FzGCzBj8Z88yGEFAdvtrG+wnKHd8=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        dev@pschenker.ch, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] ARM: dts: imx6dl: add pmu interrupt-affinity
Date:   Fri, 18 Jan 2019 14:59:07 +0100
Message-Id: <20190118135907.2336-2-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118135907.2336-1-stefan@agner.ch>
References: <20190118135907.2336-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly specify interrupt affinity to avoid HW perfevents
need to guess. This avoids the following error upon boot:
  hw perfevents: no interrupt-affinity property for /pmu, guessing.

Specifying all four CPUs shows no aversive effects on i.MX 6Solo
SoCs.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts | 4 ++++
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts | 4 ++++
 arch/arm/boot/dts/imx6dl.dtsi          | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
index 9eb2ef17339c..f1606f63d687 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
@@ -68,3 +68,7 @@
 		MX6QDL_PAD_SD3_CMD__GPIO7_IO02		0x170b0 /* SD1 CD */
 	>;
 };
+
+&pmu {
+	interrupt-affinity = <&{/cpus/cpu@0}>;
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
index a5532ecc18c5..b3bf1f80aff0 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
@@ -84,3 +84,7 @@
 		>;
 	};
 };
+
+&pmu {
+	interrupt-affinity = <&{/cpus/cpu@0}>;
+};
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index f0607eb41df4..3c8b533b3039 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -386,6 +386,11 @@
 			<0x28 0x0000000c>; /* DCIC2_MUX_CTL */
 };
 
+&pmu {
+	interrupt-affinity = <&{/cpus/cpu@0}>,
+			     <&{/cpus/cpu@1}>;
+};
+
 &vpu {
 	compatible = "fsl,imx6dl-vpu", "cnm,coda960";
 };
-- 
2.20.1

