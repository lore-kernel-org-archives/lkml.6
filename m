Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3094DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F260A2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfB0O5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:57:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:2084 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfB0O5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:57:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 06:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="278292905"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2019 06:56:59 -0800
Received: from [10.251.86.205] (abudanko-mobl.ccr.corp.intel.com [10.251.86.205])
        by linux.intel.com (Postfix) with ESMTP id CAE4458011C;
        Wed, 27 Feb 2019 06:56:55 -0800 (PST)
Subject: Re: [PATCH v3 0/9] perf: enable compression of record mode trace to
 save storage space
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
 <20190227142754.GA30149@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f3b53a68-80ed-c817-e1fa-c58c3d06ce97@linux.intel.com>
Date:   Wed, 27 Feb 2019 17:56:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227142754.GA30149@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.02.2019 17:27, Jiri Olsa wrote:
> On Tue, Feb 26, 2019 at 08:31:38AM +0300, Alexey Budankov wrote:
>>
>> The patch set implements runtime trace compression (-z option) in 
>> record mode and trace auto decompression in report and inject modes. 
>> Streaming Zstandard (Zstd) API (zstd) is used for compression and 
>> decompression of data that come from kernel mmaped data buffers.
>>
>> Usage of implemented -z,--compression_level=n option provides ~3-5x 
>> avg. trace file size reduction on variety of tested workloads what 
>> saves storage space on larger server systems where trace file size 
>> can easily reach several tens or even hundreds of GiBs, especially 
>> when profiling with dwarf-based stacks and tracing of context switches.
>> Implemented -f,--mmap-flush option can be used to avoid compressing 
>> every single byte of data and increase compression ratio at the same 
>> time lowering tool runtime overhead. Default option value is 1 what 
>> is equal to the current perf record implementation. The option is 
>> independent from -z setting and doesn't vary with compression level:
>>
>>   $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record --aio=1 -z 1 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record -z 1 -f 1024 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record --aio=1 -z 1 -f 1024 -e cycles -- matrix.gcc
>>
>> Runtime compression overhead has been measured for serial and AIO 
>> trace writing modes when profiling matrix multiplication workload 
>> with the following results:
>>
>>     -------------------------------------------------------------
>>     | SERIAL			  | AIO-1                       |
>> -----------------------------------------------------------------
>> |-z | OVH(x) | ratio(x) size(MiB) | OVH(x) | ratio(x) size(MiB) |
>> |----------------------------------------------------------------
>> | 0 | 1,00   | 1,000    179,424   | 1,00   | 1,000    187,527   |
>> | 1 | 1,04   | 8,427    181,148   | 1,01   | 8,474    188,562   |
>> | 2 | 1,07   | 8,055    186,953   | 1,03   | 7,912    191,773   |
>> | 3 | 1,04   | 8,283    181,908   | 1,03   | 8,220    191,078   |
>> | 5 | 1,09   | 8,101    187,705   | 1,05   | 7,780    190,065   |
>> | 8 | 1,05   | 9,217    179,191   | 1,12   | 6,111    193,024   |
>> -----------------------------------------------------------------
>>
>> OVH = (Execution time with -z N) / (Execution time with -z 0)
>>
>> ratio - compression ratio
>> size  - number of bytes that was compressed
>>
>> size ~= trace file x ratio
>>
>> See complete description of measurement conditions and details below.
>>
>> Introduced compression functionality can be disabled or configured from 
>> the command line using NO_LIBZSTD and LIBZSTD_DIR defines:
>>
>>   $ make -C tools/perf NO_LIBZSTD=1 clean all
>>   $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd/sources/ clean all
>>
>> If your system has some version of the zstd package preinstalled then 
>> the build system finds and uses it during the build. Auto detection 
>> feature status is reported just before compilation starts, as usual.
>> If you still prefer to compile with some version of zstd that is not 
>> preinstalled you have capability to refer the compilation to that 
>> version using LIBZSTD_DIR define.
>>
>> See 'tools/perf/perf test' run results below.
>>
>> ---
>> Alexey Budankov (9):
>>   feature: implement libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
>>   perf record: implement -f,--mmap-flush=<threshold> option
>>   perf session: define bytes_transferred and bytes_compressed metrics
>>   perf record: implement COMPRESSED event record and its attributes
>>   perf mmap: implement dedicated memory buffer for data compression
>>   perf util: introduce Zstd based streaming compression API
>>   perf record: implement -z,--compression_level=n option and compression
>>   perf report: implement record trace decompression
>>   perf inject: enable COMPRESSED records decompression
> 
> what commit id is this post based on? I can't get it applied:

I think it is that one below: 

ca9d246ede355946273271c37bf2e9e9fe533212 (HEAD -> zstd.V3) perf inject: enable COMPRESSED records decompression
4a71d4b79f5c1793e4d28851ff0ab11e1b0b2fd9 perf report: implement record trace decompression
5c2ba4e117cfacc415fbeac8e26484cfb80070b7 perf record: implement -z,--compression_level=n option and compression
9634ec18b3090daf5b0137a9aa7dd87552245a83 perf util: introduce Zstd based streaming compression API
bc692fb6a1a00e005592233a4ced1198e9d0a78d perf mmap: implement dedicated memory buffer for data compression
9ef63f64522f51bdba9e311303dd8bd73ce88f95 perf record: implement COMPRESSED event record and its attributes
8b470b5b6668532a679cecceeca2e56c1c71b8e2 perf session: define bytes_transferred and bytes_compressed metrics
1666675103895646f78b5f30c9bab77dfbfb91a1 perf record: implement -f,--mmap-flush=<threshold> option
3347a6774f85bcb06a04c95c188eb7f8e99811e1 feature: implement libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
306b805b097d42e66b0cdae19f97e1d1fa60909e (perf/core) Merge branch 'perf/core' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
=> c25b9ecf016e7824096611d4b8b0c6c271205316 (origin/perf/core) perf script python: add Python3 support to syscall-counts-by-pid.py
c6e562de9f34fd4df2833a5ef4cf59948385e816 perf script python: add Python3 support to syscall-counts.py
b3b4ccaa756984bc81ed7436e55c6fca5d02f00d perf script python: add Python3 support to stat-cpi.py

Thanks,
Alexey

> 
> Applying: feature: implement libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
> Applying: perf record: implement -f,--mmap-flush=<threshold> option
> error: corrupt patch at line 276
> Patch failed at 0002 perf record: implement -f,--mmap-flush=<threshold> option
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> 
> jirka
> 
