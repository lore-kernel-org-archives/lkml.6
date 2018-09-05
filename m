Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A331320867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsVf/7+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A331320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeIEXHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:07:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32950 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeIEXHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:07:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so7132066ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qor4mJJIB1S7+jS/KChM4atTEGvnzrUm3n7UZvsrnR8=;
        b=LsVf/7+KZIHlFFrgQxxADRoYLh/YffXKlj1aQA79CYKOGK4rFjMhIg7zsYYLzQOoZ+
         G1EDvovfQ4uM4W/ojYRNi0skcjnOte3hgeN2EegaaFAPD0zHwm7dv+veCQAAf9nKGVwZ
         b1yxxJBfYVq7u9CUL+myAqQe9G5unvzwyQtf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qor4mJJIB1S7+jS/KChM4atTEGvnzrUm3n7UZvsrnR8=;
        b=liIBRWqx5YGJIA7P+64xZhVHOCxt9FiPPsy+5tITqkCAxw9yZOXy8dTpitGkQOrNP8
         uyc5L6ZMGuafqILeV2ZXSUqtb5iQ7YW3fWC+fcMQq7NF3DLwtObypBxkKy/Z8Zoa/OA2
         VME3QbbD9r7MySXLMKuGONvcCa+WnOL/Ay7hxPhkD2GByyD6PuTah7VzpI6l/wbNdiY8
         qj3G5sLHkb4ioArLd1jZQyNoqEq0jDYIrjVvw2+RscHoXGzChpIq7VIZV3Hp7NQXa+SW
         PYZh21VTwVOolg3PZWu8X4GDhncwIXH1pAHypwD7WwgZ+qBPE8zNS1az8Q1hMDqJb0su
         IXcw==
X-Gm-Message-State: APzg51CjpScxhN/RrS12A2rOX+nXnJH89m6XtGzI/wuE7d9SEwnr8NnN
        DC4GbS+5ldPeitHcd2S66eXmIQ==
X-Google-Smtp-Source: ANB0Vda0RU6ntWJ/SXUormXdJoHcWIrvn7WxfRAYvv7p3fYwrsypMHOJrWi7KcKUtEop3/G+tbC0DA==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr23671162ljf.28.1536172543274;
        Wed, 05 Sep 2018 11:35:43 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id z21-v6sm439081ljb.59.2018.09.05.11.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 11:35:42 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: msm8996: Drop model
Date:   Wed,  5 Sep 2018 20:35:17 +0200
Message-Id: <20180905183517.9390-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905183517.9390-1-niklas.cassel@linaro.org>
References: <20180905183517.9390-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DTS board files should always specify model and compatible.

All DTS board files that includes msm8996.dtsi
already specifies model and compatible, and will thus
override the model and compatible in msm8996.dtsi.

Drop model from msm8916.dtsi, since it is only a source of confusion.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cd3865e7a270..b4d635bb81ac 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -16,8 +16,6 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 
 / {
-	model = "Qualcomm Technologies, Inc. MSM8996";
-
 	interrupt-parent = <&intc>;
 
 	#address-cells = <2>;
-- 
2.17.1

