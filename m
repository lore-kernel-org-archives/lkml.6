Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034901AbeE1Psc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:48:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030737AbeE1Ps1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:48:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Ondrej Mosnacek <omosnacek@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: morus - Hide Kconfig option for glue code
Date: Mon, 28 May 2018 17:47:45 +0200
Message-Id: <20180528154806.2621106-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:TvFRafqsmQixTaQges1esfoXih1GkM4pgZ2SYKNuCewobS8UaXq
 KiMHwAcWDyA6SjZlXfADEBsIv2/2TBomBn3AANiLZvBm72G+pgnavxkgI6R0J+of8sO8h4b
 70Y/MZUIPi73dwhZUvPXBDTOFvu8E7R7J6vMAfsaxx64/fLpAHhppO1rhovDOZOsF5sShnP
 sHw4xA6rQK47xY0PyMndw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UTbW7pFYclg=:EdTJmcBCmnoyqt959HxQaL
 mPdwH2zuaqjeRtFf+tQwwlEw1ntIoFtBGO/eMUsMoxJEl2oIztMltwGq1SaVS+KbSplzYk4IU
 OqBqPTUCq6758s+0124TjJo7EZfjItY/32ZnRzjs5YE9ZdRWzYIKd6WSojtNDpJC6LmJUJ6BF
 lHXVsJ5Mi/ZTxZcuFtOdIMIzy4utBCio/+ibMD1ro/OnL+qni9E/mi8FVyaWW4VE44ybQCV1+
 M4L/enP7zndZruNQW1eN4z73hO6oxFzYC4W+jnP7oi53Iv1gHSiOpj0q3LZh4YvQXHzURU3Bf
 9vw41CjQzdhGfpTKmtIjaKG7F/LuLzKXkTlAbMm2tK5qKxprLmsQNwEPIYw6/rrXx3OcF9CpG
 aUDwCBGGRjautQDMb+5GO7sUpr3+izN6Odk6ipn7al1jwwlV/e07H46bAUFTrgOTJ4XN2GkUf
 rRenboD7n+qrcAgPVKHOvki7QT1uwQyXDIebvbbEUwkEzp66xR6H+/qpE2bcH6MltjhPeHJPQ
 Dq5oTosY9iFKiNS9A3aqXxL4wwvJa265hFdlTvLhn0KcOwuAZFiBC6H0Kd0hJqIUrGFVJ0QdH
 uYdWzvZm6mU4DJu47vNAR/BLcdIuHnkBz4yT41Q3gCUQkIsCM0aM9C2BirhNuIpnjR3diCQ2b
 2Gf2iqMbPOdv209BXxQz7EEo2MLaw+fcQOo4VTrYEsKm5H4W2V2T0g9/Eg7eE1uLiOYY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the glue drivers for morus640 and/or morus1280 leads to a build failure
on all non-x86 architectures:

crypto/morus1280_glue.c:24:10: fatal error: asm/fpu/api.h: No such file or directory
scripts/Makefile.build:311: recipe for target 'crypto/morus1280_glue.o' failed
crypto/morus640_glue.c:24:10: fatal error: asm/fpu/api.h: No such file or directory
scripts/Makefile.build:311: recipe for target 'crypto/morus640_glue.o' failed

There really is no reason to enable these unless we also have a real
driver using the glue, so the Kconfig option can be hidden and remain
selected by the x86 specific SIMD drivers or any others getting added
in the future.

Fixes: 56e8e57fc3a7 ("crypto: morus - Add common SIMD glue code for MORUS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 75f5efde9aa3..e11c59d26ac5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -341,7 +341,7 @@ config CRYPTO_MORUS640
 	  Support for the MORUS-640 dedicated AEAD algorithm.
 
 config CRYPTO_MORUS640_GLUE
-	tristate "MORUS-640 AEAD algorithm (glue for SIMD optimizations)"
+	tristate
 	select CRYPTO_AEAD
 	select CRYPTO_CRYPTD
 	help
@@ -363,7 +363,7 @@ config CRYPTO_MORUS1280
 	  Support for the MORUS-1280 dedicated AEAD algorithm.
 
 config CRYPTO_MORUS1280_GLUE
-	tristate "MORUS-1280 AEAD algorithm (glue for SIMD optimizations)"
+	tristate
 	select CRYPTO_AEAD
 	select CRYPTO_CRYPTD
 	help
-- 
2.9.0
