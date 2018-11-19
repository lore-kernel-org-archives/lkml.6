Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB448C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8381F20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ey27Y8J2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8381F20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeKSWtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:49:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40173 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbeKSWtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:49:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so22674993wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e94DIEaO20VLtFTPXBdeuigr1I2rzbvph1yIasDBL34=;
        b=Ey27Y8J2YhDE6+lRkH45SC/ejdTI66xX5FYehwkoJNLKYb2WF+BiAYZkU3ZNZXYALm
         KIk21DyB6303cxBETEvNWE8CyCVt82fCJc0SAI515Ohhw/5xoHhKVCy0UP4lkDSsVY5R
         jCiuIVulkdgN8ok5R4m/FcpkxJ4p7OGfHnAZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e94DIEaO20VLtFTPXBdeuigr1I2rzbvph1yIasDBL34=;
        b=N/73QyO4uGuXa/p4IhTWLL508KfUfUHUlPzpPsaHIP4YOyAT7PLJzvHe/DfKvkF7RG
         ax/M9349Fm8zm89RlId7UxhUwI4dX6ksVgy0huIozyHiFz5oH4e3z470bomlz60DIT7M
         FIowEITepx9vvmS9NHAgz9lQLf1Fvf6KFxuOTWjK82orrQy3HYoaJZS7y94WKSIcJazB
         4umUedzciqolGu4RJaSq4dlBQwZOjwBY3NtxOFvp7obB1wVIUKcHykY9CfKFFHBvf8HY
         0mEQsJVjxbd58r9mb0L/7/LTYmeKUsEFTK4qRXTr9klDi+E9aR1fqO3RCeElE+HjON9q
         GepA==
X-Gm-Message-State: AGRZ1gKCu3inrBOMIoHP+YHs+y0pqQyRCs+NcYovsC9f9AFr3U8+EITI
        AnKj5y6oTbFqPj3wqmUzAEItJEutqMM=
X-Google-Smtp-Source: AJdET5e3Fvz/YQn0+rJU0hbTVW0OPy3YvH43zkjyaPeS8dokGdeni3pUtNjFXbGKCfJ7EqEBq+hi4w==
X-Received: by 2002:a05:6000:1009:: with SMTP id a9mr17527207wrx.271.1542630345269;
        Mon, 19 Nov 2018 04:25:45 -0800 (PST)
Received: from localhost ([49.248.195.80])
        by smtp.gmail.com with ESMTPSA id h67-v6sm42241111wma.10.2018.11.19.04.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 04:25:44 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/4] dt: thermal: tsens: Add bindings for qcs404
Date:   Mon, 19 Nov 2018 17:55:19 +0530
Message-Id: <d0ab6a6c4e09ecbd93ed8a81db0036992df62b95.1542629810.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1542629810.git.amit.kucheria@linaro.org>
References: <cover.1542629810.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1542629810.git.amit.kucheria@linaro.org>
References: <cover.1542629810.git.amit.kucheria@linaro.org>
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
index 1d9e8cf610181..799de30623522 100644
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

