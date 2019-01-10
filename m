Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD746C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D87E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfAJHxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:53:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:50862 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfAJHxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:53:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 23:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,460,1539673200"; 
   d="scan'208";a="265988923"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga004.jf.intel.com with ESMTP; 09 Jan 2019 23:53:49 -0800
Subject: Re: [PATCH 6/6] perf thread-stack: Hide x86 retpolines
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190109091835.5570-1-adrian.hunter@intel.com>
 <20190109091835.5570-7-adrian.hunter@intel.com> <20190109153842.GB2515@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <47f172fe-479b-323b-3d81-c3017b997244@intel.com>
Date:   Thu, 10 Jan 2019 09:52:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109153842.GB2515@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/01/19 5:38 PM, Jiri Olsa wrote:
> On Wed, Jan 09, 2019 at 11:18:35AM +0200, Adrian Hunter wrote:
>> x86 retpoline functions pollute the call graph by showing up everywhere
>> there is an indirect branch, but they do not really mean anything. Make
>> changes so that the default retpoline functions will no longer appear in
>> the call graph. Note this only affects the call graph, since all the
>> original branches are left unchanged.
>>
>> This does not handle function return thunks, nor is there any improvement
>> for the handling of inline thunks or extern thunks.
>>
>> Example:
>>
>> $ cat simple-retpoline.c
>> __attribute__((noinline)) int bar(void)
>> {
>>         return -1;
>> }
>>
>> int foo(void)
>> {
>>         return bar() + 1;
>> }
>>
>> __attribute__((indirect_branch("thunk"))) int main()
>> {
>>         int (*volatile fn)(void) = foo;
>>
>>         fn();
>>         return fn();
>> }
>> $ gcc -ggdb3 -Wall -Wextra -O2 -o simple-retpoline simple-retpoline.c
>> $ objdump -d simple-retpoline
>> <SNIP>
>> 0000000000001040 <main>:
>>     1040:       48 83 ec 18             sub    $0x18,%rsp
>>     1044:       48 8d 05 25 01 00 00    lea    0x125(%rip),%rax        # 1170 <foo>
>>     104b:       48 89 44 24 08          mov    %rax,0x8(%rsp)
>>     1050:       48 8b 44 24 08          mov    0x8(%rsp),%rax
>>     1055:       e8 1f 01 00 00          callq  1179 <__x86_indirect_thunk_rax>
>>     105a:       48 8b 44 24 08          mov    0x8(%rsp),%rax
>>     105f:       48 83 c4 18             add    $0x18,%rsp
>>     1063:       e9 11 01 00 00          jmpq   1179 <__x86_indirect_thunk_rax>
>> <SNIP>
>> 0000000000001160 <bar>:
>>     1160:       b8 ff ff ff ff          mov    $0xffffffff,%eax
>>     1165:       c3                      retq
>> <SNIP>
>> 0000000000001170 <foo>:
>>     1170:       e8 eb ff ff ff          callq  1160 <bar>
>>     1175:       83 c0 01                add    $0x1,%eax
>>     1178:       c3                      retq
>> 0000000000001179 <__x86_indirect_thunk_rax>:
>>     1179:       e8 07 00 00 00          callq  1185 <__x86_indirect_thunk_rax+0xc>
>>     117e:       f3 90                   pause
>>     1180:       0f ae e8                lfence
>>     1183:       eb f9                   jmp    117e <__x86_indirect_thunk_rax+0x5>
>>     1185:       48 89 04 24             mov    %rax,(%rsp)
>>     1189:       c3                      retq
>> <SNIP>
>> $ perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0,017 MB simple-retpoline.perf.data ]
>> $ perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
>> 2019-01-08 14:03:37.851655 Creating database...
>> 2019-01-08 14:03:37.863256 Writing records...
>> 2019-01-08 14:03:38.069750 Adding indexes
>> 2019-01-08 14:03:38.078799 Done
>> $ ~/libexec/perf-core/scripts/python/exported-sql-viewer.py simple-retpoline.db
>>
>> Before:
>>
>>     main
>>         -> __x86_indirect_thunk_rax
>>             -> __x86_indirect_thunk_rax
>>                 -> foo
>>                     -> bar
>>
>> After:
>>
>>     main
>>         -> foo
>>             -> bar
>>
> 
> hi,
> I still see them in kernel report.. after a while the output is shifted
> too far right out of the screen due to (I guess) this call/ret imbalance
> 
> 
> [root@krava perf]# ./perf-with-kcore record pt -e intel_pt/cyc/k -a -- sleep 1
> [root@krava perf]# ./perf-with-kcore script pt --call-trace -C 0
>             Xorg  2115 [000]  5850.032452321:  cbr: 36 freq: 3621 MHz (171%)
>             Xorg  2115 [000]  5850.032452351: ([kernel.kallsyms])           __list_add_valid
>             Xorg  2115 [000]  5850.032452380: ([kernel.kallsyms])           perf_pmu_enable.part.101
>             Xorg  2115 [000]  5850.032452380: ([kernel.kallsyms])               __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452415: ([kernel.kallsyms])           __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452415: ([kernel.kallsyms])               __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452442: ([kernel.kallsyms])           __list_add_valid
>             Xorg  2115 [000]  5850.032452457: ([kernel.kallsyms])           rb_next
>             Xorg  2115 [000]  5850.032452494: ([kernel.kallsyms])           __x86_indirect_thunk_r12
>             Xorg  2115 [000]  5850.032452494: ([kernel.kallsyms])               __x86_indirect_thunk_r12
>             Xorg  2115 [000]  5850.032452535: ([kernel.kallsyms])                   group_sched_in
>             Xorg  2115 [000]  5850.032452535: ([kernel.kallsyms])                       __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452535: ([kernel.kallsyms])                           __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452548: ([kernel.kallsyms])                       event_sched_in.isra.113
>             Xorg  2115 [000]  5850.032452548: ([kernel.kallsyms])                           perf_event_set_state.part.70
>             Xorg  2115 [000]  5850.032452548: ([kernel.kallsyms])                               perf_event_update_time
>             Xorg  2115 [000]  5850.032452562: ([kernel.kallsyms])                           perf_log_itrace_start
>             Xorg  2115 [000]  5850.032452562: ([kernel.kallsyms])                           __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452562: ([kernel.kallsyms])                               __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                   perf_event_update_userpage
>             Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                       calc_timer_values
>             Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                           sched_clock_cpu
>             Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                               sched_clock
>             Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                                   native_sched_clock
>             Xorg  2115 [000]  5850.032452793: ([kernel.kallsyms])                                       __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452793: ([kernel.kallsyms])                                           __indirect_thunk_start
>             Xorg  2115 [000]  5850.032452867: ([kernel.kallsyms])                                       arch_perf_update_userpage
>             Xorg  2115 [000]  5850.032452867: ([kernel.kallsyms])                                           using_native_sched_clock
>             Xorg  2115 [000]  5850.032452867: ([kernel.kallsyms])                                           sched_clock_stable
>             Xorg  2115 [000]  5850.032452867: ([kernel.kallsyms])                                           cyc2ns_read_begin
>             Xorg  2115 [000]  5850.032453157: ([kernel.kallsyms])                                           cyc2ns_read_end
>             Xorg  2115 [000]  5850.032453194: ([kernel.kallsyms])                       __indirect_thunk_start
>             Xorg  2115 [000]  5850.032453194: ([kernel.kallsyms])                           __indirect_thunk_start
>             Xorg  2115 [000]  5850.032453206: ([kernel.kallsyms])                   __list_add_valid
> 
> 
> jirka
> 

These patches are for db export and the context-sensitive call chain report
in the exported-sql-viewer.py python script.  The callchains you see above
are done at a lower level, before symbol resolution.  If you don't want to
see the thunks you can grep them out.  But more work is needed on them too.
I'll add it to the TODO list.
