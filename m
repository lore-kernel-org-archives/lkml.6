Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7516ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A8C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A8C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbeGWOQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:16:50 -0400
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:60778 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388119AbeGWOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:16:49 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CA1043C09A0;
        Mon, 23 Jul 2018 15:15:35 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H5dIqSvrDsn1; Mon, 23 Jul 2018 15:15:27 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id DA2EB3C0076;
        Mon, 23 Jul 2018 15:15:27 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 23 Jul
 2018 15:15:27 +0200
Date:   Mon, 23 Jul 2018 15:15:24 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     jiada <jiada_wang@mentor.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: potential deadlock in cpufreq-dt
Message-ID: <20180723131524.GA21030@vmlxhi-102.adit-jv.com>
References: <9e5c2419-a3c4-45fa-75c4-dcc6d9e12d86@mentor.com>
 <20180720051306.w4gmhvgabcj4svkf@vireshk-i7>
 <3098ae70-85b6-9c37-c177-63652eeda804@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3098ae70-85b6-9c37-c177-63652eeda804@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

[since Jiada's initial report was based on 4.14.50+]
FWIW, I can consistently reproduce this lockdep issue on 4.18.0-rc6:

[   17.119559] ======================================================
[   17.119571] WARNING: possible circular locking dependency detected
[   17.119589] 4.18.0-rc6 #3 Not tainted
[   17.119601] ------------------------------------------------------
[   17.119617] systemd-udevd/1538 is trying to acquire lock:
[   17.119631] (____ptrval____) (&sb->s_type->i_mutex_key
[   17.137496] #3){+.+.}, at: start_creating+0xbc/0x140
[   17.137573] 
[   17.137573] but task is already holding lock:
[   17.137597] (____ptrval____) (opp_table_lock){+.+.}, at: dev_pm_opp_get_opp_table+0xac/0x310
[   17.181185] 
[   17.181185] which lock already depends on the new lock.
[   17.189506] 
[   17.189506] the existing dependency chain (in reverse order) is:
[   17.197116] 
[   17.197116] -> #3 (opp_table_lock){+.+.}:
[   17.202803]        lock_acquire+0x578/0x5c0
[   17.207101]        __mutex_lock+0xec/0xdf8
[   17.211309]        mutex_lock_nested+0x3c/0x4c
[   17.215866]        dev_pm_opp_get_opp_table+0xac/0x310
[   17.221121]        dev_pm_opp_set_regulators+0x38/0x300
[   17.226506]        cpufreq_init+0x198/0x3e0 [cpufreq_dt]
[   17.231950]        cpufreq_online+0x3f0/0xcd4
[   17.236425]        cpufreq_add_dev+0x164/0x17c
[   17.240988]        subsys_interface_register+0x244/0x264
[   17.246409]        cpufreq_register_driver+0x178/0x278
[   17.251680]        dt_cpufreq_probe+0x158/0x178 [cpufreq_dt]
[   17.257435]        platform_drv_probe+0xa4/0x134
[   17.262167]        driver_probe_device+0x36c/0x488
[   17.267085]        __driver_attach+0x150/0x1e4
[   17.271642]        bus_for_each_dev+0x110/0x138
[   17.271677]        driver_attach+0x50/0x5c
[   17.281065]        bus_add_driver+0x2ac/0x2f8
[   17.281093]        driver_register+0x180/0x1c8
[   17.281124]        __platform_driver_register+0x9c/0xac
[   17.289056]        dt_cpufreq_platdrv_init+0x28/0x1000 [cpufreq_dt]
[   17.289093]        do_one_initcall+0x59c/0xab0
[   17.298045]        do_init_module+0x174/0x450
[   17.298073]        load_module+0x3a40/0x3b60
[   17.298101]        sys_finit_module+0x150/0x168
[   17.309161]        el0_svc_naked+0x30/0x34
[   17.309176] 
[   17.309176] -> #2 (
[   17.325197] subsys mutex#6){+.+.}:
[   17.334020]        lock_acquire+0x578/0x5c0
[   17.334048]        __mutex_lock+0xec/0xdf8
[   17.334069]        mutex_lock_nested+0x3c/0x4c
[   17.375822]        subsys_interface_register+0x10c/0x264
[   17.381268]        cpufreq_register_driver+0x178/0x278
[   17.386563]        dt_cpufreq_probe+0x158/0x178 [cpufreq_dt]
[   17.392355]        platform_drv_probe+0xa4/0x134
[   17.397089]        driver_probe_device+0x36c/0x488
[   17.402001]        __driver_attach+0x150/0x1e4
[   17.406556]        bus_for_each_dev+0x110/0x138
[   17.411202]        driver_attach+0x50/0x5c
[   17.415409]        bus_add_driver+0x2ac/0x2f8
[   17.419881]        driver_register+0x180/0x1c8
[   17.424442]        __platform_driver_register+0x9c/0xac
[   17.429825]        dt_cpufreq_platdrv_init+0x28/0x1000 [cpufreq_dt]
[   17.436234]        do_one_initcall+0x59c/0xab0
[   17.440799]        do_init_module+0x174/0x450
[   17.445243]        load_module+0x3a40/0x3b60
[   17.449588]        sys_finit_module+0x150/0x168
[   17.454193]        el0_svc_naked+0x30/0x34
[   17.458350] 
[   17.458350] -> #1 (cpu_hotplug_lock.rw_sem){++++}:
[   17.464779]        lock_acquire+0x578/0x5c0
[   17.469033]        cpus_read_lock+0x60/0x130
[   17.473379]        static_key_enable+0x1c/0x34
[   17.477894]        sched_feat_write+0x300/0x3ec
[   17.482501]        full_proxy_write+0xa4/0xc8
[   17.486935]        __vfs_write+0x10c/0x368
[   17.491100]        vfs_write+0x144/0x2e8
[   17.495090]        ksys_write+0xcc/0x13c
[   17.499079]        sys_write+0x34/0x44
[   17.502892]        el0_svc_naked+0x30/0x34
[   17.507046] 
[   17.507046] -> #0 (&sb->s_type->i_mutex_key#3){+.+.}:
[   17.513742]        __lock_acquire+0x1968/0x1f4c
[   17.518348]        lock_acquire+0x578/0x5c0
[   17.522606]        down_write+0xb8/0x148
[   17.526602]        start_creating+0xbc/0x140
[   17.530948]        debugfs_create_dir+0x2c/0x1b0
[   17.535642]        opp_debug_register+0xc4/0x10c
[   17.540330]        _add_opp_dev+0x178/0x1d8
[   17.544581]        dev_pm_opp_get_opp_table+0x134/0x310
[   17.549885]        dev_pm_opp_set_regulators+0x38/0x300
[   17.555224]        cpufreq_init+0x198/0x3e0 [cpufreq_dt]
[   17.560622]        cpufreq_online+0x3f0/0xcd4
[   17.565052]        cpufreq_add_dev+0x164/0x17c
[   17.569574]        subsys_interface_register+0x244/0x264
[   17.574968]        cpufreq_register_driver+0x178/0x278
[   17.580211]        dt_cpufreq_probe+0x158/0x178 [cpufreq_dt]
[   17.585953]        platform_drv_probe+0xa4/0x134
[   17.590647]        driver_probe_device+0x36c/0x488
[   17.595517]        __driver_attach+0x150/0x1e4
[   17.600034]        bus_for_each_dev+0x110/0x138
[   17.604640]        driver_attach+0x50/0x5c
[   17.608808]        bus_add_driver+0x2ac/0x2f8
[   17.613240]        driver_register+0x180/0x1c8
[   17.617761]        __platform_driver_register+0x9c/0xac
[   17.623092]        dt_cpufreq_platdrv_init+0x28/0x1000 [cpufreq_dt]
[   17.629449]        do_one_initcall+0x59c/0xab0
[   17.633970]        do_init_module+0x174/0x450
[   17.638402]        load_module+0x3a40/0x3b60
[   17.642747]        sys_finit_module+0x150/0x168
[   17.647350]        el0_svc_naked+0x30/0x34
[   17.651506] 
[   17.651506] other info that might help us debug this:
[   17.651506] 
[   17.659624] Chain exists of:
[   17.659624]   &sb->s_type->i_mutex_key#3 --> subsys mutex#6 --> opp_table_lock
[   17.659624] 
[   17.671440]  Possible unsafe locking scenario:
[   17.671440] 
[   17.677445]        CPU0                    CPU1
[   17.682039]        ----                    ----
[   17.686631]   lock(opp_table_lock);
[   17.690197]                                lock(subsys mutex#6);
[   17.696315]                                lock(opp_table_lock);
[   17.702421]   lock(&sb->s_type->i_mutex_key#3);
[   17.707051] 
[   17.707051]  *** DEADLOCK ***
[   17.707051] 
[   17.713070] 4 locks held by systemd-udevd/1538:
[   17.717663]  #0: (____ptrval____) (&dev->mutex){....}, at: __driver_attach+0x134/0x1e4
[   17.725760]  #1: (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: cpufreq_register_driver+0xd8/0x278
[   17.735517]  #2: (____ptrval____) (subsys mutex#6){+.+.}, at: subsys_interface_register+0x10c/0x264
[   17.744761]  #3: (____ptrval____) (opp_table_lock){+.+.}, at: dev_pm_opp_get_opp_table+0xac/0x310
[   17.753811] 
[   17.753811] stack backtrace:
[   17.758252] CPU: 4 PID: 1538 Comm: systemd-udevd Not tainted 4.18.0-rc6 #3
[   17.765215] Hardware name: Renesas Salvator-X board based on r8a7795 ES2.0+ (DT)
[   17.772708] Call trace:
[   17.775209]  dump_backtrace+0x0/0x27c
[   17.778931]  show_stack+0x24/0x30
[   17.782313]  dump_stack+0x13c/0x1b0
[   17.785868]  print_circular_bug.isra.12+0x2a8/0x3f8
[   17.790826]  check_prev_add.constprop.20+0x1a4/0xb24
[   17.795869]  __lock_acquire+0x1968/0x1f4c
[   17.799948]  lock_acquire+0x578/0x5c0
[   17.803675]  down_write+0xb8/0x148
[   17.807143]  start_creating+0xbc/0x140
[   17.810962]  debugfs_create_dir+0x2c/0x1b0
[   17.815125]  opp_debug_register+0xc4/0x10c
[   17.819287]  _add_opp_dev+0x178/0x1d8
[   17.823012]  dev_pm_opp_get_opp_table+0x134/0x310
[   17.827789]  dev_pm_opp_set_regulators+0x38/0x300
[   17.832596]  cpufreq_init+0x198/0x3e0 [cpufreq_dt]
[   17.837464]  cpufreq_online+0x3f0/0xcd4
[   17.841366]  cpufreq_add_dev+0x164/0x17c
[   17.845360]  subsys_interface_register+0x244/0x264
[   17.850228]  cpufreq_register_driver+0x178/0x278
[   17.854943]  dt_cpufreq_probe+0x158/0x178 [cpufreq_dt]
[   17.860158]  platform_drv_probe+0xa4/0x134
[   17.864326]  driver_probe_device+0x36c/0x488
[   17.868670]  __driver_attach+0x150/0x1e4
[   17.872661]  bus_for_each_dev+0x110/0x138
[   17.876740]  driver_attach+0x50/0x5c
[   17.880381]  bus_add_driver+0x2ac/0x2f8
[   17.884287]  driver_register+0x180/0x1c8
[   17.888283]  __platform_driver_register+0x9c/0xac
[   17.893087]  dt_cpufreq_platdrv_init+0x28/0x1000 [cpufreq_dt]
[   17.898918]  do_one_initcall+0x59c/0xab0
[   17.902912]  do_init_module+0x174/0x450
[   17.906818]  load_module+0x3a40/0x3b60
[   17.910636]  sys_finit_module+0x150/0x168
[   17.914712]  el0_svc_naked+0x30/0x34
