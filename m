Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeCOPQm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:16:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeCOPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:16:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Shawn Guo <shawnguo@kernel.org>, arm@kernel.org
Cc: fabio.estevam@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Bai Ping <ping.bai@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: imx: select ARM_CPU_SUSPEND for CPU_IDLE as well
Date: Thu, 15 Mar 2018 16:13:19 +0100
Message-Id: <20180315151345.3089601-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180315151345.3089601-1-arnd@arndb.de>
References: <20180315151345.3089601-1-arnd@arndb.de>
X-Provags-ID: V03:K0:zo0wDZAsBywMiKtAdUaRjxU8jKaHNi6at2P6jKxf7zPwSPWhV/V
 S05z5yznZ5oDB4Jzaug+r4j2ekZnLw6c6biEsgtX4CLgBXmANG6X95t0tdTgP+kdRFtn3II
 uhBh0Hpsko1KvU/nRS0ZToz87fXWMI46QtfbBjd/2mPGQNFxp+PlOkQPf7//rxnlyugQBPg
 jcEGyCeuMf/66KGNLEbxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RXuXQPpX9Tc=:YTGMdOfrDHBdr063OIUFGz
 0B51h/R6iCYdrO2Z+KYXCnguUNMQV9t2VKtnmII5XD9ZHyH8Y2NyVpL1EeK+y79h1W3+myjcq
 +Bm7OzIhwDC/aAf+lsmKHbmysKloK3H2yft+A8+XyB1Sg2XnX457RJeiic81M6woeU3o0YMRu
 FZy5064X1entTP2ZhYheo5DOJPckX9C7qe5MouzsG5ZxMz8+JiSCd68IerxFJtusOT0jft9Ka
 y6io6gm2naoE3a4bgIBMFCJ3lrfR3UZEvOeFFMjLKDEIzYWzQ7z/lbw6dexJBVdH5h5AEZS70
 TjW9E5NZZ7LeNK2qAAyyudTGUy+xARHtltXx6rNJDI5vm8NmbeO3Geb7k8qhGitgsuUbxW6IT
 mFvzp66URVYiHqNnyEO9BAVabRr2mYaTuLH0RyM6+e0i33s655x0HSoxEMtvwCpZBvqGLXcL4
 2vvdJRJpwR8zHArGP+PwOUYIU7vUBbDnQf0gypiRk9j1r9bSDJS00MlRPzx9EAdB/CZfv/SVF
 RcAb8hyT0Echi1HTEpjecNtHpQaVzOjlEUAYIfYwCAMHz2j1E5UbVH/Rh2w6/GV7maxDwEiFe
 bKrSFIRRGTqUk8Y3u7GQPDcvXpCfy02PJO8AxRlvI9xmb2jaCFQSQANnOJulDuel1eIjzLBKN
 +CRFXKzXhgqON8OH63g7u0WFUDsTu0Ym9XTrHy96+7WcLrYtIWWgol2eNwBf2qYkwxfzyeBHR
 eZFpSCRTwGlvx2ojihBhKaa3hgET8vIco1Tkmg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuidle support calls cpu_suspend(), which is compiled conditionally,
and fails to link unless something selects CONFIG_ARM_CPU_SUSPEND.

arch/arm/mach-imx/cpuidle-imx6sx.o: In function `imx6sx_enter_wait':
cpuidle-imx6sx.c:(.text+0x6c): undefined reference to `cpu_suspend'

This adds an explicit select statement here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f53ec31c9f5a..e47fa13f4b0c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -469,7 +469,7 @@ config	SOC_IMX53
 
 config SOC_IMX6
 	bool
-	select ARM_CPU_SUSPEND if PM
+	select ARM_CPU_SUSPEND if (PM || CPU_IDLE)
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_GIC
-- 
2.9.0
