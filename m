Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727B520C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfB0O16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:27:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfB0O15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:27:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DEBC30BD43D;
        Wed, 27 Feb 2019 14:27:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id BAA11679E2;
        Wed, 27 Feb 2019 14:27:55 +0000 (UTC)
Date:   Wed, 27 Feb 2019 15:27:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190227142754.GA30149@krava>
References: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 27 Feb 2019 14:27:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:31:38AM +0300, Alexey Budankov wrote:
> 
> The patch set implements runtime trace compression (-z option) in 
> record mode and trace auto decompression in report and inject modes. 
> Streaming Zstandard (Zstd) API (zstd) is used for compression and 
> decompression of data that come from kernel mmaped data buffers.
> 
> Usage of implemented -z,--compression_level=n option provides ~3-5x 
> avg. trace file size reduction on variety of tested workloads what 
> saves storage space on larger server systems where trace file size 
> can easily reach several tens or even hundreds of GiBs, especially 
> when profiling with dwarf-based stacks and tracing of context switches.
> Implemented -f,--mmap-flush option can be used to avoid compressing 
> every single byte of data and increase compression ratio at the same 
> time lowering tool runtime overhead. Default option value is 1 what 
> is equal to the current perf record implementation. The option is 
> independent from -z setting and doesn't vary with compression level:
> 
>   $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio=1 -z 1 -e cycles -- matrix.gcc
>   $ tools/perf/perf record -z 1 -f 1024 -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio=1 -z 1 -f 1024 -e cycles -- matrix.gcc
> 
> Runtime compression overhead has been measured for serial and AIO 
> trace writing modes when profiling matrix multiplication workload 
> with the following results:
> 
>     -------------------------------------------------------------
>     | SERIAL			  | AIO-1                       |
> -----------------------------------------------------------------
> |-z | OVH(x) | ratio(x) size(MiB) | OVH(x) | ratio(x) size(MiB) |
> |----------------------------------------------------------------
> | 0 | 1,00   | 1,000    179,424   | 1,00   | 1,000    187,527   |
> | 1 | 1,04   | 8,427    181,148   | 1,01   | 8,474    188,562   |
> | 2 | 1,07   | 8,055    186,953   | 1,03   | 7,912    191,773   |
> | 3 | 1,04   | 8,283    181,908   | 1,03   | 8,220    191,078   |
> | 5 | 1,09   | 8,101    187,705   | 1,05   | 7,780    190,065   |
> | 8 | 1,05   | 9,217    179,191   | 1,12   | 6,111    193,024   |
> -----------------------------------------------------------------
> 
> OVH = (Execution time with -z N) / (Execution time with -z 0)
> 
> ratio - compression ratio
> size  - number of bytes that was compressed
> 
> size ~= trace file x ratio
> 
> See complete description of measurement conditions and details below.
> 
> Introduced compression functionality can be disabled or configured from 
> the command line using NO_LIBZSTD and LIBZSTD_DIR defines:
> 
>   $ make -C tools/perf NO_LIBZSTD=1 clean all
>   $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd/sources/ clean all
> 
> If your system has some version of the zstd package preinstalled then 
> the build system finds and uses it during the build. Auto detection 
> feature status is reported just before compilation starts, as usual.
> If you still prefer to compile with some version of zstd that is not 
> preinstalled you have capability to refer the compilation to that 
> version using LIBZSTD_DIR define.
> 
> See 'tools/perf/perf test' run results below.
> 
> ---
> Alexey Budankov (9):
>   feature: implement libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
>   perf record: implement -f,--mmap-flush=<threshold> option
>   perf session: define bytes_transferred and bytes_compressed metrics
>   perf record: implement COMPRESSED event record and its attributes
>   perf mmap: implement dedicated memory buffer for data compression
>   perf util: introduce Zstd based streaming compression API
>   perf record: implement -z,--compression_level=n option and compression
>   perf report: implement record trace decompression
>   perf inject: enable COMPRESSED records decompression

what commit id is this post based on? I can't get it applied:

Applying: feature: implement libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
Applying: perf record: implement -f,--mmap-flush=<threshold> option
error: corrupt patch at line 276
Patch failed at 0002 perf record: implement -f,--mmap-flush=<threshold> option
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


jirka
