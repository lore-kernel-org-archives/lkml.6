Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA37C4151A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB67218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXFiE3TJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfBFFNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:13:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34466 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfBFFNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:13:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so2581827pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6eBUJRtxTOfCi5YseNIZQjzHG28hQt9IsL5ROy/8BF4=;
        b=eXFiE3TJp96F2GlZiaJR3MD+eVMpqVUSw/7P8nOrNfHdev5fVN5fZlP4fbi6H2OK69
         8Qz9+8L4Qk0et7vriyydSqaumgqpqJkyK3Sno1PZ8Vp/bnCyOzXKnns5eKuNkV2lQC9P
         7TQUjYCKTvcVRSkcjKucaRy3v7WWxdowXsJXzT8GFs/1vPwmN3GgtRQFK+JgCNVAWkrW
         SpcuHZ5UnZzWzQ2sdDwUdapIkJT2rUwWWrJuUGi9AEN8w4bq25w3ztpkfnyCdOYsT+rF
         wmnrEOQFoSMBUWmksFOWzrzypSneaBFF513yvYHB1i91Cflkeq9tD6bDADBU8DKSLRf0
         lEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6eBUJRtxTOfCi5YseNIZQjzHG28hQt9IsL5ROy/8BF4=;
        b=VM01QquxiNVGBvnVYvbocF+3QbdtbJE8kabkxnEOWvR1+wMuJ9VrWCjrSkkhUiWxky
         YBy0rjO/gVIwZqC7XTqV+s/Y7yq3wqdKNTbVoj8+qzjI7VFLpxuvNFOWcOkVN5YZ0SYJ
         Lrl9Vgp/0tjmphjRkEw3PKK2+uXasyJGps3J11KDyiHCBySv/ndmWIgEJQ8zQEljziZv
         DevTudKKzFAxqTrPNYoT2VNDVreKazmwoM+E7JjPoKDJHG0MEWimpSdlq3i06TRbBZdt
         s1WG/a6CVdQOa7GACIpT+0sCqR647IO79zEqXzSlOaA1bmElQALQ5Lup/TDSDokU8N8d
         4RPA==
X-Gm-Message-State: AHQUAuYHRgIldI6R/XxVm+MZVmzEL7Eij9Q1CBKQi2de+Mi5xLLsT8Iq
        X2jgMulbNRNwUVtqPfHHuIz+U1EUTW8=
X-Google-Smtp-Source: AHgI3IbCAy/wc+nzGXR/axugq1SPziZvKkWbBQdHtKnrdQtShjdxcrVyszO6UPa3Pr6GDD2zPRZrew==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr8517917pfi.95.1549430023090;
        Tue, 05 Feb 2019 21:13:43 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71sm10735012pfi.123.2019.02.05.21.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:13:42 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/8] arm64: dts: qcom: sdm845: Update reserved memory map
Date:   Tue,  5 Feb 2019 21:13:28 -0800
Message-Id: <20190206051335.23799-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206051335.23799-1-bjorn.andersson@linaro.org>
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update existing and add missing regions to the reserved memory map, as
described in version 10.

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- Replaced a few 0x0 with 0
- Corrected size of tz_mem

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 74 +++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ade2f385507c..16a060063882 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -72,29 +72,69 @@
 		#size-cells = <2>;
 		ranges;
 
-		memory@85fc0000 {
+		hyp_mem: memory@85700000 {
+			reg = <0 0x85700000 0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85e00000 {
+			reg = <0 0x85e00000 0 0x100000>;
+			no-map;
+		};
+
+		aop_mem: memory@85fc0000 {
 			reg = <0 0x85fc0000 0 0x20000>;
 			no-map;
 		};
 
-		memory@85fe0000 {
+		aop_cmd_db_mem: memory@85fe0000 {
 			compatible = "qcom,cmd-db";
-			reg = <0x0 0x85fe0000 0x0 0x20000>;
+			reg = <0x0 0x85fe0000 0 0x20000>;
 			no-map;
 		};
 
 		smem_mem: memory@86000000 {
-			reg = <0x0 0x86000000 0x0 0x200000>;
+			reg = <0x0 0x86000000 0 0x200000>;
 			no-map;
 		};
 
-		memory@86200000 {
+		tz_mem: memory@86200000 {
 			reg = <0 0x86200000 0 0x2d00000>;
 			no-map;
 		};
 
-		wlan_msa_mem: memory@96700000 {
-			reg = <0 0x96700000 0 0x100000>;
+		qseecom_mem: memory@8ab00000 {
+			reg = <0 0x8ab00000 0 0x1400000>;
+			no-map;
+		};
+
+		camera_mem: memory@8bf00000 {
+			reg = <0 0x8bf00000 0 0x500000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@8c410000 {
+			reg = <0 0x8c410000 0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@8c415000 {
+			reg = <0 0x8c415000 0 0x2000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8c500000 {
+			reg = <0 0x8c500000 0 0x1a00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@8df00000 {
+			reg = <0 0x8df00000 0 0x100000>;
 			no-map;
 		};
 
@@ -103,10 +143,30 @@
 			no-map;
 		};
 
+		venus_mem: memory@95800000 {
+			reg = <0 0x95800000 0 0x500000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@95d00000 {
+			reg = <0 0x95d00000 0 0x800000>;
+			no-map;
+		};
+
 		mba_region: memory@96500000 {
 			reg = <0 0x96500000 0 0x200000>;
 			no-map;
 		};
+
+		slpi_mem: memory@96700000 {
+			reg = <0 0x96700000 0 0x1400000>;
+			no-map;
+		};
+
+		spss_mem: memory@97b00000 {
+			reg = <0 0x97b00000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	cpus {
-- 
2.18.0

