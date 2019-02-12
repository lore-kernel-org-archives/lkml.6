Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F849C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D01218D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfBLOGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:06:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:54625 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfBLOGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:06:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 06:06:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="299135175"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2019 06:06:06 -0800
Received: from [10.125.252.165] (abudanko-mobl.ccr.corp.intel.com [10.125.252.165])
        by linux.intel.com (Postfix) with ESMTP id 7A3AD58046D;
        Tue, 12 Feb 2019 06:06:04 -0800 (PST)
Subject: Re: [PATCH v2 0/4] perf: enable compression of record mode trace to
 save storage space
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <20190212122758.GH3269@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fd3989c7-e6e3-3805-72d1-a621d642e073@linux.intel.com>
Date:   Tue, 12 Feb 2019 17:06:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212122758.GH3269@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 15:27, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 11, 2019 at 11:17:14PM +0300, Alexey Budankov escreveu:
>> This is the rebase to the tip of Arnaldo's perf/core repository.
>  
>> The patch set implements runtime trace compression for record mode and 
>> trace file decompression for report mode. Zstandard API [1] is used for 
>> compression/decompression of data that come from perf_events kernel 
>> data buffers.
>  
>> Realized -z,--compression_level=n option provides ~3-5x avg. trace file 
> 
> Realized? Perhaps "Using the -z/--compression_level=n options provides
> 3.5x average size reduction on..."

Yep, wording could be adjusted. Thanks!

> 
>> size reduction on variety of tested workloads what saves user storage 
>> space on larger server systems where trace file size can easily reach 
>> several tens or even hundreds of GiBs, especially when profiling with 
>> dwarf-based stacks and tracing of  context-switches.
>  
>> --mmap-flush option can be used to avoid compressing every single byte 
> 
> What is the default for --mmap-flush when -z is used? Does it vary with
> the compression level? Can we expect something that is reasonable or is
> using --mmap-flush always needed? If so can we do away with that by
> using some sensible default according to the -z level used?

Default value is 1 what is equal to the current perf record implementation. 
The option is independent from -z setting and doesn't vary with compression 
level. Default could be different if -z is specified.

> 
>> of data and increase compression ratio at the same time lowering tool 
>> runtime overhead.
>>
>>   $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record -z 1 --mmap-flush 1024 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record -z 1 --mmap-flush 1024 --aio -e cycles -- matrix.gcc
> 
> Please avoid having these explanations just on the cover letter since it
> will not get recorded in the git history for the project, please add
> examples with output from real workloads, preferably providing real
> cases so that other people can readily replicate your results when
> having access to similar large machines.

Will do. Thanks!

>  
>> The compression functionality can be disabled from the command line 
>> using NO_LIBZSTD define and Zstandard sources can be overridden using 
>> value of LIBZSTD_DIR define:
>>
>>   $ make -C tools/perf NO_LIBZSTD=1 clean all
>>   $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd-1.3.7 clean all
> 
> Showing the relevant output of the these commands before/after
> installing the libzstd library is useful as well. From what you use
> above is it fair to conclude that there are no readily made packages for
> this library and we need to get it from github and build it ourselves?

If your system has some version of the package preinstalled then the build 
system finds and uses it during the build. Auto detection feature status is 
reported just before compilation starts.

If you still prefer to compile with some newer version that is not 
preinstalled, and you don't want upgrading your system with newer version, 
you have capability to download, build and then refer the compilation to 
the newer just built library version using LIBZSTD_DIR.

> 
> On my notebook, a Fedora 29 system:
> 
> [root@quaco ~]# dnf search zstd
> ========================================================== Name & Summary Matched: zstd ==========================================================
> zstd.x86_64 : Zstd compression library
> zstd.x86_64 : Zstd compression library
> libzstd.x86_64 : Zstd shared library
> libzstd.i686 : Zstd shared library
> libzstd.x86_64 : Zstd shared library
> libzstd-devel.i686 : Header files for Zstd library
> libzstd-devel.x86_64 : Header files for Zstd library
> ============================================================= Summary Matched: zstd ==============================================================
> fedora-repo-zdicts.noarch : Zstd dictionaries for Fedora repository metadata
> [root@quaco ~]#
> [root@quaco ~]# dnf install libzstd-devel
> <SNIP>
>  libzstd-devel                         x86_64                         1.3.8-1.fc29                          updates                          39 k
> <SNIP>
> 
> So, do I need some specific 1.3.7 version? Is that why you used that
> LIBZSTD_DIR in your example?

v1.3.7 is just an example. v1.3.8 can be also provided.

> 
> I'm trying these steps, but please consider following these suggestions
> in future posts,
> 
> And thanks for working on this!

Thanks for meaningful comments. Will do my best to follow it.

Thanks,
Alexey

> 
> - Arnaldo
>  
