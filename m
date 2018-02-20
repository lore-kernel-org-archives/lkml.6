Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeBTPJ7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:09:59 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:39271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbeBTPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:09:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>,
        Jinbum Park <jinb.park7@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: make CONFIG_DEBUG_WX depend on MMU
Date: Tue, 20 Feb 2018 16:09:19 +0100
Message-Id: <20180220150932.3285766-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:1pubBCoyK7Vg1tXRaiUowkWqm20Md9suTAdDsnV4jjuPy33aM1q
 K1GU3Q6Kg6NFzgMbkT35Kc3NIA1CAuEZQXMKbVIVVxq17PM8smSBveu+XCtp8WU/j/bGYfe
 /imGXFfYEuf8iukRWJJcjc979247qNIbc0UGsJ0+RI9iq6tXoYIRVgdk3t9SmSsfVVLV+t0
 MG0FGyTUJjbf9mdIXb69g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZYwGFYNpsEA=:DXZnnXZYEXPBRl6wo5CJSV
 TMGvVgya691kufufp48KiS188U88u1ue9PzuSnX30hoCE1jPSkpkh135gyZ0gOW71C0lTEus+
 +9x70Jl1dPQhBD1QeFEOy8wHmDqPiLb010ZpNIcxbeBPuQgALJAU26qJ9P7RyMNzKIfeZdfQt
 Tm0EG6z6+HkfLs1gbTc/0biY39q4U/HhZPu4Qoh2apB5Oz2Wn486rv6nIVXj1ZyfF9jb4q3wg
 4gCWGmhq6/yWnEgesb+zLvsekexjEUI2w5V1J3k0M87hk7E9nmUc2TS6B0w43v1E3sQGWFs0O
 rvgj2Mxlw3ZT3eKJqTX8qknGYWo6ajuvmGwmXkK1FudqlT2T+YDCUlnHoCU5X7m4d5BC7NCYZ
 Bd6qU+e58DhbUH5su2sdJZZz8DJQPT5X4pFiO1VADMUVDhSSqnWzIhQRAH0U9ZmPyZJ6UmPf8
 DOKK3HaH6PCkH9z0+DgyTyazi7C37OTDfN+bEsNIAoKOsZtBaqkd2CJP2y4jxv6SPaVpzOrDH
 i5eOod9qaYAmZFU3o5WbRNTM1D9LdA/g1PFvFeUgCRlSwgxA9lgTOuJSPcXb4JliaOwks77hj
 icGVn/JkzdIHwmaaSenMGASDBGGUSz/sgheSmY1I6KAs3Dzf+wnztLnrgz7Z8vd5FFRlD7sau
 VwbSOG9CvldBhsTqRToqi8+lRBT+VFLgb47R8c9w8YOT20Ws14Tv5dMfyreXjM2AYltLpL7Ei
 aYWtGBaX5UrmnnSqvl5TfGztg3RbqccFuAgXfg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_MMU, this results in a build failure:

./arch/arm/include/asm/memory.h:92:23: error: initializer element is not constant
 #define VECTORS_BASE  vectors_base
arch/arm/mm/dump.c:32:4: note: in expansion of macro 'VECTORS_BASE'
  { VECTORS_BASE, "Vectors" },

arch/arm/mm/dump.c:71:11: error: 'L_PTE_USER' undeclared here (not in a function); did you mean 'VTIME_USER'?
   .mask = L_PTE_USER,
           ^~~~~~~~~~

Obviously the feature only makes sense with an MMU, so let's add the
dependency here.

Fixes: a8e53c151fe7 ("ARM: 8737/1: mm: dump: add checking for writable and executable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 7b3d9c5c73bb..6db106b5b9e9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -22,6 +22,7 @@ config ARM_PTDUMP_DEBUGFS
 
 config DEBUG_WX
 	bool "Warn on W+X mappings at boot"
+	depends on MMU
 	select ARM_PTDUMP_CORE
 	---help---
 		Generate a warning if any W+X mappings are found at boot.
-- 
2.9.0
