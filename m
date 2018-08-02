Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F86C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F652145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F652145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeHBKHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:07:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41627 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHBKHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:07:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728HLVt3431799
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:17:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728HLPM3431796;
        Thu, 2 Aug 2018 01:17:21 -0700
Date:   Thu, 2 Aug 2018 01:17:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zd8zeyhr2sappevojdem9xxt@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
        wangnan0@huawei.com, adrian.hunter@intel.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, mingo@kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          wangnan0@huawei.com, tglx@linutronix.de, namhyung@kernel.org,
          dsahern@gmail.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Include uapi/linux/bpf.h from the 'perf
 trace' script's bpf.h
Git-Commit-ID: 822c2621daadcf9e8fa8f11f7334e3c349434154
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

Commit-ID:  822c2621daadcf9e8fa8f11f7334e3c349434154
Gitweb:     https://git.kernel.org/tip/822c2621daadcf9e8fa8f11f7334e3c349434154
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 1 Aug 2018 10:50:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 1 Aug 2018 12:34:06 -0300

perf bpf: Include uapi/linux/bpf.h from the 'perf trace' script's bpf.h

The next example scripts need the definition for the BPF functions, i.e.
things like BPF_FUNC_probe_read, and in time will require lots of other
definitions found in uapi/linux/bpf.h, so include it from the bpf.h file
included from the eBPF scripts build with clang via '-e bpf_script.c'
like in this example:

  $ tail -8 tools/perf/examples/bpf/5sec.c
  #include <bpf.h>

  int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
  {
	return sec == 5;
  }

  license(GPL);
  $

That 'bpf.h' include in the 5sec.c eBPF example will come from a set of
header files crafted for building eBPF objects, that in a end-user
system will come from:

  /usr/lib/perf/include/bpf/bpf.h

And will include <uapi/linux/bpf.h> either from the place where the
kernel was built, or from a kernel-devel rpm package like:

  -working-directory /lib/modules/4.17.9-100.fc27.x86_64/build

That is set up by tools/perf/util/llvm-utils.c, and can be overriden
by setting the 'kbuild-dir' variable in the "llvm" ~/.perfconfig file,
like:

  # cat ~/.perfconfig
  [llvm]
       kbuild-dir = /home/foo/git/build/linux

This usually doesn't need any change, just documenting here my findings
while working with this code.

In the future we may want to instead just use what is in
/usr/include/linux/bpf.h, that comes from the UAPI provided from the
kernel sources, for now, to avoid getting the kernel's non-UAPI
"linux/bpf.h" file, that will cause clang to fail and is not what we
want anyway (no BPF function definitions, etc), do it explicitely by
asking for "uapi/linux/bpf.h".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zd8zeyhr2sappevojdem9xxt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index dd764ad5efdf..a63aa6241b7f 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #ifndef _PERF_BPF_H
 #define _PERF_BPF_H
+
+#include <uapi/linux/bpf.h>
+
 #define SEC(NAME) __attribute__((section(NAME),  used))
 
 #define probe(function, vars) \
