Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE3CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF3720645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiv27EgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF3720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeIDX3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:29:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42940 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDX3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:29:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id z11-v6so3865706lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZZ3x1DL3N5bqPixKKUEgKxntIf2lVwNuHs3ARBGsJwA=;
        b=iiv27EgKYMPX+Ekuj1PRrEHrZ7g2HHskTNodZa+q6Z6dNTAzwaJ4RqwjXzZ/FA7meO
         L86mZk0g9avbHa3VFk25WmkHw1YQ0hlGulVWREqel7vUYQBw0K288kDOzPtvNzMt8/tt
         P0DoyZTMB0P/zDlEBRhfHXBX94eFtAQKEBZ6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZZ3x1DL3N5bqPixKKUEgKxntIf2lVwNuHs3ARBGsJwA=;
        b=faG+IVI6QBDHW3CrOIE2giKPGL9d8/DWzXZyycZMGCGY6L7HHOHSPkbtxSvQrQl8I6
         9EvBYHHT1LMHe5MKmILaXmtrbI2HU2qX4EJ0DgBVCVElRv8pXn/uhjW1xjTS4F2uUgVj
         TMy4cHu3+oI4AHnel3NJ6hU76QJsVTgdZad/3Pm4TPIQZW8/Vq3+sjo4I8jgihy+coXf
         nMV2sAd3Jp8MZmDM/k1Goss3DdqsXa3jBaRdo/sW+mWH0oRH33HRwk/RVYNhPAwnWmXE
         AGt7ccCE+yV0qp4GrFypVRJmQLQZgNEurYFmzxeE5VkjC8m+vKXd5JPJfKCq4vChTGb7
         0Oww==
X-Gm-Message-State: APzg51Bq7qxPcVOhYwZQmLI1FkHtsRL+qiKD0TlAxj1GPZWsy+fHXm/u
        5thcZR5piOAtDYMwPsyKlth6/A==
X-Google-Smtp-Source: ANB0VdYmFKzmnu2o/ojBpQbczrscOrnfRlxw4YNKBQqRYI5yETyMTuwjRg5AVgpjZgGmsLyknG1MdA==
X-Received: by 2002:a19:129e:: with SMTP id 30-v6mr20976387lfs.29.1536087805582;
        Tue, 04 Sep 2018 12:03:25 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 14-v6sm4191168ljc.74.2018.09.04.12.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 12:03:25 -0700 (PDT)
Date:   Tue, 4 Sep 2018 21:03:22 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: stop_machine() soft lockup
Message-ID: <20180904190322.GA21835@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

I'm seeing some lockups when booting linux-next on a db820c arm64 board.
I've tried to analyze, but I'm currently stuck.


[   30.974764] rcu: INFO: rcu_preempt self-detected stall on CPU
[   31.010121] rcu:     2-...0: (1 GPs behind) idle=3f6/1/0x4000000000000002 softirq=53/53 fqs=3099
[   31.035352] rcu:      (t=6518 jiffies g=-1119 q=1279)
[   31.054464] Task dump for CPU 2:
[   31.065349] migration/2     R  running task        0    22      2 0x0000002a
[   31.091937] Call trace:
[   31.103357]  dump_backtrace+0x0/0x200
[   31.114780]  show_stack+0x24/0x30
[   31.126183]  sched_show_task+0x20c/0x2d8
[   31.137604]  dump_cpu_task+0x48/0x58
[   31.149111]  rcu_dump_cpu_stacks+0xa0/0xe0
[   31.160620]  rcu_check_callbacks+0x85c/0xb60
[   31.172151]  update_process_times+0x34/0x60
[   31.183575]  tick_periodic+0x58/0x110
[   31.195048]  tick_handle_periodic+0x94/0xc8
[   31.206573]  arch_timer_handler_virt+0x38/0x58
[   31.218058]  handle_percpu_devid_irq+0xe4/0x458
[   31.229544]  generic_handle_irq+0x34/0x50
[   31.240952]  __handle_domain_irq+0x8c/0xf8
[   31.252375]  gic_handle_irq+0x84/0x180
[   31.263776]  el1_irq+0xec/0x198
[   31.275117]  multi_cpu_stop+0x198/0x220
[   31.286574]  cpu_stopper_thread+0xfc/0x188
[   31.298050]  smpboot_thread_fn+0x1bc/0x2c0
[   31.309562]  kthread+0x134/0x138
[   31.320888]  ret_from_fork+0x10/0x1c
[   31.332075] Task dump for CPU 3:
[   31.342925] migration/3     R  running task        0    27      2 0x0000002a
[   31.369347] Call trace:
[   31.380732]  __switch_to+0xa8/0xf0
[   31.391599]            (null)
[   32.813449] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   32.853356] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   32.996597] watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [migration/3:27]
[   33.008710] Modules linked in:
[   33.026913] irq event stamp: 702
[   33.038360] hardirqs last  enabled at (701): [<ffff0000081bb60c>] multi_cpu_stop+0x194/0x220
[   33.050062] hardirqs last disabled at (702): [<ffff000008083e2c>] el1_irq+0xac/0x198
[   33.061600] softirqs last  enabled at (396): [<ffff000008082164>] __do_softirq+0x47c/0x574
[   33.073284] softirqs last disabled at (389): [<ffff0000080ca41c>] irq_exit+0x134/0x148
[   33.084852] CPU: 3 PID: 27 Comm: migration/3 Tainted: G        W         4.19.0-rc2-next-20180904-00001-g32563c06c8db-dirty #42
[   33.095929] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
[   33.107086] pstate: 60400005 (nZCv daif +PAN -UAO)
[   33.118542] pc : multi_cpu_stop+0x198/0x220
[   33.129799] lr : multi_cpu_stop+0x194/0x220
[   33.140522] sp : ffff00000ae5bd50
[   33.151104] x29: ffff00000ae5bd50 x28: 0000000000000000
[   33.176154] x27: ffff00000803bc80 x26: 0000000000000000
[   33.201057] x25: 0000000000000000 x24: 0000000000000000
[   33.226014] x23: ffff0000090b4000 x22: 0000000000000003
[   33.250973] x21: ffff00000803bca4 x20: ffff00000803bc80
[   33.275806] x19: 0000000000000004 x18: ffffffffffffffff
[   33.300799] x17: 0000000000000727 x16: ffff000009fcfd00
[   33.325856] x15: ffff000009cbe1c8 x14: 31203a64656c6261
[   33.350852] x13: 000000006f1527a4 x12: ffff8000d958e3b0
[   33.375706] x11: 0000000000000000 x10: 0000000000000428
[   33.400629] x9 : ffff8000d9591000 x8 : 000000000000001c
[   33.425566] x7 : ffff8000d9c08400 x6 : 0000000000000444
[   33.450410] x5 : 0000000000007045 x4 : 0000000000000000
[   33.475399] x3 : 0000000000000000 x2 : ffff00000aabb000
[   33.500394] x1 : 0000000000000001 x0 : ffff8000d958db00
[   33.525460] Call trace:
[   33.536707]  multi_cpu_stop+0x198/0x220
[   33.548035]  cpu_stopper_thread+0xfc/0x188
[   33.559444]  smpboot_thread_fn+0x1bc/0x2c0
[   33.570610]  kthread+0x134/0x138
[   33.581944]  ret_from_fork+0x10/0x1c
[   36.813418] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   36.853359] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   40.813415] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   40.853352] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   44.813415] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   44.853342] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   48.813418] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   48.853344] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   52.813407] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   52.853341] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   56.813414] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   56.853345] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   56.921016] watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [migration/2:22]
[   56.933363] Modules linked in:
[   56.951546] irq event stamp: 604
[   56.963173] hardirqs last  enabled at (603): [<ffff0000081bb60c>] multi_cpu_stop+0x194/0x220
[   56.974744] hardirqs last disabled at (604): [<ffff000008083e2c>] el1_irq+0xac/0x198
[   56.986463] softirqs last  enabled at (450): [<ffff000008082164>] __do_softirq+0x47c/0x574
[   56.998266] softirqs last disabled at (443): [<ffff0000080ca41c>] irq_exit+0x134/0x148
[   57.009651] CPU: 2 PID: 22 Comm: migration/2 Tainted: G        W    L    4.19.0-rc2-next-20180904-00001-g32563c06c8db-dirty #42
[   57.021070] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
[   57.032279] pstate: 60400005 (nZCv daif +PAN -UAO)
[   57.043733] pc : multi_cpu_stop+0x198/0x220
[   57.055152] lr : multi_cpu_stop+0x194/0x220
[   57.065929] sp : ffff00000ae33d50
[   57.076598] x29: ffff00000ae33d50 x28: 0000000000000000
[   57.101700] x27: ffff00000803bc80 x26: 0000000000000000
[   57.126947] x25: 0000000000000000 x24: 0000000000000000
[   57.152160] x23: ffff0000090b4000 x22: 0000000000000002
[   57.177351] x21: ffff00000803bca4 x20: ffff00000803bc80
[   57.202378] x19: 0000000000000004 x18: ffffffffffffffff
[   57.227500] x17: 0000000000000708 x16: ffff000009fcfbe0
[   57.252639] x15: ffff000009cbe1c8 x14: 31203a64656c6261
[   57.277712] x13: 000000006f1527a4 x12: ffff8000d9fc63b0
[   57.302892] x11: 0000000000000000 x10: 0000000000000268
[   57.328157] x9 : ffff8000d9590400 x8 : 000000000000001c
[   57.353240] x7 : ffff8000d9c08400 x6 : 0000000000000284
[   57.378364] x5 : 0000000000004f5d x4 : 0000000000000000
[   57.403477] x3 : 0000000000000000 x2 : ffff00000aabb000
[   57.428601] x1 : 0000000000000001 x0 : ffff8000d9fc5b00
[   57.453865] Call trace:
[   57.465264]  multi_cpu_stop+0x198/0x220
[   57.476690]  cpu_stopper_thread+0xfc/0x188
[   57.487921]  smpboot_thread_fn+0x1bc/0x2c0
[   57.499416]  kthread+0x134/0x138
[   57.510752]  ret_from_fork+0x10/0x1c
[   60.813418] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   60.853344] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   63.137327] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 nice=0 stuck for 60s!
[   63.138392] Showing busy workqueues and worker pools:
[   63.145567] workqueue mm_percpu_wq: flags=0x8
[   63.150564]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
[   63.154568]     pending: vmstat_update
[   64.813418] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 0
[   64.853348] cpu_stopper_thread: calling softlockup_fn+0x0/0x78 for cpu: 1
[   67.233334] INFO: task swapper/0:1 blocked for more than 30 seconds.
[   67.233610]       Tainted: G        W    L    4.19.0-rc2-next-20180904-00001-g32563c06c8db-dirty #42
[   67.239301] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   67.248525] swapper/0       D    0     1      0 0x00000028
[   67.256236] Call trace:
[   67.261631]  __switch_to+0xa8/0xf0
[   67.263546]  __schedule+0x34c/0xc90
[   67.267279]  schedule+0x34/0x98
[   67.270662]  schedule_timeout+0x250/0x540
[   67.273785]  wait_for_common+0xe0/0x1a0
[   67.277955]  wait_for_completion+0x28/0x38
[   67.281602]  __stop_cpus+0xd4/0xf8
[   67.285766]  stop_cpus+0x70/0xa8
[   67.289145]  stop_machine_cpuslocked+0x124/0x130
[   67.292276]  stop_machine+0x54/0x70
[   67.297299]  timekeeping_notify+0x44/0x70
[   67.300088]  __clocksource_select+0xa8/0x1d8
[   67.304526]  clocksource_done_booting+0x4c/0x64
[   67.309124]  do_one_initcall+0x94/0x3f8
[   67.312847]  kernel_init_freeable+0x47c/0x528
[   67.316671]  kernel_init+0x18/0x110
[   67.321603]  ret_from_fork+0x10/0x1c
[   67.324490]
[   67.324490] Showing all locks held in the system:
[   67.328566] 3 locks held by swapper/0/1:
[   67.334709]  #0: (____ptrval____) (clocksource_mutex){+.+.}, at: clocksource_done_booting+0x2c/0x64
[   67.338641]  #1: (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: stop_machine+0x28/0x70
[   67.347569]  #2: (____ptrval____) (stop_cpus_mutex){+.+.}, at: stop_cpus+0x60/0xa8
[   67.356260] 1 lock held by khungtaskd/543:
[   67.363757]  #0: (____ptrval____) (rcu_read_lock){....}, at: debug_show_all_locks+0x14/0x1b0
[   67.367628]
[   67.376368] =============================================

These lines:
[   33.038360] hardirqs last  enabled at (701): [<ffff0000081bb60c>] multi_cpu_stop+0x194/0x220
[   33.050062] hardirqs last disabled at (702): [<ffff000008083e2c>] el1_irq+0xac/0x198
seem to indicate that an irq comes directly after local_irq_restore() in multi_cpu_stop().


I've added some debug prints. In the first stop_machine call, everything
completes as it should, in the second iteration, it looks like an irq comes
directly after local_irq_restore() in multi_cpu_stop(), and after that cpu2
and cpu3 is never completed, so wait_for_completion() never returns.


[    0.418197] stop_machine: calling stop_machine_cpuslocked with fn: __enable_cpu_capability+0x0/0x38
[    0.420051] stop_machine_cpuslocked: calling stop_cpus
[    0.429017] >>>>>>>>>>>>>>>>>>>>>>>> stop_cpus:450 taking stop_cpus_mutex
[    0.434205] __stop_cpus: queueing work
[    0.441027] queueing multi_cpu_stop+0x0/0x220 for cpu: 0
[    0.444641] queueing multi_cpu_stop+0x0/0x220 for cpu: 1
[    0.450145] queueing multi_cpu_stop+0x0/0x220 for cpu: 2
[    0.450188] cpu_stopper_thread: calling multi_cpu_stop+0x0/0x220 for cpu: 1
[    0.455438] queueing multi_cpu_stop+0x0/0x220 for cpu: 3
[    0.458486] cpu_stopper_thread: calling multi_cpu_stop+0x0/0x220 for cpu: 2
[    0.459101] multi_cpu_stop: cpu: 2 before local_save_flags, in atomic: 1 irqs_disabled: 0
[    0.459660] multi_cpu_stop: cpu: 2 after local_save_flags, in atomic: 1 irqs_disabled: 0
[    0.460713] multi_cpu_stop: cpu: 1 before local_save_flags, in atomic: 1 irqs_disabled: 0
[    0.467456] cpu_stopper_thread: calling multi_cpu_stop+0x0/0x220 for cpu: 0
[    0.469026] cpu_stopper_thread: calling multi_cpu_stop+0x0/0x220 for cpu: 3
[    0.469635] multi_cpu_stop: cpu: 3 before local_save_flags, in atomic: 1 irqs_disabled: 0
[    0.470190] multi_cpu_stop: cpu: 3 after local_save_flags, in atomic: 1 irqs_disabled: 0
[    0.472945] multi_cpu_stop: cpu: 1 after local_save_flags, in atomic: 1 irqs_disabled: 0
[    0.479629] multi_cpu_stop: cpu: 0 before local_save_flags, in atomic: 1 irqs_disabled: 0
[    0.542478] multi_cpu_stop: cpu: 0 after local_save_flags, in atomic: 1 irqs_disabled: 0
[    0.555518] multi_cpu_stop: cpu: 1 before local_irq_restore, in atomic: 1 irqs_disabled: 128
[    0.555523] multi_cpu_stop: cpu: 0 before local_irq_restore, in atomic: 1 irqs_disabled: 128
[    0.555830] multi_cpu_stop: cpu: 2 before local_irq_restore, in atomic: 1 irqs_disabled: 128
[    0.556074] multi_cpu_stop: cpu: 3 before local_irq_restore, in atomic: 1 irqs_disabled: 128
[    0.556366] multi_cpu_stop: cpu: 2 after local_irq_restore, in atomic: 1 irqs_disabled: 0
[    0.556624] multi_cpu_stop: cpu: 3 after local_irq_restore, in atomic: 1 irqs_disabled: 0
[    0.557133] cpu_stopper_thread: call to multi_cpu_stop+0x0/0x220 complete, setting done for cpu: 2
[    0.558722] multi_cpu_stop: cpu: 1 after local_irq_restore, in atomic: 1 irqs_disabled: 0
[    0.559213] cpu_stopper_thread: call to multi_cpu_stop+0x0/0x220 complete, setting done for cpu: 3
[    0.567138] multi_cpu_stop: cpu: 0 after local_irq_restore, in atomic: 1 irqs_disabled: 0
[    0.575551] cpu_stopper_thread: call to multi_cpu_stop+0x0/0x220 complete, setting done for cpu: 1
[    0.583972] cpu_stopper_thread: call to multi_cpu_stop+0x0/0x220 complete, setting done for cpu: 0
[    0.651730] <<<<<<<<<<<<<<<<<<<<<< __stop_cpus:411 now waiting for completion
[    0.660642] <<<<<<<<<<<<<<<<<<<<<< __stop_cpus:413 completion done
[    0.667836] >>>>>>>>>>>>>>>>>>>>>>>> stop_cpus:454 returning stop_cpus_mutex


[    5.016096] stop_machine: calling stop_machine_cpuslocked with fn: change_clocksource+0x0/0x118
[    5.016188] stop_machine_cpuslocked: calling stop_cpus
[    5.016271] >>>>>>>>>>>>>>>>>>>>>>>> stop_cpus:450 taking stop_cpus_mutex
[    5.016365] __stop_cpus: queueing work
[    5.016471] queueing multi_cpu_stop+0x0/0x220 for cpu: 0
[    5.016699] queueing multi_cpu_stop+0x0/0x220 for cpu: 1
[    5.016858] queueing multi_cpu_stop+0x0/0x220 for cpu: 2
[    5.016901] cpu_stopper_thread: calling multi_cpu_stop+0x0/0x220 for cpu: 0
[    5.016984] multi_cpu_stop: cpu: 0 before local_save_flags, in atomic: 1 irqs_disabled: 0
[    5.017004] queueing multi_cpu_stop+0x0/0x220 for cpu: 3
[    5.017063] multi_cpu_stop: cpu: 0 after local_save_flags, in atomic: 1 irqs_disabled: 0
[    5.017270] cpu_stopper_thread: calling multi_cpu_stop+0x0/0x220 for cpu: 1
[    5.017351] multi_cpu_stop: cpu: 1 before local_save_flags, in atomic: 1 irqs_disabled: 0
[    5.017429] multi_cpu_stop: cpu: 1 after local_save_flags, in atomic: 1 irqs_disabled: 0
[    5.046491] cpu_stopper_thread: calling multi_cpu_stop+0x0/0x220 for cpu: 2
[    5.079044] multi_cpu_stop: cpu: 2 before local_save_flags, in atomic: 1 irqs_disabled: 0
[    5.097884] multi_cpu_stop: cpu: 2 after local_save_flags, in atomic: 1 irqs_disabled: 0
[    5.518726] cpu_stopper_thread: calling multi_cpu_stop+0x0/0x220 for cpu: 3
[    5.571321] multi_cpu_stop: cpu: 3 before local_save_flags, in atomic: 1 irqs_disabled: 0
[    5.624144] multi_cpu_stop: cpu: 3 after local_save_flags, in atomic: 1 irqs_disabled: 0
[    5.680879] multi_cpu_stop: cpu: 1 before local_irq_restore, in atomic: 1 irqs_disabled: 128
[    5.680891] multi_cpu_stop: cpu: 0 before local_irq_restore, in atomic: 1 irqs_disabled: 128
[    5.681227] multi_cpu_stop: cpu: 0 after local_irq_restore, in atomic: 1 irqs_disabled: 0
[    5.682256] multi_cpu_stop: cpu: 3 before local_irq_restore, in atomic: 1 irqs_disabled: 128
[    5.682986] multi_cpu_stop: cpu: 2 before local_irq_restore, in atomic: 1 irqs_disabled: 128
[    5.688761] multi_cpu_stop: cpu: 1 after local_irq_restore, in atomic: 1 irqs_disabled: 0
[    5.697559] cpu_stopper_thread: call to multi_cpu_stop+0x0/0x220 complete, setting done for cpu: 0
[    5.705384] cpu_stopper_thread: call to multi_cpu_stop+0x0/0x220 complete, setting done for cpu: 1
[    5.705896] <<<<<<<<<<<<<<<<<<<<<< __stop_cpus:411 now waiting for completion



[   33.038360] hardirqs last  enabled at (701): [<ffff0000081bb60c>] multi_cpu_stop+0x194/0x220
translates to:
arch_local_irq_restore at /home/nks/linux-next/./arch/arm64/include/asm/irqflags.h:88 (discriminator 2)
 (inlined by) multi_cpu_stop at /home/nks/linux-next/kernel/stop_machine.c:238 (discriminator 2)

[   33.118542] pc : multi_cpu_stop+0x198/0x220
translates to:
get_current at /home/nks/linux-next/./arch/arm64/include/asm/current.h:19
 (inlined by) preempt_count at /home/nks/linux-next/./include/asm-generic/preempt.h:11
 (inlined by) multi_cpu_stop at /home/nks/linux-next/kernel/stop_machine.c:239
which equals:
 asm ("mrs %0, sp_el0" : "=r" (sp_el0));


If we got an irq directly after enabling irqs, I would assume that the execution
should have continued after the irq was done. Any thoughts?


Kind regards,
Niklas
