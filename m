Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896DBECDFBD
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E0E20862
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyrr/XD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E0E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeGUKcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 06:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbeGUKcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 06:32:42 -0400
Received: from devnote (72.65.214.202.bf.2iij.net [202.214.65.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CD4206B7;
        Sat, 21 Jul 2018 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532166035;
        bh=iEqjLwngJWSxRtw+Iq8Qx7zIvNJp2cV30pexTA965Ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fyrr/XD7fpHq/ASCPXGhNLFEGfK1Lg9PhHLFQ6iL8SFsLAlWz+F8ZJKxya4my86qn
         RNuuERIMADXsUoHkMV5gH+NfgQFETMJFL3hc1TKu3sBFHVj2l/NNITP/cw4xPoHSBN
         KBiluAi2Ma11hDOxIsCcSknaBzxL9HkJXZTN7oYY=
Date:   Sat, 21 Jul 2018 18:40:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: Re: [lkp-robot] [tracing]  ecadccb31b:
 kernel_selftests.ftrace.ftracetest.fail
Message-Id: <20180721184032.01b1b6d70e0dd3b0f32aac95@kernel.org>
In-Reply-To: <20180721024113.GI12513@shao2-debian>
References: <20180721024113.GI12513@shao2-debian>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OK, I'll handle this.
The reason why this error is that kprobe event tests probe ftrace itself for test.


On Sat, 21 Jul 2018 10:41:13 +0800
kernel test robot <rong.a.chen@intel.com> wrote:

> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: ecadccb31b8f1516dd045cc64fc7bc7a2d72947f ("[PATCH 1/2] tracing: kprobes: Prohibit probing on notrace functions")
> url: https://github.com/0day-ci/linux/commits/Francis-Deslauriers/tracing-kprobes-Prohibit-probing-on-notrace-functions/20180714-072854
> 
> 
> in testcase: kernel_selftests
> with following parameters:
> 
> 	group: kselftests-01
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7.2-ecadccb31b8f1516dd045cc64fc7bc7a2d72947f
> 2018-07-18 22:17:02 ln -sf /usr/bin/clang-7 /usr/bin/clang
> 2018-07-18 22:17:02 ln -sf /usr/bin/llc-7 /usr/bin/llc
> 
> 2018-07-18 22:17:47 make run_tests -C ftrace
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-ecadccb31b8f1516dd045cc64fc7bc7a2d72947f/tools/testing/selftests/ftrace'
> TAP version 13
> selftests: ftrace: ftracetest
> ========================================
> === Ftrace unit tests ===
> [1] Basic trace file check	[PASS]
> [2] Basic test for tracers	[PASS]
> [3] Basic trace clock test	[PASS]
> [4] Basic event tracing check	[PASS]
> [5] event tracing - enable/disable with event level files	[PASS]
> [6] event tracing - restricts events based on pid	[PASS]
> [7] event tracing - enable/disable with subsystem level files	[PASS]
> [8] event tracing - enable/disable with top level files	[PASS]
> [9] ftrace - function graph filters with stack tracer	[PASS]
> [10] ftrace - function graph filters	[PASS]
> [11] ftrace - function glob filters	[PASS]
> [12] ftrace - function pid filters	[PASS]
> [13] ftrace - test for function event triggers	[PASS]
> [14] ftrace - function profiler with function tracing	[PASS]
> [15] ftrace - test reading of set_ftrace_filter	[PASS]
> [16] ftrace - test for function traceon/off triggers	[PASS]
> [17] Test creation and deletion of trace instances while setting an event	[PASS]
> [18] Test creation and deletion of trace instances	[PASS]
> [19] Kprobe dynamic event - adding and removing	[PASS]
> [20] Kprobe dynamic event - busy event check	[PASS]
> [21] Kprobe dynamic event with arguments	[PASS]
> [22] Kprobe event string type argument	[FAIL]
> [23] Kprobe event argument syntax	[PASS]
> [24] Kprobes event arguments with types	[PASS]
> [25] Kprobe event auto/manual naming	[PASS]
> [26] Kprobe dynamic event with function tracer	[PASS]
> [27] Kprobe dynamic event - probing module	[FAIL]
> [28] Kretprobe dynamic event with arguments	[PASS]
> [29] Kretprobe dynamic event with maxactive	[PASS]
> [30] Register/unregister many kprobe events	[PASS]
> [31] Kprobe events - probe points	[FAIL]
> [32] event trigger - test extended error support	[PASS]
> [33] event trigger - test field variable support	[PASS]
> [34] event trigger - test inter-event combined histogram trigger	[PASS]
> [35] event trigger - test multiple actions on hist trigger	[PASS]
> [36] event trigger - test inter-event histogram trigger onmatch action	[PASS]
> [37] event trigger - test inter-event histogram trigger onmatch-onmax action	[PASS]
> [38] event trigger - test inter-event histogram trigger onmax action	[PASS]
> [39] event trigger - test synthetic event create remove	[PASS]
> [40] event trigger - test event enable/disable trigger	[PASS]
> [41] event trigger - test trigger filter	[PASS]
> [42] event trigger - test histogram modifiers	[PASS]
> [43] event trigger - test histogram trigger	[PASS]
> [44] event trigger - test multiple histogram triggers	[PASS]
> [45] event trigger - test snapshot-trigger	[PASS]
> [46] event trigger - test stacktrace-trigger	[PASS]
> [47] trace_marker trigger - test histogram trigger	[PASS]
> [48] trace_marker trigger - test snapshot trigger	[PASS]
> [49] trace_marker trigger - test histogram with synthetic event against kernel event	[PASS]
> [50] trace_marker trigger - test histogram with synthetic event	[PASS]
> [51] event trigger - test traceon/off trigger	[PASS]
> [52] (instance)  Basic test for tracers	[PASS]
> [53] (instance)  Basic trace clock test	[PASS]
> [54] (instance)  event tracing - enable/disable with event level files	[PASS]
> [55] (instance)  event tracing - restricts events based on pid	[PASS]
> [56] (instance)  event tracing - enable/disable with subsystem level files	[PASS]
> [57] (instance)  ftrace - test for function event triggers	[PASS]
> [58] (instance)  ftrace - test for function traceon/off triggers	[PASS]
> [59] (instance)  event trigger - test event enable/disable trigger	[PASS]
> [60] (instance)  event trigger - test trigger filter	[PASS]
> [61] (instance)  event trigger - test histogram modifiers	[PASS]
> [62] (instance)  event trigger - test histogram trigger	[PASS]
> [63] (instance)  event trigger - test multiple histogram triggers	[PASS]
> [64] (instance)  trace_marker trigger - test histogram trigger	[PASS]
> [65] (instance)  trace_marker trigger - test snapshot trigger	[PASS]
> 
> # of passed:  62
> # of failed:  3
> # of unresolved:  0
> # of untested:  0
> # of unsupported:  0
> # of xfailed:  0
> # of undefined(test bug):  0
> not ok 1..1 selftests: ftrace: ftracetest [FAIL]
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-ecadccb31b8f1516dd045cc64fc7bc7a2d72947f/tools/testing/selftests/ftrace'
> 
> 
> to reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> thanks,
> rong, chen


-- 
Masami Hiramatsu <mhiramat@kernel.org>
