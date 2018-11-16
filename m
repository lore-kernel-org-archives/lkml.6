Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E61C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D6C20892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HqdsL4I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D6C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbeKPUQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:16:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33971 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbeKPUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:16:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so4635881pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuDFUrU28J59C1sp5glUdfijZEsUqR6FAQUgWuELHt4=;
        b=HqdsL4I1tJ9nEYhjZeVAExIPh2XFK7J0bCcMgpeAYiWvOIi27WouWHqsYtCaJ6z1hc
         wqGYfgkJxX3PX1+58Oxj5bzXZw9PFuBmVpMxJ7dM1H9AOyc/KI9HoqAQM5e9bc3xWZOz
         TodNwflfBk/2lqobqd23l3p6RBUKVucHrA3ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuDFUrU28J59C1sp5glUdfijZEsUqR6FAQUgWuELHt4=;
        b=qYccK/ExyaYAGJcA8vxkXMdxKe4mPmg2jhsqKztHs4B598K/V3+SNdErRrQzVCrJtK
         5o6Zm3fwqYh06aBu3zRpq760hhNvR8OVezxkAM/nKEZf6MvR8Fg5sRTyhF6Ow7wWk8I3
         KCRUuFxI3M+/SoFxXs/dv3eul4dPB8LoG2ozJmUmHyRLUf1AtszwM70fmeUPhK1gO1xs
         9TKUUFh4T937gfDPOUnetj4zHtZ3QSK7RO2z1xJbiMyknp3s4cczcisoVC6bGBLdyIXD
         LJepGXt1I0lot/EJxrE2FYilgIFops3Z0r7BdE+g8N5DYR7QFyd1riUmzgG+Tfafj/iS
         suug==
X-Gm-Message-State: AGRZ1gL8dXTEMiNL3vQd3yewg9wGVoA+Z28c10mxmnmPnV48RdSFxfsm
        lfjOldljiZlBst1ttRUTYrHr6A==
X-Google-Smtp-Source: AJdET5dHny/jRZrI6uDp+du0UONoToFOu6s5PNBwV124fVGbL1L8ifCBwYWM3j+/tzlD0VXOvCxDkA==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr9454796pgd.344.1542362719182;
        Fri, 16 Nov 2018 02:05:19 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id t26-v6sm48373412pfa.158.2018.11.16.02.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:05:18 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] ARM64: dts: msm8916: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:30 +0530
Message-Id: <01bb903b2febf4b006f28fad33308cc8084ccbaf.1542362530.git.viresh.kumar@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d302d8d639a1..482e275f0a03 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -202,7 +202,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -229,7 +232,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a

