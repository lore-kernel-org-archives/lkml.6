Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CBEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C89C208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnkDseuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C89C208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeGLES3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:18:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35281 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeGLES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:18:29 -0400
Received: by mail-qt0-f193.google.com with SMTP id a5-v6so8514900qtp.2;
        Wed, 11 Jul 2018 21:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0i/a7hohkamMfjqSB6ydaqvPxi7Q8yL72rrcO2IBuu4=;
        b=BnkDseuu1RFrRZmdy5U9+0hWmVPaRLOApKE/wo4AQ5X9PvY7CgIyUNz1X2+HJQ/Cbf
         Iu6OwZ4HcUrzUaKRCDmVQoFAe/MGNV5u4W9yYrw3IvjpmRkYG2ttjTjpARy1i5Yf+WQL
         j/qRNTz20XKYMLUbtPSAdp3f2HrAxh5MwglrtLKeaKoJGkY/EiZA/UVawMlzThVk20hG
         QJSz7uBJtQF413M+XcYl0QO2pTV4sHGvCnWWIXrOWWPcM/sdecaLpDsY2/zLd4scdWta
         PYYcf8WRo5G4b81uF9VjaH3SQkcUlHGwLfRXNWY0j5BsLLbWIp82c+tKqb1tlh4jxyTg
         VKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0i/a7hohkamMfjqSB6ydaqvPxi7Q8yL72rrcO2IBuu4=;
        b=Plr2AMseUTbou305bQETIS3/oEu3lEsMr2UVxEgt+ejBN9ecHikUVcujAvskHhQaPM
         lg3TNMnXTkda+uqemJoogJMzvl3ewg8uJRT3a1VnHKNGnSiGUg5Am6bAkaSKoUkApkNq
         GfmBIsPd7NoiDSJSpHBk7xuXAGpIwFWsufSGKzi0fgrcvx9LUEOQwRDmyLRPOscQLF8K
         hQarrMHoAjEUg505X3DcLHSOmQYXiuMcSALzT3DL8OLOJUZNuOb6Zl+c7mOTCXtVNADK
         9tmDTD0TucExbKGz6eYgvLujXf5U+TbHXg+hsQfEi6R9FcmsRIyv1CvlxoSgZefPLVc+
         1tfw==
X-Gm-Message-State: AOUpUlGHy5nzDm6EJr0O1DxwMlRHrKeVljpP1WfhIkivG7CTLpBS4fTx
        ZBiod7ozGDy1BRgGyrqn0Tk=
X-Google-Smtp-Source: AAOMgpfP6wUNALxm+P+NHZ35hWKY30mdf/6DDt7HS6nVJpv641oE6yrdCH8Usx3Z3NjVDNXDKIPXCw==
X-Received: by 2002:ac8:19db:: with SMTP id s27-v6mr485692qtk.215.1531368649408;
        Wed, 11 Jul 2018 21:10:49 -0700 (PDT)
Received: from localhost.localdomain (186-106-119-105.baf.movistar.cl. [186.106.119.105])
        by smtp.gmail.com with ESMTPSA id m51-v6sm7260115qtc.85.2018.07.11.21.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 21:10:49 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v3 1/6] arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed boards
Date:   Thu, 12 Jul 2018 00:10:19 -0400
Message-Id: <20180712041024.20583-2-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both boards are made by Avnet, Inc. So add an additional
value to the compatible property

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-microzed.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index aa4a0b6defb8..574ef2276182 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq MicroZED Development Board";
-	compatible = "xlnx,zynq-microzed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-microzed", "xlnx,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 53c6883ce1f6..595022487965 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq Zed Development Board";
-	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-zed", "xlnx,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
-- 
2.18.0

