Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CFFC43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B421420865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+uhfl/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B421420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeIKH2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:28:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46846 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeIKH2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:28:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so11414566pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DddfjiWU+nwLV/my5PU24VcyaUhmZjI44x/ThHNh0Tk=;
        b=j+uhfl/U8EPzNC5u4IHMKyxmtgSPMg7Qul3odF16PuqbtGpjjKQTh7Ata8B4PX2iWl
         hPmlaOtwL4cpzfuqjsndSokrUbYZLD5SvQvBfL6NiuO3uOihzVC4P1yGXj4njHzrx33b
         v0B8xetQiD6JjR3VKfJgUwt6IxQWVniJ9gWLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DddfjiWU+nwLV/my5PU24VcyaUhmZjI44x/ThHNh0Tk=;
        b=hZovXl6YvvqfkSuCU5WahTRs2VF/G4PfM40u1su9IBns73b95wbnLtKsmOmWvV4Wwr
         8+QrSm1fWEcZswqYKwWwYy7q/Byiut7t6zZqewsWfKudONW8vEDJWuhOtMz68d180Q0H
         G0sruHWsYTC1UCrvmmN0KQnBsRyTLVnZh+Ly5kBOyscp6mpsRSNy8xfCXh0cLR8qdR+4
         +oI6PDv6lEdEaqLlvHPr+rnLkYxe+vsWdvqD0SfHjIIeNimLIIdEvVdCqOlv8xdUeG1O
         LZgrnE4qiYJpW2bGpgI8jFMCQStEU363Y2Y/GWKvhFD79weOhCuMQXOYl34OiNmY7AQi
         eXdg==
X-Gm-Message-State: APzg51DMG8zWjoi4IWEmpg1CZ+mpyirphJZZt6cSJ12h7dAkbx0j2Ptb
        BkfC9YMr2hAltDOWmO6nKbPQ
X-Google-Smtp-Source: ANB0VdY7bxv1OM//e7kEvzNeBNPZAwg9f+WioG0WTzpEb7JHf3MZxrHug1GjgrKpUYSgvNZP+uhZ6Q==
X-Received: by 2002:a62:6602:: with SMTP id a2-v6mr27064325pfc.159.1536633083690;
        Mon, 10 Sep 2018 19:31:23 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7200:d313:f895:c3fd:ee92:ac72])
        by smtp.gmail.com with ESMTPSA id y85-v6sm27025893pfa.170.2018.09.10.19.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 19:31:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Enable SD card detection for Rock960 boards
Date:   Tue, 11 Sep 2018 08:00:31 +0530
Message-Id: <20180911023031.4892-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For proper working of SD cards, let's add the Card Detect GPIO property
to the common devicetree for Rock960 family boards.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 5a5d8e28ef55..f68254831ad9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -403,6 +403,7 @@
 	cap-sd-highspeed;
 	clock-frequency = <100000000>;
 	clock-freq-min-max = <100000 100000000>;
+	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	sd-uhs-sdr104;
 	vqmmc-supply = <&vcc_sd>;
-- 
2.17.1

