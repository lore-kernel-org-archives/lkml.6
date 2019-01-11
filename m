Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19900C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C0221841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217832;
	bh=H7I1KzlHbS3TSSSTpOm3A9n8lh98SU04/kZ8ShtoukA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZuNv9Abjt8r/L3OjGMx2gcJbWxZnMrkqWmiSUW0YtjrGu6eRKvlVf84teRx1rNQmb
	 AGe3j2ypAc7OZMiSH/yJQO9GE+FD2TfKrqsbRrKPnQOT0luM2KgSoKUDaJLmVX47go
	 cQ/S8BRC/6Wn58qdOIxesePUBl5cDZrKho8rDZd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404486AbfAKOnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404472AbfAKOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82E02184A;
        Fri, 11 Jan 2019 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217828;
        bh=H7I1KzlHbS3TSSSTpOm3A9n8lh98SU04/kZ8ShtoukA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ybE9N6hrQ3KSf+8aOxohD/buqHujlkc3LGetAFBoSpBOQoOBMjfcowMmng4QFyMP4
         KmTOiFmdIVSXP8IH8XIBvq57bwBcd0nkiw3WigXDZ7JeA5pzzTkhRd8A+g39HYlNOV
         XMvKJ2UsqQ5MFQA+ISJXpaAKh71UQ8RMfD11yoqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 4.20 56/65] selftests: Fix test errors related to lib.mk khdr target
Date:   Fri, 11 Jan 2019 15:15:42 +0100
Message-Id: <20190111131103.681306220@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuah@kernel.org>

commit 211929fd3f7c8de4d541b1cc243b82830e5ea1e8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/android/Makefile                 |    2 +-
 tools/testing/selftests/futex/functional/Makefile        |    1 +
 tools/testing/selftests/gpio/Makefile                    |    6 +++---
 tools/testing/selftests/kvm/Makefile                     |    2 +-
 tools/testing/selftests/lib.mk                           |    8 ++++----
 tools/testing/selftests/networking/timestamping/Makefile |    1 +
 tools/testing/selftests/tc-testing/bpf/Makefile          |    1 +
 tools/testing/selftests/vm/Makefile                      |    1 +
 8 files changed, 13 insertions(+), 9 deletions(-)

--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -6,7 +6,7 @@ TEST_PROGS := run.sh
 
 include ../lib.mk
 
-all: khdr
+all:
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -19,6 +19,7 @@ TEST_GEN_FILES := \
 TEST_PROGS := run.sh
 
 top_srcdir = ../../../../..
+KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
 
 $(TEST_GEN_FILES): $(HEADERS)
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -10,8 +10,6 @@ TEST_PROGS_EXTENDED := gpio-mockup-chard
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
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -16,18 +16,18 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)
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
--- a/tools/testing/selftests/networking/timestamping/Makefile
+++ b/tools/testing/selftests/networking/timestamping/Makefile
@@ -6,6 +6,7 @@ TEST_PROGS := hwtstamp_config rxtimestam
 all: $(TEST_PROGS)
 
 top_srcdir = ../../../../..
+KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
 
 clean:
--- a/tools/testing/selftests/tc-testing/bpf/Makefile
+++ b/tools/testing/selftests/tc-testing/bpf/Makefile
@@ -4,6 +4,7 @@ APIDIR := ../../../../include/uapi
 TEST_GEN_FILES = action.o
 
 top_srcdir = ../../../../..
+KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
 
 CLANG ?= clang
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,6 +25,7 @@ TEST_GEN_FILES += virtual_address_range
 
 TEST_PROGS := run_vmtests
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread


