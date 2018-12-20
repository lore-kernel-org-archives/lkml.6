Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C18C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3737C217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbeLTP13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:27:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbeLTP13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:27:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D2EEBD;
        Thu, 20 Dec 2018 07:27:27 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3D013F5C0;
        Thu, 20 Dec 2018 07:27:25 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: [BUG] dev_pm_opp refcount issue on Arm Juno r0
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     Sudeep Holla <Sudeep.Holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, nm@ti.com,
        sboyd@kernel.org, Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Douglas Raillard <Douglas.Raillard@arm.com>
Message-ID: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
Date:   Thu, 20 Dec 2018 15:27:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While running some hotplug torture test [1] on my Juno r0 I came across
the follow splat:

[  716.561862] ------------[ cut here ]------------
[  716.566451] refcount_t: underflow; use-after-free.
[  716.571240] WARNING: CPU: 2 PID: 18 at lib/refcount.c:280 refcount_dec_not_one+0x9c/0xc0
[  716.579246] Modules linked in:
[  716.582269] CPU: 2 PID: 18 Comm: cpuhp/2 Not tainted 4.20.0-rc7 #39
[  716.588469] Hardware name: ARM Juno development board (r0) (DT)
[  716.594326] pstate: 40000005 (nZcv daif -PAN -UAO)
[  716.599065] pc : refcount_dec_not_one+0x9c/0xc0
[  716.603546] lr : refcount_dec_not_one+0x9c/0xc0
[  716.608024] sp : ffff00000a063c70
[  716.611299] x29: ffff00000a063c70 x28: 0000000000000000 
[  716.616555] x27: 0000000000000000 x26: 0000000000000002 
[  716.621810] x25: ffff000009169000 x24: ffff000008f8e1b0 
[  716.627065] x23: ffff000008ce0920 x22: 00000000ffffffff 
[  716.632319] x21: ffff000009169000 x20: ffff8009762a2664 
[  716.637574] x19: ffff000009294a90 x18: 0000000000000400 
[  716.642828] x17: 0000000000000000 x16: 0000000000000000 
[  716.648082] x15: 0000000000000000 x14: 0000000000000400 
[  716.653336] x13: 000000000000023f x12: 0000000000043705 
[  716.658590] x11: 0000000000000108 x10: 0000000000000960 
[  716.663844] x9 : ffff00000a063970 x8 : ffff800976943ec0 
[  716.669098] x7 : 0000000000000000 x6 : ffff80097ff720b8 
[  716.674353] x5 : ffff80097ff720b8 x4 : 0000000000000000 
[  716.679607] x3 : ffff80097ff78e68 x2 : ffff80097ff720b8 
[  716.684861] x1 : 6374e2a7925c1100 x0 : 0000000000000000 
[  716.690115] Call trace:
[  716.692532]  refcount_dec_not_one+0x9c/0xc0
[  716.696669]  refcount_dec_and_mutex_lock+0x18/0x70
[  716.701409]  _put_opp_list_kref+0x28/0x50
[  716.705373]  _dev_pm_opp_find_and_remove_table+0x24/0x88
[  716.710628]  _dev_pm_opp_cpumask_remove_table+0x50/0xa0
[  716.715796]  dev_pm_opp_cpumask_remove_table+0x10/0x18
[  716.720879]  scpi_cpufreq_exit+0x40/0x50
[  716.724758]  cpufreq_offline+0x108/0x1e0
[  716.728637]  cpuhp_cpufreq_offline+0xc/0x18
[  716.732775]  cpuhp_invoke_callback+0x84/0x248
[  716.737084]  cpuhp_thread_fun+0xc4/0x148
[  716.740963]  smpboot_thread_fn+0x168/0x268
[  716.745013]  kthread+0x128/0x130
[  716.748204]  ret_from_fork+0x10/0x18
[  716.751738] ---[ end trace 0c658e0103aac29d ]---

The test produces a script [2] that can be found at the end of this email.

Kernel:
	7566ec393f41 ("Linux 4.20-rc7")
Config:
	arm64 defconfig w/ CONFIG_MOUSE_PS2=n
Firmware:
	ARM V2M_Juno Firmware v1.4.4
	Build Date: Jul 26 2016

	NOTICE:  BL31: v1.3(debug):v1.3-567-g3fb340a2
	NOTICE:  BL31: Built : 18:52:35, Apr 25 2017

Cheers,
Valentin

---

[1]: https://github.com/ARM-software/lisa/blob/next/lisa/tests/kernel/hotplug/torture.py

[2]: random_cpuhp.sh
#!/bin/sh
set -e
while true
do
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.055
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.084
    echo 0 > /sys/devices/system/cpu/cpu0/online
    sleep 0.014
    echo 1 > /sys/devices/system/cpu/cpu0/online
    sleep 0.069
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.037
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.075
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.088
    echo 0 > /sys/devices/system/cpu/cpu0/online
    sleep 0.064
    echo 0 > /sys/devices/system/cpu/cpu4/online
    sleep 0.049
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.024
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.097
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.013
    echo 1 > /sys/devices/system/cpu/cpu4/online
    sleep 0.094
    echo 0 > /sys/devices/system/cpu/cpu4/online
    sleep 0.073
    echo 1 > /sys/devices/system/cpu/cpu0/online
    sleep 0.022
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.057
    echo 0 > /sys/devices/system/cpu/cpu3/online
    sleep 0.054
    echo 1 > /sys/devices/system/cpu/cpu4/online
    sleep 0.022
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.018
    echo 1 > /sys/devices/system/cpu/cpu3/online
    sleep 0.057
    echo 0 > /sys/devices/system/cpu/cpu0/online
    sleep 0.046
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.018
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.016
    echo 0 > /sys/devices/system/cpu/cpu4/online
    sleep 0.016
    echo 0 > /sys/devices/system/cpu/cpu3/online
    sleep 0.044
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.046
    echo 1 > /sys/devices/system/cpu/cpu4/online
    sleep 0.093
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.098
    echo 0 > /sys/devices/system/cpu/cpu4/online
    sleep 0.072
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.013
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.099
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.07
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.022
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.041
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.098
    echo 1 > /sys/devices/system/cpu/cpu4/online
    sleep 0.032
    echo 0 > /sys/devices/system/cpu/cpu4/online
    sleep 0.043
    echo 1 > /sys/devices/system/cpu/cpu0/online
    sleep 0.076
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.072
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.036
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.042
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.016
    echo 0 > /sys/devices/system/cpu/cpu0/online
    sleep 0.07
    echo 1 > /sys/devices/system/cpu/cpu4/online
    sleep 0.018
    echo 1 > /sys/devices/system/cpu/cpu0/online
    sleep 0.055
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.096
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.012
    echo 1 > /sys/devices/system/cpu/cpu3/online
    sleep 0.093
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.086
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.09
    echo 0 > /sys/devices/system/cpu/cpu0/online
    sleep 0.077
    echo 1 > /sys/devices/system/cpu/cpu0/online
    sleep 0.01
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.026
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.049
    echo 0 > /sys/devices/system/cpu/cpu0/online
    sleep 0.083
    echo 0 > /sys/devices/system/cpu/cpu3/online
    sleep 0.096
    echo 1 > /sys/devices/system/cpu/cpu0/online
    sleep 0.067
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.083
    echo 0 > /sys/devices/system/cpu/cpu4/online
    sleep 0.089
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.065
    echo 1 > /sys/devices/system/cpu/cpu4/online
    sleep 0.066
    echo 1 > /sys/devices/system/cpu/cpu3/online
    sleep 0.099
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.08
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.076
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.01
    echo 0 > /sys/devices/system/cpu/cpu3/online
    sleep 0.017
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.049
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.057
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.083
    echo 0 > /sys/devices/system/cpu/cpu4/online
    sleep 0.037
    echo 0 > /sys/devices/system/cpu/cpu0/online
    sleep 0.04
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.051
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.03
    echo 1 > /sys/devices/system/cpu/cpu3/online
    sleep 0.067
    echo 0 > /sys/devices/system/cpu/cpu3/online
    sleep 0.011
    echo 1 > /sys/devices/system/cpu/cpu4/online
    sleep 0.041
    echo 1 > /sys/devices/system/cpu/cpu3/online
    sleep 0.057
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.082
    echo 0 > /sys/devices/system/cpu/cpu3/online
    sleep 0.067
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.069
    echo 1 > /sys/devices/system/cpu/cpu3/online
    sleep 0.062
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.074
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.025
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.016
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.017
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.025
    echo 0 > /sys/devices/system/cpu/cpu3/online
    sleep 0.016
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.082
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.021
    echo 0 > /sys/devices/system/cpu/cpu5/online
    sleep 0.02
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.035
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.063
    echo 0 > /sys/devices/system/cpu/cpu1/online
    sleep 0.064
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.029
    echo 1 > /sys/devices/system/cpu/cpu1/online
    sleep 0.096
    echo 1 > /sys/devices/system/cpu/cpu3/online
    sleep 0.073
    echo 1 > /sys/devices/system/cpu/cpu0/online
    sleep 0.049
    echo 1 > /sys/devices/system/cpu/cpu5/online
    sleep 0.065
    echo 0 > /sys/devices/system/cpu/cpu2/online
    sleep 0.024
    echo 1 > /sys/devices/system/cpu/cpu2/online
    sleep 0.092
done &
LOOP_PID=$!
sleep 10
[ $(ps -q $LOOP_PID | wc -l) -gt 1 ] && kill -9 $LOOP_PID
set +e
