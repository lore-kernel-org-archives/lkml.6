Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2F2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8D720C01
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfBSVt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:49:58 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfBSVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:49:58 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M7KKA-1gxI8A0kgu-007mo4; Tue, 19 Feb 2019 22:49:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
Date:   Tue, 19 Feb 2019 22:49:06 +0100
Message-Id: <20190219214940.391081-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f/vy0JI+ZBaJTq6VorjxfZ+Z5wOykJeG99zj8JlrGsVU3qMEfOd
 bQ+6pv6D6Jw8ngrIrUXVVKww3K/C4f9onMQI3AXmTeiBfkLNhn9tUkEI9309roY1VJQD4l+
 POCSLpy/4elQKj8Q1dBr727CZWoQG/yf3L3hPTq9bRY1hS40VEv+Tx+sINobUFlK2u0fGOp
 xPMSbqqNkE00rzLyLJsHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sp9Y7cWE308=:KoAkoM0T8AYyR3hrEqo349
 AuKYP93+lEdQJ9V19lvqT+F4WaMD9SPI2/ZLibTatcCjV2Dlr5igZn2gNsfj7Y4Zdd5mPElZd
 wbhaFNRyN6WrrPWmp7HCz8Jb6v7FrrxRZx5B8OynoD+4Hasxvdk97uXu55DNCP/NwJEQea2gd
 7FVJE94gnFjaTGeuSkzAxMkFOR+QQ9JA3Zx/nG19dyclL7oWvT1H1XLcz1QWaGevL1dyUYyFj
 FOCllSZzmDkDnindfWq+T/vcUyvNTeDhTju/zZpGETT8ge9+m5NJ8s+P0ZZvMxio0pl45t1G2
 3YK1oJZXb+mpls6rHrIa4UKzGhlJrF+uBTe/n2pYQAWV1RF9s7zwKTjEEBfUE2BZCoNsvYvEt
 7ErSTzK9e7NKFJ5wUennshlSndxkekluR2Xigc8r4Ss4WinZrMxm0dPo3H6J4/t8dHmFqjbQV
 pqfj4enxUM9+af3WLDcsgtgECTWIytrzIOBJEhP1vtbdlQD1paD26OJkf9tCWDhmY6G9y76lf
 E4zRUh0xU6UX3+SyMAn9duhRFLZb/6Zcd2+36JMU6X6Cab8YK2+HYuDewSW/gENRS59sQ6D1+
 2g/mSCxCZ9w8rsmIjRSKN68RHyYXLnPUlhPajeDaBxeY0nBjvhCvC1ncn1ekBzt8IsOn2hp5A
 owhx+BWDQ3o+9m8NsRiUtWVyE+6naRukufBUVdID9w14udfefLfja4ACb3VU6dE3u1Zo5kE2I
 pJh73o8sVGWUykkmjSs5yRtGP2wlNa824DvygA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building an arm64 allmodconfig kernel with clang results in over 140 warnings
about overly large stack frames, the worst ones being:

drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size of 20224 bytes in function 'st7789v_prepare'
drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12: error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes in function 'max3421_spi_thread'
drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes in function 'slic_ds26522_probe'
drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in function 'ccp_run_cmd'
drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840 bytes in function 'stv0367ter_algo'

None of these happen with gcc today, and almost all of these are the result
of a single known bug in llvm.  Hopefully it will eventually get fixed with the
clang-9 release.

In the meantime, the best idea I have is to turn off asan-stack for clang-8
and earlier, so we can produce a kernel that is safe to run.

I have posted three patches that address the frame overflow warnings that are
not addressed by turning off asan-stack, so in combination with this change,
we get much closer to a clean allmodconfig build, which in turn is necessary
to do meaningful build regression testing.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Link: https://bugs.llvm.org/show_bug.cgi?id=38809
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.kasan      | 13 +++++++++++++
 scripts/Makefile.kasan |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 67d7d1309c52..219cddc913ac 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -103,6 +103,19 @@ config KASAN_INLINE
 
 endchoice
 
+config KASAN_STACK
+	int
+	default 0 if CC_IS_CLANG && (CLANG_VERSION < 90000)
+	default 1
+	help
+	  The LLVM stack address sanitizer has a know bug that
+	  causes excessive stack usage in a lot of functions, see
+	  https://bugs.llvm.org/show_bug.cgi?id=38809
+	  Disabling asan-stack makes it safe to run kernels build
+	  with clang-8 with KASAN enabled, though it loses some of
+	  the functionality.  We assume that clang-9 will have a fix,
+	  so the feature can be used.
+
 config KASAN_S390_4_LEVEL_PAGING
 	bool "KASan: use 4-level paging"
 	depends on KASAN && S390
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index f1fb8e502657..6410bd22fe38 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -26,7 +26,7 @@ else
 	CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
 	 $(call cc-param,asan-globals=1) \
 	 $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
-	 $(call cc-param,asan-stack=1) \
+	 $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
 	 $(call cc-param,asan-instrument-allocas=1)
 endif
 
-- 
2.20.0

