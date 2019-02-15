Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F84C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE326222EC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404656AbfBOJjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:39:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391708AbfBOJjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:39:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9clG31117957
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:38:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9clwa1117953;
        Fri, 15 Feb 2019 01:38:47 -0800
Date:   Fri, 15 Feb 2019 01:38:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-rexc248jorf5b4l3qjn888cz@git.kernel.org>
Cc:     eranian@google.com, acme@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, sukadev@linux.vnet.ibm.com,
        sonnyrao@chromium.org, johnmccutchan@google.com, cel@us.ibm.com,
        jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, pawel.moll@arm.com, ak@linux.intel.com
Reply-To: acme@redhat.com, namhyung@kernel.org, eranian@google.com,
          sukadev@linux.vnet.ibm.com, sonnyrao@chromium.org, hpa@zytor.com,
          johnmccutchan@google.com, cel@us.ibm.com,
          adrian.hunter@intel.com, mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, dsahern@gmail.com, ak@linux.intel.com,
          pawel.moll@arm.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build: Add missing
 FEATURE_CHECK_LDFLAGS-libcrypto
Git-Commit-ID: 271402a3e97e3b9a4ce1e322a5f66c493122e1ec
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  271402a3e97e3b9a4ce1e322a5f66c493122e1ec
Gitweb:     https://git.kernel.org/tip/271402a3e97e3b9a4ce1e322a5f66c493122e1ec
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 12 Feb 2019 16:19:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:05 -0300

perf build: Add missing FEATURE_CHECK_LDFLAGS-libcrypto

When the libcrypto feature test was added we forgot to add its
FEATURE_CHECK_LDFLAGS pointing to the library needed to link with the
test-all.bin feature test fast path binary, so even when it was
introduced we got this:

  $ cat /tmp/build/perf/feature/test-all.make.output
  /usr/bin/ld: /tmp/ccjKeJJU.o: in function `main_test_libcrypto':
  /home/acme/git/perf/tools/build/feature/test-libcrypto.c:10: undefined reference to `MD5_Init'
  /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libcrypto.c:11: undefined reference to `MD5_Update'
  /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libcrypto.c:12: undefined reference to `MD5_Final'
  /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libcrypto.c:14: undefined reference to `SHA1'
  collect2: error: ld returned 1 exit status
  $ cat /tmp/build/perf/feature/test-libcrypto.
  test-libcrypto.bin          test-libcrypto.d            test-libcrypto.make.output
  $ cat /tmp/build/perf/feature/test-libcrypto.make.output
  $

Fix it, so that we keep the fast path, which, at this point, will fail
with the unwind-ARCH feature tests, that will be fixed in a followup
patch:

  $ make -C tools/perf O=/tmp/build/perf
  ...                     libcrypto: [ on  ]
   <SNIP>
  $ cat /tmp/build/perf/feature/test-all.make.output
  $ ldd /tmp/build/perf/feature/test-all.bin | grep libcrypto
	libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007f9892805000)
  $
  $ grep libcrypto /tmp/build/perf/FEATURE-DUMP
  feature-libcrypto=1
  $

With the unwind-ARCH tests fixed, we now finally manage to get
test-all.bin built and linked with the features it tests, among them the
ones fixed in this patchkit:

  $ ldd /tmp/build/perf/feature/test-all.bin  | egrep 'unwind|crypto'
	libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007f95cf2b8000)
	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f95cf294000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f95cf278000)
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John McCutchan <johnmccutchan@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sonny Rao <sonnyrao@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: 8ee4646038e4 ("perf build: Add libcrypto feature detection")
Link: https://lkml.kernel.org/n/tip-rexc248jorf5b4l3qjn888cz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4b735042cad7..0f11d5891301 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -114,6 +114,8 @@ FEATURE_CHECK_LDFLAGS-libunwind-aarch64 = -lunwind -lunwind-aarch64
 FEATURE_CHECK_LDFLAGS-libunwind-x86 = -lunwind -llzma -lunwind-x86
 FEATURE_CHECK_LDFLAGS-libunwind-x86_64 = -lunwind -llzma -lunwind-x86_64
 
+FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
+
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
