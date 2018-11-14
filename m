Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9138722360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWED4Jlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9138722360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeKNTKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:10:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40461 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeKNTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:10:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so2030442pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wMyqG5pI89CV6L/8kIrcswRejq6Wasnn2q5PPPGYQHQ=;
        b=PWED4JltQZuViISB1WJMjPC5sXuvT1qCn/cpN0jSJrUClI9PUTCKikuXf9KwQmzlx0
         nFlqcXoxIw0gzP5yhJd9R6e2/OuJxKEkD15JU/cKX/VS7v5ji1r/V1uV4F/fXpdUVRJO
         LGuOxAmAKT61wiE1W2JN/pr6rUvb3YsE06eBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wMyqG5pI89CV6L/8kIrcswRejq6Wasnn2q5PPPGYQHQ=;
        b=URdWUhHquPqV7KIYopSxjltcv/7eKEnL7SFbVb6c21007DtoIaRO7bTwqPkOp1dmVz
         M7fcTwDtIelOxAOukYK9Ocfw62i8CtBlp9/jMW3fPCmi7MJx++gj8Z156hj3N0o2JQb/
         /c16QzPYxOxtsMVWSG1p/uorgd2ckJkqjaVZBGmSsZIRkrelV/dDYILj2MW+3v3XpOh/
         6xHciREsuj1FsPTyDkclzwlLNy5HKGhiYNllgZmzsHFPhVzIL8D+qvu+L4wWfFPpCCA0
         wBh1lLiz3jFV54ALdqeySwAp3Z+hkdmxAdYxKIMs3KQ9dOJdqxj7p2V7GZi/GPCP1L1A
         Uq+A==
X-Gm-Message-State: AGRZ1gJ9qULvOdbA2LVAGVeZz0f4a15GbZRnymdTjCprwx+4gE75N8eK
        2m1eRRmFI+QVle6ciGWbMZ4Wbg==
X-Google-Smtp-Source: AJdET5cu79RNj6Ak4SHHvr00KVWxSCFev4dOnqK6iHE4/gS4MmMQbQw/xfIt77uQTHlpaTIJWm2ykQ==
X-Received: by 2002:a17:902:110a:: with SMTP id d10-v6mr1097461pla.85.1542186466971;
        Wed, 14 Nov 2018 01:07:46 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 127-v6sm25048814pfx.91.2018.11.14.01.07.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 01:07:46 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 1/5] dt-bindings: power: supply: Add nvmem properties to calibrate FGU
Date:   Wed, 14 Nov 2018 17:07:04 +0800
Message-Id: <09143dca85a260cb6c3abc5efcf09075a8050265.1542185618.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvmem properties to calibrate FGU from eFuse controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
index 98a2400..fc35ac5 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -11,6 +11,8 @@ Required properties:
 - battery-detect-gpios: GPIO for battery detection.
 - io-channels: Specify the IIO ADC channel to get temperature.
 - io-channel-names: Should be "bat-temp".
+- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
+- nvmem-cell-names: Should be "fgu_calib".
 - monitored-battery: Phandle of battery characteristics devicetree node.
   See Documentation/devicetree/bindings/power/supply/battery.txt
 
@@ -47,6 +49,8 @@ Example:
 			battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
 			io-channels = <&pmic_adc 5>;
 			io-channel-names = "bat-temp";
+			nvmem-cells = <&fgu_calib>;
+			nvmem-cell-names = "fgu_calib";
 			monitored-battery = <&bat>;
 		};
 	};
-- 
1.7.9.5

