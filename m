Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C84A2156F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C84A2156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libmpq.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeHORWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:22:46 -0400
Received: from libmpq.org ([85.25.94.4]:58260 "EHLO mail.libmpq.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbeHORWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:22:46 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2018 13:22:44 EDT
Received: from libmpq.org (bart.theraso.int [172.16.50.100])
        by mail.libmpq.org (Postfix) with ESMTPSA id D6A7638FA87;
        Wed, 15 Aug 2018 16:23:46 +0200 (CEST)
Date:   Wed, 15 Aug 2018 16:23:46 +0200
From:   Maik Broemme <mbroemme@libmpq.org>
To:     netdev <netdev@vger.kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] Kernel Oops and crash using i40e VF devices
Message-ID: <20180815142346.GC2354@libmpq.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux bart.theraso.int 4.17.10-1-ARCH 
X-PGP-Key-FingerPrint: 109D 0AC6 86CF 06BD 4890  17B0 8FB9 9971 4EEB 31F1
Organization: Personal
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a SuperMicro X11SPM-F mainboard with two Intel X722 devices which
support up to 32 VF devices per PF device. They are running with i40e
driver. Whenever I try to use the VF devices in Xen VMs, the host kernel
got an Oops or crash. In all cases the PF running on the host
immediately loses network connection. I can reproduce this always
running the following:

Enable VFs:

$> echo 24 > /sys/bus/pci/devices/0000:b5:00.2/sriov_numvfs
$> echo 2 > /sys/bus/pci/devices/0000:b5:00.3/sriov_numvfs

Assign MACs:

$> ip link set net0 vf 0 mac 00:16:3e:00:b9:1e
...

Enable trust:

$> ip link set net0 vf 0 trust on
...

Assign NIcs:
xl pci-assignable-add b5:0a.0
...

If I start 1 VM everything works fine, as soon as I start a second one,
the host becomes unavailable and the log shows the following:

Aug 15 12:33:44 server kernel: xen_pciback: vpci: 0000:b5:0b.3: assign to virtual slot 0
Aug 15 12:33:44 server kernel: pciback 0000:b5:0b.3: registering for 3
Aug 15 12:33:58 server kernel: xen-blkback: backend/vbd/3/51712: using 2 queues, protocol 1 (x86_64-abi) persistent grants
Aug 15 12:34:04 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:34:04 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:34:10 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:34:10 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:34:10 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:34:10 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:34:41 server kernel: i40e 0000:b5:00.2: VSI seid 409 Tx ring 175 disable timeout
Aug 15 12:34:52 server kernel: i40e 0000:b5:00.2: VSI seid 409 Tx ring 175 disable timeout
Aug 15 12:34:58 server kernel: i40e 0000:b5:00.2: VSI seid 409 Tx ring 175 disable timeout
Aug 15 12:35:09 server kernel: i40e 0000:b5:00.2: VSI seid 409 Tx ring 175 disable timeout
Aug 15 12:35:55 server kernel: i40e 0000:b5:00.2: VSI seid 409 Tx ring 175 disable timeout
Aug 15 12:36:26 server kernel: i40e 0000:b5:00.2: VSI seid 409 Tx ring 175 disable timeout
Aug 15 12:36:39 server kernel: i40e 0000:b5:00.2: VSI seid 409 Tx ring 175 disable timeout
Aug 15 12:36:41 server kernel: i40e 0000:b5:00.2: VSI seid 409 Tx ring 175 disable timeout
Aug 15 12:36:41 server kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
Aug 15 12:36:41 server kernel: PGD 0 P4D 0
Aug 15 12:36:41 server kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
Aug 15 12:36:41 server kernel: Modules linked in: dm_crypt algif_skcipher af_alg bonding intel_rapl skx_edac nfit intel_powerclamp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc iTCO_wdt iTCO_vendor_support nls_iso8859_1 nls_cp437 vfat aesni_intel fat aes_x86_64 crypto_simd cryptd glue_helper ofpart ipmi_ssif cmdlinepart intel_rapl_perf pcspkr i40e ast i2c_algo_bit ttm drm_kms_helper drm intel_spi_pci intel_spi spi_nor mtd i2c_i801 agpgart syscopyarea joydev sysfillrect sysimgblt fb_sys_fops input_leds mousedev led_class mei_me shpchp lpc_ich mei ioatdma dca wmi ipmi_si ipmi_devintf rtc_cmos ipmi_msghandler acpi_power_meter evdev mac_hid xen_acpi_processor xen_pciback xen_netback xen_blkback xen_gntalloc xen_gntdev xen_evtchn xenfs xen_privcmd ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 fscrypto
Aug 15 12:36:41 server kernel:  hid_generic usbhid hid sd_mod ahci libahci crc32c_intel libata xhci_pci xhci_hcd usbcore usb_common scsi_mod dm_mod
Aug 15 12:36:41 server kernel: CPU: 1 PID: 1326 Comm: logger Not tainted 4.17.14-arch1-1-ARCH #1
Aug 15 12:36:41 server kernel: Hardware name: Supermicro Super Server/X11SPM-F, BIOS 2.1 06/15/2018
Aug 15 12:36:41 server kernel: RIP: e030:__rb_insert_augmented+0x32/0x230
Aug 15 12:36:41 server kernel: RSP: e02b:ffffc90043ed3d98 EFLAGS: 00010246 
Aug 15 12:36:41 server kernel: RAX: ffff880109ddec58 RBX: 0000000000000000 RCX: ffff88010bf2d7c8
Aug 15 12:36:41 server kernel: RDX: 0000000000000000 RSI: ffff88010bf2d7c0 RDI: ffff880109ddec58
Aug 15 12:36:41 server kernel: RBP: ffff88004bf9eb98 R08: ffffffff811e56e0 R09: ffff880109ddec58
Aug 15 12:36:41 server kernel: R10: 0000000000000285 R11: ffff88004bf9eb40 R12: ffff88010bf2d7d0
Aug 15 12:36:41 server kernel: R13: ffff88010bf2d7c0 R14: 00007fdd44c4e000 R15: 0000000000000000
Aug 15 12:36:41 server kernel: FS:  0000000000000000(0000) GS:ffff880115040000(0000) knlGS:0000000000000000
Aug 15 12:36:41 server kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 15 12:36:41 server kernel: CR2: 0000000000000008 CR3: 000000004bd04000 CR4: 0000000000042660
Aug 15 12:36:41 server kernel: Call Trace:
Aug 15 12:36:41 server kernel:  __vma_adjust+0x2bb/0x7d0
Aug 15 12:36:41 server kernel:  ? kmem_cache_alloc+0x179/0x1d0
Aug 15 12:36:41 server kernel:  __split_vma+0x117/0x1c0
Aug 15 12:36:41 server kernel:  mprotect_fixup+0x1f6/0x240
Aug 15 12:36:41 server kernel:  do_mprotect_pkey+0x1b4/0x2f0
Aug 15 12:36:41 server kernel:  ? ksys_mmap_pgoff+0x19e/0x220
Aug 15 12:36:41 server kernel:  __x64_sys_mprotect+0x1b/0x20
Aug 15 12:36:41 server kernel:  do_syscall_64+0x5b/0x170
Aug 15 12:36:41 server kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 15 12:36:41 server kernel: RIP: 0033:0x7fdd44c714cb
Aug 15 12:36:41 server kernel: RSP: 002b:00007ffe224454a8 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
Aug 15 12:36:41 server kernel: RAX: ffffffffffffffda RBX: 00007fdd44c53000 RCX: 00007fdd44c714cb
Aug 15 12:36:41 server kernel: RDX: 0000000000000000 RSI: 00000000001ff000 RDI: 00007fdd44a4f000
Aug 15 12:36:41 server kernel: RBP: 00007ffe22445770 R08: 0000000000000005 R09: 0000000000000000
Aug 15 12:36:41 server kernel: R10: 00007ffe22445858 R11: 0000000000000206 R12: 0000000000000000
Aug 15 12:36:41 server kernel: R13: 000000000000fe01 R14: 00007ffe22445810 R15: 0000000000000002
Aug 15 12:36:41 server kernel: Code: 55 48 89 fd 53 48 83 ec 08 48 8b 07 48 89 c7 84 d2 74 03 48 89 29 48 85 c0 0f 84 c8 01 00 00 48 8b 18 f6 c3 01 0f 85 14 01 00 00 <48> 8b 43 08 48 89 da 48 39 c7 74 6c 48 85 c0 74 09 f6 00 01 0f
Aug 15 12:36:41 server kernel: RIP: __rb_insert_augmented+0x32/0x230 RSP: ffffc90043ed3d98
Aug 15 12:36:41 server kernel: CR2: 0000000000000008
Aug 15 12:36:41 server kernel: ---[ end trace ab257d75c031e186 ]---

After that PF and VFs are no longer accessible. In another try with
same kernel I get:

Aug 15 12:43:05 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:43:05 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:43:05 server kernel: i40e 0000:b5:00.2: Too many MDD events on VF 11, disabled
Aug 15 12:43:05 server kernel: i40e 0000:b5:00.2: Use PF Control I/F to re-enable the VF
Aug 15 12:43:05 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:43:05 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:43:05 server kernel: i40e 0000:b5:00.2: Too many MDD events on VF 11, disabled
Aug 15 12:43:05 server kernel: i40e 0000:b5:00.2: Use PF Control I/F to re-enable the VF
Aug 15 12:43:05 server kernel: bond0: link status definitely down for interface net0, disabling it
Aug 15 12:43:05 server kernel: bond0: now running without any active interface!
Aug 15 12:43:06 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:43:06 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:43:06 server kernel: i40e 0000:b5:00.2: Too many MDD events on VF 11, disabled
Aug 15 12:43:06 server kernel: i40e 0000:b5:00.2: Use PF Control I/F to re-enable the VF
Aug 15 12:43:06 server kernel: bond0: link status definitely up for interface net0, 1000 Mbps full duplex
Aug 15 12:43:06 server kernel: bond0: first active interface up!
Aug 15 12:43:06 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:43:06 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:43:06 server kernel: i40e 0000:b5:00.2: Too many MDD events on VF 11, disabled
Aug 15 12:43:06 server kernel: i40e 0000:b5:00.2: Use PF Control I/F to re-enable the VF
...
Aug 15 12:43:28 server kernel: WARNING: CPU: 0 PID: 2649 at arch/x86/xen/multicalls.c:130 xen_mc_flush+0x1cd/0x1e0
Aug 15 12:43:28 server kernel: Modules linked in: dm_crypt algif_skcipher af_alg bonding intel_rapl skx_edac nfit intel_powerclamp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc joydev mousedev input_leds led_class iTCO_wdt iTCO_vendor_support hid_generic ipmi_ssif aesni_intel aes_x86_64 crypto_simd cryptd glue_helper nls_iso8859_1 nls_cp437 vfat fat ofpart cmdlinepart intel_rapl_perf pcspkr ast i2c_algo_bit ttm drm_kms_helper i40e drm agpgart syscopyarea sysfillrect sysimgblt fb_sys_fops intel_spi_pci intel_spi spi_nor mtd i2c_i801 lpc_ich usbhid hid shpchp mei_me mei ioatdma dca wmi ipmi_si ipmi_devintf rtc_cmos ipmi_msghandler acpi_power_meter evdev mac_hid xen_acpi_processor xen_pciback xen_netback xen_blkback xenfs xen_privcmd xen_gntalloc xen_gntdev xen_evtchn ip_tables x_tables ext4 crc32c_generic crc16
Aug 15 12:43:28 server kernel:  mbcache jbd2 fscrypto sd_mod ahci libahci crc32c_intel xhci_pci xhci_hcd usbcore libata usb_common scsi_mod dm_mod
Aug 15 12:43:28 server kernel: CPU: 0 PID: 2649 Comm: cc1 Not tainted 4.17.14-arch1-1-ARCH #1
Aug 15 12:43:28 server kernel: Hardware name: Supermicro Super Server/X11SPM-F, BIOS 2.1 06/15/2018
Aug 15 12:43:28 server kernel: RIP: e030:xen_mc_flush+0x1cd/0x1e0
Aug 15 12:43:28 server kernel: RSP: e02b:ffffc90045dbfc90 EFLAGS: 00010002
Aug 15 12:43:28 server kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8801150141d8
Aug 15 12:43:28 server kernel: RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000080000001
Aug 15 12:43:28 server kernel: RBP: 0000000000000001 R08: ffffea000123ee80 R09: 0000000000000950
Aug 15 12:43:28 server kernel: R10: ffff8800062daff8 R11: 0000000000000000 R12: 0000000080000001
Aug 15 12:43:28 server kernel: R13: ffff880115014140 R14: ffff880115014150 R15: 0000000000000002
Aug 15 12:43:28 server kernel: FS:  00007fc772128ac0(0000) GS:ffff880115000000(0000) knlGS:0000000000000000
Aug 15 12:43:28 server kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 15 12:43:28 server kernel: CR2: 0000000000d549f0 CR3: 000000004d762000 CR4: 0000000000042660
Aug 15 12:43:28 server kernel: Call Trace:
Aug 15 12:43:28 server kernel:  xen_alloc_pte+0x3b3/0x3c0
Aug 15 12:43:28 server kernel:  alloc_set_pte+0x326/0x500
Aug 15 12:43:28 server kernel:  filemap_map_pages+0x37b/0x3b0
Aug 15 12:43:28 server kernel:  __handle_mm_fault+0xf7d/0x1480
Aug 15 12:43:28 server kernel:  handle_mm_fault+0x10a/0x250
Aug 15 12:43:28 server kernel:  __do_page_fault+0x214/0x570
Aug 15 12:43:28 server kernel:  do_page_fault+0x32/0x130
Aug 15 12:43:28 server kernel:  ? page_fault+0x8/0x30
Aug 15 12:43:28 server kernel:  page_fault+0x1e/0x30
Aug 15 12:43:28 server kernel: RIP: e033:0xd549f0
Aug 15 12:43:28 server kernel: RSP: e02b:00007ffdc8058bb8 EFLAGS: 00010246
Aug 15 12:43:28 server kernel: RAX: 0000000000000000 RBX: 000000000000001a RCX: 00000000000000e0
Aug 15 12:43:28 server kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001dec220
Aug 15 12:43:28 server kernel: RBP: 0000000000000024 R08: 000000000268bec0 R09: 0000000000000000
Aug 15 12:43:28 server kernel: R10: 000000000268b010 R11: 0000000000000000 R12: 0000000001ca43d8
Aug 15 12:43:28 server kernel: R13: 000000000000002b R14: 00007ffdc8058ce8 R15: 00007ffdc8058e48
Aug 15 12:43:28 server kernel: Code: 81 e8 c8 ee 9e 00 0f 1f 00 49 89 45 18 48 c1 e8 3f 48 89 c5 e9 ed fe ff ff ff 14 25 80 64 02 82 f6 c4 02 0f 84 6c fe ff ff 0f 0b <0f> 0b e9 26 ff ff ff 0f 0b e8 da f3 fe ff eb 83 0f 0b 90 0f 1f
Aug 15 12:43:28 server kernel: ---[ end trace ff1c4f9a6f1cb2a0 ]---
Aug 15 12:43:28 server kernel: WARNING: CPU: 0 PID: 2649 at arch/x86/xen/multicalls.c:130 xen_mc_flush+0x1cd/0x1e0
Aug 15 12:43:28 server kernel: Modules linked in: dm_crypt algif_skcipher af_alg bonding intel_rapl skx_edac nfit intel_powerclamp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc joydev mousedev input_leds led_class iTCO_wdt iTCO_vendor_support hid_generic ipmi_ssif aesni_intel aes_x86_64 crypto_simd cryptd glue_helper nls_iso8859_1 nls_cp437 vfat fat ofpart cmdlinepart intel_rapl_perf pcspkr ast i2c_algo_bit ttm drm_kms_helper i40e drm agpgart syscopyarea sysfillrect sysimgblt fb_sys_fops intel_spi_pci intel_spi spi_nor mtd i2c_i801 lpc_ich usbhid hid shpchp mei_me mei ioatdma dca wmi ipmi_si ipmi_devintf rtc_cmos ipmi_msghandler acpi_power_meter evdev mac_hid xen_acpi_processor xen_pciback xen_netback xen_blkback xenfs xen_privcmd xen_gntalloc xen_gntdev xen_evtchn ip_tables x_tables ext4 crc32c_generic crc16
Aug 15 12:43:28 server kernel:  mbcache jbd2 fscrypto sd_mod ahci libahci crc32c_intel xhci_pci xhci_hcd usbcore libata usb_common scsi_mod dm_mod
Aug 15 12:43:28 server kernel: CPU: 0 PID: 2649 Comm: cc1 Tainted: G        W         4.17.14-arch1-1-ARCH #1
Aug 15 12:43:28 server kernel: Hardware name: Supermicro Super Server/X11SPM-F, BIOS 2.1 06/15/2018
Aug 15 12:43:28 server kernel: RIP: e030:xen_mc_flush+0x1cd/0x1e0
Aug 15 12:43:28 server kernel: RSP: e02b:ffffc90045dbfc90 EFLAGS: 00010002
Aug 15 12:43:28 server kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
Aug 15 12:43:28 server kernel: RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000080000002
Aug 15 12:43:28 server kernel: RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000950
Aug 15 12:43:28 server kernel: R10: 0000000000007ff0 R11: 0000000000000000 R12: 0000000080000002
Aug 15 12:43:28 server kernel: R13: ffff880115014140 R14: 0000000000000202 R15: 0000000000000001
Aug 15 12:43:28 server kernel: FS:  00007fc772128ac0(0000) GS:ffff880115000000(0000) knlGS:0000000000000000
Aug 15 12:43:28 server kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 15 12:43:28 server kernel: CR2: 0000000000d549f0 CR3: 000000004d762000 CR4: 0000000000042660
Aug 15 12:43:28 server kernel: Call Trace:
Aug 15 12:43:28 server kernel:  xen_set_pmd_hyper+0x16c/0x190
Aug 15 12:43:28 server kernel:  alloc_set_pte+0x34d/0x500
Aug 15 12:43:28 server kernel:  filemap_map_pages+0x37b/0x3b0
Aug 15 12:43:28 server kernel:  __handle_mm_fault+0xf7d/0x1480
Aug 15 12:43:28 server kernel:  handle_mm_fault+0x10a/0x250
Aug 15 12:43:28 server kernel:  __do_page_fault+0x214/0x570
Aug 15 12:43:28 server kernel:  do_page_fault+0x32/0x130
Aug 15 12:43:28 server kernel:  ? page_fault+0x8/0x30
Aug 15 12:43:28 server kernel:  page_fault+0x1e/0x30
Aug 15 12:43:28 server kernel: RIP: e033:0xd549f0
Aug 15 12:43:28 server kernel: RSP: e02b:00007ffdc8058bb8 EFLAGS: 00010246
Aug 15 12:43:28 server kernel: RAX: 0000000000000000 RBX: 000000000000001a RCX: 00000000000000e0
Aug 15 12:43:28 server kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001dec220
Aug 15 12:43:28 server kernel: RBP: 0000000000000024 R08: 000000000268bec0 R09: 0000000000000000
Aug 15 12:43:28 server kernel: R10: 000000000268b010 R11: 0000000000000000 R12: 0000000001ca43d8
Aug 15 12:43:28 server kernel: R13: 000000000000002b R14: 00007ffdc8058ce8 R15: 00007ffdc8058e48
Aug 15 12:43:28 server kernel: Code: 81 e8 c8 ee 9e 00 0f 1f 00 49 89 45 18 48 c1 e8 3f 48 89 c5 e9 ed fe ff ff ff 14 25 80 64 02 82 f6 c4 02 0f 84 6c fe ff ff 0f 0b <0f> 0b e9 26 ff ff ff 0f 0b e8 da f3 fe ff eb 83 0f 0b 90 0f 1f
Aug 15 12:43:28 server kernel: ---[ end trace ff1c4f9a6f1cb2a1 ]---
Aug 15 12:43:28 server kernel: BUG: non-zero pgtables_bytes on freeing mm: 4096
Aug 15 12:43:28 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:43:28 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:43:28 server kernel: i40e 0000:b5:00.2: Too many MDD events on VF 11, disabled
Aug 15 12:43:28 server kernel: i40e 0000:b5:00.2: Use PF Control I/F to re-enable the VF
Aug 15 12:43:29 server kernel: i40e 0000:b5:00.2: TX driver issue detected, PF reset issued
Aug 15 12:43:29 server kernel: i40e 0000:b5:00.2: TX driver issue detected on VF 11
Aug 15 12:43:29 server kernel: i40e 0000:b5:00.2: Too many MDD events on VF 11, disabled
Aug 15 12:43:29 server kernel: i40e 0000:b5:00.2: Use PF Control I/F to re-enable the VF
...
Aug 15 12:43:39 server kernel: BUG: unable to handle kernel paging request at 0000001fb3ed20dc
Aug 15 12:43:39 server kernel: PGD 0 P4D 0
Aug 15 12:43:39 server kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
Aug 15 12:43:39 server kernel: Modules linked in: dm_crypt algif_skcipher af_alg bonding intel_rapl skx_edac nfit intel_powerclamp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc joydev mousedev input_leds led_class iTCO_wdt iTCO_vendor_support hid_generic ipmi_ssif aesni_intel aes_x86_64 crypto_simd cryptd glue_helper nls_iso8859_1 nls_cp437 vfat fat ofpart cmdlinepart intel_rapl_perf pcspkr ast i2c_algo_bit ttm drm_kms_helper i40e drm agpgart syscopyarea sysfillrect sysimgblt fb_sys_fops intel_spi_pci intel_spi spi_nor mtd i2c_i801 lpc_ich usbhid hid shpchp mei_me mei ioatdma dca wmi ipmi_si ipmi_devintf rtc_cmos ipmi_msghandler acpi_power_meter evdev mac_hid xen_acpi_processor xen_pciback xen_netback xen_blkback xenfs xen_privcmd xen_gntalloc xen_gntdev xen_evtchn ip_tables x_tables ext4 crc32c_generic crc16
Aug 15 12:43:39 server kernel:  mbcache jbd2 fscrypto sd_mod ahci libahci crc32c_intel xhci_pci xhci_hcd usbcore libata usb_common scsi_mod dm_mod
Aug 15 12:43:39 server kernel: CPU: 0 PID: 4 Comm: kworker/0:0 Tainted: G        W         4.17.14-arch1-1-ARCH #1
Aug 15 12:43:39 server kernel: Hardware name: Supermicro Super Server/X11SPM-F, BIOS 2.1 06/15/2018
Aug 15 12:43:39 server kernel: Workqueue: i40e i40e_service_task [i40e]
Aug 15 12:43:39 server kernel: RIP: e030:__page_frag_cache_drain+0x5/0x30
Aug 15 12:43:39 server kernel: RSP: e02b:ffffc900400e7d10 EFLAGS: 00010292
Aug 15 12:43:39 server kernel: RAX: 0000000000000000 RBX: ffff88004cb49ff8 RCX: ffff880067f86000
Aug 15 12:43:39 server kernel: RDX: 000077ff80000000 RSI: 0000000000000000 RDI: 0000001fb3ed20c0
Aug 15 12:43:39 server kernel: RBP: ffff88010b3d2140 R08: 0000000000000022 R09: 0000000000000058
Aug 15 12:43:39 server kernel: R10: ffffea000010fc20 R11: 0000000000000000 R12: 0000000000000155
Aug 15 12:43:39 server kernel: R13: 0000000000001000 R14: ffff88010b339f40 R15: ffff88010b5c1000
Aug 15 12:43:39 server kernel: FS:  0000000000000000(0000) GS:ffff880115000000(0000) knlGS:0000000000000000
Aug 15 12:43:39 server kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 15 12:43:39 server kernel: CR2: 0000001fb3ed20dc CR3: 0000000104b32000 CR4: 0000000000042660
Aug 15 12:43:39 server kernel: Call Trace:
Aug 15 12:43:39 server kernel:  i40e_clean_rx_ring+0xc5/0x1b0 [i40e]
Aug 15 12:43:39 server kernel:  i40e_down+0x16b/0x1b0 [i40e]
Aug 15 12:43:39 server kernel:  i40e_vsi_close+0x78/0x80 [i40e]
Aug 15 12:43:39 server kernel:  i40e_close+0x11/0x20 [i40e]
Aug 15 12:43:39 server kernel:  i40e_pf_quiesce_all_vsi.isra.48+0x34/0x50 [i40e]
Aug 15 12:43:39 server kernel:  i40e_prep_for_reset+0x117/0x130 [i40e]
Aug 15 12:43:39 server kernel:  i40e_do_reset+0xb0/0x200 [i40e]
Aug 15 12:43:39 server kernel:  i40e_service_task+0x908/0x1150 [i40e]
Aug 15 12:43:39 server kernel:  ? finish_task_switch+0x83/0x2e0
Aug 15 12:43:39 server kernel:  process_one_work+0x1d1/0x3b0
Aug 15 12:43:39 server kernel:  worker_thread+0x2b/0x3d0
Aug 15 12:43:39 server kernel:  ? process_one_work+0x3b0/0x3b0
Aug 15 12:43:39 server kernel:  kthread+0x112/0x130
Aug 15 12:43:39 server kernel:  ? kthread_flush_work_fn+0x10/0x10
Aug 15 12:43:39 server kernel:  ret_from_fork+0x35/0x40
Aug 15 12:43:39 server kernel: Code: 39 ef 73 1e 48 89 fb 48 85 db 74 0a 31 f6 48 89 df e8 70 fe ff ff 48 81 c3 00 10 00 00 48 39 dd 77 e5 5b 5d c3 90 0f 1f 44 00 00 <f0> 29 77 1c 75 15 48 8b 07 f6 c4 80 74 08 0f b6 77 69 85 f6 75
Aug 15 12:43:39 server kernel: RIP: __page_frag_cache_drain+0x5/0x30 RSP: ffffc900400e7d10
Aug 15 12:43:39 server kernel: CR2: 0000001fb3ed20dc
Aug 15 12:43:39 server kernel: ---[ end trace ff1c4f9a6f1cb2a2 ]---
Aug 15 12:44:03 server systemd[1]: Started Session c4 of user root.
Aug 15 12:44:39 server systemd-timesyncd[675]: Timed out waiting for reply from 176.9.144.121:123 (3.arch.pool.ntp.org).
Aug 15 12:44:49 server systemd-timesyncd[675]: Timed out waiting for reply from 146.0.32.144:123 (3.arch.pool.ntp.org).
Aug 15 12:45:00 server systemd-timesyncd[675]: Timed out waiting for reply from 138.201.20.231:123 (3.arch.pool.ntp.org).
Aug 15 12:45:10 server systemd-timesyncd[675]: Timed out waiting for reply from 94.16.116.137:123 (3.arch.pool.ntp.org).

This can be easily reproduced on my system in all cases when running 2
VMs simultaneously.

What I've done so far:

1. I've tried 4.18.0, it is even more worse. With this kernel the system
immediately reboots when assigning MACs to the VFs, sometimes after 1st,
sometimes after 2nd, sometimes after 20th. No errors shown, system just
resets.

2. I've tried 4.14.62 LTS version. VFs are not working at all cause of:
Unable to enable 24 VFs. Limited to 0 VFs due to device resource constraints.

3. I've tried i40e version 2.4.10 from https://sourceforge.net/projects/e1000/files/i40e%20stable/2.4.10/
I've tried it with 4.17.14 and 4.14.62 LTS, both lead to kernel freezes
and reboots without any output on the local display.

As intermediate solution I've reverted configuration to use bridges and
put physical NICs into the system for those VMs which requires VLANs and
PPPoE support.

Also the same configuration (same SSD) works with VFs perfectly using a
NIC under ixgb driver.

Any help is very much appreciated as I can test kernel patches on this
machine.

--Maik
