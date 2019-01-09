Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E62C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7986F20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHrRpM+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfAISBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:01:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44508 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfAISBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:01:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so8569860wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aa7DBW2jefMqiPG5SEMBLPrEapaMRoLwEi0UQnoTFU8=;
        b=kHrRpM+tjApF6eo1Zoxeiztl2FiwR3WBHD4oQFYwP0nnI8i7B0paOQaj4rtScDvFqy
         skEhNcLQEuVf86pFN4mklZeUyvysvXZzxr+h69qncZgJeLNS/e+e9QiVJ/QVK+9dxj8o
         VdlLATOi4nSqcan2ERN7GSK0BlnsPJgu6fWkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aa7DBW2jefMqiPG5SEMBLPrEapaMRoLwEi0UQnoTFU8=;
        b=sxBmsRshrGXU+zs6HkjKVsginl6aOtINmZZly+NK2x4sPlH1Jh8Sf53ckfQgzCCKmM
         t8t4cxvHvxjZ0hA7OxaDYATzrXfeLaqCyiJLZA82Xd9pl2O5qTv8JCTmHmU4DAkxlb76
         owhbnBqeCWs6zliVQ5Qo6Wcb3hkzegEZZwO7PEFBryYwtq30t8Bw4yi9tzJ1vCd6Poc7
         f1Nx1JETZJD5YrAD3OHRhsrq7Y0Hqmm9SDJgz+lvt6lDDLTRt8CKkxMEbSHH24EYn2Pb
         owspfIshE1+8XvFmEnLzIMpcZJq5b4hqKFvgG3HBq0lORxyRxbyG10v2XLBIM693HueV
         I+rw==
X-Gm-Message-State: AJcUukf+4/cK9DacNLt0hdgxjTnP1fLSQf/WwtKDSEH9pE97rUK6MXn0
        Ji0NP3yn4KGW2fDX1U98dO8DzA==
X-Google-Smtp-Source: ALg8bN5SuHaTfBgMv2bRDbK7T0AdBtnmzz8BQkudCteudChJPwuuOgeSXVXiyjbeDRrtjlC2w1JKvA==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr6265762wrv.188.1547056896228;
        Wed, 09 Jan 2019 10:01:36 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:1811:b2bc:9000:4c9])
        by smtp.gmail.com with ESMTPSA id m193sm14880509wmb.26.2019.01.09.10.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 10:01:35 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] arm64/hisilicon: fix SDcard detection
Date:   Wed,  9 Jan 2019 19:01:32 +0100
Message-Id: <1547056892-16527-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
has changed how cd_gpios phandle and cd-inverted are used to set gpio's flags.

Since this change, hikey960 SDcard is not detected anymore because flags
are not set correctly. Updating cd-gpios to set GPIO_ACTIVE_LOW instead
of high, fixes the problem.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 4643546..4ef1642 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -582,7 +582,7 @@
 	sd-uhs-sdr104;
 	disable-wp;
 	cd-inverted;
-	cd-gpios = <&gpio25 3 0>;
+	cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd_pmx_func
 		     &sd_clk_cfg_func
-- 
2.7.4

