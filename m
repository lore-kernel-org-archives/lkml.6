Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0449AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B216F20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGHG9927"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B216F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeKFPKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:10:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36255 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeKFPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:10:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id z17-v6so5315528pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ZeF+kAyK15pjP+Yr+/pWxXTXoG5eNAVYz+WyoJvFGk=;
        b=iGHG9927YgmW+7xGwZbKb/g1NQiwEzQ5JD/u4JzLGlAK0moVMX/ngtxZaqeMcTL4Wh
         ryGDj2xdIaEQ2EsmHyRUBBmHcxJMy8WKep9N+N/SANCJ+Az31SIzbI2BA/eAreoUCR/0
         l/d55jENqV8lGgYfmN6uwzHiBWglQwFfaTKW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ZeF+kAyK15pjP+Yr+/pWxXTXoG5eNAVYz+WyoJvFGk=;
        b=oE2Xp/CRv8iX3hrf6XQJJfYoJM6gecd+AoKtUYJNCXskbGZBPBf2KXWvxDp4uhTA3L
         9jIsqL9VpNJUNbgGwhliH7HlPgny6QOaQX+iLOfQXpm5AKsTel6v1N0RpdgSJJPrqGvX
         /bWLAaM/6dzJDt5Gnh4Uo+WTO1R6vS4ePYRbNtRCWGMNr4yGIWd9B9L6EhKhN/oszf50
         O0d+RSBh4E+HwpZU0GfYP709G5OBQogA2yDN4wCBgmkB1OHQ320eG4neX4DSQu+JrXPj
         xcRVb29q5lf7sxhrB0j8ys1rFXSudjoo80c4icY0GTDu28L06W4DEdRzCiN0w8ArCcnV
         7s6g==
X-Gm-Message-State: AGRZ1gI+gFRKllQf/43rcFT8Z9BPwhfy5v03BPFuJNyve390Jbk99gZR
        jUF+eJiCS9QsXUu3m7/RvQtN0Q==
X-Google-Smtp-Source: AJdET5dL1Aqqcw0y/EeNif63HTNXec1E1Qwid5AhYK5Q6122pjqW+pAK3EMWCTq0ry+uh4U5fg9pQQ==
X-Received: by 2002:a63:3287:: with SMTP id y129mr22829950pgy.337.1541483193746;
        Mon, 05 Nov 2018 21:46:33 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d196-v6sm7855817pfd.58.2018.11.05.21.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 21:46:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845-mtp: Mark protected gcc clocks
Date:   Mon,  5 Nov 2018 21:50:13 -0800
Message-Id: <20181106055013.11271-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181105194011.43770-1-swboyd@chromium.org>
References: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of v4.20-rc1 probing the GCC driver on a SDM845 device with the
standard security implementation causes an access violation and an
immediate system restart. Use the protected-clocks property to mark the
offending clocks protected for the MTP, in order to allow it to boot.

Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This depends on the acceptance of
https://lore.kernel.org/lkml/20181105194011.43770-1-swboyd@chromium.org/

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index d667eee4e6d0..b3def0358177 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -343,6 +343,12 @@
 	};
 };
 
+&gcc {
+	protected-clocks = <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
+};
+
 &i2c10 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
2.18.0

