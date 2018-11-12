Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D0C0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5073C2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0TRRdEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5073C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeKLU3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:29:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45841 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbeKLU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:29:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so8692153wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jI0WqACAlT+BW1LXg2YNMxvnK2/0hl/3M5gxbeCL2ls=;
        b=W0TRRdEcKW14hfSgcWBO8o1CwYUuZyCgxN9+4TeflcMN/YRDGiHEaYQvhi6IdB3T8V
         OALabzdWqSG4wPHDv5OW6CrDlsxajhl3soo4pbPd7G0+8wb+x/8A/CykgZ/MKXw/yYBz
         GRr6HAvYNPRMC8N/h7gciNHHjzjeJou3M+hT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jI0WqACAlT+BW1LXg2YNMxvnK2/0hl/3M5gxbeCL2ls=;
        b=UZ1Bjlb5umL1pew9oDrhpgvxobTctgbul3tTOwkL+GWINTMhuaOgxdg7ukrnMPBWeq
         YSfaOEEDoHCgVUSlS3TYyNGlmV/TIS/Hs864PDQud78MrKjv6hkvlqjJkXrDNl/GH/WV
         ZSGiD6dq8YCKRfPdekhN5vU4RENQDwA2D9XUPAwY6FezUoUZumzEhOtuDR9+QEyoJok0
         wQeHfXLOQlXpmU+MDgQjuM268VxdGR4ZiLbxRI5nN8k2UXxYgtKakOZOOn4HAJp3g8jT
         05e3tzlbJC0lQ3UiNgohh+Vbs5SX5jc1gUc1xzdWOkaEoB+1kz2pymAOugcrZgHX6pUP
         VIeg==
X-Gm-Message-State: AGRZ1gIT00Gzeyo74errTLb79VzYBFVwXgXuFrLUO49ZvK5lAoF8B+9m
        SR1FskYX04Ur2mlgiwcgkxBi9g==
X-Google-Smtp-Source: AJdET5empmpMJ7AZRIiRWLrdp/RpdJ6CIJFo3IUn2FOKdnA1UyvXujq1ZthVMW2ZczcBrltcDlFdRg==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11-v6mr481275wrt.72.1542019021985;
        Mon, 12 Nov 2018 02:37:01 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id z17-v6sm13747187wrm.65.2018.11.12.02.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:37:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v3 4/4] arm64: dts: add msm8996 compatible to gicv3
Date:   Mon, 12 Nov 2018 10:33:40 +0000
Message-Id: <20181112103340.24702-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
References: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 16c3fc0f4e69..e38da221f9a9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -902,7 +902,7 @@
 		};
 
 		intc: interrupt-controller@9bc0000 {
-			compatible = "arm,gic-v3";
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;
-- 
2.19.1

