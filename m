Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCVJss (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:48:48 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:34517 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbeCVJsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:48:46 -0400
Date: Thu, 22 Mar 2018 11:48:41 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 4.15-rc9 new insecure W+X mapping warning
In-Reply-To: <alpine.LRH.2.21.1802261127370.4893@math.ut.ee>
Message-ID: <alpine.LRH.2.21.1803221148040.11209@math.ut.ee>
References: <alpine.LRH.2.21.1801242127140.27627@math.ut.ee> <alpine.LRH.2.21.1802261127370.4893@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is Intel SE7520JR22S mainboard with 2 64-bit P4 xeons. Earlier 
> > kernels up to 4.14 have had W+X checking on but found nothing. Now I 
> > tried 4.15.0-rc9-00023-g1f07476ec143 and it gives a new W+X warning. 
> 
> This still happens in 4.15 and 4.16-rc2+.
> 
> What can I do to help resolving it?

Below is kernel_page_tables from debugfs.

> > [   10.880663] ------------[ cut here ]------------
> > [   10.880755] x86/mm: Found insecure W+X mapping at address 00000000d051fb08/0xffff880000000000
> > [   10.880900] WARNING: CPU: 2 PID: 1 at arch/x86/mm/dump_pagetables.c:266 note_page+0x718/0xb89
> > [   10.881035] Modules linked in:
> > [   10.881128] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc9-00023-g1f07476ec143 #104
> > [   10.881264] Hardware name: Intel                                  /SE7520JR22S, BIOS SE7520JR22.86B.P.10.00.0087.120820051348 12/08/2005
> > [   10.881405] RIP: 0010:note_page+0x718/0xb89
> > [   10.881491] RSP: 0000:ffffc90000013e48 EFLAGS: 00010296
> > [   10.881578] RAX: 0000000000000051 RBX: ffffc90000013ec8 RCX: ffffffff8164f938
> > [   10.881666] RDX: 0000000000000001 RSI: 0000000000000092 RDI: ffffffff82b468cc
> > [   10.881756] RBP: 0000000000000061 R08: 0000000000000177 R09: 00000000000001d7
> > [   10.881844] R10: 0720072007200720 R11: 0720072007200720 R12: 0000000000000000
> > [   10.881932] R13: 0000000000000000 R14: 0000000000000001 R15: 8800000990000000
> > [   10.882022] FS:  0000000000000000(0000) GS:ffff88003fc80000(0000) knlGS:0000000000000000
> > [   10.882156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   10.882243] CR2: 0000000000000000 CR3: 000000000200a000 CR4: 00000000000006e0
> > [   10.882331] Call Trace:
> > [   10.882423]  ptdump_walk_pgd_level_core+0x367/0x3a5
> > [   10.882511]  ptdump_walk_pgd_level_checkwx+0x10/0x3e
> > [   10.882602]  kernel_init+0x2e/0x10f
> > [   10.882688]  ? rest_init+0xb9/0xb9
> > [   10.882775]  ret_from_fork+0x35/0x40
> > [   10.882861] Code: fb ff ff 41 f7 c7 00 10 00 00 0f 85 e2 fe ff ff e9 36 fd ff ff c6 05 7d 45 6f 01 01 48 89 f2 48 c7 c7 08 5b ee 81 e8 4b d6 00 00 <0f> ff 48 8b 73 10 e9 bc f9 ff ff 4d 85 ed 0f 84 b9 01 00 00 41 
> > [   10.883103] ---[ end trace bc3e2cf1a1adfa39 ]---
> > [   10.896336] x86/mm: Checked W+X mappings: FAILED, 266243 W+X pages found.
> > [   10.896430] x86/mm: Checking user space page tables
> > [   10.909522] x86/mm: Checked W+X mappings: FAILED, 56 W+X pages found.

---[ User Space ]---
0x0000000000000000-0xffff800000000000    16777088T                               pgd
---[ Kernel Space ]---
0xffff800000000000-0xffff880000000000           8T                               pgd
---[ Low Kernel Mapping ]---
0xffff880000000000-0xffff880000099000         612K     RW                 GLB x  pte
0xffff880000099000-0xffff88000009b000           8K     ro                 GLB x  pte
0xffff88000009b000-0xffff880000200000        1428K     RW                 GLB x  pte
0xffff880000200000-0xffff880001000000          14M     RW         PSE     GLB x  pmd
0xffff880001000000-0xffff880001800000           8M     ro         PSE     GLB x  pmd
0xffff880001800000-0xffff880001892000         584K     ro                 GLB x  pte
0xffff880001892000-0xffff880001a00000        1464K     RW                 GLB x  pte
0xffff880001a00000-0xffff880001b52000        1352K     ro                 GLB x  pte
0xffff880001b52000-0xffff880001c00000         696K     RW                 GLB x  pte
0xffff880001c00000-0xffff8800dfe00000        3554M     RW         PSE     GLB x  pmd
0xffff8800dfe00000-0xffff8800dffe0000        1920K     RW                 GLB x  pte
0xffff8800dffe0000-0xffff8800e0000000         128K                               pte
0xffff8800e0000000-0xffff880100000000         512M                               pmd
0xffff880100000000-0xffff88030ec00000        8428M     RW         PSE     GLB x  pmd
0xffff88030ec00000-0xffff88030ec12000          72K     RW                 GLB x  pte
0xffff88030ec12000-0xffff88030ec1a000          32K     ro                 GLB x  pte
0xffff88030ec1a000-0xffff88030ec28000          56K     RW                 GLB x  pte
0xffff88030ec28000-0xffff88030ec30000          32K     ro                 GLB x  pte
0xffff88030ec30000-0xffff88030ec37000          28K     RW                 GLB x  pte
0xffff88030ec37000-0xffff88030ec4c000          84K     ro                 GLB x  pte
0xffff88030ec4c000-0xffff88030ec50000          16K     RW                 GLB x  pte
0xffff88030ec50000-0xffff88030ec54000          16K     ro                 GLB x  pte
0xffff88030ec54000-0xffff88030ec82000         184K     RW                 GLB x  pte
0xffff88030ec82000-0xffff88030ec84000           8K     ro                 GLB x  pte
0xffff88030ec84000-0xffff88030ec92000          56K     RW                 GLB x  pte
0xffff88030ec92000-0xffff88030ec97000          20K     ro                 GLB x  pte
0xffff88030ec97000-0xffff88030eca6000          60K     RW                 GLB x  pte
0xffff88030eca6000-0xffff88030ecbb000          84K     ro                 GLB x  pte
0xffff88030ecbb000-0xffff88030ed03000         288K     RW                 GLB x  pte
0xffff88030ed03000-0xffff88030ed04000           4K     ro                 GLB x  pte
0xffff88030ed04000-0xffff88030ed20000         112K     RW                 GLB x  pte
0xffff88030ed20000-0xffff88030ed2c000          48K     ro                 GLB x  pte
0xffff88030ed2c000-0xffff88030ed60000         208K     RW                 GLB x  pte
0xffff88030ed60000-0xffff88030ed69000          36K     ro                 GLB x  pte
0xffff88030ed69000-0xffff88030ed6a000           4K     RW                 GLB x  pte
0xffff88030ed6a000-0xffff88030ed6b000           4K     ro                 GLB x  pte
0xffff88030ed6b000-0xffff88030eda2000         220K     RW                 GLB x  pte
0xffff88030eda2000-0xffff88030eda3000           4K     ro                 GLB x  pte
0xffff88030eda3000-0xffff88030edd4000         196K     RW                 GLB x  pte
0xffff88030edd4000-0xffff88030ee0a000         216K     ro                 GLB x  pte
0xffff88030ee0a000-0xffff88030eef6000         944K     RW                 GLB x  pte
0xffff88030eef6000-0xffff88030eef7000           4K     ro                 GLB x  pte
0xffff88030eef7000-0xffff88030eef8000           4K     RW                 GLB x  pte
0xffff88030eef8000-0xffff88030eefd000          20K     ro                 GLB x  pte
0xffff88030eefd000-0xffff88030ef68000         428K     RW                 GLB x  pte
0xffff88030ef68000-0xffff88030ef6a000           8K     ro                 GLB x  pte
0xffff88030ef6a000-0xffff88030f000000         600K     RW                 GLB x  pte
0xffff88030f000000-0xffff88030f800000           8M     RW         PSE     GLB x  pmd
0xffff88030f800000-0xffff88030f827000         156K     RW                 GLB x  pte
0xffff88030f827000-0xffff88030f828000           4K     ro                 GLB x  pte
0xffff88030f828000-0xffff88030f865000         244K     RW                 GLB x  pte
0xffff88030f865000-0xffff88030f866000           4K     ro                 GLB x  pte
0xffff88030f866000-0xffff88030f869000          12K     RW                 GLB x  pte
0xffff88030f869000-0xffff88030f86a000           4K     ro                 GLB x  pte
0xffff88030f86a000-0xffff88030f894000         168K     RW                 GLB x  pte
0xffff88030f894000-0xffff88030f895000           4K     ro                 GLB x  pte
0xffff88030f895000-0xffff88030f899000          16K     RW                 GLB x  pte
0xffff88030f899000-0xffff88030f89a000           4K     ro                 GLB x  pte
0xffff88030f89a000-0xffff88030f89c000           8K     RW                 GLB x  pte
0xffff88030f89c000-0xffff88030f89d000           4K     ro                 GLB x  pte
0xffff88030f89d000-0xffff88030f8a0000          12K     RW                 GLB x  pte
0xffff88030f8a0000-0xffff88030f8a8000          32K     ro                 GLB x  pte
0xffff88030f8a8000-0xffff88030f8b0000          32K     RW                 GLB x  pte
0xffff88030f8b0000-0xffff88030f8b3000          12K     ro                 GLB x  pte
0xffff88030f8b3000-0xffff88030f8ba000          28K     RW                 GLB x  pte
0xffff88030f8ba000-0xffff88030f8c8000          56K     ro                 GLB x  pte
0xffff88030f8c8000-0xffff88030f8ce000          24K     RW                 GLB x  pte
0xffff88030f8ce000-0xffff88030f8cf000           4K     ro                 GLB x  pte
0xffff88030f8cf000-0xffff88030f8f2000         140K     RW                 GLB x  pte
0xffff88030f8f2000-0xffff88030f8f5000          12K     ro                 GLB x  pte
0xffff88030f8f5000-0xffff88030f8f7000           8K     RW                 GLB x  pte
0xffff88030f8f7000-0xffff88030f8f8000           4K     ro                 GLB x  pte
0xffff88030f8f8000-0xffff88030f8fb000          12K     RW                 GLB x  pte
0xffff88030f8fb000-0xffff88030f8fc000           4K     ro                 GLB x  pte
0xffff88030f8fc000-0xffff88030f8ff000          12K     RW                 GLB x  pte
0xffff88030f8ff000-0xffff88030f900000           4K     ro                 GLB x  pte
0xffff88030f900000-0xffff88030f902000           8K     RW                 GLB x  pte
0xffff88030f902000-0xffff88030f904000           8K     ro                 GLB x  pte
0xffff88030f904000-0xffff88030f90c000          32K     RW                 GLB x  pte
0xffff88030f90c000-0xffff88030f90e000           8K     ro                 GLB x  pte
0xffff88030f90e000-0xffff88030f914000          24K     RW                 GLB x  pte
0xffff88030f914000-0xffff88030f91d000          36K     ro                 GLB x  pte
0xffff88030f91d000-0xffff88030f923000          24K     RW                 GLB x  pte
0xffff88030f923000-0xffff88030f924000           4K     ro                 GLB x  pte
0xffff88030f924000-0xffff88030f932000          56K     RW                 GLB x  pte
0xffff88030f932000-0xffff88030f934000           8K     ro                 GLB x  pte
0xffff88030f934000-0xffff88030f935000           4K     RW                 GLB x  pte
0xffff88030f935000-0xffff88030f93a000          20K     ro                 GLB x  pte
0xffff88030f93a000-0xffff88030f940000          24K     RW                 GLB x  pte
0xffff88030f940000-0xffff88030f948000          32K     ro                 GLB x  pte
0xffff88030f948000-0xffff88030f954000          48K     RW                 GLB x  pte
0xffff88030f954000-0xffff88030f955000           4K     ro                 GLB x  pte
0xffff88030f955000-0xffff88030f95a000          20K     RW                 GLB x  pte
0xffff88030f95a000-0xffff88030f95b000           4K     ro                 GLB x  pte
0xffff88030f95b000-0xffff88030f95f000          16K     RW                 GLB x  pte
0xffff88030f95f000-0xffff88030f960000           4K     ro                 GLB x  pte
0xffff88030f960000-0xffff88030f961000           4K     RW                 GLB x  pte
0xffff88030f961000-0xffff88030f964000          12K     ro                 GLB x  pte
0xffff88030f964000-0xffff88030f96a000          24K     RW                 GLB x  pte
0xffff88030f96a000-0xffff88030f974000          40K     ro                 GLB x  pte
0xffff88030f974000-0xffff88030f97e000          40K     RW                 GLB x  pte
0xffff88030f97e000-0xffff88030f97f000           4K     ro                 GLB x  pte
0xffff88030f97f000-0xffff88030f981000           8K     RW                 GLB x  pte
0xffff88030f981000-0xffff88030f982000           4K     ro                 GLB x  pte
0xffff88030f982000-0xffff88030f986000          16K     RW                 GLB x  pte
0xffff88030f986000-0xffff88030f987000           4K     ro                 GLB x  pte
0xffff88030f987000-0xffff88030f991000          40K     RW                 GLB x  pte
0xffff88030f991000-0xffff88030f992000           4K     ro                 GLB x  pte
0xffff88030f992000-0xffff88030f994000           8K     RW                 GLB x  pte
0xffff88030f994000-0xffff88030f995000           4K     ro                 GLB x  pte
0xffff88030f995000-0xffff88030f9a0000          44K     RW                 GLB x  pte
0xffff88030f9a0000-0xffff88030f9a1000           4K     ro                 GLB x  pte
0xffff88030f9a1000-0xffff88030f9a9000          32K     RW                 GLB x  pte
0xffff88030f9a9000-0xffff88030f9ab000           8K     ro                 GLB x  pte
0xffff88030f9ab000-0xffff88030f9fb000         320K     RW                 GLB x  pte
0xffff88030f9fb000-0xffff88030f9fd000           8K     ro                 GLB x  pte
0xffff88030f9fd000-0xffff88030fa01000          16K     RW                 GLB x  pte
0xffff88030fa01000-0xffff88030fa03000           8K     ro                 GLB x  pte
0xffff88030fa03000-0xffff88030fa05000           8K     RW                 GLB x  pte
0xffff88030fa05000-0xffff88030fa07000           8K     ro                 GLB x  pte
0xffff88030fa07000-0xffff88030fa11000          40K     RW                 GLB x  pte
0xffff88030fa11000-0xffff88030fa12000           4K     ro                 GLB x  pte
0xffff88030fa12000-0xffff88030fa20000          56K     RW                 GLB x  pte
0xffff88030fa20000-0xffff88030fa22000           8K     ro                 GLB x  pte
0xffff88030fa22000-0xffff88030fab5000         588K     RW                 GLB x  pte
0xffff88030fab5000-0xffff88030fab6000           4K     ro                 GLB x  pte
0xffff88030fab6000-0xffff88030fab8000           8K     RW                 GLB x  pte
0xffff88030fab8000-0xffff88030fac5000          52K     ro                 GLB x  pte
0xffff88030fac5000-0xffff88030fac6000           4K     RW                 GLB x  pte
0xffff88030fac6000-0xffff88030fac8000           8K     ro                 GLB x  pte
0xffff88030fac8000-0xffff88030fad0000          32K     RW                 GLB x  pte
0xffff88030fad0000-0xffff88030fad1000           4K     ro                 GLB x  pte
0xffff88030fad1000-0xffff88030fae4000          76K     RW                 GLB x  pte
0xffff88030fae4000-0xffff88030faed000          36K     ro                 GLB x  pte
0xffff88030faed000-0xffff88030fb1c000         188K     RW                 GLB x  pte
0xffff88030fb1c000-0xffff88030fb20000          16K     ro                 GLB x  pte
0xffff88030fb20000-0xffff88030fb4e000         184K     RW                 GLB x  pte
0xffff88030fb4e000-0xffff88030fb50000           8K     ro                 GLB x  pte
0xffff88030fb50000-0xffff88030fb5e000          56K     RW                 GLB x  pte
0xffff88030fb5e000-0xffff88030fb60000           8K     ro                 GLB x  pte
0xffff88030fb60000-0xffff88030fc00000         640K     RW                 GLB x  pte
0xffff88030fc00000-0xffff880310800000          12M     RW         PSE     GLB x  pmd
0xffff880310800000-0xffff880310832000         200K     RW                 GLB x  pte
0xffff880310832000-0xffff880310834000           8K     ro                 GLB x  pte
0xffff880310834000-0xffff880310839000          20K     RW                 GLB x  pte
0xffff880310839000-0xffff88031083a000           4K     ro                 GLB x  pte
0xffff88031083a000-0xffff8803108dd000         652K     RW                 GLB x  pte
0xffff8803108dd000-0xffff8803108de000           4K     ro                 GLB x  pte
0xffff8803108de000-0xffff8803108fa000         112K     RW                 GLB x  pte
0xffff8803108fa000-0xffff8803108fb000           4K     ro                 GLB x  pte
0xffff8803108fb000-0xffff880310900000          20K     RW                 GLB x  pte
0xffff880310900000-0xffff880310901000           4K     ro                 GLB x  pte
0xffff880310901000-0xffff880310902000           4K     RW                 GLB x  pte
0xffff880310902000-0xffff880310903000           4K     ro                 GLB x  pte
0xffff880310903000-0xffff880310907000          16K     RW                 GLB x  pte
0xffff880310907000-0xffff880310908000           4K     ro                 GLB x  pte
0xffff880310908000-0xffff88031091f000          92K     RW                 GLB x  pte
0xffff88031091f000-0xffff880310920000           4K     ro                 GLB x  pte
0xffff880310920000-0xffff88031093d000         116K     RW                 GLB x  pte
0xffff88031093d000-0xffff88031093e000           4K     ro                 GLB x  pte
0xffff88031093e000-0xffff880310986000         288K     RW                 GLB x  pte
0xffff880310986000-0xffff880310987000           4K     ro                 GLB x  pte
0xffff880310987000-0xffff8803109c4000         244K     RW                 GLB x  pte
0xffff8803109c4000-0xffff8803109c6000           8K     ro                 GLB x  pte
0xffff8803109c6000-0xffff8803109cb000          20K     RW                 GLB x  pte
0xffff8803109cb000-0xffff8803109cc000           4K     ro                 GLB x  pte
0xffff8803109cc000-0xffff8803109ce000           8K     RW                 GLB x  pte
0xffff8803109ce000-0xffff8803109cf000           4K     ro                 GLB x  pte
0xffff8803109cf000-0xffff880310a23000         336K     RW                 GLB x  pte
0xffff880310a23000-0xffff880310a24000           4K     ro                 GLB x  pte
0xffff880310a24000-0xffff880310a2c000          32K     RW                 GLB x  pte
0xffff880310a2c000-0xffff880310a2d000           4K     ro                 GLB x  pte
0xffff880310a2d000-0xffff880310a95000         416K     RW                 GLB x  pte
0xffff880310a95000-0xffff880310a96000           4K     ro                 GLB x  pte
0xffff880310a96000-0xffff880310aca000         208K     RW                 GLB x  pte
0xffff880310aca000-0xffff880310acb000           4K     ro                 GLB x  pte
0xffff880310acb000-0xffff880310b0e000         268K     RW                 GLB x  pte
0xffff880310b0e000-0xffff880310b0f000           4K     ro                 GLB x  pte
0xffff880310b0f000-0xffff880310b9c000         564K     RW                 GLB x  pte
0xffff880310b9c000-0xffff880310b9d000           4K     ro                 GLB x  pte
0xffff880310b9d000-0xffff880310bdf000         264K     RW                 GLB x  pte
0xffff880310bdf000-0xffff880310be0000           4K     ro                 GLB x  pte
0xffff880310be0000-0xffff880310c00000         128K     RW                 GLB x  pte
0xffff880310c00000-0xffff880310e00000           2M     RW         PSE     GLB x  pmd
0xffff880310e00000-0xffff880311000000           2M     RW                 GLB x  pte
0xffff880311000000-0xffff880320000000         240M     RW         PSE     GLB x  pmd
0xffff880320000000-0xffff880340000000         512M                               pmd
0xffff880340000000-0xffff888000000000         499G                               pud
0xffff888000000000-0xffffc90000000000       66048G                               pgd
---[ vmalloc() Area ]---
0xffffc90000000000-0xffffc90000001000           4K     RW                 GLB x  pte
0xffffc90000001000-0xffffc90000002000           4K                               pte
0xffffc90000002000-0xffffc90000003000           4K     RW                 GLB x  pte
0xffffc90000003000-0xffffc90000004000           4K                               pte
0xffffc90000004000-0xffffc90000005000           4K     RW                 GLB x  pte
0xffffc90000005000-0xffffc90000006000           4K                               pte
0xffffc90000006000-0xffffc90000007000           4K     RW     PCD         GLB x  pte
0xffffc90000007000-0xffffc90000008000           4K                               pte
0xffffc90000008000-0xffffc9000000d000          20K     RW                 GLB x  pte
0xffffc9000000d000-0xffffc9000000e000           4K                               pte
0xffffc9000000e000-0xffffc9000000f000           4K     RW     PCD         GLB x  pte
0xffffc9000000f000-0xffffc90000010000           4K                               pte
0xffffc90000010000-0xffffc90000014000          16K     RW                 GLB x  pte
0xffffc90000014000-0xffffc90000015000           4K                               pte
0xffffc90000015000-0xffffc90000016000           4K     RW     PCD         GLB x  pte
0xffffc90000016000-0xffffc90000018000           8K                               pte
0xffffc90000018000-0xffffc9000001c000          16K     RW                 GLB x  pte
0xffffc9000001c000-0xffffc9000001d000           4K                               pte
0xffffc9000001d000-0xffffc9000001f000           8K     RW                 GLB x  pte
0xffffc9000001f000-0xffffc90000028000          36K                               pte
0xffffc90000028000-0xffffc9000002c000          16K     RW                 GLB x  pte
0xffffc9000002c000-0xffffc9000002d000           4K                               pte
0xffffc9000002d000-0xffffc9000002e000           4K     RW                 GLB x  pte
0xffffc9000002e000-0xffffc90000035000          28K                               pte
0xffffc90000035000-0xffffc90000036000           4K     ro                 GLB x  pte
0xffffc90000036000-0xffffc90000038000           8K                               pte
0xffffc90000038000-0xffffc9000003c000          16K     RW                 GLB x  pte
0xffffc9000003c000-0xffffc90000040000          16K                               pte
0xffffc90000040000-0xffffc90000044000          16K     RW                 GLB x  pte
0xffffc90000044000-0xffffc90000048000          16K                               pte
0xffffc90000048000-0xffffc9000004c000          16K     RW                 GLB x  pte
0xffffc9000004c000-0xffffc90000050000          16K                               pte
0xffffc90000050000-0xffffc90000054000          16K     RW                 GLB x  pte
0xffffc90000054000-0xffffc90000058000          16K                               pte
0xffffc90000058000-0xffffc9000005c000          16K     RW                 GLB x  pte
0xffffc9000005c000-0xffffc90000060000          16K                               pte
0xffffc90000060000-0xffffc90000064000          16K     RW                 GLB x  pte
0xffffc90000064000-0xffffc90000068000          16K                               pte
0xffffc90000068000-0xffffc9000006c000          16K     RW                 GLB x  pte
0xffffc9000006c000-0xffffc90000070000          16K                               pte
0xffffc90000070000-0xffffc90000074000          16K     RW                 GLB x  pte
0xffffc90000074000-0xffffc90000078000          16K                               pte
0xffffc90000078000-0xffffc9000007c000          16K     RW                 GLB x  pte
0xffffc9000007c000-0xffffc90000080000          16K                               pte
0xffffc90000080000-0xffffc90000084000          16K     RW                 GLB x  pte
0xffffc90000084000-0xffffc90000088000          16K                               pte
0xffffc90000088000-0xffffc9000008c000          16K     RW                 GLB x  pte
0xffffc9000008c000-0xffffc90000090000          16K                               pte
0xffffc90000090000-0xffffc90000094000          16K     RW                 GLB x  pte
0xffffc90000094000-0xffffc90000098000          16K                               pte
0xffffc90000098000-0xffffc9000009c000          16K     RW                 GLB x  pte
0xffffc9000009c000-0xffffc900000a0000          16K                               pte
0xffffc900000a0000-0xffffc900000a4000          16K     RW                 GLB x  pte
0xffffc900000a4000-0xffffc900000a8000          16K                               pte
0xffffc900000a8000-0xffffc900000ac000          16K     RW                 GLB x  pte
0xffffc900000ac000-0xffffc900000b0000          16K                               pte
0xffffc900000b0000-0xffffc900000b4000          16K     RW                 GLB x  pte
0xffffc900000b4000-0xffffc900000b8000          16K                               pte
0xffffc900000b8000-0xffffc900000bc000          16K     RW                 GLB x  pte
0xffffc900000bc000-0xffffc900000c0000          16K                               pte
0xffffc900000c0000-0xffffc900000c4000          16K     RW                 GLB x  pte
0xffffc900000c4000-0xffffc900000c5000           4K                               pte
0xffffc900000c5000-0xffffc900000c8000          12K     RW                 GLB x  pte
0xffffc900000c8000-0xffffc900000c9000           4K                               pte
0xffffc900000c9000-0xffffc900000cc000          12K     RW                 GLB x  pte
0xffffc900000cc000-0xffffc900000d0000          16K                               pte
0xffffc900000d0000-0xffffc900000d4000          16K     RW                 GLB x  pte
0xffffc900000d4000-0xffffc900000d8000          16K                               pte
0xffffc900000d8000-0xffffc900000dc000          16K     RW                 GLB x  pte
0xffffc900000dc000-0xffffc900000e0000          16K                               pte
0xffffc900000e0000-0xffffc900000e4000          16K     RW                 GLB x  pte
0xffffc900000e4000-0xffffc900000e8000          16K                               pte
0xffffc900000e8000-0xffffc900000ec000          16K     RW                 GLB x  pte
0xffffc900000ec000-0xffffc900000f0000          16K                               pte
0xffffc900000f0000-0xffffc900000f4000          16K     RW                 GLB x  pte
0xffffc900000f4000-0xffffc900000f8000          16K                               pte
0xffffc900000f8000-0xffffc900000fc000          16K     RW                 GLB x  pte
0xffffc900000fc000-0xffffc90000100000          16K                               pte
0xffffc90000100000-0xffffc90000104000          16K     RW                 GLB x  pte
0xffffc90000104000-0xffffc90000108000          16K                               pte
0xffffc90000108000-0xffffc9000010c000          16K     RW                 GLB x  pte
0xffffc9000010c000-0xffffc90000110000          16K                               pte
0xffffc90000110000-0xffffc90000114000          16K     RW                 GLB x  pte
0xffffc90000114000-0xffffc90000118000          16K                               pte
0xffffc90000118000-0xffffc9000011c000          16K     RW                 GLB x  pte
0xffffc9000011c000-0xffffc90000120000          16K                               pte
0xffffc90000120000-0xffffc90000124000          16K     RW                 GLB x  pte
0xffffc90000124000-0xffffc90000130000          48K                               pte
0xffffc90000130000-0xffffc90000134000          16K     RW                 GLB x  pte
0xffffc90000134000-0xffffc90000138000          16K                               pte
0xffffc90000138000-0xffffc9000013c000          16K     RW                 GLB x  pte
0xffffc9000013c000-0xffffc90000140000          16K                               pte
0xffffc90000140000-0xffffc90000144000          16K     RW                 GLB x  pte
0xffffc90000144000-0xffffc90000148000          16K                               pte
0xffffc90000148000-0xffffc9000014c000          16K     RW                 GLB x  pte
0xffffc9000014c000-0xffffc90000150000          16K                               pte
0xffffc90000150000-0xffffc90000154000          16K     RW                 GLB x  pte
0xffffc90000154000-0xffffc90000158000          16K                               pte
0xffffc90000158000-0xffffc9000015c000          16K     RW                 GLB x  pte
0xffffc9000015c000-0xffffc90000160000          16K                               pte
0xffffc90000160000-0xffffc90000164000          16K     RW                 GLB x  pte
0xffffc90000164000-0xffffc90000168000          16K                               pte
0xffffc90000168000-0xffffc9000016c000          16K     RW                 GLB x  pte
0xffffc9000016c000-0xffffc90000170000          16K                               pte
0xffffc90000170000-0xffffc90000174000          16K     RW                 GLB x  pte
0xffffc90000174000-0xffffc90000178000          16K                               pte
0xffffc90000178000-0xffffc9000017c000          16K     RW                 GLB x  pte
0xffffc9000017c000-0xffffc90000180000          16K                               pte
0xffffc90000180000-0xffffc90000184000          16K     RW                 GLB x  pte
0xffffc90000184000-0xffffc90000188000          16K                               pte
0xffffc90000188000-0xffffc9000018c000          16K     RW                 GLB x  pte
0xffffc9000018c000-0xffffc90000190000          16K                               pte
0xffffc90000190000-0xffffc90000194000          16K     RW                 GLB x  pte
0xffffc90000194000-0xffffc90000198000          16K                               pte
0xffffc90000198000-0xffffc9000019c000          16K     RW                 GLB x  pte
0xffffc9000019c000-0xffffc900001a0000          16K                               pte
0xffffc900001a0000-0xffffc900001a4000          16K     RW                 GLB x  pte
0xffffc900001a4000-0xffffc900001a8000          16K                               pte
0xffffc900001a8000-0xffffc900001ac000          16K     RW                 GLB x  pte
0xffffc900001ac000-0xffffc900001b0000          16K                               pte
0xffffc900001b0000-0xffffc900001b4000          16K     RW                 GLB x  pte
0xffffc900001b4000-0xffffc900001b8000          16K                               pte
0xffffc900001b8000-0xffffc900001bc000          16K     RW                 GLB x  pte
0xffffc900001bc000-0xffffc900001d0000          80K                               pte
0xffffc900001d0000-0xffffc900001d4000          16K     RW                 GLB x  pte
0xffffc900001d4000-0xffffc900001d8000          16K                               pte
0xffffc900001d8000-0xffffc900001dc000          16K     RW                 GLB x  pte
0xffffc900001dc000-0xffffc900001dd000           4K                               pte
0xffffc900001dd000-0xffffc900001e0000          12K     RW                 GLB x  pte
0xffffc900001e0000-0xffffc900001e8000          32K                               pte
0xffffc900001e8000-0xffffc900001ec000          16K     RW                 GLB x  pte
0xffffc900001ec000-0xffffc900001f9000          52K                               pte
0xffffc900001f9000-0xffffc900001fc000          12K     RW                 GLB x  pte
0xffffc900001fc000-0xffffc90000200000          16K                               pte
0xffffc90000200000-0xffffc90000210000          64K     RW     PCD         GLB x  pte
0xffffc90000210000-0xffffc90000214000          16K                               pte
0xffffc90000214000-0xffffc90000218000          16K     RW                 GLB x  pte
0xffffc90000218000-0xffffc9000021c000          16K                               pte
0xffffc9000021c000-0xffffc90000220000          16K     RW                 GLB x  pte
0xffffc90000220000-0xffffc90000224000          16K                               pte
0xffffc90000224000-0xffffc90000228000          16K     RW                 GLB x  pte
0xffffc90000228000-0xffffc90000230000          32K                               pte
0xffffc90000230000-0xffffc90000240000          64K     RW     PCD         GLB x  pte
0xffffc90000240000-0xffffc90000244000          16K                               pte
0xffffc90000244000-0xffffc90000248000          16K     RW                 GLB x  pte
0xffffc90000248000-0xffffc9000024c000          16K                               pte
0xffffc9000024c000-0xffffc90000250000          16K     RW                 GLB x  pte
0xffffc90000250000-0xffffc90000254000          16K                               pte
0xffffc90000254000-0xffffc90000258000          16K     RW                 GLB x  pte
0xffffc90000258000-0xffffc9000025c000          16K                               pte
0xffffc9000025c000-0xffffc90000260000          16K     RW                 GLB x  pte
0xffffc90000260000-0xffffc90000264000          16K                               pte
0xffffc90000264000-0xffffc90000268000          16K     RW                 GLB x  pte
0xffffc90000268000-0xffffc90000270000          32K                               pte
0xffffc90000270000-0xffffc90000280000          64K     RW     PCD         GLB x  pte
0xffffc90000280000-0xffffc90000284000          16K                               pte
0xffffc90000284000-0xffffc90000288000          16K     RW                 GLB x  pte
0xffffc90000288000-0xffffc9000028c000          16K                               pte
0xffffc9000028c000-0xffffc90000290000          16K     RW                 GLB x  pte
0xffffc90000290000-0xffffc90000294000          16K                               pte
0xffffc90000294000-0xffffc90000298000          16K     RW                 GLB x  pte
0xffffc90000298000-0xffffc9000029c000          16K                               pte
0xffffc9000029c000-0xffffc900002a0000          16K     RW                 GLB x  pte
0xffffc900002a0000-0xffffc900002a4000          16K                               pte
0xffffc900002a4000-0xffffc900002a8000          16K     RW                 GLB x  pte
0xffffc900002a8000-0xffffc900002ac000          16K                               pte
0xffffc900002ac000-0xffffc900002b0000          16K     RW                 GLB x  pte
0xffffc900002b0000-0xffffc900002b4000          16K                               pte
0xffffc900002b4000-0xffffc900002b8000          16K     RW                 GLB x  pte
0xffffc900002b8000-0xffffc900002bc000          16K                               pte
0xffffc900002bc000-0xffffc900002c0000          16K     RW                 GLB x  pte
0xffffc900002c0000-0xffffc900002d4000          80K                               pte
0xffffc900002d4000-0xffffc900002d8000          16K     RW                 GLB x  pte
0xffffc900002d8000-0xffffc900002dc000          16K                               pte
0xffffc900002dc000-0xffffc900002e0000          16K     RW                 GLB x  pte
0xffffc900002e0000-0xffffc900002e4000          16K                               pte
0xffffc900002e4000-0xffffc900002e8000          16K     RW                 GLB x  pte
0xffffc900002e8000-0xffffc900002ec000          16K                               pte
0xffffc900002ec000-0xffffc900002f0000          16K     RW                 GLB x  pte
0xffffc900002f0000-0xffffc900002f4000          16K                               pte
0xffffc900002f4000-0xffffc900002f8000          16K     RW                 GLB x  pte
0xffffc900002f8000-0xffffc90000324000         176K                               pte
0xffffc90000324000-0xffffc90000328000          16K     RW                 GLB x  pte
0xffffc90000328000-0xffffc9000032c000          16K                               pte
0xffffc9000032c000-0xffffc90000330000          16K     RW                 GLB x  pte
0xffffc90000330000-0xffffc9000033c000          48K                               pte
0xffffc9000033c000-0xffffc90000340000          16K     RW                 GLB x  pte
0xffffc90000340000-0xffffc90000344000          16K                               pte
0xffffc90000344000-0xffffc90000348000          16K     RW                 GLB x  pte
0xffffc90000348000-0xffffc90000350000          32K                               pte
0xffffc90000350000-0xffffc90000354000          16K     RW                 GLB x  pte
0xffffc90000354000-0xffffc90000360000          48K                               pte
0xffffc90000360000-0xffffc90000380000         128K     RW     PCD         GLB x  pte
0xffffc90000380000-0xffffc900003a0000         128K                               pte
0xffffc900003a0000-0xffffc900003c0000         128K     RW     PCD         GLB x  pte
0xffffc900003c0000-0xffffc9000043c000         496K                               pte
0xffffc9000043c000-0xffffc90000440000          16K     RW                 GLB x  pte
0xffffc90000440000-0xffffc90000454000          80K                               pte
0xffffc90000454000-0xffffc90000458000          16K     RW                 GLB x  pte
0xffffc90000458000-0xffffc900006dc000        2576K                               pte
0xffffc900006dc000-0xffffc900006e0000          16K     RW                 GLB x  pte
0xffffc900006e0000-0xffffc9000073c000         368K                               pte
0xffffc9000073c000-0xffffc90000740000          16K     RW                 GLB x  pte
0xffffc90000740000-0xffffc90000794000         336K                               pte
0xffffc90000794000-0xffffc90000798000          16K     RW                 GLB x  pte
0xffffc90000798000-0xffffc900007f4000         368K                               pte
0xffffc900007f4000-0xffffc900007f8000          16K     RW                 GLB x  pte
0xffffc900007f8000-0xffffc900007fc000          16K                               pte
0xffffc900007fc000-0xffffc90000800000          16K     RW                 GLB x  pte
0xffffc90000800000-0xffffc9000082c000         176K                               pte
0xffffc9000082c000-0xffffc90000830000          16K     RW                 GLB x  pte
0xffffc90000830000-0xffffc90000844000          80K                               pte
0xffffc90000844000-0xffffc90000848000          16K     RW                 GLB x  pte
0xffffc90000848000-0xffffc900009c9000        1540K                               pte
0xffffc900009c9000-0xffffc90000a44000         492K     RW                 GLB x  pte
0xffffc90000a44000-0xffffc90000d40000        3056K                               pte
0xffffc90000d40000-0xffffc90000d44000          16K     RW                 GLB x  pte
0xffffc90000d44000-0xffffc90000d58000          80K                               pte
0xffffc90000d58000-0xffffc90000d5c000          16K     RW                 GLB x  pte
0xffffc90000d5c000-0xffffc90000d64000          32K                               pte
0xffffc90000d64000-0xffffc90000d68000          16K     RW                 GLB x  pte
0xffffc90000d68000-0xffffc90000e50000         928K                               pte
0xffffc90000e50000-0xffffc90000e54000          16K     RW                 GLB x  pte
0xffffc90000e54000-0xffffc90000fa8000        1360K                               pte
0xffffc90000fa8000-0xffffc90000fac000          16K     RW                 GLB x  pte
0xffffc90000fac000-0xffffc90000fb8000          48K                               pte
0xffffc90000fb8000-0xffffc90000fbc000          16K     RW                 GLB x  pte
0xffffc90000fbc000-0xffffc90000fc0000          16K                               pte
0xffffc90000fc0000-0xffffc90000fc4000          16K     RW                 GLB x  pte
0xffffc90000fc4000-0xffffc90000fc8000          16K                               pte
0xffffc90000fc8000-0xffffc90000fcc000          16K     RW                 GLB x  pte
0xffffc90000fcc000-0xffffc900010c0000         976K                               pte
0xffffc900010c0000-0xffffc900010c4000          16K     RW                 GLB x  pte
0xffffc900010c4000-0xffffc900010f0000         176K                               pte
0xffffc900010f0000-0xffffc900010f4000          16K     RW                 GLB x  pte
0xffffc900010f4000-0xffffc90001100000          48K                               pte
0xffffc90001100000-0xffffc90001104000          16K     RW                 GLB x  pte
0xffffc90001104000-0xffffc90001110000          48K                               pte
0xffffc90001110000-0xffffc90001114000          16K     RW                 GLB x  pte
0xffffc90001114000-0xffffc90001268000        1360K                               pte
0xffffc90001268000-0xffffc9000126c000          16K     RW                 GLB x  pte
0xffffc9000126c000-0xffffc900013b0000        1296K                               pte
0xffffc900013b0000-0xffffc900013b4000          16K     RW                 GLB x  pte
0xffffc900013b4000-0xffffc90001750000        3696K                               pte
0xffffc90001750000-0xffffc90001754000          16K     RW                 GLB x  pte
0xffffc90001754000-0xffffc900017c0000         432K                               pte
0xffffc900017c0000-0xffffc900017c4000          16K     RW                 GLB x  pte
0xffffc900017c4000-0xffffc90001818000         336K                               pte
0xffffc90001818000-0xffffc9000181c000          16K     RW                 GLB x  pte
0xffffc9000181c000-0xffffc900018e0000         784K                               pte
0xffffc900018e0000-0xffffc900018e4000          16K     RW                 GLB x  pte
0xffffc900018e4000-0xffffc90001c70000        3632K                               pte
0xffffc90001c70000-0xffffc90001c74000          16K     RW                 GLB x  pte
0xffffc90001c74000-0xffffc90001c75000           4K                               pte
0xffffc90001c75000-0xffffc90001c78000          12K     RW                 GLB x  pte
0xffffc90001c78000-0xffffc90001c7c000          16K                               pte
0xffffc90001c7c000-0xffffc90001c80000          16K     RW                 GLB x  pte
0xffffc90001c80000-0xffffc90001c84000          16K                               pte
0xffffc90001c84000-0xffffc90001c88000          16K     RW                 GLB x  pte
0xffffc90001c88000-0xffffc90001c8c000          16K                               pte
0xffffc90001c8c000-0xffffc90001c90000          16K     RW                 GLB x  pte
0xffffc90001c90000-0xffffc90001c94000          16K                               pte
0xffffc90001c94000-0xffffc90001c98000          16K     RW                 GLB x  pte
0xffffc90001c98000-0xffffc90001ca1000          36K                               pte
0xffffc90001ca1000-0xffffc90001ca4000          12K     RW                 GLB x  pte
0xffffc90001ca4000-0xffffc90001ca5000           4K                               pte
0xffffc90001ca5000-0xffffc90001ca8000          12K     RW                 GLB x  pte
0xffffc90001ca8000-0xffffc90001cad000          20K                               pte
0xffffc90001cad000-0xffffc90001cb0000          12K     RW                 GLB x  pte
0xffffc90001cb0000-0xffffc90001cb5000          20K                               pte
0xffffc90001cb5000-0xffffc90001cb8000          12K     RW                 GLB x  pte
0xffffc90001cb8000-0xffffc90001cbd000          20K                               pte
0xffffc90001cbd000-0xffffc90001cc0000          12K     RW                 GLB x  pte
0xffffc90001cc0000-0xffffc9000204c000        3632K                               pte
0xffffc9000204c000-0xffffc90002050000          16K     RW                 GLB x  pte
0xffffc90002050000-0xffffc9000215c000        1072K                               pte
0xffffc9000215c000-0xffffc90002160000          16K     RW                 GLB x  pte
0xffffc90002160000-0xffffc90002adc000        9712K                               pte
0xffffc90002adc000-0xffffc90002ae0000          16K     RW                 GLB x  pte
0xffffc90002ae0000-0xffffc90002b2c000         304K                               pte
0xffffc90002b2c000-0xffffc90002b30000          16K     RW                 GLB x  pte
0xffffc90002b30000-0xffffc9000923c000      105520K                               pte
0xffffc9000923c000-0xffffc90009240000          16K     RW                 GLB x  pte
0xffffc90009240000-0xffffc9000a000000       14080K                               pte
0xffffc9000a000000-0xffffc90040000000         864M                               pmd
0xffffc90040000000-0xffffc98000000000         511G                               pud
0xffffc98000000000-0xffffe88000000000          31T                               pgd
0xffffe88000000000-0xffffe8ffc0000000         511G                               pud
0xffffe8ffc0000000-0xffffe8ffffc00000        1020M                               pmd
0xffffe8ffffc00000-0xffffe8ffffc03000          12K     RW                 GLB x  pte
0xffffe8ffffc03000-0xffffe8ffffc40000         244K                               pte
0xffffe8ffffc40000-0xffffe8ffffc43000          12K     RW                 GLB x  pte
0xffffe8ffffc43000-0xffffe8ffffc80000         244K                               pte
0xffffe8ffffc80000-0xffffe8ffffc83000          12K     RW                 GLB x  pte
0xffffe8ffffc83000-0xffffe8ffffcc0000         244K                               pte
0xffffe8ffffcc0000-0xffffe8ffffcc3000          12K     RW                 GLB x  pte
0xffffe8ffffcc3000-0xffffe8ffffd00000         244K                               pte
0xffffe8ffffd00000-0xffffe8ffffd03000          12K     RW                 GLB x  pte
0xffffe8ffffd03000-0xffffe8ffffd40000         244K                               pte
0xffffe8ffffd40000-0xffffe8ffffd43000          12K     RW                 GLB x  pte
0xffffe8ffffd43000-0xffffe8ffffd80000         244K                               pte
0xffffe8ffffd80000-0xffffe8ffffd83000          12K     RW                 GLB x  pte
0xffffe8ffffd83000-0xffffe8ffffdc0000         244K                               pte
0xffffe8ffffdc0000-0xffffe8ffffdc3000          12K     RW                 GLB x  pte
0xffffe8ffffdc3000-0xffffe8ffffe00000         244K                               pte
0xffffe8ffffe00000-0xffffe90000000000           2M                               pmd
0xffffe90000000000-0xffffea0000000000           1T                               pgd
---[ Vmemmap ]---
0xffffea0000000000-0xffffea0003800000          56M     RW         PSE     GLB x  pmd
0xffffea0003800000-0xffffea0004000000           8M                               pmd
0xffffea0004000000-0xffffea000c800000         136M     RW         PSE     GLB x  pmd
0xffffea000c800000-0xffffea0040000000         824M                               pmd
0xffffea0040000000-0xffffea8000000000         511G                               pud
0xffffea8000000000-0xffffff0000000000       20992G                               pgd
---[ ESPfix Area ]---
0xffffff0000000000-0xffffff1000000000          64G                               pud
0xffffff1000000000-0xffffff1000009000          36K                               pte
0xffffff1000009000-0xffffff100000a000           4K     ro                 GLB x  pte
0xffffff100000a000-0xffffff1000019000          60K                               pte
0xffffff1000019000-0xffffff100001a000           4K     ro                 GLB x  pte
0xffffff100001a000-0xffffff1000029000          60K                               pte
0xffffff1000029000-0xffffff100002a000           4K     ro                 GLB x  pte
0xffffff100002a000-0xffffff1000039000          60K                               pte
0xffffff1000039000-0xffffff100003a000           4K     ro                 GLB x  pte
0xffffff100003a000-0xffffff1000049000          60K                               pte
0xffffff1000049000-0xffffff100004a000           4K     ro                 GLB x  pte
0xffffff100004a000-0xffffff1000059000          60K                               pte
0xffffff1000059000-0xffffff100005a000           4K     ro                 GLB x  pte
0xffffff100005a000-0xffffff1000069000          60K                               pte
0xffffff1000069000-0xffffff100006a000           4K     ro                 GLB x  pte
0xffffff100006a000-0xffffff1000079000          60K                               pte
... 131059 entries skipped ... 
---[ High Kernel Mapping ]---
0xffffffff80000000-0xffffffff81000000          16M                               pmd
0xffffffff81000000-0xffffffff81c00000          12M     ro         PSE     GLB x  pmd
0xffffffff81c00000-0xffffffff82800000          12M     RW         PSE     GLB x  pmd
0xffffffff82800000-0xffffffffa0000000         472M                               pmd
---[ Modules ]---
0xffffffffa0000000-0xffffffffa0002000           8K     ro                 GLB x  pte
0xffffffffa0002000-0xffffffffa0004000           8K     RW                 GLB x  pte
0xffffffffa0004000-0xffffffffa0009000          20K                               pte
0xffffffffa0009000-0xffffffffa0017000          56K     ro                 GLB x  pte
0xffffffffa0017000-0xffffffffa0021000          40K     RW                 GLB x  pte
0xffffffffa0021000-0xffffffffa0022000           4K                               pte
0xffffffffa0022000-0xffffffffa0024000           8K     ro                 GLB x  pte
0xffffffffa0024000-0xffffffffa0026000           8K     RW                 GLB x  pte
0xffffffffa0026000-0xffffffffa0027000           4K                               pte
0xffffffffa0027000-0xffffffffa0029000           8K     ro                 GLB x  pte
0xffffffffa0029000-0xffffffffa002b000           8K     RW                 GLB x  pte
0xffffffffa002b000-0xffffffffa002f000          16K                               pte
0xffffffffa002f000-0xffffffffa0032000          12K     ro                 GLB x  pte
0xffffffffa0032000-0xffffffffa0035000          12K     RW                 GLB x  pte
0xffffffffa0035000-0xffffffffa003f000          40K                               pte
0xffffffffa003f000-0xffffffffa0041000           8K     ro                 GLB x  pte
0xffffffffa0041000-0xffffffffa0043000           8K     RW                 GLB x  pte
0xffffffffa0043000-0xffffffffa0044000           4K                               pte
0xffffffffa0044000-0xffffffffa0046000           8K     ro                 GLB x  pte
0xffffffffa0046000-0xffffffffa0048000           8K     RW                 GLB x  pte
0xffffffffa0048000-0xffffffffa0049000           4K                               pte
0xffffffffa0049000-0xffffffffa004b000           8K     ro                 GLB x  pte
0xffffffffa004b000-0xffffffffa004d000           8K     RW                 GLB x  pte
0xffffffffa004d000-0xffffffffa0050000          12K                               pte
0xffffffffa0050000-0xffffffffa0057000          28K     ro                 GLB x  pte
0xffffffffa0057000-0xffffffffa005c000          20K     RW                 GLB x  pte
0xffffffffa005c000-0xffffffffa005d000           4K                               pte
0xffffffffa005d000-0xffffffffa005f000           8K     ro                 GLB x  pte
0xffffffffa005f000-0xffffffffa0061000           8K     RW                 GLB x  pte
0xffffffffa0061000-0xffffffffa0062000           4K                               pte
0xffffffffa0062000-0xffffffffa006b000          36K     ro                 GLB x  pte
0xffffffffa006b000-0xffffffffa0072000          28K     RW                 GLB x  pte
0xffffffffa0072000-0xffffffffa0073000           4K                               pte
0xffffffffa0073000-0xffffffffa0075000           8K     ro                 GLB x  pte
0xffffffffa0075000-0xffffffffa0078000          12K     RW                 GLB x  pte
0xffffffffa0078000-0xffffffffa0079000           4K                               pte
0xffffffffa0079000-0xffffffffa0081000          32K     ro                 GLB x  pte
0xffffffffa0081000-0xffffffffa0086000          20K     RW                 GLB x  pte
0xffffffffa0086000-0xffffffffa0087000           4K                               pte
0xffffffffa0087000-0xffffffffa0090000          36K     ro                 GLB x  pte
0xffffffffa0090000-0xffffffffa0096000          24K     RW                 GLB x  pte
0xffffffffa0096000-0xffffffffa0097000           4K                               pte
0xffffffffa0097000-0xffffffffa009b000          16K     ro                 GLB x  pte
0xffffffffa009b000-0xffffffffa009e000          12K     RW                 GLB x  pte
0xffffffffa009e000-0xffffffffa00a3000          20K                               pte
0xffffffffa00a3000-0xffffffffa00a8000          20K     ro                 GLB x  pte
0xffffffffa00a8000-0xffffffffa00ad000          20K     RW                 GLB x  pte
0xffffffffa00ad000-0xffffffffa00ae000           4K                               pte
0xffffffffa00ae000-0xffffffffa00b0000           8K     ro                 GLB x  pte
0xffffffffa00b0000-0xffffffffa00b2000           8K     RW                 GLB x  pte
0xffffffffa00b2000-0xffffffffa00b3000           4K                               pte
0xffffffffa00b3000-0xffffffffa00bd000          40K     ro                 GLB x  pte
0xffffffffa00bd000-0xffffffffa00c3000          24K     RW                 GLB x  pte
0xffffffffa00c3000-0xffffffffa00d0000          52K                               pte
0xffffffffa00d0000-0xffffffffa00da000          40K     ro                 GLB x  pte
0xffffffffa00da000-0xffffffffa00e0000          24K     RW                 GLB x  pte
0xffffffffa00e0000-0xffffffffa00e1000           4K                               pte
0xffffffffa00e1000-0xffffffffa00e6000          20K     ro                 GLB x  pte
0xffffffffa00e6000-0xffffffffa00e9000          12K     RW                 GLB x  pte
0xffffffffa00e9000-0xffffffffa00ea000           4K                               pte
0xffffffffa00ea000-0xffffffffa012b000         260K     ro                 GLB x  pte
0xffffffffa012b000-0xffffffffa0157000         176K     RW                 GLB x  pte
0xffffffffa0157000-0xffffffffa0158000           4K                               pte
0xffffffffa0158000-0xffffffffa015d000          20K     ro                 GLB x  pte
0xffffffffa015d000-0xffffffffa0161000          16K     RW                 GLB x  pte
0xffffffffa0161000-0xffffffffa0162000           4K                               pte
0xffffffffa0162000-0xffffffffa016e000          48K     ro                 GLB x  pte
0xffffffffa016e000-0xffffffffa0177000          36K     RW                 GLB x  pte
0xffffffffa0177000-0xffffffffa017a000          12K                               pte
0xffffffffa017a000-0xffffffffa017f000          20K     ro                 GLB x  pte
0xffffffffa017f000-0xffffffffa0182000          12K     RW                 GLB x  pte
0xffffffffa0182000-0xffffffffa0183000           4K                               pte
0xffffffffa0183000-0xffffffffa0199000          88K     ro                 GLB x  pte
0xffffffffa0199000-0xffffffffa01a7000          56K     RW                 GLB x  pte
0xffffffffa01a7000-0xffffffffa01e0000         228K                               pte
0xffffffffa01e0000-0xffffffffa0204000         144K     ro                 GLB x  pte
0xffffffffa0204000-0xffffffffa0217000          76K     RW                 GLB x  pte
0xffffffffa0217000-0xffffffffa0218000           4K                               pte
0xffffffffa0218000-0xffffffffa0241000         164K     ro                 GLB x  pte
0xffffffffa0241000-0xffffffffa0255000          80K     RW                 GLB x  pte
0xffffffffa0255000-0xffffffffa025e000          36K                               pte
0xffffffffa025e000-0xffffffffa0269000          44K     ro                 GLB x  pte
0xffffffffa0269000-0xffffffffa0271000          32K     RW                 GLB x  pte
0xffffffffa0271000-0xffffffffa0272000           4K                               pte
0xffffffffa0272000-0xffffffffa0278000          24K     ro                 GLB x  pte
0xffffffffa0278000-0xffffffffa027d000          20K     RW                 GLB x  pte
0xffffffffa027d000-0xffffffffa027e000           4K                               pte
0xffffffffa027e000-0xffffffffa0283000          20K     ro                 GLB x  pte
0xffffffffa0283000-0xffffffffa0286000          12K     RW                 GLB x  pte
0xffffffffa0286000-0xffffffffa0400000        1512K                               pte
0xffffffffa0400000-0xffffffffff200000        1518M                               pmd
---[ End Modules ]---
0xffffffffff200000-0xffffffffff576000        3544K                               pte
0xffffffffff576000-0xffffffffff57a000          16K     ro                 GLB x  pte
0xffffffffff57a000-0xffffffffff57c000           8K                               pte
0xffffffffff57c000-0xffffffffff57d000           4K     ro                 GLB x  pte
0xffffffffff57d000-0xffffffffff5fa000         500K                               pte
0xffffffffff5fa000-0xffffffffff5fe000          16K     RW PWT PCD         GLB x  pte
0xffffffffff5fe000-0xffffffffff600000           8K                               pte
0xffffffffff600000-0xffffffffff601000           4K USR ro                 GLB x  pte
0xffffffffff601000-0xffffffffff800000        2044K                               pte
0xffffffffff800000-0x0000000000000000           8M                               pmd

-- 
Meelis Roos (mroos@linux.ee)
