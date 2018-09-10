Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53241C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C13A20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWevnr2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C13A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeIJUJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:09:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38788 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbeIJUJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:09:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so10645047pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DddfjiWU+nwLV/my5PU24VcyaUhmZjI44x/ThHNh0Tk=;
        b=PWevnr2Lpw/bnA0HESa9iyVkClbxsJOYPlhP7AmMwy9a6c7eqqnS4kcFuumWD8eDqu
         5TyPbARtJMbdmXcn+ZyEocjr/nOC+pLcQKBFUQPkfOwz8jVZ5fKgUmR0hiIx0crIxFFy
         0qfls7qARHP7wRbThv1DW/l1pDMx20fE2zYwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DddfjiWU+nwLV/my5PU24VcyaUhmZjI44x/ThHNh0Tk=;
        b=Y/QnC2x3f7Pi6BEd9gkofVzu1PiE1ZiVlG8IsrlLs4WSTxL7C9L6xSBNquNIUoW1L/
         n5i9hdrt9FlxT/VW6r/9tGlpNoalTkUz/P1zokuk6M8gYPvdwGweluRuC5xe2vfcDKZO
         ZwXH+TTL+s6v8w5lv4MvRywZ+hAZP7Uv2Mzy4nk3NxpWcbEFz3jqvaoQZXg2aush9zPp
         cH/3EeWYJuAuIIB2pbHpgfZJjzwaTOXMJoFd7AB9wtk1MCOe2AWKh6+1bRdfqmt24vFk
         F+doxYIAZ283zB4uai+QjB7o708dsKnCNp4Jl7kSZxLlTp9TcfyxdQ/nXCFagXo4jTmr
         mgzA==
X-Gm-Message-State: APzg51BljSqwJt/6Er/yaQFh/PgjjvCD0Btu/XVeAtpiJSpP5xQ+0ixt
        81o9oMEd0wyme1xsIrd50jao
X-Google-Smtp-Source: ANB0Vda8CeIyNE1qDZp1KonBEUUFJCFFlGslTIiiPJ26+7Ys0yYeOHMxSM8/+E1iSjcD5FMm6WCxkw==
X-Received: by 2002:a65:608b:: with SMTP id t11-v6mr23620131pgu.259.1536592491302;
        Mon, 10 Sep 2018 08:14:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:728c:6bba:60a8:6c40:2817:7ee1])
        by smtp.gmail.com with ESMTPSA id e202-v6sm26703907pfh.16.2018.09.10.08.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:14:50 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] arm64: dts: rockchip: Enable SD card detection for Rock960 boards
Date:   Mon, 10 Sep 2018 20:43:56 +0530
Message-Id: <20180910151356.25946-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org>
References: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org>
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

