Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeC1O43 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:56:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:18174 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753101AbeC1O42 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:56:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="215647501"
Subject: Re: [PATCH v2 4/4] perf: Support perf -vv
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
 <1522249028-15099-5-git-send-email-yao.jin@linux.intel.com>
 <20180328132252.GM3102@krava>
 <c984a7d9-1e59-93f6-36b5-6ce878039f53@linux.intel.com>
 <20180328141940.GA32321@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f943f62c-0af2-7052-88a4-df9c7a978fa1@linux.intel.com>
Date: Wed, 28 Mar 2018 22:56:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328141940.GA32321@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2018 10:19 PM, Jiri Olsa wrote:
> On Wed, Mar 28, 2018 at 10:00:32PM +0800, Jin, Yao wrote:
>>
>>
>> On 3/28/2018 9:22 PM, Jiri Olsa wrote:
>>> On Wed, Mar 28, 2018 at 10:57:08PM +0800, Jin Yao wrote:
>>>> We keep having bug reports that when users build perf on their own,
>>>> but they don't install some needed libraries such as libelf,
>>>> libbfd/libibery.
>>>>
>>>> The perf can build, but it is missing important functionality.
>>>>
>>>> This patch provides a new option '-vv' which will print the
>>>> compiled-in status of libraries.
>>>>
>>>> The 'perf -vv' is equal to 'perf -version --build-options'.
>>>>
>>>> For example:
>>>>
>>>> $ ./perf -vv or ./perf -version --build-options
>>>> perf version 4.13.rc5.gcb1183
>>>>                    dwarf: [ on  ]
>>>>       dwarf_getlocations: [ on  ]
>>>>                    glibc: [ on  ]
>>>>                     gtk2: [ on  ]
>>>>                 libaudit: [ OFF ]
>>>>                   libbfd: [ on  ]
>>>>                   libelf: [ on  ]
>>>>                  libnuma: [ on  ]
>>>> numa_num_possible_cpus: [ on  ]
>>>>                  libperl: [ on  ]
>>>>                libpython: [ on  ]
>>>>                 libslang: [ on  ]
>>>>                libcrypto: [ on  ]
>>>>                libunwind: [ on  ]
>>>>       libdw-dwarf-unwind: [ on  ]
>>>>                     zlib: [ on  ]
>>>>                     lzma: [ on  ]
>>>>                get_cpuid: [ on  ]
>>>>                      bpf: [ on  ]
>>>> [ on  ]: library is compiled-in
>>>> [ OFF ]: library is disabled in make configuration
>>>>            OR library is not installed in build environment
>>>>
>>>> v2:
>>>> ---
>>>> Use a global variable version_verbose to count the number of 'v'.
>>>>
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>> ---
>>>>    tools/perf/perf.c | 22 ++++++++++++++++++----
>>>>    tools/perf/perf.h |  1 +
>>>>    2 files changed, 19 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
>>>> index 1b3fc8e..355219e 100644
>>>> --- a/tools/perf/perf.c
>>>> +++ b/tools/perf/perf.c
>>>> @@ -32,7 +32,7 @@
>>>>    #include <linux/kernel.h>
>>>>    const char perf_usage_string[] =
>>>> -	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
>>>> +	"perf [--version [--build-options]] [--help] [OPTIONS] COMMAND [ARGS]";
>>>
>>> --build-options is 'perf version' option no?
>>>
>>> jirka
>>>
>>
>> Yes. Command-line something like:
>>
>> perf --version --build-options or perf -v --build-options.
>>
>> Is this usage string not correct? If so, I'd like to fix that.
>>
>> "perf [--version [--build-options]] [--help] [OPTIONS] COMMAND [ARGS]";
> 
> ah I forgot that --version is in fact 'perf version'
> now I see --build-options depends on --version.. ok ;-)
> 
> could you please also create Documentation/perf-version.txt,
> now when it has option, we should document it
> 

That's fine. I will create the perf-version.txt.

> also please use the standard option parsing API we use in commands:
> 
>          argc = parse_options(argc, argv, record_options, record_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
> 
> so we get standard error when the option is mangled,
> unlinke now, when it's silent:
> 
> 	[jolsa@krava perf]$ ./perf --version --buil
> 	perf version 4.16.rc6.gcc183d
> 
> thanks,
> jirka
> 

Oh, yes. Let me check and update the code. Thanks so much for reminding 
this.

Thanks
Jin Yao
