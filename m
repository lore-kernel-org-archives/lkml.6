Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC4EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88845204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E78Z/icE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88845204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeILO6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:58:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46717 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeILO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:58:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so1229788edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9bJ7qSAUU7/5UhkQH/j21Wuybl3ji2CUnJgoFpqPBH8=;
        b=E78Z/icE+yxJRRycW8ZF3KLIgVkflz0oks+ey8DbjzK0W6Z9evURKH4w5CY/7PmjxF
         gHRdO4+KsGHKksvWarxBBUNldQuYBLf0GnmJSLw/55Nu7As3+FglyledJH6kdR05wq2K
         dxbr8cz1r+nY+fV/Xsne3uCJj+/TMeOSg/OiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9bJ7qSAUU7/5UhkQH/j21Wuybl3ji2CUnJgoFpqPBH8=;
        b=ZhxZcwG+vWyEuwUB1UNZjBd9dXCZjFYdZEbcKCxUxpbsx9n/QwyvpZivl4CBOhz0L0
         dZ74/2mzQFO80NHzA/NaM+MdllYcbci8CsFNbx9hj3gyPJx/lcS0Upod4B7z+bT51YYy
         DOne+wLg+ZzPMY7XJR6ucUoaDvu46k2klyTZh4w1Sl610AHsVJq4R2dlwk6fESCpJV+U
         XTtED2pyFqmGyfGYS+Dp6ZZ1kkbEgi4qg6DKn7ZQYeme7lgXZ5rRYmzWxxk6XtKQpumj
         dkI6yQZ2boZ3az7Wkk0QUIMM6LY9TnM/QaLydJO6OUFw2NUYzEJN+zBjovl68b53mbtH
         sZaQ==
X-Gm-Message-State: APzg51DHM0BPzk4zW64OTRCHUBurY0RDonxjaOsV8acM4x2LQSMDNgiJ
        CvtGOiFUSeukFZGrGl/mIQu5qTzXpMk=
X-Google-Smtp-Source: ANB0VdaL4sHGU8o3EJxKovk7DEfF27YAtwNdouu4xvYR36iYmlJdE8iQZABl7BVyv6JjYoyag2Hd6w==
X-Received: by 2002:a50:9732:: with SMTP id c47-v6mr1753777edb.89.1536746097944;
        Wed, 12 Sep 2018 02:54:57 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id q26-v6sm387923eda.72.2018.09.12.02.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:54:56 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 14/16] arm64: dts: msm8916: Add gpu thermal zone
Date:   Wed, 12 Sep 2018 15:22:59 +0530
Message-Id: <ffefc578b5cb9298e33f0ea480b3d521f34afd54.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the gpu thermal zone to export temperature to userspace.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index be27d8dc9e6b..62f079ae9ba3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -237,6 +237,26 @@
 			};
 		};
 
+		gpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				gpu_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				gpu_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
 	};
 
 	cpu_opp_table: cpu_opp_table {
-- 
2.17.1

