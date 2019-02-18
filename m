Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8575EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627721773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gikiozbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfBRMgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37670 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfBRMgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so18170171wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=E3zqoukVK+Ya0YkeW29Ko/3au5HBn1f79BzxBsWHcKk=;
        b=gikiozbg8GjHM+ZQFhlHYcrN5kXzfvbJO8awqTdiNQM6hhvOuNBWtPVf6ofBk1jDh2
         osx0FGPr+RvcBftHozZQmzUItjSf0j9XaJ0Mflm7Su221HreN+yT3A+xJM28ICn6tRRM
         msYEn6+2njMvURNeGaXaJla7qNn8q9rgV1rePD/Ay4rcsGqL19Rvn3y8xHHlH+hMTa/X
         ga/kO5HSbsZU6Sr7Cwh3/qDLbWV9sEEl6RafR+w1l+M48c5Aqtk/aVcGfvsoscTOhSDa
         1yG+h2aLpgiplJ+C2fIXyrZ73OQdxyRmcvpUPTzp18Qn2Q7OK1TKiLXaoxt8zebytys6
         4gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=E3zqoukVK+Ya0YkeW29Ko/3au5HBn1f79BzxBsWHcKk=;
        b=P7a+omapZ5qzBUysGTgtV29qE2aKRPmqv8ZneXk053/gEV5kwqa4q+T1HRL/X37CoI
         PJSI6OfRGzqHfqXvG3dWJ1X8itgDDKkmbiILciENK3d/nFE506UGTJVPFSeBY1PYzi1j
         q1svmT8sekyytCK1dK6vu+6WI/dclH+dIVFNaGCXtt9XBrtho391zMPO+DzEaJz5EJgd
         OVMhEFAs+YAxaWjjFm4YlNkzrJnzERcOs2+UwZ2tvGMoUe4OTObhcHvF6MVCiR2lFOkJ
         jNkOT1U6MvofENMxwt5pSSth/SQitetxujMLsmRo82GUT2YcJU+ZlUDUf4Ae3NLzUI57
         DjAw==
X-Gm-Message-State: AHQUAua7SxauglFOBL/dCwpgqnAR1zX+WWrn9HAMgazAch9LNL//YiyT
        oNJSyY1WxIAGGUERuBJL6+YMcB31wrQ=
X-Google-Smtp-Source: AHgI3IZ2KwZpyYpRuF6FSW0qJz9Vopen3/fIUgIKDOnx3/qOFiBJiS7lGbn1teQbxM5pGVmHtCtLhg==
X-Received: by 2002:adf:f487:: with SMTP id l7mr16017941wro.86.1550493378565;
        Mon, 18 Feb 2019 04:36:18 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id d2sm9907391wrs.97.2019.02.18.04.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:18 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 07/12] arm64: dts: msm8998: thermal: GPU has two sensors, add the second
Date:   Mon, 18 Feb 2019 18:05:21 +0530
Message-Id: <efa80be2e37b7fcf5c51cb24991f2c5c2b4fe7a5.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first sensor is on top and the second sensor below the GPU

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index ba579cf10254..dc641523fcbd 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -500,7 +500,14 @@
 			};
 		};
 
-		gpu-thermal {
+		gpu-thermal-bottom {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+		};
+
+		gpu-thermal-top {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-- 
2.17.1

