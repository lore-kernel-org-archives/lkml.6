Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F679C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EC6218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EC6218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeHQMvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbeHQMvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 137894001389;
        Fri, 17 Aug 2018 09:48:16 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F1831745B;
        Fri, 17 Aug 2018 09:48:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 00/13] perf tools: Use plain debug files for compressed objects
Date:   Fri, 17 Aug 2018 11:48:00 +0200
Message-Id: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 09:48:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 09:48:16 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
currently we don't allow to open plain debug files for
compressed kernel module objects, ending up with following
warning:

  $ perf report --stdio
  lzma: failed The input is not in the .xz format
  lzma: failed The input is not in the .xz format
  lzma: failed The input is not in the .xz format
  lzma: failed The input is not in the .xz format
  # To display the perf.data header info, please use --header/--header-only options.

The reason is behind the logic we open the DSO object files,
when we try all possible 'debug' objects until we find the
data. So even if the DSO is represented by 'krava.xz' module,
we can end up opening ~/.debug/....23432432/debug' file which
is not compressed and we fail with above error.

This patchset adds the code to detect un/compressed files and
return plain debug file when available even for compressed
kernel modules.

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (13):
      perf tools: Get rid of dso__needs_decompress call in read_object_code
      perf tools: Get rid of dso__needs_decompress call in symbol__disassemble
      perf tools: Get rid of dso__needs_decompress call in __open_dso
      perf tools: Make decompress_to_file function static
      perf tools: Make is_supported_compression function static
      perf tools: Add compression id into struct kmod_path
      perf tools: Store compression id into struct dso
      perf tools: Use compression id in decompress_kmodule function
      perf tools: Move the temp file processing into decompress_kmodule
      perf tools: Add is_compressed callback to compressions array
      perf tools: Add lzma_is_compressed function
      perf tools: Add gzip_is_compressed function
      perf tools: Remove ext from struct kmod_path

 tools/perf/tests/code-reading.c |   4 +++-
 tools/perf/tests/kmod-path.c    | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------
 tools/perf/util/annotate.c      |   4 +++-
 tools/perf/util/compress.h      |   2 ++
 tools/perf/util/dso.c           | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------
 tools/perf/util/dso.h           |  13 +++++--------
 tools/perf/util/lzma.c          |  20 +++++++++++++++++++
 tools/perf/util/machine.c       |   4 +++-
 tools/perf/util/zlib.c          |  18 +++++++++++++++++
 9 files changed, 172 insertions(+), 140 deletions(-)
