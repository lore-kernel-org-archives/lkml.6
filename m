Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3203C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FB82177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbfAIPip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:38:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfAIPip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:38:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A6E6C0C49D0;
        Wed,  9 Jan 2019 15:38:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7114F10A1827;
        Wed,  9 Jan 2019 15:38:43 +0000 (UTC)
Date:   Wed, 9 Jan 2019 16:38:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] perf thread-stack: Hide x86 retpolines
Message-ID: <20190109153842.GB2515@krava>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
 <20190109091835.5570-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109091835.5570-7-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 15:38:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:18:35AM +0200, Adrian Hunter wrote:
> x86 retpoline functions pollute the call graph by showing up everywhere
> there is an indirect branch, but they do not really mean anything. Make
> changes so that the default retpoline functions will no longer appear in
> the call graph. Note this only affects the call graph, since all the
> original branches are left unchanged.
> 
> This does not handle function return thunks, nor is there any improvement
> for the handling of inline thunks or extern thunks.
> 
> Example:
> 
> $ cat simple-retpoline.c
> __attribute__((noinline)) int bar(void)
> {
>         return -1;
> }
> 
> int foo(void)
> {
>         return bar() + 1;
> }
> 
> __attribute__((indirect_branch("thunk"))) int main()
> {
>         int (*volatile fn)(void) = foo;
> 
>         fn();
>         return fn();
> }
> $ gcc -ggdb3 -Wall -Wextra -O2 -o simple-retpoline simple-retpoline.c
> $ objdump -d simple-retpoline
> <SNIP>
> 0000000000001040 <main>:
>     1040:       48 83 ec 18             sub    $0x18,%rsp
>     1044:       48 8d 05 25 01 00 00    lea    0x125(%rip),%rax        # 1170 <foo>
>     104b:       48 89 44 24 08          mov    %rax,0x8(%rsp)
>     1050:       48 8b 44 24 08          mov    0x8(%rsp),%rax
>     1055:       e8 1f 01 00 00          callq  1179 <__x86_indirect_thunk_rax>
>     105a:       48 8b 44 24 08          mov    0x8(%rsp),%rax
>     105f:       48 83 c4 18             add    $0x18,%rsp
>     1063:       e9 11 01 00 00          jmpq   1179 <__x86_indirect_thunk_rax>
> <SNIP>
> 0000000000001160 <bar>:
>     1160:       b8 ff ff ff ff          mov    $0xffffffff,%eax
>     1165:       c3                      retq
> <SNIP>
> 0000000000001170 <foo>:
>     1170:       e8 eb ff ff ff          callq  1160 <bar>
>     1175:       83 c0 01                add    $0x1,%eax
>     1178:       c3                      retq
> 0000000000001179 <__x86_indirect_thunk_rax>:
>     1179:       e8 07 00 00 00          callq  1185 <__x86_indirect_thunk_rax+0xc>
>     117e:       f3 90                   pause
>     1180:       0f ae e8                lfence
>     1183:       eb f9                   jmp    117e <__x86_indirect_thunk_rax+0x5>
>     1185:       48 89 04 24             mov    %rax,(%rsp)
>     1189:       c3                      retq
> <SNIP>
> $ perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0,017 MB simple-retpoline.perf.data ]
> $ perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
> 2019-01-08 14:03:37.851655 Creating database...
> 2019-01-08 14:03:37.863256 Writing records...
> 2019-01-08 14:03:38.069750 Adding indexes
> 2019-01-08 14:03:38.078799 Done
> $ ~/libexec/perf-core/scripts/python/exported-sql-viewer.py simple-retpoline.db
> 
> Before:
> 
>     main
>         -> __x86_indirect_thunk_rax
>             -> __x86_indirect_thunk_rax
>                 -> foo
>                     -> bar
> 
> After:
> 
>     main
>         -> foo
>             -> bar
> 

hi,
I still see them in kernel report.. after a while the output is shifted
too far right out of the screen due to (I guess) this call/ret imbalance


[root@krava perf]# ./perf-with-kcore record pt -e intel_pt/cyc/k -a -- sleep 1
[root@krava perf]# ./perf-with-kcore script pt --call-trace -C 0
            Xorg  2115 [000]  5850.032452321:  cbr: 36 freq: 3621 MHz (171%)
            Xorg  2115 [000]  5850.032452351: ([kernel.kallsyms])           __list_add_valid
            Xorg  2115 [000]  5850.032452380: ([kernel.kallsyms])           perf_pmu_enable.part.101
            Xorg  2115 [000]  5850.032452380: ([kernel.kallsyms])               __indirect_thunk_start
            Xorg  2115 [000]  5850.032452415: ([kernel.kallsyms])           __indirect_thunk_start
            Xorg  2115 [000]  5850.032452415: ([kernel.kallsyms])               __indirect_thunk_start
            Xorg  2115 [000]  5850.032452442: ([kernel.kallsyms])           __list_add_valid
            Xorg  2115 [000]  5850.032452457: ([kernel.kallsyms])           rb_next
            Xorg  2115 [000]  5850.032452494: ([kernel.kallsyms])           __x86_indirect_thunk_r12
            Xorg  2115 [000]  5850.032452494: ([kernel.kallsyms])               __x86_indirect_thunk_r12
            Xorg  2115 [000]  5850.032452535: ([kernel.kallsyms])                   group_sched_in
            Xorg  2115 [000]  5850.032452535: ([kernel.kallsyms])                       __indirect_thunk_start
            Xorg  2115 [000]  5850.032452535: ([kernel.kallsyms])                           __indirect_thunk_start
            Xorg  2115 [000]  5850.032452548: ([kernel.kallsyms])                       event_sched_in.isra.113
            Xorg  2115 [000]  5850.032452548: ([kernel.kallsyms])                           perf_event_set_state.part.70
            Xorg  2115 [000]  5850.032452548: ([kernel.kallsyms])                               perf_event_update_time
            Xorg  2115 [000]  5850.032452562: ([kernel.kallsyms])                           perf_log_itrace_start
            Xorg  2115 [000]  5850.032452562: ([kernel.kallsyms])                           __indirect_thunk_start
            Xorg  2115 [000]  5850.032452562: ([kernel.kallsyms])                               __indirect_thunk_start
            Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                   perf_event_update_userpage
            Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                       calc_timer_values
            Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                           sched_clock_cpu
            Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                               sched_clock
            Xorg  2115 [000]  5850.032452600: ([kernel.kallsyms])                                                   native_sched_clock
            Xorg  2115 [000]  5850.032452793: ([kernel.kallsyms])                                       __indirect_thunk_start
            Xorg  2115 [000]  5850.032452793: ([kernel.kallsyms])                                           __indirect_thunk_start
            Xorg  2115 [000]  5850.032452867: ([kernel.kallsyms])                                       arch_perf_update_userpage
            Xorg  2115 [000]  5850.032452867: ([kernel.kallsyms])                                           using_native_sched_clock
            Xorg  2115 [000]  5850.032452867: ([kernel.kallsyms])                                           sched_clock_stable
            Xorg  2115 [000]  5850.032452867: ([kernel.kallsyms])                                           cyc2ns_read_begin
            Xorg  2115 [000]  5850.032453157: ([kernel.kallsyms])                                           cyc2ns_read_end
            Xorg  2115 [000]  5850.032453194: ([kernel.kallsyms])                       __indirect_thunk_start
            Xorg  2115 [000]  5850.032453194: ([kernel.kallsyms])                           __indirect_thunk_start
            Xorg  2115 [000]  5850.032453206: ([kernel.kallsyms])                   __list_add_valid


jirka
