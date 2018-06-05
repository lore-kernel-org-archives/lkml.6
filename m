Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeFELpB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:45:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeFELpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:45:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ilia Lin <ilialin@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: kryo: allow building as a loadable module
Date: Tue,  5 Jun 2018 13:44:24 +0200
Message-Id: <20180605114453.1381941-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:57oeEaoE/TbPh/0dlaPflkcfFNDoLJDYCe39vyxhDNMXhYQ8z2G
 ePuq7sirlnx72JycXkgqQ4ARmhO/C6AiRGBzd/AeoAviZSqmiwhslA0SqOGIVegPVUYMwTQ
 I35KdQlWDcr5grWU43whyOcjcPbWga++nQV9cMunv6yu5uoI/NvScB1RhY/t8vKNfAyIbAz
 H8dhlP5RuE9MgQCP2Vr6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5nrw9W4fa2A=:yAHiVx//zvMMRoNRNyV9CK
 Z2snSL36sFna4psMvjUiRi/7lllDRUActZ81k7iSq9L8fW+7cNigDpO42C13m5ARexgO35ZqI
 0nHOPzAmr5k/WAhNaYsG0RjedxXwVsVwwym+neN/0/qEKamwsXfRKnRfzzaFxJnSuB/kRi9Ng
 GXTKK9h0jiV7bhT0M8CSWHITTfnNOQcL/WgYZuI0yI0XyYS5jzB27/fOnb2fdFgl/h3WxzfEi
 zWrg0u7PkfQ+iXtBp5yJvIoh8IhXm0YQcqjuZpiyCB4wXMak8GATq6qadrgS2d/JL5/PQ736x
 KMgddP8eaS/fiDtDoYdlTykVeYCBF+bQQ1aDoWe7Y4ixXMYXRh9j1p+432lXOJYc8xCUK8vBG
 qI/V/Jo9XrWCe8E+hGk78sIwVYvnQd9g6ZloDHDGEy1GNQtJC+TV3xBZ4XIYHaDDAI86IiQNu
 7XCHwsTyHrcaIk95g4JDhVKSSWi5OBRHx1sKBV1ALmkKnHZEdWqxLYqVDZH97MGEJ54DOBArg
 hq3MqLXr7DcojOEVYzeY4jf4ycEYiQYYG5ECt/l5/CmWlwOUosCrLKBhIuPsLJra0hlG1ls3a
 9s1NtgXG+e1qUHiS+PhfuVZJ/ZP5lT7PrG4ghIpbW/DKtz7Q0RuhzwMLanwdZNTbMQUw+B0Mr
 BiGARe9+G4zLVy7Pv479CuHwP3REFCYQh/BSrMVPJNWnpXgerEgTWgYHmqQR0YSHUVrw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the kryo cpufreq driver while QCOM_SMEM is a loadable module
results in a link error:

drivers/cpufreq/qcom-cpufreq-kryo.o: In function `qcom_cpufreq_kryo_probe':
qcom-cpufreq-kryo.c:(.text+0xbc): undefined reference to `qcom_smem_get'

The problem is that Kconfig ignores interprets the dependency as met
when the dependent symbol is a 'bool' one. By making it 'tristate',
it will be forced to be a module here, which builds successfully.

Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index c7ce928fbf1f..52f5f1a2040c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -125,7 +125,7 @@ config ARM_OMAP2PLUS_CPUFREQ
 	default ARCH_OMAP2PLUS
 
 config ARM_QCOM_CPUFREQ_KRYO
-	bool "Qualcomm Kryo based CPUFreq"
+	tristate "Qualcomm Kryo based CPUFreq"
 	depends on ARM64
 	depends on QCOM_QFPROM
 	depends on QCOM_SMEM
-- 
2.9.0
