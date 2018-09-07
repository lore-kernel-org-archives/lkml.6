Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4259AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9052083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeXIvrcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9052083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeIHASX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:18:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35708 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHASW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:18:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so12321803edq.2;
        Fri, 07 Sep 2018 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjG9Rua9PjtNDZA9o8UjHp0B10LXAYiHlUkwS/ungZE=;
        b=VeXIvrcY1iGs28MhTgVRTdWjIALLvoggQCXxYN+sPPzrBgfxA06DkJS03GoeHorefU
         xW9WhTZaJUdzAypzOwTOxTROG+qlG3qFx5k3bxUr8WR+iSS99gA1nwCAhzOIZ/mRXIa5
         LFPFVCZ7J8STW4jQROVpM8HDngineWe/Z/lmXUio6R1YO+n24pw9Ebi+wP4Lry49iuW2
         NqdbalOdM19yEt8vaGv9jzyHL+CVQBQEs1nUcNDBt0EgtwLDwCH40BCTPT6goQ8Oz+wi
         H826TdFGLRpKmpo9uuy0dy2YwxWj6FEoqpNzf9f2fhZlihSKugiWG+j6ytB1SDBoK80l
         7vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vjG9Rua9PjtNDZA9o8UjHp0B10LXAYiHlUkwS/ungZE=;
        b=Zl3y1FnycdssUVWdoVnGMu95ojjS09Fq0uS9bIcwZX87BC1Q6Wl3GdNlhOKCFP79Uy
         jA4dv7aPtKLk4b//ER2S/JDdp+Sig7GqaXgCqN474v/ZivCsvrMGuSeX52BN3swkSgBO
         N6wGnubaXz5Tu/+fQzBXfFBD8kY0KNHIn9qKq+BQi8Si8/0+j1B7ELDv/zB197IX3cYh
         Umpp6r9GQWaCHkiDJ+Nmpm5mCLm86MEuUahLwQIPCNYs2B/syaBcuWPC7KNmC9pmoV/t
         gL4MBXwrRjylfAuriIYm+hDcvQCS/7AxHKvwMYVaLbJOSUwH1jo0ttki5d6B0pj562Fr
         fgFg==
X-Gm-Message-State: APzg51Ciu/6CCT1RnEat3D/nvXJe40vGMFr/gpXQGPjs8gjIabDmxr8f
        Z8Ut+yfciAyuDkmMaWUm+Ec=
X-Google-Smtp-Source: ANB0Vdb/rkUElnESsakifaDqMbQQPAgSv1F9FmFudu7Am9Ozt/XiM3/H/WfQPnfiiNkV9NDMt19R1w==
X-Received: by 2002:a50:8ad1:: with SMTP id k17-v6mr10444525edk.36.1536348957067;
        Fri, 07 Sep 2018 12:35:57 -0700 (PDT)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h34-v6sm4868808eda.58.2018.09.07.12.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:35:56 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 1/5] dt-binding: rtci-pcf8523: add quartz_load property
Date:   Fri,  7 Sep 2018 21:35:04 +0200
Message-Id: <20180907193508.24974-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180822183555.GA24084@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Søren Andersen <san@skov.dk>

The NXP pcf8523 supports two different quartz loads.
- 7 pF (default)
- 12.5 pF (minimum power consumption)

The pcf8523 needs to know the size of the quartz load,
otherwise the the RTC will have a bad precision.

The default for the rtc (after power-on) is 7 pF.
Add a property that tells if the external capacitor is 12.5 pF.

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 19 +++++++++++++++++++
 Documentation/devicetree/bindings/trivial-devices.txt |  1 -
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
new file mode 100644
index 000000000000..7c5e93f5077c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
@@ -0,0 +1,19 @@
+* NXP PCF8523 Real Time Clock
+
+NXP PCF8523 Real Time Clock
+
+Required properties:
+- compatible: Should contain "nxp,pcf8523".
+- reg: I2C address for chip.
+
+Optional property:
+- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
+  which differ from the default value of 7 pF
+
+Example:
+
+pcf8523: pcf8523@68 {
+	compatible = "nxp,pcf85063";
+	reg = <0x68>;
+	nxp,quartz_load_12.5pF;
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a2808a95c..297dc82b67ad 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -169,7 +169,6 @@ nxp,pca9556		Octal SMBus and I2C registered interface
 nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
-nxp,pcf8523		Real-time Clock
 nxp,pcf8563		Real-time clock/calendar
 nxp,pcf85063		Tiny Real-Time Clock
 oki,ml86v7667		OKI ML86V7667 video decoder
-- 
2.12.0

