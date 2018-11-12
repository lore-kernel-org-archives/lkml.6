Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D23C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE542241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJ3HQ4A7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE542241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeKMIHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:07:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43259 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbeKMIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:06:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so4660980pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 14:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ww6DrvJd07ctjJaJJTAavaoJC5URKjvaFE8KSQ3FlG0=;
        b=TJ3HQ4A7btn/vTCKPiNPNpWN79l6NE6duFdOjwnvC3UuFbvVCpAPqimxERtxjaivWD
         a6rsq2YvcV1a2fpgA3NVAzf32MRnUkydFoCcePUM5rdTPXOysiRQHf3svrEzccHcRUPd
         4SwuwqtHkz2X/5PSUpJuLA/9CB52j+gWk55Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ww6DrvJd07ctjJaJJTAavaoJC5URKjvaFE8KSQ3FlG0=;
        b=Y/5hxiX3inpgQWH2LHe7jXwZ4tT5ucfCHaBn7TzENvKSZfSMO6ygmIae4xm0r97U5y
         TO76nL/G2E9v9i/Me4F32cuiZ2Y/zvEvd67KW1SIhiF8bvAB/sUxpLSDSDq6KicypkKm
         3M2Ua1b6aRWJ2qRSaV4R7VF8WSRMR9JTShkNuI/nqHbSeHKMJyUDBhDmM1L5yOLIUQ7D
         Z7epJBUYy0OC/WItCcgjsbFQeqMLB5cog0UlnY8V1hW5c6XpaVOGZwcwPllcST4Hez8E
         0uSEx+V/qMNNhIdIFnnVgBv2puSxjBrjIZnccTT2RDb5JRwHyQ/mVlXafT768KSrAaxp
         z72A==
X-Gm-Message-State: AGRZ1gJ4YFrC6DtLJLFqmseswcSXwprkTdj1K57BgAMkYBl/Yr+qIIXL
        ZUoy26637ti7UMeSwvL/5rxBHnVaTI4=
X-Google-Smtp-Source: AJdET5dplwuRXxegHUk1BpOF+Gx/j7LetycuvuTn12bc8NOh9uIu3KUucbZ680/QR7Ii5OSQRGyH8A==
X-Received: by 2002:a65:63d3:: with SMTP id n19mr2413904pgv.179.1542060713107;
        Mon, 12 Nov 2018 14:11:53 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z2sm16166706pgu.4.2018.11.12.14.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 14:11:52 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 2/2] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date:   Mon, 12 Nov 2018 14:11:26 -0800
Message-Id: <20181112221126.27142-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181112221126.27142-1-mka@chromium.org>
References: <20181112221126.27142-1-mka@chromium.org>
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
Changes in v6:
- changed node name to 'adc-chan@'

Changes in v5:
- added unit address to 'die-temp' node

Changes in v4:
- none

Changes in v3:
- fixed separator in commit message
- remove duplicate 'Signed-off-by' tag

Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 048f19fa01504..f1025a50c227b 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -75,6 +75,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
+
+			adc-chan@ADC5_DIE_TEMP {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
 		};
 
 		rtc@6000 {
-- 
2.19.1.930.g4563a0d9d0-goog

