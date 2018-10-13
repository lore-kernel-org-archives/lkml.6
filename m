Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D85C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50402064E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YKcsvLJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50402064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJNBhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 21:37:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47024 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeJNBhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 21:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W/mKDkSoBRCXG8AG6ohilCz5tfZTVhF/c/pLbpJ2GyU=; b=YKcsvLJhF/5dGk6SRYjT5w9OnT
        dzQQGZ68W5i1AhhNEf4mrK504wdcFQrOKne1eV/CYmmiyGsveXtIXtTuUwQUMH0N0q1NGR4/aQ8TC
        XSYwSG8uVbLGCopO1MRRFTUVulyY88LUSwlYE9ZZhgEvjMqeWjR9g1sN8xrufpuRchuE+rPOMPYPb
        n8LHodvHAlAW/gx9W6hUo4c3gn5ctU02fjShQI5wZxqEEO2/gNcfKx0Dsln+3Xa/hby94KgcG+i+O
        p//5wn/066IimIFaBaAV1K6A+DKidr5z1pKDtX5QLcgH5/wQCzWV/jrzhJGPVfOonNgTOJz2Oh4vn
        VDJQu/3Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBOCb-0008Nb-1H; Sat, 13 Oct 2018 17:59:49 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Luis Rodriguez <mcgrof@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: test_kmod: BUG on module removal
Message-ID: <70765c55-7da9-c91c-ff20-3c915bc7ded1@infradead.org>
Date:   Sat, 13 Oct 2018 10:59:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-rc7, on x86_64:

modprobe test_kmod; rmmod test_kmod

[  199.033143] calling  test_kmod_init+0x0/0x1000 [test_kmod] @ 1704
[  199.034636] misc test_kmod0: interface ready
[  199.035468] initcall test_kmod_init+0x0/0x1000 [test_kmod] returned 0 after 1210 usecs
[  206.597737] misc test_kmod0: Ending request_module() tests
[  206.598698] misc test_kmod0: removing interface
[  206.600052] BUG: unable to handle kernel paging request at ffffe150a6032048
[  206.601224] PGD 0 P4D 0 
[  206.601642] Oops: 0000 [#1] PREEMPT SMP PTI
[  206.602309] CPU: 3 PID: 1707 Comm: rmmod Not tainted 4.19.0-rc7mod #2
[  206.603479] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[  206.604899] RIP: 0010:kfree+0x43/0x180
[  206.605564] Code: 53 48 89 fb 0f 82 48 01 00 00 49 c7 c4 00 00 00 80 4c 2b 25 4f 05 f9 00 49 01 c4 49 c1 ec 0c 49 c1 e4 06 4c 03 25 2d 05 f9 00 <49> 8b 44 24 08 48 8d 50 ff a8 01 4c 0f 45 e2 49 8b 54 24 08 48 8d
[  206.608861] RSP: 0018:ffffa40cc0cc7e70 EFLAGS: 00010282
[  206.609785] RAX: ffffa40d40c81030 RBX: ffffa40cc0c81030 RCX: 0000000000000004
[  206.611075] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffa40cc0c81030
[  206.612367] RBP: ffffffffc0e51008 R08: 0000000000000001 R09: 0000000000000000
[  206.613657] R10: 0000000000000000 R11: 0000000000000000 R12: ffffe150a6032040
[  206.614947] R13: ffffa40cc0c81080 R14: dead000000000200 R15: dead000000000100
[  206.616240] FS:  00007f475d64ab80(0000) GS:ffff8d148b000000(0000) knlGS:0000000000000000
[  206.617655] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  206.618695] CR2: ffffe150a6032048 CR3: 0000000133a02005 CR4: 00000000000606e0
[  206.619985] Call Trace:
[  206.620403]  test_kmod_exit+0xc6/0x281 [test_kmod]
[  206.621196]  __x64_sys_delete_module+0x157/0x240
[  206.621989]  do_syscall_64+0x60/0x180
[  206.622654]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  206.623570] RIP: 0033:0x7f475cd36f87
[  206.624232] Code: 73 01 c3 48 8b 0d 11 af 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 ae 2b 00 f7 d8 64 89 01 48
[  206.627530] RSP: 002b:00007ffcb69b0b58 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  206.628822] RAX: ffffffffffffffda RBX: 00007ffcb69b0bb8 RCX: 00007f475cd36f87
[  206.630121] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005614019547e8
[  206.631412] RBP: 0000561401954780 R08: 00007ffcb69afad1 R09: 0000000000000000
[  206.632702] R10: 00007f475cda61e0 R11: 0000000000000206 R12: 00007ffcb69b0d80
[  206.633992] R13: 00007ffcb69b177b R14: 0000561401954260 R15: 0000561401954780
[  206.635286] Modules linked in: test_kmod(-) xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ctr ccm af_packet ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter btrfs snd_hda_codec_hdmi snd_hda_codec_realtek xor zstd_compress snd_hda_codec_generic raid6_pq uvcvideo libcrc32c coretemp zstd_decompress hwmon xxhash arc4 videobuf2_vmalloc intel_rapl iwldvm i915 videobuf2_memops x86_pkg_temp_thermal intel_powerclamp videobuf2_v4l2 hid_generic videobuf2_common mac80211 kvm_intel
[  206.648055]  usbmouse videodev crct10dif_pclmul usbhid media hid crc32_pclmul crc32c_intel msr ghash_clmulni_intel pcbc iwlwifi aesni_intel aes_x86_64 snd_hda_intel kvmgt snd_hda_codec vfio_mdev snd_hda_core crypto_simd iTCO_wdt mdev iTCO_vendor_support snd_hwdep snd_pcm gpio_ich vfio_iommu_type1 cryptd vfio cfg80211 snd_timer kvm glue_helper sdhci_pci intel_cstate intel_uncore snd cqhci mei_me toshiba_acpi sdhci sparse_keymap irqbypass sr_mod intel_rapl_perf mmc_core joydev e1000e wmi lpc_ich mei uio_pdrv_genirq evdev cdrom mousedev input_leds thermal pcspkr mac_hid led_class industrialio serio_raw uio soundcore rfkill pcc_cpufreq video toshiba_haps ac battery button sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[  206.659837] CR2: ffffe150a6032048
[  206.660375] ---[ end trace 1359071a63fe0cfa ]---
[  206.661164] RIP: 0010:kfree+0x43/0x180
[  206.661834] Code: 53 48 89 fb 0f 82 48 01 00 00 49 c7 c4 00 00 00 80 4c 2b 25 4f 05 f9 00 49 01 c4 49 c1 ec 0c 49 c1 e4 06 4c 03 25 2d 05 f9 00 <49> 8b 44 24 08 48 8d 50 ff a8 01 4c 0f 45 e2 49 8b 54 24 08 48 8d
[  206.665133] RSP: 0018:ffffa40cc0cc7e70 EFLAGS: 00010282
[  206.666048] RAX: ffffa40d40c81030 RBX: ffffa40cc0c81030 RCX: 0000000000000004
[  206.667339] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffa40cc0c81030
[  206.668629] RBP: ffffffffc0e51008 R08: 0000000000000001 R09: 0000000000000000
[  206.669919] R10: 0000000000000000 R11: 0000000000000000 R12: ffffe150a6032040
[  206.671210] R13: ffffa40cc0c81080 R14: dead000000000200 R15: dead000000000100
[  206.672500] FS:  00007f475d64ab80(0000) GS:ffff8d148b000000(0000) knlGS:0000000000000000
[  206.673916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  206.674955] CR2: ffffe150a6032048 CR3: 0000000133a02005 CR4: 00000000000606e0
[  206.676246] BUG: sleeping function called from invalid context at ../include/linux/percpu-rwsem.h:34
[  206.677912] in_atomic(): 0, irqs_disabled(): 1, pid: 1707, name: rmmod
[  206.679076] INFO: lockdep is turned off.
[  206.679741] CPU: 3 PID: 1707 Comm: rmmod Tainted: G      D           4.19.0-rc7mod #2
[  206.681157] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[  206.682574] Call Trace:
[  206.682988]  dump_stack+0x5c/0x7b
[  206.683528]  ___might_sleep+0xeb/0x130
[  206.684194]  exit_signals+0x1b/0x230
[  206.684859]  do_exit+0x9b/0xbc0
[  206.685401]  rewind_stack_do_exit+0x17/0x20

-- 
~Randy
