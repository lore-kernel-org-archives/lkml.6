Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E15C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424A920892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmzM6Ijy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424A920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbeKPUNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:13:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389532AbeKPUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:13:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so10929396plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E163C4a21s93kfgzU/fG9cKlenfPzM5SxGYZubHyS8Q=;
        b=AmzM6Ijyw6T6dd8GJlLZC+rWVmROCPYvspgH88Vq9493kNczdSqTXDemYbdJ1PoPzp
         LWcF4bsRzX9049AeZmzF/cGVX9R3ppozpMeVyHvu3CCaqTOsR7e26mTuaLul9jBXb3cV
         RVeWj0ZfErRql1Nl/j44rcR4Bp1EW3Tu18kmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E163C4a21s93kfgzU/fG9cKlenfPzM5SxGYZubHyS8Q=;
        b=ZMH4BJsKSwvGJuHLwBfrWkxuad+TGpV6QQOqBY7H+9HT8R6fianYkRsV6HbrhDgks5
         dFLDwnTBICPNb10I2tgfMv05ssjj9uZ8ZYlpkefP2ff2A73fWhiIColfpPeMGfxcX6nV
         ATWXTeItIk8bNSVNmqJj4ayWOqNpb+bPspP9yRNyBZfRtSQVkToMw4DE9FB6Q2wuFyZ3
         676daauMxOKzUOlbv+pVR+p44PyPIB/iSiPNJS8UGh/S18vgImJJ/oXjZ2MszqsROgmP
         O15CTpqnPKrJMPa3mdCcOifn4qHAzlXoFzyonOFHSW8TFOSMT8sPxlZCL6sF2QNdV8hW
         pzNw==
X-Gm-Message-State: AGRZ1gIAx39IzdRiw5TJW/dNZmNhlF6QyCM7ShwSx72eSgCmk5i+YHky
        IPH2wkCkzjXSYOJN9UQgKvc1GQ==
X-Google-Smtp-Source: AJdET5fZDDOfhpLM5mpHdj20S3iWEbJorDhWZNiRNtGafcOuhLAEI7YhvoXeZmk3/fzjEq/kJF840A==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9-v6mr10290565plo.183.1542362512599;
        Fri, 16 Nov 2018 02:01:52 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id 124-v6sm75274216pfb.132.2018.11.16.02.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:01:52 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: uniphier: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:31:15 +0530
Message-Id: <b522f13dfffcec1e2b78e126513114428ec9a4b4.1542362000.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1542362000.git.viresh.kumar@linaro.org>
References: <cover.1542362000.git.viresh.kumar@linaro.org>
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
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 8d20e9548e39..06a049f6edf8 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -141,8 +141,10 @@
 			cooling-maps {
 				map {
 					trip = <&cpu_alert>;
-					cooling-device = <&cpu0
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

