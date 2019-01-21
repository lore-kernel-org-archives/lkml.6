Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A507AC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1402089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079426;
	bh=VPpAhCxGX90of8jVznp/8DSpURmWpfXY8+vkfq3wHsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M1OyvkYda0J9J6FnS/oEVTHvIjtzZhBgCqSbruYxdQvl5W+jQ0KQ/BC2wCoeKdVjc
	 NkdNq002aBGmSHUcV7qHUrixBI+k12i6wS5hkuk6NhilfI9o0TPOdjrOcdOjBAZyKM
	 wj1zj/RSIiyDFrbQMdeSLV15e8zrJPq3rtJ5K4+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbfAUOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732864AbfAUOCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 612A22089F;
        Mon, 21 Jan 2019 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079364;
        bh=VPpAhCxGX90of8jVznp/8DSpURmWpfXY8+vkfq3wHsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7OC6cpa7QJnkSvsbiOlDiP83h0At+Yt0f8IiChe579TU/UNaIbavYECa4EvkIO1s
         opgFnVZNSNc82fiL24y8iKUVwVag65NqjpJJAtJzc0SGiVUvXI1THjP2+U7QvVXsUu
         F7YHdpKiVGWZ1MeA3O2sxjaNj/eDYug0oUrjSfRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 4.19 99/99] selftests: Fix test errors related to lib.mk khdr target
Date:   Mon, 21 Jan 2019 14:49:31 +0100
Message-Id: <20190121134920.082952532@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 tools/testing/selftests/gpio/Makefile                    |    1 +
 tools/testing/selftests/kvm/Makefile                     |    2 +-
 tools/testing/selftests/lib.mk                           |    8 ++++----
 tools/testing/selftests/networking/timestamping/Makefile |    1 +
 tools/testing/selftests/vm/Makefile                      |    1 +
 7 files changed, 10 insertions(+), 6 deletions(-)

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
@@ -9,6 +9,7 @@ EXTRA_OBJS := ../gpiogpio-event-mon-in.o
 EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
 EXTRA_OBJS += ../gpiolsgpio.o
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 all: $(BINARIES)
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
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -24,6 +24,7 @@ TEST_GEN_FILES += virtual_address_range
 
 TEST_PROGS := run_vmtests
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread


