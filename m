Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeBTWBM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:01:12 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBTWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
Date: Tue, 20 Feb 2018 22:59:50 +0100
Message-Id: <20180220215954.4092811-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
X-Provags-ID: V03:K0:2jo0KNnjQFA0vHEhz+QmUaepQ1mlmpluQzE/EAn1H7/QvIH7Jzi
 ViH2im1R9pEKhC2Dv95f9PRRrvj3sqK+j/y3qgmjv7ITwBfRbOMBajWau7wswsoIgSMc1hJ
 U1m9vV8Wbni0bsezmL0YrzR1l08syn1u5NKxvFyDT2kDeB2RsCK2SMP6D/NabQkZv7YLqLA
 u2/m5bL6bHm61GCjgocig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+KkU0vohw3Q=:hJSmopaCFGYevUdnoWXnpD
 jig8SDTv5gJF+jvcuMZDB3t+nwZC0jltgmNZApp6m7nfq1n6s590WtuYnSeYlEanQVDFWkjh9
 slYt7I4MU+ROQIhqsrocOPcJZ2p4p9RCtqBe9csiiMhr/zKEsFcscSDn2IiNrh2ziV4gOkjpW
 884+wwMU3sVb5u85xOGvlj3TYiwR76wXQIWEJxL4Rnm3b4z4NglKv2eVBowy2Il+C+K2GHETA
 Lhuiwod9AL/79UBkPLGOryDKYeVzpGnehzdoV4+YKJUPY3n9DeFSLHNEEJ45npBvCBpxw9BaS
 wBlPBgSjLZ/3j5PF2iSaRltTgUu2TIww2N7fQPhvthZ272u0b9IjZJpe612Ee+LSjYer69oJk
 8vp+DNZ9GyeBOOMifEy1QxXK8RMD/WsHDyp+7mlXwlXccVFKNznrwR5ZWZ0AQDoehlEgwCMlG
 F3fLzDkfqla0Ovy2Upot7lNafm7oL0MAgSlxTJTFmLoNIjjhdYA2e6+kpSsBLel2sXIhVIi0w
 aF/5mETwzjKEDyBWisJ4DuhDjIJV3AK0/6PXyJozGfRsLwgJ83IKd7xxTXxeKpN8FeEQ8DRz7
 nmESGGt+4HBiehcGkH34KzaDiLKJ3iNM41K6YlUz7LODZx+Kv5/5dlniVk+x1y/KnT5TTb8Pn
 1G4UfrVaMS/dIF2KJ3czF9BQ2+A4+kGa2QmBmc/ARyuEgkkwd0L3BxDeY9JfUCD6QBlsQADWa
 6WCtSv/ny9DRw5Ytzf1w9nnB7td6hS9NViB7Xw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need some way to pass -mbig-endian to the linker during the
LTO link stage, otherwise we get a waning like

arm-linux-gnueabi/bin/ld: arch/arm/lib/clearbit.o: compiled for a big endian system and target is little endian

for each file we link in.

There is probably a better method of passing that flag, I'm just
adding it to a different hack that I added earlier for x86 LTO
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 33b7eb4502aa..f39c2e2d55c0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -49,11 +49,13 @@ endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
+KBUILD_BIARCHFLAGS += -mbig-endian
 CHECKFLAGS	+= -D__ARMEB__
 AS		+= -EB
 LD		+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
+KBUILD_BIARCHFLAGS += -mlittle-endian
 CHECKFLAGS	+= -D__ARMEL__
 AS		+= -EL
 LD		+= -EL
-- 
2.9.0
