Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbeCMLqb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:46:31 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932892AbeCMLq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:46:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: scmi: add thermal dependency
Date: Tue, 13 Mar 2018 12:45:41 +0100
Message-Id: <20180313114607.2061209-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180313114607.2061209-1-arnd@arndb.de>
References: <20180313114607.2061209-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Ub40RA2KrXxyns1AKvX6VG5a8JZPLwXt0AF0rWOdfBRrEwoLee5
 g8z82UyREIC+m2/0qQHxTbARkdPmy95bm0uOCqr6q8D1kEFKIZyUxnR+squm8Rv86oNrqKp
 lnhrLv1I2gTlW0AyQabOccBEi0diJDvrNyt+/r3NsXvkxdkWVMY2uYbe9IZIv88JLElbEzh
 vgAJg5hhcOQDKQl3xuuQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hZNyBtAC1tA=:6WG+bDIezYeah+7Rt2Jp6i
 fzZ2XqbHzCJNcGkG7UhYZAIA7uhsGChjH2Q7+tXbs67upszKiMzvZ0rF67WnBzyW0l2qG0kLH
 olvxkqKNvmG2pWLACO0a/eMptzl8E0GhgOzYtNDejZrxXoMIaT15iWYFpH3f2nPTCnLzmu6BK
 yS2LAkvdovsyJDE3gcrQNsovT0NxGwuU6jVVGZjko5x1QNLcKM+bG0YSDHDxn8dtI1hmG8GbP
 0j4bUyoIyARLjfjwL1U3HGHpvAvc0wOQQ2f6vFfu/uYMK1cCBEDV8bD3950NN0js1fMyZpbVJ
 pAU/J+IA8UtyaESpRllPm/t7+2T+OjYPqsJmKA9SN2Z1/+iQAcV7T5Q73z/7VYuVxKNlW1wJF
 ULpgqTuoKJ7Tyvbdu+4ToX4DkSXtWf2leYW9ZtW9jx9dq8LZECdZ77OgvWiv69sRe0wRhpSES
 ykpYkDP161KUsGIlohq33HSrtuJegOoZYOVCi+ASG3SHJJr11uBqcpza3RgNwnHkBR3QcXdP6
 fxV54zpimjQf1is5tCtgssopo/k+ErKm1Kpm3wRsirSduTEWJ3t617Fk7CPQiwj2bwOVDa8lL
 gLZApTEJbN01724Wk+rLUw/MgH0fO3MmT7LoFYcZaL1bNgi5pni1nu7Q0uhh9seIrHYcVKKrY
 Gd+IhiE9TplV5iObTMjtITyuvTuVGCqSlaiCXceMJGE30fAVlrt02ExwE1d9a3iXxnHwSHZbd
 bv+bwKYm21UaCgIPpWKwEQfpFJlAPiylKD7vbg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A built-in scmi cpufreq driver cannot link against a modular
thermal framework:

drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_ready':
scmi-cpufreq.c:(.text+0x40): undefined reference to `of_cpufreq_cooling_register'
drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_exit':
scmi-cpufreq.c:(.text+0x88): undefined reference to `cpufreq_cooling_unregister'

This adds a Kconfig dependency that makes sure this configuration
is not possible, while allowing all configurations that can work.
Note that disabling CPU_THERMAL means we don't care about the
THERMAL dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index d9457d1e535c..7f56fe5183f2 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -242,6 +242,7 @@ config ARM_SA1110_CPUFREQ
 config ARM_SCMI_CPUFREQ
 	tristate "SCMI based CPUfreq driver"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCMI
-- 
2.9.0
