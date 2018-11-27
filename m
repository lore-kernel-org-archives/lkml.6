Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FD0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819B62086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0aDCfqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819B62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeK1D15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:27:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45050 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbeK1D14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:27:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so19041416wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=s5zhkfCpfsrybfxA0ie5n6DnKn1jNcno8a7LLALW7fc=;
        b=W0aDCfqbcIPSRmcdsX12/LQ8Ufi7EHRGwNuS1GPizZ2EDJWTFmGyi8CLLkm2O6AgGE
         Bfd+uNsi373GPo7hZzoLEMBkn+Bxc2qZJupojzI+4wkqHuJ3UluyeUptT7sde5h3IQQm
         OG3lRm9v2lv36OEZ/zilPzUrU5hsC3kEkZMFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=s5zhkfCpfsrybfxA0ie5n6DnKn1jNcno8a7LLALW7fc=;
        b=BI0wXGGIBiRV4IxPZbze/kWyFGHAlv9mbGnEYn5jF/aLLOZKI5LTWOXyWBBkRt5Eid
         f3V7wgsYL+NMjdgyfnrx+JGoh6D4sV6KeAoGclsvpsR0E7emjOUumluvEv7W0GJvtaib
         ED4Hav6b4xcHuUrh/A8I0FpvsmLHi/dPTVLsJEFBRXCBY6KX+vhozEBtjUbbMFVPz3wH
         GsdQpgsAQqZcd85u1jIcN8PF4RlcrS1AJHUgh/Ue9d3job0J/xUHKpgiIcpGFYnfJ68m
         kSZVF6le+TX6Pch6HAx3inms8SVX8cXiqJZuYeClFKEEMhaRU2M6EgJnMDS36knHU4eV
         /qIw==
X-Gm-Message-State: AA+aEWa8CNl1H4V9JNVDHD+du8O/Z5Q9KJX1s4GzsvFqXWBVrwlotULK
        ln4WLkrR3e3hnUfKvLAM5nM92kiM+4s=
X-Google-Smtp-Source: AFSGD/Ucl2mm18KEjRadHs4Hwt55+aXLBs5oOSf5T8G/iDRnlaD33gOPYUU6zQLAan4rSy94r4ExFg==
X-Received: by 2002:adf:9422:: with SMTP id 31mr16736576wrq.106.1543336168929;
        Tue, 27 Nov 2018 08:29:28 -0800 (PST)
Received: from localhost ([49.248.92.105])
        by smtp.gmail.com with ESMTPSA id s139sm6736196wmd.3.2018.11.27.08.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 08:29:28 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        khasim.mohammed@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 1/4] dt: thermal: tsens: Add bindings for qcs404
Date:   Tue, 27 Nov 2018 21:59:04 +0530
Message-Id: <d0ab6a6c4e09ecbd93ed8a81db0036992df62b95.1543335819.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1543335819.git.amit.kucheria@linaro.org>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1543335819.git.amit.kucheria@linaro.org>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 uses v1 of the TSENS IP block. Create a fallback DT property
"qcom,tsens-v1" to gather common code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
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

