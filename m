Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B1F20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ov5okNR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B1F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeIJU6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:58:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34210 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbeIJU6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:58:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so10719377pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pn0YO/ycbcj2ZZfDPJRgtsYZBYJvTqJrPHsXrmqWarY=;
        b=Ov5okNR3CGie5rIXoOGAvmmQH+euUCIyoe6s9+BwBFaVp1eTWJXjYd3+GcM/wlgu//
         H/JUGUpXj2z0McqQWqqrxuBHxNH6exYw//l4stS0x96h5IJWzzyf1Uwl8kpDv85kgls/
         gXlrmgH7czrPhH2/UA8QbbqxtYo60orrtE/YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pn0YO/ycbcj2ZZfDPJRgtsYZBYJvTqJrPHsXrmqWarY=;
        b=dJw9Nco+bNvkXiVFPYT13egq7svR+oizwWf3R+DST/fllyNcaH81GavEsnd3IwUyKH
         /qLWdflUe6JzvHgbxpe1s4NYu8dYICxVgdaP7A8AGK0uHrVUPHSxyZvncls0Upqshd2G
         G2MADBkk66viQTMiYvdFz4AnEHZSLrCiW3qe4G7rwh4sz1veIbCbdQ3qUdFpJ1LLzIeu
         Ia7XCRQMmypiWOhLro6gH/qUytG9OeJZnBTk21fGYcbWVGY6ti8Aps9UaaSDOQEjEVh6
         +8t5PABu924VreTBvy47sDpyLwe2VYcNjqmOaPx9gcCK2TbTodjZbnY6dfjTJoitRPlM
         w43A==
X-Gm-Message-State: APzg51DpyCiwklQcYnaZWqGIoK1BfL/CO+1/ND1HmtT+35UbpWh8YEGK
        xwYgfFeTB7erEf3v/VCRSrb8mw==
X-Google-Smtp-Source: ANB0VdbhfLT0orMwGgdB8llK8YdItQGxlDdjetki6Z+AFQteCBygkglyf29f+shra5QqSbVuWkWWaA==
X-Received: by 2002:a63:7058:: with SMTP id a24-v6mr23176159pgn.206.1536595425877;
        Mon, 10 Sep 2018 09:03:45 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b3-v6sm33893517pgm.74.2018.09.10.09.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 09:03:45 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 3/3] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date:   Mon, 10 Sep 2018 09:03:01 -0700
Message-Id: <20180910160301.237538-4-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180910160301.237538-1-mka@chromium.org>
References: <20180910160301.237538-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a channel node for the die temperature to the ADC.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v3:
- fixed separator in commit message
- remove duplicate 'Signed-off-by' tag

Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 41593ebbea2c..d18d4f260fbe 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -19,6 +19,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
+
+			die-temp {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
 		};
 
 		pm8998_gpio: gpios@c000 {
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

