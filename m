Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8CE206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGBCzkC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfBOFuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:50:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34388 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbfBOFuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:50:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id j18so4314166pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+28ah16ssp2zUlQ08ousTOH5MdUsrEXHyb5TznP/Xc0=;
        b=DGBCzkC0cmXtmaogSMqWCCj1CQSsyzp/9IPw9txdvx0boTDHpDgJdxlTaaeLznzIvz
         X6Nrqjvq9INr+lU0ku2eHwR+QQLsD/cp+TmmlOQmQsZ4Fz3QDg7SD4T2RFgAopBa23Fw
         ml/Ml6Hk8dyV0TkQfocLIjVj59dfANuucfiLqc0mjqBsT/4P8mUWOCKK1DtN5At3WEEP
         tkAb5V467FaYtxkwV9YrqlawLNC3XmwxK8mkLMZjS0xB/TeryNKE/S/xyBvrWZ9cwZVA
         er1BfYFf3BxXDPRkk+NotXddoLgOWSNgH4VIZpCvN5l+GDyo4gO4NcHh7nthfuWq5mah
         cU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+28ah16ssp2zUlQ08ousTOH5MdUsrEXHyb5TznP/Xc0=;
        b=rP7HEpJjZ69rAieyhdBjd1i+Ieq5ii98Fs3kEb7vVPGcUAOeCYmEpm7KEbaX5+IOcK
         s/zwQVOocziFjaeM+sWxohDguYkEkEaqXUYh9Hs/kG1gTOjT0e4zHPsDj0xIgKCckw58
         EPeSo0XE6KfIy7mHr6zIMERDC7LNpgVAwahhBTFTuqt+7QwcKcx068IVg1Ycmi0E8ggl
         lbLS+TPZZlbGuWFcz1K9QK6jz7WYoklakdKeG23pCNf0vAf7a0ugVZO6ndbEe8wJt2v1
         AP2PSogV5EZ3EidaPA6l0nyx9LozLV2xenfCEno8sfzj09ueV1iaquYAYBNlB7BK/c1b
         6KNQ==
X-Gm-Message-State: AHQUAubH+UvczptG6FJ+youGH+ndIcVG4V5RTChSW8/F0FbhbDxe5Twg
        Q3hAQWMJIPTMj2QClfHH8Rzt
X-Google-Smtp-Source: AHgI3IZAaKvBbSAzW7L+1qiChviVMumolz0prwc44USYG31JQ2InwoQD4JzHgnDC7Xd37e/C2zwq5w==
X-Received: by 2002:aa7:819a:: with SMTP id g26mr8029156pfi.187.1550209819674;
        Thu, 14 Feb 2019 21:50:19 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98a:c91:14c4:f458:9909:7fad])
        by smtp.gmail.com with ESMTPSA id c18sm6160810pfc.63.2019.02.14.21.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 21:50:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        john.stultz@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: hisilicon: hi3670: Add reset controller support
Date:   Fri, 15 Feb 2019 11:19:55 +0530
Message-Id: <20190215054955.788-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
References: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller support for HiSilicon HI3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index a5bd6d80b226..2af88c429c97 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -151,6 +151,12 @@
 			#clock-cells = <1>;
 		};
 
+		crg_rst: crg_rst_controller {
+			compatible = "hisilicon,hi3670-reset", "hisilicon,hi3660-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&crg_ctrl>;
+		};
+
 		pctrl: pctrl@e8a09000 {
 			compatible = "hisilicon,hi3670-pctrl", "syscon";
 			reg = <0x0 0xe8a09000 0x0 0x1000>;
-- 
2.17.1

