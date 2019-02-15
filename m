Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8556420840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198022;
	bh=mOBP+9rPnX0dhUGx4qlf39uMWjz/4et0MCUUEMNWhVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oEOqcTqOT73jXEBkDBY/8GUcfF5b8YgTPOnn7eNp6hC4RdjnTNIycpaZhj6gz1bPz
	 iAHmN0TmwVRWLatYp4y+IokLAOGGkgLOT1VRVzR9mhXEExrXFJlVtX9Opj3SUj7Zmv
	 M4mlSY4RLxACpb8tHneQIzdr0FCQLFZ8Vdc5BHA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbfBOCd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387621AbfBOCL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF9C21B1C;
        Fri, 15 Feb 2019 02:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196716;
        bh=mOBP+9rPnX0dhUGx4qlf39uMWjz/4et0MCUUEMNWhVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QKU5RNwndcYiridJsan6WFquZ9drKL+RVBjxRuoZCWnP44OlVDrL4RCBHBcAjm6h
         Jp2aY1aTiuEUt7KR+jZKokv23R1S65xqRgrK3WFPmP5q32ajxgjdXWLcME+za6oebG
         dsnMx7knjZgW1wbbs7a9AtLvnSCYnQ4am8yEWvC4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/65] selftests: seccomp: use LDLIBS instead of LDFLAGS
Date:   Thu, 14 Feb 2019 21:10:38 -0500
Message-Id: <20190215021121.177674-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fathi Boudra <fathi.boudra@linaro.org>

[ Upstream commit 5bbc73a841d7f0bbe025a342146dde462a796a5a ]

seccomp_bpf fails to build due to undefined reference errors:

 aarch64-linaro-linux-gcc --sysroot=/build/tmp-rpb-glibc/sysroots/hikey
 -O2 -pipe -g -feliminate-unused-debug-types -Wl,-no-as-needed -Wall
 -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -lpthread seccomp_bpf.c -o
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf
 /tmp/ccrlR3MW.o: In function `tsync_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1920: undefined reference to `sem_post'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1920: undefined reference to `sem_post'
 /tmp/ccrlR3MW.o: In function `TSYNC_setup':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1863: undefined reference to `sem_init'
 /tmp/ccrlR3MW.o: In function `TSYNC_teardown':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1904: undefined reference to `sem_destroy'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1897: undefined reference to `pthread_kill'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1898: undefined reference to `pthread_cancel'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1899: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_siblings_fail_prctl':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1978: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1990: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1992: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_ancestor':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2016: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2032: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2034: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_sibling_want_nnp':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2046: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2058: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2060: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_no_filter':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2073: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2098: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2100: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_one_divergence':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2125: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2143: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2145: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_not_under_filter':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2169: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2202: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2227: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'

It's GNU Make and linker specific.

The default Makefile rule looks like:

$(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)

When linking is done by gcc itself, no issue, but when it needs to be passed
to proper ld, only LDLIBS follows and then ld cannot know what libs to link
with.

More detail:
https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

LDFLAGS
Extra flags to give to compilers when they are supposed to invoke the linker,
‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
instead.

LDLIBS
Library flags or names given to compilers when they are supposed to invoke the
linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
variable.

https://lkml.org/lkml/2010/2/10/362

tools/perf: libraries must come after objects

Link order matters, use LDLIBS instead of LDFLAGS to properly link against
libpthread.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/seccomp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index fce7f4ce0692..1760b3e39730 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -9,7 +9,7 @@ BINARIES := seccomp_bpf seccomp_benchmark
 CFLAGS += -Wl,-no-as-needed -Wall
 
 seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) -lpthread $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
 
 TEST_PROGS += $(BINARIES)
 EXTRA_CLEAN := $(BINARIES)
-- 
2.19.1

