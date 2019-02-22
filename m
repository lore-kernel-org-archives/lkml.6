Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB5F2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBVMpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:45:50 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:44400 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbfBVMpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:45:49 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 670781C28CA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:45:46 +0000 (GMT)
Received: (qmail 10850 invoked from network); 22 Feb 2019 12:45:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Feb 2019 12:45:46 -0000
Date:   Fri, 22 Feb 2019 12:45:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190222124544.GY9565@techsingularity.net>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:49:10AM -0800, Linus Torvalds wrote:
> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > However; whichever way around you turn this cookie; it is expensive and nasty.
> 
> Do you (or anybody else) have numbers for real loads?
> 
> Because performance is all that matters. If performance is bad, then
> it's pointless, since just turning off SMT is the answer.
> 

I tried to do a comparison between tip/master, ht disabled and this series
putting test workloads into a tagged cgroup but unfortunately it failed

[  156.978682] BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
[  156.986597] #PF error: [normal kernel read fault]
[  156.991343] PGD 0 P4D 0
[  156.993905] Oops: 0000 [#1] SMP PTI
[  156.997438] CPU: 15 PID: 0 Comm: swapper/15 Not tainted 5.0.0-rc7-schedcore-v1r1 #1
[  157.005161] Hardware name: SGI.COM C2112-4GP3/X10DRT-P-Series, BIOS 2.0a 05/09/2016
[  157.012896] RIP: 0010:wakeup_preempt_entity.isra.70+0x9/0x50
[  157.018613] Code: 00 be c0 82 60 00 e9 86 02 1a 00 66 0f 1f 44 00 00 48 c1 e7 03 be c0 80 60 00 e9 72 02 1a 00 66 90 0f 1f 44 00 00
 53 48 89 fb <48> 2b 5e 58 48 85 db 7e 2c 48 81 3e 00 00 10 00 8b 05 a9 b7 19 01
[  157.037544] RSP: 0018:ffffc9000c5bbde8 EFLAGS: 00010086
[  157.042819] RAX: ffff88810f5f6a00 RBX: 00000001547f175c RCX: 0000000000000001
[  157.050015] RDX: ffff88bf3bdb0a40 RSI: 0000000000000000 RDI: 00000001547f175c
[  157.057215] RBP: ffff88bf7fae32c0 R08: 000000000001e358 R09: ffff88810fb9f000
[  157.064410] R10: ffffc9000c5bbe08 R11: ffff88810fb9f5c4 R12: 0000000000000000
[  157.071611] R13: ffff88bf4e3ea0c0 R14: 0000000000000000 R15: ffff88bf4e3ea7a8
[  157.078814] FS:  0000000000000000(0000) GS:ffff88bf7f5c0000(0000) knlGS:0000000000000000
[  157.086977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  157.092779] CR2: 0000000000000058 CR3: 000000000220e005 CR4: 00000000003606e0
[  157.099979] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  157.109529] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  157.119058] Call Trace:
[  157.123865]  pick_next_entity+0x61/0x110
[  157.130137]  pick_task_fair+0x4b/0x90
[  157.136124]  __schedule+0x365/0x12c0
[  157.141985]  schedule_idle+0x1e/0x40
[  157.147822]  do_idle+0x166/0x280
[  157.153275]  cpu_startup_entry+0x19/0x20
[  157.159420]  start_secondary+0x17a/0x1d0
[  157.165568]  secondary_startup_64+0xa4/0xb0
[  157.171985] Modules linked in: af_packet iscsi_ibft iscsi_boot_sysfs msr intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass crc32_pclmul ghash_clmulni_intel ixgbe aesni_intel xfrm_algo iTCO_wdt joydev iTCO_vendor_support libphy igb aes_x86_64 crypto_simd ptp cryptd mei_me mdio pps_core ioatdma glue_helper pcspkr ipmi_si lpc_ich i2c_i801 mei dca ipmi_devintf ipmi_msghandler acpi_pad pcc_cpufreq button btrfs libcrc32c xor zstd_decompress zstd_compress raid6_pq hid_generic usbhid ast i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops xhci_pci crc32c_intel ehci_pci ttm xhci_hcd ehci_hcd drm ahci usbcore mpt3sas libahci raid_class scsi_transport_sas wmi sg nbd dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[  157.258990] CR2: 0000000000000058
[  157.264961] ---[ end trace a301ac5e3ee86fde ]---
[  157.283719] RIP: 0010:wakeup_preempt_entity.isra.70+0x9/0x50
[  157.291967] Code: 00 be c0 82 60 00 e9 86 02 1a 00 66 0f 1f 44 00 00 48 c1 e7 03 be c0 80 60 00 e9 72 02 1a 00 66 90 0f 1f 44 00 00 53 48 89 fb <48> 2b 5e 58 48 85 db 7e 2c 48 81 3e 00 00 10 00 8b 05 a9 b7 19 01
[  157.316121] RSP: 0018:ffffc9000c5bbde8 EFLAGS: 00010086
[  157.324060] RAX: ffff88810f5f6a00 RBX: 00000001547f175c RCX: 0000000000000001
[  157.333932] RDX: ffff88bf3bdb0a40 RSI: 0000000000000000 RDI: 00000001547f175c
[  157.343795] RBP: ffff88bf7fae32c0 R08: 000000000001e358 R09: ffff88810fb9f000
[  157.353634] R10: ffffc9000c5bbe08 R11: ffff88810fb9f5c4 R12: 0000000000000000
[  157.363506] R13: ffff88bf4e3ea0c0 R14: 0000000000000000 R15: ffff88bf4e3ea7a8
[  157.373395] FS:  0000000000000000(0000) GS:ffff88bf7f5c0000(0000) knlGS:0000000000000000
[  157.384238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  157.392709] CR2: 0000000000000058 CR3: 000000000220e005 CR4: 00000000003606e0
[  157.402601] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  157.412488] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  157.422334] Kernel panic - not syncing: Attempted to kill the idle task!
[  158.529804] Shutting down cpus with NMI
[  158.573249] Kernel Offset: disabled
[  158.586198] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

RIP translates to kernel/sched/fair.c:6819

static int
wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
{
        s64 gran, vdiff = curr->vruntime - se->vruntime; /* LINE 6819 */

        if (vdiff <= 0)
                return -1;

        gran = wakeup_gran(se);
        if (vdiff > gran)
                return 1;
}

I haven't tried debugging it yet.

-- 
Mel Gorman
SUSE Labs
