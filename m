Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A510C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86FA208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86FA208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metrics.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756237AbeFOSDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:03:19 -0400
Received: from static-151-200-251-90.washdc.east.verizon.net ([151.200.251.90]:58126
        "EHLO static-151-200-251-90.washdc.east.verizon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752703AbeFOSDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:03:17 -0400
X-Greylist: delayed 829 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jun 2018 14:03:17 EDT
Received: from localhost ([127.0.0.1])
        by Zia.metrics.net with esmtp (Exim 4.91)
        (envelope-from <aderobertis@metrics.net>)
        id 1fTsqk-0006b3-PY; Fri, 15 Jun 2018 13:49:27 -0400
Subject: Re: fscache: fix a kernel BUG at fs/fscache/operation.c:69!
To:     carmark.dlut@gmail.com
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180222073330.36259-1-carmark.dlut@gmail.com>
From:   Anthony DeRobertis <aderobertis@metrics.net>
Message-ID: <afbfd186-1f06-a03c-79b5-c98a12d35c75@metrics.net>
Date:   Fri, 15 Jun 2018 13:49:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180222073330.36259-1-carmark.dlut@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 02:33 AM, carmark.dlut@gmail.com wrote:
> From: Lei Xue <carmark.dlut@gmail.com>
>
> There is a potential race in fscache operation enqueuing for reading and
> copying multiple pages from cachefiles to netfs.
> Under some heavy load system, it will happen very often.

Did anything happen with this patch? I still saw it with 4.16.12 (panic 
below, captured via netconsole) when running ffmpeg with a source on a 
cached NFSv3 share. (Actually an overlay on top of that cached NFS 
mount). Applying this patch seems to have fixed the issue.

The only weird thing I've noticed — not sure it's actually new from this 
patch — is that midway through the encode, it stopped using the cached 
version and started transferring it from the server again. But even so, 
that's far better than a panic that takes out the machine (until the 
watchdog forces a reset).

ps: please cc me on replies, not subscribed to the mailing list.

[51593.345396] FS-Cache:
[51593.345406] FS-Cache: Assertion failed
[51593.345409] FS-Cache: 0 > 0 is false
[51593.345421] ------------[ cut here ]------------
[51593.345424] kernel BUG at /build/linux-43CEzF/linux-4.16.12/fs/fscache/operation.c:68!
[51593.345430] invalid opcode: 0000 [#1] SMP PTI
[51593.345433] Modules linked in: netconsole configfs ebtable_filter ebtables devlink ip6table_filter ip6_tables iptable_filter overlay nfsv3 nfs tun cachefiles fscache binfmt_misc snd_usb_audio snd_hda_codec_hdmi snd_usbmidi_lib xts dm_crypt hid_generic usbhid snd_rawmidi snd_seq_device hid pktcdvd snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec bridge snd_hda_core stp llc intel_powerclamp snd_hwdep kvm_intel kvm snd_pcm_oss mxm_wmi snd_mixer_oss snd_pcm snd_timer irqbypass intel_cstate uhci_hcd intel_uncore r8169 pcspkr ehci_pci xhci_pci xhci_hcd wmi snd ehci_hcd i2c_i801 firewire_ohci sr_mod soundcore usbcore firewire_core crc_itu_t cdrom mii sg button asus_atk0110 lpc_ich shpchp usb_common i5500_temp i7core_edac nvidia_drm(PO) drm_kms_helper drm nvidia_modeset(PO) nvidia(PO)
[51593.345468]  ipmi_devintf ipmi_msghandler nfsd coretemp auth_rpcgss nfs_acl lockd grace sunrpc i2c_dev iTCO_wdt iTCO_vendor_support acpi_cpufreq msr loop ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb crypto_simd cryptd glue_helper aes_x86_64 dm_mod raid456 libcrc32c crc32c_generic async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid0 multipath linear raid1 raid10 md_mod sd_mod ahci libahci crc32c_intel evdev serio_raw libata scsi_mod
[51593.345493] CPU: 6 PID: 0 Comm: swapper/6 Tainted: P        W IO     4.16.0-2-amd64 #1 Debian 4.16.12-1
[51593.345495] Hardware name: System manufacturer System Product Name/SABERTOOTH X58, BIOS 1402    08/09/2012
[51593.345502] RIP: 0010:fscache_enqueue_operation+0x106/0x150 [fscache]
[51593.345504] RSP: 0018:ffff91a767383c98 EFLAGS: 00010082
[51593.345508] RAX: 0000000000000018 RBX: ffff91a7290d4d80 RCX: 0000000000000006
[51593.345510] RDX: 0000000000000000 RSI: 0000000000000086 RDI: ffff91a767396730
[51593.345512] RBP: ffff91a3359f8a20 R08: 000000000000043e R09: 0000000000000000
[51593.345515] R10: ffff91a767383c80 R11: 0000000000000001 R12: ffff91a7290d4d80
[51593.345517] R13: ffff91a7290d4e08 R14: ffff91a703575e20 R15: ffff91a7290d4e08
[51593.345520] FS:  0000000000000000(0000) GS:ffff91a767380000(0000) knlGS:0000000000000000
[51593.345522] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[51593.345524] CR2: 000055627b19b000 CR3: 000000015680a000 CR4: 00000000000006e0
[51593.345528] Call Trace:
[51593.345531]  <IRQ>
[51593.345536]  cachefiles_read_waiter+0xf8/0x150 [cachefiles]
[51593.345541]  __wake_up_common+0x76/0x170
[51593.345544]  wake_up_page_bit+0xac/0x100
[51593.345561]  mpage_end_io+0x30/0x90 [ext4]
[51593.345568]  clone_endio+0x8e/0x140 [dm_mod]
[51593.345572]  raid_end_bio_io+0x2c/0xb0 [raid10]
[51593.345576]  raid10_end_read_request+0x71/0x150 [raid10]
[51593.345581]  blk_update_request+0x78/0x2b0
[51593.345589]  scsi_end_request+0x2c/0x1e0 [scsi_mod]
[51593.345597]  scsi_io_completion+0x477/0x670 [scsi_mod]
[51593.345600]  blk_done_softirq+0xa0/0xd0
[51593.345605]  __do_softirq+0xde/0x2b4
[51593.345609]  irq_exit+0xae/0xb0
[51593.345612]  do_IRQ+0x7d/0xc0
[51593.345615]  common_interrupt+0xf/0xf
[51593.345617]  </IRQ>
[51593.345622] RIP: 0010:cpuidle_enter_state+0xa0/0x2b0
[51593.345624] RSP: 0018:ffffb3f1431c7eb0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
[51593.345627] RAX: ffff91a7673a18c0 RBX: 00002eec8305e1d8 RCX: 000000000000001f
[51593.345629] RDX: 00002eec8305e1d8 RSI: 000000002d9c529c RDI: 0000000000000000
[51593.345632] RBP: ffff91a7673a9948 R08: 0000000000000001 R09: 0000000000000135
[51593.345634] R10: ffffb3f1431c7e90 R11: 00000000000000a0 R12: 0000000000000003
[51593.345636] R13: ffffffff9cab2cd8 R14: 0000000000000000 R15: 00002eec83032f50
[51593.345641]  do_idle+0x183/0x1e0
[51593.345644]  cpu_startup_entry+0x6f/0x80
[51593.345649]  start_secondary+0x1a4/0x1f0
[51593.345652]  secondary_startup_64+0xa5/0xb0
[51593.345655] Code: 0b 48 c7 c7 63 d9 7d c1 e8 72 dd 2f da 48 c7 c7 71 d9 7d c1 e8 66 dd 2f da 48 63 73 44 31 d2 48 c7 c7 a0 ce 7d c1 e8 54 dd 2f da <0f> 0b 48 c7 c7 63 d9 7d c1 e8 46 dd 2f da 48 c7 c7 71 d9 7d c1
[51593.345682] RIP: fscache_enqueue_operation+0x106/0x150 [fscache] RSP: ffff91a767383c98
[51593.345688] ---[ end trace fe061122063cafae ]---
[51593.345690] Kernel panic - not syncing: Fatal exception in interrupt
[51593.345782] Kernel Offset: 0x1aa00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[51593.345786] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
[51593.345793] WARNING: CPU: 6 PID: 0 at /build/linux-43CEzF/linux-4.16.12/kernel/sched/core.c:1190 set_task_cpu+0x14d/0x160
[51593.345795] Modules linked in: netconsole configfs ebtable_filter ebtables devlink ip6table_filter ip6_tables iptable_filter overlay nfsv3 nfs tun cachefiles fscache binfmt_misc snd_usb_audio snd_hda_codec_hdmi snd_usbmidi_lib xts dm_crypt hid_generic usbhid snd_rawmidi snd_seq_device hid pktcdvd snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec bridge snd_hda_core stp llc intel_powerclamp snd_hwdep kvm_intel kvm snd_pcm_oss mxm_wmi snd_mixer_oss snd_pcm snd_timer irqbypass intel_cstate uhci_hcd intel_uncore r8169 pcspkr ehci_pci xhci_pci xhci_hcd wmi snd ehci_hcd i2c_i801 firewire_ohci sr_mod soundcore usbcore firewire_core crc_itu_t cdrom mii sg button asus_atk0110 lpc_ich shpchp usb_common i5500_temp i7core_edac nvidia_drm(PO) drm_kms_helper drm nvidia_modeset(PO) nvidia(PO)
[51593.345823]  ipmi_devintf ipmi_msghandler nfsd coretemp auth_rpcgss nfs_acl lockd grace sunrpc i2c_dev iTCO_wdt iTCO_vendor_support acpi_cpufreq msr loop ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb crypto_simd cryptd glue_helper aes_x86_64 dm_mod raid456 libcrc32c crc32c_generic async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid0 multipath linear raid1 raid10 md_mod sd_mod ahci libahci crc32c_intel evdev serio_raw libata scsi_mod
[51593.345844] CPU: 6 PID: 0 Comm: swapper/6 Tainted: P      D W IO     4.16.0-2-amd64 #1 Debian 4.16.12-1
[51593.345846] Hardware name: System manufacturer System Product Name/SABERTOOTH X58, BIOS 1402    08/09/2012
[51593.345849] RIP: 0010:set_task_cpu+0x14d/0x160
[51593.345851] RSP: 0018:ffff91a7673837f0 EFLAGS: 00010006
[51593.345853] RAX: 0000000000000200 RBX: ffff91a74e31c380 RCX: 0000000000000000
[51593.345855] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff91a74e31c380
[51593.345857] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
[51593.345859] R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
[51593.345861] R13: 0000000000000000 R14: 0000000000000046 R15: 00000000000218c0
[51593.345864] FS:  0000000000000000(0000) GS:ffff91a767380000(0000) knlGS:0000000000000000
[51593.345866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[51593.345868] CR2: 000055627b19b000 CR3: 000000015680a000 CR4: 00000000000006e0
[51593.345870] Call Trace:
[51593.345872]  <IRQ>
[51593.345875]  try_to_wake_up+0x154/0x460
[51593.345879]  autoremove_wake_function+0x11/0x50
[51593.345881]  __wake_up_common+0x76/0x170
[51593.345884]  __wake_up_common_lock+0x7c/0xc0
[51593.345888]  irq_work_run_list+0x4d/0x70
[51593.345891]  smp_irq_work_interrupt+0x32/0xc0
[51593.345894]  irq_work_interrupt+0xf/0x20
[51593.345898] RIP: 0010:panic+0x1fb/0x252
[51593.345900] RSP: 0018:ffff91a767383a48 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff09
[51593.345903] RAX: 0000000000000041 RBX: 0000000000000000 RCX: 0000000000000006
[51593.345905] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff91a767396730
[51593.345908] RBP: ffff91a767383ac0 R08: 0000000000000472 R09: 0000000000000000
[51593.345910] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[51593.345912] R13: 0000000000000000 R14: ffffffff9c80922d R15: 0000000000000004
[51593.345915]  ? irq_work_interrupt+0xa/0x20
[51593.345919]  ? panic+0x1f7/0x252
[51593.345923]  oops_end+0xac/0xc0
[51593.345927]  do_trap+0x132/0x140
[51593.345930]  do_error_trap+0x9d/0x120
[51593.345934]  ? fscache_enqueue_operation+0x106/0x150 [fscache]
[51593.345938]  ? up+0x12/0x60
[51593.345941]  ? console_unlock+0x29d/0x550
[51593.345944]  invalid_op+0x1b/0x40
[51593.345949] RIP: 0010:fscache_enqueue_operation+0x106/0x150 [fscache]

