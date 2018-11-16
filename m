Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA16C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5E520892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnpCbbhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5E520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbeKPURC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:17:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36770 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbeKPURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:17:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id y6-v6so3374821plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SF62PrzKsc3DFSelUulAf5/CE9NMeGCTdyY77HTuy1c=;
        b=PnpCbbhTW06C0H0dmVz2PQDq+LdWEyZzDI+ZgwXXfb6wI7dbqTUiEw94Mwr/E4LoMc
         V+U3PTjh02eBJW5jd+RWoMOA9XgiSQarp7dTK9y7zpBDVwlGDMm/VLI7DZvtG+RwhvsR
         VLw1jZupl3w/fHsQbTjVOr0fNbgzu92fqrp3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SF62PrzKsc3DFSelUulAf5/CE9NMeGCTdyY77HTuy1c=;
        b=HiL17cQE6oPEyfoT8zPWv1fekFjyW9++vZcKZFOkQ6jb0XwyblRHbp4uIb/OPwkBOR
         zv/IziWKfNlUHm4kUMMSTkG3VlCZACzh8Gw/lqsX9IN13W/imaaVby8hQFEDb/v+9yxi
         vqXh04wVW8fcXIpLMMyrKjTdNcM9rZsEhZnCi/SGnC5XgqJS8S6arW2z2nvYEQsFjPCl
         bPN32V3HQ+Qm0sz3HkGpMtZitqSXZxQ0b+j5cBRGDbJcWlhwkjZClxdXLEoH/Ii2VRLo
         RUrlxqCFbd86/JrpGHlhxyMJKQ/PPa+ZCedF4Ts1z+XJECNawM1fNstUdv5udTD8TGj3
         pX1Q==
X-Gm-Message-State: AGRZ1gKff+0uH53rx86RW0bHHedBepnZjygAlqYzY8BKdIHXkd6yI0vC
        pG6m8nD34GYwYJEvZ7JfJewHfQ==
X-Google-Smtp-Source: AJdET5egE/u+vdbiW4gAR2BSipj0p0ZhT8QMmGfDO7ULuxLK8+VBXWs3TPmG96Hqf//6NrpzTKb7Dg==
X-Received: by 2002:a17:902:3143:: with SMTP id w61-v6mr10080122plb.58.1542362723769;
        Fri, 16 Nov 2018 02:05:23 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id q145-v6sm97195004pfq.143.2018.11.16.02.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:05:23 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] ARM64: dts: renesas: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:31 +0530
Message-Id: <f2116377ab65e4b3ece39c32f54ac3eec2fb7d8c.1542362530.git.viresh.kumar@linaro.org>
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
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 15 ++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi |  6 +++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a79c8d369e0b..3a662df32143 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2878,7 +2878,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor1_passive>;
-					cooling-device = <&a57_0 4 4>;
+					cooling-device = <&a57_0 4 4>,
+							 <&a57_1 4 4>,
+							 <&a57_2 4 4>,
+							 <&a57_3 4 4>;
 				};
 			};
 		};
@@ -2904,7 +2907,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor2_passive>;
-					cooling-device = <&a57_0 4 4>;
+					cooling-device = <&a57_0 4 4>,
+							 <&a57_1 4 4>,
+							 <&a57_2 4 4>,
+							 <&a57_3 4 4>;
 				};
 			};
 		};
@@ -2930,7 +2936,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor3_passive>;
-					cooling-device = <&a57_0 4 4>;
+					cooling-device = <&a57_0 4 4>,
+							 <&a57_1 4 4>,
+							 <&a57_2 4 4>,
+							 <&a57_3 4 4>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 1ec6aaa520c1..dd95e937f87a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2526,7 +2526,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor1_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
@@ -2552,7 +2552,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor2_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
@@ -2578,7 +2578,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor3_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a

