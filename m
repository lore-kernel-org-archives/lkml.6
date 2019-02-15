Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88D9222DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191647;
	bh=NZFaswzDL7rjHuvtliZrAwpkJyiE1JdqrgUzmcdeZVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KyehHTXVkKj34ZsKnTV+h6vRgojOU0dtdzoG+P+rmW9B6wUnRmC25bBBkrx/cco/9
	 UtDB3d+gGYvzCF4vV7p/vQbtk2NI9NTd4NRvFC6/owic039StEGdrRLKIZQ0LjwZte
	 EidHfuI4FcPNlq1mvG0MdCU7v+tF02k9t72/OELk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbfBOAr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388994AbfBOArY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:24 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481CA222C9;
        Fri, 15 Feb 2019 00:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191644;
        bh=NZFaswzDL7rjHuvtliZrAwpkJyiE1JdqrgUzmcdeZVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rm0+Es1Sb6gC7UXjmUFYFVniGRdmYDkyGaOoNd4Js1cfmFDCCUilV7//SvZUVRhKm
         hajhT89gcqxaRBt6qfiWwP0Q5NlFXNjEsY0BuUNl1bK1/lGgzoBazLpV788oJd1t21
         C/+/MYtksWTuYHd3RcdyP9vn7MmeTmyOIw4i/dVw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Carl Love <cel@us.ibm.com>,
        David Ahern <dsahern@gmail.com>,
        John McCutchan <johnmccutchan@google.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 22/43] perf build: Add missing FEATURE_CHECK_LDFLAGS-libcrypto
Date:   Thu, 14 Feb 2019 21:45:18 -0300
Message-Id: <20190215004539.23571-23-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.19.1

