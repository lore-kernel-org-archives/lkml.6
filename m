Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeE3QIb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:08:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43929 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeE3QIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:08:30 -0400
X-Google-Smtp-Source: ADUXVKLYyF6F2pNWbrezyxt87Q3bBzR7p/mXgrW26k/28NfvK30GOXFkTbVeri9W9LH+v4CA9Elx2w==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: Fix missing clock update
Date: Wed, 30 May 2018 18:08:09 +0200
Message-Id: <20180530160809.9074-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A missing clock update is causing the below warning:

 ------------[ cut here ]------------
 rq->clock_update_flags < RQCF_ACT_SKIP
 WARNING: CPU: 10 PID: 0 at kernel/sched/sched.h:963 inactive_task_timer+0x5d6/0x720
 Modules linked in: xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack devlink ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep sunrpc arc4 iwlmvm intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp mac80211 kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore iwlwifi intel_rapl_perf snd_hda_codec_hdmi cfg80211 mei_wdt snd_hda_codec_realtek iTCO_wdt iTCO_vendor_support snd_hda_codec_generic
  snd_hda_intel btusb snd_hda_codec btrtl btbcm btintel wmi_bmof intel_wmi_thunderbolt snd_hwdep bluetooth snd_hda_core snd_seq snd_seq_device snd_pcm rtsx_usb_ms mei_me ecdh_generic snd_timer memstick rfkill snd mei lpc_ich i2c_i801 shpchp tpm_tis soundcore tpm_tis_core tpm xfs libcrc32c nouveau video drm_kms_helper e1000e ttm rtsx_usb_sdmmc drm mmc_core mxm_wmi igb crc32c_intel dca rtsx_usb ptp ata_generic r8169 i2c_algo_bit pps_core pata_acpi mii wmi
 CPU: 10 PID: 0 Comm: swapper/10 Not tainted 4.17.0-rc6+ #33
 Hardware name: LENOVO 30B6S2F900/1030, BIOS S01KT56A 01/15/2018
 RIP: 0010:inactive_task_timer+0x5d6/0x720
 RSP: 0000:ffff91c89f203eb0 EFLAGS: 00010086
 RAX: 0000000000000000 RBX: ffff91c891cc5810 RCX: 0000000000000000
 RDX: ffff91c89b572a80 RSI: 0000000000000000 RDI: ffffffffa213319d
 RBP: ffff91c89f3e1f40 R08: 0000000000000001 R09: 0000000000000001
 R10: ffff91c89f203df0 R11: 0000000000000000 R12: ffff91c09ec0e000
 R13: ffff91c89f3e0800 R14: 00000000001e1f40 R15: ffffffffa27c2bb0
 FS:  0000000000000000(0000) GS:ffff91c89f200000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f84659eb710 CR3: 0000000439212003 CR4: 00000000001606e0
 Call Trace:
  <IRQ>
  ? task_woken_dl+0x70/0x70
  __hrtimer_run_queues+0x10f/0x530
  hrtimer_interrupt+0xe5/0x240
  smp_apic_timer_interrupt+0x79/0x2b0
  apic_timer_interrupt+0xf/0x20
  </IRQ>
 RIP: 0010:cpuidle_enter_state+0xa5/0x360
 RSP: 0000:ffffa1f046387e98 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
 RAX: ffff91c89b572a80 RBX: 00000080584fb70b RCX: 0000000000000000
 RDX: ffff91c89b572a80 RSI: 0000000000000001 RDI: ffff91c89b572a80
 RBP: 0000000000000002 R08: 00000000000015ec R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff91c89f3ebe40
 R13: ffffffffa32dc4f8 R14: 0000000000000000 R15: 00000080584f5890
  ? cpuidle_enter_state+0x9e/0x360
  do_idle+0x203/0x280
  cpu_startup_entry+0x6f/0x80
  start_secondary+0x1b0/0x200
  secondary_startup_64+0xa5/0xb0
 Code: 31 c7 fa ff 0f 0b e9 e6 fd ff ff 80 3d 3c 61 24 01 00 0f 85 75 fd ff ff 48 c7 c7 b0 5b 0b a3 c6 05 28 61 24 01 01 e8 0a c7 fa ff <0f> 0b e9 5b fd ff ff 48 8b 7c 24 08 be ff ff ff ff e8 84 1b 01
 irq event stamp: 793922
 hardirqs last  enabled at (793919): [<ffffffffa27c5f6e>] cpuidle_enter_state+0x9e/0x360
 hardirqs last disabled at (793920): [<ffffffffa2a0096e>] interrupt_entry+0xce/0xe0
 softirqs last  enabled at (793922): [<ffffffffa20bef78>] irq_enter+0x68/0x70
 softirqs last disabled at (793921): [<ffffffffa20bef5d>] irq_enter+0x4d/0x70
 ---[ end trace eda7418c80ca042c ]---

This happens because inactive_task_timer calls sub_running_bw (if
TASK_DEAD and non_contending) that might trigger a schedutil update,
which might access the clock. Clock is however currently updated only
later in inactive_task_timer function.

Fix the problem by updating the clock right after task_rq_lock().

Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
Cc: linux-kernel@vger.kernel.org

---
This was actually first spotted by lkp-robot[1], but the fix never made
it to the list as a proper patch. Apologies. :/

[1] https://www.spinics.net/lists/kernel/msg2706782.html
---
 kernel/sched/deadline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1356afd1eeb6..fbfc3f1d368a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1259,6 +1259,9 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 
 	rq = task_rq_lock(p, &rf);
 
+	sched_clock_tick();
+	update_rq_clock(rq);
+
 	if (!dl_task(p) || p->state == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
@@ -1278,9 +1281,6 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	if (dl_se->dl_non_contending == 0)
 		goto unlock;
 
-	sched_clock_tick();
-	update_rq_clock(rq);
-
 	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
-- 
2.14.3
