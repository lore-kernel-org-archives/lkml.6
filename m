Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EF92082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBEK0eyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EF92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeLELTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:19:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46405 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLELTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:19:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so21728504qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8CHfiRwxEDOflDsQ1UB4C3wvULIvrMVzWwFsjRMLPAQ=;
        b=WBEK0eyfX09plNYhK++Zga/wk11dSY0KVQOOVuoZE7j6Vd1ayw9QaLxIG94CIsSCYO
         /nAuZnrEAJcrTFRiw8CSSMMZeu48sRhbekzIRQsgoF/Rqn40EeGrkuv+smTXG+mYaGfm
         6hFInu5St5kQRFiq6uujHCzntYHPhX63kKELynEvxawGr30Bvd78yOkUw3aqVD71Nk5r
         z3By8DHiiWzEwMx0kAdP4qt13PPyo+RXhfu0i2LxX7xd0RutHe7P8QyKeUDUTTOqqgRu
         ihXHVckipdKO6kOx0x3Vm8r2rCeJzKmMMZ+qr/fbkbL5Sx9+iv0eVsXs8uH6bgK8rHxO
         4Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8CHfiRwxEDOflDsQ1UB4C3wvULIvrMVzWwFsjRMLPAQ=;
        b=V2yNKNJ3aQcOlxSCFvaCWFZ8nL8kyE1krFHWQtsoMh8o9M6ewhOVuuErZ9HBDePuCX
         ynkGPHGCK4pAk3NLb/9fZbjH6dqjzqSEIElCQpNy0MQT3ylvea+XIPIo85ohMRXCNHB1
         NJ16D5E7ovJmAzQfjoB8jOtzrk/y58U2Nv6zzvSoaucapWFzXwVy7N0zN1JlSnhZQUko
         QWYWnHzfhRFZ326X3wvvbw/fUumkb5X8tyEW1PK3aoiMfIQrF4eovWE4z2TVfrpYOKvJ
         hNTXSqJ/u31Swylhf6ZjfBNbWhxQPDwHFpN5kbYixV+EROfWwxvgpgH8oWBJd9DN0RGq
         EVHg==
X-Gm-Message-State: AA+aEWavagy1wFOpEePhZIxMqgKELUXI7pIks/mzizGT/3WGlUfGBtOu
        HkOtilVV1lFtJdY0vig5X/4=
X-Google-Smtp-Source: AFSGD/WfcnxquOLZm7fHFspCBRjIkrlKZ5wZ0EA4ErshlCdu3tKPo8xT1HezNHepvoClrIaBvH/zFg==
X-Received: by 2002:a0c:c993:: with SMTP id b19mr22225456qvk.126.1544008769237;
        Wed, 05 Dec 2018 03:19:29 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
        by smtp.gmail.com with ESMTPSA id k62sm9960189qte.86.2018.12.05.03.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 03:19:28 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     cphealy@gmail.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ARM: dts: vf610-zii-scu4-aib: Add HI8435 support
Date:   Wed,  5 Dec 2018 09:19:35 -0200
Message-Id: <1544008775-24128-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the vf610-zii-scu4-aib board there is a hi8435 (32-channel
discrete-to-digital SPI sensor device) in the DSPI0 bus.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Chris Healy <cphealy@gmail.com>
---
Changes since v1:
- Put status as the last propert
- Use a generic node name

 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index 52bac14..de6dfa5 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -397,6 +397,20 @@
 	};
 };
 
+&dspi0 {
+	pinctrl-0 = <&pinctrl_dspi0>;
+	pinctrl-names = "default";
+	bus-num = <0>;
+	status = "okay";
+
+	adc@5 {
+		compatible = "holt,hi8435";
+		reg = <5>;
+		gpios = <&gpio5 3 GPIO_ACTIVE_HIGH>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
 &dspi1 {
 	bus-num = <1>;
 	pinctrl-names = "default";
-- 
2.7.4

