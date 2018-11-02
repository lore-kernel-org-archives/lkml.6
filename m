Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D558C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0110520657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cyxa2HsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0110520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeKCGut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:50:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45531 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeKCGut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:50:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4so1079594pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sZCLfTgtZcJNkqilv33qyExYx/YciuwDbR6uIPzORe4=;
        b=Cyxa2HsYDi0MFk4JjYxlu6bqWk2fJUcwhLOdFdLYCxcef2kBzSU1IWa6BicFhedmO4
         ZGv4BmdRDGCwm3B1QGKADseUajaW0SaSTTDArdaDyLFRCVx4YFi9oLAolTWeKVeiF5kz
         OHbmWRKCCd5JK8t3Z4QJv1z13Pi/SjWnvH66s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sZCLfTgtZcJNkqilv33qyExYx/YciuwDbR6uIPzORe4=;
        b=I8/TGEzO/7tMWTj+yourgi5l4hqDbiSO/AQMdSBbdBRC30AfYgLTvoXnRexaahWBi4
         ZxkI0EYo1fozjHetQRJNuNjNz6Mb+j1bBVc3uxlD9ijxekcdytf2aMbZq/GHgDiO+38f
         s0c84FUO2yW9DHeL31c5FgtssGuiGDHzvw0YALp41yg2kpnuhnRsJytr+PrG2P9X2/QU
         cl1jOHt76AGkXEUnPuVDugO0CpZQQh2dggOlYYaR22deIu3Ojvfu4XPHDmmGmUBNo6nu
         yHH3bgWLs7mBieILnJc9HHmvL2MuKQKFScPYN9QrwJKVtwh4F2wzXGFqbWwz8cps5VO2
         tA2A==
X-Gm-Message-State: AGRZ1gIcwJYKG1lIYR/+YENRZAsbt2+Ql2aiDQY1sBkn8t3+RsVBZicr
        wz4G8JmZZc7IJS2NQXW9Zu/V1Q==
X-Google-Smtp-Source: AJdET5fWurVv/sG2K/Ns92y9ayw/XB5lXKKF2p6dtix/oXgdzIb9papRaCTGxYiqFsUSven/HTsuxQ==
X-Received: by 2002:a62:6b41:: with SMTP id g62-v6mr13266093pfc.106.1541194920227;
        Fri, 02 Nov 2018 14:42:00 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i88-v6sm18880123pfi.66.2018.11.02.14.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 14:41:59 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] arm64: dts: sdm845-mtp: Reserve reserved gpios
Date:   Fri,  2 Nov 2018 14:45:32 -0700
Message-Id: <20181102214532.17661-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of commit 3edfb7bd76bd ("gpiolib: Show correct
direction from the beginning") the gpiolib will attempt to read the
direction of all pins, which triggers a read from protected register
regions.

The pins 0 through 3 and 81 through 84 are protected, so mark these as
reserved.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Given that mainline has not yet booted on the SDM845 MTP or MSM8998 MTP
(which seems to be the affected platform), I think it's better to pick this
change than to rework the offending commit.

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index eedfaf8922e2..d667eee4e6d0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -352,6 +352,10 @@
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+};
+
 &uart9 {
 	status = "okay";
 };
-- 
2.18.0

