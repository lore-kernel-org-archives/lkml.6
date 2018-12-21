Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D1B21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l6jfWtW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbeLUQCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:02:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38167 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbeLUQCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:02:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so6227361wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0bZMELC53/x8lmD+PNUs3INXGEckOq2dahFVEILk4Y=;
        b=l6jfWtW8zw6HpCHInoVQo9lVhkWxNtmWdR9n+MN57AY5Usq7zyqeaBLrHrmPevHmMU
         brDqtNFgqL9aTvLdwaPO1J1yoxlHJopCYi5YRiTv39em/7R2W7vNIM+jrdVZZcwgZUaO
         N/Y8i/XbgHeXCOu6NWOZIhY+twYfpYcULOR/KwKLUat7AClGrzumtB+yhYT//SmoStB3
         L9kPyY9ma/MXtOL2QwYn5TnGJtQfuw9XZejOrPltK8zzS2j9KIwMxC0bqkFmyjmILkIz
         Qbudj8a8nLkX/uOGlre/gD7V5RLmOsfLS/zVIRKzbtrfJGj2/+c2CSajKI5qun+oORVc
         Oxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0bZMELC53/x8lmD+PNUs3INXGEckOq2dahFVEILk4Y=;
        b=KFDVSDdCT5ipx/2FvAhSTDlyOQkhP1TD3+eNLg7e99CcZxdkifapeyn+awSDCRxUkq
         125YrlgkAIiFcjAjh6zx5omeKOUqCd1avArVr4tidvFRwgkl2GOS34pPWZzeHg2z03Zg
         QZvO8QsA1evAA7qGssw7cJIGo/Zr8/vJsGv0WMaJGKBVtGx/9FP+niPQITwB1U9SI5T3
         lcw+Hp9qdzvp7lZczFX7Z2csAMbodMXMhrBLczwcLPgvf8s5zPrz9dc2G4nf8wA5Z4hV
         Jdfx03ACx9NXtn6SRQHG+Lde6VBbH+f3BpARwm9y/G6GvsKlFGHJacs5rW89J7gTiu3A
         u2qQ==
X-Gm-Message-State: AJcUukc6LdeEZmCh5d2ncHPeXMKdz3wTmb6N9ujHffhF0k4Ll5ouXswZ
        mgCCjHQWHonv3rBM0Z4V1xNWsQ==
X-Google-Smtp-Source: AFSGD/XcJFjdXUbsOUstk2t2ZUggTMRPjoYtpWM6g2Oicv9kaxsoqEqE4RdHniZ20c2sErVwk4FWQA==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr3327549wml.121.1545408168817;
        Fri, 21 Dec 2018 08:02:48 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y138sm13044021wmc.16.2018.12.21.08.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 08:02:48 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: clk: meson: add ao slow clock path ids
Date:   Fri, 21 Dec 2018 17:02:35 +0100
Message-Id: <20181221160239.26265-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221160239.26265-1-jbrunet@baylibre.com>
References: <20181221160239.26265-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CLKIDs for the slow clock generation path

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/dt-bindings/clock/axg-aoclkc.h  | 7 ++++++-
 include/dt-bindings/clock/gxbb-aoclkc.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/axg-aoclkc.h b/include/dt-bindings/clock/axg-aoclkc.h
index 61955016a55b..8ec4a269c7a6 100644
--- a/include/dt-bindings/clock/axg-aoclkc.h
+++ b/include/dt-bindings/clock/axg-aoclkc.h
@@ -21,6 +21,11 @@
 #define CLKID_AO_SAR_ADC_SEL	8
 #define CLKID_AO_SAR_ADC_DIV	9
 #define CLKID_AO_SAR_ADC_CLK	10
-#define CLKID_AO_ALT_XTAL	11
+#define CLKID_AO_CTS_OSCIN	11
+#define CLKID_AO_32K_PRE	12
+#define CLKID_AO_32K_DIV	13
+#define CLKID_AO_32K_SEL	14
+#define CLKID_AO_32K		15
+#define CLKID_AO_CTS_RTC_OSCIN	16
 
 #endif
diff --git a/include/dt-bindings/clock/gxbb-aoclkc.h b/include/dt-bindings/clock/gxbb-aoclkc.h
index 9d15e2221fdb..ec3b26319fc4 100644
--- a/include/dt-bindings/clock/gxbb-aoclkc.h
+++ b/include/dt-bindings/clock/gxbb-aoclkc.h
@@ -63,5 +63,12 @@
 #define CLKID_AO_UART2		4
 #define CLKID_AO_IR_BLASTER	5
 #define CLKID_AO_CEC_32K	6
+#define CLKID_AO_CTS_OSCIN	7
+#define CLKID_AO_32K_PRE	8
+#define CLKID_AO_32K_DIV	9
+#define CLKID_AO_32K_SEL	10
+#define CLKID_AO_32K		11
+#define CLKID_AO_CTS_RTC_OSCIN	12
+#define CLKID_AO_CLK81		13
 
 #endif
-- 
2.19.2

