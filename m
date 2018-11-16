Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FBAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC87820892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHWWgwrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC87820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbeKPUNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:13:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33838 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeKPUNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:13:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so10953540plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQa+91PLxFYb8h1aIVw+4jOUYz51ilym0PbG90kh508=;
        b=aHWWgwrJHeMJF7ff+1nnC4xFocDcrbbCvgDon1DEptT8Nv3+kT8MtF5A1rPMDRLE1R
         sfFIptosEqc8HanBNvZItk3DiZolp+jOkm2UAWMSrxY7nqw6dBMHh4WvvX4Znak52ZMe
         d9SCmulfAKlNGrZTWNVKofTrKqW21c9pt4ba4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQa+91PLxFYb8h1aIVw+4jOUYz51ilym0PbG90kh508=;
        b=Lzg1KtlaA3cxDAxg8oxaDW3fk6DHhH9vofNTKi2eHBhgSeYSJg9YqIymiMqkfd2p+d
         htSnpMVA9pv89pTDYEXscNrrXQHp4Neq0ZCm7RuojPcwv3KwXOeGiiNhwnEDy8p4QAxB
         ARYdU2GFHyxMMvtlBtdxSuTj2+f8zoFK+Bkq5rbmO4VZEROjAC+XKg6x1ViiPTZUpIy4
         u8EWlUvyz8u7mmM1Q+dUEwcW/UbOCu0FYGl+J6w8X3M3wq/+8Lqwm0F762aZEWEQh5H8
         AJgo+X1VufZtGYlxJSvkfpzQwIDA2OmQeYFFTYiETLdk6iC6cApInqIKgazTu8qALExQ
         vZEQ==
X-Gm-Message-State: AGRZ1gKqG0fP7k6u84WEIUYRh3UoU1NbThQSA+ItPV1wq5Jq6U1LRPf0
        /5ugjr1BAw+Q3IXtgS5Pg7RkMw==
X-Google-Smtp-Source: AJdET5c9Gn006arlwcVwGHiCL3dNsXf1qiwVhdOJT7zz8A+ZYcwNG98sOjwnvyiBbkQfeznAgf3lIw==
X-Received: by 2002:a17:902:396a:: with SMTP id e39-v6mr10242837plg.65.1542362495513;
        Fri, 16 Nov 2018 02:01:35 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id u6sm30797249pgr.79.2018.11.16.02.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:01:34 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ARM: dts: ls1021a: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:31:11 +0530
Message-Id: <4e3e13854a25a2c59a8202872191be329ae4d5f1.1542362000.git.viresh.kumar@linaro.org>
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
 arch/arm/boot/dts/ls1021a.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66a79ad..2a411eb1ebb0 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -324,6 +324,8 @@
 						trip = <&cpu_alert>;
 						cooling-device =
 							<&cpu0 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT
 							THERMAL_NO_LIMIT>;
 					};
 				};
-- 
2.19.1.568.g152ad8e3369a

