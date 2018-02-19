Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeBSMpL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:45:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbeBSMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:45:10 -0500
Date: Mon, 19 Feb 2018 13:44:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <fengguang.wu@intel.com>
Cc: kan.liang@linux.intel.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com, lkp@01.org
Subject: Re: [perf/x86/intel]  41e062cd2e:
 WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_save_and_restart_reload
Message-ID: <20180219124446.GR25201@hirez.programming.kicks-ass.net>
References: <1518474035-21006-2-git-send-email-kan.liang@linux.intel.com>
 <20180217062119.cemwsj6dsf4ezfn6@inn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217062119.cemwsj6dsf4ezfn6@inn>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 02:21:19PM +0800, kernel test robot wrote:
> [  242.731381] WARNING: CPU: 3 PID: 1107 at arch/x86/events/intel/ds.c:1326 intel_pmu_save_and_restart_reload+0x87/0x90

That's the one asserting the PMU is in fact disabled.

> [  242.731417] CPU: 3 PID: 1107 Comm: netserver Not tainted 4.15.0-00001-g41e062c #1
> [  242.731418] Hardware name: LENOVO IdeaPad U410    /Lenovo          , BIOS 65CN15WW 06/05/2012
> [  242.731422] RIP: 0010:intel_pmu_save_and_restart_reload+0x87/0x90
> [  242.731423] RSP: 0018:fffffe000008c8d0 EFLAGS: 00010002
> [  242.731425] RAX: 0000000000000001 RBX: ffff88007d069800 RCX: 0000000000000000
> [  242.731426] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff88007d069800
> [  242.731427] RBP: 0000000000000010 R08: 0000000000000001 R09: 0000000000000001
> [  242.731428] R10: 00000000000000b0 R11: 0000000000003000 R12: 00000000000f4243
> [  242.731429] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> [  242.731431] FS:  00007f1501639700(0000) GS:ffff880112ac0000(0000) knlGS:0000000000000000
> [  242.731432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  242.731433] CR2: 00007f65a1394d68 CR3: 000000007f62a006 CR4: 00000000001606e0
> [  242.731434] Call Trace:
> [  242.731438]  <NMI>
> [  242.731443]  __intel_pmu_pebs_event+0xc8/0x260
> [  242.731452]  ? intel_pmu_drain_pebs_nhm+0x211/0x2f0
> [  242.731454]  intel_pmu_drain_pebs_nhm+0x211/0x2f0
> [  242.731457]  intel_pmu_handle_irq+0x12d/0x4b0
> [  242.731464]  ? perf_event_nmi_handler+0x2d/0x50
> [  242.731466]  perf_event_nmi_handler+0x2d/0x50
> [  242.731470]  nmi_handle+0x6a/0x130
> [  242.731473]  default_do_nmi+0x4e/0x110
> [  242.731475]  do_nmi+0xe5/0x140
> [  242.731479]  end_repeat_nmi+0x1a/0x54

And this should have shown with any testing I think.

The problem appears to be that intel_pmu_handle_irq() uses
__intel_pmu_disable_all() which 'forgets' to clear cpuc->enabled as per
x86_pmu_disable().
