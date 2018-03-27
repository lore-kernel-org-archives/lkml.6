Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeC0A5f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 20:57:35 -0400
Received: from tn-76-7-162-187.sta.embarqhsd.net ([76.7.162.187]:52627 "EHLO
        animx.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbeC0A5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 20:57:34 -0400
Date: Mon, 26 Mar 2018 20:45:55 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 4.15.12 crash
Message-ID: <20180327004555.GB25259@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using target to make /dev/sr[012] an iscsi target.  Another system is
reading all 3 at the same time.  I had 2 VMs running using libvirt (qemu and
kvm module).  Less than a minute after starting the read, the kernel oops.

Rebooted the machine and tried again without the VMs running, got another
oops.

Here's the oops from the first one:
[1489.107778] WARNING: CPU: 0 PID: 0 at /usr/src/linux/dist/4.15.12-nobklcd/drivers/scsi/scsi_lib.c:1068 scsi_init_io+0x111/0x1a0 [scsi_mod]
[1489.109248] Modules linked in: vhost_net tap tun netconsole dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic md_mod dm_crypt algif_skcipher af_alg dm_mod dax af_packet iscsi_target_mod tcm_loop vhost_scsi vhost target_core_file target_core_iblock target_core_pscsi target_core_mod nfsd exportfs dummy bridge stp llc ib_iser rdma_cm iw_cm ib_cm ib_core ipv6 iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi configfs sr_mod cdrom adt7475 hwmon_vid sd_mod sg coretemp x86_pkg_temp_thermal kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc nouveau video led_class drm_kms_helper cfbfillrect snd_hda_codec_realtek syscopyarea cfbimgblt snd_hda_codec_generic
[1489.113370]  sysfillrect sysimgblt fb_sys_fops cfbcopyarea ttm drm agpgart igb snd_hda_intel aesni_intel snd_hda_codec aes_x86_64 snd_hda_core hwmon crypto_simd mptsas glue_helper mpt3sas i2c_algo_bit snd_pcm_oss mptscsih i2c_core snd_mixer_oss mptbase raid_class snd_pcm scsi_transport_sas wmi snd_timer snd soundcore ahci libahci libata scsi_mod button unix [last unloaded: netconsole]
[1489.113370] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.12 #2
[1489.113370] Hardware name: Dell Inc. Precision T5610/0WN7Y6, BIOS A16 02/05/2018
[1489.113370] RIP: 0010:scsi_init_io+0x111/0x1a0 [scsi_mod]
[1489.113370] RSP: 0018:ffff880c6fc03d78 EFLAGS: 00010046
[1489.113370] RAX: 0000000000000000 RBX: ffff880c14cdd400 RCX: 0000000000000000
[1489.113370] RDX: 0000000000000000 RSI: ffff880c14cdd400 RDI: ffff880c14cdd548
[1489.113370] RBP: ffff880c14cdd548 R08: 0000000000000000 R09: ffff880c14cdd580
[1489.113370] R10: ffff880bd7e03088 R11: 0000000000000000 R12: ffff880c37353000
[1489.113370] R13: 0000000000000000 R14: ffff880c37353000 R15: ffff880c3333b1e0
[1489.113370] FS:  0000000000000000(0000) GS:ffff880c6fc00000(0000) knlGS:0000000000000000
[1489.113370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1489.113370] CR2: 00007fbd5adb4000 CR3: 0000000001c09005 CR4: 00000000001626f0
[1489.113370] Call Trace:
[1489.113370]  <IRQ>
[1489.113370]  ? scsi_setup_cmnd+0xb3/0x140 [scsi_mod]
[1489.113370]  ? scsi_prep_fn+0x53/0x130 [scsi_mod]
[1489.113370]  ? __update_load_avg_cfs_rq.isra.3+0x166/0x170
[1489.113370]  ? blk_peek_request+0x136/0x220
[1489.113370]  ? scsi_request_fn+0x2b/0x510 [scsi_mod]
[1489.113370]  ? __blk_run_queue+0x34/0x50
[1489.113370]  ? blk_run_queue+0x26/0x40
[1489.113370]  ? scsi_run_queue+0x229/0x2b0 [scsi_mod]
[1489.113370]  ? scsi_io_completion+0x3ce/0x5a0 [scsi_mod]
[1489.113370]  ? blk_done_softirq+0x67/0x80
[1489.113370]  ? __do_softirq+0xdb/0x1dd
[1489.113370]  ? irq_exit+0xa3/0xb0
[1489.113370]  ? do_IRQ+0x45/0xc0
[1489.113370]  ? common_interrupt+0x77/0x77
[1489.113370]  </IRQ>
[1489.113370]  ? cpuidle_enter_state+0x124/0x200
[1489.113370]  ? cpuidle_enter_state+0x119/0x200
[1489.113370]  ? do_idle+0xdc/0x180
[1489.113370]  ? cpu_startup_entry+0x14/0x20
[1489.113370]  ? start_kernel+0x386/0x38e
[1489.113370]  ? secondary_startup_64+0xa5/0xb0
[1489.113370] Code: 8b 7b 30 e8 62 e2 1f e1 49 8b 17 4c 89 ff 89 c6 89 44 24 04 e8 c1 f7 21 e1 85 c0 41 89 c4 74 55 41 bc 02 00 00 00 e9 39 ff ff ff <0f> 0b 41 bc 01 00 00 00 e9 2c ff ff ff 48 8b 3d 6b dc 00 00 be 
[1489.113370] ---[ end trace 60f9802b953c86c0 ]---
[1489.113370] ------------[ cut here ]------------
[1489.113370] kernel BUG at /usr/src/linux/dist/4.15.12-nobklcd/block/blk-core.c:3235!
[1489.113370] invalid opcode: 0000 [#1] PREEMPT SMP
[1489.113370] Modules linked in: vhost_net tap tun netconsole dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic md_mod dm_crypt algif_skcipher af_alg dm_mod dax af_packet iscsi_target_mod tcm_loop vhost_scsi vhost target_core_file target_core_iblock target_core_pscsi target_core_mod nfsd exportfs dummy bridge stp llc ib_iser rdma_cm iw_cm ib_cm ib_core ipv6 iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi configfs sr_mod cdrom adt7475 hwmon_vid sd_mod sg coretemp x86_pkg_temp_thermal kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc nouveau video led_class drm_kms_helper cfbfillrect snd_hda_codec_realtek syscopyarea cfbimgblt snd_hda_codec_generic
[1489.113370]  sysfillrect sysimgblt fb_sys_fops cfbcopyarea ttm drm agpgart igb snd_hda_intel aesni_intel snd_hda_codec aes_x86_64 snd_hda_core hwmon crypto_simd mptsas glue_helper mpt3sas i2c_algo_bit snd_pcm_oss mptscsih i2c_core snd_mixer_oss mptbase raid_class snd_pcm scsi_transport_sas wmi snd_timer snd soundcore ahci libahci libata scsi_mod button unix [last unloaded: netconsole]
[1489.113370] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.12 #2
[1489.113370] Hardware name: Dell Inc. Precision T5610/0WN7Y6, BIOS A16 02/05/2018
[1489.113370] RIP: 0010:__blk_end_request_all+0x50/0x60
[1489.113370] RSP: 0018:ffff880c6fc03df8 EFLAGS: 00010002
[1489.113370] RAX: 0000000000000001 RBX: ffff880c3333b1e0 RCX: 0000000000000000
[1489.113370] RDX: 0000000000000001 RSI: ffff880c257a7f00 RDI: 0000000000000000
[1489.113370] RBP: 0000000000000001 R08: 0000000000000000 R09: ffff880c14cdd580
[1489.113370] R10: ffff880bd7e03088 R11: 0000000000000000 R12: ffff880c14cdd400
[1489.113370] R13: ffff880c3333b1e0 R14: 0000000000000246 R15: ffff880c3333b1e0
[1489.113370] FS:  0000000000000000(0000) GS:ffff880c6fc00000(0000) knlGS:0000000000000000
[1489.113370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1489.113370] CR2: 00007fbd5adb4000 CR3: 0000000001c09005 CR4: 00000000001626f0
[1489.113370] Call Trace:
[1489.113370]  <IRQ>
[1489.113370]  ? blk_peek_request+0x173/0x220
[1489.113370]  ? scsi_request_fn+0x2b/0x510 [scsi_mod]
[1489.113370]  ? __blk_run_queue+0x34/0x50
[1489.113370]  ? blk_run_queue+0x26/0x40
[1489.113370]  ? scsi_run_queue+0x229/0x2b0 [scsi_mod]
[1489.113370]  ? scsi_io_completion+0x3ce/0x5a0 [scsi_mod]
[1489.113370]  ? blk_done_softirq+0x67/0x80
[1489.113370]  ? __do_softirq+0xdb/0x1dd
[1489.113370]  ? irq_exit+0xa3/0xb0
[1489.113370]  ? do_IRQ+0x45/0xc0
[1489.113370]  ? common_interrupt+0x77/0x77
[1489.113370]  </IRQ>
[1489.113370]  ? cpuidle_enter_state+0x124/0x200
[1489.113370]  ? cpuidle_enter_state+0x119/0x200
[1489.113370]  ? do_idle+0xdc/0x180
[1489.113370]  ? cpu_startup_entry+0x14/0x20
[1489.113370]  ? start_kernel+0x386/0x38e
[1489.113370]  ? secondary_startup_64+0xa5/0xb0
[1489.113370] Code: ff ff ff 84 c0 75 24 c3 0f 0b 48 8b 87 40 01 00 00 31 c9 48 85 c0 74 df 8b 48 58 40 0f b6 f6 8b 57 58 e8 04 ff ff ff 84 c0 74 dc <0f> 0b 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41 54 55 53 48 
[1489.113370] RIP: __blk_end_request_all+0x50/0x60 RSP: ffff880c6fc03df8
[1489.113370] ---[ end trace 60f9802b953c86c1 ]---
[1489.113370] Kernel panic - not syncing: Fatal exception in interrupt
[1489.113370] Kernel Offset: disabled
[1489.113370] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

Here's the oops from the 2nd one:
[ 131.975234] WARNING: CPU: 0 PID: 0 at /usr/src/linux/dist/4.15.12-nobklcd/drivers/scsi/scsi_lib.c:1068 scsi_init_io+0x111/0x1a0 [scsi_mod]
[ 131.975245] Modules linked in: af_packet iscsi_target_mod tcm_loop vhost_scsi vhost target_core_file target_core_iblock target_core_pscsi target_core_mod nfsd exportfs dummy bridge stp llc ib_iser rdma_cm iw_cm ib_cm ib_core ipv6 iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi netconsole configfs adt7475 hwmon_vid coretemp x86_pkg_temp_thermal sr_mod cdrom kvm_intel kvm irqbypass nouveau crct10dif_pclmul crc32_pclmul sd_mod crc32c_intel video sg ghash_clmulni_intel led_class snd_hda_codec_realtek pcbc drm_kms_helper snd_hda_codec_generic cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops snd_hda_intel cfbcopyarea snd_hda_codec ttm snd_hda_core drm aesni_intel snd_pcm_oss agpgart aes_x86_64 snd_mixer_oss igb snd_pcm crypto_simd mptsas mpt3sas glue_helper ahci hwmon snd_timer
[ 131.975290]  mptscsih raid_class i2c_algo_bit libahci snd mptbase libata scsi_transport_sas i2c_core wmi soundcore scsi_mod button unix
[ 131.975301] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.12 #2
[ 131.975304] Hardware name: Dell Inc. Precision T5610/0WN7Y6, BIOS A16 02/05/2018
[ 131.975310] RIP: 0010:scsi_init_io+0x111/0x1a0 [scsi_mod]
[ 131.975312] RSP: 0018:ffff880c6fc03d78 EFLAGS: 00010046
[ 131.975315] RAX: 0000000000000000 RBX: ffff880c30b00000 RCX: 0000000000000000
[ 131.975318] RDX: 0000000000000000 RSI: ffff880c30b00000 RDI: ffff880c30b00148
[ 131.975320] RBP: ffff880c30b00148 R08: 0000000000000000 R09: ffff880c30b00180
[ 131.975322] R10: ffff880c36c69088 R11: 0000000000000000 R12: ffff880c37300800
[ 131.975324] R13: 0000000000000000 R14: ffff880c37300800 R15: ffff880c33692990
[ 131.975327] FS:  0000000000000000(0000) GS:ffff880c6fc00000(0000) knlGS:0000000000000000
[ 131.975330] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 131.975333] CR2: 000000000179bbe0 CR3: 0000000001c09005 CR4: 00000000001606f0
[ 131.975335] Call Trace:
[ 131.975339]  <IRQ>
[ 131.975347]  ? scsi_setup_cmnd+0xb3/0x140 [scsi_mod]
[ 131.975353]  ? scsi_prep_fn+0x53/0x130 [scsi_mod]
[ 131.975360]  ? blk_peek_request+0x136/0x220
[ 131.975365]  ? scsi_request_fn+0x2b/0x510 [scsi_mod]
[ 131.975369]  ? __blk_run_queue+0x34/0x50
[ 131.975372]  ? blk_run_queue+0x26/0x40
[ 131.975377]  ? scsi_run_queue+0x229/0x2b0 [scsi_mod]
[ 131.975382]  ? scsi_io_completion+0x3ce/0x5a0 [scsi_mod]
[ 131.975386]  ? blk_done_softirq+0x67/0x80
[ 131.975390]  ? __do_softirq+0xdb/0x1dd
[ 131.975396]  ? irq_exit+0xa3/0xb0
[ 131.975399]  ? do_IRQ+0x45/0xc0
[ 131.975403]  ? common_interrupt+0x77/0x77
[ 131.975406]  </IRQ>
[ 131.975411]  ? cpuidle_enter_state+0x124/0x200
[ 131.975414]  ? cpuidle_enter_state+0x119/0x200
[ 131.975418]  ? do_idle+0xdc/0x180
[ 131.975421]  ? cpu_startup_entry+0x14/0x20
[ 131.975425]  ? start_kernel+0x386/0x38e
[ 131.975429]  ? secondary_startup_64+0xa5/0xb0
[ 131.975431] Code: 8b 7b 30 e8 62 52 1f e1 49 8b 17 4c 89 ff 89 c6 89 44 24 04 e8 c1 67 21 e1 85 c0 41 89 c4 74 55 41 bc 02 00 00 00 e9 39 ff ff ff <0f> 0b 41 bc 01 00 00 00 e9 2c ff ff ff 48 8b 3d 6b dc 00 00 be 
[ 131.975463] ---[ end trace d0914a85cf373d2b ]---
[ 131.975470] ------------[ cut here ]------------
[ 131.975473] kernel BUG at /usr/src/linux/dist/4.15.12-nobklcd/block/blk-core.c:3235!
[ 131.975478] invalid opcode: 0000 [#1] PREEMPT SMP
[ 131.975513] Modules linked in: af_packet iscsi_target_mod tcm_loop vhost_scsi vhost target_core_file target_core_iblock target_core_pscsi target_core_mod nfsd exportfs dummy bridge stp llc ib_iser rdma_cm iw_cm ib_cm ib_core ipv6 iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi netconsole configfs adt7475 hwmon_vid coretemp x86_pkg_temp_thermal sr_mod cdrom kvm_intel kvm irqbypass nouveau crct10dif_pclmul crc32_pclmul sd_mod crc32c_intel video sg ghash_clmulni_intel led_class snd_hda_codec_realtek pcbc drm_kms_helper snd_hda_codec_generic cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops snd_hda_intel cfbcopyarea snd_hda_codec ttm snd_hda_core drm aesni_intel snd_pcm_oss agpgart aes_x86_64 snd_mixer_oss igb snd_pcm crypto_simd mptsas mpt3sas glue_helper ahci hwmon snd_timer
[ 131.975882]  mptscsih raid_class i2c_algo_bit libahci snd mptbase libata scsi_transport_sas i2c_core wmi soundcore scsi_mod button unix
[ 131.975946] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.12 #2
[ 131.975982] Hardware name: Dell Inc. Precision T5610/0WN7Y6, BIOS A16 02/05/2018
[ 131.976022] RIP: 0010:__blk_end_request_all+0x50/0x60
[ 131.976049] RSP: 0018:ffff880c6fc03df8 EFLAGS: 00010002
[ 131.976077] RAX: 0000000000000001 RBX: ffff880c33692990 RCX: 0000000000000000
[ 131.976114] RDX: 0000000000000001 RSI: ffff880c31550d80 RDI: 0000000000000000
[ 131.976150] RBP: 0000000000000001 R08: 0000000000000000 R09: ffff880c30b00180
[ 131.976185] R10: ffff880c36c69088 R11: 0000000000000000 R12: ffff880c30b00000
[ 131.976221] R13: ffff880c33692990 R14: 0000000000000246 R15: ffff880c33692990
[ 131.976256] FS:  0000000000000000(0000) GS:ffff880c6fc00000(0000) knlGS:0000000000000000
[ 131.976296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 131.976325] CR2: 000000000179bbe0 CR3: 0000000001c09005 CR4: 00000000001606f0
[ 131.976359] Call Trace:
[ 131.976374]  <IRQ>
[ 131.976387]  ? blk_peek_request+0x173/0x220
[ 131.976412]  ? scsi_request_fn+0x2b/0x510 [scsi_mod]
[ 131.976439]  ? __blk_run_queue+0x34/0x50
[ 131.976462]  ? blk_run_queue+0x26/0x40
[ 131.976485]  ? scsi_run_queue+0x229/0x2b0 [scsi_mod]
[ 131.976514]  ? scsi_io_completion+0x3ce/0x5a0 [scsi_mod]
[ 131.976543]  ? blk_done_softirq+0x67/0x80
[ 131.976566]  ? __do_softirq+0xdb/0x1dd
[ 131.976587]  ? irq_exit+0xa3/0xb0
[ 131.976606]  ? do_IRQ+0x45/0xc0
[ 131.976625]  ? common_interrupt+0x77/0x77
[ 131.976646]  </IRQ>
[ 131.976660]  ? cpuidle_enter_state+0x124/0x200
[ 131.976684]  ? cpuidle_enter_state+0x119/0x200
[ 131.976709]  ? do_idle+0xdc/0x180
[ 131.976729]  ? cpu_startup_entry+0x14/0x20
[ 131.976752]  ? start_kernel+0x386/0x38e
[ 131.976774]  ? secondary_startup_64+0xa5/0xb0
[ 131.976797] Code: ff ff ff 84 c0 75 24 c3 0f 0b 48 8b 87 40 01 00 00 31 c9 48 85 c0 74 df 8b 48 58 40 0f b6 f6 8b 57 58 e8 04 ff ff ff 84 c0 74 dc <0f> 0b 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41 54 55 53 48 
[ 131.976917] RIP: __blk_end_request_all+0x50/0x60 RSP: ffff880c6fc03df8
[ 131.982799] ---[ end trace d0914a85cf373d2c ]---
[ 131.982799] Kernel panic - not syncing: Fatal exception in interrupt
[ 131.982799] Kernel Offset: disabled
[ 131.982799] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
