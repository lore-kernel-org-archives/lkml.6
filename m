Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F97ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC0620652
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC0620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeGQR0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:26:46 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:38804 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbeGQR0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:26:46 -0400
Received: by mail-qt0-f182.google.com with SMTP id y19-v6so1485449qto.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=9sTvIk2IUS6/g/UajNlsVnuVZZ2JcB0MWHE3C1Z4ChA=;
        b=HBtSD9aOG6TJuFmusRzEbEzC2QYBl6PWIAWuV7CtTuazBMOrviuuLldDs1Q/PEhq41
         vWOjjt7YDQ9/OPAnVet62QDKOpW+zxE0psTDiwu9LArcNDO/LdarWR/4szCbhmK9Mzy7
         BNotYPjtW2L6zunNb/vSwYJR8PC/MuNWqZ3iTNfI1AIYw60A6IVeyx1/NJ4a4Wa7/dl3
         ft4MyaGpL0W1zYI2N3Y9QuqZAfcix/YHWZ0qLsZSxZYV4OqpAMghtVesyeIcMk3Cfa5I
         lFzmvpQpuuaKQQ7m7GE1Rr9bBZ/ZGreoulfFo8L3NP2/gvqJFBJ4D/rOxflfeadTf1nG
         StGw==
X-Gm-Message-State: AOUpUlFLvF//adepLY/iZcqPzSpMbWGhxRLgSV/PtiRGlfGWk3dN55ip
        k1TghM4LuU+fFy1dXBAKyyeVrg==
X-Google-Smtp-Source: AAOMgpfDwxVoxRzzDR2YRBjPFHhWq/XgmZ3AVlKrSCRxZYYjF0R2RAnD6yB5gdxETsDJ3UUu8AMEaw==
X-Received: by 2002:a0c:b24c:: with SMTP id k12-v6mr2670934qve.152.1531846393412;
        Tue, 17 Jul 2018 09:53:13 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id r185-v6sm605571qkf.53.2018.07.17.09.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 09:53:12 -0700 (PDT)
Message-ID: <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Lukas Wunner <lukas@wunner.de>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>, linux-pm@vger.kernel.org
Date:   Tue, 17 Jul 2018 12:53:11 -0400
In-Reply-To: <20180717071641.GA5411@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
         <20180716235936.11268-2-lyude@redhat.com> <20180717071641.GA5411@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 09:16 +0200, Lukas Wunner wrote:
> [cc += linux-pm]
> 
> Hi Lyude,
> 
> First of all, thanks a lot for looking into this. 
> 
> On Mon, Jul 16, 2018 at 07:59:25PM -0400, Lyude Paul wrote:
> > In order to fix all of the spots that need to have runtime PM get/puts()
> > added, we need to ensure that it's possible for us to call
> > pm_runtime_get/put() in any context, regardless of how deep, since
> > almost all of the spots that are currently missing refs can potentially
> > get called in the runtime suspend/resume path. Otherwise, we'll try to
> > resume the GPU as we're trying to resume the GPU (and vice-versa) and
> > cause the kernel to deadlock.
> > 
> > With this, it should be safe to call the pm runtime functions in any
> > context in nouveau with one condition: any point in the driver that
> > calls pm_runtime_get*() cannot hold any locks owned by nouveau that
> > would be acquired anywhere inside nouveau_pmops_runtime_resume().
> > This includes modesetting locks, i2c bus locks, etc.
> 
> [snip]
> > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > @@ -835,6 +835,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
> >  		return -EBUSY;
> >  	}
> >  
> > +	dev->power.disable_depth++;
> > +
> 
> I'm not sure if that variable is actually private to the PM core.
> Grepping through the tree I only find a single occurrence where it's
> accessed outside the PM core and that's in amdgpu.  So this looks
> a little fishy TBH.  It may make sense to cc such patches to linux-pm
> to get Rafael & other folks involved with the PM core to comment.
> 
> Also, the disable_depth variable only exists if the kernel was
> compiled with CONFIG_PM enabled, but I can't find a "depends on PM"
> or something like that in nouveau's Kconfig.  Actually, if PM is
> not selected, all the nouveau_pmops_*() functions should be #ifdef'ed
> away, but oddly there's no #ifdef CONFIG_PM anywhere in nouveau_drm.c.
> 
> Anywayn, if I understand the commit message correctly, you're hitting a
> pm_runtime_get_sync() in a code path that itself is called during a
> pm_runtime_get_sync().  Could you include stack traces in the commit
> message?  My gut feeling is that this patch masks a deeper issue,
> e.g. if the runtime_resume code path does in fact directly poll outputs,
> that would seem wrong.  Runtime resume should merely make the card
> accessible, i.e. reinstate power if necessary, put into PCI_D0,
> restore registers, etc.  Output polling should be scheduled
> asynchronously.

Since it is apparently internal to the RPM core (I should go fix the references
to that which I added in amdgpu as well then, whoops...) I will have to figure
out another way to do this.

So: the reason that patch was added was mainly for the patches later in the
series that add guards around the i2c bus and aux bus, since both of those
require that the device be awake for it to work. Currently, the spot where it
would recurse is:

[   72.126859] nouveau 0000:01:00.0: DRM: suspending console...
[   72.127161] nouveau 0000:01:00.0: DRM: suspending display...
[  246.718589] INFO: task kworker/0:1:60 blocked for more than 120 seconds.
[  246.719254]       Tainted: G           O      4.18.0-rc5Lyude-Test+ #3
[  246.719411] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  246.719527] kworker/0:1     D    0    60      2 0x80000000
[  246.719636] Workqueue: pm pm_runtime_work
[  246.719772] Call Trace:
[  246.719874]  __schedule+0x322/0xaf0
[  246.722800]  schedule+0x33/0x90
[  246.724269]  rpm_resume+0x19c/0x850
[  246.725128]  ? finish_wait+0x90/0x90
[  246.725990]  __pm_runtime_resume+0x4e/0x90
[  246.726876]  nvkm_i2c_aux_acquire+0x39/0xc0 [nouveau]
[  246.727713]  nouveau_connector_aux_xfer+0x5c/0xd0 [nouveau]
[  246.728546]  drm_dp_dpcd_access+0x77/0x110 [drm_kms_helper]
[  246.729349]  drm_dp_dpcd_write+0x2b/0xb0 [drm_kms_helper]
[  246.730085]  drm_dp_mst_topology_mgr_suspend+0x4e/0x90 [drm_kms_helper]
[  246.730828]  nv50_display_fini+0xa5/0xc0 [nouveau]
[  246.731606]  nouveau_display_fini+0xc8/0x100 [nouveau]
[  246.732375]  nouveau_display_suspend+0x62/0x110 [nouveau]
[  246.733106]  nouveau_do_suspend+0x5e/0x2d0 [nouveau]
[  246.733839]  nouveau_pmops_runtime_suspend+0x4f/0xb0 [nouveau]
[  246.734585]  pci_pm_runtime_suspend+0x6b/0x190
[  246.735297]  ? pci_has_legacy_pm_support+0x70/0x70
[  246.736044]  __rpm_callback+0x7a/0x1d0
[  246.736742]  ? pci_has_legacy_pm_support+0x70/0x70
[  246.737467]  rpm_callback+0x24/0x80
[  246.738165]  ? pci_has_legacy_pm_support+0x70/0x70
[  246.738864]  rpm_suspend+0x142/0x6b0
[  246.739593]  pm_runtime_work+0x97/0xc0
[  246.740312]  process_one_work+0x231/0x620
[  246.741028]  worker_thread+0x44/0x3a0
[  246.741731]  kthread+0x12b/0x150
[  246.742439]  ? wq_pool_ids_show+0x140/0x140
[  246.743149]  ? kthread_create_worker_on_cpu+0x70/0x70
[  246.743846]  ret_from_fork+0x3a/0x50
[  246.744601] 
               Showing all locks held in the system:
[  246.746010] 4 locks held by kworker/0:1/60:
[  246.746757]  #0: 000000003bb334a6 ((wq_completion)"pm"){+.+.}, at:
process_one_work+0x1b3/0x620
[  246.747541]  #1: 000000002c55902b ((work_completion)(&dev-
>power.work)){+.+.}, at: process_one_work+0x1b3/0x620
[  246.748338]  #2: 000000002a39c817 (&mgr->lock){+.+.}, at:
drm_dp_mst_topology_mgr_suspend+0x33/0x90 [drm_kms_helper]
[  246.749120]  #3: 00000000b7d2f3c0 (&aux->hw_mutex){+.+.}, at:
drm_dp_dpcd_access+0x64/0x110 [drm_kms_helper]
[  246.749928] 1 lock held by khungtaskd/65:
[  246.750715]  #0: 00000000407da5ec (rcu_read_lock){....}, at:
debug_show_all_locks+0x23/0x185
[  246.751535] 1 lock held by dmesg/1122:
[  246.752328] 2 locks held by zsh/1149:
[  246.753100]  #0: 000000000a27c37b (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40
[  246.753901]  #1: 000000006cb043f7 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0xc1/0x870

[  246.755503] =============================================

[  246.757068] NMI backtrace for cpu 1
[  246.757858] CPU: 1 PID: 65 Comm: khungtaskd Tainted:
G           O      4.18.0-rc5Lyude-Test+ #3
[  246.758653] Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET78W (1.51
) 05/18/2018
[  246.759427] Call Trace:
[  246.760203]  dump_stack+0x8e/0xd3
[  246.760977]  nmi_cpu_backtrace.cold.3+0x14/0x5a
[  246.761729]  ? lapic_can_unplug_cpu.cold.27+0x42/0x42
[  246.762462]  nmi_trigger_cpumask_backtrace+0xa1/0xae
[  246.763183]  arch_trigger_cpumask_backtrace+0x19/0x20
[  246.763908]  watchdog+0x316/0x580
[  246.764644]  kthread+0x12b/0x150
[  246.765350]  ? reset_hung_task_detector+0x20/0x20
[  246.766052]  ? kthread_create_worker_on_cpu+0x70/0x70
[  246.766777]  ret_from_fork+0x3a/0x50
[  246.767488] Sending NMI from CPU 1 to CPUs 0,2-7:
[  246.768624] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x7f/0x120
[  246.768648] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x7f/0x120
[  246.768671] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x7f/0x120
[  246.768676] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x7f/0x120
[  246.768678] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x7f/0x120
[  246.768681] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x7f/0x120
[  246.768684] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x7f/0x120
[  246.769623] Kernel panic - not syncing: hung_task: blocked tasks

Suspending the MST topology at that point should be the right thing to do though
(and afaict, I don't -think- we reprobe connectors on resume by default), so I
definitely think we need some sort of way to have a RPM barrier here that
doesn't take effect in the suspend/resume path

> 
> Thanks,
> 
> Lukas
