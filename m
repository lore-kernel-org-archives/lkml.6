Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5697820675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QetYrpog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeLQJrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53902 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732238AbeLQJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:47:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so11589940wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7zUfQ5k1UaGNLQZWqXUVxUrsnDmZIr72/O/z7L/p8XE=;
        b=QetYrpogRHsbPuvIb1lnhOHGRCb5X9owoV/AIv0hvqBsfvxhCRXjPEGrdGgYn5v1Mc
         HDpWdDIMxrVXmwqNDPiKsFQTZ2a3O7LCK+kRPiAVQeN0rDu653kusvLwkrVNLaTx+X0T
         qCry9q5eEfUmIK4pOEKIOKe3nD8pUN+sIxWUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7zUfQ5k1UaGNLQZWqXUVxUrsnDmZIr72/O/z7L/p8XE=;
        b=YTBgxU78kROr1OtQ/X9lLAMZd2LZWovVuXv6dzaLc9syG4Nlh6VXQZFSWvPzURj37X
         QgFMsR6aJjpkCyH1ty12gE3BVhK+RHwDg4FPKHMPgA+KGslOSFgcWq+87RfTVF+8Zbby
         B6MJ/37YB6y7gRU9sn+E8ntscrVN2Thvu04TwQwya6jwftkq+JecJ0yqWU8fp3qOpWgx
         jNAC+BPv+I7/2g++9RfkTtaVO1sy12FbTA0iSbxlGZxMI0/06CdwrOJWYPvSFXxfCMAu
         B4ubRNQhqHgZIgcWfURvo2Tr/YOEMroUjnfEEZlXcxFXQWF0Y3u5k0Gum3N21/LrejOv
         NGPw==
X-Gm-Message-State: AA+aEWZyD2rYU+FHSuDRHktk2xQ79HFPVH7s2RpciOdWWzRARypEszil
        MjWFI1+VVVck7xCFIxWbWG3fqg==
X-Google-Smtp-Source: AFSGD/W7AfI98CnyZ0p8vcdpfYDXkTB7x6OrV/CwFqF8fuIpp5WZTRDIcwA7oulJja30ZZ/F4hIh8w==
X-Received: by 2002:a1c:2884:: with SMTP id o126mr11386163wmo.17.1545040020936;
        Mon, 17 Dec 2018 01:47:00 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:47:00 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 13/13] arm64: defconfig: Enable HFPLL
Date:   Mon, 17 Dec 2018 10:46:30 +0100
Message-Id: <1545039990-19984-14-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high frequency pll is required on compatible Qualcomm SoCs to
support the CPU frequency scaling feature.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5c2b1f6..da390aa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -615,6 +615,7 @@ CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
+CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.7.4

