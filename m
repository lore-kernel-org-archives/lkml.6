Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9D6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F263E206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmJIscQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfBXP2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:28:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37695 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfBXP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:28:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id z196so4339421lff.4;
        Sun, 24 Feb 2019 07:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTVCiu9UJJEAWIEm0N2KYXnp6/WhALYxpW+vg+wufXg=;
        b=LmJIscQ/HMWwqMcYwvocBaxi6jmwpygT0g3gPtXhl+KwjJbGWYyTH8uHDm931qvcnN
         l9eMS6cvRTYNu8jOl12qspk31R65PqAZW5pQvJW+CWdFEgV2cdcwxFgHSgjfI9J0KzYu
         YM16i1JBDSNfdkObPH095MYbIy/CGKUZ7xzNNn27tLMQy1rwm5RzHziHaGPz41WT48ms
         kcIfPExa/oJD8DoPplN8xdN+WEcxhCNoegv7onYqkrYXzOduRRNQ+uXmAMAtZHjARSbv
         CcVh2WK9KTdCIhuIgoVlrTQayoJjQMzQb+uspSrHdC9RW0PzlBbj4AJEM19m6WmPTo/Q
         6OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTVCiu9UJJEAWIEm0N2KYXnp6/WhALYxpW+vg+wufXg=;
        b=ocSBm8nm1JwWYjtRQWzjnaX6fO2sr1eMhQsydNqFBiaYKkWV7it+z/UmRQ9W9xJxCs
         fLVWI1qEf1xP9x4oWJKpFlhf3rGqoqagNVaFdUbK42Hg26rKdyvlqwfzA3Khx+6xf9ww
         NaEoncA81tkSZ9uc/dvjIQ558mxOJEeA5k9fN824p1mAQszP7Bp+AVJvfgDaigVtbw9j
         VYVWkvXph/T5geHYWVmKNRt1fKcwNAH0TrrAWrqvi3tTp9LYWYFXpf7G/YMeJ4/dsNNv
         Bhb3D/kWSQRjEt4FKKVvd9yKPPUVA17k0bTxaZz0OiwhowMRZtndUKDrAlw+vBm3NiUO
         eBeA==
X-Gm-Message-State: AHQUAuaxYkGqZpawsKgpG5OLpFjZ6IOXcOL4o0cW1zP/kI9xSrgwXav9
        YzXTMtRmAGr721bjZZxRjdM=
X-Google-Smtp-Source: AHgI3IaMTteyTEmFL1FAk5snDc6/XmOUHUa1l0cbNjVn4mX6SQL+jfmLBEz8GjiFlEi/TuoBllukjg==
X-Received: by 2002:ac2:446c:: with SMTP id y12mr390700lfl.44.1551022087695;
        Sun, 24 Feb 2019 07:28:07 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1907694ljf.52.2019.02.24.07.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 07:28:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: tegra: cpuidle: Handle tick broadcasting within cpuidle core on Tegra20/30
Date:   Sun, 24 Feb 2019 18:27:40 +0300
Message-Id: <20190224152740.7305-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20/30 drivers do not handle the tick_broadcast_enter() error which
potentially could happen when CPU timer isn't permitted to be stopped.
Let's just move out the broadcasting to the CPUIDLE core by setting the
respective flag in the Tegra20/30 drivers. This patch doesn't fix any
problem because currently tick_broadcast_enter() could fail only on
ARM64, so consider this change as a minor cleanup.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 11 ++---------
 arch/arm/mach-tegra/cpuidle-tegra30.c |  9 +--------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 3f24addd7972..6620d61b5ec5 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -61,7 +61,8 @@ static struct cpuidle_driver tegra_idle_driver = {
 			.exit_latency     = 5000,
 			.target_residency = 10000,
 			.power_usage      = 0,
-			.flags            = CPUIDLE_FLAG_COUPLED,
+			.flags            = CPUIDLE_FLAG_COUPLED |
+			                    CPUIDLE_FLAG_TIMER_STOP,
 			.name             = "powered-down",
 			.desc             = "CPU power gated",
 		},
@@ -136,12 +137,8 @@ static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 	if (tegra20_reset_cpu_1() || !tegra_cpu_rail_off_ready())
 		return false;
 
-	tick_broadcast_enter();
-
 	tegra_idle_lp2_last();
 
-	tick_broadcast_exit();
-
 	if (cpu_online(1))
 		tegra20_wake_cpu1_from_reset();
 
@@ -153,14 +150,10 @@ static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
 					 struct cpuidle_driver *drv,
 					 int index)
 {
-	tick_broadcast_enter();
-
 	cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
 
 	tegra20_cpu_clear_resettable();
 
-	tick_broadcast_exit();
-
 	return true;
 }
 #else
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index c1417361e10e..c8fe0447e3a9 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -56,6 +56,7 @@ static struct cpuidle_driver tegra_idle_driver = {
 			.exit_latency		= 2000,
 			.target_residency	= 2200,
 			.power_usage		= 0,
+			.flags			= CPUIDLE_FLAG_TIMER_STOP,
 			.name			= "powered-down",
 			.desc			= "CPU power gated",
 		},
@@ -76,12 +77,8 @@ static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 		return false;
 	}
 
-	tick_broadcast_enter();
-
 	tegra_idle_lp2_last();
 
-	tick_broadcast_exit();
-
 	return true;
 }
 
@@ -90,14 +87,10 @@ static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv,
 					int index)
 {
-	tick_broadcast_enter();
-
 	smp_wmb();
 
 	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
 
-	tick_broadcast_exit();
-
 	return true;
 }
 #else
-- 
2.20.1

