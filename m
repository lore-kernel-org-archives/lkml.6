Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A072087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FiNDwDf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A072087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeIJU6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:58:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40547 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbeIJU63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:58:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id s13-v6so10698933pfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9v+SdcrhUYluLoY69mPdaMFx4Nogh2CsYFNID8uJf0w=;
        b=FiNDwDf1JMlDHmHAHYY4azmApZonf5/yelBqI8R8MbocyWc0PdLntJRfCVhyMsevFg
         kXLHgy4aH1G+GYbxPD+u5OAOHDnBjGu0csCy3NX1IK2x4UUxQcO51RjS73Skj43BRVtw
         2y59EITjLfkxJC4UXgybW0+UyToiFCPaNsNDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9v+SdcrhUYluLoY69mPdaMFx4Nogh2CsYFNID8uJf0w=;
        b=NasRarwIlitlRJriOGEDWswSLn66yGu9xG9roxHXICBcQmykO7iLkx1jU4F1BWRYW6
         QH+hfjn1HkIffA3l+96OdRSCPI8zNP0JSyOKG9oskKAhyGwoN5g1/lp9xPbBp7T8puFT
         0qk4n2xqxOUuyL4Iya7VY0GcPlTCAXD+Mz7d1E0Nj5Yk99cdL10ivR0/0r9UYxf6U+zT
         qqOo0+B3Nk3rASU8q+1gRi5HGSjx/RiHesu9wg+r3P/xuSlYd5T3urb3e0OPFwNYHWuG
         aSnDrkH0ea/xplCTAz9ErczN9eQOA8bCfF1vRFJOhIlZkXD8CWTACnnojcpnIt+UdFik
         csIA==
X-Gm-Message-State: APzg51CRTzNsNZ7A11+xdIh20KZEQRZtM7Ea9NQfy6y+DSnXlQmU0uya
        9qhCF1kjYJ6TXe0oXMmjokg8Nw==
X-Google-Smtp-Source: ANB0VdaD2w0McAHIKSY2f5yDV+QWzeLwkcJGErFj1XMHH6eSxDmtg22IjMjTaIJwd5dIQBMVElTjAA==
X-Received: by 2002:a62:9992:: with SMTP id t18-v6mr24365650pfk.239.1536595423131;
        Mon, 10 Sep 2018 09:03:43 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b3-v6sm33893517pgm.74.2018.09.10.09.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 09:03:42 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
Date:   Mon, 10 Sep 2018 09:02:59 -0700
Message-Id: <20180910160301.237538-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180910160301.237538-1-mka@chromium.org>
References: <20180910160301.237538-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
'reg' property consists of two values, the SPMI address and the length
of the controller's registers. However the SPMI bus to which it is added
specifies "#size-cells = <0>;". Remove the controller register length
from the documentation of the field and the example.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- fixed separator in commit message
- removed duplicate 'Signed-off-by' tag

Changes in v2:
- none
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index 0fb46137f936..d0c188e5c922 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -13,7 +13,7 @@ VADC node:
 - reg:
     Usage: required
     Value type: <prop-encoded-array>
-    Definition: VADC base address and length in the SPMI PMIC register map.
+    Definition: VADC base address in the SPMI PMIC register map.
 
 - #address-cells:
     Usage: required
@@ -104,7 +104,7 @@ Example:
 	/* VADC node */
 	pmic_vadc: vadc@3100 {
 		compatible = "qcom,spmi-vadc";
-		reg = <0x3100 0x100>;
+		reg = <0x3100>;
 		interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

