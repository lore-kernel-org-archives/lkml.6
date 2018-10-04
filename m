Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98F82098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CG40vsk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98F82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeJDHFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:05:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43853 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbeJDHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:05:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id p24-v6so2439776pff.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjCdwjVblOuE0rbT1WEw8RU8kvqJNXEgtd9ixVw2O8s=;
        b=CG40vsk2jHN/5EW7l4QPN9k6bINw8c4I8NNFrbiDNAXdaJFE9fuNcT/WU3YlHOZ/b4
         ipl4yrrTlBiSKXKCEUOKBOkckIEu0BwU6sqTOeTqU2uERJ8J5ST9msAatvuD+Al4brLb
         Zjq9Run5INNRkLehPJ3g0cxVIpa0HesUbHoHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjCdwjVblOuE0rbT1WEw8RU8kvqJNXEgtd9ixVw2O8s=;
        b=rQhOy3BSJX83LnUqk8qEPkO6EeZUv5fQh+FN7ycI+qvXnScGMteHn+RT36mgM4MW4q
         uVr8foiF7eEHAAiufJrBkbjokQ8chy5yHoAaMH4V5dPHTQR4egPIQio37WQzAn6jpV5x
         LqJeQKxOeJE3myqyrMbU98Vvagag6T5TAMnzpwo2Ncsy1CT805S/sV3aDFAjW0gNKoeY
         89Tv5MukuM5IRmksOyPeMvcgms0p1Y19d/nqc9cD5QvovuOYL47uy7SY+KlRLWqJtJdS
         DAsMKIApdpyOU3XDRqzHbfqn6n3wTTEncONeAsz4Xi+8wKrQylqLDsj8YgrnYH7e7Cg+
         go1w==
X-Gm-Message-State: ABuFfogOCRHPid3h0nJ77nTmg2pdn7pkxmKvLC2Wtv469QWS2iZepU8O
        uX4M3UmOxZPK4dN32/mL59P4lQ==
X-Google-Smtp-Source: ACcGV61QBotVraPgPIgkRYWRv1nu0MxtJ3WouaoppIHAvFb/pBQhzR6vNre4r5vOVSrx1Zx+dxSFUg==
X-Received: by 2002:a62:5a83:: with SMTP id o125-v6mr4064370pfb.117.1538612092133;
        Wed, 03 Oct 2018 17:14:52 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b81-v6sm6497051pfm.96.2018.10.03.17.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 17:14:51 -0700 (PDT)
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
Subject: [PATCH v5 2/2] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date:   Wed,  3 Oct 2018 17:14:32 -0700
Message-Id: <20181004001432.21218-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181004001432.21218-1-mka@chromium.org>
References: <20181004001432.21218-1-mka@chromium.org>
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
Changes in v4:
- added unit address to 'die-temp' node
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 048f19fa0150..32b141637d13 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -75,6 +75,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
+
+			die-temp@ADC5_DIE_TEMP {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
 		};
 
 		rtc@6000 {
-- 
2.19.0.605.g01d371f741-goog

