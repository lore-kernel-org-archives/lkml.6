Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4151C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E82208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E82208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754987AbeFNIxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:53:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41573 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754981AbeFNIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:53:37 -0400
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fTO0V-00050v-GP; Thu, 14 Jun 2018 10:53:27 +0200
Message-ID: <1528966400.21021.26.camel@pengutronix.de>
Subject: Re: [PATCH v4 0/7] add virt-dma support for imx-sdma
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        s.hauer@pengutronix.de, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     dmaengine@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 14 Jun 2018 10:53:20 +0200
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

I just gave this series a spin and it seems there is even more locking
fun, see the lockdep output below. After taking a short look it seems
this is caused by using the wrong spinlock variants in
sdma_int_handler(), those should also use the _irqsave ones. When
fixing this you might want to reconsider patch 7/7, as it's probably
not needed at all.

Regards,
Lucas

[   20.479401] ========================================================
[   20.485769] WARNING: possible irq lock inversion dependency detected
[   20.492140] 4.17.0+ #1538 Not tainted
[   20.495814] --------------------------------------------------------
[   20.502181] systemd/1 just changed the state of lock:
[   20.507247] c0abdafc (&(&substream->self_group.lock)->rlock){-...}, at: snd_pcm_stream_lock+0x54/0x60
[   20.516523] but this lock took another, HARDIRQ-unsafe lock in the past:
[   20.523234]  (fs_reclaim){+.+.}
[   20.523253] 
[   20.523253] 
[   20.523253] and interrupts could create inverse lock ordering between them.
[   20.523253] 
[   20.537804] 
[   20.537804] other info that might help us debug this:
[   20.544344]  Possible interrupt unsafe locking scenario:
[   20.544344] 
[   20.551144]        CPU0                    CPU1
[   20.555686]        ----                    ----
[   20.560224]   lock(fs_reclaim);
[   20.563386]                                local_irq_disable();
[   20.569315]                                lock(&(&substream->self_group.lock)->rlock);
[   20.577337]                                lock(fs_reclaim);
[   20.583014]   <Interrupt>
[   20.585643]     lock(&(&substream->self_group.lock)->rlock);
[   20.591322] 
[   20.591322]  *** DEADLOCK ***
[   20.591322] 
[   20.597260] 1 lock held by systemd/1:
[   20.607806]  #0: ab23d11c (snd_pcm_link_rwlock){.-..}, at: snd_pcm_stream_lock+0x4c/0x60
[   20.615951] 
[   20.615951] the shortest dependencies between 2nd lock and 1st lock:
[   20.623799]  -> (fs_reclaim){+.+.} ops: 248474 {
[   20.628456]     HARDIRQ-ON-W at:
[   20.631716]                       lock_acquire+0x260/0x29c
[   20.637223]                       fs_reclaim_acquire+0x48/0x58
[   20.643075]                       kmem_cache_alloc_trace+0x3c/0x364
[   20.649366]                       alloc_worker.constprop.15+0x28/0x64
[   20.655824]                       init_rescuer.part.5+0x20/0xa4
[   20.661764]                       workqueue_init+0x124/0x1f8
[   20.667446]                       kernel_init_freeable+0x60/0x550
[   20.673561]                       kernel_init+0x18/0x120
[   20.678890]                       ret_from_fork+0x14/0x20
[   20.684299]                         (null)
[   20.688408]     SOFTIRQ-ON-W at:
[   20.691659]                       lock_acquire+0x260/0x29c
[   20.697158]                       fs_reclaim_acquire+0x48/0x58
[   20.703006]                       kmem_cache_alloc_trace+0x3c/0x364
[   20.709288]                       alloc_worker.constprop.15+0x28/0x64
[   20.709301]                       init_rescuer.part.5+0x20/0xa4
[   20.720717]                       workqueue_init+0x124/0x1f8
[   20.720729]                       kernel_init_freeable+0x60/0x550
[   20.720738]                       kernel_init+0x18/0x120
[   20.720746]                       ret_from_fork+0x14/0x20
[   20.720751]                         (null)
[   20.720756]     INITIAL USE at:
[   20.720770]                      lock_acquire+0x260/0x29c
[   20.720782]                      fs_reclaim_acquire+0x48/0x58
[   20.774374]                      kmem_cache_alloc_trace+0x3c/0x364
[   20.780574]                      alloc_worker.constprop.15+0x28/0x64
[   20.786945]                      init_rescuer.part.5+0x20/0xa4
[   20.792794]                      workqueue_init+0x124/0x1f8
[   20.798384]                      kernel_init_freeable+0x60/0x550
[   20.804406]                      kernel_init+0x18/0x120
[   20.809648]                      ret_from_fork+0x14/0x20
[   20.814971]                        (null)
[   20.818992]   }
[   20.820768]   ... key      at: [<80e22074>] __fs_reclaim_map+0x0/0x10
[   20.827220]   ... acquired at:
[   20.830289]    fs_reclaim_acquire+0x48/0x58
[   20.834487]    kmem_cache_alloc_trace+0x3c/0x364
[   20.839123]    sdma_transfer_init+0x44/0x130
[   20.843409]    sdma_prep_dma_cyclic+0x78/0x21c
[   20.847869]    snd_dmaengine_pcm_trigger+0xdc/0x184
[   20.852764]    soc_pcm_trigger+0x164/0x190
[   20.856876]    snd_pcm_do_start+0x34/0x40
[   20.860902]    snd_pcm_action_single+0x48/0x74
[   20.865360]    snd_pcm_action+0x34/0xfc
[   20.869213]    snd_pcm_ioctl+0x910/0x10ec
[   20.873241]    vfs_ioctl+0x30/0x44
[   20.876657]    do_vfs_ioctl+0xac/0x974
[   20.880421]    ksys_ioctl+0x48/0x64
[   20.883923]    sys_ioctl+0x18/0x1c
[   20.887340]    ret_fast_syscall+0x0/0x28
[   20.891277]    0x7289bcbc
[   20.893909] 
[   20.895410] -> (&(&substream->self_group.lock)->rlock){-...} ops: 59 {
[   20.901977]    IN-HARDIRQ-W at:
[   20.905143]                     lock_acquire+0x260/0x29c
[   20.910473]                     _raw_spin_lock+0x48/0x58
[   20.915801]                     snd_pcm_stream_lock+0x54/0x60
[   20.921561]                     _snd_pcm_stream_lock_irqsave+0x40/0x48
[   20.928107]                     snd_pcm_period_elapsed+0x2c/0xa4
[   20.934127]                     dmaengine_pcm_dma_complete+0x54/0x58
[   20.940498]                     sdma_int_handler+0x1dc/0x2a8
[   20.946179]                     __handle_irq_event_percpu+0x1fc/0x498
[   20.952635]                     handle_irq_event_percpu+0x38/0x8c
[   20.958742]                     handle_irq_event+0x48/0x6c
[   20.964242]                     handle_fasteoi_irq+0xc4/0x138
[   20.970006]                     generic_handle_irq+0x28/0x38
[   20.975681]                     __handle_domain_irq+0xb0/0xc4
[   20.981443]                     gic_handle_irq+0x68/0xa0
[   20.986769]                     __irq_svc+0x70/0xb0
[   20.991662]                     _raw_spin_unlock_irq+0x38/0x6c
[   20.997511]                     task_work_run+0x90/0xb8
[   21.002751]                     do_work_pending+0xc8/0xd0
[   21.008164]                     slow_work_pending+0xc/0x20
[   21.013661]                     0x76c77e86
[   21.017768]    INITIAL USE at:
[   21.020844]                    lock_acquire+0x260/0x29c
[   21.026086]                    _raw_spin_lock+0x48/0x58
[   21.031328]                    snd_pcm_stream_lock+0x54/0x60
[   21.037002]                    snd_pcm_stream_lock_irq+0x38/0x3c
[   21.043023]                    snd_pcm_sync_ptr+0x214/0x260
[   21.048609]                    snd_pcm_ioctl+0xbe0/0x10ec
[   21.054027]                    vfs_ioctl+0x30/0x44
[   21.058832]                    do_vfs_ioctl+0xac/0x974
[   21.063984]                    ksys_ioctl+0x48/0x64
[   21.068875]                    sys_ioctl+0x18/0x1c
[   21.073679]                    ret_fast_syscall+0x0/0x28
[   21.079004]                    0x7e9026dc
[   21.083023]  }
[   21.084710]  ... key      at: [<8162a6e4>] __key.31798+0x0/0x8
[   21.090552]  ... acquired at:
[   21.093537]    mark_lock+0x3a4/0x69c
[   21.097128]    __lock_acquire+0x420/0x16d4
[   21.101239]    lock_acquire+0x260/0x29c
[   21.105091]    _raw_spin_lock+0x48/0x58
[   21.108940]    snd_pcm_stream_lock+0x54/0x60
[   21.113226]    _snd_pcm_stream_lock_irqsave+0x40/0x48
[   21.118296]    snd_pcm_period_elapsed+0x2c/0xa4
[   21.122841]    dmaengine_pcm_dma_complete+0x54/0x58
[   21.127735]    sdma_int_handler+0x1dc/0x2a8
[   21.131937]    __handle_irq_event_percpu+0x1fc/0x498
[   21.136915]    handle_irq_event_percpu+0x38/0x8c
[   21.141547]    handle_irq_event+0x48/0x6c
[   21.145570]    handle_fasteoi_irq+0xc4/0x138
[   21.149854]    generic_handle_irq+0x28/0x38
[   21.154052]    __handle_domain_irq+0xb0/0xc4
[   21.158335]    gic_handle_irq+0x68/0xa0
[   21.162184]    __irq_svc+0x70/0xb0
[   21.165601]    _raw_spin_unlock_irq+0x38/0x6c
[   21.169973]    task_work_run+0x90/0xb8
[   21.173735]    do_work_pending+0xc8/0xd0
[   21.177670]    slow_work_pending+0xc/0x20
[   21.181691]    0x76c77e86
[   21.184320] 
[   21.185821] 
[   21.185821] stack backtrace:
[   21.190198] CPU: 0 PID: 1 Comm: systemd Not tainted 4.17.0+ #1538
[   21.196303] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   21.202841] Backtrace: 
[   21.205314] [<8010e318>] (dump_backtrace) from [<8010e604>] (show_stack+0x20/0x24)
[   21.212900]  r7:80e9f3d0 r6:00000000 r5:60070193 r4:80e9f3d0
[   21.218581] [<8010e5e4>] (show_stack) from [<8099b660>] (dump_stack+0xa4/0xd8)
[   21.225825] [<8099b5bc>] (dump_stack) from [<8017b52c>] (print_irq_inversion_bug+0x15c/0x1fc)
[   21.234368]  r9:814da818 r8:00000001 r7:ee926c00 r6:00000000 r5:ee915bb0 r4:814da818
[   21.242133] [<8017b3d0>] (print_irq_inversion_bug) from [<8017b6dc>] (check_usage_forwards+0x110/0x13c)
[   21.251544]  r9:00000002 r8:80bfd3e2 r7:ee926c00 r6:ee927148 r5:80e08488 r4:00000001
[   21.259306] [<8017b5cc>] (check_usage_forwards) from [<8017c2a4>] (mark_lock+0x3a4/0x69c)
[   21.267500]  r9:ee926c00 r8:80a03cd8 r7:00000101 r6:00000002 r5:00000000 r4:ee927148
[   21.275263] [<8017bf00>] (mark_lock) from [<8017cf68>] (__lock_acquire+0x420/0x16d4)
[   21.283023]  r10:ee927148 r9:ed4620e4 r8:ee926c00 r7:00000000 r6:00000001 r5:00000001
[   21.290863]  r4:00000490
[   21.293416] [<8017cb48>] (__lock_acquire) from [<8017ed58>] (lock_acquire+0x260/0x29c)
[   21.301350]  r10:00000001 r9:80e084a4 r8:00000000 r7:00000000 r6:00000000 r5:ed4620e4
[   21.309189]  r4:00000000
[   21.311746] [<8017eaf8>] (lock_acquire) from [<809b74f0>] (_raw_spin_lock+0x48/0x58)
[   21.319506]  r10:ee0a4714 r9:ed457100 r8:ee0a46c8 r7:ee0a4714 r6:ee0a4010 r5:807847b0
[   21.327346]  r4:ed4620d4
[   21.329902] [<809b74a8>] (_raw_spin_lock) from [<807847b0>] (snd_pcm_stream_lock+0x54/0x60)
[   21.338265]  r5:ed462000 r4:ed462000
[   21.341863] [<8078475c>] (snd_pcm_stream_lock) from [<80784838>] (_snd_pcm_stream_lock_irqsave+0x40/0x48)
[   21.351440]  r5:ed462000 r4:60070193
[   21.355042] [<807847f8>] (_snd_pcm_stream_lock_irqsave) from [<8078b044>] (snd_pcm_period_elapsed+0x2c/0xa4)
[   21.364881]  r5:ee3ef000 r4:ed462000
[   21.368478] [<8078b018>] (snd_pcm_period_elapsed) from [<8078d7b4>] (dmaengine_pcm_dma_complete+0x54/0x58)
[   21.378148]  r7:ee0a4714 r6:ee0a4010 r5:00000007 r4:ee0a46bc
[   21.383827] [<8078d760>] (dmaengine_pcm_dma_complete) from [<80504c0c>] (sdma_int_handler+0x1dc/0x2a8)
[   21.393157] [<80504a30>] (sdma_int_handler) from [<8018cd28>] (__handle_irq_event_percpu+0x1fc/0x498)
[   21.402393]  r10:00000000 r9:eeafd400 r8:80e084a4 r7:00000038 r6:00000038 r5:80ea3c12
[   21.410233]  r4:ee2b5d40
[   21.412787] [<8018cb2c>] (__handle_irq_event_percpu) from [<8018cffc>] (handle_irq_event_percpu+0x38/0x8c)
[   21.422457]  r10:00000000 r9:ee914000 r8:ee81d400 r7:00000038 r6:eeafd400 r5:eeafd464
[   21.430296]  r4:80e08488
[   21.432852] [<8018cfc4>] (handle_irq_event_percpu) from [<8018d098>] (handle_irq_event+0x48/0x6c)
[   21.441736]  r6:eeafd464 r5:eeafd464 r4:eeafd400
[   21.446374] [<8018d050>] (handle_irq_event) from [<8019146c>] (handle_fasteoi_irq+0xc4/0x138)
[   21.454912]  r7:00000038 r6:eeafd464 r5:80e10a60 r4:eeafd400
[   21.460589] [<801913a8>] (handle_fasteoi_irq) from [<8018bd9c>] (generic_handle_irq+0x28/0x38)
[   21.469214]  r7:00000038 r6:80d92ae4 r5:00000000 r4:00000000
[   21.474893] [<8018bd74>] (generic_handle_irq) from [<8018c48c>] (__handle_domain_irq+0xb0/0xc4)
[   21.483611] [<8018c3dc>] (__handle_domain_irq) from [<80102330>] (gic_handle_irq+0x68/0xa0)
[   21.491978]  r9:ee914000 r8:f4001100 r7:80e5c6bc r6:ee915f00 r5:80e08c3c r4:f4000100
[   21.499738] [<801022c8>] (gic_handle_irq) from [<801019f0>] (__irq_svc+0x70/0xb0)
[   21.507233] Exception stack(0xee915f00 to 0xee915f48)
[   21.512303] 5f00: 00000001 00000004 00000000 ee926c00 ee9270a8 ee926c00 ecc45e00 ee9270a8
[   21.520498] 5f20: 80ec23b0 ee914000 00000000 ee915f64 ee915f20 ee915f50 8017c7c0 809b78ac
[   21.528687] 5f40: 20070013 ffffffff
[   21.532193]  r9:ee914000 r8:80ec23b0 r7:ee915f34 r6:ffffffff r5:20070013 r4:809b78ac
[   21.539959] [<809b7874>] (_raw_spin_unlock_irq) from [<8014e98c>] (task_work_run+0x90/0xb8)
[   21.548321]  r5:ee926c00 r4:ecc45e00
[   21.551913] [<8014e8fc>] (task_work_run) from [<8010da3c>] (do_work_pending+0xc8/0xd0)
[   21.559848]  r9:ee914000 r8:801011c4 r7:ee915fb0 r6:ffffe000 r5:00000004 r4:801011c4
[   21.567608] [<8010d974>] (do_work_pending) from [<80101034>] (slow_work_pending+0xc/0x20)
[   21.575797] Exception stack(0xee915fb0 to 0xee915ff8)
[   21.580864] 5fa0:                                     00000000 020c34e8 46059f00 00000000
[   21.589059] 5fc0: 00000002 76f133a4 020df680 00000006 76e6e168 00000035 7ef81778 00000035
[   21.597253] 5fe0: 00000006 7ef816a0 76c75d67 76c77e86 20070030 00000039
[   21.603883]  r7:00000006 r6:020df680 r5:76f133a4 r4:00000002

Am Donnerstag, den 14.06.2018, 22:02 +0800 schrieb Robin Gong:
> The legacy sdma driver has below limitations or drawbacks:
>   1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
>      one page size for one channel regardless of only few BDs needed
>      most time. But in few cases, the max PAGE_SIZE maybe not enough.
>   2. One SDMA channel can't stop immediatley once channel disabled which
>      means SDMA interrupt may come in after this channel terminated.There
>      are some patches for this corner case such as commit "2746e2c389f9",
>      but not cover non-cyclic.
> 
> The common virt-dma overcomes the above limitations. It can alloc bd
> dynamically and free bd once this tx transfer done. No memory wasted or
> maximum limititation here, only depends on how many memory can be requested
> from kernel. For No.2, such issue can be workaround by checking if there
> is available descript("sdmac->desc") now once the unwanted interrupt
> coming. At last the common virt-dma is easier for sdma driver maintain.
> 
> Change from v3:
>   1. add two uart patches which impacted by this patchset.
>   2. unlock 'vc.lock' before cyclic dma callback and lock again after
>      it because some driver such as uart will call dmaengine_tx_status
>      which will acquire 'vc.lock' again and dead lock comes out.
>   3. remove 'Revert commit' stuff since that patch is not wrong and
>      combine two patch into one patch as Sascha's comment.
> 
> Change from v2:
>   1. include Sascha's patch to make the main patch easier to review.
>      Thanks Sacha.
>   2. remove useless 'desc'/'chan' in struct sdma_channe.
> 
> Change from v1:
>   1. split v1 patch into 5 patches.
>   2. remove some unnecessary condition check.
>   3. remove unnecessary 'pending' list.
> 
> Robin Gong (6):
>   tty: serial: imx: correct dma cookie status
>   dmaengine: imx-sdma: add virt-dma support
>   dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct
>     sdma_channel'
>   dmaengine: imx-sdma: remove the maximum limitation for bd numbers
>   dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
>   tty: serial: imx: split all dma setup operations out of 'port.lock'
>     protector
> 
> Sascha Hauer (1):
>   dmaengine: imx-sdma: factor out a struct sdma_desc from struct
>     sdma_channel
> 
>  drivers/dma/Kconfig      |   1 +
>  drivers/dma/imx-sdma.c   | 394 +++++++++++++++++++++++++++--------------------
>  drivers/tty/serial/imx.c |  99 ++++++------
>  3 files changed, 282 insertions(+), 212 deletions(-)
> 
