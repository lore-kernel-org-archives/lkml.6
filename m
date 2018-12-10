Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A51C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2CD2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2CD2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeLJSTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbeLJSTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:19:37 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4CE2081F;
        Mon, 10 Dec 2018 18:19:34 +0000 (UTC)
Date:   Mon, 10 Dec 2018 13:19:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        Oleg Nesterov <oleg@redhat.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: mainline/master boot bisection: v4.20-rc5-79-gabb8d6ecbd8f on
 jetson-tk1
Message-ID: <20181210131933.53e3ae8a@gandalf.local.home>
In-Reply-To: <f24ba5f2-dcc8-45d2-9599-3a0d40fe4d95@linux.ibm.com>
References: <5c09f05a.1c69fb81.95568.35c2@mx.google.com>
        <f24ba5f2-dcc8-45d2-9599-3a0d40fe4d95@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 16:23:19 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Hi,
> 
> Can you please provide more details. I don't understand how this patch
> can cause boot failure.
> 
> >From the log found at  
> https://storage.kernelci.org/mainline/master/v4.20-rc5-79-gabb8d6ecbd8f/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/lab-baylibre/boot-tegra124-jetson-tk1.html
> 
> 23:21:06.680269  [    7.500733] Unable to handle kernel NULL pointer dereference at virtual address 00000064
> 23:21:06.680455  [    7.508893] pgd = (ptrval)
> 23:21:06.721940  [    7.511591] [00000064] *pgd=ad7d8003, *pmd=f9d5d003
> 23:21:06.722241  [    7.516500] Internal error: Oops: 207 [#1] SMP ARM
>  ...
> 23:21:06.722724  [    7.546706] CPU: 0 PID: 122 Comm: udevd Not tainted 4.20.0-rc5 #1
> 23:21:06.722911  [    7.552785] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> 23:21:06.765203  [    7.559045] PC is at drm_plane_register_all+0x18/0x50
> 23:21:06.765493  [    7.564094] LR is at drm_modeset_register_all+0xc/0x6c
> 23:21:06.765698  [    7.569217] pc : [<c09a8700>]    lr : [<c09ab240>]    psr: a0000013
> 23:21:06.765882  [    7.575470] sp : c3451c70  ip : 2d827000  fp : c1804c48
> 23:21:06.766053  [    7.580680] r10: 00000000  r9 : ec9cc300  r8 : 00000000
> 23:21:06.766229  [    7.585893] r7 : bf193c80  r6 : 00000000  r5 : c3694224  r4 : fffffffc
> 23:21:06.766403  [    7.592404] r3 : 00002000  r2 : 0002f000  r1 : eef92cf0  r0 : c3694000
>  ...
> 23:21:07.068237  [    7.880215] [<c09a8700>] (drm_plane_register_all) from [<c09ab240>] (drm_modeset_register_all+0xc/0x6c)
> 23:21:07.068493  [    7.889603] [<c09ab240>] (drm_modeset_register_all) from [<c0992054>] (drm_dev_register+0x16c/0x1c4)
> 23:21:07.109960  [    7.898915] [<c0992054>] (drm_dev_register) from [<bf0ec0d8>] (nouveau_platform_probe+0x54/0x8c [nouveau])
> 23:21:07.110285  [    7.908750] [<bf0ec0d8>] (nouveau_platform_probe [nouveau]) from [<c0a45968>] (platform_drv_probe+0x48/0x98)
> 23:21:07.110515  [    7.918572] [<c0a45968>] (platform_drv_probe) from [<c0a43bd8>] (really_probe+0x228/0x2d0)
> 23:21:07.110706  [    7.926832] [<c0a43bd8>] (really_probe) from [<c0a43de4>] (driver_probe_device+0x60/0x174)
> 23:21:07.110893  [    7.935093] [<c0a43de4>] (driver_probe_device) from [<c0a43fc8>] (__driver_attach+0xd0/0xd4)
> 23:21:07.153794  [    7.943528] [<c0a43fc8>] (__driver_attach) from [<c0a41e8c>] (bus_for_each_dev+0x74/0xb4)
> 23:21:07.154133  [    7.951688] [<c0a41e8c>] (bus_for_each_dev) from [<c0a42ff0>] (bus_add_driver+0x18c/0x210)
> 23:21:07.154352  [    7.959946] [<c0a42ff0>] (bus_add_driver) from [<c0a44b24>] (driver_register+0x74/0x108)
> 23:21:07.154544  [    7.968212] [<c0a44b24>] (driver_register) from [<bf1bb170>] (nouveau_drm_init+0x170/0x1000 [nouveau])
> 23:21:07.154739  [    7.977692] [<bf1bb170>] (nouveau_drm_init [nouveau]) from [<c0402d6c>] (do_one_initcall+0x54/0x1fc)
> 23:21:07.197008  [    7.986820] [<c0402d6c>] (do_one_initcall) from [<c04d276c>] (do_init_module+0x64/0x1f4)
> 23:21:07.197344  [    7.994906] [<c04d276c>] (do_init_module) from [<c04d1980>] (load_module+0x1ee8/0x23c8)
> 23:21:07.197553  [    8.002907] [<c04d1980>] (load_module) from [<c04d2080>] (sys_finit_module+0xac/0xd8)
> 23:21:07.197751  [    8.010722] [<c04d2080>] (sys_finit_module) from [<c0401000>] (ret_fast_syscall+0x0/0x4c)
> 23:21:07.197935  [    8.018884] Exception stack(0xc3451fa8 to 0xc3451ff0)
> 
> 
> Both PC and LR are pointing to drm_* code. I don't see this anyway related to
> uprobes. Did I miss anything?
> 

The bot sometimes gets confused during the bisect. This looks to be one
of those times. I'd simply ignore it because the code path of the
commit it points out is obviously never hit.

The bug may be a race condition that will cause havoc with automated
bisects.

-- Steve
