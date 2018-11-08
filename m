Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A0C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2447320857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2447320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeKHNtf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 08:49:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:1470 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbeKHNtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 08:49:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 20:16:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="84210777"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2018 20:16:04 -0800
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 20:16:03 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.166]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.34]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 20:16:03 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
CC:     "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] e1000e: Change watchdog task to be delayed work
Thread-Topic: [PATCH] e1000e: Change watchdog task to be delayed work
Thread-Index: AQHUc9PWN4rECceD60+9OHzQSfrOrqVFSZ/A
Date:   Thu, 8 Nov 2018 04:16:03 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965AD0FF@ORSMSX103.amr.corp.intel.com>
References: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
In-Reply-To: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Robert Eshleman
> Sent: Saturday, November 3, 2018 5:17 PM
> Cc: Robert Eshleman <bobbyeshleman@gmail.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; David S. Miller <davem@davemloft.net>;
> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] e1000e: Change watchdog task to be delayed work
> 
> This completes a pending TODO to use queue_delayed_work() instead of
> schedule_work().
> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 

This patch is causing my test systems to either completely freeze or panic with a trace and lock up when an e1000e interface is brought up (with our without an address.)  I was able to capture the following trace via a serial console:

u1462:[ttyS1]/root> modprobe e1000e
u1462:[ttyS1]/root> ifconfig eth1 u1462-1
u1462:[ttyS1]/ro[  413.151204] WARNING: CPU: 3 PID: 0 at kernel/workqueue.c:1511 __queue_delayed_work+0x66/0x90
ot> [  413.267388] Modules linked in: e1000e xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_mirror dm_region_hash dm_log dm_mod coretemp kvm_intel kvm irqbypass iTCO_wdt iTCO_vendor_support i2c_i801 gpio_ich i5000_edac pcspkr lpc_ich sg i5k_amb acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sr_mod sd_mod cdrom ata_generic pata_acpi radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ata_piix drm libata e1000 i2c_core serio_raw
[  413.990294] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.20.0-rc1_next-queue_regress-00129-g712ce5c #14
[  414.101676] Hardware name: Supermicro X7DBX/X7DBX, BIOS 2.1 06/23/2008
[  414.179780] RIP: 0010:__queue_delayed_work+0x66/0x90
[  414.239164] Code: f5 00 89 42 50 48 01 f1 3d 00 20 00 00 48 89 4a 30 75 27 e9 9c 3f 06 00 89 c7 e9 25 fa ff ff 0f 0b 0f 1f 00 eb cc 0f 0b eb bb <0f> 0b 0f 1f 84 00 00 00 00 00 eb a8 0f 0b eb 9a 89 c6 0f 1f 84 00
[  414.463907] RSP: 0018:ffff9a1dbdac3eb0 EFLAGS: 00010003
[  414.526412] RAX: 0000000000002000 RBX: 0000000000000206 RCX: 0000000000000001
[  414.611796] RDX: ffff9a1db3d10918 RSI: ffff9a1db4330000 RDI: ffff9a1db3d10938
[  414.697180] RBP: ffff9a1db3d10880 R08: ffff9a1dbdac3ef8 R09: ffff9a1dbdac3ef8
[  414.782563] R10: 0000000000000004 R11: 0000000000000005 R12: 0000000000000100
[  414.867947] R13: ffffffffc0ab8660 R14: 0000000000000000 R15: 0000000000000000
[  414.953332] FS:  0000000000000000(0000) GS:ffff9a1dbdac0000(0000) knlGS:0000000000000000
[  415.050156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  415.118899] CR2: 00007fbf928ea000 CR3: 000000001a00a000 CR4: 00000000000006e0
[  415.204284] Call Trace:
[  415.233510]  <IRQ>
[  415.257532]  queue_delayed_work_on+0x24/0x40
[  415.308599]  call_timer_fn+0x2b/0x140
[  415.352381]  run_timer_softirq+0x1df/0x430
[  415.401366]  ? enqueue_hrtimer+0x38/0x90
[  415.448267]  ? __hrtimer_run_queues+0x129/0x260
[  415.502453]  __do_softirq+0xd0/0x29d
[  415.545199]  irq_exit+0xdb/0xf0
[  415.582740]  smp_apic_timer_interrupt+0x68/0x130
[  415.637964]  apic_timer_interrupt+0xf/0x20
[  415.686949]  </IRQ>
[  415.712012] RIP: 0010:mwait_idle+0x72/0x1c0
[  415.762037] Code: 01 00 0f ae 38 0f ae f0 31 d2 65 48 8b 04 25 80 5c 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 0f 85 23 01 00 00 31 c0 fb 0f 01 c9 <65> 8b 2d 67 c2 c6 73 66 66 66 66 90 65 48 8b 04 25 80 5c 01 00 f0
[  415.986780] RSP: 0018:ffffae7e0039beb8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  416.077364] RAX: 0000000000000000 RBX: ffff9a1d4f4bd700 RCX: 0000000000000000
[  416.162748] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000005e259b5f9b
[  416.248132] RBP: 0000000000000003 R08: 0000000000000002 R09: fffffff33a143210
[  416.333516] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  416.418901] R13: 0000000000000000 R14: ffff9a1d4f4bd700 R15: ffff9a1d4f4bd700
[  416.504286]  do_idle+0x19a/0x290
[  416.542868]  cpu_startup_entry+0x19/0x20
[  416.589774]  start_secondary+0x18c/0x1e0
[  416.636676]  secondary_startup_64+0xa4/0xb0
[  416.686702] ---[ end trace 3c61674d52e0a694 ]---
[  416.741927] WARNING: CPU: 3 PID: 0 at kernel/workqueue.c:1512 __queue_delayed_work+0x62/0x90
[  416.842907] Modules linked in: e1000e xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_mirror dm_region_hash dm_log dm_mod coretemp kvm_intel kvm irqbypass iTCO_wdt iTCO_vendor_support i2c_i801 gpio_ich i5000_edac pcspkr lpc_ich sg i5k_amb acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sr_mod sd_mod cdrom ata_generic pata_acpi radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ata_piix drm libata e1000 i2c_core serio_raw
[  417.561653] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W         4.20.0-rc1_next-queue_regress-00129-g712ce5c #14
[  417.689675] Hardware name: Supermicro X7DBX/X7DBX, BIOS 2.1 06/23/2008
[  417.767780] RIP: 0010:__queue_delayed_work+0x62/0x90
[  417.827165] Code: 8b 35 22 b1 f5 00 89 42 50 48 01 f1 3d 00 20 00 00 48 89 4a 30 75 27 e9 9c 3f 06 00 89 c7 e9 25 fa ff ff 0f 0b 0f 1f 00 eb cc <0f> 0b eb bb 0f 0b 0f 1f 84 00 00 00 00 00 eb a8 0f 0b eb 9a 89 c6
[  418.051907] RSP: 0018:ffff9a1dbdac3eb0 EFLAGS: 00010002
[  418.114412] RAX: 0000000000002000 RBX: 0000000000000206 RCX: 0000000000000001
[  418.199796] RDX: ffff9a1db3d10918 RSI: ffff9a1db4330000 RDI: ffff9a1db3d10938
[  418.285181] RBP: ffff9a1db3d10880 R08: ffff9a1dbdac3ef8 R09: ffff9a1dbdac3ef8
[  418.370563] R10: 0000000000000004 R11: 0000000000000005 R12: 0000000000000100
[  418.455948] R13: ffffffffc0ab8660 R14: 0000000000000000 R15: 0000000000000000
[  418.541333] FS:  0000000000000000(0000) GS:ffff9a1dbdac0000(0000) knlGS:0000000000000000
[  418.638156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  418.706901] CR2: 00007fbf928ea000 CR3: 000000001a00a000 CR4: 00000000000006e0
[  418.792283] Call Trace:
[  418.821507]  <IRQ>
[  418.845532]  queue_delayed_work_on+0x24/0x40
[  418.896598]  call_timer_fn+0x2b/0x140
[  418.940380]  run_timer_softirq+0x1df/0x430
[  418.989366]  ? enqueue_hrtimer+0x38/0x90
[  419.036267]  ? __hrtimer_run_queues+0x129/0x260
[  419.090453]  __do_softirq+0xd0/0x29d
[  419.133197]  irq_exit+0xdb/0xf0
[  419.170742]  smp_apic_timer_interrupt+0x68/0x130
[  419.225964]  apic_timer_interrupt+0xf/0x20
[  419.274947]  </IRQ>
[  419.300013] RIP: 0010:mwait_idle+0x72/0x1c0
[  419.350037] Code: 01 00 0f ae 38 0f ae f0 31 d2 65 48 8b 04 25 80 5c 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 0f 85 23 01 00 00 31 c0 fb 0f 01 c9 <65> 8b 2d 67 c2 c6 73 66 66 66 66 90 65 48 8b 04 25 80 5c 01 00 f0
[  419.574779] RSP: 0018:ffffae7e0039beb8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  419.665363] RAX: 0000000000000000 RBX: ffff9a1d4f4bd700 RCX: 0000000000000000
[  419.750748] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000005e259b5f9b
[  419.836132] RBP: 0000000000000003 R08: 0000000000000002 R09: fffffff33a143210
[  419.921516] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  420.006900] R13: 0000000000000000 R14: ffff9a1d4f4bd700 R15: ffff9a1d4f4bd700
[  420.092285]  do_idle+0x19a/0x290
[  420.130868]  cpu_startup_entry+0x19/0x20
[  420.177773]  start_secondary+0x18c/0x1e0
[  420.224677]  secondary_startup_64+0xa4/0xb0
[  420.274700] ---[ end trace 3c61674d52e0a695 ]---
[  420.329926] ------------[ cut here ]------------
[  420.385147] kernel BUG at kernel/time/timer.c:1137!
[  420.443497] invalid opcode: 0000 [#1] SMP PTI
[  420.495596] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W         4.20.0-rc1_next-queue_regress-00129-g712ce5c #14
[  420.623620] Hardware name: Supermicro X7DBX/X7DBX, BIOS 2.1 06/23/2008
[  420.701726] RIP: 0010:add_timer+0x1c9/0x1f0
[  420.751748] Code: 48 89 de ff d0 48 8b 45 00 48 85 c0 75 e4 e9 43 ff ff ff 49 01 d5 44 8b 73 20 e9 e1 fe ff ff 49 89 ed 4d 89 ef e9 27 ff ff ff <0f> 0b 0f 0b e8 ce 07 f8 ff 4c 89 ef e8 b5 08 00 00 e9 0d ff ff ff
[  420.976492] RSP: 0018:ffff9a1dbdac3e70 EFLAGS: 00010002
[  421.038997] RAX: 0000000000000000 RBX: ffff9a1db3d10938 RCX: 000000010001a1a7
[  421.124381] RDX: ffff9a1db3d10918 RSI: 000000010001a1a6 RDI: ffff9a1db3d10938
[  421.209765] RBP: ffff9a1db3d10880 R08: ffff9a1db3d10920 R09: ffff9a1db3d10920
[  421.295149] R10: 0000000000000004 R11: 0000000000000005 R12: 0000000000000100
[  421.380532] R13: ffffffffc0ab8660 R14: 0000000000000000 R15: 0000000000000000
[  421.465918] FS:  0000000000000000(0000) GS:ffff9a1dbdac0000(0000) knlGS:0000000000000000
[  421.562741] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  421.631486] CR2: 00007fbf928ea000 CR3: 000000001a00a000 CR4: 00000000000006e0
[  421.716869] Call Trace:
[  421.746091]  <IRQ>
[  421.770129]  ? e1000e_downshift_workaround+0x20/0x20 [e1000e]
[  421.838862]  queue_delayed_work_on+0x24/0x40
[  421.889925]  call_timer_fn+0x2b/0x140
[  421.933710]  run_timer_softirq+0x1df/0x430
[  421.982692]  ? enqueue_hrtimer+0x38/0x90
[  422.029597]  ? __hrtimer_run_queues+0x129/0x260
[  422.083781]  __do_softirq+0xd0/0x29d
[  422.126524]  irq_exit+0xdb/0xf0
[  422.164068]  smp_apic_timer_interrupt+0x68/0x130
[  422.219293]  apic_timer_interrupt+0xf/0x20
[  422.268277]  </IRQ>
[  422.293341] RIP: 0010:mwait_idle+0x72/0x1c0
[  422.343364] Code: 01 00 0f ae 38 0f ae f0 31 d2 65 48 8b 04 25 80 5c 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 0f 85 23 01 00 00 31 c0 fb 0f 01 c9 <65> 8b 2d 67 c2 c6 73 66 66 66 66 90 65 48 8b 04 25 80 5c 01 00 f0
[  422.568109] RSP: 0018:ffffae7e0039beb8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  422.658693] RAX: 0000000000000000 RBX: ffff9a1d4f4bd700 RCX: 0000000000000000
[  422.744076] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000005e259b5f9b
[  422.829460] RBP: 0000000000000003 R08: 0000000000000002 R09: fffffff33a143210
[  422.914843] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  423.000229] R13: 0000000000000000 R14: ffff9a1d4f4bd700 R15: ffff9a1d4f4bd700
[  423.085615]  do_idle+0x19a/0x290
[  423.124197]  cpu_startup_entry+0x19/0x20
[  423.171101]  start_secondary+0x18c/0x1e0
[  423.218006]  secondary_startup_64+0xa4/0xb0
[  423.268028] Modules linked in: e1000e xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_mirror dm_region_hash dm_log dm_mod coretemp kvm_intel kvm irqbypass iTCO_wdt iTCO_vendor_support i2c_i801 gpio_ich i5000_edac pcspkr lpc_ich sg i5k_amb acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sr_mod sd_mod cdrom ata_generic pata_acpi radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ata_piix drm libata e1000 i2c_core serio_raw
[  423.986779] ---[ end trace 3c61674d52e0a696 ]---
[  424.041999] RIP: 0010:add_timer+0x1c9/0x1f0
[  424.092021] Code: 48 89 de ff d0 48 8b 45 00 48 85 c0 75 e4 e9 43 ff ff ff 49 01 d5 44 8b 73 20 e9 e1 fe ff ff 49 89 ed 4d 89 ef e9 27 ff ff ff <0f> 0b 0f 0b e8 ce 07 f8 ff 4c 89 ef e8 b5 08 00 00 e9 0d ff ff ff
[  424.316765] RSP: 0018:ffff9a1dbdac3e70 EFLAGS: 00010002
[  424.379268] RAX: 0000000000000000 RBX: ffff9a1db3d10938 RCX: 000000010001a1a7
[  424.464652] RDX: ffff9a1db3d10918 RSI: 000000010001a1a6 RDI: ffff9a1db3d10938
[  424.550037] RBP: ffff9a1db3d10880 R08: ffff9a1db3d10920 R09: ffff9a1db3d10920
[  424.635420] R10: 0000000000000004 R11: 0000000000000005 R12: 0000000000000100
[  424.720804] R13: ffffffffc0ab8660 R14: 0000000000000000 R15: 0000000000000000
[  424.806190] FS:  0000000000000000(0000) GS:ffff9a1dbdac0000(0000) knlGS:0000000000000000
[  424.903012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  424.971757] CR2: 00007fbf928ea000 CR3: 000000001a00a000 CR4: 00000000000006e0
[  425.057140] Kernel panic - not syncing: Fatal exception in interrupt
[  425.133170] Kernel Offset: 0xac00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  425.261191] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
