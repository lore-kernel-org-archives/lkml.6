Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeC0N0q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:26:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:4404 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbeC0N0o (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:26:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="41629814"
Subject: Re: [PATCH v1 2/3] perf version: Print the status of compiled-in
 libraries
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
 <20180326093925.GI6207@krava>
 <84893905-7512-0757-c13c-152a9d051f92@linux.intel.com>
 <20180327123803.GF3102@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1f03bf56-4baa-e79e-84fe-17e9632fd09d@linux.intel.com>
Date: Tue, 27 Mar 2018 21:26:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327123803.GF3102@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2018 8:38 PM, Jiri Olsa wrote:
> On Mon, Mar 26, 2018 at 09:51:03PM +0800, Jin, Yao wrote:
>>
>>
>> On 3/26/2018 5:39 PM, Jiri Olsa wrote:
>>> On Tue, Mar 27, 2018 at 12:07:03AM +0800, Jin Yao wrote:
>>>> This patch checks the values passed by CFLAGS (-DXXX) and then
>>>> print the status of libraries.
>>>>
>>>> For example, if HAVE_DWARF_SUPPORT is defined, that means the
>>>> library "dwarf" is compiled-in. The patch will print the status
>>>> "on" for this library.
>>>>
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>> ---
>>>>    tools/perf/builtin-version.c | 125 +++++++++++++++++++++++++++++++++++++++++++
>>>>    tools/perf/builtin.h         |   1 +
>>>>    2 files changed, 126 insertions(+)
>>>>
>>>> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
>>>> index 37019c5..90a0a7f 100644
>>>> --- a/tools/perf/builtin-version.c
>>>> +++ b/tools/perf/builtin-version.c
>>>> @@ -9,3 +9,128 @@ int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
>>>>    	printf("perf version %s\n", perf_version_string);
>>>>    	return 0;
>>>>    }
>>>> +
>>>> +static void status_print(const char *name, const char *status)
>>>> +{
>>>> +	printf("%22s: [ %3s ]\n", name, status);
>>>> +}
>>>> +
>>>> +static void library_status(void)
>>>> +{
>>>> +#ifdef HAVE_DWARF_SUPPORT
>>>> +	status_print("dwarf", "on");
>>>> +#else
>>>> +	status_print("dwarf", "off");
>>>> +#endif
>>>
>>> could this and all those below be in some generic macro?
>>>
>>> #define STATUS(__d, __m)		\
>>> #ifdef __d 				\
>>> 	status_print(#__m, "on");	\
>>> #else					\
>>> 	status_print(#__m, "OFF");	\
>>> #endif
>>>
>>> STATUS(HAVE_DWARF_SUPPORT, dwarf)
>>>
>>>
>>> also please print the 'OFF' and use colors as in the build message
>>>
>>
>> Fine, thanks. I will update the code.
>>
>>>> +
>>>> +#ifdef HAVE_DWARF_GETLOCATIONS
>>>> +	status_print("dwarf_getlocations", "on");
>>>> +#else
>>>> +	status_print("dwarf_getlocations", "off");
>>>> +#endif
>>>> +
>>>> +#ifdef NO_GLIBC
>>>> +	status_print("glibc", "off");
>>>> +#else
>>>> +	status_print("glibc", "on");
>>>> +#endif
>>>> +
>>>> +#ifdef HAVE_GTK2_SUPPORT
>>>> +	status_print("gtk2", "on");
>>>> +#else
>>>> +	status_print("gtk2", "off");
>>>> +#endif
>>>> +
>>>
>>> SNIP
>>>
>>>> +}
>>>> +
>>>> +int cmd_version2(int argc, const char **argv)
>>>> +{
>>>> +	cmd_version(argc, argv);
>>>> +	library_status();
>>>> +	return 0;
>>>> +}
>>>> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
>>>> index 05745f3..c7508ee 100644
>>>> --- a/tools/perf/builtin.h
>>>> +++ b/tools/perf/builtin.h
>>>> @@ -29,6 +29,7 @@ int cmd_timechart(int argc, const char **argv);
>>>>    int cmd_top(int argc, const char **argv);
>>>>    int cmd_script(int argc, const char **argv);
>>>>    int cmd_version(int argc, const char **argv);
>>>> +int cmd_version2(int argc, const char **argv);
>>>
>>> please don't add new command for this, handle this in cmd_version
>>>
>>
>> Yeah, I know that, adding a new command is not a good idea.
>>
>> But how can I pass a new parameter to cmd_version to indicate it's the -vv
>> case? Use argv[1]? But looks not good since argc is 1.
>>
>> Any idea about that?
> 
> I guess the based would be to have 'perf version -v', where
> in cmd_version you'd call standard option processing..
> 
> the 'perf -vv' shortcut could for example be done through
> some global var like in attached patch... untested
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 37019c5d675f..1fe458792cc1 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -4,6 +4,8 @@
>   #include <linux/compiler.h>
>   #include <stdio.h>
>   
> +int version_verbose;
> +
>   int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
>   {
>   	printf("perf version %s\n", perf_version_string);
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 1b3fc8ec0fa2..a5c95c6c0de7 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -185,7 +185,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>   			break;
>   		}
>   
> -		if (!strcmp(cmd, "-v")) {
> +		if (strstarts(cmd, "-v")) {
> +			int i;
> +
> +			for (i = 2; cmd[i]; i++) {
> +				if (cmd[i] == 'v')
> +					version_verbose++;
> +			}
> +
>   			(*argv)[0] = "--version";
>   			break;
>   		}
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 8fec1abd0f1f..9c45ba179635 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -13,6 +13,8 @@ void test_attr__init(void);
>   void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
>   		     int fd, int group_fd, unsigned long flags);
>   
> +extern int version_verbose;
> +
>   #define HAVE_ATTR_TEST
>   #include "perf-sys.h"
>   
> 

Using global variable, hmm, that's fine, looks no better way. :)

I will follow Ingo's suggestion. Use 'perf -v --build-options' and map 
it to 'perf -vv'.

Thanks
Jin Yao
