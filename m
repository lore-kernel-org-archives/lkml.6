Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B76C5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A15320645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IVlLEOzy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PejJz19s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A15320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJQCRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:17:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:17:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7E1661311; Tue, 16 Oct 2018 18:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539714328;
        bh=7dSahrdFGS5I+riZm8EC75n1owYlV8/x/BKWqYouB8o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IVlLEOzyRB/7SvovdCwVpLcJco5nEdNyZ8p/PuI3+HQHV1gYxAMJTQPcjos7aere4
         O5ZcUtUhWI1yId7VvOPdjaPCbbCWcWMxnBhJuPRqfx894orltVLY8je5rbGfBIU+eB
         EHmscibyNgdIgq9RohA02j2m0Hvoi+9LRb81Gj6A=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CCB260769;
        Tue, 16 Oct 2018 18:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539714326;
        bh=7dSahrdFGS5I+riZm8EC75n1owYlV8/x/BKWqYouB8o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PejJz19sRaz02B4Hu+4xsNZfYAHt17MGdRz3s5ZXDuj/X95A6ejYkYyAJY10hgQgs
         9B0Op6oVNEPtg+S3/X5unUpEivCNXz2DwbytBKEFqcnUhk6xyAZvfI1Un1hyL8cO+5
         CLXulbKdbHHe2Oz45j/tmxBGFxNPP1eHHLlcgYqA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CCB260769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
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
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
 <20181016125721.236ada82@gandalf.local.home>
 <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
 <20181016134803.1b9260c1@gandalf.local.home>
 <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
Date:   Tue, 16 Oct 2018 23:55:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016141610.639b9000@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 11:46 PM, Steven Rostedt wrote:
> 
> [ Removed ivan.ivanov@linaro.org due to getting mail delivery errors ]
> 
> On Tue, 16 Oct 2018 23:35:00 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> Ok got it, this sounds fun. I'll give it a try.
> 
> Awesome, I'm looking forward to seeing what you come up with.
> 

Now, I can trigger this crash reboot with "ftrace=function 
ftrace_filter=f*,g*,h*,i*,j*,k*,l*,m*,n*,o*,p*,q*"

And pstore dmesg log gives slightly different backtrace than 
before(i.e., uart_add_one_port+0x374/0x4c8):

<4>[    1.976945] EINJ: ACPI disabled.
<6>[    2.070011] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
<6>[    2.087353] SuperH (H)SCI(F) driver initialized
<6>[    2.093708] msm_serial 78af000.serial: msm_serial: detected port #1
<6>[    2.093901] msm_serial 78af000.serial: uartclk = 19200000
<6>[    2.099078] 78af000.serial: ttyMSM1 at MMIO 0x78af000 (irq = 9, 
base_baud = 1200000) is a MSM
<6>[    2.108386] msm_serial 78b0000.serial: msm_serial: detected port #0
<6>[    2.113076] msm_serial 78b0000.serial: uartclk = 7372800
<6>[    2.119300] 78b0000.serial: ttyMSM0 at MMIO 0x78b0000 (irq = 10, 
base_baud = 460800) is a MSM
<0>[    2.119769] Internal error: synchronous external abort: 96000010 
[#1] PREEMPT SMP
<4>[    2.119772] Modules linked in:
<4>[    2.119780] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.19.0-rc8-00008-ge033b9909fff-dirty #2
<4>[    2.119785] Hardware name: Qualcomm Technologies, Inc. APQ 8016 
SBC (DT)
<4>[    2.119789] pstate: 40000085 (nZcv daIf -PAN -UAO)
<4>[    2.119792] pc : msm_read.isra.2+0x20/0x50
<4>[    2.119796] lr : msm_read.isra.2+0x1c/0x50
<4>[    2.119799] sp : ffff000008033760
<4>[    2.119802] x29: ffff000008033760 x28: ffff000009486018
<4>[    2.119809] x27: 0000000000000001 x26: ffff7dfffe7ff070
<4>[    2.119816] x25: 0000000000000062 x24: ffff000009486000
<4>[    2.119824] x23: 0000000000000000 x22: ffff00000978e190
<4>[    2.119831] x21: ffff0000095e8228 x20: 0000000000000062
<4>[    2.119838] x19: ffff7dfffe7ff008 x18: ffffffffffffffff
<4>[    2.119845] x17: 0000000000000000 x16: 0000000000000000
<4>[    2.119852] x15: ffff0000094a96c8 x14: 3d20647561625f65
<4>[    2.119859] x13: 736162202c303120 x12: 3d20717269282030
<4>[    2.119866] x11: 3030306238377830 x10: 0000000000000134
<4>[    2.119874] x9 : ffff80003c356400 x8 : ffff000008033680
<4>[    2.119881] x7 : ffff80003c354100 x6 : 00000000000d9b72
<4>[    2.119888] x5 : 0000000000000150 x4 : ffff80003bc8f000
<4>[    2.119895] x3 : ffff80003c356498 x2 : 0000000000000000
<4>[    2.119902] x1 : ffff80003bf10000 x0 : 0000000000000800
<0>[    2.119911] Process swapper/0 (pid: 1, stack limit = 
0x(____ptrval____))
<4>[    2.119914] Call trace:
<4>[    2.119917]  msm_read.isra.2+0x20/0x50
<4>[    2.119920]  msm_reset_dm_count+0x44/0x80
<4>[    2.119924]  __msm_console_write+0x1c8/0x1d0
<4>[    2.119928]  msm_serial_early_write_dm+0x3c/0x50
<4>[    2.119931]  console_unlock.part.6+0x468/0x528
<4>[    2.119935]  vprintk_emit+0x210/0x218
<4>[    2.119938]  vprintk_default+0x48/0x58
<4>[    2.119942]  vprintk_func+0xf0/0x1c0
<4>[    2.119945]  printk+0x74/0x94
<4>[    2.119949]  uart_add_one_port+0x374/0x4c8
<4>[    2.119952]  msm_serial_probe+0x140/0x1c8
<4>[    2.119955]  platform_drv_probe+0x58/0xb0
<4>[    2.119959]  really_probe+0x1f4/0x3c8
<4>[    2.119963]  driver_probe_device+0x12c/0x150
<4>[    2.119966]  __driver_attach+0x144/0x148
<4>[    2.119969]  bus_for_each_dev+0x78/0xe0
<4>[    2.119973]  driver_attach+0x30/0x40
<4>[    2.119976]  bus_add_driver+0x1c8/0x2a8
<4>[    2.119979]  driver_register+0x68/0x118
<4>[    2.119983]  __platform_driver_register+0x54/0x60
<4>[    2.119987]  msm_serial_init+0x40/0x70
<4>[    2.119990]  do_one_initcall+0x54/0x248
<4>[    2.119993]  kernel_init_freeable+0x210/0x378
<4>[    2.119997]  kernel_init+0x18/0x118
<4>[    2.120000]  ret_from_fork+0x10/0x1c
<0>[    2.120004] Code: aa1e03e0 8b214273 97e61727 d503201f (b9400260)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
