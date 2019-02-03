Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D97C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5C220823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207825;
	bh=WxWcSlVysT22iLthOTvc1FREblvLSudP7vD3nHgBtjU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y0tsUs6ljmgoeJzjqBGWGv8SddHP1EFw2zWWpWBePhRiLktrdJ1qEsGe1X3Af1Gjm
	 YOZWUndcvFUelgsl8u60ZMEmqXIH3NZcBQ8CXPU59NCgA7iJfKdew+TXDQPwEbYQyN
	 zjbPlA9Blfrw/RZRPc0/tLi3gzNqnc/3Xf+yhH9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfBCPaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:30:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfBCPaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73071D792C;
        Sun,  3 Feb 2019 15:30:22 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5DFA5C23D;
        Sun,  3 Feb 2019 15:30:19 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [RFC/PATCH 00/14] perf record: Add support to store data in directory
Date:   Sun,  3 Feb 2019 16:30:04 +0100
Message-Id: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 03 Feb 2019 15:30:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset adds the --dir option to record command (and all
the other record command that overload cmd_record) that allows
the data to be stored in directory with multiple data files.

It's next step for multiple threads implementation in record.
It's now possible to make directory data via --dir option, like:

  $ perf record --dir perf bench sched messaging
  $ ls -l perf.data
  total 344
  -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
  -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
  -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
  -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
  -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
  -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
  -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
  -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7
  -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header

There's a data file created for every cpu and it's storing
data for those cpu maps. The report command will read it
transparently, sort it and display as single file data.

It's possible to transform directory data into standard
perf.data file via simple inject command:
    
  $ perf inject -o perf.data.file -i perf.data

The old perf fails over the directory data with following message:
  $ perf report
  incompatible file format (rerun with -v to learn more)

I'm now testing the record threads support, so I'd like to
have some agreement on the directory data support before.

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/dir

thanks,
jirka


---
Jiri Olsa (14):
      perf tools: Make rm_rf to remove single file
      perf session: Add process callback to reader object
      perf data: Move size to struct perf_data_file
      perf data: Add global path holder
      perf data: Make check_backup work over directories
      perf data: Add perf_data__(create_dir|free_dir) functions
      perf data: Add perf_data__open_dir_data function
      perf data: Add directory support
      perf data: Don't store auxtrace index for directory data file
      perf data: Add perf_data__update_dir function
      perf data: Make perf_data__size to work over directory
      perf session: Add __perf_session__process_dir_events function
      perf session: Add path to reader object
      perf record: Add --dir option to store data in directory

 tools/perf/Documentation/perf-record.txt |   3 ++
 tools/perf/builtin-annotate.c            |   4 +--
 tools/perf/builtin-buildid-cache.c       |   4 +--
 tools/perf/builtin-buildid-list.c        |   8 ++---
 tools/perf/builtin-c2c.c                 |   4 +--
 tools/perf/builtin-diff.c                |  12 +++----
 tools/perf/builtin-evlist.c              |   4 +--
 tools/perf/builtin-inject.c              |  10 +++---
 tools/perf/builtin-kmem.c                |   2 +-
 tools/perf/builtin-kvm.c                 |   8 ++---
 tools/perf/builtin-lock.c                |   8 ++---
 tools/perf/builtin-mem.c                 |   8 ++---
 tools/perf/builtin-record.c              |  72 +++++++++++++++++++++++++++++++------
 tools/perf/builtin-report.c              |   6 ++--
 tools/perf/builtin-sched.c               |  16 ++++-----
 tools/perf/builtin-script.c              |  12 +++----
 tools/perf/builtin-stat.c                |   6 ++--
 tools/perf/builtin-timechart.c           |   8 ++---
 tools/perf/builtin-trace.c               |   8 ++---
 tools/perf/util/data-convert-bt.c        |   2 +-
 tools/perf/util/data.c                   | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/data.h                   |  24 +++++++++----
 tools/perf/util/mmap.h                   |  23 ++++++------
 tools/perf/util/session.c                | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/util.c                   |  10 ++++--
 25 files changed, 479 insertions(+), 131 deletions(-)
