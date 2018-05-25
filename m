Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967087AbeEYQDT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:03:19 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966645AbeEYQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:03:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: omap: fix compile-test building
Date: Fri, 25 May 2018 18:02:32 +0200
Message-Id: <20180525160248.4135506-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525160248.4135506-1-arnd@arndb.de>
References: <20180525160248.4135506-1-arnd@arndb.de>
X-Provags-ID: V03:K1:HJczMFqROpixsomUHXS8P9IVumte8g0U3R07LJZWvvmxWdAS0Q2
 xyxFclCLiSSbCLlwYIMJzvofYe42OgR//tBzSY3t4ifm4oMa3yKKODck/wITVUhDS01URev
 4NumEauYS709cyDkQMVgj4pALLWdQxImQy7Ccq9opgCRI5lLMqrGEr0avJv/WeuGMFkrqNs
 0yobjNlPW6uVLde/MjWjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IDIZwrykjFg=:+wemxXA16MDSq0tV/mxjiH
 qBy+FpaqVyMqFEIxiuC/qDBp17BRs0SoXzF5Igt0hjrqS/8PZ8YMK9DrMLlaxHpq5YY6PvAAx
 wKzLZ3D6zfTwhfag3cPmAqShSfGkEnUCqiBGP5DDq8SuG1wlgTK+eTTgw601+7OhKll8S5Y48
 5iCfKIjIKDneJDUhC/gIebdTuOljshknxyI0Ahha3D2qDijac79p3PNqcagA5FqjwxrHHKBxn
 aqEiJoPLx/iK24rPWxDakmk+myKvKK5LdT4/Qf5bW7JGqNAwf7ssBaxi3ug3+ohji/wM0kCCX
 ySa9852OPxpYADEDrPodtuCHnBYtSQEP5nKMJUdabU1YrWHZiBPg4g0x+VVbdob0q8z3i0hFu
 apJ5LMO7zp/GUQsxjwok41S1CIZUK6DG2qdEk7TIMuQQfbee+LDI5Pq0Ib6jQ0yoUMdKvvA0v
 /IUBypwsZsrnBBDbTf5A2OhZ0fdCvZAKedtU/bcyx+d4urhY+mjLSMliTby/iNuN3iPbygrWN
 ZViiWQOrxRlnUIh1QPtiUno2fM4/IobMT+DNMYAuNgnkjaaLHiZL3ioNV51V1/B0nAFxGltST
 ljcXfslm7UgHMX9ioAzsDLLchwbxv0jS98QVh3KfVM/TeOdfopPMKFRMmVRyHlr7noi1cfSwX
 0/MRyUHF2yXC/ospDDOukHg67EL1FuAITME7QZUxiu1TXjrar58zgy4EFfH5vR5FA3Fs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced driver causes a harmless Kconfig warning when
compile-testing random configurations:

WARNING: unmet direct dependencies detected for SND_SDMA_SOC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && DMA_OMAP [=n]
  Selected by [y]:
  - SND_OMAP_SOC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (ARCH_OMAP [=y] && DMA_OMAP [=n] || ARM [=y] && COMPILE_TEST [=y])

By simply allow build testing without DMA_OMAP, we can shut up that warning.

Fixes: dde637f2daf1 ("ASoC: omap: Introduce the generic_dmaengine_pcm based sdma-pcm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/omap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index f1d6799e08a9..6dccea6fdaeb 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -5,7 +5,7 @@ config SND_OMAP_SOC
 
 config SND_SDMA_SOC
 	tristate "SoC Audio for Texas Instruments chips using sDMA"
-	depends on DMA_OMAP
+	depends on DMA_OMAP || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_OMAP_SOC_DMIC
-- 
2.9.0
