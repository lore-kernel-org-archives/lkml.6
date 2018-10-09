Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE9C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF002086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTQ8iaak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF002086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJIVXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:23:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41427 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJIVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:23:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so864608pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ramjEGzY4YO96nqd2/8xdohTx62cvWs5MAFFc07+hXE=;
        b=DTQ8iaakVTc77iQV8PrO6XrTZoRuyIRf0JxOtp+oj43zEivtEOJE7r4188RevoYNGz
         lrk2ywKFsq63WbpuDfB/0Klbna8kYlqH0k4m1x8O5v3RzT6Cp+aoJJwzizRdWd5hAeuh
         Ns/fF7AhoXunIG9qesHtm2pzIUFgDHosvIBI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ramjEGzY4YO96nqd2/8xdohTx62cvWs5MAFFc07+hXE=;
        b=nIBy1a+JTDKgSPiDLPM5XS+M+gvqMj8YsPeg6mQOqA1z8JCaCDPnUkLG7QJBxvfxQ8
         8W6MPrMStB/35sm/NBjtX90p1LVDC8lGtWU4F47PE1Et3es5aUuYKDOE7xdnPAovrXVz
         HFplCqukZL5XmPuSkIgVyqqJDxx0FXPfQN1oAhKiFK1RhKYT5kKQ3+7syfTKcDUaaCii
         Oj+heoieNqF0fVuCMzHuTxlC04tkR4Dyspu4KyhIxcUgQvRJ0FyFWAlSKhvjXWy1Sqw3
         MDPFTj5InxIsoJHY7mMUOmBIwm2fUAMC7yt6gu6SU6BJztG+xe0x9lgK8sTt4CYgn256
         1Fug==
X-Gm-Message-State: ABuFfogKbx/KF/i4wiC18PId3IFr/Go3/wgwZCD0ZkSyQBmCoiNDNMv3
        AlFqe5Dizafs0SJSJw7RmoN/
X-Google-Smtp-Source: ACcGV60TGLESIeG2G19goPR7a0QeB+Oam6R+kYUq7sm17wCFmRAXmhTyA9GNYcq9BTeqg6vC00g+cA==
X-Received: by 2002:a62:8a91:: with SMTP id o17-v6mr30582200pfk.184.1539093964274;
        Tue, 09 Oct 2018 07:06:04 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e64-v6sm28947722pfe.55.2018.10.09.07.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:06:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/6] arm64: dts: hisilicon: hikey960: Standardize LED labels and triggers
Date:   Tue,  9 Oct 2018 19:35:20 +0530
Message-Id: <20181009140522.6492-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all 96Boards, the following standard is used for onboard LEDs.

device-name:green:user1  default-trigger: heartbeat
device-name:green:user2  default-trigger: mmc0/disk-activity
                                          (onboard-storage)
device-name:green:user3  default-trigger: mmc1 (SD-card)
device-name:green:user4  default-trigger: none, panic-indicator
device-name:yellow:wlan  default-trigger: phy0tx
device-name:blue:bt      default-trigger: hci0-power

So lets adopt the same for HiKey960 which is one of the 96Boards
CE platform.

Since there is no trigger available for onboard-storage UFS now, user2
trigger is set to none.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hi3660-hikey960.dts     | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c98bcbc8dfba..35ce460b3ed4 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -85,36 +85,36 @@
 		compatible = "gpio-leds";
 
 		user_led1 {
-			label = "user_led1";
+			label = "hi3660-hikey960:green:user1";
 			/* gpio_150_user_led1 */
 			gpios = <&gpio18 6 0>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		user_led2 {
-			label = "user_led2";
+			label = "hi3660-hikey960:green:user2";
 			/* gpio_151_user_led2 */
 			gpios = <&gpio18 7 0>;
-			linux,default-trigger = "mmc0";
+			linux,default-trigger = "none";
 		};
 
 		user_led3 {
-			label = "user_led3";
+			label = "hi3660-hikey960:green:user3";
 			/* gpio_189_user_led3 */
 			gpios = <&gpio23 5 0>;
-			default-state = "off";
+			linux,default-trigger = "mmc0";
 		};
 
 		user_led4 {
-			label = "user_led4";
+			label = "hi3660-hikey960:green:user4";
 			/* gpio_190_user_led4 */
 			gpios = <&gpio23 6 0>;
 			panic-indicator;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
 		};
 
 		wlan_active_led {
-			label = "wifi_active";
+			label = "hi3660-hikey960:yellow:wlan";
 			/* gpio_205_wifi_active */
 			gpios = <&gpio25 5 0>;
 			linux,default-trigger = "phy0tx";
@@ -122,7 +122,7 @@
 		};
 
 		bt_active_led {
-			label = "bt_active";
+			label = "hi3660-hikey960:blue:bt";
 			gpios = <&gpio25 7 0>;
 			/* gpio_207_user_led1 */
 			linux,default-trigger = "hci0-power";
-- 
2.17.1

