Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A65C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B8820661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbYg7vmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B8820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeH3WvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:51:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40114 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3WvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:51:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so8021335lfi.7;
        Thu, 30 Aug 2018 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bSioIBdz22Ik+FhDjc//uL6/I13puDvIMWmsv1alKKU=;
        b=tbYg7vmn9Nr8llxKlt5Ls4j6jGqrMw/emWUWmGs7p7vZZy+rjfdvlx9UN49PJFcAhH
         kArR/TxW11R2SoJvk3dlxaTXsKhx6pdTLeX+ZcT6WAUQdMrM+QVWUxquWdjgWxmvlDxJ
         /RAEuBNcAklPXcRqkjsjjao9z/t6xiMpNwHfS+Lzoo2LI5cxIfS7l/4yPzTi0TOT0FhO
         qULsllt91Fr4/CIJDcDErgsm/8QU30rYIZqZEENJW173MpRAZa108cOslXxGD9gAVydp
         G+Uuq+rGUU0H2V930fkwROQOnylpcxol1ZlkV/FlZVJheW6Fg46S4pUEQOoBQksD1umv
         ISLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bSioIBdz22Ik+FhDjc//uL6/I13puDvIMWmsv1alKKU=;
        b=h+NWyOnjHlbl+oS2qvbXIihhJtWwVo3BJy/SlQwrWogohEPc5GF9tixzagHAnclYRn
         cSv2aihiqmxI00kxY8urfYy9cF9Lh+upmj8IgXLoFrVhKvZar8Qgw887ChQQEWyO2YzB
         7vJmaBj0aNFONunnhYEXJkqWAml5s/Zi47Y39vUIY3QB1VGWZJfElEUNcbt/9RKDkEWn
         cTdmdrC65EGmyiROtYzeVsQHmpB5bdvjj3P08LqjoEZjWpeOmyAyPECWNm/Ds3/T4Sep
         FhAsBCXdY+vMqlzh7P8aHFlLIcrYEMoD6dt21Fv+UfaxOv1J/YHh991F9DXwU89x8xag
         LBQw==
X-Gm-Message-State: APzg51AYwnCoECzpvsDRU4fLyu3QPAMWdpkGgHCaEf8po/xm0T0uc559
        gdFJFtXoeb7OH6+Fkn8/jKo=
X-Google-Smtp-Source: ANB0VdavtbYrr2FBdSharB6RjgqhulxgFXgRLbyqL2tffx+Uh0RFPgJ4zc2SuYTK77kXRZLUh7HdCw==
X-Received: by 2002:a19:df43:: with SMTP id q3-v6mr8010645lfj.53.1535654853490;
        Thu, 30 Aug 2018 11:47:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id x14-v6sm1429500lff.7.2018.08.30.11.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:47:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: tegra: cpuidle: Handle tick broadcasting within cpuidle core on Tegra20/30
Date:   Thu, 30 Aug 2018 21:47:04 +0300
Message-Id: <20180830184704.6138-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20/30 drivers do not handle the tick_broadcast_enter() error,
let's just move out the broadcasting to the CPUIDLE core by setting
the respective flag in the Tegra20/30 drivers.

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
2.18.0

