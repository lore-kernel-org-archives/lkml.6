Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB214C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5507219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3ZCT2QF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5507219E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeHFLWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:22:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40355 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeHFLWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:22:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19-v6so9980114ljc.7;
        Mon, 06 Aug 2018 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I+polcD2ykwKvj37N170Ls6rreDUc3NfcfZ5LU1FjzU=;
        b=q3ZCT2QFpusGA9zrxcVZcrLrM6TebSmRtaOy/iOVq/gxQwre0BooaxJnIkYjWt+6fj
         4ZAytqm/OvAol7TeSXS5FdjwthGS6nqadyfU9iHepvWlAcqbtd0eGZn8j5XJOSNlK1kr
         lYBQcpUaOCUqi5FcVbsNvipznrmyH9BPVUGVRFLI2okD++Oe1WGV5Vd6ang8zWs3Vesk
         xeydC8u62HLneOS6aj64P4QCc7OMpdqT8pK/TXXXzv/YzhGr4pWM+hfl/JJIfJBxvnBf
         PAG0Gq5PZWNjKodSwCPKPYhimQctyau3NE/0zIEijszoATGVCUYZdsnC39opSrKhHLhx
         sbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I+polcD2ykwKvj37N170Ls6rreDUc3NfcfZ5LU1FjzU=;
        b=uEMZzU9Uo14q6sCnJkBvlD1pLZJO5CfOr1E4tT94qukS90A9NduUO4M5JTj1lJJJwK
         nNH8qnPTnlzIvV9c/wv9/qdB5fUVp2M9WzhZMI0v//fYovd7cJgcm6DZ17KEyN0yaqny
         RRNwMyed1x/Lt4dr/sJKc4Hkh06ov2mGVpAzoZiJcZdjMm7jKy3Ih7faqj9TY+m49ClL
         uU3oGWiBjIq20/41lnJI3nRpZENAkZTgCd1G2g4leYpnOrftvj7Iv+JODmkvffAI9E79
         ZuBBAAaperKOPebDYYa4zIfXVaSraDBLIXHwu1mcId2vRTmyJdKg7NK0nDRaze9b+DM5
         JVOg==
X-Gm-Message-State: AOUpUlEM8cD6JKjraDCEm+XfKnVqMzSNIcw+DClJVXdk2BiHXdcGmihI
        GI0naQCOkES5lCpAnbPPpq4=
X-Google-Smtp-Source: AAOMgpc/YwGShoPeIkQ2mVlxnJb/sAeLjFUzZ8Ei9DyK4bP2Yu274qHU/gf0QJDRCGQbUbgDcLRGew==
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr13097264ljk.111.1533546846521;
        Mon, 06 Aug 2018 02:14:06 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q16-v6sm2175912ljj.68.2018.08.06.02.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 02:14:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] gpio: tegra: Move driver registration to subsys_init level
Date:   Mon,  6 Aug 2018 12:12:07 +0300
Message-Id: <20180806091207.12586-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806091207.12586-1-digetx@gmail.com>
References: <20180806091207.12586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in regards to deferred probing within the drivers core
that causes GPIO-driver to suspend before its users. The bug appears if
GPIO-driver probe is getting deferred, which happens after introducing
dependency on PINCTRL-driver for the GPIO-driver by defining "gpio-ranges"
property in device-tree. The bug in the drivers core is old (more than 4
years now) and is well known, unfortunately there is no easy fix for it.
The good news is that we can workaround the deferred probe issue by
changing GPIO / PINCTRL drivers registration order and hence by moving
PINCTRL driver registration to the arch_init level and GPIO to the
subsys_init.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Stefan Agner <stefan@agner.ch>
---

Changelog:

v2: Corrected commit message with s/to suspend after/to suspend before/.



 drivers/gpio/gpio-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 2d940785bad0..a53c77db9744 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -712,4 +712,4 @@ static int __init tegra_gpio_init(void)
 {
 	return platform_driver_register(&tegra_gpio_driver);
 }
-postcore_initcall(tegra_gpio_init);
+subsys_initcall(tegra_gpio_init);
-- 
2.18.0

