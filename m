Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59111ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0859D214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdWw8+Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0859D214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJSUzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:55:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34658 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJSUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:55:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so15844519plr.1;
        Fri, 19 Oct 2018 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bOm0HRmT/HL5EepHWbPNNUnvLKgst+PQQHeTsNhkPAY=;
        b=cdWw8+VsBI86IcDArWiR6DpHu07W/NCuIEyixrOcoNHxsP28FzRLgJso8uPIna9/fy
         2kJ6xQw/UIOTuJU2NgRXwMCs1dc31mElYwdE5HcLoAdMK7yvGBvB/KCMVNl+rbT8jW9d
         wB7yhld+7PX5iSpoQO8lL0EQLJwlYT46r582MiNKDNMnBlvEszDTE+q7uVX357hTFrYt
         ZB4uCONhfPWn7dp0Uiclc5K8LWOtZms9Fl1L7x00AAk82HBjvEZhlVpsrPQ4CXM+z27m
         /rREhz1OZgIrQmp+ffFhwSWOep/wOco5dAw3YmwPVF29ce4If7NO0Gl+2bK1LlG/jb14
         3Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bOm0HRmT/HL5EepHWbPNNUnvLKgst+PQQHeTsNhkPAY=;
        b=lERzTOV70M/jdqNehyZPFjTVAUilur1W/XUyjvaySZDvfhw/B5xJgKGcTVXGxn0Wtl
         r6OprFrnaBxLughxabaDSlrCcS0Q2R7t3HbtWc/EptkAgyqRbEgve7ry3VzWSbi869Y3
         A74tzuSJNCwhHLyrLKgpN+uSXmefwFuG49vMa/tJ2iBouOTkL0r52TGM6fmKrKUUwjHi
         s71MOcqZB03byNMWaBDbqp70i/gQHzYs0MCGQRmn/lW11qpNouYCYz4gVIwn+y73mtXJ
         ZZh2v++rlTQIpoYcBe8jDt1P0uN6+ZWkpGsXc44aKJONVb2RU1UlyBvC4XVI9rbbVS0W
         rWpQ==
X-Gm-Message-State: ABuFfogel92YNDUFljC50zktnHfJxJ878Km7EE+5cX0nc/0jpaHJ66aE
        LHYTctAJaurVHBwhaXffuMk=
X-Google-Smtp-Source: ACcGV63lQ++xgpge5a4+5IgmRhl8IM1qUJsIhp3WFWDgw9MDcUJlRgzEayX+41yHaVanS/iPVQDQPA==
X-Received: by 2002:a17:902:6843:: with SMTP id f3-v6mr33968645pln.64.1539953383858;
        Fri, 19 Oct 2018 05:49:43 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id o131-v6sm33640679pgo.53.2018.10.19.05.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:49:43 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Du Changbin <changbin.du@gmail.com>
Subject: [PATCH v2 4/4] kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Date:   Fri, 19 Oct 2018 12:49:21 +0000
Message-Id: <20181019124921.13780-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181019124921.13780-1-changbin.du@gmail.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will apply GCC '-Og' optimization level which is supported
since GCC 4.8. This optimization level offers a reasonable level
of optimization while maintaining fast compilation and a good
debugging experience. It is similar to '-O1' while perferring
to keep debug ability over runtime speed.

If enabling this option breaks your kernel, you should either
disable this or find a fix (mostly in the arch code). Currently
this option has only been tested on x86_64 and arm platform.

This option can satisfy people who was searching for a method
to disable compiler optimizations so to achieve better kernel
debugging experience with kgdb or qemu.

The main problem of '-Og' is we must not use __attribute__((error(msg))).
The compiler will report error though the call to error function
still can be optimize out. So we must fallback to array tricky.

Comparison of vmlinux size: a bit smaller.

    w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ size vmlinux
       text    data     bss     dec     hex filename
    22665554   9709674  2920908 35296136        21a9388 vmlinux

    w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ size vmlinux
       text    data     bss     dec     hex filename
    21499032   10102758 2920908 34522698        20ec64a vmlinux

Comparison of system performance: a bit drop (~6%).
    This benchmark of kernel compilation is suggested by Ingo Molnar.
    https://lkml.org/lkml/2018/5/2/74

    Preparation: Set cpufreq to 'performance'.
    for ((cpu=0; cpu<120; cpu++)); do
      G=/sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
      [ -f $G ] && echo performance > $G
    done

    w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

    Performance counter stats for 'make -j8' (5 runs):

        219.764246652 seconds time elapsed                   ( +-  0.78% )

    w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

    Performance counter stats for 'make -j8' (5 runs):

         233.574187771 seconds time elapsed                  ( +-  0.19% )

Signed-off-by: Du Changbin <changbin.du@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile                     |  5 +++++
 include/linux/compiler-gcc.h |  2 +-
 include/linux/compiler.h     |  2 +-
 init/Kconfig                 | 19 +++++++++++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 757d6507cb5c..ea908cfe8594 100644
--- a/Makefile
+++ b/Makefile
@@ -657,6 +657,10 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
+ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
+KBUILD_CFLAGS	+= $(call cc-option, -Og)
+KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
+else
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
@@ -667,6 +671,7 @@ else
 KBUILD_CFLAGS   += -O2
 endif
 endif
+endif
 
 KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 			$(call cc-disable-warning,maybe-uninitialized,))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 4d36b27214fd..2a76f7c64b54 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -85,7 +85,7 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#ifndef __CHECKER__
+#if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..9385c62e9f00 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -320,7 +320,7 @@ static inline void *offset_to_ptr(const int *off)
  * sparse see a constant array size without breaking compiletime_assert on old
  * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
  */
-# ifndef __CHECKER__
+# if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #  define __compiletime_error_fallback(condition) \
 	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
 # endif
diff --git a/init/Kconfig b/init/Kconfig
index 1e234e2f1cba..b01c7c654570 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1081,6 +1081,25 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+config CC_OPTIMIZE_FOR_DEBUGGING
+	bool "Optimize for better debugging experience (-Og)"
+	select NO_AUTO_INLINE
+	help
+	  This will apply GCC '-Og' optimization level which is supported
+	  since GCC 4.8. This optimization level offers a reasonable level
+	  of optimization while maintaining fast compilation and a good
+	  debugging experience. It is similar to '-O1' while preferring to
+	  keep debug ability over runtime speed. The overall performance
+	  will drop a bit (~6%).
+
+	  Use only if you want to debug the kernel, especially if you want
+	  to have better kernel debugging experience with gdb facilities
+	  like kgdb or qemu. If enabling this option breaks your kernel,
+	  you should either disable this or find a fix (mostly in the arch
+	  code).
+
+	  If unsure, select N.
+
 endchoice
 
 config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
-- 
2.17.1

