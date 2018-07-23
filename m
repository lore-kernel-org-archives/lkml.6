Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02720846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehSvf2q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC02720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbeGWHLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:11:08 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43193 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbeGWHLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:11:07 -0400
Received: by mail-pl0-f68.google.com with SMTP id o7-v6so7799030plk.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NkthwwEMi7a4yyrhFCNi+MJpK1lyOUPQFCvHpXCK/FI=;
        b=ehSvf2q4bgyD1rOtVRN85iwNczGNSEnX1XdpFKm5kw8STBiIQljxglLbgbqfr4itot
         sDoXqFsHYvmeVEIdloeA6glXv0Y6uIYrZYt5RD08oT2Y6ldVOBN9VqSOYRJGLs2zk/CB
         d89H7qxQETsHil+ozUS5zvv3SAJGLlBRWn02w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NkthwwEMi7a4yyrhFCNi+MJpK1lyOUPQFCvHpXCK/FI=;
        b=obkhNvBBQFxSNdiZ0iEtmK53Booi/jFiWL6swaokltrn1n69EU3/ux1V/04tNjtWAI
         bIeami76Qj1x0WB0+85r293IYmJXaVaTZw1FXCFKW9rYTVFlLGUNCgLEeCd1W0SwZLTE
         3xAoOQD9BQaOybEAINkVgUQ37Rl4YaBmyrUn4wO/75Lgj/rWyjsrBqwoB/AF8BlHVQ7N
         0dDilI8dym88BEfZfmiAmPIxFHGuy0EkbHsh8qIPSx34HKnGFIZd3BU94ejc+d10c6RV
         B9USBJ1SjzrdW3ZbsgoAB5Vha8ZuL/dwlKb3vbbp0wlHlAaRZWeR0LFoHA8axReWXwV5
         MOvA==
X-Gm-Message-State: AOUpUlGfrreLKDgzgOB/KHoDT5LVTqaGeETOLHdvoIucfm7JtJz74yff
        GTX6a2TR8YmR80g3td9jiaclrw==
X-Google-Smtp-Source: AAOMgpeGPVND+tdvQCXDTElPIXzfIq2aWGJiQVxN1QZVq22+CPSdGHOGJYfHl9kC6KwrgKExHjdwxg==
X-Received: by 2002:a17:902:18a:: with SMTP id b10-v6mr11826486plb.62.1532326293671;
        Sun, 22 Jul 2018 23:11:33 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 8-v6sm11972303pfk.132.2018.07.22.23.11.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:11:33 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 5/5] arm64: dts: sprd: Add one suspend timer
Date:   Mon, 23 Jul 2018 14:10:20 +0800
Message-Id: <daf81b1cc8dd6048a9fcb7682a5937b72eb46dfd.1531881619.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Spreadtrum platform, the current clocksource for timekeeping will be
stopped in suspend state, thus add one always-on timer to calculate the
suspend time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index e9db910..eb6be56 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -146,6 +146,12 @@
 				clocks = <&ext_32k>;
 			};
 
+			timer@40050020 {
+				compatible = "sprd,sc9860-suspend-timer";
+				reg = <0 0x40050020 0 0x20>;
+				clocks = <&ext_32k>;
+			};
+
 			hwlock: hwspinlock@40500000 {
 				compatible = "sprd,hwspinlock-r3p0";
 				reg = <0 0x40500000 0 0x1000>;
-- 
1.7.9.5

