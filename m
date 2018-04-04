Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeDDMbi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:31:38 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48231 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDDMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:31:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <linux@armlinux.org.uk>,
        Jinbum Park <jinb.park7@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: decompressor: mark error() as __noreturn
Date: Wed,  4 Apr 2018 14:30:50 +0200
Message-Id: <20180404123117.3575773-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:KQIJs5Cz/ZkMSEA+TmjjY3S+0OU/dzNTCnZAKHQWA1NyXMg+mTN
 dro8mQfrPVYkFWVVlRRocM+OZBP9RsrvnhEcH0saYRqi9Iqh17tgeq8/YgHG6mVxIrFape4
 OHFrhIt9p1A64dBktG1XJtnsmFbS6TPtSV3RCmxKbpDXqr9+hEB8ZQzh+65pOQ5gE3h/2FN
 JrAQHiLFgFub3o7uU9OqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iTRZYIkqSzw=:PZdnCEYAxKtSGmgb/yEsjd
 DxBketQggQP69tF/2T5BjGWLPFwoOAxUiUuXpOMtO3vHx63YpGZVhReUw6o97Lx1kx1KBPFf1
 FUshPbM1nqmzQpi3ur9NC9LsH3WlzyWm156GF/Kuz7PoWcnC7DGx2f3wh8DDi8qny9Xs90jH7
 J33pi6hgWj+Bc/V3yF+tGrGU/HC21Zp/ru8UK0tZ0ADHcvoWmonjzRREFkKxxhVylWz07AXsR
 crMdcoBiIfTn8cUPLYAGHtSYxjXEY0EFz0pzoC/YVA0UNPNF3IKl04r97a2fv2r2DWM69eSTd
 00zverlcx6c92HORKxtB+s11fLCst0dhEcGD913C2enpqRq3ZVa5XIKtiad+l4F5yqc8Heqyh
 WaOzEj2ftV0yZVNS+rN3suVB7FIb7f4XWpwBmm9D/3hz7P9/67EuGKKZmqjPfL8TZ5dhab0LY
 zYjCZmpQdo557SwsCDBIConznAC45un6YrJdRySIZ7oti9cOxFrbbY9Qp1E1jvkxxd+GU0U1B
 sBu6B0Hg5qqPvv4ya8d9wiFjcfAQ3QDFae8j2VYy9MiCC72+gbGYtkTmrXYz5eG34XbCYa03x
 Fpld96ICVaqbnfkvtr1tcGJYfbHV4kuvZSxM7cAndd4MnQSDxZQNjkmnOJOQF2f4/wRW+g+dW
 aynGZxvvei4UniyM7Lm0QfdpODnk9CsFDZp7vSBlDVHQ4lXZaA1/CyaFmgqyJhGYX0qtQv3ou
 NTwsp2DF9huG68NCbrEPoNHSnFfDhmfQ1zIo5A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc complains about fortify_panic() possibly returning:

arch/arm/boot/compressed/misc.c: In function 'fortify_panic':
arch/arm/boot/compressed/misc.c:167:1: error: 'noreturn' function does return [-Werror]

This annotates the error() function as __noreturn, which lets gcc
see in all configurations that it fortify_panic() cannot return either.

Fixes: ee333554fed5 ("ARM: 8749/1: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 009db7d275f8..313a587d656b 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -24,7 +24,7 @@ unsigned int __machine_arch_type;
 #include <linux/linkage.h>
 
 static void putstr(const char *ptr);
-extern void error(char *x);
+extern void error(char *x) __noreturn;
 
 #include CONFIG_UNCOMPRESS_INCLUDE
 
-- 
2.9.0
