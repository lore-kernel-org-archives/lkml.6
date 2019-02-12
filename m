Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC2EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743C42080D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549974486;
	bh=4E8Ddz1lDpu5N1dNn14Pmvn7BEHuISgfWs/ulBVw1Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dZgNm3lKH6GWA64thXLSFdLoOldUWohCxTrVnbLlei17LOJ//bxhb3cIbD6WgvFJZ
	 REr8fmeDolVhD0YJy0pxx2HPopnLzd4DRU0ApAUC/EkYNKo4z2MeO+h30U8vvd6yzw
	 086QRIacbEb3j/rJo7ZNti0rIKmdpUbWPCJ9xuVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfBLM2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfBLM2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:28:04 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E40C2080D;
        Tue, 12 Feb 2019 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549974482;
        bh=4E8Ddz1lDpu5N1dNn14Pmvn7BEHuISgfWs/ulBVw1Mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v48OnboZpdLn20cO+l+TijEiDo1r/vkeiZlGdlUjhdMDqKcC45DZmhHVmeoe5jiP8
         5ExPpeKnRfYh7rU7OYNqJTvMBF74bz5q3b8GGJSXLbKuTCyGGbPA9DhPb/TKeephFB
         HJ0rc/MmWnPjZkpYJ/UuSBmzlPAij4teVAbjEjZQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5D2B8410D5; Tue, 12 Feb 2019 09:27:58 -0300 (-03)
Date:   Tue, 12 Feb 2019 09:27:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190212122758.GH3269@kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 11, 2019 at 11:17:14PM +0300, Alexey Budankov escreveu:
> This is the rebase to the tip of Arnaldo's perf/core repository.
 
> The patch set implements runtime trace compression for record mode and 
> trace file decompression for report mode. Zstandard API [1] is used for 
> compression/decompression of data that come from perf_events kernel 
> data buffers.
 
> Realized -z,--compression_level=n option provides ~3-5x avg. trace file 

Realized? Perhaps "Using the -z/--compression_level=n options provides
3.5x average size reduction on..."

> size reduction on variety of tested workloads what saves user storage 
> space on larger server systems where trace file size can easily reach 
> several tens or even hundreds of GiBs, especially when profiling with 
> dwarf-based stacks and tracing of  context-switches.
 
> --mmap-flush option can be used to avoid compressing every single byte 

What is the default for --mmap-flush when -z is used? Does it vary with
the compression level? Can we expect something that is reasonable or is
using --mmap-flush always needed? If so can we do away with that by
using some sensible default according to the -z level used?

> of data and increase compression ratio at the same time lowering tool 
> runtime overhead.
> 
>   $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
>   $ tools/perf/perf record -z 1 --mmap-flush 1024 -e cycles -- matrix.gcc
>   $ tools/perf/perf record -z 1 --mmap-flush 1024 --aio -e cycles -- matrix.gcc

Please avoid having these explanations just on the cover letter since it
will not get recorded in the git history for the project, please add
examples with output from real workloads, preferably providing real
cases so that other people can readily replicate your results when
having access to similar large machines.
 
> The compression functionality can be disabled from the command line 
> using NO_LIBZSTD define and Zstandard sources can be overridden using 
> value of LIBZSTD_DIR define:
> 
>   $ make -C tools/perf NO_LIBZSTD=1 clean all
>   $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd-1.3.7 clean all

Showing the relevant output of the these commands before/after
installing the libzstd library is useful as well. From what you use
above is it fair to conclude that there are no readily made packages for
this library and we need to get it from github and build it ourselves?

On my notebook, a Fedora 29 system:

[root@quaco ~]# dnf search zstd
========================================================== Name & Summary Matched: zstd ==========================================================
zstd.x86_64 : Zstd compression library
zstd.x86_64 : Zstd compression library
libzstd.x86_64 : Zstd shared library
libzstd.i686 : Zstd shared library
libzstd.x86_64 : Zstd shared library
libzstd-devel.i686 : Header files for Zstd library
libzstd-devel.x86_64 : Header files for Zstd library
============================================================= Summary Matched: zstd ==============================================================
fedora-repo-zdicts.noarch : Zstd dictionaries for Fedora repository metadata
[root@quaco ~]#
[root@quaco ~]# dnf install libzstd-devel
<SNIP>
 libzstd-devel                         x86_64                         1.3.8-1.fc29                          updates                          39 k
<SNIP>

So, do I need some specific 1.3.7 version? Is that why you used that
LIBZSTD_DIR in your example?

I'm trying these steps, but please consider following these suggestions
in future posts,

And thanks for working on this!

- Arnaldo
 
> ---
> Alexey Budankov (4):
>   feature: realize libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
>   perf record: implement -z=<level> and --mmap-flush=<thres> options
>   perf record: enable runtime trace compression
>   perf report: support record trace file decompression
> 
>  tools/build/Makefile.feature             |   6 +-
>  tools/build/feature/Makefile             |   6 +-
>  tools/build/feature/test-all.c           |   5 +
>  tools/build/feature/test-libzstd.c       |  12 +
>  tools/perf/Documentation/perf-record.txt |   9 +
>  tools/perf/Makefile.config               |  20 ++
>  tools/perf/Makefile.perf                 |   3 +
>  tools/perf/builtin-record.c              | 167 +++++++++++---
>  tools/perf/builtin-report.c              |   5 +-
>  tools/perf/perf.h                        |   2 +
>  tools/perf/util/env.h                    |  10 +
>  tools/perf/util/event.c                  |   1 +
>  tools/perf/util/event.h                  |   7 +
>  tools/perf/util/evlist.c                 |   6 +-
>  tools/perf/util/evlist.h                 |   3 +-
>  tools/perf/util/header.c                 |  45 +++-
>  tools/perf/util/header.h                 |   1 +
>  tools/perf/util/mmap.c                   | 265 +++++++++++++---------
>  tools/perf/util/mmap.h                   |  31 ++-
>  tools/perf/util/session.c                | 271 ++++++++++++++++++++++-
>  tools/perf/util/session.h                |  26 +++
>  tools/perf/util/tool.h                   |   2 +
>  22 files changed, 742 insertions(+), 161 deletions(-)
>  create mode 100644 tools/build/feature/test-libzstd.c
> 
> ---
> Changes in v2:
> - moved compression/decompression code to session layer
> - enabled allocation aio data buffers for compression
> - enabled trace compression for serial trace streaming
> 
> ---
> [1] https://github.com/facebook/zstd

-- 

- Arnaldo
