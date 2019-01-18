Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE6BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCA820652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="BUHZ7BoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfARN7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:59:46 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36896 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfARN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:59:45 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 398495C0690;
        Fri, 18 Jan 2019 14:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547819984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=zhxmiycYgyG17WJdlUxxh60xluR3cVATQp0GAWFoVH8=;
        b=BUHZ7BoGpc/DRdmvGPkEHpRmmT0hd47nYN6AzGfNZyxl3SSJQckqldzhuQmx7KYT2yGNil
        8wjHxb9PLrbse0Wg/ltD99bSOnOEesBV1NnJNcGciT0YjHIH/yBkiVVg4CuHId5e25Dnx2
        6cG6QM0mVuDn5sawSluZoDdgx6Ipar0=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        dev@pschenker.ch, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] ARM: dts: imx6q: add pmu interrupt-affinity
Date:   Fri, 18 Jan 2019 14:59:06 +0100
Message-Id: <20190118135907.2336-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly specify interrupt affinity to avoid HW perfevents
need to guess. This avoids the following error upon boot:
  hw perfevents: no interrupt-affinity property for /pmu, guessing.

Specifying all four CPUs shows no aversive effects on i.MX 6Dual
SoCs.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6q.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 8381d24eff7d..d2c1977c8b16 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -537,6 +537,13 @@
 			<0x28 0x0000000c>; /* DCIC2_MUX_CTL */
 };
 
+&pmu {
+	interrupt-affinity = <&{/cpus/cpu@0}>,
+			     <&{/cpus/cpu@1}>,
+			     <&{/cpus/cpu@2}>,
+			     <&{/cpus/cpu@3}>;
+};
+
 &vpu {
 	compatible = "fsl,imx6q-vpu", "cnm,coda960";
 };
-- 
2.20.1

