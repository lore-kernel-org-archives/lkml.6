Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D59C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6670A2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6670A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=godking.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeKZKPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:15:42 -0500
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:41018 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeKZKPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:15:42 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Nov 2018 05:15:40 EST
Received: from localhost (localhost [IPv6:::1])
        by godking.net (Postfix) with ESMTPS id 5FF5D1D2AE826;
        Sun, 25 Nov 2018 17:17:17 -0600 (CST)
Date:   Sun, 25 Nov 2018 15:17:15 -0800 (PST)
From:   Alexander Kappner <agk@godking.net>
X-X-Sender: ak@REDDOT
To:     perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        lukas@wunner.de, Jim.Qu@amd.com, bhelgaas@google.com,
        guneshwor.o.singh@intel.com
cc:     agk@godking.net, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [snd_hda_intel] snd_hda_intel causes high CPU lockup and system
 instability if mic disabled in BIOS on Lenovo P50
Message-ID: <alpine.DEB.2.11.1811251505140.20766@REDDOT>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Lenovo P50 laptop has a BIOS option to disable the microphone. When 
this option gets chosen, the snd_hda_intel driver causes high CPU load on 
a single kworker thread, spinning on "process_unsol_events", and system
instability. This behavior occurs from the time that the snd_hda_intel
module is loaded, irrespective of whether anything is attempting to access
the mic. The sound output still works.

When in this state, the module cannot be removed cleanly; attempting to
remove it (even without rmmod -f) triggers an oops.

I have attached two exemplary dmesg outputs. Strangely enough, the exact
location of the oops varies, but further up the call chain, I always see
process_unsol_events.

When the mic is not disabled in the BIOS, the module works stable,
regardless whether or not the mic is muted in ALSA.

I wasn't able to pinpoint the root cause. Any pointers on where to
start? Much appreciated.

Best regards
Alexander

First dmesg:

[31592.691573] BUG: unable to handle kernel NULL pointer dereference at 
000000000000020c
[31592.691600] IP: mux_select+0x1d/0x190 [snd_hda_codec_generic]
[31592.691601] PGD 0 P4D 0
[31592.691604] Oops: 0000 [#1] PREEMPT SMP
[31592.691606] Modules linked in: snd_hda_codec_hdmi snd_hda_codec_realtek 
snd_hda_codec_generic snd_hda_intel(-) snd_hda_codec snd_hwdep 
snd_hda_core snd_pcm snd_timer zfs(PO) zunicode(PO) zlua(PO) 
nvidia_drm(PO) nvidia_modeset(PO) nvidia(PO) iwlmvm mac80211 qmi_wwan 
iwlwifi cfg80211 thinkpad_acpi rfkill zcommon(PO) znvpair(PO) zavl(PO) 
icp(PO) spl(O) sdhci_pci cqhci sdhci mmc_block rtsx_pci_sdmmc rtsx_pci 
mfd_core
[31592.691639] CPU: 3 PID: 11044 Comm: kworker/3:1 Tainted: P           O 
4.16.0-rc7-00206-gf461da3-dirty #33
[31592.691640] Hardware name: LENOVO 20ENCTO1WW/20ENCTO1WW, BIOS N1EET62W 
(1.35 ) 11/10/2016
[31592.691643] Workqueue: events process_unsol_events [snd_hda_core]
[31592.691647] RIP: 0010:mux_select+0x1d/0x190 [snd_hda_codec_generic]
[31592.691648] RSP: 0018:ffffc9000f0dfe08 EFLAGS: 00010292
[31592.691650] RAX: 0000000000000001 RBX: ffff880e44737300 RCX: 
00000000ffffffff
[31592.691651] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffff880ee6368800
[31592.691652] RBP: 0000000000000000 R08: 0000000000000f09 R09: 
0000000000000000
[31592.691653] R10: 0000000000000018 R11: 0000000000000003 R12: 
ffff880ee6368800
[31592.691655] R13: 0000000000000000 R14: ffff881053ce6100 R15: 
0ffff881053ce610
[31592.691656] FS:  0000000000000000(0000) GS:ffff881053cc0000(0000) 
knlGS:0000000000000000
[31592.691658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[31592.691659] CR2: 000000000000020c CR3: 000000000220a004 CR4: 
00000000003606e0
[31592.691661] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[31592.691662] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[31592.691662] Call Trace:
[31592.691668]  ? snd_hda_jack_detect_state+0x4b/0x60 [snd_hda_codec]
[31592.691672]  call_jack_callback.isra.1+0x20/0xa0 [snd_hda_codec]
[31592.691676]  snd_hda_jack_unsol_event+0x62/0x70 [snd_hda_codec]
[31592.691679]  process_unsol_events+0x64/0x80 [snd_hda_core]
[31592.691682]  process_one_work+0x13e/0x380
[31592.691684]  worker_thread+0x62/0x3e0
[31592.691686]  ? rescuer_thread+0x2d0/0x2d0
[31592.691689]  kthread+0x10d/0x140
[31592.691690]  ? kthread_bind+0x10/0x10
[31592.691693]  ret_from_fork+0x35/0x40
[31592.691695] Code: e2 01 e9 77 fb ff ff c3 66 0f 1f 44 00 00 0f 1f 44 00 
00 41 57 41 56 41 55 41 54 49 89 fc 55 53 48 83 ec 08 48 8b af 08 04 00 00 
<8b> 85 0c 02 00 00 85 c0 74 73 89 d3 41 89 f5 8d 50 ff 39 d8 89
[31592.691721] RIP: mux_select+0x1d/0x190 [snd_hda_codec_generic] RSP: 
ffffc9000f0dfe08
[31592.691723] CR2: 000000000000020c
[31592.691725] ---[ end trace dee155e55b20eab8 ]---


Second dmesg:

[115121.084841] BUG: unable to handle kernel NULL pointer dereference at 
00000000000005f8
[115121.084844] PGD 0 P4D 0
[115121.084847] Oops: 0000 [#1] PREEMPT SMP
[115121.084850] CPU: 2 PID: 12228 Comm: kworker/2:1 Tainted: P           O 
4.18.0-rc2-00223-g1904148-dirty #39
[115121.084851] Hardware name: LENOVO 20ENCTO1WW/20ENCTO1WW, BIOS N1EET62W 
(1.35 ) 11/10/2016
[115121.084856] Workqueue: events process_unsol_events [snd_hda_core]
[115121.084859] RIP: 0010:set_path_power+0x24/0x120 
[snd_hda_codec_generic]
[115121.084860] Code: 66 0f 1f 44 00 00 0f 1f 44 00 00 41 57 41 89 f7 41 
56 41 55 41 54 55 48 89 fd 53 48 83 ec 08 4c 8b b7 08 04 00 00 89 54 24 04 
<41> 8b be f8 05 00 00 49 8b b6 08 06 00 00 85 ff 0f 84 ce 00 00 00
[115121.084901] RSP: 0018:ffffc900243e3de8 EFLAGS: 00010296
[115121.084903] RAX: 0000000000000000 RBX: 0000000000000018 RCX: 
00000000ffffffff
[115121.084904] RDX: 0000000000000000 RSI: 0000000000000018 RDI: 
ffff880f993a2800
[115121.084906] RBP: ffff880f993a2800 R08: 0000000000000f09 R09: 
0000000000000000
[115121.084907] R10: 0000000000000019 R11: 0000000000000000 R12: 
0000000000000000
[115121.084908] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000018
[115121.084910] FS:  0000000000000000(0000) GS:ffff881053c80000(0000) 
knlGS:0000000000000000
[115121.084911] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[115121.084912] CR2: 00000000000005f8 CR3: 000000000260a004 CR4: 
00000000003606e0
[115121.084914] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[115121.084915] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[115121.084916] Call Trace:
[115121.084922]  pin_power_callback+0x4f/0x80 [snd_hda_codec_generic]
[115121.084926]  call_jack_callback.isra.1+0x20/0xa0 [snd_hda_codec]
[115121.084930]  snd_hda_jack_unsol_event+0x62/0x70 [snd_hda_codec]
[115121.084933]  process_unsol_events+0x64/0x80 [snd_hda_core]
[115121.084937]  process_one_work+0x157/0x390
[115121.084939]  worker_thread+0x64/0x3e0
[115121.084942]  ? rescuer_thread+0x2e0/0x2e0
[115121.084944]  kthread+0x10d/0x140
[115121.084946]  ? kthread_bind+0x10/0x10
[115121.084948]  ret_from_fork+0x35/0x40
[115121.084951] Modules linked in: snd_hda_codec_hdmi 
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel(-) snd_hda_codec 
snd_hwdep snd_hda_core snd_pcm snd_timer tun nvidia_modeset(PO) nvidia(PO) 
iwlmvm mac80211 iwlwifi btusb btrtl btbcm btintel bluetooth cfg80211 
qmi_wwan ecdh_generic thinkpad_acpi rfkill sdhci_pci cqhci sdhci mmc_block 
rtsx_pci_sdmmc rtsx_pci mfd_core
[115121.084969] CR2: 00000000000005f8
[115121.084971] ---[ end trace 010d684599325728 ]---
[115121.084975] RIP: 0010:set_path_power+0x24/0x120 
[snd_hda_codec_generic]
[115121.084976] Code: 66 0f 1f 44 00 00 0f 1f 44 00 00 41 57 41 89 f7 41 
56 41 55 41 54 55 48 89 fd 53 48 83 ec 08 4c 8b b7 08 04 00 00 89 54 24 04 
<41> 8b be f8 05 00 00 49 8b b6 08 06 00 00 85 ff 0f 84 ce 00 00 00
[115121.085000] RSP: 0018:ffffc900243e3de8 EFLAGS: 00010296
[115121.085001] RAX: 0000000000000000 RBX: 0000000000000018 RCX: 
00000000ffffffff
[115121.085002] RDX: 0000000000000000 RSI: 0000000000000018 RDI: 
ffff880f993a2800
[115121.085003] RBP: ffff880f993a2800 R08: 0000000000000f09 R09: 
0000000000000000
[115121.085004] R10: 0000000000000019 R11: 0000000000000000 R12: 
0000000000000000
[115121.085005] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000018
[115121.085006] FS:  0000000000000000(0000) GS:ffff881053c80000(0000) 
knlGS:0000000000000000
[115121.085007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[115121.085008] CR2: 00000000000005f8 CR3: 000000000260a004 CR4: 
00000000003606e0
[115121.085009] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[115121.085010] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
