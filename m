Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2D3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361FF2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT7RgJNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361FF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeJEX0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbeJEXN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:13:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D4620834;
        Fri,  5 Oct 2018 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756075;
        bh=pg/zq5uVsx/WLdOsEb2kywynth0JDFD3XUDmA5N/z7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iT7RgJNBYYpU5YXQeYqQ4ty8kMBnRkRVAmmeyx119w6j0/2iMEFNiDxdM2RogDGVR
         vMFlhWf02mXa4XWXgQjoLmd0vdgwW7wwgzOqgmK1XsnN6yVRsOX5iWOl7BOd5n8BAI
         uXTEqkG+1ZEvgv6rzoRd25eS0ZeQKFNdU8nGDBHc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 10/48] selftests: add headers_install to lib.mk
Date:   Fri,  5 Oct 2018 12:13:46 -0400
Message-Id: <20181005161424.20521-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit b2d35fa5fc80c27e868e393dcab4c94a0d71737f ]

If the kernel headers aren't installed we can't build all the tests.
Add a new make target rule 'khdr' in the file lib.mk to generate the
kernel headers and that gets include for every test-dir Makefile that
includes lib.mk If the testdir in turn have its own sub-dirs the
top_srcdir needs to be set to the linux-rootdir to be able to generate
the kernel headers.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
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
index 466e07af8473..f1076175e2b3 100644
--- a/Makefile
+++ b/Makefile
@@ -298,19 +298,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
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
index d9d00319b07c..bcb69380bbab 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,9 +32,6 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
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
index 663e11e85727..d515dabc6b0d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_FILES += udpgso udpgso_bench_tx udpgso_bench_rx
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
 TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict
 
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
index fdefa2295ddc..58759454b1d0 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,10 +25,6 @@ TEST_PROGS := run_vmtests
 
 include ../lib.mk
 
-$(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-
-../../../../usr/include/linux/kernel.h:
-	make -C ../../../.. headers_install
-- 
2.17.1

