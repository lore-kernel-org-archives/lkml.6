Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 09773C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41AD208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T2VRpVTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41AD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935535AbeFMRue (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:50:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39288 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935469AbeFMRu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:50:28 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so1630674pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=en6JlW/eubpEXwzzx51YdRdw0IRcV/N/RiaBflwTF8k=;
        b=T2VRpVTdRy+DeHsNo0DIgNDg8rcPYQ9nMGo1vRCIXqkQtYsId/HYChfoDHA+Ot+4Uw
         qlx7nB32meTPfVx8Lg5KNb8yIzpAbqlDeSELgI29Fq7aCnaCTL6tzGLFmTKvE0zk14vL
         Nn4C65VBikwsxLR/uoTljH4jLOOWED3UaTD5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=en6JlW/eubpEXwzzx51YdRdw0IRcV/N/RiaBflwTF8k=;
        b=huhTuGXRIn+kc7ajIP3Ub2N4JCgmSc0i57RO1Vfv6KP0mqSfP4LVLxp5acyYFhstgP
         w2Ci/viPTrTIzaEl76Q4XIMh6vG+rBJsXL54+m3/s196v8jP+Fb3GaQOkLUwHKByNhza
         4kLJXNVoGwpoV120tcbeNR9njT3SKkuEe3Z9pyoOuySv4i6vU06NdQ441bQp1lLTXND+
         Uce35YmK4SZAmSA2bvax7NwJ6gyb2YsYd+zexC53MH4qiUWOz1wyYSWdF0vpN0iEgdoU
         GP+CvtwooK7MfMpNImLB8nlEFsqNGIMLPu3IMiC9+kZxxDIx8YUspzkzh+CjTIlNN75g
         /4DQ==
X-Gm-Message-State: APt69E3oOqy9T5Z+GJUVlqdg7ncvzRvbYmnEC7lL4ys0vnM1vNfxZHZ9
        VaPf4qEVy+T8wUokDM4OGXbmlQ==
X-Google-Smtp-Source: ADUXVKI0TNpeaY+hAnYXeuwXHj1YesuDMmJJrThVUteqG3HmR2sY/V9KtEO9C5GtkKNEozq3BWclXA==
X-Received: by 2002:a63:ae43:: with SMTP id e3-v6mr4721554pgp.181.1528912228362;
        Wed, 13 Jun 2018 10:50:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id e68-v6sm6330778pfl.65.2018.06.13.10.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 10:50:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andy.gross@linaro.org, bjorn.andersson@linaro.org
Cc:     kramasub@codeaurora.org, wsa@the-dreams.de,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: qcom: Fix default clock-freq for qcom,geni-i2c
Date:   Wed, 13 Jun 2018 10:50:11 -0700
Message-Id: <20180613175011.217585-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an early version of the I2C patch that was posted to the list the
default I2C frequency (if none was specified) was 400 kHz.  There was
debate on the list and we decided that it would be more consistent
with the rest of i2c if we defaulted to 100 kHz.  ...but we never
updated the bindings.  Let's fix this.

NOTE: since the i2c driver itself hasn't actually landed yet and the
SoC here is very new it seems terribly unlikely that anyone was
relying on the old 400 kHz number, so I'll assume this is an OK
"incompatible" device tree change.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index d330c73de9a2..68b7d6207e3d 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -39,7 +39,7 @@ Required properties:
 
 Optional property:
 - clock-frequency:	Desired I2C bus clock frequency in Hz.
-			When missing default to 400000Hz.
+			When missing default to 100000Hz.
 
 Child nodes should conform to I2C bus binding as described in i2c.txt.
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

