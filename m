Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2FEC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67B62082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547603966;
	bh=vBgPCck2SWWf2qKiOlYSsPHcwPfWb+9+STBIm3oxeyY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DuRgbwlp4cbbf0jwl+dzDuQ6pqulWzmLndPT/AuR5IY9Ml6wxB4STxmSIJhBR44iC
	 qKjmRHzM7MJjhU8MV2obcoDGtAC2qyfW92zR9L9ESxVfeOiuvO1Zbfs7jV+lKdNbAF
	 alCVwH3uGzVN/z47JyLtWD9kGMubjPGvt8m+W93U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfAPB7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfAPB7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:59:25 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FEBA2082F;
        Wed, 16 Jan 2019 01:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547603963;
        bh=vBgPCck2SWWf2qKiOlYSsPHcwPfWb+9+STBIm3oxeyY=;
        h=From:To:Cc:Subject:Date:From;
        b=XmqO1pmJwav1X85NiGekbhSGaD3VaIL1H+lerpxuHDom8wjXRQ3Tvc5VqBK46KhmE
         V4sIsI/PUAAm/f7P1Bvgg6tiz4j1Wfi0SpTugyxem2GpHaxKV303MF7b+I/idzGE7C
         LY+KTErEoj2ccMDyPk/YR2jiVON1paJsi3B+8pfk=
From:   shuah@kernel.org
To:     gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     anders.roxell@linaro.org, khalid.aziz@oracle.com,
        stable@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH backport for 4.19] selftests: Fix test errors related to lib.mk khdr target
Date:   Tue, 15 Jan 2019 18:59:21 -0700
Message-Id: <20190116015922.17979-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

Upstream commit 211929fd3f7c ("selftests: Fix test errors related to
lib.mk khdr target")

This backport drops change to test that isn't in 4.19
- tools/testing/selftests/tc-testing/bpf/Makefile

The rest of the changes applied with minor changes to
- tools/testing/selftests/gpio/Makefile
- tools/testing/selftests/kvm/Makefile

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
Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/android/Makefile                 | 2 +-
 tools/testing/selftests/futex/functional/Makefile        | 1 +
 tools/testing/selftests/gpio/Makefile                    | 1 +
 tools/testing/selftests/kvm/Makefile                     | 2 +-
 tools/testing/selftests/lib.mk                           | 8 ++++----
 tools/testing/selftests/networking/timestamping/Makefile | 1 +
 tools/testing/selftests/vm/Makefile                      | 1 +
 7 files changed, 10 insertions(+), 6 deletions(-)

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
index 4665cdbf1a8d..59ea4c461978 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -9,6 +9,7 @@ EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
 EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
 EXTRA_OBJS += ../gpiolsgpio.o
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 all: $(BINARIES)
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ec32dad3c3f0..cc83e2fd3787 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -1,6 +1,7 @@
 all:
 
 top_srcdir = ../../../../
+KSFT_KHDR_INSTALL := 1
 UNAME_M := $(shell uname -m)
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c
@@ -40,4 +41,3 @@ $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 
 all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
-$(STATIC_LIBS):| khdr
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
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index e94b7b14bcb2..dc68340a6a96 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -24,6 +24,7 @@ TEST_GEN_FILES += virtual_address_range
 
 TEST_PROGS := run_vmtests
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
-- 
2.17.1

