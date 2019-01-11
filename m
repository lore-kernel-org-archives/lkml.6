Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C37BC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9282177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217152;
	bh=otsIriULA5DCVKBX4YO826vARP9+x0A6ihY2mGkYvUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cysxd8qv9QsQruXOJXAiao7mK+9Pea3savOH5I5ctEH7o0nrD0kr5c6QZYS6k7fqt
	 ZKrv1GZlOtqO2jQcLHSCd2z1TkIufFFbWZB6XD+dpgo8sL6OUF8Ih5yylSDZ3HnHhO
	 3yDFZBnpZeibbwaD1VJRI2ADtSzJzQqmi8MaPsGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbfAKOcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389428AbfAKOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD132133F;
        Fri, 11 Jan 2019 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217147;
        bh=otsIriULA5DCVKBX4YO826vARP9+x0A6ihY2mGkYvUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/vTvmU3p0WM3Uh8zZ6WMyI0RKxOnLhyWoV7cmATlb01Hx7YxHCYT9eS5jwZrXnox
         80zQBQ8K1kAMPD+7xGjmNgiT1B3iAmm9sjY4yajhma4Gvehiv6sxxVaKyh2kTxp0Yf
         HPFEcXzBABM5xFvhjP/7G5oGne+vpvJYL0DiCjto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kelly <martin@martingkelly.com>,
        Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pali Rohar <pali.rohar@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH 4.14 058/105] tools: fix cross-compile var clobbering
Date:   Fri, 11 Jan 2019 15:14:29 +0100
Message-Id: <20190111131107.880515108@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kelly <martin@martingkelly.com>

commit 7ed1c1901fe52e6c5828deb155920b44b0adabb1 upstream.

Currently a number of Makefiles break when used with toolchains that
pass extra flags in CC and other cross-compile related variables (such
as --sysroot).

Thus we get this error when we use a toolchain that puts --sysroot in
the CC var:

  ~/src/linux/tools$ make iio
  [snip]
  iio_event_monitor.c:18:10: fatal error: unistd.h: No such file or directory
    #include <unistd.h>
             ^~~~~~~~~~

This occurs because we clobber several env vars related to
cross-compiling with lines like this:

  CC = $(CROSS_COMPILE)gcc

Although this will point to a valid cross-compiler, we lose any extra
flags that might exist in the CC variable, which can break toolchains
that rely on them (for example, those that use --sysroot).

This easily shows up using a Yocto SDK:

  $ . [snip]/sdk/environment-setup-cortexa8hf-neon-poky-linux-gnueabi

  $ echo $CC
  arm-poky-linux-gnueabi-gcc -march=armv7-a -mfpu=neon -mfloat-abi=hard
  -mcpu=cortex-a8
  --sysroot=[snip]/sdk/sysroots/cortexa8hf-neon-poky-linux-gnueabi

  $ echo $CROSS_COMPILE
  arm-poky-linux-gnueabi-

  $ echo ${CROSS_COMPILE}gcc
  krm-poky-linux-gnueabi-gcc

Although arm-poky-linux-gnueabi-gcc is a cross-compiler, we've lost the
--sysroot and other flags that enable us to find the right libraries to
link against, so we can't find unistd.h and other libraries and headers.
Normally with the --sysroot flag we would find unistd.h in the sdk
directory in the sysroot:

  $ find [snip]/sdk/sysroots -path '*/usr/include/unistd.h'
  [snip]/sdk/sysroots/cortexa8hf-neon-poky-linux-gnueabi/usr/include/unistd.h

The perf Makefile adds CC = $(CROSS_COMPILE)gcc if and only if CC is not
already set, and it compiles correctly with the above toolchain.

So, generalize the logic that perf uses in the common Makefile and
remove the manual CC = $(CROSS_COMPILE)gcc lines from each Makefile.

Note that this patch does not fix cross-compile for all the tools (some
have other bugs), but it does fix it for all except usb and acpi, which
still have other unrelated issues.

I tested both with and without the patch on native and cross-build and
there appear to be no regressions.

Link: http://lkml.kernel.org/r/20180107214028.23771-1-martin@martingkelly.com
Signed-off-by: Martin Kelly <martin@martingkelly.com>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Pali Rohar <pali.rohar@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/cgroup/Makefile            |    1 -
 tools/gpio/Makefile              |    2 --
 tools/hv/Makefile                |    1 -
 tools/iio/Makefile               |    2 --
 tools/laptop/freefall/Makefile   |    1 -
 tools/leds/Makefile              |    1 -
 tools/perf/Makefile.perf         |    6 ------
 tools/power/acpi/Makefile.config |    3 ---
 tools/scripts/Makefile.include   |   18 ++++++++++++++++++
 tools/spi/Makefile               |    2 --
 tools/usb/Makefile               |    1 -
 tools/vm/Makefile                |    1 -
 12 files changed, 18 insertions(+), 21 deletions(-)

--- a/tools/cgroup/Makefile
+++ b/tools/cgroup/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for cgroup tools
 
-CC = $(CROSS_COMPILE)gcc
 CFLAGS = -Wall -Wextra
 
 all: cgroup_event_listener
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -12,8 +12,6 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CC = $(CROSS_COMPILE)gcc
-LD = $(CROSS_COMPILE)ld
 CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := lsgpio gpio-hammer gpio-event-mon
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Hyper-V tools
 
-CC = $(CROSS_COMPILE)gcc
 WARNINGS = -Wall -Wextra
 CFLAGS = $(WARNINGS) -g $(shell getconf LFS_CFLAGS)
 
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -12,8 +12,6 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CC = $(CROSS_COMPILE)gcc
-LD = $(CROSS_COMPILE)ld
 CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer
--- a/tools/laptop/freefall/Makefile
+++ b/tools/laptop/freefall/Makefile
@@ -2,7 +2,6 @@
 PREFIX ?= /usr
 SBINDIR ?= sbin
 INSTALL ?= install
-CC = $(CROSS_COMPILE)gcc
 
 TARGET = freefall
 
--- a/tools/leds/Makefile
+++ b/tools/leds/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for LEDs tools
 
-CC = $(CROSS_COMPILE)gcc
 CFLAGS = -Wall -Wextra -g -I../../include/uapi
 
 all: uledmon led_hw_brightness_mon
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -144,12 +144,6 @@ define allow-override
     $(eval $(1) = $(2)))
 endef
 
-# Allow setting CC and AR and LD, or setting CROSS_COMPILE as a prefix.
-$(call allow-override,CC,$(CROSS_COMPILE)gcc)
-$(call allow-override,AR,$(CROSS_COMPILE)ar)
-$(call allow-override,LD,$(CROSS_COMPILE)ld)
-$(call allow-override,CXX,$(CROSS_COMPILE)g++)
-
 LD += $(EXTRA_LDFLAGS)
 
 HOSTCC  ?= gcc
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -56,9 +56,6 @@ INSTALL_SCRIPT = ${INSTALL_PROGRAM}
 # to compile vs uClibc, that can be done here as well.
 CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
 CROSS_COMPILE ?= $(CROSS)
-CC = $(CROSS_COMPILE)gcc
-LD = $(CROSS_COMPILE)gcc
-STRIP = $(CROSS_COMPILE)strip
 HOSTCC = gcc
 
 # check if compiler option is supported
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -42,6 +42,24 @@ EXTRA_WARNINGS += -Wformat
 
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
+# Makefiles suck: This macro sets a default value of $(2) for the
+# variable named by $(1), unless the variable has been set by
+# environment or command line. This is necessary for CC and AR
+# because make sets default values, so the simpler ?= approach
+# won't work as expected.
+define allow-override
+  $(if $(or $(findstring environment,$(origin $(1))),\
+            $(findstring command line,$(origin $(1)))),,\
+    $(eval $(1) = $(2)))
+endef
+
+# Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+$(call allow-override,AR,$(CROSS_COMPILE)ar)
+$(call allow-override,LD,$(CROSS_COMPILE)ld)
+$(call allow-override,CXX,$(CROSS_COMPILE)g++)
+$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
 endif
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -11,8 +11,6 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CC = $(CROSS_COMPILE)gcc
-LD = $(CROSS_COMPILE)ld
 CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := spidev_test spidev_fdx
--- a/tools/usb/Makefile
+++ b/tools/usb/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for USB tools
 
-CC = $(CROSS_COMPILE)gcc
 PTHREAD_LIBS = -lpthread
 WARNINGS = -Wall -Wextra
 CFLAGS = $(WARNINGS) -g -I../include
--- a/tools/vm/Makefile
+++ b/tools/vm/Makefile
@@ -6,7 +6,6 @@ TARGETS=page-types slabinfo page_owner_s
 LIB_DIR = ../lib/api
 LIBS = $(LIB_DIR)/libapi.a
 
-CC = $(CROSS_COMPILE)gcc
 CFLAGS = -Wall -Wextra -I../lib/
 LDFLAGS = $(LIBS)
 


