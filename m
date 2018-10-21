Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD55AECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E552083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBKhM2EG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E552083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJVFNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33243 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJVFNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so35130822ljz.0;
        Sun, 21 Oct 2018 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/dNYx0paZ6UZXuaSjvIqsdXTvvUXhcV1ITScTYkVkI=;
        b=kBKhM2EGKOZFgnpHh8v5TlZn8nvncTDDC47lzAaNC1GmRyHtYnK+n26UQcIMpaojJf
         VGAZbqGB5QI/1+DJ3ZygG0jmU+fO7s1xF3DdVI3EDJWHQ6aa+YMkpfMlmoj+8hJRQdSi
         P5FJJCtOX4l8Qsmn4FO+dbB9a3JWAYcVBiJbU5Jxbmdclmi5tLVWjetY8+Fl6va6SlN0
         57xqmyPar8CRwzvrsEUNdJz9BA+tVoSBiza+7sjrNRies5PtTP66WftTttztHyqq8W6Y
         0FKmdRR4v2dvU+3LCefr3ordLSveL0D0sG9FXicYP7fGRBUFGhKNNENgW6eFmYhEyqJu
         B++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/dNYx0paZ6UZXuaSjvIqsdXTvvUXhcV1ITScTYkVkI=;
        b=A7uKHynguC7K2WmG8FIRCk+qCNM7fphElbrDJL8vmkN2XMmGxQfo8GJNVjYkCOE27g
         juRWpCnuxQF5B1QCsTSI8rSTwD0zlPVccsLR7VdFyzLevj1Sk+DNCv++DfRLE1ap6GrK
         EX641dFeCh9MlafC2drwjwTqXzr4T2ppVvocvIRCTx6jtlRA0fknvuzSLEOn0pDIiZX7
         YpAL1DW70/8khp+tWKFXtoB6NYOEkCTqRRbWXnUMhpT14VFrZB6I2PupML5E2MJrhb2A
         2I5PIs9zbowsrvDGw2nSuNNZtvTe3KvRn/bnohoMIeqBmsH+IXtO4Rf049s0KUXufrej
         UEMQ==
X-Gm-Message-State: ABuFfohulLq55j2x6KXHuhBzfghJhwcJvJA2TIia7+hTePq2eUFhkbw4
        zNa2rijKslf9a8rn0XTq23yXyUHp
X-Google-Smtp-Source: ACcGV60W2otK6ypMrReooDjr8gaKQCNNnBnbXwMA9k4JxFpq8PL0qdLyG6DS2m0tCskWdZAyMAak5g==
X-Received: by 2002:a2e:2a43:: with SMTP id q64-v6mr27046238ljq.153.1540155489332;
        Sun, 21 Oct 2018 13:58:09 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 05/17] ARM: tegra: Create tegra20-cpufreq device on Tegra30
Date:   Sun, 21 Oct 2018 23:54:49 +0300
Message-Id: <20181021205501.23943-6-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20-cpufreq driver require a platform device in order to be loaded,
instantiate a simple platform device for the driver during of the machines
late initialization. Driver now supports Tegra30 SoC's, hence create the
device on Tegra30 machines.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 67d8ae60ac67..b559e22eab76 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -111,6 +111,10 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.19.0

