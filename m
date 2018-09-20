Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF98ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A962150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A962150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbeITXuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:50:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:43655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732757AbeITXuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:50:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 11:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258940398"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 11:05:42 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 89924301A93; Thu, 20 Sep 2018 11:05:42 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Make perf script easier to use for itrace
Date:   Thu, 20 Sep 2018 11:05:35 -0700
Message-Id: <20180920180540.14039-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a range of improvements to make it easier to look
at itrace traces with perf script. Nothing here couldn't be done
before with some additional scripting, but add simple high 
level options to make it easier to use.

% perf record -e intel_pt//k -a sleep 1

Show function calls:

% perf script --call-trace
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])          perf_pmu_enable
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])          __x86_indirect_thunk_rax
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])          event_filter_match
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage
    
Show function calls and returns:

% perf script --call-ret-trace
                perf   900 [000] 194167.205652203:   tr strt     ([unknown])        pt_config
                perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            pt_config
                perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            pt_event_add
                perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            perf_pmu_enable
                perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            perf_pmu_nop_void
                perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            event_sched_in.isra.107
                perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            __x86_indirect_thunk_rax
                perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            perf_pmu_nop_int
                perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            group_sched_in
                perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            event_filter_match
                perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            event_filter_match
                perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            group_sched_in


Show instruction traces (using XED):

  % perf script --insn-trace --xed
       swapper     0 [000] 117276.429606186:  ffffffff81010486 pt_config ([kernel.kallsyms])          nopl  %eax, (%rax,%rax,1)
       swapper     0 [000] 117276.429606186:  ffffffff8101048b pt_config ([kernel.kallsyms])          add $0x10, %rsp
       swapper     0 [000] 117276.429606186:  ffffffff8101048f pt_config ([kernel.kallsyms])          popq  %rbx
       swapper     0 [000] 117276.429606186:  ffffffff81010490 pt_config ([kernel.kallsyms])          popq  %rbp
       swapper     0 [000] 117276.429606186:  ffffffff81010491 pt_config ([kernel.kallsyms])          popq  %r12
       swapper     0 [000] 117276.429606186:  ffffffff81010493 pt_config ([kernel.kallsyms])          popq  %r13
       swapper     0 [000] 117276.429606186:  ffffffff81010495 pt_config ([kernel.kallsyms])          popq  %r14
       swapper     0 [000] 117276.429606186:  ffffffff81010497 pt_config ([kernel.kallsyms])          popq  %r15
       swapper     0 [000] 117276.429606186:  ffffffff81010499 pt_config ([kernel.kallsyms])          retq


Filter by a ftrace style graph function:

 % perf script --graph-function group_sched_in --call-trace
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          calc_timer_values
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_cpu
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          arch_perf_update_userpage
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              __fentry__
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              using_native_sched_clock
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_stable
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_enable
                perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax


Also available in
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git pt/easy-script-7

v1: Initial post
v2: Address review comments. Minor fixes to descriptions. Now builds everywhere.
v3: Merge wildcard+remove addr/sym patch for one logical review unit.
Drop typed remove patch
Fix build failure on ARM ETM builds.
Fix git branch number.
v4: Remove debug printout.
Really fix ETM build failure (Kim Phillips)
v5: Split out --xed into separate option to handle other architectures better,
and support brstackinsn too. Add total cycles printing for brstackinsn
v6: Document xed build. Change code formatting for one patch.


