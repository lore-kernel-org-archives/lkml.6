Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeDSHIM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 03:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeDSHIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 03:08:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67F3217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx48Df2gQiOSem3dAveSQ/H2nNaek+NJJIayMqVQ+QPDE6IUmt1OiVTxJB2++gWhtSWIlMCOEG6BQB8t3JX2ziP0=
MIME-Version: 1.0
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 19 Apr 2018 09:08:07 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd-+jp99p=5MsCa=68TNSJk57+drcFgUr2Y1rWW3RPbSA@mail.gmail.com>
Message-ID: <CAJKOXPd-+jp99p=5MsCa=68TNSJk57+drcFgUr2Y1rWW3RPbSA@mail.gmail.com>
Subject: [BUG] NULL pointer on next-20180419 on Odroid XU3 (snd_soc_register_card)
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark and Liam,

On today's next-20180419, NULL pointer exception appeared in
snd_soc_instantiate_card() on Odroid XU3 and XU boards (Samsung,
Exynos5422, Exynos5410, max98090 codec). Built with exynos_defconfig
(ARM).

I bisected it to:
45f8cb57da0d7a9ead4b39d7f5def333a5b0c08b is the first bad commit
commit 45f8cb57da0d7a9ead4b39d7f5def333a5b0c08b
Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date:   Tue Mar 27 14:30:40 2018 +0100

    ASoC: core: Allow topology to override machine driver FE DAI link config.

    Machine drivers statically define a number of DAI links that currently
    cannot be changed or removed by topology. This means PCMs and platform
    components cannot be changed by topology at runtime AND machine drivers
    are tightly coupled to topology.

    This patch allows topology to override the machine driver DAI link config
    in order to reuse machine drivers with different topologies and platform
    components. The patch supports :-

    1) create new FE PCMs with a topology defined PCM ID.
    2) destroy existing static FE PCMs
    3) change the platform component driver.
    4) assign any new HW params fixups.

    The patch requires no changes to the machine drivers, but does add some
    platform component flags that the platform component driver can assign
    before loading topologies.

    Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

:040000 040000 25fc03e81975655bd0f90500b2578551742a2fba
28715f6094887d961cb84b26a4d56f478c1ace89 M include
:040000 040000 e387f83c522f7cfc71c0f7669752b4475e3ab55e
baad16725177cc3a4bb6c70afb2416d4f1b7f620 M sound



Full OOPS:
[    6.172383] max98090 5-0010: MAX98090 REVID=0x43
[    6.182548] max98090 5-0010: use default 2.8v micbias
[    6.196790] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[    6.203639] pgd = 7cab35d7
[    6.206125] [00000004] *pgd=00000000
[    6.209748] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    6.214958] Modules linked in:
[    6.217982] CPU: 0 PID: 62 Comm: kworker/0:2 Not tainted
4.17.0-rc1-next-20180419 #41
[    6.225797] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    6.231877] Workqueue: events deferred_probe_work_func
[    6.236973] PC is at snd_soc_register_card+0xacc/0x1048
[    6.242165] LR is at 0x3
[    6.244663] pc : [<c0783b44>]    lr : [<00000003>]    psr: 60000013
[    6.250917] sp : eeb25d98  ip : 00000000  fp : ecc18800
[    6.256113] r10: ee0ec810  r9 : 00000002  r8 : ee0eca60
[    6.261312] r7 : ee0ec968  r6 : ecc18e14  r5 : ee0ec900  r4 : c0d73e24
[    6.267817] r3 : 00000000  r2 : 5d521c4d  r1 : ee0ecc24  r0 : 00000000
[    6.274315] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    6.281421] Control: 10c5387d  Table: 4000406a  DAC: 00000051
[    6.287138] Process kworker/0:2 (pid: 62, stack limit = 0xf8128fcf)
[    6.293377] Stack: (0xeeb25d98 to 0xeeb26000)
[    6.297704] 5d80:
    00000000 ee0ec890
[    6.305868] 5da0: c1008448 ee0eca08 ee0ec898 c0284318 ee0ec984
c10804fc c0dc0a38 014080c0
[    6.314013] 5dc0: ee0c6200 5d521c4d 00000000 ee0ec810 ee0c88d0
ee0ec810 ee05e810 ef01f7a4
[    6.322159] 5de0: c10898e8 00000000 00000022 c0793cc0 ee0ec810
00000000 ee05e810 ee0eca60
[    6.330304] 5e00: ef01f7a4 c07a6b80 ee05e810 ee05e810 c10898e8
fffffdfb c18136f8 c0578400
[    6.338450] 5e20: ee05e810 c18136f4 00000000 c10b3320 c18136f8
c0575f4c 00000001 c0578a40
[    6.346595] 5e40: c10898e8 00000000 eeb25e94 c0576240 c1008448
00000001 c0d78588 c10b3320
[    6.354741] 5e60: c10c6d60 c0573f24 fffffff3 ee8a7ed4 ed55f3d4
5d521c4d ee05e810 ee05e810
[    6.362886] 5e80: c1008448 ee05e844 c1064414 c0575b24 c1064414
ee05e810 00000001 5d521c4d
[    6.371031] 5ea0: ee05e810 ee05e810 c1064738 c1064414 eeb24000
c0574de4 ee05e810 c10643c8
[    6.379177] 5ec0: c10643c8 c05753a0 ffffe000 00000000 60000013
c1064438 eeaaf100 eef65fc0
[    6.387323] 5ee0: eeb25f1c c100846c eef69200 c1008448 c10ab850
c01471d8 00000001 00000000
[    6.395468] 5f00: c0147114 60000093 00000000 00000000 c10aa247
eef65fc0 c0147978 c1064438
[    6.403614] 5f20: c120f104 00000000 c0d7887c 5d521c4d eef65fc0
eeaaf100 eef65fc0 eeaaf118
[    6.411759] 5f40: 00000008 c1005900 eef65ff4 eeb24000 eef65fc0
c01478d8 eea9f340 00000000
[    6.419905] 5f60: ffffe000 eeb23000 eea9f340 00000000 eeb24000
eeaaf100 c01478a0 eeb23038
[    6.428050] 5f80: eeb03ea0 c014e1f4 eeb24000 eea9f340 c014e0bc
00000000 00000000 00000000
[    6.436195] 5fa0: 00000000 00000000 00000000 c01010b4 00000000
00000000 00000000 00000000
[    6.444340] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    6.452486] 5fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[    6.460643] [<c0783b44>] (snd_soc_register_card) from [<c0793cc0>]
(devm_snd_soc_register_card+0x38/0x70)
[    6.470179] [<c0793cc0>] (devm_snd_soc_register_card) from
[<c07a6b80>] (odroid_audio_probe+0x1a4/0x210)
[    6.479621] [<c07a6b80>] (odroid_audio_probe) from [<c0578400>]
(platform_drv_probe+0x4c/0xb0)
[    6.488193] [<c0578400>] (platform_drv_probe) from [<c0575f4c>]
(driver_probe_device+0x2e0/0x4b4)
[    6.497032] [<c0575f4c>] (driver_probe_device) from [<c0573f24>]
(bus_for_each_drv+0x74/0xb8)
[    6.505521] [<c0573f24>] (bus_for_each_drv) from [<c0575b24>]
(__device_attach+0xd4/0x168)
[    6.513753] [<c0575b24>] (__device_attach) from [<c0574de4>]
(bus_probe_device+0x88/0x90)
[    6.521898] [<c0574de4>] (bus_probe_device) from [<c05753a0>]
(deferred_probe_work_func+0x64/0x18c)
[    6.530917] [<c05753a0>] (deferred_probe_work_func) from
[<c01471d8>] (process_one_work+0x220/0x8e8)
[    6.540012] [<c01471d8>] (process_one_work) from [<c01478d8>]
(worker_thread+0x38/0x584)
[    6.548073] [<c01478d8>] (worker_thread) from [<c014e1f4>]
(kthread+0x138/0x168)
[    6.555433] [<c014e1f4>] (kthread) from [<c01010b4>]
(ret_from_fork+0x14/0x20)
[    6.562616] Exception stack(0xeeb25fb0 to 0xeeb25ff8)
[    6.567633] 5fa0:                                     00000000
00000000 00000000 00000000
[    6.575794] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    6.583939] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    6.590521] Code: e5d83059 e3130080 1a0000ec e59b35a4 (e5932004)
[    6.596677] ---[ end trace 97faeced889b58b2 ]---
[    6.963181] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex,
lpa 0xC1E1

Full log is here:
http://www.krzk.eu/#/builders/1/builds/1769/steps/10/logs/serial0

Bisect log:
git bisect start
# bad: [2754896635e43cdfaf49175a2df23c8bc0eab37a] Add linux-next
specific files for 20180419
git bisect bad 2754896635e43cdfaf49175a2df23c8bc0eab37a
# good: [a27fc14219f2e3c4a46ba9177b04d9b52c875532] Merge branch
'parisc-4.17-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect good a27fc14219f2e3c4a46ba9177b04d9b52c875532
# good: [d5d9427e3e758fdb55c71a224d587d752661c405] Merge
remote-tracking branch 'v4l-dvb/master'
git bisect good d5d9427e3e758fdb55c71a224d587d752661c405
# bad: [4fcbe47f55bb71b44724ec00626e28efc24b7bad] Merge
remote-tracking branch 'security/next-testing'
git bisect bad 4fcbe47f55bb71b44724ec00626e28efc24b7bad
# good: [c0c9267abfaf150c68138271f7fe014e5002d7cf] Merge
remote-tracking branch 'sound/for-next'
git bisect good c0c9267abfaf150c68138271f7fe014e5002d7cf
# bad: [726ada29f866aa17d76929b89dc7601300c5a1d6] Merge
remote-tracking branch 'block/for-next'
git bisect bad 726ada29f866aa17d76929b89dc7601300c5a1d6
# good: [651e4890930d10d009a9a8b829a7177670975ec7] ASoC: Intel:
Skylake: Unify the fw ops for SKL and KBL
git bisect good 651e4890930d10d009a9a8b829a7177670975ec7
# good: [28f66e6a6a2528369f22d319870fc1b619d05ca2] Merge branch
'for-4.17/block' into for-next
git bisect good 28f66e6a6a2528369f22d319870fc1b619d05ca2
# bad: [24ada03555505205b0c8b8b796d52926600bf947] ASoC: topology: Fix
build errors
git bisect bad 24ada03555505205b0c8b8b796d52926600bf947
# bad: [45f8cb57da0d7a9ead4b39d7f5def333a5b0c08b] ASoC: core: Allow
topology to override machine driver FE DAI link config.
git bisect bad 45f8cb57da0d7a9ead4b39d7f5def333a5b0c08b
# good: [112c60b333ec9ddc7e940116f5e9fdc0d1a9706a] ASoC: Intel:
Skylake: Reset stream to link mapping
git bisect good 112c60b333ec9ddc7e940116f5e9fdc0d1a9706a
# good: [7b0037fa2d6048284e90de4131fc53c0ac1d4430] ASoC: nau8824: user
configuration of key detection
git bisect good 7b0037fa2d6048284e90de4131fc53c0ac1d4430
# first bad commit: [45f8cb57da0d7a9ead4b39d7f5def333a5b0c08b] ASoC:
core: Allow topology to override machine driver FE DAI link config.
krzk@PC-kkoz:~/dev/linux$

Best regards,
Krzysztof
