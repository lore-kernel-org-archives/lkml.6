Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497BFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E1220989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="U0la24gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfA2Uca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:32:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36753 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2Uc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:32:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so17139315edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mkDQBanMrMqpFMG/yIE4fD6W17dgZpQWiF1yvpbuOng=;
        b=U0la24gcg/dfeDpFU8jxtgcxRcPGT1YdddlAPIfJBFmvKvm5IKLRN8GYeIquWpLnvW
         QZlKhInLaJYwR0FNt9nDLs3voCsvXHO2TQt3nTLfy6A3tKTDgv84UoyP6bUh6oz1EdK3
         ekPhHOOHxkv9oIx1wOk5YvUDSBxnpiJ+8YmD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mkDQBanMrMqpFMG/yIE4fD6W17dgZpQWiF1yvpbuOng=;
        b=MBCyezotK90/eoWaieCBxc4+w4If7iifHOFvs5ZiEu5CxjbWKYSUbjdvHpE1Bi6Ofv
         b8nACYN4KsxcrrU2ZeX+WpLB/tFDBfClzoPvoN6BSjXtY50/fmwy1IXAdIz4zjWQP9Hs
         Ais2+YLMbeUYXUiqKGNr7JXuNrgFBYoQfTTH2E2PI4SOIV2y0rCJhnqQBCS9O2S4Xath
         m6KHNEr/LgEOCXJqB8/TIZvs/EEFXhjbLeWCMQGdhEIYqB3xP/1SHEtlBVmV5ZUUEPl+
         FGOFscXSTgck07UirINLHVK6shoiKDBjVHWT6Ypv4hCzKwe3wmijW3/tckoOWEuT7Az0
         tnYw==
X-Gm-Message-State: AJcUukfJsfCdPpcAt2TMumj9V9eXBqomjOPY1ajCWT7gSUA+mKajYy80
        MzzC9ZGH/UKin0biopHMcXVf6g==
X-Google-Smtp-Source: ALg8bN6csMq0LuZnx6B0qOwTt/eBRlB3a62k48Ovgtlb50XVUPg03Eo+EVgrmIjld49XhvYXLMk6kQ==
X-Received: by 2002:a17:906:19c8:: with SMTP id h8mr24285465ejd.199.1548793947344;
        Tue, 29 Jan 2019 12:32:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c30sm14768299edc.70.2019.01.29.12.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 12:32:26 -0800 (PST)
Date:   Tue, 29 Jan 2019 21:32:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/i915: Always allocate VCPI during system resume
Message-ID: <20190129203224.GA3271@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20190129183928.26779-1-lyude@redhat.com>
 <20190129183928.26779-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129183928.26779-4-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 01:39:27PM -0500, Lyude Paul wrote:
> Since there's a chance MST topologies can be removed while the system is
> in suspend, there's also a chance that the connectors in the atomic
> state which we try to restore on system resume will have been
> unregistered if they were part of an MST topology that was removed
> mid-suspend. In such situations, we'll currently skip recalculating the
> VCPI. Normally this would be safe since we don't expect to be allowed to
> enable displays on unregistered connections, but since we need to try
> our best to restore even partially invalid atomic states on system
> resume we end up introducing the chance that we try enabling a display
> on a now-unregistered connector. This of course results on a blow up
> during system resume:
> 
> [ 1894.177788] [drm:pipe_config_err [i915]] *ERROR* mismatch in dp_m_n (expected tu 0 gmch 1730150/8388608 link 288358/1048576, or tu 0 gmch 0/0 link 0/0, found tu 64, gmch 1730150/8388608 link 288358/1048576)
> [ 1894.177795] ------------[ cut here ]------------
> [ 1894.177799] pipe state doesn't match!
> [ 1894.177905] WARNING: CPU: 2 PID: 1894 at drivers/gpu/drm/i915/intel_display.c:12292 intel_atomic_commit_tail+0xd5e/0xdd0 [i915]
> [ 1894.177909] Modules linked in: i915(O) drm_kms_helper(O) drm(O) vfat fat joydev iTCO_wdt wmi_bmof btusb btrtl btbcm intel_rapl btintel i2c_algo_bit x86_pkg_temp_thermal bluetooth syscopyarea coretemp sysfillrect sysimgblt crc32_pclmul fb_sys_fops ucsi_acpi psmouse ecdh_generic pcspkr typec_ucsi i2c_i801 typec mei_me mei i2c_core wmi thinkpad_acpi ledtrig_audio snd soundcore rfkill tpm_tis tpm_tis_core video pcc_cpufreq tpm acpi_pad uas usb_storage crc32c_intel nvme serio_raw nvme_core xhci_pci xhci_hcd [last unloaded: drm]
> [ 1894.177990] CPU: 2 PID: 1894 Comm: kworker/u16:8 Tainted: G           O      5.0.0-rc4Lyude-Test+ #9
> [ 1894.177994] Hardware name: LENOVO 20L8S2N800/20L8S2N800, BIOS N22ET35W (1.12 ) 04/09/2018
> [ 1894.178005] Workqueue: events_unbound async_run_entry_fn
> [ 1894.178079] RIP: 0010:intel_atomic_commit_tail+0xd5e/0xdd0 [i915]
> [ 1894.178085] Code: ba 01 00 00 00 4c 89 4c 24 10 e8 3d 46 01 00 4c 8b 4c 24 10 e9 a4 fb ff ff e8 b2 18 bd e0 0f 0b e9 a5 fd ff ff e8 a6 18 bd e0 <0f> 0b e9 f1 f9 ff ff e8 9a 18 bd e0 0f 0b 0f b6 44 24 18 e9 23 f9
> [ 1894.178090] RSP: 0000:ffffc90000553c08 EFLAGS: 00010286
> [ 1894.178096] RAX: 0000000000000000 RBX: ffff888459edc000 RCX: 0000000000000006
> [ 1894.178101] RDX: 0000000000000007 RSI: ffff8884591e2f90 RDI: ffff88845e295690
> [ 1894.178105] RBP: ffff888454e27000 R08: 0000000000000000 R09: 0000000000000000
> [ 1894.178108] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888454e22000
> [ 1894.178112] R13: ffff888454e21000 R14: ffff8883ca680750 R15: ffff8883ca680758
> [ 1894.178118] FS:  0000000000000000(0000) GS:ffff88845e280000(0000) knlGS:0000000000000000
> [ 1894.178123] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1894.178127] CR2: 0000000000000000 CR3: 0000000002214001 CR4: 00000000003606e0
> [ 1894.178131] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1894.178135] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1894.178139] Call Trace:
> [ 1894.178224]  intel_atomic_commit+0x240/0x320 [i915]
> [ 1894.178251]  drm_atomic_helper_commit_duplicated_state+0xc9/0xe0 [drm_kms_helper]
> [ 1894.178321]  __intel_display_resume+0x82/0xd0 [i915]
> [ 1894.178391]  intel_display_resume+0xcf/0x120 [i915]
> [ 1894.178453]  i915_drm_resume+0xb1/0x100 [i915]
> [ 1894.178465]  ? pci_pm_suspend_late+0x30/0x30
> [ 1894.178473]  dpm_run_callback+0x70/0x210
> [ 1894.178484]  device_resume+0xae/0x1f0
> [ 1894.178493]  async_resume+0x19/0x30
> [ 1894.178502]  async_run_entry_fn+0x39/0x160
> [ 1894.178513]  process_one_work+0x23c/0x590
> [ 1894.178529]  worker_thread+0x30/0x380
> [ 1894.178539]  ? rescuer_thread+0x340/0x340
> [ 1894.178545]  kthread+0x112/0x130
> [ 1894.178552]  ? kthread_create_on_node+0x60/0x60
> [ 1894.178563]  ret_from_fork+0x3a/0x50
> [ 1894.178582] irq event stamp: 76782
> [ 1894.178591] hardirqs last  enabled at (76781): [<ffffffff8112c135>] vprintk_emit+0x2c5/0x2d0
> [ 1894.178600] hardirqs last disabled at (76782): [<ffffffff81001ae8>] trace_hardirqs_off_thunk+0x1a/0x1c
> [ 1894.178609] softirqs last  enabled at (76734): [<ffffffff81c0035d>] __do_softirq+0x35d/0x412
> [ 1894.178618] softirqs last disabled at (76727): [<ffffffff810bf830>] irq_exit+0xe0/0xf0
> [ 1894.178687] WARNING: CPU: 2 PID: 1894 at drivers/gpu/drm/i915/intel_display.c:12292 intel_atomic_commit_tail+0xd5e/0xdd0 [i915]
> [ 1894.178692] ---[ end trace 0df08c0b9a67376e ]---
> 
> So, fix this by using the new drm_atomic_state.suspend_or_resume hook in
> order to force us to retrieve a VCPI allocation when restoring a pipe's
> atomic state. This is safe, since drm_dp_atomic_find_vcpi_slots() will
> just return the VCPI allocation we had pre-suspend.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Fixes: eceae1472467 ("drm/dp_mst: Start tracking per-port VCPI allocations")
> ---
>  drivers/gpu/drm/i915/intel_dp_mst.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index cdb83d294cdd..04c9a16fdc39 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -80,8 +80,13 @@ static int intel_dp_mst_compute_config(struct intel_encoder *encoder,
>  	mst_pbn = drm_dp_calc_pbn_mode(adjusted_mode->crtc_clock, bpp);
>  	pipe_config->pbn = mst_pbn;
>  
> -	/* Zombie connectors can't have VCPI slots */
> -	if (!drm_connector_is_unregistered(connector)) {
> +	/*
> +	 * Zombie connectors can't have VCPI slots and won't be turned on,
> +	 * except during resume where we must make sure we restore the
> +	 * previous VCPI allocations
> +	 */
> +	if (!drm_connector_is_unregistered(connector) ||

Hm, could we push the !drm_connector_is_unregistered check into
drm_dp_atomic_find_vcpi_slots? Then we could also push the
state->duplicated check there, and these special cases would be in the
same library.

From a code logic pov looks correct I think, I couldn't poke any holes int
this idea at least. I guess we'll find out :-)
-Daniel

> +	    state->suspend_or_resume) {
>  		slots = drm_dp_atomic_find_vcpi_slots(state,
>  						      &intel_dp->mst_mgr,
>  						      port,
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
