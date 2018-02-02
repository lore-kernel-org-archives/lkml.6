Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeBBO7Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:59:24 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:49262 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeBBO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:59:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 3/3] x86: error_inject: make  just_return_func globally visible
Date: Fri,  2 Feb 2018 15:56:19 +0100
Message-Id: <20180202145634.200291-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202145634.200291-1-arnd@arndb.de>
References: <20180202145434.100626-1-arnd@arndb.de>
 <20180202145634.200291-1-arnd@arndb.de>
X-Provags-ID: V03:K0:hiXWzmx7Z9S3IwGnYbP8u+Xj80EIya28N0XC+8ESANwln5WzUYU
 lm+5wplDOhe9YiEnaR4ui/BtiD+D1x0uNzQdfSugyGSWDWF+gh/4u/iNuqRQZYoSFTOEr/C
 NoziMIy1mh7RNl37ct2/xR2mkI728P9aTCVtEh5YaMxtqXVjYuQhieqzjI6yliKma8GVjnK
 TNoY0OY8dcU2B7NmL+FSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AMXJisyEtF0=:EE2SMXpObJdFU1Q1XeqD9r
 N/SCsXmJ7Ur9inHz8/OcqIofDxCShKXo5BjhFMGgtkucaPgvqUrQ+9qr0xJ17GxUpdGz2nbKt
 9cNRHEXIxd7ZBP8iaZxXyyjtI5rqE/+6+PGn3bstBxrSrGS+aBkVvhvAnlJGr6J8uUmCtHdEM
 hkSLzMXKvRyy7J289EeWtNERMLEnVraa2WgETeUiyIAwzLIZyN+LkLo2IiYYuxsAVeqiVjx+T
 O0j72LwezIFMPdh5wFnl4e6Aq+1wn3M87O3Pc11y1wsye/KRFpSxBwhLIjTz7/jNTdm0YgnVq
 a8D1CTTqaiR4N8bg0AtUZQzW0RIZm4118PG7OujzEiNV6MrVyiHHrAcEmxIdl4tAR1jr0Eqp5
 AgCrpo9kRFZm3HEoitHoUHRXsAK5or1qlI884VLrGWuAkE1MbuzQsS763MOe4rl/uK2ytS6PN
 bZw8XByA1ComF6OmevxfJ8nzUb8FPEbmUhQNm7XqXJotjfkzVzoqZiia1kd5YAa2NwxwxE7+S
 wA6qsXBW3ASTvJVbXZSAFqO8tbenWMua72b7cktbB4nDapfIuCxy9sUS1oktANclra0jt1BeA
 MLhZMCcczkTueKOGnR6UidCiA7cHBYjW/+KQ3Oy80p1PLRY6YpBIINP+RpHL4uhcEtGrql3mg
 bmmoAJzqaKuRPRuz62lO024e5YddcuVOts6lNKEdDhGVEO2zxkEVNaw1xNxMzWN6SEKoLu2zS
 EpyCJkI4Bj66rX/wsi+IoU+hxOHDZwu53MdIIw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With link time optimizations enabled, I get a link failure:

./ccLbOEHX.ltrans19.ltrans.o: In function `override_function_with_return':
<artificial>:(.text+0x7f3): undefined reference to `just_return_func'

Marking the symbol .globl makes it work as expected.

Fixes: 540adea3809f ("error-injection: Separate error-injection from kprobe")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/lib/error-inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index 7b881d03d0dd..3cdf06128d13 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -7,6 +7,7 @@ asmlinkage void just_return_func(void);
 
 asm(
 	".type just_return_func, @function\n"
+	".globl just_return_func\n"
 	"just_return_func:\n"
 	"	ret\n"
 	".size just_return_func, .-just_return_func\n"
-- 
2.9.0
