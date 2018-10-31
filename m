Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED78ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4A020840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZum8nXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4A020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeJaS2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:28:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43496 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeJaS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:28:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so15627220wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YT2BGL73pI00O7JsdMy6/bfTMju1hXp1TWklR4ycj/Y=;
        b=BZum8nXLTQ4NN966TU5Ngk/Fw9BfsYRg3AezKMn0W/0NnzF4JHYdoxnWX2otpQY7nq
         aJ5rNEnIqV4EdmjoG8rYDO3DqRMVPJdLTlk4yAtAHizGIHHsAqNyybbtYK1sU1fYHpzT
         16ITGm0vTNp4UO2j1RqijxyBtY1o+dutoj2sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YT2BGL73pI00O7JsdMy6/bfTMju1hXp1TWklR4ycj/Y=;
        b=TTyb9dkv1hSf7PxfvsqOvZc+OM9d78E7kDxfcrm9PebzEMRkhiE9cM5BF/F/+yTiUS
         +bsjnN3lq0z3NLjfrRtLBMLBaQ03M5lO3Fgc/9rCyvkJCBommxwQ96mmy6NNeUY5ZK0r
         6gTcgiFc+p4BGtknV6ij2qAMf8hGhoRvnM0sMDj0/74gi02sP7QZfyreZce8P5Pf1BsU
         gVOiScsZkSO3HtN5RnTUMc7HLvFaskAK2/J22muDcqOtvCkdkxE+HljX4HFOvGW/HyNo
         BXWteHiy+i4v2W4K1+f8Dlu2ljrdICLckLAZsUl+HplspAYsjOncftSTehjbYJA4zcdU
         PK4g==
X-Gm-Message-State: AGRZ1gLEMqgxnHZEsDryKG5N+oIRzrNuHbie/I7pK5VsV5aLDqe7s4Al
        qAznSUopYaFjHzKtvFUjimyUyQ==
X-Google-Smtp-Source: AJdET5eKYC/7D+pc1y5wcN4lTTcmB32J+l72dNO2mYye69Sc9Fue++6Bntxs0gBclQDyvVxGsKmq2Q==
X-Received: by 2002:a5d:560c:: with SMTP id l12-v6mr2038566wrv.281.1540978254624;
        Wed, 31 Oct 2018 02:30:54 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1086:999:fd1b:8629:a7fc:68b])
        by smtp.gmail.com with ESMTPSA id w14-v6sm10737377wrt.73.2018.10.31.02.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Oct 2018 02:30:54 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 3/5] ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
Date:   Wed, 31 Oct 2018 10:30:30 +0100
Message-Id: <20181031093032.20386-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181031093032.20386-1-benjamin.gaignard@st.com>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare hwspinlock device for stm32mp157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 185541a5b69f..9b16c28f8ac3 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -803,6 +803,15 @@
 			status = "disabled";
 		};
 
+		hsem: hwspinlock@4c000000 {
+			compatible = "st,stm32-hwspinlock";
+			#hwlock-cells = <1>;
+			reg = <0x4c000000 0x400>;
+			clocks = <&rcc HSEM>;
+			clock-names = "hwspinlock";
+			status = "disabled";
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.15.0

