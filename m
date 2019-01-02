Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47243C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1706321871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfABJmf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:42:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:14275 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbfABJme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:42:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 01:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,430,1539673200"; 
   d="scan'208";a="134653632"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.251.83.195])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2019 01:42:30 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        David Woodhouse <dwmw2@infradead.org>, Eric Wong <e@80x24.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20181227114948.ev4b3jte3ubsc5us@dcvr>
Cc:     iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
Message-ID: <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: iommu_intel or i915 regression in 4.18, 4.19.12 and drm-tip
Date:   Wed, 02 Jan 2019 11:42:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric Wong (2018-12-27 13:49:48)
> I just got a used Thinkpad X201 (Core i5 M 520, Intel QM57
> chipset) and hit some kernel panics while trying to view
> image/animation-intensive stuff in Firefox (X11) unless I use
> "iommu_intel=igfx_off".
> 
> With Debian stable backport kernels, "linux-image-4.17.0-0.bpo.3-amd64"
> (4.17.17-1~bpo9+1) has no problems.  But "linux-image-4.18.0-0.bpo.3-amd64"
> (4.18.20-2~bpo9+1) gives a blank screen before I can login via agetty
> and run startx.

Could you open a new bug at (and attach relevant information there):

https://01.org/linuxgraphics/documentation/how-report-bugs

Most confusing about this is that 4.17 would have worked to begin with,
without intel_iommu=igfx_off (unless it was the default for older
kernel?)

Did you maybe update other parts of the system while updating the
kernel?

If you could attach full boot dmesg from working and non-working kernel +
have config file of both kernel's in Bugzilla. That'd be a good start!

Regards, Joonas

> Building 4.19.12 myself got me into X11 and able to start
> Firefox to panic the kernel.  I also updated to the latest BIOS
> (1.40), but it's an EOL laptop (but it's still the most powerful
> laptop I use).  I intend to replace the BIOS with Coreboot soon...
> 
> Initially, I thought I was hitting another GPU hang from 4.18+:
> 
>         https://bugs.freedesktop.org/show_bug.cgi?id=107945
> 
> But building drm-tip @ commit 28bb1fc015cedadf3b099b8bd0bb27609849f362
> ("drm-tip: 2018y-12m-25d-08h-12m-37s UTC integration manifest")
> I was still able to reproduce the panic unless I use iommu_intel=igfx_off
> "i915.reset=1" did not help matters, either.
> 
> Below is what I got from netconsole while on drm-tip:
> 
> Kernel panic - not syncing: DMAR hardware is malfunctioning
> Shutting down cpus with NMI
> Kernel Offset: disabled
> ---[ end Kernel panic - not syncing: DMAR hardware is malfunctioning ]---
> ------------[ cut here ]------------
> sched: Unexpected reschedule of offline CPU#3!
> WARNING: CPU: 0 PID: 105 at native_smp_send_reschedule+0x34/0x40
> Modules linked in: netconsole ccm snd_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic intel_powerclamp coretemp kvm_intel kvm irqbypass crc32_pclmul crc32c_intel ghash_clmulni_intel arc4 iwldvm aesni_intel aes_x86_64 crypto_simd cryptd mac80211 glue_helper intel_cstate iwlwifi intel_uncore i915 intel_gtt i2c_algo_bit iosf_mbi drm_kms_helper cfbfillrect syscopyarea intel_ips cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea thinkpad_acpi prime_numbers cfg80211 ledtrig_audio i2c_i801 sg snd_hda_intel led_class snd_hda_codec drm ac drm_panel_orientation_quirks snd_hwdep battery e1000e agpgart snd_hda_core snd_pcm snd_timer ptp snd soundcore pps_core ehci_pci ehci_hcd lpc_ich video mfd_core button acpi_cpufreq ecryptfs ip_tables x_tables ipv6 evdev thermal [last unloaded: netconsole]
> CPU: 0 PID: 105 Comm: kworker/u8:3 Not tainted 4.20.0-rc7b1+ #1
> Hardware name: LENOVO 3680FBU/3680FBU, BIOS 6QET70WW (1.40 ) 10/11/2012
> Workqueue: i915 __i915_gem_free_work [i915]
> RIP: 0010:native_smp_send_reschedule+0x34/0x40
> Code: 05 69 c6 c9 00 73 15 48 8b 05 18 2d b3 00 be fd 00 00 00 48 8b 40 30 e9 9a 58 7d 00 89 fe 48 c7 c7 78 73 af 81 e8 dc c2 01 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 66 66 66 66 90 8b 05 0d 7d df
> RSP: 0018:ffff888075003d98 EFLAGS: 00010092
> RAX: 000000000000002e RBX: ffff8880751a0740 RCX: 0000000000000006
> RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff888075015440
> RBP: ffff88806e823700 R08: 0000000000000000 R09: ffff888072fc07c0
> R10: ffff888075003d60 R11: 00000000fff5c002 R12: ffff8880751a0740
> R13: ffff8880751a0740 R14: 0000000000000000 R15: 0000000000000003
> FS:  0000000000000000(0000) GS:ffff888075000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdb1f53f000 CR3: 0000000001c0a004 CR4: 00000000000206f0
> Call Trace:
>  <IRQ>
>  ? check_preempt_curr+0x4e/0x90
>  ? ttwu_do_wakeup.isra.19+0x14/0xf0
>  ? try_to_wake_up+0x323/0x410
>  ? autoremove_wake_function+0xe/0x30
>  ? __wake_up_common+0x8d/0x140
>  ? __wake_up_common_lock+0x6c/0x90
>  ? irq_work_run_list+0x49/0x80
>  ? tick_sched_handle.isra.6+0x50/0x50
>  ? update_process_times+0x3b/0x50
>  ? tick_sched_handle.isra.6+0x30/0x50
>  ? tick_sched_timer+0x3b/0x80
>  ? __hrtimer_run_queues+0xea/0x270
>  ? hrtimer_interrupt+0x101/0x240
>  ? smp_apic_timer_interrupt+0x6a/0x150
>  ? apic_timer_interrupt+0xf/0x20
>  </IRQ>
>  ? panic+0x1ca/0x212
>  ? panic+0x1c7/0x212
>  ? __iommu_flush_iotlb+0x19e/0x1c0
>  ? iommu_flush_iotlb_psi+0x96/0xf0
>  ? intel_unmap+0xbf/0xf0
>  ? i915_gem_object_put_pages_gtt+0x36/0x220 [i915]
>  ? drm_ht_remove+0x20/0x20 [drm]
>  ? drm_mm_remove_node+0x1ad/0x310 [drm]
>  ? __pm_runtime_resume+0x54/0x70
>  ? __i915_gem_object_unset_pages+0x129/0x170 [i915]
>  ? __i915_gem_object_put_pages+0x70/0xa0 [i915]
>  ? __i915_gem_free_objects+0x245/0x4e0 [i915]
>  ? __switch_to_asm+0x24/0x60
>  ? __i915_gem_free_work+0x65/0xa0 [i915]
>  ? process_one_work+0x1fd/0x410
>  ? worker_thread+0x49/0x3f0
>  ? kthread+0xf8/0x130
>  ? process_one_work+0x410/0x410
>  ? kthread_park+0x90/0x90
>  ? ret_from_fork+0x35/0x40
> WARNING: CPU: 0 PID: 105 at native_smp_send_reschedule+0x34/0x40
> ---[ end trace 7dd2184d8c86cef5 ]---
> ------------[ cut here ]------------
> sched: Unexpected reschedule of offline CPU#2!
> WARNING: CPU: 0 PID: 105 at native_smp_send_reschedule+0x34/0x40
> Modules linked in: netconsole ccm snd_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic intel_powerclamp coretemp kvm_intel kvm irqbypass crc32_pclmul crc32c_intel ghash_clmulni_intel arc4 iwldvm aesni_intel aes_x86_64 crypto_simd cryptd mac80211 glue_helper intel_cstate iwlwifi intel_uncore i915 intel_gtt i2c_algo_bit iosf_mbi drm_kms_helper cfbfillrect syscopyarea intel_ips cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea thinkpad_acpi prime_numbers cfg80211 ledtrig_audio i2c_i801 sg snd_hda_intel led_class snd_hda_codec drm ac drm_panel_orientation_quirks snd_hwdep battery e1000e agpgart snd_hda_core snd_pcm snd_timer ptp snd soundcore pps_core ehci_pci ehci_hcd lpc_ich video mfd_core button acpi_cpufreq ecryptfs ip_tables x_tables ipv6 evdev thermal [last unloaded: netconsole]
> CPU: 0 PID: 105 Comm: kworker/u8:3 Tainted: G        W         4.20.0-rc7b1+ #1
> Hardware name: LENOVO 3680FBU/3680FBU, BIOS 6QET70WW (1.40 ) 10/11/2012
> Workqueue: i915 __i915_gem_free_work [i915]
> RIP: 0010:native_smp_send_reschedule+0x34/0x40
> Code: 05 69 c6 c9 00 73 15 48 8b 05 18 2d b3 00 be fd 00 00 00 48 8b 40 30 e9 9a 58 7d 00 89 fe 48 c7 c7 78 73 af 81 e8 dc c2 01 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 66 66 66 66 90 8b 05 0d 7d df
> RSP: 0018:ffff888075003d10 EFLAGS: 00010086
> RAX: 000000000000002e RBX: ffff888075120740 RCX: 0000000000000006
> RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff888075015440
> RBP: ffff88807378b700 R08: 0000000000000000 R09: ffff888072fc07c0
> R10: ffff888075003cd8 R11: 00000000ffeb4a02 R12: ffff888075120740
> R13: ffff888075120740 R14: 0000000000000004 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff888075000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdb1f53f000 CR3: 0000000001c0a004 CR4: 00000000000206f0
> Call Trace:
>  <IRQ>
>  ? check_preempt_curr+0x4e/0x90
>  ? ttwu_do_wakeup.isra.19+0x14/0xf0
>  ? try_to_wake_up+0x323/0x410
>  ? __wake_up_common+0x8d/0x140
>  ? ep_poll_callback+0xbd/0x2a0
>  ? __wake_up_common+0x8d/0x140
>  ? __wake_up_common_lock+0x6c/0x90
>  ? irq_work_run_list+0x49/0x80
>  ? tick_sched_handle.isra.6+0x50/0x50
>  ? update_process_times+0x3b/0x50
>  ? tick_sched_handle.isra.6+0x30/0x50
>  ? tick_sched_timer+0x3b/0x80
>  ? __hrtimer_run_queues+0xea/0x270
>  ? hrtimer_interrupt+0x101/0x240
>  ? smp_apic_timer_interrupt+0x6a/0x150
>  ? apic_timer_interrupt+0xf/0x20
>  </IRQ>
>  ? panic+0x1ca/0x212
>  ? panic+0x1c7/0x212
>  ? __iommu_flush_iotlb+0x19e/0x1c0
>  ? iommu_flush_iotlb_psi+0x96/0xf0
>  ? intel_unmap+0xbf/0xf0
>  ? i915_gem_object_put_pages_gtt+0x36/0x220 [i915]
>  ? drm_ht_remove+0x20/0x20 [drm]
> ---[ end trace 7dd2184d8c86cef6 ]---
> 
> 
> Thanks.  I barely use graphics and certainly not with KVM;
> so I don't think I'll be missing anything igfx_off.  But
> maybe this bugreport can help other X201 users.
