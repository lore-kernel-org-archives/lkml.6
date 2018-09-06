Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67935C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E2520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cixBin4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E2520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbeIGBmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:42:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45441 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbeIGBmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:42:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so5529855pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJIPFG6/l55uECh0YdRmKoWJkw+DIM5LFfi5ltyGq7E=;
        b=cixBin4VnOD7UYhjMKSdjDnGaat+AfVeaqHbcJC2eCI/SqnuXHYuz9KipK/3SwufbI
         q3DuOk6iJ1BPYQ9KjG62oKbIp2sPfxc0yd9yw95/USOKmksGi+eopU9oAcYmrT3yBnZB
         GDjpDy45EYAE2x6mv/xV0zAgLZ5myZgt7Cc7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJIPFG6/l55uECh0YdRmKoWJkw+DIM5LFfi5ltyGq7E=;
        b=ckSsInkidBW/SOfd8o2BOizFa7eK3fXSuAIpsaBrd3o0CPpfq1zDPtYryN+hWnxyS4
         5z2TmjmEi+H3jiaMtxK2SlSA84lsAIxz5apOJ+iTqegld9c9nkBQ2ylu/9XeNDcjQzPF
         WluJfEVODIfZc8dAmYHiKNxyvRKx1oe9cpJ/cKb/muyY8+bxLYVaNnV7mp6vZ6ID+tR4
         Zd2yzBfDcmiThpiadq+f+GOjx+ulndmQC+95oasEDtnGCYxvW/JoIsnH98oIz3TC+nQ9
         kJySXKvHqPJLuxRA7kQ3YaVC02uLXcBUlY/etQ4pzhwYg/M4Leo3XpNgFw1bCR08hg/B
         yMPw==
X-Gm-Message-State: APzg51DXUtwdI12f23kgpM9bmXdViNX1VcowlLEZGNix1Joyq75B6N4E
        lAwM3hP+onVB3gz24SlxogL74g==
X-Google-Smtp-Source: ANB0VdZF93uhZxGe6rIzBbOEgFEPheFjldqp6luHmn8Du55gU58j2rHmupKykeruz1HlPNH43KKlKw==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33-v6mr4653459plb.218.1536267935841;
        Thu, 06 Sep 2018 14:05:35 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8271288pfn.123.2018.09.06.14.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:05:35 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date:   Thu,  6 Sep 2018 14:04:54 -0700
Message-Id: <20180906210454.247219-4-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180906210454.247219-1-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a channel node for the die temperature to the ADC.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
--
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

