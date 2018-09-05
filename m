Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FFDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D02075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHemRwG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195D02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeIESQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:16:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43632 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIESQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:16:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id h64-v6so6027836lfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4yUG8UvS6aDIE9rdEmcMRCnl6AqXP64eyLFScbgJNpQ=;
        b=FHemRwG6ZIpKA6WdswK2+Dazccr+pYc3RFic9BEIcDd4ADd/iJKlru+hUEvl4XSZH3
         C41S7mR9C2dI9ll6t392zsUWIHVlmB84AKqG3z9VpWsHAYq4EwMpwcjBTaOoCU0oBCex
         1JjN3VGG2bkkqrcdL7iD7W1Muf9vbsiDvLnAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4yUG8UvS6aDIE9rdEmcMRCnl6AqXP64eyLFScbgJNpQ=;
        b=GIF5GI6y5ScPkrv83in424kigKfP5Eu4EfxLCpJkdxX62efJFci21LbVqiFV7Mpw34
         LBfBQ3ZNS3zITYhpuvbj0VG0tteP+/wr8OhhWSDOMpr1L4j23XdjI6gBJ/NCGK56jrmm
         IoJsiloLMWUQVuZG26TZo7qMo5gRirN8fQofOO+qcfKxsmYhj1k6Ov+OdfZmSEOjDG1T
         ft5FRxd/lj53cSKMDFCMIf1AN0PYBv9C1bBA5prwD8P1LbXVRqQ8MFi0CrvdsL+kXFOo
         GmUz9789Z+FSWdM5tBxW1KVthp8b3xRdHLxkzAucvb8ZivJdbfkQI1kHuCA7U7k+XWoX
         NOAQ==
X-Gm-Message-State: APzg51BeaI8EHUs+k08+7eF/QaYMe3cq9lxrIIjv/FtkvWi/Rmyeh8pv
        MxneT75EYcOjkvyrgintVInE6Q==
X-Google-Smtp-Source: ANB0VdbkYtbp/Z/KfMbQ56uTd+TkeMhbleqUsnmx/QAZ9cI0CA9aj8mTmJHEozMSsrmcCrscPJ2VfA==
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr12485931lfa.139.1536155155464;
        Wed, 05 Sep 2018 06:45:55 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id y23-v6sm326650lfk.43.2018.09.05.06.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 06:45:54 -0700 (PDT)
Date:   Wed, 5 Sep 2018 15:45:53 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: stop_machine() soft lockup
Message-ID: <20180905134553.GB5345@centauri.lan>
References: <20180904190322.GA21835@centauri.lan>
 <20180905084241.GS24082@hirez.programming.kicks-ass.net>
 <20180905114749.GA5345@centauri.lan>
 <20180905131410.GY24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905131410.GY24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 03:14:10PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 05, 2018 at 01:47:49PM +0200, Niklas Cassel wrote:
> > On Wed, Sep 05, 2018 at 10:42:41AM +0200, Peter Zijlstra wrote:
> > > On Tue, Sep 04, 2018 at 09:03:22PM +0200, Niklas Cassel wrote:
> > > > Hello Peter,
> > > >
> > > > I'm seeing some lockups when booting linux-next on a db820c arm64 board.
> > > > I've tried to analyze, but I'm currently stuck.
> > >
> > > Please see (should be in your Inbox too):
> > >
> > >   https://lkml.kernel.org/r/20180905084158.GR24124@hirez.programming.kicks-ass.net
> >
> > I'm sorry if I mislead you by replying to your other mail thread,
> > both of them have timekeeping_notify() in the call trace,
> > but my problem has this call trace:
> >
> > [  128.747853]  wait_for_common+0xe0/0x1a0
> > [  128.752023]  wait_for_completionx+0x28/0x38
> > [  128.755677]  __stop_cpus+0xd4/0xf8
> > [  128.759837]  stop_cpus+0x70/0xa8
> > [  128.762958]  stop_machine_cpuslocked+0x124/0x130
> > [  128.766345]  stop_machine+0x54/0x70
> > [  128.771373]  timekeeping_notify+0x44/0x70
> > [  128.774158]  __clocksource_select+0xa8/0x1d8
> > [  128.778605]  clocksource_done_booting+0x4c/0x64
> > [  128.782931]  do_one_initcall+0x94/0x3f8
> > [  128.786921]  kernel_init_freeable+0x47c/0x528
> > [  128.790742]  kernel_init+0x18/0x110
> > [  128.795673]  ret_from_fork+0x10/0x1c
> >
> >
> > while your other mail thread has this call trace:
> >
> > * stop_machine()
> > * timekeeping_notify()
> > * __clocksource_select()
> > * clocksource_select()
> > * clocksource_watchdog_work()
> >
> >
> > So my problem is not related to the watchdog, I tried your revert anyway,
> > but unfortunately my problem persists.
>
> Oh, right, missed that distinction. And this is new?

I can reproduce it on 4.14.15 so probably not that new.

>
> I'll try and have a look. Lockdep doesn't suggest anything?

Thanks.

Usually, when seeing these soft lockups, no.

However, I just managed to get this lockdep splat when booting without
earlycon and ftrace=irqsoff
I'm not sure that it is related, but I'm planning on looking into it anyway:

[   70.644248] Bluetooth: hci0: QCA Failed to request file: qca/rampatch_00440302.bin (-11)
[   70.644299] Bluetooth: hci0: QCA Failed to download patch (-11)
[   70.644475] cfg80211: failed to load regulatory.db
[   70.658037] remoteproc remoteproc0: powering up adsp-pil
[   70.663080] remoteproc remoteproc0: Direct firmware load for adsp.mdt failed with error -2
[   70.667438]
[   70.667445] ======================================================
[   70.667450] WARNING: possible circular locking dependency detected
[   70.667459] 4.19.0-rc2-next-20180904-00002-gd2e5ea917660-dirty #44 Tainted: G        W
[   70.667464] ------------------------------------------------------
[   70.667471] kworker/0:1/14 is trying to acquire lock:
[   70.667478] (____ptrval____) (&(&pool->lock)->rlock){-.-.}, at: __queue_work+0x3d4/0x6a0
[   70.667512]
[   70.667512] but task is already holding lock:
[   70.667517] (____ptrval____) (&port_lock_key){-.-.}, at: msm_uart_irq+0x38/0x710
[   70.667545]
[   70.667545] which lock already depends on the new lock.
[   70.667545]
[   70.667550]
[   70.667550] the existing dependency chain (in reverse order) is:
[   70.667555]
[   70.667555] -> #2 (&port_lock_key){-.-.}:
[   70.667585]        _raw_spin_lock+0x44/0x58
[   70.667591]        __msm_console_write+0x84/0x1e8
[   70.667598]        msm_console_write+0x64/0x78
[   70.667608]        console_unlock+0x400/0x610
[   70.667615]        register_console+0x290/0x3b8
[   70.667622]        uart_add_one_port+0x4cc/0x4d8
[   70.667628]        msm_serial_probe+0x158/0x1d8
[   70.667639]        platform_drv_probe+0x58/0xa8
[   70.667645]        really_probe+0x280/0x3d8
[   70.667651]        driver_probe_device+0x60/0x148
[   70.667658]        __driver_attach+0x144/0x148
[   70.667665]        bus_for_each_dev+0x84/0xd8
[   70.667671]        driver_attach+0x30/0x40
[   70.667677]        bus_add_driver+0x234/0x2a8
[   70.667684]        driver_register+0x64/0x110
[   70.667691]        __platform_driver_register+0x54/0x60
[   70.667700]        msm_serial_init+0x40/0x70
[   70.667709]        do_one_initcall+0x94/0x3f8
[   70.667717]        kernel_init_freeable+0x47c/0x528
[   70.667726]        kernel_init+0x18/0x110
[   70.667732]        ret_from_fork+0x10/0x1c
[   70.667737]
[   70.667737]
[   70.667737] -> #1 (console_owner){-.-.}:
[   70.667762]        console_unlock+0x298/0x610
[   70.667769]        vprintk_emit+0x110/0x298
[   70.667776]        vprintk_default+0x48/0x58
[   70.667782]        vprintk_func+0x100/0x200
[   70.667789]        printk+0x74/0x94
[   70.667797]        __warn_printk+0x48/0xa0
[   70.667803]        check_flush_dependency+0xf8/0x150
[   70.667809]        __flush_work+0xc0/0x2e0
[   70.667815]        __cancel_work_timer+0x154/0x1c8
[   70.667821]        cancel_delayed_work_sync+0x24/0x30
[   70.667832]        ufshcd_ungate_work+0x30/0x100
[   70.667838]        process_one_work+0x2a0/0x710
[   70.667844]        worker_thread+0x48/0x478
[   70.667852]        kthread+0x134/0x138
[   70.667858]        ret_from_fork+0x10/0x1c
[   70.667863]
[   70.667863] -> #0 (&(&pool->lock)->rlock){-.-.}:
[   70.667890]        lock_acquire+0xc0/0x230
[   70.667897]        _raw_spin_lock+0x44/0x58
[   70.667903]        __queue_work+0x3d4/0x6a0
[   70.667909]        queue_work_on+0xc8/0xd0
[   70.667920]        hci_uart_tx_wakeup+0x188/0x228
[   70.667926]        hci_uart_write_wakeup+0x70/0x78
[   70.667933]        ttyport_write_wakeup+0xdc/0xe8
[   70.667940]        tty_port_tty_wakeup+0x28/0x38
[   70.667946]        uart_write_wakeup+0x24/0x38
[   70.667952]        msm_handle_tx_pio+0x94/0x1d0
[   70.667958]        msm_handle_tx+0x10c/0x3c0
[   70.667964]        msm_uart_irq+0x310/0x710
[   70.667972]        __handle_irq_event_percpu+0xb8/0x440
[   70.667978]        handle_irq_event_percpu+0x40/0x98
[   70.667983]        handle_irq_event+0x50/0x80
[   70.667990]        handle_fasteoi_irq+0xc8/0x1a0
[   70.667998]        generic_handle_irq+0x34/0x50
[   70.668004]        __handle_domain_irq+0x8c/0xf8
[   70.668010]        gic_handle_irq+0x84/0x180
[   70.668016]        el1_irq+0xec/0x198
[   70.668022]        console_unlock+0x4e0/0x610
[   70.668029]        vprintk_emit+0x110/0x298
[   70.668036]        dev_vprintk_emit+0x150/0x248
[   70.668042]        dev_printk_emit+0x84/0xa8
[   70.668048]        __dev_printk+0x5c/0xa0
[   70.668054]        _dev_warn+0x74/0x98
[   70.668062]        _request_firmware+0x428/0x5d8
[   70.668068]        request_firmware+0x40/0x50
[   70.668076]        rproc_boot+0xfc/0x480
[   70.668081]        rproc_auto_boot_callback+0x24/0x38
[   70.668087]        request_firmware_work_func+0x50/0x88
[   70.668094]        process_one_work+0x2a0/0x710
[   70.668100]        worker_thread+0x48/0x478
[   70.668106]        kthread+0x134/0x138
[   70.668113]        ret_from_fork+0x10/0x1c
[   70.668118]
[   70.668124] Chain exists of:
[   70.668124]   &(&pool->lock)->rlock --> console_owner --> &port_lock_key
[   70.668124]
[   70.668155]  Possible unsafe locking scenario:
[   70.668155]
[   70.668160]        CPU0                    CPU1
[   70.668164]        ----                    ----
[   70.668169]   lock(&port_lock_key);
[   70.668182]                                lock(console_owner);
[   70.668195]                                lock(&port_lock_key);
[   70.668209]   lock(&(&pool->lock)->rlock);
[   70.668222]
[   70.668222]  *** DEADLOCK ***
[   70.668222]
[   70.668229] 6 locks held by kworker/0:1/14:
[   70.668234]  #0: (____ptrval____) ((wq_completion)"events"){+.+.}, at: process_one_work+0x1f8/0x710
[   70.668263]  #1: (____ptrval____) ((work_completion)(&fw_work->work)){+.+.}, at: process_one_work+0x1f8
/0x710
[   70.668293]  #2: (____ptrval____) (&rproc->lock){+.+.}, at: rproc_boot+0x4c/0x480
[   70.668322]  #3: (____ptrval____) (console_lock){+.+.}, at: vprintk_emit+0x108/0x298
[   70.668351]  #4: (____ptrval____) (&port_lock_key){-.-.}, at: msm_uart_irq+0x38/0x710
[   70.668379]  #5: (____ptrval____) (&hu->proto_lock){.+.+}, at: hci_uart_write_wakeup+0x70/0x78
[   70.668409]
[   70.668409] stack backtrace:
[   70.668418] CPU: 0 PID: 14 Comm: kworker/0:1 Tainted: G        W         4.19.0-rc2-next-20180904-00002
-gd2e5ea917660-dirty #44
[   70.668423] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
[   70.668435] Workqueue: events request_firmware_work_func
[   70.668446] Call trace:
[   70.668454]  dump_backtrace+0x0/0x200
[   70.668460]  show_stack+0x24/0x30
[   70.668469]  dump_stack+0xac/0xe4
[   70.668476]  print_circular_bug.isra.19+0x1d4/0x2e8
[   70.668482]  __lock_acquire+0x1814/0x1878
[   70.668489]  lock_acquire+0xc0/0x230
[   70.668495]  _raw_spin_lock+0x44/0x58
[   70.668501]  __queue_work+0x3d4/0x6a0
[   70.668507]  queue_work_on+0xc8/0xd0
[   70.668514]  hci_uart_tx_wakeup+0x188/0x228
[   70.668520]  hci_uart_write_wakeup+0x70/0x78
[   70.668527]  ttyport_write_wakeup+0xdc/0xe8
[   70.668533]  tty_port_tty_wakeup+0x28/0x38
[   70.668539]  uart_write_wakeup+0x24/0x38
[   70.668544]  msm_handle_tx_pio+0x94/0x1d0
[   70.668550]  msm_handle_tx+0x10c/0x3c0
[   70.668557]  msm_uart_irq+0x310/0x710
[   70.668563]  __handle_irq_event_percpu+0xb8/0x440
[   70.668568]  handle_irq_event_percpu+0x40/0x98
[   70.668574]  handle_irq_event+0x50/0x80
[   70.668581]  handle_fasteoi_irq+0xc8/0x1a0
[   70.668588]  generic_handle_irq+0x34/0x50
[   70.668594]  __handle_domain_irq+0x8c/0xf8
[   70.668599]  gic_handle_irq+0x84/0x180
[   70.668606]  el1_irq+0xec/0x198
[   70.668612]  console_unlock+0x4e0/0x610
[   70.668619]  vprintk_emit+0x110/0x298
[   70.668625]  dev_vprintk_emit+0x150/0x248
[   70.668631]  dev_printk_emit+0x84/0xa8
[   70.668637]  __dev_printk+0x5c/0xa0
[   70.668643]  _dev_warn+0x74/0x98
[   70.668649]  _request_firmware+0x428/0x5d8
[   70.668656]  request_firmware+0x40/0x50
[   70.668662]  rproc_boot+0xfc/0x480
[   70.668668]  rproc_auto_boot_callback+0x24/0x38
[   70.668674]  request_firmware_work_func+0x50/0x88
[   70.668680]  process_one_work+0x2a0/0x710
[   70.668686]  worker_thread+0x48/0x478
[   70.668693]  kthread+0x134/0x138
[   70.668699]  ret_from_fork+0x10/0x1c


Kind regards,
Niklas
