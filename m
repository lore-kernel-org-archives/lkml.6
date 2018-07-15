Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3433FECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC042089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6iD6wof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC042089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeGOU0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:26:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeGOU0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:26:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id c4-v6so17169302wrs.12;
        Sun, 15 Jul 2018 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyiW2DYmpzVazYYSFbr7WrZtLW3EPgd2qzGpNJQcZN4=;
        b=j6iD6wofYueP96Y3Orv0I5BuUITXHZ+1iZNIkcCYi6y1wuTzjVLuBXJMiwQOm88lNN
         BIDSVcAyGnuiKjTHHNHaj5c0tcVe76FdO1ziVPmd1PG02Au7VC8wwBpbf0cMz7mlHXDk
         IOaJuXxnPV0jDOgLVK13fj9NwQdLqXT5LiOQQhRNswTxBUXvCsBi6oz4LIEZRtlkRr5g
         2Kf3gO3+SSG34UIJWmHKEapqUMD5CUZbj7+d99TrQblHNjRclCGP1WWrBiTsdlbJoEnw
         SCHKoWhVmdz3rmtyOBecPfF8vAftN3o+drjrH+HnkWmcEQOyswQCEimx47sAZlJi2r+s
         1E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyiW2DYmpzVazYYSFbr7WrZtLW3EPgd2qzGpNJQcZN4=;
        b=IqsmJqhYQD4lVKowaNgrBYbeZSA5tafIWf/pscuxf4/rCsS4rlALiG2YXogNzDEcYn
         6EE8cm+8WQWte8rEEmsFHd+z1VnxDjTrv6glXr1TfAfkrwXcSKusxGJ2zpT3L/IZqbqb
         ZA1RFrNsert8Al9icRJ2Nb779a6cUlH7c/f+ktyFS5z9LmLBb3ZYQmd20iN5sWjL8i5B
         BktedCVqrSg+boOL8RO8hQJNmI5CqluZGzWxHHEuKbZ5EC6tgcQVo9OTsXnVjLedv3yz
         8do+7ZqCI0z/FG0iD2nHmRD0Ggav8RqBKTk0kMnMMrIOS7R+FLYYV2goKzsTnr6pnGPS
         zKoA==
X-Gm-Message-State: AOUpUlGGhu/hWlF2ysf+lmT4aQM7UTS7B9mGOx1v98NYi9ju3gtuoZK6
        eKnLKsa7wDpxwEdtuv9cDzU=
X-Google-Smtp-Source: AAOMgpfbYZDNKPLs3ATVYmlE5Gn/FpkslT3Thcgr1YCBwIN4Knge24zlPk4mPTDaYnjMo8JbJkg0RA==
X-Received: by 2002:a5d:67c6:: with SMTP id n6-v6mr10054838wrw.39.1531684934597;
        Sun, 15 Jul 2018 13:02:14 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id z7-v6sm20816234wrh.85.2018.07.15.13.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:02:13 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v5 1/5] clk: actions: Fix the missing REGMAP_MMIO dependency
Date:   Sun, 15 Jul 2018 22:01:47 +0200
Message-Id: <20180715200151.10416-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715200151.10416-1-sravanhome@gmail.com>
References: <20180715200151.10416-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add REGMAP_MMIO as dependency to avoid undefined
reference to regmap symbols.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/clk/actions/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
index 8854adb37847..39491154abbf 100644
--- a/drivers/clk/actions/Kconfig
+++ b/drivers/clk/actions/Kconfig
@@ -1,6 +1,7 @@
 config CLK_ACTIONS
 	bool "Clock driver for Actions Semi SoCs"
 	depends on ARCH_ACTIONS || COMPILE_TEST
+	select REGMAP_MMIO
 	default ARCH_ACTIONS
 
 if CLK_ACTIONS
-- 
2.18.0

