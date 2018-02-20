Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeBTPGF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:06:05 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:37621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbeBTPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:06:04 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: stub out cpuidle_poll_state_init() without CONFIG_CPU_IDLE
Date: Tue, 20 Feb 2018 16:05:44 +0100
Message-Id: <20180220150559.3182304-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:3OD7vIULYZde7RWXK6ymLab5sOw5e7xnMJoCCDbaoZIBwgxEpyq
 YLPGXYPuFqblau/9uFFGf/C1cDUj2BUCiktk1Y4Fj1yNiiW0RWuaI/o5mOZDDfmRUMfjDkR
 msEAszgBCstD1n5jHGclxzcEZHql4ZcoJVRWiCyJM7QAnpQijpp18tpgOo8/pv/bzXvnqLk
 hbCv9jehzUi2lG/sd0iiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vH1vV7XC7wg=:o21vuKj8bbAcQ5wi0S/JE3
 2pKHrcBn76rrNJPIOh1whFF8yoKBdlwuEjFSnTURZlQl6bJUnkpmyQAbFxhZJuKii9VOcPyft
 qaZjB1T9IeNwiG/MnlL7Pq25MbjkI2r8tYcNk8eCdsFMX5gqPMl3f4ikckOHzl7pfHs7d4B1p
 8n9LtCtG7Lz7kN14e7gZ04Prpudfx41rpog0/intFxW9nc5lcF6Dmvz+Z5kSjcJY3RSGKJiyL
 2tOvJs4yAp3CCNkQdv9+Y4ctKB2jDF8G41wjSmWE1WRloYGDdLW0ZXE+kMmXR5HFFHoGFesre
 GH6KGqnz6k6mOlyaG6Gm1/v29tBKptTfwLCmvB0fjqQGrnrau4UwAvn1DLK04yyBJoWZTA1kF
 Zf6B9OlyZoTEP/jSeJiGH1giss2iPdCDe/GYMMV85eoqkbu6T540RTtfckBbKqz+DTVS12uCw
 YqQ7/iSOZqU0YKcGricd3BVwCikmtM61DhcokEEoEett1h2JpdZXFKfeIk2/dFYpHvTo4cGsM
 kXw1WUh9lqtr5hVoHAp1u7xQObcT0R0CuumuhFI58lZvuCdWeliglMH8DIKa92HUAzA6p3fsP
 o5x3jRK6um+IM1G2HB/U3DtNHRtFwgu3Wkj3xsV0cxRYIj0ZV+8JkyQrddbXay4YHy++eoHWE
 jnrECDvotqoPwOc8TXOovzZ+nXTg5ka0OXA6bKUUAZjX3ZOZdtuPBpDl3VAlq/R3mAzjQS9XJ
 WXZ/gNZpGxRlOWoSIV/MTCUz2suQOJo6rvw3aA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling cpuidle_poll_state_init() from apm_init() results in a link
failure since that directory is never entered without CONFIG_CPU_IDLE:

arch/x86/kernel/apm_32.o: In function `apm_init':
apm_32.c:(.init.text+0x62c): undefined reference to `cpuidle_poll_state_init'

CONFIG_ARCH_HAS_CPU_RELAX can be set without CONFIG_CPU_IDLE but has no
effect then, so we should treat that configuration the same as
if CONFIG_ARCH_HAS_CPU_RELAX was not set at all.

Fixes: 34c2f65b718d ("cpuidle: Move polling state initialization code to separate file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/cpuidle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 871f9e21810c..0b3fc229086c 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -225,7 +225,7 @@ static inline void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev,
 }
 #endif
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
 void cpuidle_poll_state_init(struct cpuidle_driver *drv);
 #else
 static inline void cpuidle_poll_state_init(struct cpuidle_driver *drv) {}
-- 
2.9.0
