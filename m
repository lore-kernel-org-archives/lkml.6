Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4405DC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3D6208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eG7AyAl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3D6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeJPC1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:27:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33185 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeJPC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:27:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id s4-v6so9743444plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YLsDhg5zmRoRd2nq9v4jijpwo9apn3dlm8tarNuMuio=;
        b=eG7AyAl4mvM3K+g92MiM9uUWKlk4f3gpgxEDtc878UxFv09ypwwc7laEsEYU2dNAEx
         xLlbJyQp1Q2+pQNua5/b7I8ujrdOUVhXZ5u6dQ9WkIJA2oWFJRXpMTEFBeA2SYyk9si1
         UB8+AryDuYy7sC0nUNIAOVvVCKI40LQCVR/OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YLsDhg5zmRoRd2nq9v4jijpwo9apn3dlm8tarNuMuio=;
        b=LnavWEsSzWeJ0qOyvDzwB+BuJVZU1ggyBqNDxaAewFW1xFBAqud2kPuj/iBZJGwhKY
         UylNypu0+NlN2g0Tdk/UG5pZCUBeGpyi/lHaheGTGvO8yhewl1gkT+zOR7txGTeUuI4C
         NKiU6fNUpgUQ271kROnCqaI2tYjfcn+30gOptS4B9UQbmBmdI6UznGRZmioJkO9cBNo+
         Uw7RB5UDG7LbN9z1XjInYrSMHwLHYI2e/xoIT7D5/DTtlodhgqUJLXrxVUMuxiXiS5L5
         ayn2fSg24rCUPR0+UdTWZf3V9rh2kd38MMK9XaQqJTe0onkOUOpMvqcuyrTXcTK92jz/
         VBlQ==
X-Gm-Message-State: ABuFfojL5laWACJ/yo1hszMgw3LnJCpXdoNOuadtOGuv5TuHnwZ+8bMs
        RXnSSJ+b/mOgiDmO9VRNfmYS//lg0VE=
X-Google-Smtp-Source: ACcGV63wUwSxE9C3wQDoIuAWDCmAFFczByTaoff+dto9NoSm77AsEuBpWlcS7Jh+gNbCuR9cMR388A==
X-Received: by 2002:a17:902:a7:: with SMTP id a36-v6mr5207898pla.87.1539628853369;
        Mon, 15 Oct 2018 11:40:53 -0700 (PDT)
Received: from localhost ([49.248.168.189])
        by smtp.gmail.com with ESMTPSA id r73-v6sm18627774pfk.157.2018.10.15.11.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:40:52 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 1/4] dt: thermal: tsens: Add bindings for qcs404
Date:   Tue, 16 Oct 2018 00:10:40 +0530
Message-Id: <102083e3ea93f48085b93f8df307967689ea18d6.1539627762.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1539627762.git.amit.kucheria@linaro.org>
References: <cover.1539627762.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1539627762.git.amit.kucheria@linaro.org>
References: <cover.1539627762.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 uses v1 of the TSENS IP block. Create a fallback DT property
"qcom,tsens-v1" to gather common code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 1d9e8cf61018..799de3062352 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -8,9 +8,12 @@ Required properties:
     - "qcom,msm8996-tsens" (MSM8996)
     - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
     - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
+    - "qcom,qcs404-tsens", "qcom,tsens-v1" (QCS404)
   The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
   with version 2 of the TSENS IP. MSM8996 is the only exception because the
   generic property did not exist when support was added.
+  Similarly, the generic "qcom,tsens-v1" property must be used as a fallback for
+  any SoC with version 1 of the TSENS IP.
 
 - reg: Address range of the thermal registers.
   New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
-- 
2.17.1

