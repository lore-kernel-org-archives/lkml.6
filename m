Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBCC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9065E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9065E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeLKNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:35:06 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:38207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:35:06 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MXp1Q-1gyDNP1nyu-00Y9S6; Tue, 11 Dec 2018 14:34:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] kasan: fix kasan_check_read/write definitions
Date:   Tue, 11 Dec 2018 14:34:35 +0100
Message-Id: <20181211133453.2835077-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3NV4RcGQl1HBnCrKLlXV1Xu+qAbG+2o5BPe28qfau76/IQ0XUDe
 n1qHTrKjyqCnVLqJMeEafcYAZY1kcBx/unMD152Ef0ZO+O3iZHUl9HrecaJ8pR5/mXT+obu
 1NNCkPg4DSuRJJneMlbLJkrTFL77BFtyjiCtjwUAo/1O0lEiZKPpo5BHF2YyTEsMNhwRsD2
 CkQxxuYJMeAy2hAd0/Lzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rPwv5eM93nI=:p9zfN6yHNp8eRXxLlpjRvw
 KP660BQb2bNcXujATOGQ7MgKuNO9LS4uie+hacaxL7eZCvoiIPwB3mCtnfiYGl68fqC//Dxv1
 zBmAU5+oHkqxW/SfB9bobbPFGpcEo6f6h2GMdtwSwy9clqfJm8vs1QA7yuRNxRWLzMsqAsbyZ
 sPp2BByri/fi/lWTNLk7BIa4v85sWm/5vwZTTsFtf1MwQh9IMVVsdfulUFhNxiUGE+cJ6/k2b
 3hb9IJqt4mooyt9W2J2hlUxrFZ3Hr4EV1YHhM94q271WDtvpg24H3EfBD4UU/LYtXIRDJGI5g
 YtEgoZ3Xdq/9qWAcd1tVHnI9NVuErY7+m00Ii1niH6Hld1Hyjm5420rn3uLvznl7gMb4z7/IU
 If11wn66EJ/kGLrhXbSxCHxe9+EOAulTcaMmi2n19CyIeFrtAqoV+/8BS5AOKrR7XyiCg3Iwb
 lTz4ShQYLdBEsHn5Pejj5tcj5wsAe7I6YAtvsiur60wDVSpkz+1YwhqbJMuaVUH23FZw4qDe1
 jpAp+6y01rIXj2/MwNv/WCjVmPme4XM9Q7MXir1u6EihfJXAtwBbC1c1lGHdjeD8pAQwEtFOv
 QemUHy8/SSmUed140DH4RNLfO5Zl1VcPnbi9yX4kuE+mk9sZtb1FmBxTMVesesZHD1a8SY2/n
 rzz0e93LfLJ07zPLotFvUem5w45U3OZ3i9rrkwFt6L6dvsR4jMmxKD5sUw68o3AkVQxsNo5Tj
 a1EvntzjtiT5jrgy32k0mpI1zOimV0c5/YqKQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building little-endian allmodconfig kernels on arm64 started failing
with the generated atomic.h implementation, since we now try to call
kasan helpers from the EFI stub:

aarch64-linux-gnu-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: in function `atomic_set':
include/generated/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'

I suspect that we get similar problems in other files that explicitly
disable KASAN for some reason but call atomic_t based helper functions.

We can fix this by checking the predefined __SANITIZE_ADDRESS__ macro
that the compiler sets instead of checking CONFIG_KASAN, but this in turn
requires a small hack in mm/kasan/common.c so we do see the extern
declaration there instead of the inline function.

Fixes: b1864b828644 ("locking/atomics: build atomic headers as required")
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/kasan-checks.h | 2 +-
 mm/kasan/common.c            | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index d314150658a4..a61dc075e2ce 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_KASAN_CHECKS_H
 #define _LINUX_KASAN_CHECKS_H
 
-#ifdef CONFIG_KASAN
+#if defined(__SANITIZE_ADDRESS__) || defined(__KASAN_INTERNAL)
 void kasan_check_read(const volatile void *p, unsigned int size);
 void kasan_check_write(const volatile void *p, unsigned int size);
 #else
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 03d5d1374ca7..51a7932c33a3 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -14,6 +14,8 @@
  *
  */
 
+#define __KASAN_INTERNAL
+
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-- 
2.20.0

