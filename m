Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2818C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED4520873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfANNwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:52:06 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:59238 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfANNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:51:49 -0500
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id QDrm1z00M3XaVaC01DrmHY; Mon, 14 Jan 2019 14:51:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gj2eY-0000F5-8y; Mon, 14 Jan 2019 14:51:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gj2eY-0006oU-7c; Mon, 14 Jan 2019 14:51:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 12/12] selftests: gpio: Fix building tools/gpio from kselftests
Date:   Mon, 14 Jan 2019 14:51:44 +0100
Message-Id: <20190114135144.26096-13-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114135144.26096-1-geert+renesas@glider.be>
References: <20190114135144.26096-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running "make kselftests":

    make[3]: Entering directory 'tools/gpio'
    Makefile:24: tools/build/Makefile.include: No such file or directory
    make[3]: *** No rule to make target 'tools/build/Makefile.include'.  Stop.

When building kselftest in a separate output directory, the gpio tools
are still built in the source directory.

Fix this by passing the correct source and build paths to the make
subprocess.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Marked RFC as there are still issues with this approach:

  - "make kselftest O=" needs:

	all: $(TEST_PROGS_EXTENDED)

    "make kselftest" needs that line to be replaced by:

	TEST_GEN_PROGS_EXTENDED := $(TEST_PROGS_EXTENDED)

    Having both lines doesn't help.

  - gpio-mockup-chardev is no longer built.
---
 tools/testing/selftests/gpio/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 0bb80619db580af1..1eb4304fcfcbad67 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -13,20 +13,22 @@ TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_PROGS_EXTENDED := gpio-mockup-chardev
 
-GPIODIR := $(realpath ../../../gpio)
+GPIOSRCDIR := $(abspath $(CURDIR)/../../../gpio)
+GPIOOBJDIR := $(abspath $(OUTPUT)/../../../gpio)
 GPIOOBJ := gpio-utils.o
 
 all: $(TEST_PROGS_EXTENDED)
 
 override define CLEAN
 	$(RM) $(TEST_PROGS_EXTENDED)
-	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
+	$(MAKE) -C $(GPIOSRCDIR) OUTPUT=$(GPIOOBJDIR)/ clean
 endef
 
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
-$(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
+$(TEST_PROGS_EXTENDED): $(GPIOOBJDIR)/$(GPIOOBJ)
 
-$(GPIODIR)/$(GPIOOBJ):
-	$(MAKE) OUTPUT=$(GPIODIR)/ -C $(GPIODIR)
+$(GPIOOBJDIR)/$(GPIOOBJ):
+	mkdir -p $(GPIOOBJDIR)
+	$(MAKE) OUTPUT=$(GPIOOBJDIR)/ -C $(GPIOSRCDIR)
-- 
2.17.1

