Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B3CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492952086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwGemMPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492952086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeIDPMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:12:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38564 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeIDPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:12:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id i7-v6so2560856lfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vD7TcHCrb/iDwX/xErZR6WiQmFX64erZ+hL7VjI0A3E=;
        b=HwGemMPVq2EqLYY0o3SEnXwisrptnPF93YmsWaDyZugq5SRBqI/1256Em7ELFXsZF/
         S5dL0d5aIGt5mnFQxSXUUzezOGVjicRHXGVr9r5pL82O12Cnzf/N1xbsTk8+dYYxXZR0
         Nxww7TzX0lTMz9IEJTQdGsYe7nJ8ViyqUQR9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vD7TcHCrb/iDwX/xErZR6WiQmFX64erZ+hL7VjI0A3E=;
        b=tG4/+NBryOEpAWm2qScNmKHIlygYJr1dDE6UW5AsJ/8PGRxmKDmbJ7kS+ZtMz0zzC6
         0C4o6PpBQzd8WtxKWlYG+NBdoFpKRt56wvep9bRss5gZ65bByBjNyKUwuOZrz+vIPw1q
         oiPnwjnaNIn6NLExEml9I1ROxB0mcgoERHe87d5raoimhCI4U/XLfb07FKmHdlPIdUYA
         L4YPRpBebMzc9srFxFnpf60uFy66BDUspiljee/oQWSCfbhJBEPqKdGqlqGWLCqa23P+
         BT3QX//tGA+6Az8k8vvYrkf28KTfbISimJ9UNRewEG2pv+ZLA3IxpGG/IhKBCAJuqM0Z
         CskA==
X-Gm-Message-State: APzg51DPhNymt8C2V3qVrRAt+FPnHVQVOu9hR6K/GMSgU0G5j0ms2tHq
        JL3GOBHn5HyHzIJLcz3CpQ9fOg==
X-Google-Smtp-Source: ANB0VdakKuPISdFv8DrowTcjvj60UVLJ8ozSxQn/lSZpShFdv+GShBAg3HC2cu1d2Tf41ag+lH6vUQ==
X-Received: by 2002:a19:6d12:: with SMTP id i18-v6mr14809987lfc.72.1536058082057;
        Tue, 04 Sep 2018 03:48:02 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id f66-v6sm4271647lji.23.2018.09.04.03.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 03:48:01 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org, bamv2005@gmail.com, brgl@bgdev.pl,
        pbonzini@redhat.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, aarcange@redhat.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v6] selftests: add headers_install to lib.mk
Date:   Tue,  4 Sep 2018 12:47:21 +0200
Message-Id: <20180904104721.27535-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809080402.24469-1-anders.roxell@linaro.org>
References: <20180809080402.24469-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel headers aren't installed we can't build all the tests.
Add a new make target rule 'khdr' in the file lib.mk to generate the
kernel headers and that gets include for every test-dir Makefile that
includes lib.mk If the testdir in turn have its own sub-dirs the
top_srcdir needs to be set to the linux-rootdir to be able to generate
the kernel headers.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
---

I sent this (v5) a month ago and wondered if it got lost. Resending
unchanged.

Cheers,
Anders

 Makefile                                           | 14 +-------------
 scripts/subarch.include                            | 13 +++++++++++++
 tools/testing/selftests/android/Makefile           |  2 +-
 tools/testing/selftests/android/ion/Makefile       |  2 ++
 tools/testing/selftests/futex/functional/Makefile  |  1 +
 tools/testing/selftests/gpio/Makefile              |  7 ++-----
 tools/testing/selftests/kvm/Makefile               |  7 ++-----
 tools/testing/selftests/lib.mk                     | 12 ++++++++++++
 tools/testing/selftests/net/Makefile               |  1 +
 .../selftests/networking/timestamping/Makefile     |  1 +
 tools/testing/selftests/vm/Makefile                |  4 ----
 11 files changed, 36 insertions(+), 28 deletions(-)
 create mode 100644 scripts/subarch.include

diff --git a/Makefile b/Makefile
index 19948e556941..9c781e77fa24 100644
--- a/Makefile
+++ b/Makefile
@@ -299,19 +299,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
 export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
-# SUBARCH tells the usermode build what the underlying arch is.  That is set
-# first, and if a usermode build is happening, the "ARCH=um" on the command
-# line overrides the setting of ARCH below.  If a native build is happening,
-# then ARCH is assigned, getting whatever value it gets normally, and
-# SUBARCH is subsequently ignored.
-
-SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
-				  -e s/sun4u/sparc64/ \
-				  -e s/arm.*/arm/ -e s/sa110/arm/ \
-				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
-				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-				  -e s/riscv.*/riscv/)
+include scripts/subarch.include
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
diff --git a/scripts/subarch.include b/scripts/subarch.include
new file mode 100644
index 000000000000..650682821126
--- /dev/null
+++ b/scripts/subarch.include
@@ -0,0 +1,13 @@
+# SUBARCH tells the usermode build what the underlying arch is.  That is set
+# first, and if a usermode build is happening, the "ARCH=um" on the command
+# line overrides the setting of ARCH below.  If a native build is happening,
+# then ARCH is assigned, getting whatever value it gets normally, and
+# SUBARCH is subsequently ignored.
+
+SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+				  -e s/sun4u/sparc64/ \
+				  -e s/arm.*/arm/ -e s/sa110/arm/ \
+				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
+				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
+				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
+				  -e s/riscv.*/riscv/)
diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index 72c25a3cb658..d9a725478375 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -6,7 +6,7 @@ TEST_PROGS := run.sh
 
 include ../lib.mk
 
-all:
+all: khdr
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index e03695287f76..88cfe88e466f 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -10,6 +10,8 @@ $(TEST_GEN_FILES): ipcsocket.c ionutils.c
 
 TEST_PROGS := ion_test.sh
 
+KSFT_KHDR_INSTALL := 1
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index ff8feca49746..ad1eeb14fda7 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -18,6 +18,7 @@ TEST_GEN_FILES := \
 
 TEST_PROGS := run.sh
 
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 $(TEST_GEN_FILES): $(HEADERS)
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb47565c55..4665cdbf1a8d 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -21,11 +21,8 @@ endef
 CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
 LDLIBS += -lmount -I/usr/include/libmount
 
-$(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
+$(BINARIES):| khdr
+$(BINARIES): ../../../gpio/gpio-utils.o
 
 ../../../gpio/gpio-utils.o:
 	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
-
-../../../../usr/include/linux/gpio.h:
-	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
-
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 03b0f551bedf..87d1a8488af8 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -37,9 +37,6 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
 $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 	$(AR) crs $@ $^
 
-$(LINUX_HDR_PATH):
-	make -C $(top_srcdir) headers_install
-
-all: $(STATIC_LIBS) $(LINUX_HDR_PATH)
+all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
-$(TEST_GEN_PROGS) $(LIBKVM_OBJ): | $(LINUX_HDR_PATH)
+$(STATIC_LIBS):| khdr
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 17ab36605a8e..0a8e75886224 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -16,8 +16,20 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+top_srcdir ?= ../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH		?= $(SUBARCH)
+
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
+.PHONY: khdr
+khdr:
+	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
+
+ifdef KSFT_KHDR_INSTALL
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES):| khdr
+endif
+
 .ONESHELL:
 define RUN_TEST_PRINT_RESULT
 	TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index cccdb2295567..256d82d5fa87 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_FILES += udpgso udpgso_bench_tx udpgso_bench_rx ip_defrag
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
 TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/reuseport_bpf_numa: LDFLAGS += -lnuma
diff --git a/tools/testing/selftests/networking/timestamping/Makefile b/tools/testing/selftests/networking/timestamping/Makefile
index a728040edbe1..14cfcf006936 100644
--- a/tools/testing/selftests/networking/timestamping/Makefile
+++ b/tools/testing/selftests/networking/timestamping/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS := hwtstamp_config rxtimestamp timestamping txtimestamp
 
 all: $(TEST_PROGS)
 
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 clean:
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 9881876d2aa0..e94b7b14bcb2 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -26,10 +26,6 @@ TEST_PROGS := run_vmtests
 
 include ../lib.mk
 
-$(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-
-../../../../usr/include/linux/kernel.h:
-	make -C ../../../.. headers_install
-- 
2.18.0

