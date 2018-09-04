Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC5C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1635206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElU/KFdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1635206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIDOwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:52:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40549 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeIDOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:52:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so3687394wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+PVCKznci0AHT6i8Z02ot2xaPHWn52lA5413+yAK5nQ=;
        b=ElU/KFdwiv+VEO8+hgqr6As7g+5FOuYecqHjOuRmQjppkJK3ae3dkSWMps4ZjM8VDp
         D2x6BZAHLCBqD+KWGneMLlIkdD9ToVfmBK7AJ2hQiLxluxSd+WsQ+TehpETmjyVlbMk3
         M7MugfHjdNpse2lIv6LM/kL15/mB6H2SnFCn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+PVCKznci0AHT6i8Z02ot2xaPHWn52lA5413+yAK5nQ=;
        b=Cb93o4PMGToIwq68ePuGE5O3gecPs6UQAyxjsMKbFdJhRCYKGPp0bIs3EFg58SmUdd
         hyYzoh1UrVkibB4kzVyc6Ulf3ibrH0QllOkSAm8zcjBM16cxMwDzla1If+wDE2yHE8pS
         bFBm9zaZ5QVo+Lll6ezkvRkna5KyOUzzIGLMCwCYJ6JdZo7gYD0h+rWO6nIWKCtR+dj4
         iMi9dBCZD82HfSWM13XQpHN7qUtKKqvbAkRfwTnZ9bHsmSF/iQOWn7ZINoeNQSVOY7yD
         kQ5Ucu/RSx8rqyFkXv/a50WowUniugmkCCZQNzso/lxyu04Zar8cwxInOhAO6OPeUEZE
         D/Ig==
X-Gm-Message-State: APzg51AWUwHBqeozOSBltWfYCUOjcKHV79mn6fpVtNsYupm02U8eKEoJ
        hl+8HkhIxiI7e7LLPBmuxie8Mg==
X-Google-Smtp-Source: ANB0VdZZUAHey2wpMEwyBOypdJwJc4QgdKmdwZJWD8WAlpVyPLSPAbjE2ewk9PEN6msw9YImoX3bEA==
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr1935562wmd.45.1536056863739;
        Tue, 04 Sep 2018 03:27:43 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id g129-v6sm16903325wmf.42.2018.09.04.03.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:27:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 10/13] ASoC: dt-bindings: Add WCD9335 MBHC specific properties
Date:   Tue,  4 Sep 2018 11:24:57 +0100
Message-Id: <20180904102500.30318-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add new bindings required to support MBHC
(Multi Button Headset Control) block in the codec.
This block is used for jack insert/removal detection,
headset type detection and 8 button press/release events.

All these properties are very much specific to board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wcd9335.txt           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 5d6ea66a863f..4d56c3ca9fa8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -55,6 +55,26 @@ Required properties with SLIMbus Interface:
 	Value type: <string>
 	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
 
+- qcom,mbhc-vthreshold:
+	Usage: Optional, only required if headset button support required.
+	Value type: <u32 array>
+	Definition: Must contain an array of 8 threshold voltages in mV for
+		 8 buttons detection on headset.
+
+- qcom,hphl-jack-type-normally-open:
+	Usage: Optional, only required if headset button support required.
+	Value type: <boolean>
+	Definition: present if hphl pin on jack is a NO (Normally Open).
+		If not specified, then its assumed that hphl pin on jack
+		is NC (Normally Closed).
+
+- qcom,gnd-jack-type-normally-open:
+	Usage: Optional, only required if headset button support required.
+	Value type: <boolean>
+	Definition: present if gnd pin on jack is NO (Normally Open).
+		 If not specified, then its assumed that gnd pin on
+		 jack is NC  (Normally Closed).
+
 - vdd-buck-supply:
 	Usage: required
 	Value type: <phandle>
-- 
2.18.0

