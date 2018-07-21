Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12115ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91CD20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91CD20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeGUUcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:32:36 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50931 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbeGUUcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:32:35 -0400
Received: from [192.168.0.7] (ip5f5bd28c.dynamic.kabel-deutschland.de [95.91.210.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 108CC2012BA067;
        Sat, 21 Jul 2018 21:38:42 +0200 (CEST)
Subject: Re: UBSAN: Undefined behaviour in arch/x86/events/amd/ibs.c:582:24:
 member access within null pointer of type 'struct perf_event'
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
References: <eb1d1d7d-7ca6-677d-2ae5-911935706516@molgen.mpg.de>
 <alpine.DEB.2.21.1807200958390.1580@nanos.tec.linutronix.de>
From:   Paul Menzel <pmenzel+linux-x86@molgen.mpg.de>
Message-ID: <7934cc44-3658-123c-bfe2-3e58624b19b6@molgen.mpg.de>
Date:   Sat, 21 Jul 2018 21:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807200958390.1580@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas,


Am 20.07.2018 um 10:39 schrieb Thomas Gleixner:

> On Fri, 20 Jul 2018, Paul Menzel wrote:
>> Enabling the undefined behavior sanitizer and building GNU/Linux 4.18-rc5+
>> (with some unrelated commits) with GCC 8.1.0 from Debian Sid/unstable, the
>> warning below is shown.
>>
>>> [    2.111913]
>>> ================================================================================
>>> [    2.111917] UBSAN: Undefined behaviour in
>>> arch/x86/events/amd/ibs.c:582:24
>>> [    2.111919] member access within null pointer of type 'struct perf_event'
>>> [    2.111926] CPU: 0 PID: 144 Comm: udevadm Not tainted
>>> 4.18.0-rc5-00316-g4864b68cedf2 #104
>>> [    2.111928] Hardware name: ASROCK E350M1/E350M1, BIOS TIMELESS 01/01/1970
>>> [    2.111930] Call Trace:
>>> [    2.111943]  dump_stack+0x55/0x89
>>> [    2.111949]  ubsan_epilogue+0xb/0x33
>>> [    2.111953]  handle_null_ptr_deref+0x7f/0x90
>>> [    2.111958]  __ubsan_handle_type_mismatch_v1+0x55/0x60
>>> [    2.111964]  perf_ibs_handle_irq+0x596/0x620
> 
> Right, the code dereferences event before checking the STARTED bit. Patch
> below should cure the issue. The warning should not trigger, if I analyzed
> the thing correctly. Emphasis on *should*

> 8<--------------------
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 4b98101209a1..d50bb4dc0650 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -579,7 +579,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>   {
>   	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
>   	struct perf_event *event = pcpu->event;
> -	struct hw_perf_event *hwc = &event->hw;
> +	struct hw_perf_event *hwc;
>   	struct perf_sample_data data;
>   	struct perf_raw_record raw;
>   	struct pt_regs regs;
> @@ -602,6 +602,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>   		return 0;
>   	}
>   
> +	if (WARN_ON_ONCE(!event))
> +		goto fail;
> +
> +	hwc = &event->hw;
>   	msr = hwc->config_base;
>   	buf = ibs_data.regs;
>   	rdmsrl(msr, *buf);

Thank you very much. The warning is gone after applying it.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
