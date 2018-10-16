Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC7C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF57208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF57208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJPXUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbeJPXUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:20:30 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00537208B3;
        Tue, 16 Oct 2018 15:29:29 +0000 (UTC)
Date:   Tue, 16 Oct 2018 11:29:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Message-ID: <20181016112928.4b52afb5@gandalf.local.home>
In-Reply-To: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 17:08:25 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> Hi,
> 
> On dragonboard 410c, with "ftrace=function" boot args, the console 
> output slows down and board resets without any backtrace as below. This 
> is tested on latest kernel and seems to exist even in older kernels as well.

So this only happens when ftrace=function is on the boot console.


> 
> [    2.949164] EINJ: ACPI disabled.
> [    3.133001] Serial: 8250/16550 dri
> Format: Log Type - Time(microsec) - Message - Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> 
> But with pstore enabled, able to get the below backtrace:
> 
> <4>[    2.949164] EINJ: ACPI disabled.
> <6>[    3.133001] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> <6>[    3.164097] SuperH (H)SCI(F) driver initialized
> <0>[    3.164471] Internal error: synchronous external abort: 96000010 
> [#1] PREEMPT SMP
> <4>[    3.164479] Modules linked in:
> <4>[    3.164495] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 
> 4.19.0-rc8-00008-ge033b9909fff-dirty #175
> <4>[    3.164501] Hardware name: Qualcomm Technologies, Inc. APQ 8016 
> SBC (DT)
> <4>[    3.164508] pstate: 40000085 (nZcv daIf -PAN -UAO)
> <4>[    3.164514] pc : msm_read.isra.2+0x20/0x50
> <4>[    3.164520] lr : msm_read.isra.2+0x1c/0x50
> <4>[    3.164526] sp : ffff000008033a50
> <4>[    3.164531] x29: ffff000008033a50 x28: ffff000009486018
> <4>[    3.164548] x27: 0000000000000001 x26: ffff7dfffe7ff070
> <4>[    3.164565] x25: 0000000000000034 x24: ffff000009486000
> <4>[    3.164582] x23: 0000000000000000 x22: ffff00000978e190
> <4>[    3.164599] x21: ffff0000095e8228 x20: 0000000000000034
> <4>[    3.164616] x19: ffff7dfffe7ff008 x18: ffffffffffffffff
> <4>[    3.164632] x17: 0000000000000000 x16: 0000000000000000
> <4>[    3.164649] x15: ffff0000094a96c8 x14: ffff00008978e6bf
> <4>[    3.164666] x13: ffff00000978e6cd x12: 0000000000000038
> <4>[    3.164683] x11: ffff0000094c6000 x10: 0000000000000c24
> <4>[    3.164699] x9 : ffff80003c89b400 x8 : ffff000008033970
> <4>[    3.164716] x7 : ffff80000eb04100 x6 : 00000000000af304
> <4>[    3.164732] x5 : 0000000000000c40 x4 : ffff80003c06f000
> <4>[    3.164750] x3 : ffff80003c89b498 x2 : 0000000000000000
> <4>[    3.164766] x1 : ffff80003ca68000 x0 : 0000000000000800
> <0>[    3.164785] Process swapper/0 (pid: 1, stack limit = 
> 0x(____ptrval____))
> <4>[    3.164791] Call trace:
> <4>[    3.164797]  msm_read.isra.2+0x20/0x50
> <4>[    3.164804]  msm_reset_dm_count+0x44/0x80
> <4>[    3.164810]  __msm_console_write+0x1c8/0x1d0
> <4>[    3.164816]  msm_serial_early_write_dm+0x3c/0x50
> <4>[    3.164823]  console_unlock.part.6+0x468/0x528
> <4>[    3.164829]  vprintk_emit+0x210/0x218
> <4>[    3.164835]  vprintk_default+0x48/0x58
> <4>[    3.164841]  vprintk_func+0xf0/0x1c0
> <4>[    3.164847]  printk+0x74/0x94
> <4>[    3.164853]  sci_init+0x24/0x3c
> <4>[    3.164859]  do_one_initcall+0x54/0x248
> <4>[    3.164866]  kernel_init_freeable+0x210/0x378
> <4>[    3.164872]  kernel_init+0x18/0x118
> <4>[    3.164878]  ret_from_fork+0x10/0x1c
> <0>[    3.164884] Code: aa1e03e0 8b214273 97e616f7 d503201f (b9400260)
> 
> Seems to be issue with the msm serial driver and not ftrace.
> Could someone look into it.

I'm guessing that there may have been an issue with ftrace, it tried to
print, but the printing caused a bug that rebooted the box.

Does function tracing work after boot up? That is, without the
ftrace=function, can you do:

 echo function > /sys/kernel/debug/tracing/current_tracer

without any issue?

> 
> One more thing is for pstore dmesg-ramoops, I had to change 
> late_initcall to postcore_initcall which brings the question as to why 
> we changed to late_initcall?
> Simple git blame shows to support crypto compress api, but is it really 
> helpful? A lot of boottime issues can be caught with pstore enabled at 
> postcore_initcall rather than late_initcall, this backtrace
> is just one example. Is there any way we could change this?

Does it break if the crypto is not initialized? Perhaps add a command
line flag to have it happen earlier:

 ramoops=earlyinit

and add a postcore_initcall that checks if that flag is set, and if so,
it does the work then, and the late_initcall() will do nothing.

That way, you can still have unmodified kernels use pstore when it
crashes at boot up.

-- Steve
