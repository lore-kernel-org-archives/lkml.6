Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17FBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08D620657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfANNvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:51:48 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:57698 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbfANNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:51:48 -0500
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id QDrm1z00D3XaVaC01DrmWv; Mon, 14 Jan 2019 14:51:46 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gj2eY-0000En-3I; Mon, 14 Jan 2019 14:51:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gj2eY-0006oC-2H; Mon, 14 Jan 2019 14:51:46 +0100
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
Subject: [PATCH 07/12] selftests: memfd: Fix build with O=
Date:   Mon, 14 Jan 2019 14:51:39 +0100
Message-Id: <20190114135144.26096-8-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114135144.26096-1-geert+renesas@glider.be>
References: <20190114135144.26096-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kselftest in a separate output directory:

    make[3]: *** No rule to make target 'common.o', needed by '/tmp/kselftest/memfd/memfd_test'.  Stop.

Fix this by explicitly listing common.o (in the output tree) in the
build targets (allowing the EXTRA_CLEAN rule to be dropped), and
updating the dependencies of the final executables.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/testing/selftests/memfd/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 53a848109f7bbbd0..f3e988e54ec81083 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -6,7 +6,7 @@ CFLAGS += -I../../../../usr/include/
 
 TEST_GEN_PROGS := memfd_test
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
-TEST_GEN_FILES := fuse_mnt fuse_test
+TEST_GEN_FILES := fuse_mnt fuse_test common.o
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
@@ -14,7 +14,5 @@ include ../lib.mk
 
 $(OUTPUT)/fuse_mnt: LDLIBS += $(shell pkg-config fuse --libs)
 
-$(OUTPUT)/memfd_test: memfd_test.c common.o
-$(OUTPUT)/fuse_test: fuse_test.c common.o
-
-EXTRA_CLEAN = common.o
+$(OUTPUT)/memfd_test: memfd_test.c $(OUTPUT)/common.o
+$(OUTPUT)/fuse_test: fuse_test.c $(OUTPUT)/common.o
-- 
2.17.1

