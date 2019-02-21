Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4115BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3132084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfBUPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:38:02 -0500
Received: from www62.your-server.de ([213.133.104.62]:38864 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:38:01 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwqQB-0007cS-UB; Thu, 21 Feb 2019 16:37:59 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwqQB-0003zP-KT; Thu, 21 Feb 2019 16:37:59 +0100
Subject: Re: [PATCH] bpf: test_bpf: turn of preemption in function __run_once
To:     Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190221084425.9574-1-anders.roxell@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c93b8a98-f76f-7c45-817a-0cd334273306@iogearbox.net>
Date:   Thu, 21 Feb 2019 16:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190221084425.9574-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25367/Thu Feb 21 14:02:13 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2019 09:44 AM, Anders Roxell wrote:
> When running test seccomp_bpf the following splat occurs:
> 
> [ RUN      ] global.secseccomp_bpf.c:2136:global.detect_seccomp_filter_flags:Expected 22 (22) == (*__errno_location ()) (14)
> seccomp_bpf.c:2138:global.detect_seccomp_filter_flags:Failed to detect that an unknown
>   filter flag (0x8) is unsupported! Does a new flag need to be added to this test?
> [ 2155.677841] BUG: assuming atomic context at kernel/seccomp.c:271
> [ 2155.689351] in_atomic(): 0, irqs_disabled(): 0, pid: 28540, name: seccomp_bpf
> [ 2155.696597] INFO: lockdep is turned off.
> [ 2155.700605] CPU: 5 PID: 28540 Comm: seccomp_bpf Tainted: G        W         5.0.0-rc7-next-20190220 #1
> [ 2155.709972] Hardware name: HiKey Development Board (DT)
> [ 2155.715232] Call trace:
> [ 2155.717710]  dump_backtrace+0x0/0x160
> [ 2155.721399]  show_stack+0x24/0x30
> [ 2155.724742]  dump_stack+0xc8/0x114
> [ 2155.728172]  __cant_sleep+0xf0/0x108
> [ 2155.731777]  __seccomp_filter+0x8c/0x5c8
> [ 2155.735727]  __secure_computing+0x4c/0xe8
> [ 2155.739767]  syscall_trace_enter+0xf8/0x2b8
> [ 2155.743982]  el0_svc_common+0xf0/0x130
> [ 2155.747758]  el0_svc_handler+0x38/0x78
> [ 2155.751534]  el0_svc+0x8/0xc
> 
> Rework so that preemption is disabled when we loop over function
> 'BPF_PROG_RUN(...)'.
> Commit 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
> highlighted the issue.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Hmm, wrong commit description? Below code is not related to seccomp
but rather BPF test suite. Could you fix it up and resubmit? Rest
looks okay to me.

> ---
>  lib/test_bpf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index f3e570722a7e..0845f635f404 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -6668,12 +6668,14 @@ static int __run_one(const struct bpf_prog *fp, const void *data,
>  	u64 start, finish;
>  	int ret = 0, i;
>  
> +	preempt_disable();
>  	start = ktime_get_ns();
>  
>  	for (i = 0; i < runs; i++)
>  		ret = BPF_PROG_RUN(fp, data);
>  
>  	finish = ktime_get_ns();
> +	preempt_enable();
>  
>  	*duration = finish - start;
>  	do_div(*duration, runs);
> 

