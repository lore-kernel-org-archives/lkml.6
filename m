Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbeBWFAK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 00:00:10 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35783 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeBWFAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 00:00:08 -0500
X-Google-Smtp-Source: AH8x226xFix7M4sZ4f7gkxNQgUZXbNOtifswG2FCjm+c2TMc3Hml5c/vS2TmyIjzga6Gn5oq1/bu9fdYqtoW7z39Ui4=
MIME-Version: 1.0
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 22 Feb 2018 20:59:47 -0800
Message-ID: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
Subject: Long standing kernel warning: perfevents: irq loop stuck!
To: Peter Zijlstra <peterz@infradead.org>, Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, jolsa@redhat.com,
        bigeasy@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We keep seeing the following kernel warning from 3.10 kernel to 4.9
kernel, it exists for a rather long time.

Google search shows there was a patch from Ingo:
https://patchwork.kernel.org/patch/6308681/

but it doesn't look like ever merged into mainline...

I don't know how it is triggered. Please let me know if any other
information I can provide.

BTW, the 4.9.78 kernel we use is based on the upstream 4.9 release,
plus some fs and networking patches backported, everything is from
upstream.


Thanks!

----------->

[12032.813743] perf: interrupt took too long (7710 > 7696), lowering
kernel.perf_event_max_sample_rate to 25000
[14751.091121] perfevents: irq loop stuck!
[14751.095169] INFO: NMI handler (perf_event_nmi_handler) took too
long to run: 4.099 msecs
[14751.103265] perf: interrupt took too long (40100 > 9637), lowering
kernel.perf_event_max_sample_rate to 4000
[14751.113092] ------------[ cut here ]------------
[14751.117719] WARNING: CPU: 34 PID: 85204 at
arch/x86/events/intel/core.c:2093 intel_pmu_handle_irq+0x35d/0x4c0
[14751.127629] Modules linked in:^Ac sch_htb^Ac cls_basic^Ac
act_mirred^Ac cls_u32^Ac veth^Ac fuse^Ac sch_ingress^Ac iTCO_wdt^Ac
intel_rapl^Ac sb_edac^Ac edac_core^Ac iTCO_vendor_
support^Ac x86_pkg_temp_thermal^Ac coretemp^Ac crct10dif_pclmul^Ac
crc32_pclmul^Ac ghash_clmulni_intel^Ac i2c_i801^Ac i2c_smbus^Ac
ioatdma^Ac i2c_core^Ac lpc_ich^Ac shpchp^Ac tcp_
diag^Ac hed^Ac inet_diag^Ac wmi^Ac acpi_pad^Ac ipmi_si^Ac
ipmi_devintf^Ac ipmi_msghandler^Ac acpi_cpufreq^Ac sch_fq_codel^Ac
xfs^Ac libcrc32c^Ac ixgbe^Ac mdio^Ac ptp^Ac crc32c_int
el^Ac pps_core^Ac dca^Ac
[14751.172819] CPU: 34 PID: 85204 Comm: kworker/34:2 Not tainted
4.9.78.x86_64 #1
[14751.181341] Hardware name: SYNNEX F3HY-MX/X10DRD-LTP-B-TW008, BIOS
2.0 10/14/2016
[14751.188829]  ffff99577fa88b48^Ac ffffffff8138d5e7^Ac
ffff99577fa88b98^Ac 0000000000000000^Ac
[14751.196922]  ffff99577fa88b88^Ac ffffffff8108a7fb^Ac
0000082d00000000^Ac 0000000000000064^Ac
[14751.205015]  0000000200000000^Ac ffff99577fa8d440^Ac
ffff993902a16000^Ac 0000000000000040^Ac
[14751.213102] Call Trace:
[14751.215564]  <NMI>  [<ffffffff8138d5e7>] dump_stack+0x4d/0x66
[14751.221321]  [<ffffffff8108a7fb>] __warn+0xcb/0xf0
[14751.226124]  [<ffffffff8108a87f>] warn_slowpath_fmt+0x5f/0x80
[14751.231880]  [<ffffffff8100bc2d>] intel_pmu_handle_irq+0x35d/0x4c0
[14751.238062]  [<ffffffff810047dc>] perf_event_nmi_handler+0x2c/0x50
[14751.244248]  [<ffffffff81021eda>] nmi_handle+0x6a/0x120
[14751.249484]  [<ffffffff81022443>] default_do_nmi+0x53/0xf0
[14751.254992]  [<ffffffff810225c0>] do_nmi+0xe0/0x120
[14751.259884]  [<ffffffff8175535d>] end_repeat_nmi+0x87/0x8f
[14751.265377]  [<ffffffff8100b811>] ? intel_pmu_enable_event+0x1d1/0x230
[14751.271913]  [<ffffffff8100b811>] ? intel_pmu_enable_event+0x1d1/0x230
[14751.278446]  [<ffffffff8100b811>] ? intel_pmu_enable_event+0x1d1/0x230
[14751.284981]  <EOE>  [<ffffffff81005c6e>] x86_pmu_start+0x7e/0x100
[14751.291082]  [<ffffffff81005f62>] x86_pmu_enable+0x272/0x2e0
[14751.296754]  [<ffffffff811803b7>] perf_pmu_enable.part.92+0x7/0x10
[14751.302946]  [<ffffffff811854ab>] perf_cgroup_switch+0x17b/0x1b0
[14751.308963]  [<ffffffff81186636>] __perf_event_task_sched_in+0x66/0x1a0
[14751.315582]  [<ffffffff81186f11>] ? __perf_event_task_sched_out+0xb1/0x430
[14751.322463]  [<ffffffff810b1d7a>] finish_task_switch+0x10a/0x1b0
[14751.328476]  [<ffffffff8174edbd>] __schedule+0x20d/0x690
[14751.333797]  [<ffffffff8174f276>] schedule+0x36/0x80
[14751.338763]  [<ffffffff810a505e>] worker_thread+0xbe/0x480
[14751.344251]  [<ffffffff810a4fa0>] ? process_one_work+0x410/0x410
[14751.350265]  [<ffffffff810aa8e6>] kthread+0xe6/0x100
[14751.355238]  [<ffffffff8108f188>] ? do_exit+0x698/0xaa0
[14751.360475]  [<ffffffff810aa800>] ? kthread_park+0x60/0x60
[14751.365966]  [<ffffffff81754194>] ret_from_fork+0x54/0x60
[14751.371376] ---[ end trace fd59d29a318e02d5 ]---

[14751.377511] CPU#34: ctrl:       0000000000000000
[14751.382141] CPU#34: status:     0000000000000000
[14751.386770] CPU#34: overflow:   0000000000000000
[14751.391395] CPU#34: fixed:      00000000000000b0
[14751.396022] CPU#34: pebs:       0000000000000000
[14751.400648] CPU#34: debugctl:   0000000000000000
[14751.405281] CPU#34: active:     0000000200000000
[14751.409912] CPU#34:   gen-PMC0 ctrl:  00000000001301b7
[14751.415064] CPU#34:   gen-PMC0 count: 0000ffff0025fa88
[14751.420214] CPU#34:   gen-PMC0 left:  00000000ffda057b
[14751.425358] CPU#34:   gen-PMC1 ctrl:  00000000001301bb
[14751.430497] CPU#34:   gen-PMC1 count: 0000ffff005ad046
[14751.435643] CPU#34:   gen-PMC1 left:  00000000ffa52fc1
[14751.440786] CPU#34:   gen-PMC2 ctrl:  0000000000130151
[14751.445937] CPU#34:   gen-PMC2 count: 0000ffff069ffd2d
[14751.451091] CPU#34:   gen-PMC2 left:  00000000f9600409
[14751.456240] CPU#34:   gen-PMC3 ctrl:  000000000013003c
[14751.461383] CPU#34:   gen-PMC3 count: 0000ffff05abd0c9
[14751.466524] CPU#34:   gen-PMC3 left:  00000000fa54a75b
[14751.471670] CPU#34: fixed-PMC0 count: 0000ffffd26bbae7
[14751.476814] CPU#34: fixed-PMC1 count: 0000ffffffffffff
[14751.481958] CPU#34: fixed-PMC2 count: 0000000000000000
[14751.487100] core: clearing PMU state on CPU#34
