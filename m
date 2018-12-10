Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96B720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SI/4PwcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96B720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeLJKXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:23:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42777 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeLJKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:23:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so9846542wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2KRU/g/GisxnlaqWW4HcsfIO+AdwGpDB+M+SNsZ+gc=;
        b=SI/4PwcMDJaCE/vholFjokX+8AzcbogsxRh952zVJ4LMzH6YMFfIZ4aWzP9IzWQqFs
         6rKKkZk1uTNu28fnTWkWiVJZINhnyPBm1MOpsIl3zsr4AtGdBcOO7r4c0K+FRxE32efl
         wtPK8di7fJRgb/mLPNIXK+mhgXjn/06fDK+X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2KRU/g/GisxnlaqWW4HcsfIO+AdwGpDB+M+SNsZ+gc=;
        b=dlaLtZmFpWT0g04B0EC3WfGi7uycW0vE9qwXb1OLHjtQZ/hf21wKnJpajQPxqJdBOo
         /dxw9KdomYMBKOaVHh2PijV1szx0+uYe9eITFz6PoV7umpGqEu5EX608WKKx0BBLKEah
         1AJJuybPlmbDJuFews6U9lCd1uusVVw0ifgzL7hONTzSSbPCSvDq5q0Capp80q88REoP
         zPBjeRi0G3FJgK+smzx9vnTxwgfTy3ooft9YrK3DuPAWIQJCsNLwQ90uxrDQmlAgls98
         ZoOXYamvXl7UxsHWJRw3HDuC+XRStMJ9oAtdevXxIto//DUbYYi6X+RhC8Ti8YYiNA81
         a1xQ==
X-Gm-Message-State: AA+aEWb0twkWZCx94hKY2rWbbWhPRJSOgUQ+UT9vUMXcgekz+ZWeP0NV
        KmuLCbwn22Rv74xgFA4U+qkVhg==
X-Google-Smtp-Source: AFSGD/XBPyKVqVOtGr3PV4sGg7Qyi6ZYrnZUfaW+VvkUHg0CVz8JTWpaBhn1vOYKzcAkWlrfDUXgIw==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr8990360wrq.69.1544437399815;
        Mon, 10 Dec 2018 02:23:19 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id r64sm12266664wmg.5.2018.12.10.02.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 02:23:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 4/4] arm64: dts: add msm8996 compatible to gicv3
Date:   Mon, 10 Dec 2018 10:23:09 +0000
Message-Id: <20181210102309.8207-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
References: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible to gicv3 node to enable quirk required to restrict writing
to GICR_WAKER register which is restricted on msm8996 SoC in Hypervisor.

With this quirk MSM8996 can at least boot out of mainline, which can help
community to work with boards based on MSM8996.

Without this patch Qualcomm DB820c board reboots on mainline.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8585c61e32ef..cd9650cea05d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -404,7 +404,7 @@
 		};
 
 		intc: interrupt-controller@9bc0000 {
-			compatible = "arm,gic-v3";
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;
-- 
2.19.2

