Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0967EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A172083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549448570;
	bh=nbDjTOJfpeqHX9ibHSMc8fTmADZOS4UiaCEGnSQz+a0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UhfSr2E95rg8rK+k1WQ5i7VMiafr3OlYHfxr4CzdQXgc6O6IFZZMordiE07/zCNMO
	 0qrAzbSuUYAZEqakXND8y6rf2U1UYWhtYcEtf9ZvmJfQXtPQHBsZob1bKgMFWGSWGf
	 LixIhKJ/YZzBJ3RZgn7sHkQOjHwnP4ViNGmKxXkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfBFKWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBFKWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:22:48 -0500
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C86218AE;
        Wed,  6 Feb 2019 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549448567;
        bh=nbDjTOJfpeqHX9ibHSMc8fTmADZOS4UiaCEGnSQz+a0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c48E7MMO8FSUXJFTGfb+HvPQPhndudfqofH2p4S1vaD25PsoohQmqUTIkpHAwsGFJ
         ifcZoSXk8j1HyNWTK07q22aMREEB+XFyTI/LjwuPui9S5zfYtpJmND5KlodFwTAtEI
         6M4906AyIXd+Fqg78TBR0VwJUkQBTpk4coEe5ir0=
Received: by mail-lf1-f45.google.com with SMTP id b20so4891749lfa.12;
        Wed, 06 Feb 2019 02:22:46 -0800 (PST)
X-Gm-Message-State: AHQUAubWt0sAIukrTapT43pgbYfRxXAQWJ344brB8+3eXOHdSh0QcAIn
        wS2xEgMRXaGMF35vKWRkdK0FD9VvqHxClBjpOXI=
X-Google-Smtp-Source: AHgI3Ibwg6kYNIFXGJ3hpuI/LAeSpbVQD0ZDReVubMA2AuLTiLRMc0v+SDJhL/6Se1lToU4p7+h4rYeIBdPr08eRiUU=
X-Received: by 2002:a19:4948:: with SMTP id l8mr6565339lfj.156.1549448564730;
 Wed, 06 Feb 2019 02:22:44 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
 <20190205211622.GA5891@kozik-lap> <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
 <20190206100549.GO3837@imbe.wolfsonmicro.main>
In-Reply-To: <20190206100549.GO3837@imbe.wolfsonmicro.main>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 6 Feb 2019 11:22:33 +0100
X-Gmail-Original-Message-ID: <CAJKOXPejBO_9iBHg1R8M2=tcuTck72DjxTYEUyQOp8cPV-0xTg@mail.gmail.com>
Message-ID: <CAJKOXPejBO_9iBHg1R8M2=tcuTck72DjxTYEUyQOp8cPV-0xTg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dapm: Check for NULL widget in dapm_update_dai_unlocked
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 at 11:05, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> DAIs linked to the dummy will not have an associated playback/capture
> widget, so we need to skip the update in that case.
>
> Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Ok so that all makes sense, this patch is probably the best fix?
>
> Thanks,
> Charles

For this particular issue (NULL-pointer):
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

However now I see bug sleeping in atomic context:

[   64.000828] BUG: sleeping function called from invalid context at
../kernel/locking/mutex.c:908
[   64.008483] in_atomic(): 1, irqs_disabled(): 128, pid: 353, name: aplay
[   64.014978] 2 locks held by aplay/353:
[   64.018671]  #0: 1fb9b63d (&(&group->lock)->rlock){....}, at:
snd_pcm_action_lock_irq+0x18/0x3c
[   64.027337]  #1: 8b42bfe8 (&(&pri_dai->spinlock)->rlock){....}, at:
i2s_trigger+0x130/0x6c8
[   64.035654] irq event stamp: 8754
[   64.038925] hardirqs last  enabled at (8753): [<c0a78758>]
_raw_spin_unlock_irq+0x24/0x5c
[   64.047094] hardirqs last disabled at (8754): [<c0a785a0>]
_raw_spin_lock_irq+0x18/0x50
[   64.055068] softirqs last  enabled at (8096): [<c0102698>]
__do_softirq+0x4f0/0x5e4
[   64.062680] softirqs last disabled at (8083): [<c012ee94>]
irq_exit+0x160/0x16c
[   64.069953] Preemption disabled at:
[   64.069956] [<00000000>]   (null)
[   64.076700] CPU: 6 PID: 353 Comm: aplay Not tainted
5.0.0-rc5-next-20190206-00001-g101ffa564f78 #348
[   64.085822] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   64.091882] [<c0112318>] (unwind_backtrace) from [<c010df2c>]
(show_stack+0x10/0x14)
[   64.099601] [<c010df2c>] (show_stack) from [<c0a5626c>]
(dump_stack+0x98/0xc4)
[   64.106788] [<c0a5626c>] (dump_stack) from [<c0156ac8>]
(___might_sleep+0x264/0x2cc)
[   64.114501] [<c0156ac8>] (___might_sleep) from [<c0a732b4>]
(__mutex_lock+0x40/0xa98)
[   64.122300] [<c0a732b4>] (__mutex_lock) from [<c0a73d28>]
(mutex_lock_nested+0x1c/0x24)
[   64.130275] [<c0a73d28>] (mutex_lock_nested) from [<c04c2838>]
(clk_prepare_lock+0x50/0xf8)
[   64.138596] [<c04c2838>] (clk_prepare_lock) from [<c04c5f48>]
(clk_core_get_rate+0xc/0x60)
[   64.146824] [<c04c5f48>] (clk_core_get_rate) from [<c07b419c>]
(i2s_trigger+0x444/0x6c8)
[   64.154883] [<c07b419c>] (i2s_trigger) from [<c079cba0>]
(soc_pcm_trigger+0x100/0x140)
[   64.162768] [<c079cba0>] (soc_pcm_trigger) from [<c07839c0>]
(snd_pcm_action_single+0x38/0x80)
[   64.171349] [<c07839c0>] (snd_pcm_action_single) from [<c0783a5c>]
(snd_pcm_action+0x54/0x5c)
[   64.179841] [<c0783a5c>] (snd_pcm_action) from [<c0783bd4>]
(snd_pcm_action_lock_irq+0x28/0x3c)
[   64.188508] [<c0783bd4>] (snd_pcm_action_lock_irq) from
[<c07860b0>] (snd_pcm_ioctl+0x920/0x123c)
[   64.197350] [<c07860b0>] (snd_pcm_ioctl) from [<c02aa6d4>]
(do_vfs_ioctl+0xb0/0x9f8)
[   64.205054] [<c02aa6d4>] (do_vfs_ioctl) from [<c02ab050>]
(ksys_ioctl+0x34/0x5c)
[   64.212418] [<c02ab050>] (ksys_ioctl) from [<c0101000>]
(ret_fast_syscall+0x0/0x28)
[   64.220045] Exception stack(0xe69dffa8 to 0xe69dfff0)
[   64.225058] ffa0:                   004391b8 00001770 00000004
00004142 00439340 00439340
[   64.233218] ffc0: 004391b8 00001770 00001770 00000036 00001770
00000000 00000000 be8db940
[   64.241361] ffe0: b6fa382c be8db8ec b6f32a3c b6e42bdc
[   64.246386]
[   64.247823] ======================================================
[   64.253979] WARNING: possible circular locking dependency detected
[   64.260133] 5.0.0-rc5-next-20190206-00001-g101ffa564f78 #348
Tainted: G        W
[   64.268193] ------------------------------------------------------
[   64.274342] aplay/353 is trying to acquire lock:
[   64.278937] 51044846 (prepare_lock){+.+.}, at: clk_prepare_lock+0x50/0xf8
[   64.285694]
[   64.285694] but task is already holding lock:
[   64.291500] 8b42bfe8 (&(&pri_dai->spinlock)->rlock){....}, at:
i2s_trigger+0x130/0x6c8
[   64.299387]
[   64.299387] which lock already depends on the new lock.
[   64.299387]
[   64.307534]
[   64.307534] the existing dependency chain (in reverse order) is:
[   64.314985]
[   64.314985] -> #1 (&(&pri_dai->spinlock)->rlock){....}:
[   64.321667]        clk_mux_set_parent+0x34/0xb8
[   64.326162]        clk_core_set_parent_nolock+0x21c/0x54c
[   64.331535]        clk_set_parent+0x38/0x6c
[   64.335696]        of_clk_set_defaults+0x11c/0x384
[   64.340460]        of_clk_add_provider+0x8c/0xc8
[   64.345054]        samsung_i2s_probe+0x484/0x64c
[   64.349651]        platform_drv_probe+0x6c/0xa4
[   64.354153]        really_probe+0x280/0x414
[   64.358311]        driver_probe_device+0x78/0x1c4
[   64.362991]        bus_for_each_drv+0x74/0xb8
[   64.367323]        __device_attach+0xd4/0x16c
[   64.371655]        bus_probe_device+0x88/0x90
[   64.375988]        deferred_probe_work_func+0x4c/0xd0
[   64.381017]        process_one_work+0x228/0x810
[   64.385520]        worker_thread+0x30/0x570
[   64.389681]        kthread+0x134/0x164
[   64.393405]        ret_from_fork+0x14/0x20
[   64.397477]          (null)
[   64.400249]
[   64.400249] -> #0 (prepare_lock){+.+.}:
[   64.405539]        __mutex_lock+0x7c/0xa98
[   64.409610]        mutex_lock_nested+0x1c/0x24
[   64.414029]        clk_prepare_lock+0x50/0xf8
[   64.418362]        clk_core_get_rate+0xc/0x60
[   64.422695]        i2s_trigger+0x444/0x6c8
[   64.426768]        soc_pcm_trigger+0x100/0x140
[   64.431188]        snd_pcm_action_single+0x38/0x80
[   64.435953]        snd_pcm_action+0x54/0x5c
[   64.440112]        snd_pcm_action_lock_irq+0x28/0x3c
[   64.445052]        snd_pcm_ioctl+0x920/0x123c
[   64.449386]        do_vfs_ioctl+0xb0/0x9f8
[   64.453457]        ksys_ioctl+0x34/0x5c
[   64.457269]        ret_fast_syscall+0x0/0x28
[   64.461516]        0xbe8db8ec
[   64.464460]
[   64.464460] other info that might help us debug this:
[   64.464460]
[   64.472438]  Possible unsafe locking scenario:
[   64.472438]
[   64.478327]        CPU0                    CPU1
[   64.482831]        ----                    ----
[   64.487336]   lock(&(&pri_dai->spinlock)->rlock);
[   64.492017]                                lock(prepare_lock);
[   64.497823]
lock(&(&pri_dai->spinlock)->rlock);
[   64.505017]   lock(prepare_lock);
[   64.508306]
[   64.508306]  *** DEADLOCK ***
[   64.508306]
[   64.514203] 2 locks held by aplay/353:
[   64.517935]  #0: 1fb9b63d (&(&group->lock)->rlock){....}, at:
snd_pcm_action_lock_irq+0x18/0x3c
[   64.526596]  #1: 8b42bfe8 (&(&pri_dai->spinlock)->rlock){....}, at:
i2s_trigger+0x130/0x6c8
[   64.534915]
[   64.534915] stack backtrace:
[   64.539246] CPU: 6 PID: 353 Comm: aplay Tainted: G        W
5.0.0-rc5-next-20190206-00001-g101ffa564f78 #348
[   64.549734] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   64.555802] [<c0112318>] (unwind_backtrace) from [<c010df2c>]
(show_stack+0x10/0x14)
[   64.563515] [<c010df2c>] (show_stack) from [<c0a5626c>]
(dump_stack+0x98/0xc4)
[   64.570708] [<c0a5626c>] (dump_stack) from [<c01846b0>]
(print_circular_bug+0x210/0x334)
[   64.578765] [<c01846b0>] (print_circular_bug) from [<c01874ec>]
(__lock_acquire+0x12cc/0x1a5c)
[   64.587344] [<c01874ec>] (__lock_acquire) from [<c01886d8>]
(lock_acquire+0xe0/0x268)
[   64.595142] [<c01886d8>] (lock_acquire) from [<c0a732f0>]
(__mutex_lock+0x7c/0xa98)
[   64.602768] [<c0a732f0>] (__mutex_lock) from [<c0a73d28>]
(mutex_lock_nested+0x1c/0x24)
[   64.610740] [<c0a73d28>] (mutex_lock_nested) from [<c04c2838>]
(clk_prepare_lock+0x50/0xf8)
[   64.619059] [<c04c2838>] (clk_prepare_lock) from [<c04c5f48>]
(clk_core_get_rate+0xc/0x60)
[   64.627291] [<c04c5f48>] (clk_core_get_rate) from [<c07b419c>]
(i2s_trigger+0x444/0x6c8)
[   64.635349] [<c07b419c>] (i2s_trigger) from [<c079cba0>]
(soc_pcm_trigger+0x100/0x140)
[   64.643235] [<c079cba0>] (soc_pcm_trigger) from [<c07839c0>]
(snd_pcm_action_single+0x38/0x80)
[   64.651815] [<c07839c0>] (snd_pcm_action_single) from [<c0783a5c>]
(snd_pcm_action+0x54/0x5c)
[   64.660306] [<c0783a5c>] (snd_pcm_action) from [<c0783bd4>]
(snd_pcm_action_lock_irq+0x28/0x3c)
[   64.668972] [<c0783bd4>] (snd_pcm_action_lock_irq) from
[<c07860b0>] (snd_pcm_ioctl+0x920/0x123c)
[   64.677811] [<c07860b0>] (snd_pcm_ioctl) from [<c02aa6d4>]
(do_vfs_ioctl+0xb0/0x9f8)
[   64.685522] [<c02aa6d4>] (do_vfs_ioctl) from [<c02ab050>]
(ksys_ioctl+0x34/0x5c)
[   64.692887] [<c02ab050>] (ksys_ioctl) from [<c0101000>]
(ret_fast_syscall+0x0/0x28)
[   64.700510] Exception stack(0xe69dffa8 to 0xe69dfff0)
[   64.705536] ffa0:                   004391b8 00001770 00000004
00004142 00439340 00439340
[   64.713684] ffc0: 004391b8 00001770 00001770 00000036 00001770
00000000 00000000 be8db940
[   64.721828] ffe0: b6fa382c be8db8ec b6f32a3c b6e42bdc


Best regards,
Krzysztof
