Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27091C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0D320663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUtYRSZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfANIYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:24:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53585 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANIYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:24:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so7901609wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YkPn1xL2oiOArne/N0Ongdrcw7L7vib32IvSe9FF2Fc=;
        b=XUtYRSZy6SQeX2YpwgO/tK6iru2s/vfHaxM8c9QHOhdzWcpDi2pGL3qW8aBP7ah9Un
         MuC4eVNPZNmZw9euyORY+vlCZh713DQEIloLteThOJHFozL0eUMb25yE7OCAaw1oghqg
         zpLXVaWmeilM+jNaH9Zq8YsXk/KmFaABuUWDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YkPn1xL2oiOArne/N0Ongdrcw7L7vib32IvSe9FF2Fc=;
        b=QXldkYFjRVy8YZ7VxuvozVZTUUyP6i0o+zHf4fWjro5hw6px4PdWvrvFK/zYxrTkds
         KkLM2rgBaePzXfJJx6BCR6j85XTH2Bomlf9Hu174kl09KtCLwRX5otMCYsxuTUP26Wd6
         pSw6c7jFDKpQ6AwCW8J5Z+6lnvTOfHjsmInbgYDkiV/xzFmBzpVO/YDQmwJqOdgWeNQi
         4l1YKlxaYxUt6g2kL0EKhnmdxGskZXTKSWUqWPsjAWNRLovc70K/x/oye8chFbUSoUrU
         JT2Ah87kCvs+lHE8lzqOwL6owDF3v7kEGVBLcADWiU6N52Rjc6e5ZDtKjKboKx3E5JAC
         s3Dw==
X-Gm-Message-State: AJcUukcSWwYT3OZhrK0YYSy+dRsviKHIUtTXYoEiCdywKFwk5dyPbtFv
        cwcb5wl8BHlyRJmDIfbKjwvTVADI6Yb79w==
X-Google-Smtp-Source: ALg8bN4kQ/ZCwNziATs04XAyBFhYbz3xUAWh/PEVfSuMG4i4awWaMeCzNWuDpbk4lrMqAPyVyyYElg==
X-Received: by 2002:a1c:2382:: with SMTP id j124mr10685396wmj.14.1547454277799;
        Mon, 14 Jan 2019 00:24:37 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:39ec:3900:1e09:314e])
        by smtp.gmail.com with ESMTPSA id i192sm28546146wmg.7.2019.01.14.00.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 00:24:37 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] arm64/hisilicon: fix SDcard detection
Date:   Mon, 14 Jan 2019 09:24:34 +0100
Message-Id: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDcard detection of hikey960 is active low so cd-inverted is wrong.
Instead of adding cd-inverted, we should better set correctly cd-gpios
to use GPIO_ACTIVE_LOW.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

SD card detection was not working on v5.0-rc1 but patch
https://marc.info/?l=linux-mmc&m=154637189021211&w=2 makes it work.
Nevertheles, latest changes in of_mmc_detection makes possible to have 
a correct DT config.

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 71bfe41..dc314e7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -665,8 +665,7 @@
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
 	disable-wp;
-	cd-inverted;
-	cd-gpios = <&gpio25 3 0>;
+	cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd_pmx_func
 		     &sd_clk_cfg_func
-- 
2.7.4

