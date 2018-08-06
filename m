Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17ACC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCCE21A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCCE21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbeHFVjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:39:40 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44774 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbeHFVjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:39:40 -0400
Received: by mail-yb0-f196.google.com with SMTP id l16-v6so5722778ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0r/z2K7DxU//mOtoQH8uPwL/KbEjYKjifu8burZlIzE=;
        b=AO0r7hG4mIf7Nu/wJ5osWxzPz2VHuKLWJhXekO0u4VfZnr9e0qGmHiSRxYm3VPLE17
         oO0IwKDDeCeX/lBQnCPNmRflauc4bGXXSF4e9MBdPPk5jnL+KW0Rfv8tTyF/3+xnmagG
         MXf18VUPsyLba/kf42UlabPmcapqiD2bpH/kMylHhzbJBShzgIqTBue7xu41CNasDmq2
         uJqx7CGlaGcydrKAPSqB3xI3srzoGOWCbiX6bakJ7xrN1UHBrvMZFDUA1gfG75Rg+n9c
         c235VJx21q5WGeJnoGFJcPfWjCso3zGdpbHdShDiwhi3KH8Wle4tGMG+ruvVNGuegbs4
         VwBg==
X-Gm-Message-State: AOUpUlGhSauzFyslzIR8bdDaSYXG+0EvurDErBbM1DLPcrROuAStGdAj
        DMJvG690EWElOh337IocNDLMLg==
X-Google-Smtp-Source: AAOMgpdNqEt65rE1BER0Cmcted7IXHGqrYvRASpVOcElJMHEqJVIdzA6vYuwvUjyaXUKADbOg1hv+Q==
X-Received: by 2002:a25:ab01:: with SMTP id u1-v6mr8561472ybi.280.1533583747114;
        Mon, 06 Aug 2018 12:29:07 -0700 (PDT)
Received: from malachite ([172.56.22.98])
        by smtp.gmail.com with ESMTPSA id j8-v6sm7587296ywj.6.2018.08.06.12.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 12:29:06 -0700 (PDT)
Message-ID: <e2c9ee61a615477d31756f30d185025caed5ad2b.camel@redhat.com>
Subject: Re: [PATCH v4 7/8] drm/nouveau: Fix deadlocks in
 nouveau_connector_detect()
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Karol Herbst <karolherbst@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
Date:   Mon, 06 Aug 2018 15:29:04 -0400
In-Reply-To: <20180806091517.GL3008@phenom.ffwll.local>
References: <20180801211459.7731-1-lyude@redhat.com>
         <20180801211459.7731-8-lyude@redhat.com>
         <20180806091517.GL3008@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 11:15 +0200, Daniel Vetter wrote:
> On Wed, Aug 01, 2018 at 05:14:57PM -0400, Lyude Paul wrote:
> > When we disable hotplugging on the GPU, we need to be able to
> > synchronize with each connector's hotplug interrupt handler before the
> > interrupt is finally disabled. This can be a problem however, since
> > nouveau_connector_detect() currently grabs a runtime power reference
> > when handling connector probing. This will deadlock the runtime suspend
> > handler like so:
> > 
> > [  861.480896] INFO: task kworker/0:2:61 blocked for more than 120
> > seconds.
> > [  861.483290]       Tainted: G           O      4.18.0-rc6Lyude-Test+ #1
> > [  861.485158] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  861.486332] kworker/0:2     D    0    61      2 0x80000000
> > [  861.487044] Workqueue: events nouveau_display_hpd_work [nouveau]
> > [  861.487737] Call Trace:
> > [  861.488394]  __schedule+0x322/0xaf0
> > [  861.489070]  schedule+0x33/0x90
> > [  861.489744]  rpm_resume+0x19c/0x850
> > [  861.490392]  ? finish_wait+0x90/0x90
> > [  861.491068]  __pm_runtime_resume+0x4e/0x90
> > [  861.491753]  nouveau_display_hpd_work+0x22/0x60 [nouveau]
> > [  861.492416]  process_one_work+0x231/0x620
> > [  861.493068]  worker_thread+0x44/0x3a0
> > [  861.493722]  kthread+0x12b/0x150
> > [  861.494342]  ? wq_pool_ids_show+0x140/0x140
> > [  861.494991]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [  861.495648]  ret_from_fork+0x3a/0x50
> > [  861.496304] INFO: task kworker/6:2:320 blocked for more than 120
> > seconds.
> > [  861.496968]       Tainted: G           O      4.18.0-rc6Lyude-Test+ #1
> > [  861.497654] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  861.498341] kworker/6:2     D    0   320      2 0x80000080
> > [  861.499045] Workqueue: pm pm_runtime_work
> > [  861.499739] Call Trace:
> > [  861.500428]  __schedule+0x322/0xaf0
> > [  861.501134]  ? wait_for_completion+0x104/0x190
> > [  861.501851]  schedule+0x33/0x90
> > [  861.502564]  schedule_timeout+0x3a5/0x590
> > [  861.503284]  ? mark_held_locks+0x58/0x80
> > [  861.503988]  ? _raw_spin_unlock_irq+0x2c/0x40
> > [  861.504710]  ? wait_for_completion+0x104/0x190
> > [  861.505417]  ? trace_hardirqs_on_caller+0xf4/0x190
> > [  861.506136]  ? wait_for_completion+0x104/0x190
> > [  861.506845]  wait_for_completion+0x12c/0x190
> > [  861.507555]  ? wake_up_q+0x80/0x80
> > [  861.508268]  flush_work+0x1c9/0x280
> > [  861.508990]  ? flush_workqueue_prep_pwqs+0x1b0/0x1b0
> > [  861.509735]  nvif_notify_put+0xb1/0xc0 [nouveau]
> > [  861.510482]  nouveau_display_fini+0xbd/0x170 [nouveau]
> > [  861.511241]  nouveau_display_suspend+0x67/0x120 [nouveau]
> > [  861.511969]  nouveau_do_suspend+0x5e/0x2d0 [nouveau]
> > [  861.512715]  nouveau_pmops_runtime_suspend+0x47/0xb0 [nouveau]
> > [  861.513435]  pci_pm_runtime_suspend+0x6b/0x180
> > [  861.514165]  ? pci_has_legacy_pm_support+0x70/0x70
> > [  861.514897]  __rpm_callback+0x7a/0x1d0
> > [  861.515618]  ? pci_has_legacy_pm_support+0x70/0x70
> > [  861.516313]  rpm_callback+0x24/0x80
> > [  861.517027]  ? pci_has_legacy_pm_support+0x70/0x70
> > [  861.517741]  rpm_suspend+0x142/0x6b0
> > [  861.518449]  pm_runtime_work+0x97/0xc0
> > [  861.519144]  process_one_work+0x231/0x620
> > [  861.519831]  worker_thread+0x44/0x3a0
> > [  861.520522]  kthread+0x12b/0x150
> > [  861.521220]  ? wq_pool_ids_show+0x140/0x140
> > [  861.521925]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [  861.522622]  ret_from_fork+0x3a/0x50
> > [  861.523299] INFO: task kworker/6:0:1329 blocked for more than 120
> > seconds.
> > [  861.523977]       Tainted: G           O      4.18.0-rc6Lyude-Test+ #1
> > [  861.524644] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  861.525349] kworker/6:0     D    0  1329      2 0x80000000
> > [  861.526073] Workqueue: events nvif_notify_work [nouveau]
> > [  861.526751] Call Trace:
> > [  861.527411]  __schedule+0x322/0xaf0
> > [  861.528089]  schedule+0x33/0x90
> > [  861.528758]  rpm_resume+0x19c/0x850
> > [  861.529399]  ? finish_wait+0x90/0x90
> > [  861.530073]  __pm_runtime_resume+0x4e/0x90
> > [  861.530798]  nouveau_connector_detect+0x7e/0x510 [nouveau]
> > [  861.531459]  ? ww_mutex_lock+0x47/0x80
> > [  861.532097]  ? ww_mutex_lock+0x47/0x80
> > [  861.532819]  ? drm_modeset_lock+0x88/0x130 [drm]
> > [  861.533481]  drm_helper_probe_detect_ctx+0xa0/0x100 [drm_kms_helper]
> > [  861.534127]  drm_helper_hpd_irq_event+0xa4/0x120 [drm_kms_helper]
> > [  861.534940]  nouveau_connector_hotplug+0x98/0x120 [nouveau]
> > [  861.535556]  nvif_notify_work+0x2d/0xb0 [nouveau]
> > [  861.536221]  process_one_work+0x231/0x620
> > [  861.536994]  worker_thread+0x44/0x3a0
> > [  861.537757]  kthread+0x12b/0x150
> > [  861.538463]  ? wq_pool_ids_show+0x140/0x140
> > [  861.539102]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [  861.539815]  ret_from_fork+0x3a/0x50
> > [  861.540521]
> >                Showing all locks held in the system:
> > [  861.541696] 2 locks held by kworker/0:2/61:
> > [  861.542406]  #0: 000000002dbf8af5 ((wq_completion)"events"){+.+.}, at:
> > process_one_work+0x1b3/0x620
> > [  861.543071]  #1: 0000000076868126 ((work_completion)(&drm-
> > >hpd_work)){+.+.}, at: process_one_work+0x1b3/0x620
> > [  861.543814] 1 lock held by khungtaskd/64:
> > [  861.544535]  #0: 0000000059db4b53 (rcu_read_lock){....}, at:
> > debug_show_all_locks+0x23/0x185
> > [  861.545160] 3 locks held by kworker/6:2/320:
> > [  861.545896]  #0: 00000000d9e1bc59 ((wq_completion)"pm"){+.+.}, at:
> > process_one_work+0x1b3/0x620
> > [  861.546702]  #1: 00000000c9f92d84 ((work_completion)(&dev-
> > >power.work)){+.+.}, at: process_one_work+0x1b3/0x620
> > [  861.547443]  #2: 000000004afc5de1 (drm_connector_list_iter){.+.+}, at:
> > nouveau_display_fini+0x96/0x170 [nouveau]
> > [  861.548146] 1 lock held by dmesg/983:
> > [  861.548889] 2 locks held by zsh/1250:
> > [  861.549605]  #0: 00000000348e3cf6 (&tty->ldisc_sem){++++}, at:
> > ldsem_down_read+0x37/0x40
> > [  861.550393]  #1: 000000007009a7a8 (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0xc1/0x870
> > [  861.551122] 6 locks held by kworker/6:0/1329:
> > [  861.551957]  #0: 000000002dbf8af5 ((wq_completion)"events"){+.+.}, at:
> > process_one_work+0x1b3/0x620
> > [  861.552765]  #1: 00000000ddb499ad ((work_completion)(&notify-
> > >work)#2){+.+.}, at: process_one_work+0x1b3/0x620
> > [  861.553582]  #2: 000000006e013cbe (&dev->mode_config.mutex){+.+.}, at:
> > drm_helper_hpd_irq_event+0x6c/0x120 [drm_kms_helper]
> > [  861.554357]  #3: 000000004afc5de1 (drm_connector_list_iter){.+.+}, at:
> > drm_helper_hpd_irq_event+0x78/0x120 [drm_kms_helper]
> > [  861.555227]  #4: 0000000044f294d9 (crtc_ww_class_acquire){+.+.}, at:
> > drm_helper_probe_detect_ctx+0x3d/0x100 [drm_kms_helper]
> > [  861.556133]  #5: 00000000db193642 (crtc_ww_class_mutex){+.+.}, at:
> > drm_modeset_lock+0x4b/0x130 [drm]
> > 
> > [  861.557864] =============================================
> > 
> > [  861.559507] NMI backtrace for cpu 2
> > [  861.560363] CPU: 2 PID: 64 Comm: khungtaskd Tainted:
> > G           O      4.18.0-rc6Lyude-Test+ #1
> > [  861.561197] Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET78W
> > (1.51 ) 05/18/2018
> > [  861.561948] Call Trace:
> > [  861.562757]  dump_stack+0x8e/0xd3
> > [  861.563516]  nmi_cpu_backtrace.cold.3+0x14/0x5a
> > [  861.564269]  ? lapic_can_unplug_cpu.cold.27+0x42/0x42
> > [  861.565029]  nmi_trigger_cpumask_backtrace+0xa1/0xae
> > [  861.565789]  arch_trigger_cpumask_backtrace+0x19/0x20
> > [  861.566558]  watchdog+0x316/0x580
> > [  861.567355]  kthread+0x12b/0x150
> > [  861.568114]  ? reset_hung_task_detector+0x20/0x20
> > [  861.568863]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [  861.569598]  ret_from_fork+0x3a/0x50
> > [  861.570370] Sending NMI from CPU 2 to CPUs 0-1,3-7:
> > [  861.571426] NMI backtrace for cpu 6 skipped: idling at
> > intel_idle+0x7f/0x120
> > [  861.571429] NMI backtrace for cpu 7 skipped: idling at
> > intel_idle+0x7f/0x120
> > [  861.571432] NMI backtrace for cpu 3 skipped: idling at
> > intel_idle+0x7f/0x120
> > [  861.571464] NMI backtrace for cpu 5 skipped: idling at
> > intel_idle+0x7f/0x120
> > [  861.571467] NMI backtrace for cpu 0 skipped: idling at
> > intel_idle+0x7f/0x120
> > [  861.571469] NMI backtrace for cpu 4 skipped: idling at
> > intel_idle+0x7f/0x120
> > [  861.571472] NMI backtrace for cpu 1 skipped: idling at
> > intel_idle+0x7f/0x120
> > [  861.572428] Kernel panic - not syncing: hung_task: blocked tasks
> > 
> > So: fix this with a new trick; store the current task_struct that's
> > executing in the nouveau_connector structure, then avoid attempting to
> > runtime resume the device when we know that we're just running from the
> > context of our hotplug interrupt handler. Since hpd interrupts are only
> > enabled while the device is runtime active, this should be totally safe.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Karol Herbst <karolherbst@gmail.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_connector.c | 16 ++++++++++------
> >  drivers/gpu/drm/nouveau/nouveau_connector.h |  1 +
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > index 9714e09f17db..8409c3f2c3a1 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > @@ -572,13 +572,14 @@ nouveau_connector_detect(struct drm_connector
> > *connector, bool force)
> >  		nv_connector->edid = NULL;
> >  	}
> >  
> > -	/* Outputs are only polled while runtime active, so resuming the
> > -	 * device here is unnecessary (and would deadlock upon runtime suspend
> > -	 * because it waits for polling to finish). We do however, want to
> > -	 * prevent the autosuspend timer from elapsing during this operation
> > -	 * if possible.
> > +	/* Output polling and HPD only happens while we're runtime active, so
> > +	 * resuming the device here is unnecessary (and would deadlock upon
> > +	 * runtime suspend because it waits for polling to finish). We do
> > +	 * however, want to prevent the autosuspend timer from elapsing during
> > +	 * this operation if possible.
> >  	 */
> > -	if (drm_kms_helper_is_poll_worker()) {
> > +	if (drm_kms_helper_is_poll_worker() ||
> 
> Uh, this entirely slipped through my rader. Looks very much like a hack.
> If you want to avoid doing runtime pm from the poll worker imo the right
> thing to do would be to use pm_runtime_get_if_in_use() and skip the entire
> detection (returning the current state) if you can't get a runtime pm
> reference. You could also use the force parameter to figure out whether
> userspace is asking for this information or not.
nope! While you're definitely right that we should actually avoid disabling
output polling during runtime suspend (see my response to your response on
patch 3), this part is still needed and also matches what i915 currently does
in it's irq handlers (see: all the disable_rpm_wakeref_asserts() calls in
i915_hpd.c). pm_runtime_get_if_in_use() won't work because (taken from
Documentation/power/runtime_pm.txt):

  int pm_runtime_get_if_in_use(struct device *dev);
    - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
      runtime PM status is RPM_ACTIVE and the runtime PM usage counter is
      nonzero, increment the counter and return 1; otherwise return 0 without
      changing the counter

Which means if the usage count is non-zero (e.g. all points where the GPU is
awake but isn't in use and is waiting for the autosuspend delay to timeout),
we'll just avoid connector detection entirely without at least having a screen
active or some other kind of activity that grabs a runtime power reference.

Additionally: nouveau_connector_detect() is what sees whether or not the
connector status has changed in order to determine whether or not we want to
propogate the event to sysfs. If we avoid running the function at any point,
we are just dropping hotplug events. 
> 
> Otoh it's a bit nasty to stop the polling (if the hw really requires it)
> just because the display is suspended, makes waking up the machine just a
> notch more annoying. E.g. in i915 we keep polling (and use some ACPI
> methods if available for hpd detection, to waste less power on rpm
> wakeups).
> -Daniel
> 
> > +	    nv_connector->hpd_task == current) {
> >  		pm_runtime_get_noresume(dev->dev);
> >  	} else {
> >  		ret = pm_runtime_get_sync(dev->dev);
> > @@ -1151,6 +1152,8 @@ nouveau_connector_hotplug(struct nvif_notify
> > *notify)
> >  	const char *name = connector->name;
> >  	struct nouveau_encoder *nv_encoder;
> >  
> > +	nv_connector->hpd_task = current;
> > +
> >  	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
> >  		NV_DEBUG(drm, "service %s\n", name);
> >  		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP)))
> > @@ -1167,6 +1170,7 @@ nouveau_connector_hotplug(struct nvif_notify
> > *notify)
> >  		nouveau_connector_hotplug_probe(nv_connector);
> >  	}
> >  
> > +	nv_connector->hpd_task = NULL;
> >  	return NVIF_NOTIFY_KEEP;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h
> > b/drivers/gpu/drm/nouveau/nouveau_connector.h
> > index 2d9d35a146a4..1964e682ba13 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_connector.h
> > +++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
> > @@ -45,6 +45,7 @@ struct nouveau_connector {
> >  	u8 *dcb;
> >  
> >  	struct nvif_notify hpd;
> > +	struct task_struct *hpd_task;
> >  
> >  	struct drm_dp_aux aux;
> >  
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
-- 
Cheers,
	Lyude Paul

