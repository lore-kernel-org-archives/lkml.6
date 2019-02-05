Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9B42083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfBEPeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:34:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:63040 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfBEPeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:34:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 07:34:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="131728030"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2019 07:34:15 -0800
Received: from [10.125.252.139] (abudanko-mobl.ccr.corp.intel.com [10.125.252.139])
        by linux.intel.com (Postfix) with ESMTP id D0B655800E0;
        Tue,  5 Feb 2019 07:34:13 -0800 (PST)
Subject: Re: [PATCH v5 2/4] perf record: bind the AIO user space buffers to
 nodes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
 <5a5adebc-afe0-4806-81cd-180d49ec043f@linux.intel.com>
 <20190204192910.GK5593@kernel.org>
 <62d94ac3-45ac-c4e4-0f9e-1084c4a25b83@linux.intel.com>
 <20190205151526.GC10613@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <56f5e0b8-917c-d180-7e71-77a7edcb4231@linux.intel.com>
Date:   Tue, 5 Feb 2019 18:34:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190205151526.GC10613@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.02.2019 18:15, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 04, 2019 at 10:47:03PM +0300, Alexey Budankov escreveu:
>>
>> On 04.02.2019 22:29, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Jan 22, 2019 at 08:48:54PM +0300, Alexey Budankov escreveu:
>>>>
>>>> Allocate and bind AIO user space buffers to the memory nodes
>>>> that mmap kernel buffers are bound to.
>>>
>>> [root@quaco amazonlinux]# perf test -v python
>>> 18: 'import perf' in python                               :
>>> --- start ---
>>> test child forked, pid 526
>>> Traceback (most recent call last):
>>>   File "<stdin>", line 1, in <module>
>>> ImportError: /tmp/build/perf/python/perf.so: undefined symbol: mbind
>>
>> Argh. Missed that.
>>
>>> test child finished with -1
>>> ---- end ----
>>> 'import perf' in python: FAILED!
>>> [root@quaco amazonlinux]#
>>>
>>>
>>> Please always use 'perf test' before pushing upstream, I'll try to fix
>>> this one, either by linking libnuma into the python binding or by moving
>>> the routines using it to a separate file.
>>
>> Will do. Thanks for followup.
> 
> this seems to do the trick:
> 
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index d3ffc18424b5..88ffa995b44b 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -56,6 +56,7 @@ ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
>  perf = Extension('perf',
>  		  sources = ext_sources,
>  		  include_dirs = ['util/include'],
> +		  libraries = ['numa'],
>  		  extra_compile_args = cflags,
>  		  extra_objects = [libtraceevent, libapikfs],
>                   )
> 
> ------------------------------------------------
> 
> [root@quaco ~]# ldd /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gnu.so
> 	linux-vdso.so.1 (0x00007ffdf53c3000)
> 	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007fa538b82000)
> 	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007fa538b66000)
> 	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fa538b3d000)
> 	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007fa538b2f000)
> 	libpython3.7m.so.1.0 => /lib64/libpython3.7m.so.1.0 (0x00007fa5387b7000)
> 	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fa538795000)
> 	libc.so.6 => /lib64/libc.so.6 (0x00007fa5385cd000)
> 	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fa5385b2000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007fa538c1a000)
> 	libdl.so.2 => /lib64/libdl.so.2 (0x00007fa5385ac000)
> 	libutil.so.1 => /lib64/libutil.so.1 (0x00007fa5385a7000)
> 	libm.so.6 => /lib64/libm.so.6 (0x00007fa538423000)
> [root@quaco ~]#
> 
> [root@quaco ~]# perf test python
> 18: 'import perf' in python                               : Ok
> [root@quaco ~]#
> 
> 
> So I'm ammending that hunk to the patch that introduces that mbind
> usage.

Again, thanks a lot, Arnaldo!

Alexey

> 
> Thanks,
> 
> - Arnaldo
> 
