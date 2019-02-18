Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEC321773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jc4l8IJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfBRMgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41096 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbfBRMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so6020682wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=N587anwGGRTU9xPHyvLRXOqqrWAJRORm+3kTnyypRTo=;
        b=Jc4l8IJ90kvEkU8G1HaGwYqWWvLzLSG43nkVF/20nkF5ZWfVqNnP8nuQpvSs8RimI8
         OxkB13Gx6P/0jqz80P5RZbmXmTSIHd8G9TaQL3oE1SYU4NSW2PaQg4Ab0ePEPhpDyhba
         W84QPQ+M6AcxkqTawY79jJhuE459Hyuw/zbZloMYvHBWcHgR09sB09g10GmBp9zpZW+4
         J4bZHvrKhaRsPPfYgfNJs6QzHYUh9jzyPmb8Dab/TQWAKcNdSgHiyP24GX/i5U3hiRUj
         4UfhZCMw9R4IJ0H06DmJhQOYKMq97cm8PqV9GLtKxqogg0NJw8F1UMobU/GF3wwayrrJ
         aVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=N587anwGGRTU9xPHyvLRXOqqrWAJRORm+3kTnyypRTo=;
        b=QHQa988siqIxMkbmnkZD9gsLjgyeOYFk34SCMZg1apqGIdc46RjObEJdzw2/aBLv5y
         meyS+Ae983anQbTMVBaMOikjIWjx5QWQdOdZmC7v3aU6JIcaqoHUnVNbkKlCQ7F1+sdk
         lqQpKyihHPKQJfoB9OvW2WdyCT2lKFZqAyRkxJgWLP/Z8coMkCwkeJzlFuRQJV1BSjla
         gLWoESBfi1BeBNgB3+O+OjFwgiz51z+ClVQmarj2w/CHgPEgE2e6NVAOInBakV14qBDD
         hIU/ZAeQ9Xy5HCNbaSISKKDqWCxQ7jqT8GFAbgte6vvJk6uiLA02RbCToI9/DCMH6vYF
         uGqw==
X-Gm-Message-State: AHQUAuZaPySi8vQ/ibjmczU9nw1eHYZFdD3jgauJsY/bUu33H0eSicJ/
        62QGbPZ/CvWCFknni3seerifIYJQFjM=
X-Google-Smtp-Source: AHgI3IZWDcf3DNhtnvRAIUUXPBKNEoN8id3zeOoupEGqa8C+Bfqw686iY/maxTe4w6GmKgqxzB01kA==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr16312897wrw.269.1550493372600;
        Mon, 18 Feb 2019 04:36:12 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id o2sm18596461wmo.33.2019.02.18.04.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:12 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 06/12] arm64: dts: msm8998: thermal: Fix the gpu sensor number
Date:   Mon, 18 Feb 2019 18:05:20 +0530
Message-Id: <6c8750d78d375ed288d95fa9af8d330f9ed62958.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU sensor is sensor ID 13 on controller 0

Fixes: 4449b6f248d9a1 ("arm64: dts: qcom: msm8998: Add tsens and thermal-zones")
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 662ca458e64a..ba579cf10254 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -504,7 +504,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens1 3>;
+			thermal-sensors = <&tsens0 13>;
 		};
 	};
 
-- 
2.17.1

