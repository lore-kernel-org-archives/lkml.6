Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0991CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3EB216E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQCnw6Bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3EB216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeHHVfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:35:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32884 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHVfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:35:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so1616082pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ah5CVFph/rLL+ZJ1gEnQ88ZVR9bFIAJr3uYoDi+MZ2Y=;
        b=GQCnw6BksSGfcvZhRg2x23sBZQ5Xl00k6ibEMWAZWdF3JjgM8YhJTMVFltg9cDGcmh
         8hCIithgzQWTdy+/ifQcZ+xashj5wYmSylFQ20aCmIFJ/a6/OmG2hbP/Uy/fAxqfnk29
         B0ahspmtI5hEnuXRwq3o09sWXF7/2fBW9Nm1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ah5CVFph/rLL+ZJ1gEnQ88ZVR9bFIAJr3uYoDi+MZ2Y=;
        b=PX1DN3LvTFqjT432NB2DTiiFP1Oey9IalJD1HVWg6dEAoqLNFg0a9KInTtX609ZUmL
         XTIAwCWD27ZJxxM+s9Dud0D1NzkgVRZWETgAjB72r0d8opCFfFiH983Mc+n8Tncul9iA
         hfMdAGF5DnvOXDhi3Ca/W2hLnCoQpHstm4mfZN8MLvLn8oHVeHuMt0lJ+kM5W2WtE4vF
         ss8wZrDZvD3bZSm7jPs+7wqJOKfMfZqpdGQd3Hw/Q2Ku1vWDqxqOTmhbTDZejpjLdIkz
         MQP/ANTioVt8VyBXjH9ajBthlgCsoG5kx7GMAqN+G46QGB59baXWXglYKfH6Ed8NL8Cs
         He9A==
X-Gm-Message-State: AOUpUlGQg3lw8naZiZ8RIeZrlviebqvjlwQO6wDkLb2gfJ+x2ZrhPxrp
        XzsqczVsw26vohgCbeQU2Wa0sg==
X-Google-Smtp-Source: AA+uWPzQlndd3Z7t9c5d455gzVPkeo+9+M/uIKlLLLblo4HzBJITEl5mGr99n9B25SmQ0YuFfI/VKA==
X-Received: by 2002:a63:5350:: with SMTP id t16-v6mr3644366pgl.196.1533755653025;
        Wed, 08 Aug 2018 12:14:13 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id f5-v6sm5431136pga.58.2018.08.08.12.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 12:14:12 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
Date:   Wed,  8 Aug 2018 12:13:37 -0700
Message-Id: <20180808191339.16875-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180808191339.16875-1-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org>
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
2.18.0.597.ga71716f1ad-goog

