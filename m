Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CEFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCAC20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035224;
	bh=L07seX9gJHM0eYfM6/AosVqlshj+iQffiCx6phs4QFw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kpsojdMh//tH5SkCsIruUi7jgc5uCKKYVfiB/UC3nqVrPSgnSiOCJrFYd/njpANqj
	 xoyQxnt+lcgEgMTbwK0nOJMBVx1ed/eTgFAXB5uVVavCr/PVx5dIYhBlD+uPvrsjYU
	 C4jmniqNG1awm/DdFut0X8cl/TJEcdd8YP4RQEQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBXTHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBXTHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78FE43082B21;
        Sun, 24 Feb 2019 19:07:01 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55A7C6013A;
        Sun, 24 Feb 2019 19:06:57 +0000 (UTC)
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
Subject: [PATCHv3 00/20] perf record: Add support to store data in directory
Date:   Sun, 24 Feb 2019 20:06:36 +0100
Message-Id: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 24 Feb 2019 19:07:01 +0000 (UTC)
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

There's new DIR_FORMAT feature to describe directory data
layout/format. In future we can describe different data files
layout according to special needs.

It's possible to transform directory data into standard
perf.data file via simple inject command:
    
  $ perf inject -o perf.data.file -i perf.data

The old perf fails over the directory data with following message:
  $ perf report
  incompatible file format (rerun with -v to learn more)

I'm now testing the record threads support, so I'd like to
have some agreement on the directory data support before.

v3 changes:
  - add rm_rf_perf_data to safely remove file/directory perf data
  - allocation fix in perf_data__create_dir

v2 changes:
  - rm_rf changes are already accepted with requested changes
  - updated doc/man plus adding perf.data-directory-format.txt
    to describe directory format/layout
  - the --switch-output options now works over directory data
  - data rollback is not part of this patchset, updated my TODO though ;-)
  - added --output-dir option to combine -o and --dir
  - added DIR_FORMAT feature to describe directory data
  - disabling directory output for aio for now

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/dir

thanks,
jirka


---
Jiri Olsa (20):
      perf tools: Add depth checking to rm_rf
      perf tools: Add pattern name checking to rm_rf
      perf tools: Add rm_rf_perf_data function
      perf data: Move size to struct perf_data_file
      perf data: Add global path holder
      perf data: Make check_backup work over directories
      perf data: Fail check_backup in case of error
      perf data: Add perf_data__(create_dir|close_dir) functions
      perf data: Add perf_data__open_dir_data function
      perf data: Add directory support
      perf data: Don't store auxtrace index for directory data file
      perf data: Add perf_data__update_dir function
      perf data: Make perf_data__size to work over directory
      perf header: Add DIR_FORMAT feature to describe directory data
      perf session: Add process callback to reader object
      perf session: Add __perf_session__process_dir_events function
      perf session: Add path to reader object
      perf record: Add --dir option to store data in directory
      perf record: Add --output-dir option to store data in directory
      perf record: Describe perf.data directory format

 tools/lib/subcmd/parse-options.h                        |   4 ++
 tools/perf/Documentation/perf-record.txt                |   6 +++
 tools/perf/Documentation/perf.data-directory-format.txt |  54 ++++++++++++++++++++
 tools/perf/builtin-annotate.c                           |   4 +-
 tools/perf/builtin-buildid-cache.c                      |   4 +-
 tools/perf/builtin-buildid-list.c                       |   8 ++-
 tools/perf/builtin-c2c.c                                |   4 +-
 tools/perf/builtin-diff.c                               |  12 ++---
 tools/perf/builtin-evlist.c                             |   4 +-
 tools/perf/builtin-inject.c                             |  10 ++--
 tools/perf/builtin-kmem.c                               |   2 +-
 tools/perf/builtin-kvm.c                                |   8 ++-
 tools/perf/builtin-lock.c                               |   8 ++-
 tools/perf/builtin-mem.c                                |   8 ++-
 tools/perf/builtin-record.c                             | 104 ++++++++++++++++++++++++++++++++++-----
 tools/perf/builtin-report.c                             |   6 +--
 tools/perf/builtin-sched.c                              |  16 +++---
 tools/perf/builtin-script.c                             |  12 ++---
 tools/perf/builtin-stat.c                               |   6 +--
 tools/perf/builtin-timechart.c                          |   8 ++-
 tools/perf/builtin-trace.c                              |   8 ++-
 tools/perf/util/data-convert-bt.c                       |   2 +-
 tools/perf/util/data.c                                  | 257 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 tools/perf/util/data.h                                  |  26 +++++++---
 tools/perf/util/header.c                                |  44 ++++++++++++++++-
 tools/perf/util/header.h                                |   5 ++
 tools/perf/util/mmap.h                                  |  23 ++++-----
 tools/perf/util/session.c                               | 125 +++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/util.c                                  |  55 ++++++++++++++++++++-
 tools/perf/util/util.h                                  |   1 +
 30 files changed, 700 insertions(+), 134 deletions(-)
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt
