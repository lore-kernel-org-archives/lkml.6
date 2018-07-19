Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C14CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86FE206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86FE206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeGSI1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:27:05 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:34803 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeGSI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:27:05 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1fg3bu-0000lU-EP from Jiada_Wang@mentor.com ; Thu, 19 Jul 2018 00:44:26 -0700
Received: from [134.86.193.17] (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 19 Jul
 2018 00:44:23 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
Subject: potential deadlock in cpufreq-dt
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
CC:     <linux-kernel@vger.kernel.org>
Message-ID: <9e5c2419-a3c4-45fa-75c4-dcc6d9e12d86@mentor.com>
Date:   Thu, 19 Jul 2018 16:44:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

After enable lockdep, by poking /sys/kernel/debug/sched_features,
I triggered the following lockdep report:

[   34.410559] ======================================================
[   34.416766] WARNING: possible circular locking dependency detected
[   34.422987] 4.14.50-03493-g65adcd3b74c9-dirty #203 Tainted: G 
C
[   34.450785] ------------------------------------------------------
[   34.457001] systemd-udevd/1490 is trying to acquire lock:
[   34.462432]  (
[   34.464102] opp_table_lock
[   34.466814] ){+.+.}
[   34.468932] , at: [<ffff0000084c3328>] 
dev_pm_opp_get_opp_table+0x2c/0x140
[   34.475819]
                but task is already holding lock:
[   34.481689]  (
[   34.483359] subsys mutex
[   34.485914] #6
[   34.487587] ){+.+.}
[   34.489701] , at: [<ffff0000084adc1c>] 
subsys_interface_register+0x68/0x118
[   34.496677]
                which lock already depends on the new lock.

[   34.504890]
                the existing dependency chain (in reverse order) is:
[   34.512406]
                -> #3
[   34.515836]  (
[   34.517505] subsys mutex
[   34.520045] #6
[   34.521715] ){+.+.}linux-kernel@vger.kernel.org
[   34.523819] :
[   34.525412]        __mutex_lock+0x94/0x840
[   34.529543]        mutex_lock_nested+0x1c/0x24
[   34.534022]        subsys_interface_register+0x68/0x118
[   34.539284]        cpufreq_register_driver+0x10c/0x1d8
[   34.544464]        dt_cpufreq_probe+0xcc/0x108 [cpufreq_dt]
[   34.550074]        platform_drv_probe+0x58/0xa8
[   34.554637]        driver_probe_device+0x200/0x2b4
[   34.559463]        __driver_attach+0x7c/0xac
[   34.563768]        bus_for_each_dev+0xa0/0xb8
[   34.568169]        driver_attach+0x20/0x28
[   34.568173]        bus_add_driver+0x19c/0x1d8
[   34.568177]        driver_register+0x98/0xd0
[   34.568187]        __platform_driver_register+0x48/0x50
[   34.568198]        dt_cpufreq_platdrv_init+0x18/0x1000 [cpufreq_dt]
[   34.568205]        do_one_initcall+0x120/0x13c
[   34.568212]        do_init_module+0x5c/0x1c8
[   34.568215]        load_module+0x20f0/0x2150
[   34.568218]        SyS_finit_module+0xd4/0xe8
[   34.568220]        el0_svc_naked+0x34/0x38
[   34.568224]
                -> #2
[   34.568225]  (
[   34.568228] cpu_hotplug_lock.rw_sem
[   34.568229] ){++++}
[   34.568230] :
[   34.568236]        cpus_read_lock+0x54/0xcc
[   34.568241]        static_key_enable+0x14/0x2c
[   34.568247]        sched_feat_write+0xd0/0x1c4
[   34.568252]        full_proxy_write+0x6c/0xac
[   34.568257]        __vfs_write+0x34/0x138
[   34.568260]        vfs_write+0xc0/0x17c
[   34.568262]        SyS_write+0x60/0xb8
[   34.568265]        el0_svc_naked+0x34/0x38
[   34.568266]
                -> #1
[   34.568267]  (
[   34.568269] &sb->s_type->i_mutex_key
[   34.568271] #3
[   34.568272] ){+.+.}
[   34.568273] :
[   34.568279]        down_write+0x48/0x84
[   34.568282]        start_creating+0x7c/0xd0
[   34.568284]        debugfs_create_dir+0x14/0xbc
[   34.568289]        opp_debug_register+0x68/0xa8
[   34.568293]        _add_opp_dev+0x78/0xb4
[   34.568296]        dev_pm_opp_get_opp_table+0x7c/0x140
[   34.568300]        dev_pm_opp_of_add_table+0x1e0/0x4a4
[   34.568306]        InitDVFS+0x7c/0x37c
[   34.568314]        PVRSRVDeviceCreate+0x324/0x610
[   34.568317]        pvr_drm_load+0x64/0x128
[   34.568322]        pvr_probe+0x70/0xa0
[   34.568325]        platform_drv_probe+0x58/0xa8
[   34.568328]        driver_probe_device+0x200/0x2b4
[   34.568331]        __driver_attach+0x7c/0xac
[   34.568334]        bus_for_each_dev+0xa0/0xb8
[   34.568337]        driver_attach+0x20/0x28
[   34.568340]        bus_add_driver+0x19c/0x1d8
[   34.568343]        driver_register+0x98/0xd0
[   34.568346]        __platform_driver_register+0x48/0x50
[   34.568352]        pvr_init+0x50/0x58
[   34.568355]        do_one_initcall+0x120/0x13c
[   34.568360]        kernel_init_freeable+0x26c/0x270
[   34.568366]        kernel_init+0x10/0xfc
[   34.568369]        ret_from_fork+0x10/0x18
[   34.568370]
                -> #0
[   34.568372]  (
[   34.568373] opp_table_lock
[   34.568375] ){+.+.}
[   34.568376] :
[   34.568381]        lock_acquire+0x224/0x250
[   34.568384]        __mutex_lock+0x94/0x840
[   34.568387]        mutex_lock_nested+0x1c/0x24
[   34.568391]        dev_pm_opp_get_opp_table+0x2c/0x140
[   34.568394]        dev_pm_opp_set_regulators+0x30/0x190
[   34.568400]        cpufreq_init+0xe4/0x304 [cpufreq_dt]
[   34.568405]        cpufreq_online+0x174/0x5d8
[   34.568408]        cpufreq_add_dev+0x60/0x78linux-kernel@vger.kernel.org
[   34.568411]        subsys_interface_register+0x100/0x118
[   34.568414]        cpufreq_register_driver+0x10c/0x1d8
[   34.568419]        dt_cpufreq_probe+0xcc/0x108 [cpufreq_dt]
[   34.568422]        platform_drv_probe+0x58/0xa8
[   34.568425]        driver_probe_device+0x200/0x2b4
[   34.568428]        __driver_attach+0x7c/0xac
[   34.568431]        bus_for_each_dev+0xa0/0xb8
[   34.568433]        driver_attach+0x20/0x28
[   34.568436]        bus_add_driver+0x19c/0x1d8
[   34.568439]        driver_register+0x98/0xd0
[   34.568442]        __platform_driver_register+0x48/0x50
[   34.568448]        dt_cpufreq_platdrv_init+0x18/0x1000 [cpufreq_dt]
[   34.568450]        do_one_initcall+0x120/0x13c
[   34.568454]        do_init_module+0x5c/0x1c8
[   34.568457]        load_module+0x20f0/0x2150
[   34.568460]        SyS_finit_module+0xd4/0xe8
[   34.568462]        el0_svc_naked+0x34/0x38
[   34.568463]
                other info that might help us debug this:

[   34.568465] Chain exists of:

[   34.568466] opp_table_lock
[   34.568468]  -->
[   34.568469] cpu_hotplug_lock.rw_sem
[   34.568470]  -->
[   34.568472] subsys mutex
[   34.568473] #6
[   34.568474]

[   34.568476]  Possible unsafe locking scenario:

[   34.568478]        CPU0                    CPU1
[   34.568479]        ----                    ----
[   34.568481]   lock(
[   34.568482] subsys mutex
[   34.568483] #6
[   34.568484] );
[   34.568485]                                lock(
[   34.568487] cpu_hotplug_lock.rw_sem
[   34.568488] );
[   34.568489]                                lock(
[   34.568490] subsys mutex
[   34.568491] #6
[   34.568492] );
[   34.568493]   lock(
[   34.568495] opp_table_lock
[   34.568496] );
[   34.568497]
                 *** DEADLOCK ***

[   34.568500] 4 locks held by systemd-udevd/1490:
[   34.568501]  #0:
[   34.568503]  (
[   34.568504] &dev->mutex
[   34.568506] ){....}
[   34.568510] , at: [<ffff0000084aefd0>] __driver_attach+0x58/0xac
[   34.568511]  #1:
[   34.568512]  (
[   34.568513] &dev->mutex
[   34.568514] ){....}
[   34.568518] , at: [<ffff0000084aefe0>] __driver_attach+0x68/0xac
[   34.568519]  #2:
[   34.568520]  (
[   34.568522] cpu_hotplug_lock.rw_sem
[   34.568523] ){++++}
[   34.568526] , at: [<ffff00000857e728>] cpufreq_register_driver+0xa8/0x1d8
[   34.568527]  #3:
[   34.568528]  (
[   34.568530] subsys mutex
[   34.568531] #6
[   34.568532] ){+.+.}
[   34.568535] , at: [<ffff0000084adc1c>] 
subsys_interface_register+0x68/0x118
[   34.568537]
                stack backtrace:
[   34.568542] CPU: 1 PID: 1490 Comm: systemd-udevd Tainted: G         C 
      4.14.50-03493-g65adcd3b3
[   34.568544] Hardware name: Renesas H3ULCB Kingfisher board based on 
r8a7795 ES2.0+ (DT)
[   34.568548] Call trace:
[   34.568552] [<ffff000008089f20>] dump_backtrace+0x0/0x39c
[   34.568556] [<ffff00000808a2d0>] show_stack+0x14/0x1c
[   34.568561] [<ffff0000087774c0>] dump_stack+0xb0/0xf0
[   34.568565] [<ffff0000080f3c94>] print_circular_bug.isra.17+0x1e4/0x2c0
[   34.568568] [<ffff0000080f613c>] __lock_acquire+0xd0c/0x1750
[   34.568572] [<ffff0000080f73d0>] lock_acquire+0x224/0x250
[   34.568575] [<ffff00000878b24c>] __mutex_lock+0x94/0x840
[   34.568579] [<ffff00000878ba14>] mutex_lock_nested+0x1c/0x24
[   34.568583] [<ffff0000084c3328>] dev_pm_opp_get_opp_table+0x2c/0x140
[   34.568586] [<ffff0000084c35bc>] dev_pm_opp_set_regulators+0x30/0x190
[   34.568592] [<ffff000000979348>] cpufreq_init+0xe4/0x304 [cpufreq_dt]
[   34.568595] [<ffff00000857f1bc>] cpufreq_online+0x174/0x5d8
[   34.568599] [<ffff00000857f698>] cpufreq_add_dev+0x60/0x78
[   34.568602] [<ffff0000084adcb4>] subsys_interface_register+0x100/0x118
[   34.568605] [<ffff00000857e78c>] cpufreq_register_driver+0x10c/0x1d8
[   34.568610] [<ffff000000979634>] dt_cpufreq_probe+0xcc/0x108 [cpufreq_dt]
[   34.568614] [<ffff0000084b0f74>] platform_drv_probe+0x58/0xa8
[   34.568617] [<ffff0000084aeec4>] driver_probe_device+0x200/0x2b4
[   34.568620] [<ffff0000084aeff4>] __driver_attach+0x7c/0xac
[   34.568623] [<ffff0000084acfcc>] bus_for_each_dev+0xa0/0xb8
[   34.568626] [<ffff0000084ae748>] driver_attach+0x20/0x28
[   34.568629] [<ffff0000084ae2b8>] bus_add_driver+0x19c/0x1d8
[   34.568632] [<ffff0000084affb4>] driver_register+0x98/0xd0
[   34.568636] [<ffff0000084b0ecc>] __platform_driver_register+0x48/0x50
[   34.568641] [<ffff00000097e018>] dt_cpufreq_platdrv_init+0x18/0x1000 
[cpufreq_dt]
[   34.568644] [<ffff000008083358>] do_one_initcall+0x120/0x13c
[   34.568648] [<ffff00000813cd1c>] do_init_module+0x5c/0x1c8
[   34.568651] [<ffff00000813c0ac>] load_module+0x20f0/0x2150
[   34.568654] [<ffff00000813c3d4>] SyS_finit_module+0xd4/0xe8
[   34.568656] Exception stack(0xffff00001eaf3ec0 to 0xffff00001eaf4000)
[   34.568661] 3ec0: 000000000000000f 0000ffff829aff78 0000000000000000 
000000000000000f
[   34.568664] 3ee0: 0000000000000000 0000000000041a40 ffffffffffffffff 
ffffffffffffffff
[   34.568667] 3f00: 0000000000000111 0000000000000038 4f5e424aff524446 
0000000000000001
[   34.568670] 3f20: 0000000000000000 ffffffffffff0000 0000000000000001 
0000000000000020
[   34.568674] 3f40: 0000ffff829c0f80 0000ffff82aef440 0000000000000000 
0000aaab1c5e1cf0
[   34.568676] 3f60: 0000ffff829aff78 0000000000000000 0000000000020000 
0000aaab1c5d7940
[   34.568679] 3f80: 0000aaaae9f0c000 0000000000000000 0000000000000000 
0000aaaae9ed6e50
[   34.568682] 3fa0: 0000000000000000 0000ffffcbeec410 0000ffff829a98ac 
0000ffffcbeec410
[   34.568685] 3fc0: 0000ffff82aef464 0000000040000000 000000000000000f 
0000000000000111
[   34.568688] 3fe0: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   34.568691] [<ffff000008083080>] el0_svc_naked+0x34/0x38


the deadlock occurs between load of cpufreq-dt module and write to 
/sys/kernel/debug/sched_features

in cpufreq-dt module, it acquires cpu_hotplug_lock.rw_sem then calls 
subsys_interface_register()
which in turns will hold &sb->s_type->i_mutex_key.

while write to sched_features,
firstly acquires &sb->s_type->i_mutex_key, then
hold cpu_hotplug_lock.rw_sem.

IMO, driver should not try to acquire &sb->s_type->i_mutex_key while 
holding cpu_hotplug_lock.rw_sem.

could you please have a look at this issue?

Thanks,
Jiada
