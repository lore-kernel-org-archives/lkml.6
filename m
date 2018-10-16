Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C2CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFA42147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="S0/t1+0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFA42147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJQHCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:02:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38951 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeJQHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:02:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so27458532wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ye1KyeFd6LL/hX/y6yUauOBoJc01+GbZRwYdi4eoiDw=;
        b=S0/t1+0X7A39fW11i5ciBLJxEYxJjlK8mk1VHx3+/rGn2j64lfdRZ27zXf/Xh5cA//
         XtFTKmDmXAleVGGA6bHAkMJ9xZAxVx+++zIpKDqxOFA1lRml5bkrwBNFAkMrB+w+oc4L
         +w1dslkedvr69IR2EXP0cQrBTU8PfhXwwtaLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ye1KyeFd6LL/hX/y6yUauOBoJc01+GbZRwYdi4eoiDw=;
        b=YniVoT2h9K+ODfOgARwMwyVy00XIuS32ZIdYaKH3pvrhYcGZPMiQp/KAne8wUBRl1d
         Qv4eF0HQ+wUWHYuUutXPM2FGWYxLoAjJGXgrMu+ty0eARqOrfXrcpi/ItUhuKSLYQxdI
         8bZXcRqXc5DUOTZobmpv9hJN3nfm2VZHYMvvAfC3K+ZES9eX3/XcEwbMsJp+RgqbYXkq
         EzacfMUNPuuqundIVwGiIewhkrwuCEY/+WFwyXtdHTL3Txid6C18BntbEsxklMf2Ob80
         xZGSBoG8YnPvmYgmylwV9H+TZL+msspnRysPUlA7OpMjb118pR4xj4GGxefOA2E647WH
         RbTg==
X-Gm-Message-State: ABuFfojlw+ysnoYHUsEIixsyqnnow9UO+cTCXLaRj9evJmCaoa89+su6
        G0sP8OrFXdcaLwb21fF5U31a7Q==
X-Google-Smtp-Source: ACcGV60urx4oOZNnQGBo2ulVnMcwCJLEjeer+Xc+L13R30XmrSuyA3EW0VmRbNut0xwCNMEzT8WTkg==
X-Received: by 2002:a5d:6692:: with SMTP id l18-v6mr22524296wru.154.1539731381498;
        Tue, 16 Oct 2018 16:09:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id n3-v6sm20499253wrr.62.2018.10.16.16.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 16:09:40 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:09:38 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Message-ID: <20181016230938.GA140578@joelaf.mtv.corp.google.com>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:08:25PM +0530, Sai Prakash Ranjan wrote:
> Hi,
> 
> On dragonboard 410c, with "ftrace=function" boot args, the console output
> slows down and board resets without any backtrace as below. This is tested
> on latest kernel and seems to exist even in older kernels as well.
> 
> [    2.949164] EINJ: ACPI disabled.
> [    3.133001] Serial: 8250/16550 dri
> Format: Log Type - Time(microsec) - Message - Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> 
> But with pstore enabled, able to get the below backtrace:
> <4>[    2.949164] EINJ: ACPI disabled.
> <6>[    3.133001] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> <6>[    3.164097] SuperH (H)SCI(F) driver initialized
> <0>[    3.164471] Internal error: synchronous external abort: 96000010 [#1]
> PREEMPT SMP
> <4>[    3.164479] Modules linked in:
> <4>[    3.164495] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
> 4.19.0-rc8-00008-ge033b9909fff-dirty #175
> <4>[    3.164501] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC
> (DT)
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
> 
> One more thing is for pstore dmesg-ramoops, I had to change late_initcall to
> postcore_initcall which brings the question as to why we changed to
> late_initcall?
> Simple git blame shows to support crypto compress api, but is it really
> helpful? A lot of boottime issues can be caught with pstore enabled at
> postcore_initcall rather than late_initcall, this backtrace
> is just one example. Is there any way we could change this?

Any chance you are able to dig deeper into the stack trace? I would
disassemble vmlinux and see which part of msm_read is generating the
synchronous external abort and look into that.

Also similar to what Steve suggested, I wonder if it boots for you if you
annotate all the functions in the serial driver with 'notrace'.

thanks,

 - Joel

