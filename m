Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E184214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHGcoVtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E184214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeHBNDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:03:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44139 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbeHBNDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:03:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so788020edr.11;
        Thu, 02 Aug 2018 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0ynkw2hB14rcQY1Mb1ryHXQyygRwuaPP/EG0/OxRpQM=;
        b=sHGcoVtHuofzVa966cvlYe5Ex0esvthdgCeut5cB8Nlq3IDMPxPYzhikpJ/EUq6pk/
         D/gkpc5vgRz0EPBDA9LEymN/y+gHgOiCJY6d05vRp0If0HkewysUsl0xi1/yMxDO5ZJt
         G+EIgp6un0VauCd8KERT9cLNsCVmebBCJGvfGEzxX9vjYN/me+RA/8SMrpHfgrnfndVP
         e2E22jYM396tF6cq/GuR5q+dcuL5efOniPDw2+qvS7/iK1jv1iENDW/7w7aUp6jixxQy
         /t7oVD0QHO/TlkiBeJcPJYbzAO6AGRNElMYaTi0Bt3bAAKzPB0kx8imjZDZIs3VW45sd
         1CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0ynkw2hB14rcQY1Mb1ryHXQyygRwuaPP/EG0/OxRpQM=;
        b=fi+48gTIHeX0EwH2v3H667oL4YhByE9cjBhLAoCmyLU1uwodvviaulkJvU7OsBUSSu
         DWomr9HXKnKRZZRzrJZ8+B9IkCaZf45hSL7iCzvdPkOlsX9ocwC2C7QAGKzblip/zkAZ
         owFQlsdRhmchGHt6ISL9MEpNQLNTDg18Is17bearWfVzWw/17d01SaOzme9hg5rW/KBE
         1zOwxNu9pnLTOKljcgNygy0Ex5OijsUv8UbY3DdGubhg2FktQOFfIPTVwGOIqvowF80F
         O3Y8mBGl5pbT7PaoMGFxpQZcXqNsY2q4poN6MBDN5ptuEJpu1hL1mlI3VOjCRDXPNqyQ
         sdBw==
X-Gm-Message-State: AOUpUlGp4rdrHyil0EA6ymRVDA+aipXtZ5Xqsxq4slE7HWQ0t4E0AGqk
        bh2agmZtGrTR+bo1861dPoWQOKJ2
X-Google-Smtp-Source: AAOMgpejJz9noI0utA0fn8b75CZ5Yu7X5tdgyVwyT8/GpZiLYK8GIHXmYaiLiMHDVLuZ+l1nNV4eJA==
X-Received: by 2002:a50:955e:: with SMTP id v30-v6mr2978557eda.268.1533208340396;
        Thu, 02 Aug 2018 04:12:20 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id c21-v6sm886933eda.21.2018.08.02.04.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 04:12:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to arch_init level
Date:   Thu,  2 Aug 2018 14:11:43 +0300
Message-Id: <20180802111144.12512-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in regards to deferred probing within the drivers core
that causes GPIO-driver to suspend after its users. The bug appears if
GPIO-driver probe is getting deferred, which happens after introducing
dependency on PINCTRL-driver for the GPIO-driver by defining "gpio-ranges"
property in device-tree. The bug in the drivers core is old (more than 4
years now) and is well known, unfortunately there is no easy fix for it.
The good news is that we can workaround the deferred probe issue by
changing GPIO / PINCTRL drivers registration order and hence by moving
PINCTRL driver registration to the arch_init level and GPIO to the
subsys_init.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra114.c | 7 ++++++-
 drivers/pinctrl/tegra/pinctrl-tegra124.c | 7 ++++++-
 drivers/pinctrl/tegra/pinctrl-tegra20.c  | 7 ++++++-
 drivers/pinctrl/tegra/pinctrl-tegra210.c | 7 ++++++-
 drivers/pinctrl/tegra/pinctrl-tegra30.c  | 7 ++++++-
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra114.c b/drivers/pinctrl/tegra/pinctrl-tegra114.c
index 511a8774fd8d..d43c209e9c30 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra114.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra114.c
@@ -1868,4 +1868,9 @@ static struct platform_driver tegra114_pinctrl_driver = {
 	},
 	.probe = tegra114_pinctrl_probe,
 };
-builtin_platform_driver(tegra114_pinctrl_driver);
+
+static int __init tegra114_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra114_pinctrl_driver);
+}
+arch_initcall(tegra114_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra124.c b/drivers/pinctrl/tegra/pinctrl-tegra124.c
index 57e3cdcf4503..5b07a5834d15 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra124.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra124.c
@@ -2080,4 +2080,9 @@ static struct platform_driver tegra124_pinctrl_driver = {
 	},
 	.probe = tegra124_pinctrl_probe,
 };
-builtin_platform_driver(tegra124_pinctrl_driver);
+
+static int __init tegra124_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra124_pinctrl_driver);
+}
+arch_initcall(tegra124_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index 624889ed3a9d..1fc82a9576e0 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -2277,4 +2277,9 @@ static struct platform_driver tegra20_pinctrl_driver = {
 	},
 	.probe = tegra20_pinctrl_probe,
 };
-builtin_platform_driver(tegra20_pinctrl_driver);
+
+static int __init tegra20_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra20_pinctrl_driver);
+}
+arch_initcall(tegra20_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c b/drivers/pinctrl/tegra/pinctrl-tegra210.c
index 0956a1c73391..3e77f5474dd8 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
@@ -1582,4 +1582,9 @@ static struct platform_driver tegra210_pinctrl_driver = {
 	},
 	.probe = tegra210_pinctrl_probe,
 };
-builtin_platform_driver(tegra210_pinctrl_driver);
+
+static int __init tegra210_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra210_pinctrl_driver);
+}
+arch_initcall(tegra210_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra30.c b/drivers/pinctrl/tegra/pinctrl-tegra30.c
index c923ad58af84..10e617003e9c 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra30.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra30.c
@@ -2503,4 +2503,9 @@ static struct platform_driver tegra30_pinctrl_driver = {
 	},
 	.probe = tegra30_pinctrl_probe,
 };
-builtin_platform_driver(tegra30_pinctrl_driver);
+
+static int __init tegra30_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra30_pinctrl_driver);
+}
+arch_initcall(tegra30_pinctrl_init);
-- 
2.18.0

