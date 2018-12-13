Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6543C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544731217;
	bh=L2B6NsvYG8sR66Scc6ehr8zjSFOj3gfamMjeWNmBDp4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cBFM6u3V28wNHfR4OVJgYl7HplAihjt+lbTwo6xzC3GRoYrd31iO/XTD9BsNm9333
	 BVyxXScnJVfe9LiuZLRY61mNDipuS3lCz4nrl+RMTk+JmGyOeOspFqN9IvK+eJMviJ
	 mXE2F5zj1DE7kgoU9FGGSvaZNOUZaDFzfa0QrIuA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6543C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeLMUAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbeLMUAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:00:16 -0500
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E88120811;
        Thu, 13 Dec 2018 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544731214;
        bh=L2B6NsvYG8sR66Scc6ehr8zjSFOj3gfamMjeWNmBDp4=;
        h=From:To:Cc:Subject:Date:From;
        b=Bug4bD42Be22Jea46Qiuc1hLDCqZ4r6vmzPgHbNKhw2885lW48DcafmeDgDioC6xl
         6gIUcyT9psBX4VgXdpdAX5LPzLQ6KHqRoDZNKd/ea8xisQKWepKS///nJEHp0T20IP
         BeNHjF3bcwzFbO0qXag+qQpZ2otse/5Mhw9jqakc=
From:   shuah@kernel.org
To:     shuah@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org, bamv2005@gmail.com,
        brgl@bgdev.pl, fathi.boudra@linaro.org, anders.roxell@linaro.org,
        daniel.diaz@linaro.org, pintu.ping@gmail.com, pbonzini@redhat.com,
        drjones@redhat.com, hofsass@google.com, peterx@redhat.com,
        peng.hao2@zte.com.cn, wei@redhat.com, davem@davemloft.net,
        dcaratti@redhat.com, akpm@linux-foundation.org, mhocko@suse.com,
        khalid.aziz@oracle.com, mpe@ellerman.id.au,
        aneesh.kumar@linux.vnet.ibm.com, dima@arista.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] selftests: Fix test errors related to lib.mk khdr target
Date:   Thu, 13 Dec 2018 13:00:11 -0700
Message-Id: <20181213200011.10779-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

Commit b2d35fa5fc80 ("selftests: add headers_install to lib.mk") added
khdr target to run headers_install target from the main Makefile. The
logic uses KSFT_KHDR_INSTALL and top_srcdir as controls to initialize
variables and include files to run headers_install from the top level
Makefile. There are a few problems with this logic.

1. Exposes top_srcdir to all tests
2. Common logic impacts all tests
3. Uses KSFT_KHDR_INSTALL, top_srcdir, and khdr in an adhoc way. Tests
   add "khdr" dependency in their Makefiles to TEST_PROGS_EXTENDED in
   some cases, and STATIC_LIBS in other cases. This makes this framework
   confusing to use.

The common logic that runs for all tests even when KSFT_KHDR_INSTALL
isn't defined by the test. top_srcdir is initialized to a default value
when test doesn't initialize it. It works for all tests without a sub-dir
structure and tests with sub-dir structure fail to build.

e.g: make -C sparc64/drivers/ or make -C drivers/dma-buf

../../lib.mk:20: ../../../../scripts/subarch.include: No such file or directory
make: *** No rule to make target '../../../../scripts/subarch.include'.  Stop.

There is no reason to require all tests to define top_srcdir and there is
no need to require tests to add khdr dependency using adhoc changes to
TEST_* and other variables.

Fix it with a consistent use of KSFT_KHDR_INSTALL and top_srcdir from tests
that have the dependency on headers_install.

Change common logic to include khdr target define and "all" target with
dependency on khdr when KSFT_KHDR_INSTALL is defined.

Only tests that have dependency on headers_install have to define just
the KSFT_KHDR_INSTALL, and top_srcdir variables and there is no need to
specify khdr dependency in the test Makefiles.

Fixes: b2d35fa5fc80 ("selftests: add headers_install to lib.mk")
Cc: stable@vger.kernel.org
Signed-off-by: Shuah Khan <shuah@kernel.org>

---
 tools/testing/selftests/android/Makefile                 | 2 +-
 tools/testing/selftests/futex/functional/Makefile        | 1 +
 tools/testing/selftests/gpio/Makefile                    | 6 +++---
 tools/testing/selftests/kvm/Makefile                     | 2 +-
 tools/testing/selftests/lib.mk                           | 8 ++++----
 tools/testing/selftests/networking/timestamping/Makefile | 1 +
 tools/testing/selftests/tc-testing/bpf/Makefile          | 1 +
 tools/testing/selftests/vm/Makefile                      | 1 +
 8 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index d9a725478375..72c25a3cb658 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -6,7 +6,7 @@ TEST_PROGS := run.sh
 
 include ../lib.mk
 
-all: khdr
+all:
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index ad1eeb14fda7..30996306cabc 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -19,6 +19,7 @@ TEST_GEN_FILES := \
 TEST_PROGS := run.sh
 
 top_srcdir = ../../../../..
+KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
 
 $(TEST_GEN_FILES): $(HEADERS)
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 46648427d537..07f572a1bd3f 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -10,8 +10,6 @@ TEST_PROGS_EXTENDED := gpio-mockup-chardev
 GPIODIR := $(realpath ../../../gpio)
 GPIOOBJ := gpio-utils.o
 
-include ../lib.mk
-
 all: $(TEST_PROGS_EXTENDED)
 
 override define CLEAN
@@ -19,7 +17,9 @@ override define CLEAN
 	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
 endef
 
-$(TEST_PROGS_EXTENDED):| khdr
+KSFT_KHDR_INSTALL := 1
+include ../lib.mk
+
 $(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
 
 $(GPIODIR)/$(GPIOOBJ):
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 01a219229238..52bfe5e76907 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -1,6 +1,7 @@
 all:
 
 top_srcdir = ../../../..
+KSFT_KHDR_INSTALL := 1
 UNAME_M := $(shell uname -m)
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/ucall.c lib/sparsebit.c
@@ -44,7 +45,6 @@ $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 
 all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
-$(STATIC_LIBS):| khdr
 
 cscope: include_paths = $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include lib ..
 cscope:
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 0a8e75886224..8b0f16409ed7 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -16,18 +16,18 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+ifdef KSFT_KHDR_INSTALL
 top_srcdir ?= ../../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH		?= $(SUBARCH)
 
-all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
-
 .PHONY: khdr
 khdr:
 	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
 
-ifdef KSFT_KHDR_INSTALL
-$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES):| khdr
+all: khdr $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
+else
+all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 endif
 
 .ONESHELL:
diff --git a/tools/testing/selftests/networking/timestamping/Makefile b/tools/testing/selftests/networking/timestamping/Makefile
index 14cfcf006936..c46c0eefab9e 100644
--- a/tools/testing/selftests/networking/timestamping/Makefile
+++ b/tools/testing/selftests/networking/timestamping/Makefile
@@ -6,6 +6,7 @@ TEST_PROGS := hwtstamp_config rxtimestamp timestamping txtimestamp
 all: $(TEST_PROGS)
 
 top_srcdir = ../../../../..
+KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
 
 clean:
diff --git a/tools/testing/selftests/tc-testing/bpf/Makefile b/tools/testing/selftests/tc-testing/bpf/Makefile
index dc92eb271d9a..be5a5e542804 100644
--- a/tools/testing/selftests/tc-testing/bpf/Makefile
+++ b/tools/testing/selftests/tc-testing/bpf/Makefile
@@ -4,6 +4,7 @@ APIDIR := ../../../../include/uapi
 TEST_GEN_FILES = action.o
 
 top_srcdir = ../../../../..
+KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
 
 CLANG ?= clang
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 6e67e726e5a5..e13eb6cc8901 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,6 +25,7 @@ TEST_GEN_FILES += virtual_address_range
 
 TEST_PROGS := run_vmtests
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
-- 
2.17.1

