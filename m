Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965021AbeEJNgI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:36:08 -0400
Received: from foss.arm.com ([217.140.101.70]:55936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934693AbeEJNgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:36:07 -0400
Subject: Re: [PATCH v2 21/27] coresight: Convert driver messages to dev_dbg
To: Robin Murphy <robin.murphy@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, mark.rutland@arm.com, will.deacon@arm.com,
        sudeep.holla@arm.com, frowand.list@gmail.com, robh@kernel.org,
        john.horley@arm.com
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
 <20180501225503.a55fb963795afb40163f3763@arm.com>
 <adf2465b-dd2c-dc0f-51ca-da7f1a8836ba@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <25e5fafe-23ea-cb86-a5da-7c0ab8c25e02@arm.com>
Date: Thu, 10 May 2018 14:36:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <adf2465b-dd2c-dc0f-51ca-da7f1a8836ba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/18 14:52, Robin Murphy wrote:
> On 02/05/18 04:55, Kim Phillips wrote:
>> On Tue, 1 May 2018 10:10:51 +0100
>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>> Convert component enable/disable messages from dev_info to dev_dbg.
>>> This is required to prevent LOCKDEP splats when operating in perf
>>> mode where we could be called with locks held to enable a coresight
>>
>> Can we see the splats?  Doesn't lockdep turn itself off if it starts
>> triggering too many splats?
> 
> Without some very careful and robust reasoning for why the condition being reported by lockdep could not actually occur in practice, "avoiding the splats" is far, far less important than "avoiding the potential deadlock that they are reporting".
> 
>>> path. If someone wants to really see the messages, they can always
>>> enable it at runtime via dynamic_debug.
>>
>> Won't the splats still occur when the messages are enabled with
>> dynamic_debug?
>>
>> So in effect this patch only tries to mitigate the splats, all the
>> while making things harder for regular users that now have to recompile
>> their kernels, in exchange for a very small convenience for kernel
>> developers that happen to see a splat or two with DEBUG_LOCKDEP set?
> 
> FWIW, if "regular users" means people running distro kernels, then chances are that they probably have DYNAMIC_DEBUG set already (100% of my local sample of 2 - Ubuntu x86_64 and Arch aarch64 - certainly do). Either way, though, this particular log spam really does only look vaguely useful to people debugging the coresight stack itself, so anyone going out of their way to turn it on has surely already gone beyond regular use (even if they're just reproducing an issue with additional logging at the request of kernel developers, rather than debugging it themselves).
> 
> Reducing the scope for possible deadlock from the general case to just debugging scenarios is certainly not a bad thing, but as you say I think we need a closer look at the underlying issue to know whether even dev_dbg() is wise.



Sorry for the delay, here is how it looks like on 4.17. In the original
version where I added this change was, slightly different, which had to
do with triggering prints from a perf-context, which could be holding
other locks/semaphores (CPU hotplug). I should have captured the log for
the commit description. I will see if I can get a better splat with the
older version.

Anyways, the following splat is only triggered when you enable printing
stuff from a perf call path. As people have already observed here, the
prints are too invasive and only helpful for the debug. We cannot move
the prints out of the path as there is no safer place outside, either.
Both sysfs mode and perf mode uses the same code path. But with perf,
you might be holding some additional semaphores/locks which is triggering
the splat. Below, stack #1 is from the perf context.



[ 1207.472310] ======================================================
[ 1207.478434] WARNING: possible circular locking dependency detected
[ 1207.484563] 4.17.0-rc3-00027-g9b9372f #73 Not tainted
[ 1207.489568] ------------------------------------------------------
[ 1207.495694] bash/2334 is trying to acquire lock:
[ 1207.500272] 000000004a592304 (&mm->mmap_sem){++++}, at: __might_fault+0x3c/0x88
[ 1207.507555]
[ 1207.507555] but task is already holding lock:
[ 1207.513339] 0000000008ac668a (&sb->s_type->i_mutex_key#3){++++}, at: iterate_dir+0x68/0x1a8
[ 1207.521652]
[ 1207.521652] which lock already depends on the new lock.
[ 1207.521652]
[ 1207.529761]
[ 1207.529761] the existing dependency chain (in reverse order) is:
[ 1207.537177]
[ 1207.537177] -> #5 (&sb->s_type->i_mutex_key#3){++++}:
[ 1207.543686]        down_write+0x48/0xa0
[ 1207.547496]        start_creating+0x54/0x118
[ 1207.551734]        debugfs_create_dir+0x14/0x110
[ 1207.556319]        opp_debug_register+0x78/0x110
[ 1207.560903]        _add_opp_dev+0x54/0x98
[ 1207.564884]        dev_pm_opp_get_opp_table+0x94/0x178
[ 1207.569982]        dev_pm_opp_add+0x20/0x68
[ 1207.574138]        scpi_dvfs_add_opps_to_device+0x80/0x108
[ 1207.579581]        scpi_cpufreq_init+0x50/0x2c0
[ 1207.584076]        cpufreq_online+0xc4/0x6e0
[ 1207.588313]        cpufreq_add_dev+0xa8/0xb8
[ 1207.592551]        subsys_interface_register+0xa4/0xf8
[ 1207.597649]        cpufreq_register_driver+0x17c/0x258
[ 1207.602747]        scpi_cpufreq_probe+0x30/0x70
[ 1207.607244]        platform_drv_probe+0x58/0xc0
[ 1207.611740]        driver_probe_device+0x2d4/0x478
[ 1207.616493]        __device_attach_driver+0xac/0x158
[ 1207.621418]        bus_for_each_drv+0x70/0xc8
[ 1207.625740]        __device_attach+0xdc/0x160
[ 1207.630063]        device_initial_probe+0x10/0x18
[ 1207.634729]        bus_probe_device+0x94/0xa0
[ 1207.639055]        device_add+0x308/0x5e8
[ 1207.643035]        platform_device_add+0x110/0x298
[ 1207.647789]        platform_device_register_full+0x10c/0x130
[ 1207.653404]        scpi_clocks_probe+0xe4/0x160
[ 1207.657901]        platform_drv_probe+0x58/0xc0
[ 1207.662396]        driver_probe_device+0x2d4/0x478
[ 1207.667149]        __device_attach_driver+0xac/0x158
[ 1207.672073]        bus_for_each_drv+0x70/0xc8
[ 1207.676397]        __device_attach+0xdc/0x160
[ 1207.680714]        device_initial_probe+0x10/0x18
[ 1207.685371]        bus_probe_device+0x94/0xa0
[ 1207.689685]        device_add+0x308/0x5e8
[ 1207.693654]        of_device_add+0x44/0x60
[ 1207.697709]        of_platform_device_create_pdata+0x80/0xe0
[ 1207.703311]        of_platform_bus_create+0x170/0x458
[ 1207.708313]        of_platform_populate+0x7c/0x130
[ 1207.713055]        devm_of_platform_populate+0x50/0xb0
[ 1207.718144]        scpi_probe+0x3c0/0x480
[ 1207.722113]        platform_drv_probe+0x58/0xc0
[ 1207.726598]        driver_probe_device+0x2d4/0x478
[ 1207.731341]        __device_attach_driver+0xac/0x158
[ 1207.736255]        bus_for_each_drv+0x70/0xc8
[ 1207.740568]        __device_attach+0xdc/0x160
[ 1207.744881]        device_initial_probe+0x10/0x18
[ 1207.749537]        bus_probe_device+0x94/0xa0
[ 1207.753851]        deferred_probe_work_func+0x58/0x180
[ 1207.758938]        process_one_work+0x228/0x410
[ 1207.763422]        worker_thread+0x25c/0x460
[ 1207.767651]        kthread+0x100/0x130
[ 1207.771363]        ret_from_fork+0x10/0x18
[ 1207.775415]
[ 1207.775415] -> #4 (opp_table_lock){+.+.}:
[ 1207.780864]        __mutex_lock+0x8c/0x8e8
[ 1207.784921]        mutex_lock_nested+0x1c/0x28
[ 1207.789321]        dev_pm_opp_get_opp_table+0x28/0x178
[ 1207.794409]        dev_pm_opp_add+0x20/0x68
[ 1207.798552]        scpi_dvfs_add_opps_to_device+0x80/0x108
[ 1207.803983]        scpi_cpufreq_init+0x50/0x2c0
[ 1207.808468]        cpufreq_online+0xc4/0x6e0
[ 1207.812695]        cpufreq_add_dev+0xa8/0xb8
[ 1207.816922]        subsys_interface_register+0xa4/0xf8
[ 1207.822009]        cpufreq_register_driver+0x17c/0x258
[ 1207.827097]        scpi_cpufreq_probe+0x30/0x70
[ 1207.831583]        platform_drv_probe+0x58/0xc0
[ 1207.836069]        driver_probe_device+0x2d4/0x478
[ 1207.840812]        __device_attach_driver+0xac/0x158
[ 1207.845726]        bus_for_each_drv+0x70/0xc8
[ 1207.850038]        __device_attach+0xdc/0x160
[ 1207.854351]        device_initial_probe+0x10/0x18
[ 1207.859009]        bus_probe_device+0x94/0xa0
[ 1207.863323]        device_add+0x308/0x5e8
[ 1207.867293]        platform_device_add+0x110/0x298
[ 1207.872036]        platform_device_register_full+0x10c/0x130
[ 1207.877639]        scpi_clocks_probe+0xe4/0x160
[ 1207.882125]        platform_drv_probe+0x58/0xc0
[ 1207.886610]        driver_probe_device+0x2d4/0x478
[ 1207.891353]        __device_attach_driver+0xac/0x158
[ 1207.896268]        bus_for_each_drv+0x70/0xc8
[ 1207.900581]        __device_attach+0xdc/0x160
[ 1207.904893]        device_initial_probe+0x10/0x18
[ 1207.909550]        bus_probe_device+0x94/0xa0
[ 1207.913865]        device_add+0x308/0x5e8
[ 1207.917833]        of_device_add+0x44/0x60
[ 1207.921888]        of_platform_device_create_pdata+0x80/0xe0
[ 1207.927490]        of_platform_bus_create+0x170/0x458
[ 1207.932491]        of_platform_populate+0x7c/0x130
[ 1207.937234]        devm_of_platform_populate+0x50/0xb0
[ 1207.942322]        scpi_probe+0x3c0/0x480
[ 1207.946292]        platform_drv_probe+0x58/0xc0
[ 1207.950777]        driver_probe_device+0x2d4/0x478
[ 1207.955520]        __device_attach_driver+0xac/0x158
[ 1207.960434]        bus_for_each_drv+0x70/0xc8
[ 1207.964747]        __device_attach+0xdc/0x160
[ 1207.969059]        device_initial_probe+0x10/0x18
[ 1207.973716]        bus_probe_device+0x94/0xa0
[ 1207.978029]        deferred_probe_work_func+0x58/0x180
[ 1207.983115]        process_one_work+0x228/0x410
[ 1207.987600]        worker_thread+0x25c/0x460
[ 1207.991827]        kthread+0x100/0x130
[ 1207.995538]        ret_from_fork+0x10/0x18
[ 1207.999590]
[ 1207.999590] -> #3 (subsys mutex#9){+.+.}:
[ 1208.005041]        __mutex_lock+0x8c/0x8e8
[ 1208.009098]        mutex_lock_nested+0x1c/0x28
[ 1208.013497]        subsys_interface_register+0x54/0xf8
[ 1208.018584]        cpufreq_register_driver+0x17c/0x258
[ 1208.023672]        scpi_cpufreq_probe+0x30/0x70
[ 1208.028157]        platform_drv_probe+0x58/0xc0
[ 1208.032643]        driver_probe_device+0x2d4/0x478
[ 1208.037386]        __device_attach_driver+0xac/0x158
[ 1208.042300]        bus_for_each_drv+0x70/0xc8
[ 1208.046613]        __device_attach+0xdc/0x160
[ 1208.050926]        device_initial_probe+0x10/0x18
[ 1208.055583]        bus_probe_device+0x94/0xa0
[ 1208.059897]        device_add+0x308/0x5e8
[ 1208.063867]        platform_device_add+0x110/0x298
[ 1208.068610]        platform_device_register_full+0x10c/0x130
[ 1208.074214]        scpi_clocks_probe+0xe4/0x160
[ 1208.078699]        platform_drv_probe+0x58/0xc0
[ 1208.083184]        driver_probe_device+0x2d4/0x478
[ 1208.087928]        __device_attach_driver+0xac/0x158
[ 1208.092842]        bus_for_each_drv+0x70/0xc8
[ 1208.097155]        __device_attach+0xdc/0x160
[ 1208.101468]        device_initial_probe+0x10/0x18
[ 1208.106124]        bus_probe_device+0x94/0xa0
[ 1208.110439]        device_add+0x308/0x5e8
[ 1208.114407]        of_device_add+0x44/0x60
[ 1208.118462]        of_platform_device_create_pdata+0x80/0xe0
[ 1208.124064]        of_platform_bus_create+0x170/0x458
[ 1208.129065]        of_platform_populate+0x7c/0x130
[ 1208.133808]        devm_of_platform_populate+0x50/0xb0
[ 1208.138896]        scpi_probe+0x3c0/0x480
[ 1208.142866]        platform_drv_probe+0x58/0xc0
[ 1208.147351]        driver_probe_device+0x2d4/0x478
[ 1208.152095]        __device_attach_driver+0xac/0x158
[ 1208.157009]        bus_for_each_drv+0x70/0xc8
[ 1208.161322]        __device_attach+0xdc/0x160
[ 1208.165635]        device_initial_probe+0x10/0x18
[ 1208.170292]        bus_probe_device+0x94/0xa0
[ 1208.174605]        deferred_probe_work_func+0x58/0x180
[ 1208.179691]        process_one_work+0x228/0x410
[ 1208.184176]        worker_thread+0x25c/0x460
[ 1208.188403]        kthread+0x100/0x130
[ 1208.192114]        ret_from_fork+0x10/0x18
[ 1208.196166]
[ 1208.196166] -> #2 (cpu_hotplug_lock.rw_sem){++++}:
[ 1208.202389]        cpus_read_lock+0x4c/0xc0
[ 1208.206531]        etm_setup_aux+0x50/0x230
[ 1208.210675]        rb_alloc_aux+0x20c/0x2e0
[ 1208.214816]        perf_mmap+0x3fc/0x670
[ 1208.218699]        mmap_region+0x38c/0x5a0
[ 1208.222754]        do_mmap+0x320/0x410
[ 1208.226466]        vm_mmap_pgoff+0xe4/0x110
[ 1208.230608]        ksys_mmap_pgoff+0xc0/0x230
[ 1208.234923]        sys_mmap+0x18/0x28
[ 1208.238548]        el0_svc_naked+0x30/0x34
[ 1208.242600]
[ 1208.242600] -> #1 (&event->mmap_mutex){+.+.}:
[ 1208.248392]        __mutex_lock+0x8c/0x8e8
[ 1208.252448]        mutex_lock_nested+0x1c/0x28
[ 1208.256848]        perf_mmap+0x150/0x670
[ 1208.260731]        mmap_region+0x38c/0x5a0
[ 1208.264786]        do_mmap+0x320/0x410
[ 1208.268497]        vm_mmap_pgoff+0xe4/0x110
[ 1208.272638]        ksys_mmap_pgoff+0xc0/0x230
[ 1208.276952]        sys_mmap+0x18/0x28
[ 1208.280577]        el0_svc_naked+0x30/0x34
[ 1208.284629]
[ 1208.284629] -> #0 (&mm->mmap_sem){++++}:
[ 1208.289991]        lock_acquire+0x44/0x60
[ 1208.293961]        __might_fault+0x60/0x88
[ 1208.298017]        filldir64+0xd0/0x340
[ 1208.301815]        dcache_readdir+0x110/0x178
[ 1208.306128]        iterate_dir+0x9c/0x1a8
[ 1208.310097]        ksys_getdents64+0x8c/0x178
[ 1208.314411]        sys_getdents64+0xc/0x18
[ 1208.318465]        el0_svc_naked+0x30/0x34
[ 1208.322518]
[ 1208.322518] other info that might help us debug this:
[ 1208.322518]
[ 1208.330443] Chain exists of:
[ 1208.330443]   &mm->mmap_sem --> opp_table_lock --> &sb->s_type->i_mutex_key#3
[ 1208.330443]
[ 1208.341831]  Possible unsafe locking scenario:
[ 1208.341831]
[ 1208.347691]        CPU0                    CPU1
[ 1208.352172]        ----                    ----
[ 1208.356653]   lock(&sb->s_type->i_mutex_key#3);
[ 1208.361145]                                lock(opp_table_lock);
[ 1208.367094]                                lock(&sb->s_type->i_mutex_key#3);
[ 1208.374079]   lock(&mm->mmap_sem);
[ 1208.377449]
[ 1208.377449]  *** DEADLOCK ***
[ 1208.377449]
[ 1208.383312] 1 lock held by bash/2334:
[ 1208.386934]  #0: 0000000008ac668a (&sb->s_type->i_mutex_key#3){++++}, at: iterate_dir+0x68/0x1a8
[ 1208.395653]
[ 1208.395653] stack backtrace:
[ 1208.399970] CPU: 4 PID: 2334 Comm: bash Not tainted 4.17.0-rc3-00027-g9b9372f #73
[ 1208.407378] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jul 28 2017
[ 1208.418053] Call trace:
[ 1208.420475]  dump_backtrace+0x0/0x1d0
[ 1208.424100]  show_stack+0x14/0x20
[ 1208.427382]  dump_stack+0xb8/0xf4
[ 1208.430665]  print_circular_bug.isra.20+0x1d4/0x2e0
[ 1208.435494]  __lock_acquire+0x14c8/0x19c0
[ 1208.439463]  lock_acquire+0x44/0x60
[ 1208.442917]  __might_fault+0x60/0x88
[ 1208.446456]  filldir64+0xd0/0x340
[ 1208.449736]  dcache_readdir+0x110/0x178
[ 1208.453533]  iterate_dir+0x9c/0x1a8
[ 1208.456986]  ksys_getdents64+0x8c/0x178
[ 1208.460783]  sys_getdents64+0xc/0x18
[ 1208.464321]  el0_svc_naked+0x30/0x34
[ 1397.521749] replicator_disable:86: coresight-dynamic-replicator 20120000.replicator: REPLICATOR disabled
[ 1397.531166] tmc_disable_etr_sink:1833: coresight-tmc 20070000.etr: TMC-ETR disabled
[ 1397.539439] replicator_disable:86: coresight-dynamic-replicator 20120000.replicator: REPLICATOR disabled
[ 1397.548850] tmc_disable_etr_sink:1833: coresight-tmc 20070000.etr: TMC-ETR disabled
[ 1397.557650] replicator_disable:86: coresight-dynamic-replicator 20120000.replicator: REPLICATOR disabled
[ 1397.567060] tmc_disable_etr_sink:1833: coresight-tmc 20070000.etr: TMC-ETR disabled
[ 1397.575416] replicator_disable:86: coresight-dynamic-replicator 20120000.replicator: REPLICATOR disabled
[ 1397.584820] tmc_disable_etr_sink:1833: coresight-tmc 20070000.etr: TMC-ETR disabled
[ 1397.593708] replicator_disable:86: coresight-dynamic-replicator 20120000.replicator: REPLICATOR disabled
[ 1397.603104] tmc_disable_etr_sink:1833: coresight-tmc 20070000.etr: TMC-ETR disabled



Cheers
Suzuki
