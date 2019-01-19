Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DAEC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB692086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U0WVcMHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfASAAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:00:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39441 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfASAAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:00:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so7343162pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQru0ZtjCj4tH1acvKM1FH9lK8e+6criBQjkrVcg/5o=;
        b=U0WVcMHAXlgEtTRXrunT7DHmBR5HVGIcmDD6NHcoftpfd4TbM3FHNLf6lC7XY3wKwu
         5r4xMWaxvbwsu0ZiZEEece+JBlBbvbU2WTN6GGSgxFSkcQao2iZHAgHCaEysDinskO2F
         OvzT7WFNXBdCxW/kibf3aph8u68DfehiYEtsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQru0ZtjCj4tH1acvKM1FH9lK8e+6criBQjkrVcg/5o=;
        b=YFHKy4XvcMyykqxPdYxZsiJNNGTUx6ZSguh2Tm/LfRVuY67fLBJiVW3s0OyItWSm7B
         dNpuV0UQf71GnxHu90uQD5CiBlyNAXp9eT7NJfF1Qqs9BY6THObDE5HdF8Fr7tozLjiR
         lvOfHumRnPHQ9wNLSPbh4zibNtV1f07A6N7AUIbzynxeUh7ivcDUAuZ6ndvtQ7mNBj4M
         eN2MaOogIZjvyO/glCMR7vNxS4ymuy1rUhQibqMvEXkksgOZDuQe3nile9CvByupr0YG
         uS3tHP8r9wnAB4Wk2d3tJEI8JNtpxXZEZZe0ycpdIj8DeseIoEhgGxm3X4hQ5uYd+IJT
         dzyA==
X-Gm-Message-State: AJcUukedC6D+k1tUVSX9h+I5/WLesRdcP7JGA/yhukeUAMltPMUt7E9S
        H3JdoQ+xWWddh/0yKRIeA0ldgA==
X-Google-Smtp-Source: ALg8bN5b+l/blDpXz0bBpVc0UWOAf0zgmW/Hr9h6iXHTku+yjv2b5s7UL8AypL2/3Q2cf3ndfsEbLw==
X-Received: by 2002:a62:26c7:: with SMTP id m190mr21641089pfm.79.1547856036248;
        Fri, 18 Jan 2019 16:00:36 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id m3sm13066900pfi.102.2019.01.18.16.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:00:35 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Govind Singh <govinds@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] dts: arm64/sdm845: Add clocks to WCN3990 WLAN module device node
Date:   Fri, 18 Jan 2019 16:00:15 -0800
Message-Id: <20190119000016.139657-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commit be7019103469 ("dts: arm64/sdm845: Add WCN3990 WLAN module
device node") was posted upstream no clocks were specified.  However,
when the pack was picked into the Chrome OS kernel tree (allegedly
directly from the mailing list post) it had clock properties.

I presume that the clock should be there, so let's add it.

Fixes: be7019103469 ("dts: arm64/sdm845: Add WCN3990 WLAN module device node")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e4156ea320aa..f99424fc4df2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2211,6 +2211,8 @@
 			reg = <0 0x18800000 0 0x800000>;
 			reg-names = "membase";
 			memory-region = <&wlan_msa_mem>;
+			clock-names = "cxo_ref_clk_pin";
+			clocks = <&rpmhcc RPMH_RF_CLK2>;
 			interrupts =
 				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.20.1.321.g9e740568ce-goog

