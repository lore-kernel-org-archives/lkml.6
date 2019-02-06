Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1FDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B59E218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAjM/UgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfBFFNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:13:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39531 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfBFFNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:13:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id f132so290736pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e9TQnw+GQEem4vsP/p8L7vayUTg3Ai1uL/Urr2XtEmY=;
        b=cAjM/UgE6MuHRLilAUObMjjGRsfkWIyxCExhRof6s0tug8FnL2MAyl4ZOPx81HXZUY
         0F6ZCuCd1jNVpoQqJnzfT/mNklL9TRykk10mIzQLHkyxZ/7lhA+gmfbGgRBUtJ2dpPiv
         To4fVD3JCH+/dMwl4qsSsj712tjVs9Tu6k8mn8Z7J03qidFdpblbkJHfX1xScGL+2/pq
         G+YWVXV+oJEoa+V8/Pyrb4/sa9Tka+L6SkC5jg6mqu1bNLBCt3iyeeAdzZVkdqG1+f4d
         XWApgEA1izlwSTPMI9jOiwWicqFclIednmmJBIfNTAU6/nnnluRHJXiNmmuD/WUkthRE
         oGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e9TQnw+GQEem4vsP/p8L7vayUTg3Ai1uL/Urr2XtEmY=;
        b=aiEXQD0DmmxyazkV5zBASkDj2r+S8YgvsomlX7MS5iY6VwCLVIP/hyEcp6FYgmQpka
         vaxcXRFI57WsoiSObmno49z0F8yIMzbux2+QEwrRnEDR5NUy2Z1LyjvtEFOsnE1aPxtI
         WlRFjhwng9SKbQu0UjCC2pWnU4ksenVhH/xpPeDZCWWXa4hpHaQC34qMqs4O8SRcu8U6
         Gg0U8ArjOjGNW24LIgSZcfgooQl95cHUPZI9iukVALKgDbuO8cV5T1PTqM2FwG9UyTTW
         +T11/FBQIiBhqV8RyekT2eVyLhEucU7NdDdhhZ34NEGWM1ll66fzhO5OFDq4t2VRulDt
         +IyQ==
X-Gm-Message-State: AHQUAuaclaMw9wkl8RNKHaV3v8kerfFM5m2akHK8CzR23f1rW8jQ8j7m
        skNEiDp6N9Ez6Z8ftBEGbxYOlA==
X-Google-Smtp-Source: AHgI3IbL1UvBWlxBLUCwp1lvJ/UIe9qh4zFlPhZU3mADvZuH8TRrvd2Rq7SkAF6OcWEonxD+zmUL2g==
X-Received: by 2002:a62:2018:: with SMTP id g24mr9040936pfg.100.1549430024417;
        Tue, 05 Feb 2019 21:13:44 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71sm10735012pfi.123.2019.02.05.21.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:13:43 -0800 (PST)
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
Subject: [PATCH v6 2/8] arm64: dts: qcom: sdm845: Define rmtfs memory
Date:   Tue,  5 Feb 2019 21:13:29 -0800
Message-Id: <20190206051335.23799-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206051335.23799-1-bjorn.andersson@linaro.org>
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the rmtfs memory node. As the memory region specified in version
10 of the memory map is only 1MB a chunk of unallocated memory is
chosen.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- Corrected unit address

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 16a060063882..a33d27b3a389 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -103,6 +103,15 @@
 			no-map;
 		};
 
+		rmtfs_mem: memory@88f00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0x88f00000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
 		qseecom_mem: memory@8ab00000 {
 			reg = <0 0x8ab00000 0 0x1400000>;
 			no-map;
-- 
2.18.0

