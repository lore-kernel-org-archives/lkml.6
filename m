Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D46C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C3D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmAzlxcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C3D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbeHAXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732697AbeHAXZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:54 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9932208B1;
        Wed,  1 Aug 2018 21:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159487;
        bh=GB7MmpxZbHTLD28vQzFbCXoq7ntYsdJ5WBCX6ZX1pRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmAzlxcWoII24LOFqV/qqSWGfEMdLXunzc5GwR4DvYd8N9bGaNcZ0nnXro266fZc1
         GhphY5f5IgGkY06cC1iMKYvvsz+D9E+chXcMY+Ajxlab/PraG7HSnwnjPKd0tdhH5r
         vpL5pIPO4i6cwTzR/dBYOpP/55Ne+FJgLjCx/4ak=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 20/21] perf bpf: Include uapi/linux/bpf.h from the 'perf trace' script's bpf.h
Date:   Wed,  1 Aug 2018 18:36:47 -0300
Message-Id: <20180801213648.4814-21-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

