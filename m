Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEVA0Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:26:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:52873 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeEVA0U (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:26:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="56364318"
Subject: Re: [PATCH v4 3/3] perf annotate: Support '--group' option
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1526914666-31839-1-git-send-email-yao.jin@linux.intel.com>
 <1526914666-31839-4-git-send-email-yao.jin@linux.intel.com>
 <20180521174326.GA3772@kernel.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <381891a7-aef6-76a6-a5e5-9a95c74b3c62@linux.intel.com>
Date: Tue, 22 May 2018 08:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521174326.GA3772@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2018 1:43 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 21, 2018 at 10:57:46PM +0800, Jin Yao escreveu:
>> With the '--group' option, even for non-explicit group, perf annotate
>> will enable the group output.
>>
>> For example,
>>
>> perf record -e cycles,branches ./div
>> perf annotate main --stdio --group
> 
> You forgot to make the first line to include the group event string,
> i.e. for cycles,instructions it will show only this:
> 
>   Percent         |      Source code & Disassembly of ld-2.26.so for cycles:u (1 samples)
> ----------------------------------------------------------------------------------------
>                   :
>                   :
>                   :
>                   :           Disassembly of section .text:
>                   :
>                   :           00000000000167e0 <__GI___tunables_init>:
>                   :           __GI___tunables_init():
>                   :           /* Initialize the tunables list from the environment.  For now we only use the
>                   :              ENV_ALIAS to find values.  Later we will also use the tunable names to find
>                   :              values.  */
>                   :           void
>                   :           __tunables_init (char **envp)
>                   :           {
>      0.00    0.00 :   167e0:       push   %r15
>      0.00    0.00 :   167e2:       push   %r14
> 
> I'm applying the patch, this can be done on top,
> 
> - Arnaldo
> 

Oh, 'perf annotate --group' can show the group string but 'perf annotate 
--group --stdio' shows only one event.

I will check the '--stdio' and post a followup patch to fix that.

Thanks
Jin Yao

>>
>>                   :            Disassembly of section .text:
>>                   :
>>                   :            00000000004004b0 <main>:
>>                   :            main():
>>                   :
>>                   :                    return i;
>>                   :            }
>>                   :
>>                   :            int main(void)
>>                   :            {
>>      0.00    0.00 :   4004b0:       push   %rbx
>>                   :                    int i;
>>                   :                    int flag;
>>                   :                    volatile double x = 1212121212, y = 121212;
>>                   :
>>                   :                    s_randseed = time(0);
>>      0.00    0.00 :   4004b1:       xor    %edi,%edi
>>                   :                    srand(s_randseed);
>>      0.00    0.00 :   4004b3:       mov    $0x77359400,%ebx
>>                   :
>>                   :                    return i;
>>                   :            }
>>                   :
>>
>> But if without --group, there is only one event reported.
>>
>> perf annotate main --stdio
>>
>>           :            Disassembly of section .text:
>>           :
>>           :            00000000004004b0 <main>:
>>           :            main():
>>           :
>>           :                    return i;
>>           :            }
>>           :
>>           :            int main(void)
>>           :            {
>>      0.00 :   4004b0:       push   %rbx
>>           :                    int i;
>>           :                    int flag;
>>           :                    volatile double x = 1212121212, y = 121212;
>>           :
>>           :                    s_randseed = time(0);
>>      0.00 :   4004b1:       xor    %edi,%edi
>>           :                    srand(s_randseed);
>>      0.00 :   4004b3:       mov    $0x77359400,%ebx
>>           :
>>           :                    return i;
>>           :            }
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-annotate.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index 6e5d9f7..da57042 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -45,6 +45,7 @@ struct perf_annotate {
>>   	bool	   print_line;
>>   	bool	   skip_missing;
>>   	bool	   has_br_stack;
>> +	bool	   group_set;
>>   	const char *sym_hist_filter;
>>   	const char *cpu_list;
>>   	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>> @@ -508,6 +509,9 @@ int cmd_annotate(int argc, const char **argv)
>>   		    "Don't shorten the displayed pathnames"),
>>   	OPT_BOOLEAN(0, "skip-missing", &annotate.skip_missing,
>>   		    "Skip symbols that cannot be annotated"),
>> +	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group,
>> +			&annotate.group_set,
>> +			"Show event group information together"),
>>   	OPT_STRING('C', "cpu", &annotate.cpu_list, "cpu", "list of cpus to profile"),
>>   	OPT_CALLBACK(0, "symfs", NULL, "directory",
>>   		     "Look for files with symbols relative to this directory",
>> @@ -570,6 +574,9 @@ int cmd_annotate(int argc, const char **argv)
>>   	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
>>   						      HEADER_BRANCH_STACK);
>>   
>> +	if (annotate.group_set)
>> +		perf_evlist__force_leader(annotate.session->evlist);
>> +
>>   	ret = symbol__annotation_init();
>>   	if (ret < 0)
>>   		goto out_delete;
>> -- 
>> 2.7.4
