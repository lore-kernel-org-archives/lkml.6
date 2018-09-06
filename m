Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF69C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D76120844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Td6541f1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D76120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbeIGBmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:42:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45495 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbeIGBmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:42:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id x26-v6so5828483pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vFlxfVRSjS2EsnlOC/4qKCm1oe1/j2za0S0N4a70Cyw=;
        b=Td6541f15RDc0tm8IvwY1Dyk5K4GHRuOSEilQDqW7MPXyGayHmch6wmkX68/1T+pMj
         XOKi4LvLLXQSJJu1sxpmc3kosdwdpF0VrBkB+k1BTqb/SEB3PN2X55XWDYx1I+qwa0MY
         GKHO0taF9SkU8ZhC6SBq1uCoXQeqXSv6BYJg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFlxfVRSjS2EsnlOC/4qKCm1oe1/j2za0S0N4a70Cyw=;
        b=tAKviKAYTWKENZShYo5k8xyfTM0O/3v7Kq89rLb+N0/LQSxiGcGRLHIOsJ1KdrQRVm
         TZ42/he3s74h13aoa4yLitkVLKnOI7QXftTKDBz5J9jKdqnyidR7ZyykMV7xGdOf3QPR
         yaTOCkcEs1dizEuIR/HjrJrjxq/Xa1fsHlmnX3rFtr5M2ZwdMZrIpwAaERHm+AOq9A0t
         i/uxPxvonGdN23w8NqxYi9mq8COpe+b9OVXVolDvT1OtmYgZvJfoLTS4yKpVcV/MbYMC
         ZtOFvTPBlxedvdR7eu35bYLz9VyuKTtoZV0+s41cBMFUGSfLdRxoK8BAl3O3S/fnnKnW
         d9RQ==
X-Gm-Message-State: APzg51CJoPHQ6fSFrvM0sG90eNfIk6OihVCwuLAX9Li/3jBFDuGytQdy
        DJsGoTYtJOMbrE2FmLlKsTSS6w==
X-Google-Smtp-Source: ANB0VdYZKxiklFX2ndnobTS1L3ol8LfyaOtW4VPfKlrbS1vHX8BMQZYuT4x17Q4nKDyq80FB6Bv/EQ==
X-Received: by 2002:a62:d44a:: with SMTP id u10-v6mr5005730pfl.144.1536267933882;
        Thu, 06 Sep 2018 14:05:33 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8271288pfn.123.2018.09.06.14.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:05:33 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
Date:   Thu,  6 Sep 2018 14:04:52 -0700
Message-Id: <20180906210454.247219-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180906210454.247219-1-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org>
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
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
--
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

