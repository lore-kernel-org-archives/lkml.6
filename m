Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFE1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C248721904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m/KDnUqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBGMW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:22:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51033 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBGMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:22:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190207122256euoutp014dea84a02d7fbd4e0d7e05021f105aee~BFGZlcVNm0270302703euoutp01f;
        Thu,  7 Feb 2019 12:22:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190207122256euoutp014dea84a02d7fbd4e0d7e05021f105aee~BFGZlcVNm0270302703euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549542176;
        bh=H6Y7wC3toDL3M1M0Y0eIc6JpT2LapMqMXG+qsTve8bE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=m/KDnUqs2lnwxsJLbfY2Yolry85e0CLx/BQqOjtTNOlDRcYR9VYi7/iEM2TIzaXEx
         PQYnuV/PD2AkxWlAvVUy1SLIPcPPXQuU7zqybXJMc6qSiXFl9ANEzicqYF0IckdgqP
         hICYgSbfKqD1HAyl6n2QraQqs10V87iPIqJSBhe4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207122256eucas1p1b5ec134933d6597575a36fa746b1be4f~BFGZLSMX50912409124eucas1p1Z;
        Thu,  7 Feb 2019 12:22:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 43.F0.04294.F132C5C5; Thu,  7
        Feb 2019 12:22:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207122255eucas1p1cdebed838c799eca46cce6a654a26187~BFGYfLkmd0362003620eucas1p1L;
        Thu,  7 Feb 2019 12:22:55 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-a9-5c5c231f7a16
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.26.04128.F132C5C5; Thu,  7
        Feb 2019 12:22:55 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PMK00LA22DUXV40@eusync1.samsung.com>;
        Thu, 07 Feb 2019 12:22:55 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date:   Thu, 07 Feb 2019 13:22:25 +0100
Message-id: <20190207122227.19873-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7djP87oKyjExBgfvMllsnLGe1eLm1w5W
        i8u75rBZfO49wmgx4/w+Jou1R+6yW7z5cZbJ4szpS6wW/65tZLHY+NXDYuWJWcwO3B6bVnWy
        edy5tofNY8vVdhaPvi2rGD1OnnrC4nH8xnYmj8+b5ALYo7hsUlJzMstSi/TtErgyTlzbxVTQ
        pVnx9NwPtgbGz0pdjJwcEgImEp/3/GbtYuTiEBJYwSix7vwcdgjnM6NE0+1jLDBV13+sZ4JI
        LGOUaFiwngXCaWCSeDP/NhNIFZuAoUTX2y42EFtEwEriRfsrsFHMAk+YJHbe+MkOkhAWcJTY
        8ukeM4jNIqAqsf9qEyOIzStgK3Hg1wGodfISqzccYAZplhCYwSZx6P0vRoiEi8TGW5+YIGwZ
        icuTu1kgipoZJdpnzGKHcHoYJbbO2cEGUWUtcfj4RVYQm1mAT2LStulAYzmA4rwSHW1CECUe
        EusXHAIrFxKIlfg+ewrTBEbxBYwMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQLj8fS/
        4192MO76k3SIUYCDUYmHN+BWVIwQa2JZcWXuIUYJDmYlEV4xuZgYId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYz58bJqd+JfO/Oy7Zl6Pf5FmN33KXVl
        M5S95DtiYs55pSxXfsefFj1TrECTyfVG3iO9ix432OOeJH/hY7901GoHd1TAvwcPOTvL+rse
        fny50vaqh+1CrgOnvmdzCTfxLFOZc2ZXlBqHXp33ciOvzsArFW0vyg+msm3imh137PHs0/wv
        QnfsOKLEUpyRaKjFXFScCAC3YvDHwwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e/4ZV155ZgYg/+9YhYbZ6xntbj5tYPV
        4vKuOWwWn3uPMFrMOL+PyWLtkbvsFm9+nGWyOHP6EqvFv2sbWSw2fvWwWHliFrMDt8emVZ1s
        Hneu7WHz2HK1ncWjb8sqRo+Tp56weBy/sZ3J4/MmuQD2KC6blNSczLLUIn27BK6ME9d2MRV0
        aVY8PfeDrYHxs1IXIyeHhICJxPUf65m6GLk4hASWMErMuXIRymlikpj46w4bSBWbgKFE19su
        MFtEwEriRfsrdpAiZoEnTBIPHqxlAkkICzhKbPl0jxnEZhFQldh/tYkRxOYVsJU48OsAC8Q6
        eYnVGw4wT2DkWsDIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwkLYd+7llB2PXu+BDjAIc
        jEo8vD+uR8UIsSaWFVfmHmKU4GBWEuEVk4uJEeJNSaysSi3Kjy8qzUktPsQozcGiJM573qAy
        SkggPbEkNTs1tSC1CCbLxMEp1cB4cIPHVvejs03m3r8w+d9ai9s68QGCj5+nODrVTSt6vI7f
        s2Q9c2X01W96k/tsdst4ZNhvnH2+it8mye39lKSm3ZLMZ9JyO5atX/lFyNP0gVpWmXjvhh7B
        N4+W3Cl/8pLNe2fFks3LvzllPBfc+e/Sv3eF+sKi5xLeK33ff8HtyiWmf79/i7g5K7EUZyQa
        ajEXFScCAG94BXQgAgAA
X-CMS-MailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
i2c adapters") added a visible warning for an attempt to do i2c transfer
over a suspended i2c bus. This revealed a long standing issue in the
cpufreq-dt driver, which gives a following warning during system
suspend/resume cycle:

--->8---
Enabling non-boot CPUs ...
CPU1 is up
CPU2 is up
CPU3 is up
------------[ cut here ]------------
WARNING: CPU: 4 PID: 29 at drivers/i2c/i2c-core-base.c:1869 __i2c_transfer+0x6f8/0xa50
Modules linked in:
CPU: 4 PID: 29 Comm: cpuhp/4 Tainted: G        W         5.0.0-rc4-next-20190131-00024-g54b06b29cc65 #5324
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c01110e8>] (unwind_backtrace) from [<c010d11c>] (show_stack+0x10/0x14)
[<c010d11c>] (show_stack) from [<c09a2584>] (dump_stack+0x90/0xc8)
[<c09a2584>] (dump_stack) from [<c0120bd0>] (__warn+0xf8/0x124)
[<c0120bd0>] (__warn) from [<c0120c3c>] (warn_slowpath_null+0x40/0x48)
[<c0120c3c>] (warn_slowpath_null) from [<c065cda0>] (__i2c_transfer+0x6f8/0xa50)
[<c065cda0>] (__i2c_transfer) from [<c065d168>] (i2c_transfer+0x70/0xe4)
[<c065d168>] (i2c_transfer) from [<c053ce4c>] (regmap_i2c_read+0x48/0x64)
[<c053ce4c>] (regmap_i2c_read) from [<c0536f1c>] (_regmap_raw_read+0xf8/0x450)
[<c0536f1c>] (_regmap_raw_read) from [<c053772c>] (_regmap_bus_read+0x38/0x68)
[<c053772c>] (_regmap_bus_read) from [<c05365a0>] (_regmap_read+0x60/0x250)
[<c05365a0>] (_regmap_read) from [<c05367cc>] (regmap_read+0x3c/0x5c)
[<c05367cc>] (regmap_read) from [<c047cfc0>] (regulator_is_enabled_regmap+0x20/0x90)
[<c047cfc0>] (regulator_is_enabled_regmap) from [<c0477660>] (_regulator_is_enabled+0x34/0x40)
[<c0477660>] (_regulator_is_enabled) from [<c0478674>] (create_regulator+0x1a4/0x25c)
[<c0478674>] (create_regulator) from [<c047c818>] (_regulator_get+0xe4/0x278)
[<c047c818>] (_regulator_get) from [<c068f1dc>] (dev_pm_opp_set_regulators+0xa0/0x1c0)
[<c068f1dc>] (dev_pm_opp_set_regulators) from [<c0698cc8>] (cpufreq_init+0x98/0x2d0)
[<c0698cc8>] (cpufreq_init) from [<c06959e4>] (cpufreq_online+0xc8/0x71c)
[<c06959e4>] (cpufreq_online) from [<c06960fc>] (cpuhp_cpufreq_online+0x8/0x10)
[<c06960fc>] (cpuhp_cpufreq_online) from [<c01213d4>] (cpuhp_invoke_callback+0xf4/0xebc)
[<c01213d4>] (cpuhp_invoke_callback) from [<c0122e4c>] (cpuhp_thread_fun+0x1d8/0x320)
[<c0122e4c>] (cpuhp_thread_fun) from [<c0149858>] (smpboot_thread_fn+0x194/0x340)
[<c0149858>] (smpboot_thread_fn) from [<c014573c>] (kthread+0x124/0x160)
[<c014573c>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xe897dfb0 to 0xe897dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 3865
hardirqs last  enabled at (3873): [<c0186dec>] vprintk_emit+0x228/0x2a4
hardirqs last disabled at (3880): [<c0186cf0>] vprintk_emit+0x12c/0x2a4
softirqs last  enabled at (3052): [<c0102564>] __do_softirq+0x3a4/0x66c
softirqs last disabled at (3043): [<c0128464>] irq_exit+0x140/0x168
---[ end trace db48b455d924fec2 ]---
CPU4 is up
CPU5 is up
CPU6 is up
CPU7 is up
--->8---

This is a scenario that triggers the above issue:

1. system disables non-boot cpu's at the end of system suspend procedure,
2. this in turn deinitializes cpufreq drivers for the disabled cpus,
3. early in the system resume procedure all cpus are got back to online
   state,
4. this in turn causes cpufreq to be initialized for the newly onlined
   cpus,
5. cpufreq-dt acquires all its resources (clocks, regulators) during
   ->init() callback,
6. getting regulator require to check its state, what in turn requires
   i2c transfer,
7. during system early resume stage this is not really possible.

The issue is caused by cpufreq-dt driver not keeping its resources for
the whole driver lifetime and relying that they can be always acquired
at any system context. This problem has been observed on Samsung
Exynos based Odroid XU3/XU4 boards, but it happens on all boards, which
have separate regulators for different CPU clusters.

To fix this issue I've rewritten resources (clock and regulators)
handling in cpufreq-dt driver. Now the driver gathers them in its
->probe() and keeps using them until the ->remove() happens. This
required also some rework in common opp regulators handling code.
Namely, regulators are no longer assigned by name, instead the caller
has to pass proper regulator object. The side-effect of this work
is also a removal of the FIXME item and correct handling of deferred
probe caused by lack of non-CPU0 regulator.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (2):
  cpufreq: dt/ti/opp: move regulators initialization to the drivers
  cpufreq: dt: rework resources initialization

 drivers/cpufreq/cpufreq-dt.c | 127 +++++++++++++++--------------------
 drivers/cpufreq/ti-cpufreq.c |  42 ++++++++++--
 drivers/opp/core.c           |  40 ++---------
 include/linux/pm_opp.h       |   2 +-
 4 files changed, 96 insertions(+), 115 deletions(-)

-- 
2.17.1

