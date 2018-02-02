Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeBBPI5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:08:57 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeBBPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:08:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: xscale: fix gcc-8 build
Date: Fri,  2 Feb 2018 16:07:35 +0100
Message-Id: <20180202150756.420422-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202150756.420422-1-arnd@arndb.de>
References: <20180202150756.420422-1-arnd@arndb.de>
X-Provags-ID: V03:K0:2xE8Ysl+nge5G68+SZQ6I0gm8eZTMxRMNfb/OOim3hKtJxfhhnQ
 bebJdDMzeqhZ/v6tA0gomxUpE7lKLOlDpZdImYmhdOmE35PiiIzKNLxaf35HgM7r8zvTCqe
 uFS1Tz4IN5HcdRvn2Qj5w8zev63CRGTxt5ySXTw/qeMx35KjziEyTj0668OhAN1yJcrTUGg
 5vU2V6F/iestPg0ZfIRpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3p06aYed3us=:CXvv4pWHrhIHFEYaL8/Sp/
 Cpk68x+Ndu+I0dAL8/89yy5jiKXD2jTg//m6fWVPDN0YKAVnsfMe5qcsMwTQzLR94y3SrAD0L
 5BbZ5QrUFvQ325KZ3UHRZUNqayRzUSg6SBM+F/b4Cj/2nJWbDGAEpIqtG4iDEXLhRLt3jfvTR
 Ykwgbf3nJ+dvgxGXayhpnWEY62/ou3FYDz9vVxrG+Cr8Xhy6+39XoFA4qZxSAl3UaSt/NQ5qL
 4T5lqWhxTHnUz7at5tInKrMDdoa+1bWLwGnZe6CbGCoV7+f3xXzeAwz1V6JaxkCC87e3+mAEe
 1AKnMIXd8czSziQNtAz8zOElnzpRcusPQkGyPZCYubX2gZWBaEv5TrEiKP0YypYGIlT30IB2t
 kKqqFvuTYtm53k8bPFK9xZdZg7RDqpCfIpQH0HF9UerRkuBsZuEouAUeWDXa8dgueLlzuN4CD
 ISMZWM0qfYhwwSbqOljMrHfteN4l1j/0NlzTwCjlNH1Ap09V6TJW4VQP9kpQaJFsOYcPbw5xq
 huPwrcEoAlg630z9LG/fUaYxGyhfgUaVxGO3EzWlfyX+MZXdCz6P6yT/aZwUi0cX6oFAmELN5
 PlruUZn67yggaGG0vLymXFMYhRiFgl+39uCNvi3IYTD0Irql9rD2VCCHV7FGWf8fRqHC6+3vF
 48xtR76ID2d7mJz7gPFBt8UF2sLYW/7DmQ32B34u/IatMrLaNTSezR7WYj4gRN0UpPbT7vSsg
 NM5g9EN7KgHwUbXWkm2JnP+FNjL6Zfcac8hI2g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use a hack in xscale-cp0.c to allow building it for ARMv4 while
also using ARMv5TE and iWMMXt specific inline assembly, by
adding a top-level asm statement.

Unfortunately that hack no longer works with gcc-8, since it will
revert back to the normal architecture. The recommended way of
handling this is to use __attribute__((target("armv5te"))) on the
functions that need it, or #pragma GCC target("arch=armv5te").
Either of those work with gcc-8, but not earlier versions, and
it seems worse to combine that with the old hack.

Instead, this adds the .arch statement to each inline assembler
statement that needs it individually. That is also slightly uglier
than the previous hack, but it works with all compiler versions
and documents better why we need the override in the first place.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84129
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/xscale-cp0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/xscale-cp0.c b/arch/arm/kernel/xscale-cp0.c
index 77a2eef72115..e06a2f6dac4f 100644
--- a/arch/arm/kernel/xscale-cp0.c
+++ b/arch/arm/kernel/xscale-cp0.c
@@ -17,11 +17,10 @@
 #include <asm/thread_notify.h>
 #include <asm/cputype.h>
 
-asm("	.arch armv5te\n");
-
 static inline void dsp_save_state(u32 *state)
 {
 	__asm__ __volatile__ (
+		".arch	armv5te\n\t"
 		"mrrc	p0, 0, %0, %1, c0\n"
 		: "=r" (state[0]), "=r" (state[1]));
 }
@@ -29,6 +28,7 @@ static inline void dsp_save_state(u32 *state)
 static inline void dsp_load_state(u32 *state)
 {
 	__asm__ __volatile__ (
+		".arch	armv5te\n\t"
 		"mcrr	p0, 0, %0, %1, c0\n"
 		: : "r" (state[0]), "r" (state[1]));
 }
@@ -134,7 +134,8 @@ static int __init cpu_has_iwmmxt(void)
 	 *	tmrrc	%0, %1, wR0
 	 */
 	__asm__ __volatile__ (
-		"mcrr	p0, 0, %2, %3, c0\n"
+		".arch	armv5te\n\t"
+		"mcrr	p0, 0, %2, %3, c0\n\t"
 		"mrrc	p0, 0, %0, %1, c0\n"
 		: "=r" (lo), "=r" (hi)
 		: "r" (0), "r" (0x100));
-- 
2.9.0
