Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CAEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95F020892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jW92B1Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95F020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbeKPURL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:17:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45659 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389504AbeKPURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:17:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so10393171pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuQ2y36Xrogh3AFeo+w7wq6zdpbFBC/erJbwrEPtLJs=;
        b=jW92B1VzqoIqDzqfecPcu+sFg3tYWXLZGvNmhlicA/IAPUk2KrDwq6Cd/dXpVmP/Ch
         tc8tdaerC+mPnSf3WEy6lguWwJvNA8r2ShnOFqXsyYp0ajfqyXaQMmd3DuZxDcpGVjul
         t/MXnPBObHOJLawXqGPkrM4efmpv8szog/bXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuQ2y36Xrogh3AFeo+w7wq6zdpbFBC/erJbwrEPtLJs=;
        b=E19ppKjgRZW2NZMD0fgCUM33MtUXWRGmC4kqCFw7d/CzNTxI6vDDwuBemvizVyuIL3
         MIpVFgEMb6F7ssDkgnqu2LRF0CrGNxFnO4c4hz4LdBvKMngC3sQ7XxRAbndmEl3L3tyi
         RSCyA5zY7Z+IQNP32jlrHJK64O6OH0Jbi/m7c9VUETHWKTUr9WZpYjjG6zHbd0kEVUov
         ySHiNwwyx6bR5f6CyJENIKnS7wxqpqp2B5sXCNNml+r3RedYJTNl9WfxG0tPeIBXWIr4
         U0Xg1NSbtVvTNDnRtRMMp/W8juo/Fq4snOit04qm0sJkYE2FPvaLakPReNHS3CMhwSmw
         ARYg==
X-Gm-Message-State: AGRZ1gIYerG+WpWYR5QR5QxtieudL4a/VE8OrBhpldAXEH0iuINPZ5oI
        nijVupvrASMLkjX9IOvxyyxTeg==
X-Google-Smtp-Source: AJdET5cQ/pFNqQDeGVqoVWAXo3OsGpLnmRROYg1543bE0SKQ5rAbtrwuV09x3/9tqL5x2ckwMAUTtA==
X-Received: by 2002:a63:5153:: with SMTP id r19mr9270294pgl.281.1542362733085;
        Fri, 16 Nov 2018 02:05:33 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id 79sm29801208pge.66.2018.11.16.02.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:05:32 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] ARM64: dts: uniphier: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:33 +0530
Message-Id: <c759699a44189aed078186fd19089d2f44d988e3.1542362530.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index d7e2d8969601..4a0c46cb11cd 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -206,13 +206,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_alert>;
-					cooling-device = <&cpu0
-					    THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu_alert>;
-					cooling-device = <&cpu2
-					    THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a

