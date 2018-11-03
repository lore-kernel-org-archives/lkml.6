Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417DDC32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E106D20831
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaxeRnK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E106D20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeKCKH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 06:07:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39800 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeKCKH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 06:07:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so25616ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 17:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hKFtHDoeD2I3dCcTddHr1VkWXec8x2dKA2N4zzQ+PU=;
        b=gaxeRnK4UEZtCZUTx7BFLp/T5k0GAEXx+YcZCI0PJAhJCl41ATLUJb/MxuVTnzdE/n
         NkIhWF9rm8JQFvtADy3HpcUxIjsLFg03I4CBRiXjPv44kyq+s4u3VvhX9lhRMwcsO/6t
         al4Y4OjzSknwMko/icmeAABQH0zDg5YgJKNNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hKFtHDoeD2I3dCcTddHr1VkWXec8x2dKA2N4zzQ+PU=;
        b=XKxSLH9YSMmc5qF7+IWaOavVr6gnYSFEhuzz4N/7tBjOePP9b4zv8Z3+/gmfhl1Z6e
         JsJwKVWwdrpPuH4hwgbq7e4fQibORsfG6AX2Zu/zyetKS50gMIXanN8vvSlc5fj4TZsS
         vuydMqWF40NTlACz8Grh9hPxWzCrnNUy7zLF1aiH9BHHjbqGBp3O8fbZgdRpwIO1m2uS
         UeXmuortxllo+3u7AuctVac2wEY+nDaSaqBx/Am4/QQJBJ4F2DR8Dovl6agYoZdH7x52
         UvdxJerq+XFYemq2ofOXH+hklOKo8Oo/ePFsI+HWGyinfuXh/IzA/HPWWqqHTBgAcPnP
         xttQ==
X-Gm-Message-State: AGRZ1gKvvAuMWaAw+WwDpOvErFLyZFEV6IbYoDV+SJ95mmZX80jxgSp+
        9lR1/rhNA6gkiUTBSPovqP+LpQ==
X-Google-Smtp-Source: AJdET5cPCFUfBXvm0bxm5yeIn8ffcx+jtMM5gALxbzggaIXu9v31Er5nnhZa9gBSq9/T13Ek7JWgow==
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr8901643ljp.12.1541206681328;
        Fri, 02 Nov 2018 17:58:01 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id t6-v6sm5215413ljd.2.2018.11.02.17.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 17:58:00 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     bjorn.andersson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: msm8916: remove bogus argument to the cpu clock
Date:   Sat,  3 Nov 2018 01:57:34 +0100
Message-Id: <20181103005734.15545-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The apcs node has #clock-cells = <0>, which means that those who
references it should specify 0 arguments.

The apcs reference in the cpu node incorrectly specifies an argument,
remove this bogus argument.

Fixes: 65afdf458360 ("arm64: dts: qcom: msm8916: Add CPU frequency scaling support")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d302d8d639a1..e4bfd47178b1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -111,7 +111,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -123,7 +123,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -135,7 +135,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -147,7 +147,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
-- 
2.19.1

