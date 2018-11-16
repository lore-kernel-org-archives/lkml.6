Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0EFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761E220892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATnBdGjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761E220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbeKPUQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:16:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40334 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeKPUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:16:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id x2-v6so11173015pfm.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oskLWY4mMeTJJ9TYoYBq3J1qg+P8pf5LnWRqIcwKGK8=;
        b=ATnBdGjgO7zh0Orx+cQY5HgoRJ4l9UbThujztH+bBaMJGHsFpCw1g+uMRsgziODVZb
         rbecT9tokiUQH9Sxkd6bI6PKhqIioXGKtsSJ80pXMCVb7cLjyKGLCWsapQGglk8SjHYz
         3j+FQd43roFL2giLKateOQSrXnm4Je8L7ScME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oskLWY4mMeTJJ9TYoYBq3J1qg+P8pf5LnWRqIcwKGK8=;
        b=P7i5oihBJqiMvZwzlWpRJGMYKPocnFB8cg88Fqks9Qxw2jGTh6eZ7x5HB9YUEhTrw5
         tSqL2jwyS05O2asc3RRTDjbmTLZe8/N1flqTmbdL813M+1zfbVUaY9fyjhh+7y8CxGKb
         SCRVFtICd18cjR++Wfs2F7CzEpRJ03kQ7codCrLcYAG6Y3ZrwRZ5Hq9GJo3EtC7KfWBk
         yio8UoOU1EwYapCzP7JEuIN3AfTxo6VGSUC7YEvm+QAtyHHl7+e8khpacmM4iOM/2DhM
         w8J8+EiUXndE3Y/KC0BipvvLAPgjN75zfjM4+a2S9sbGlsiRfOD9a3m/GwtP9XYosKL1
         RR9Q==
X-Gm-Message-State: AGRZ1gIU5J1ShnCV9t+Q1x2eP/xFu0s62WBRn+p+ZxGBUN4OBjy2TLBp
        +QjRpNBjuAfoKgVHYp8jx+nff+ggD3U=
X-Google-Smtp-Source: AJdET5dREXH8/pgZpQdplTK2PixR+p4HIWciuMrOJU2yRz/F5loN/y1ujUTc6zD5ASZeKRCw1RV7yg==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr9396597pgn.112.1542362699588;
        Fri, 16 Nov 2018 02:04:59 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id r2sm10042207pfh.57.2018.11.16.02.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:04:59 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] ARM64: dts: fsl: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:26 +0530
Message-Id: <c92e66ea7e0692b13c8088d0a554acfeacf74cf4.1542362530.git.viresh.kumar@linaro.org>
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
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  6 ++--
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 ++--
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 17 ++++++-----
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 28 ++++++-------------
 4 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 3fed504b5381..c7224c5bb6cc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -171,8 +171,10 @@
 				map0 {
 					trip = <&cpu_alert>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50012d6..8c94d8279b5e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -140,8 +140,10 @@
 				map0 {
 					trip = <&cpu_alert>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612ab56b..7faee0d270d2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -152,15 +152,14 @@
 				map0 {
 					trip = <&cpu_alert>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-
-				map1 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu4 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d188774a36e8..f11187f7465c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -101,26 +101,14 @@
 				map0 {
 					trip = <&cpu_alert>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu2 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-				map2 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu4 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-				map3 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu6 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a

