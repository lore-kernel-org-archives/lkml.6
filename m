Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4131AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189A820823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfAVQJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:09:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:56131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbfAVQJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:09:23 -0500
Received: from [91.14.89.174] ([91.14.89.174]) by web-mail.gmx.net
 (3c-app-gmx-bs21.server.lan [172.19.170.73]) (via HTTP); Tue, 22 Jan 2019
 17:09:09 +0100
MIME-Version: 1.0
Message-ID: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Joerg Roedel" <joro@8bytes.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Jan 2019 17:09:09 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:9+allI/Tfg/FrW4dJ6O05+us0VMhCXjjMzGp0AbgDel3cqRAwVOLDM0LicCnx72MNI3em
 yheK5IUr5jrh10PgyP3mL//j6p0+QTJl9y0v/QwIb7ACEqGo19NLkw3S6SVXgFpQSaqgHOLMJKG8
 21PU5eab6tjt5U22k95bjro3XWqFSdkDs25iYRaxAa454tKUFMRnmUDwUvGLe3UyCdCb/tC07PUG
 VL/003DbgjWD2PIU4CrenIBVH/5wA3LnwhO7ujUMfHYU5hxsccM4lZBmFHdD6JGLIyD7fiSXH+IN
 3k=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZXoZnQYyRZM=:pYg39yDcx38Rue5mlj4a8g
 XmeELkoaZDz58eIDwpwf1fWnzaHca5o2JdACup/24mE+48YUzZVS3l2NcuNsb74xkDSu5HfJa
 LCFDiWVbam00Tk9DMgWzER1vlSUazgo9hGQdRRwS+vxzA9OSg6yHhWOh82PBF8oLJ3WBr8lwa
 klUQ0SaPpGSkFT6/KzdLRQvWVr+l/qtRFGuACEzzkWUH4F/yV/6uHRkNjNxUpGgHPzSR5Rxxk
 I1Y42+1gLp0R0evsT0XOkVEVjV7bBaCzD1HjDj4v+FNr82GJOeVathxaCoc+FX+S408VKOAeZ
 9pxwW3mjnyfo16BpxsJX6OSnwlPt2uDgmL3Wfjx0xDbfj1ViimTpLxO1fIaqmsZ3HO02rtCMI
 3B1LMbXZQxiW6H6S6972WtVrGVF7WXQmyZgH1B9OvaK8V544xaXapfGcPUur+qoUzShayuRlo
 PaFJVj0uwKEPd/liwUR755IfTJ7jKoOfAA4xRLPGwfxMjsw8Ih5Xow7DIwjZsX4hi0urxXxvA
 ElfiiBsACHyGZxG8bw2VRbOkD1uFyx76R1QgUWZ19IpvR8IgMLT5XoljqZNZFzlu+gRWlZ5qF
 DAiy660HYGMWs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following Patch breaks hdmi (at least) on Bananapi R2 (mt7623):

a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a "iommu/mediatek: Use helper functions to access dev->iommu_fwspec"

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu/mtk_iommu_v1.c?id=a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a

[    5.363509] Backtrace:                                                                      
[    5.365946] [<c05a6010>] (mtk_iommu_domain_free) from [<c05a1544>] (iommu_domain_free+0x20/)
[    5.374670]  r4:decd57a0                                                                    
[    5.377192] [<c05a1524>] (iommu_domain_free) from [<c011b85c>] (release_iommu_mapping+0x24/)
[    5.385922] [<c011b838>] (release_iommu_mapping) from [<c011b8cc>] (arm_iommu_release_mappi)
[    5.395943]  r7:00000000 r6:decd5780 r5:00000000 r4:decd57a0                                
[    5.401567] [<c011b89c>] (arm_iommu_release_mapping.part.0) from [<c011cb4c>] (arch_setup_d)
[    5.411412]  r5:00000000 r4:dead1410                                                        
[    5.414968] [<c011ca7c>] (arch_setup_dma_ops) from [<c07d2764>] (of_dma_configure+0x27c/0x3)
[    5.423521]  r6:c0b58e20 r5:00000000 r4:00000000                                            
[    5.428109] [<c07d24e8>] (of_dma_configure) from [<c060a63c>] (platform_dma_configure+0x28/)
[    5.436838]  r10:c107efdc r9:00000000 r8:c10c0008 r7:00000000 r6:c1117b34 r5:dead1410       
[    5.444612]  r4:c1117b30                                                                    
[    5.447131] [<c060a614>] (platform_dma_configure) from [<c06079ec>] (really_probe+0xc4/0x42)
[    5.455602] [<c0607928>] (really_probe) from [<c0607f70>] (driver_probe_device+0x88/0x1e0)  
[    5.463814]  r10:00000000 r9:c060a25c r8:00000000 r7:c1008c48 r6:c107efdc r5:c107efdc       
[    5.471588]  r4:dead1410                                                                    
[    5.474107] [<c0607ee8>] (driver_probe_device) from [<c06081fc>] (__driver_attach+0x134/0x1)
[    5.482663]  r9:c060a25c r8:00000000 r7:c1008c48 r6:c107efdc r5:dead1444 r4:dead1410        
[    5.490358] [<c06080c8>] (__driver_attach) from [<c0605510>] (bus_for_each_dev+0x84/0xc4)   
[    5.498480]  r7:c1008c48 r6:c06080c8 r5:c107efdc r4:00000000                                
[    5.504102] [<c060548c>] (bus_for_each_dev) from [<c0607344>] (driver_attach+0x2c/0x30)     
[    5.512052]  r7:c10bff30 r6:c107fad8 r5:decde780 r4:c107efdc                                
[    5.517675] [<c0607318>] (driver_attach) from [<c0606c68>] (bus_add_driver+0x1d0/0x274)     
[    5.525629] [<c0606a98>] (bus_add_driver) from [<c0608fa8>] (driver_register+0x84/0x118)    
[    5.533666]  r8:c060a20c r7:c0609c60 r6:c10c0230 r5:00000002 r4:c107efdc                    
[    5.540323] [<c0608f24>] (driver_register) from [<c060a538>] (__platform_register_drivers+0)

after reverting it i can boot without crash and start x-server

my repo just for reference (revert not pushed yet): https://github.com/frank-w/BPI-R2-4.14/tree/5.0-hdmi

i hope i had chosen the right way to report this...

regards Frank
