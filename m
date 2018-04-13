Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+HzgZo0UQWs/U1RflQFcYU9wkcCHWTQ8/DRGKfN+q+5aieA8X5+0XZQ+v+wnfEOxO+Qegi
ARC-Seal: i=1; a=rsa-sha256; t=1523610241; cv=none;
        d=google.com; s=arc-20160816;
        b=NqAxzUANstzRskhAeQ4DyTZ9zvTD0bwjZVl6Ec7ntzFihQ4XqVkZReXGFT+XQhGb2z
         d/rdj5hK9x2ZI5mMYy4h9Rd0i19m9L6CgTiHUA7TG73dWZ61shzMJmdsJ+z8vaE867E9
         CVUeuJ7kDiqHDvf1ergdLV3y9z3EXBL3vqdCJg18OK7YyRaOEMMk9KV2lhJ6Ru8Pnl/Z
         LrzjM6ktKOgeq4OdpgzzNMAAhZlFOqg1H95Qk7TXj3hnOaXQ20tboE/5iyDJSbYil4ig
         R2/crZVATjxQP+jyhergpLGGclOxBI535XF9cIRnNxKxgncdVzG2/mgi8RrVkxO9NIk5
         RFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=z0ByjDKZNoymk8XuXcJm4KXoJHEHyCW9YqjWJtuyoME=;
        b=KsiNiQLZXCjeQqbwkMry4exs1UHTHumCg1cWMEJZEPIYwNYZoBpYZl1itR6leG6FX1
         2soDbAxHU6BE5UPajRX26Cpa41QN8rd0Ypwi7c6EeNjFwP7mRR/4IqjUWQM/S6bY8EXE
         yRoQJ0MToeB3fXOTCqJrOkrr9H+wIL7SyIJGsYelr0XxhybIoSuYKL+RYsVNx57gsCwy
         aJR7L9Ot4LoXaE2PwbOjl1xv8hnjj73uJP9A2R+JHw5H9GfUct3qzSqovLhPHMPv0vRi
         HY5Lf2XGIJYkK3M933bjEdBWrlRpKqBzf0NcLo/5FrXW4ELX5weJ1q4bIaBN95bPnBd6
         zu0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=Knrwr7w3;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=Knrwr7w3;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeDMJEB (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 13 Apr 2018 05:04:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43619 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753644AbeDMJD6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Apr 2018 05:03:58 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net
Cc: linux-kselftest@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, fathi.boudra@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: add headers_install to lib.mk
Date: Fri, 13 Apr 2018 11:03:51 +0200
Message-Id: <20180413090351.25662-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180412102302.4532-1-anders.roxell@linaro.org>
References: <20180412102302.4532-1-anders.roxell@linaro.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597535540200601816?=
X-GMAIL-MSGID: =?utf-8?q?1597621133028313451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the kernel headers aren't installed we can't build all the tests.
Add a new make target rule 'khdr' in the file lib.mk to generate the
kernel headers and that gets include for every test-dir Makefile that
includes lib.mk If the testdir in turn have its own sub-dirs the
top_srcdir needs to be set to the linux-rootdir to be able to generate
the kernel headers.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 Makefile                                          | 14 +-------------
 scripts/subarch.include                           | 13 +++++++++++++
 tools/testing/selftests/android/Makefile          |  2 +-
 tools/testing/selftests/android/ion/Makefile      |  1 +
 tools/testing/selftests/bpf/Makefile              |  5 ++---
 tools/testing/selftests/futex/functional/Makefile |  1 +
 tools/testing/selftests/gpio/Makefile             |  4 ----
 tools/testing/selftests/kvm/Makefile              |  6 +-----
 tools/testing/selftests/lib.mk                    | 10 ++++++++++
 tools/testing/selftests/vm/Makefile               |  3 ---
 10 files changed, 30 insertions(+), 29 deletions(-)
 create mode 100644 scripts/subarch.include

diff --git a/Makefile b/Makefile
index 74567b0ec2f0..0c47935d48a2 100644
--- a/Makefile
+++ b/Makefile
@@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
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
index f6304d2be90c..087390bbad68 100644
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
index e03695287f76..14ecd9805748 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -11,6 +11,7 @@ $(TEST_GEN_FILES): ipcsocket.c ionutils.c
 TEST_PROGS := ion_test.sh
 
 include ../../lib.mk
+top_srcdir = ../../../../../
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
 $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0a315ddabbf4..cc611a284087 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -16,9 +16,8 @@ LDLIBS += -lcap -lelf -lrt -lpthread
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 all: $(TEST_CUSTOM_PROGS)
 
-$(TEST_CUSTOM_PROGS): urandom_read
-
-urandom_read: urandom_read.c
+$(TEST_CUSTOM_PROGS):| khdr
+$(TEST_CUSTOM_PROGS): urandom_read.c
 	$(CC) -o $(TEST_CUSTOM_PROGS) -static $<
 
 # Order correspond to 'make run_tests' order
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index ff8feca49746..9f602fb40241 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -19,5 +19,6 @@ TEST_GEN_FILES := \
 TEST_PROGS := run.sh
 
 include ../../lib.mk
+top_srcdir = ../../../../../
 
 $(TEST_GEN_FILES): $(HEADERS)
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb47565c55..768b2be010db 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -25,7 +25,3 @@ $(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
 
 ../../../gpio/gpio-utils.o:
 	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
-
-../../../../usr/include/linux/gpio.h:
-	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
-
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index dc44de904797..ba03ce334212 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -31,9 +31,5 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
 $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 	$(AR) crs $@ $^
 
-$(LINUX_HDR_PATH):
-	make -C $(top_srcdir) headers_install
-
-all: $(STATIC_LIBS) $(LINUX_HDR_PATH)
+all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
-$(TEST_GEN_PROGS) $(LIBKVM_OBJ): | $(LINUX_HDR_PATH)
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 195e9d4739a9..1b1e8135715e 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -16,8 +16,18 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+top_srcdir ?= ../../../../
+include $(top_srcdir)/scripts/subarch.include
+ARCH		?= $(SUBARCH)
+
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
+.PHONY: khdr
+khdr:
+	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
+
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES):| khdr
+
 .ONESHELL:
 define RUN_TESTS
 	@export KSFT_TAP_LEVEL=`echo 1`;
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index fdefa2295ddc..1e34a40745ef 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -29,6 +29,3 @@ $(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-
-../../../../usr/include/linux/kernel.h:
-	make -C ../../../.. headers_install
-- 
2.16.3

