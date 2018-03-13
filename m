Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbeCMLqP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:46:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932920AbeCMLqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:46:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: scpi: add thermal dependency
Date: Tue, 13 Mar 2018 12:45:40 +0100
Message-Id: <20180313114607.2061209-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:LcahI0XNWHAeNx1lkW9nKKJ++liKI9dY3IbGR8H3bnRrl8xwV+8
 F2NdIeAlGFKGRQULp79gatGcfUKm923DeAnJQrfXLxrfTabZcLPWA4daD7tt4/DyGzxpP6m
 Y44+EuJS3iRcBh1/O44MqVoPBu4AEjob4wW39ycZuODGHEy1Ai7MJd2RWaN56t3v3d0K5dz
 L+HLLg/dVNffWMy7wgLQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r71t+0e13gg=:n0TiwV+NcH9kc1R43zGKE8
 8V6IGk7+MI29+t6BS/55eJXNWC/m5rt4mlUjoCVU2bcaXwtbkgZOk359yk3xWSFNT8Ca6uCqx
 dWXzG9HOix5grvt/GuQfYMo7T5Z1nRfGgPWWX5AeVcZND+q6pEDMtUz6BFzVx2SaQWcDCnzuc
 bxN9L+D8XuYRFSvJ8rPDjqgQv4GcSFPmibGtvK59J8td/ownSyUUHc7wAEON/9py42Dc2oPEn
 citPAzNVJg4gNv4g+thHHBYiFKAhh0V2je8tH5Tv7wtNMiTKcaNfNrlM54osP1ZPgCgO9erFv
 6bv/iWboJgG6DC4Xe2kXBl1XY4J59wbrCKMA+MGQ7rkF+9ZVmeCalLwhsC+sCxtmZqs4fOGaV
 8+QoCQYM8VOZflO4NKiJhSAtazWbg1pWfxofwUJC+fAcDAqUla4EmNdHlxLezUXizLz4cDWU1
 FOW5EaVr4oqAKVWR0Za8tKMhF3Dg60Ypcb4gOHndz4ywj1aSX0JsPXFQlf0asMK7yT72IGhmz
 rXKJy6eKuD9KcqipnXp9Ja/YfARrgDNyGtYgeuLIjPASJ7rSQUwFGnGH8bLtln2Cp+3849PqX
 ZXwYymUnoezpJij1VOZSQjYpOU/Y6wDSkn4JYAUlLPRCn3tf5I1U0V11WO9Ls8fNgao4ia8yU
 kKnwPgEAyij2x7JNEZeEaee1yeTaURio2kWszMLFBrR0gEOC2BbfydFYSyvhAwSFAZiV/428g
 svYZ7ryZTDu/IMdOS6h1XHeF6JrIRp1awaQccA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A built-in scpi cpufreq driver cannot link against a modular
thermal framework:

drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_ready':
scpi-cpufreq.c:(.text+0x4c): undefined reference to `of_cpufreq_cooling_register'
drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_exit':
scpi-cpufreq.c:(.text+0x9c): undefined reference to `cpufreq_cooling_unregister'

This adds a Kconfig dependency that makes sure this configuration
is not possible, while allowing all configurations that can work.
Note that disabling CPU_THERMAL means we don't care about the
THERMAL dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 9bbb5b39d18a..d9457d1e535c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -45,6 +45,7 @@ config ARM_DT_BL_CPUFREQ
 config ARM_SCPI_CPUFREQ
 	tristate "SCPI based CPUfreq driver"
 	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
+	depends on !CPU_THERMAL || THERMAL
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCPI
 	  protocol for CPU power management.
-- 
2.9.0
