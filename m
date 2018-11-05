Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBB7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2213520862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2213520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeKESum convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:50:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59078 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeKESum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:50:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C54A4207CF; Mon,  5 Nov 2018 10:31:45 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4FE71206A1;
        Mon,  5 Nov 2018 10:31:45 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:31:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>
Cc:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <kyungmin.park@samsung.com>,
        <absahu@codeaurora.org>, <peterpandong@micron.com>,
        <frieder.schrempf@exceet.de>, <linus.walleij@linaro.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v12] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Message-ID: <20181105103144.363ffc49@xps13>
In-Reply-To: <20181105084040.xyxzkmcrlg7iyics@laureti-dev>
References: <1533620414-3332-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20181105084040.xyxzkmcrlg7iyics@laureti-dev>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helmut,

Helmut Grohne <helmut.grohne@intenta.de> wrote on Mon, 5 Nov 2018
09:40:43 +0100:

> On Tue, Aug 07, 2018 at 11:10:14AM +0530, Naga Sureshkumar Relli wrote:
> > Add driver for arm pl353 static memory controller nand interface with
> > HW ECC support. This controller is used in Xilinx Zynq SoC for
> > interfacing the NAND flash memory.
> > 
> > Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> > ---
> > Changes in v12:  
> 
> I attempted to apply this v12 together with the v11 of pl353-smc (which seems
> to be the latest version) onto a vanilla v4.19 kernel tree. Application was
> smooth and a build was without errors. During boot, my dmesg was spammed with
> lots of repetitions of this:
> 
> [    5.816275] ------------[ cut here ]------------
> [    5.820981] WARNING: CPU: 0 PID: 1 at .../linux/drivers/mtd/nand/raw/nand_base.c:2773 nand_subop_get_data_len+0x60/0xa4
> [    5.836868] Modules linked in:
> [    5.836912] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         4.19.0-dirty #3
> [    5.836929] Hardware name: Xilinx Zynq Platform
> [    5.836943] Backtrace: 
> [    5.836981] [<c0015430>] (dump_backtrace) from [<c0015710>] (show_stack+0x20/0x24)
> [    5.837004]  r7:c062e618 r6:00000000 r5:600f0013 r4:c062e618
> [    5.837027] [<c00156f0>] (show_stack) from [<c0423e78>] (dump_stack+0xac/0xd8)
> [    5.837055] [<c0423dcc>] (dump_stack) from [<c002352c>] (__warn+0x118/0x130)
> [    5.837079]  r10:00000000 r9:c0270be8 r8:00000ad5 r7:c0550358 r6:00000009 r5:00000000
> [    5.837097]  r4:00000000 r3:de4c6000
> [    5.837122] [<c0023414>] (__warn) from [<c0023634>] (warn_slowpath_null+0x50/0x58)
> [    5.837146]  r9:de4c78c5 r8:da4d1010 r7:de4c78f8 r6:c0270be8 r5:00000ad5 r4:c0550358
> [    5.837173] [<c00235e4>] (warn_slowpath_null) from [<c0270be8>] (nand_subop_get_data_len+0x60/0xa4)
> [    5.837192]  r6:0000003c r5:00000003 r4:de4c7870
> [    5.837217] [<c0270b88>] (nand_subop_get_data_len) from [<c027c954>] (pl353_nand_exec_op_cmd+0x60/0x314)
> [    5.837238]  r7:de4c78f8 r6:0000003c r5:de4c7870 r4:00000003
> [    5.837262] [<c027c8f4>] (pl353_nand_exec_op_cmd) from [<c02712a4>] (nand_op_parser_exec_op+0x484/0x4e8)
> [    5.837285]  r10:00000002 r9:00000014 r8:de4c790c r7:00000004 r6:c0634260 r5:c052cc44
> [    5.837301]  r4:c0620bcc
> [    5.837325] [<c0270e20>] (nand_op_parser_exec_op) from [<c027be20>] (pl353_nfc_exec_op+0x24/0x2c)
> [    5.837348]  r10:de4c7a18 r9:00000080 r8:03463678 r7:89705f41 r6:36b4a597 r5:de4c78d0
> [    5.837364]  r4:da4d1010
> [    5.837387] [<c027bdfc>] (pl353_nfc_exec_op) from [<c026ec40>] (nand_erase_op+0x150/0x1f0)
> [    5.837411] [<c026eaf0>] (nand_erase_op) from [<c026f010>] (single_erase+0x28/0x2c)
> [    5.837434]  r9:e08c1000 r8:00000006 r7:00000040 r6:00000001 r5:0001ff80 r4:da4d1010
> [    5.837459] [<c026efe8>] (single_erase) from [<c02771b4>] (nand_erase_nand+0x1f8/0x3f8)
> [    5.837484] [<c0276fbc>] (nand_erase_nand) from [<c02780d8>] (write_bbt+0x30c/0x748)
> [    5.837508]  r10:00000006 r9:e08c1000 r8:00000006 r7:00000002 r6:da4d1010 r5:00000000
> [    5.837524]  r4:0ffc0000
> [    5.837549] [<c0277dcc>] (write_bbt) from [<c027900c>] (nand_create_bbt+0x30c/0x6d0)
> [    5.837572]  r10:c061fd2c r9:c061fce8 r8:00000000 r7:c061fd2c r6:00000000 r5:00000003
> [    5.837587]  r4:00000000
> [    5.837614] [<c0278d00>] (nand_create_bbt) from [<c0275a90>] (nand_scan_with_ids+0x1248/0x1e74)
> [    5.837636]  r10:c0620524 r9:00000004 r8:00000001 r7:00000004 r6:da4d1378 r5:00000001
> [    5.837652]  r4:da4d1010
> [    5.837676] [<c0274848>] (nand_scan_with_ids) from [<c027c09c>] (pl353_nand_probe+0x144/0x208)
> [    5.837699]  r10:00000000 r9:c0620ae0 r8:c0633ba0 r7:00000000 r6:da4d8e10 r5:da4d8e00
> [    5.837715]  r4:da4d1010
> [    5.837738] [<c027bf58>] (pl353_nand_probe) from [<c0253994>] (platform_drv_probe+0x44/0x7c)
> [    5.837757]  r6:c0e0205c r5:c0620ae0 r4:da4d8e10
> [    5.837783] [<c0253950>] (platform_drv_probe) from [<c02518f8>] (really_probe+0x27c/0x408)
> [    5.837801]  r5:da4d8e10 r4:c0e02058
> [    5.837827] [<c025167c>] (really_probe) from [<c0251d58>] (driver_probe_device+0x138/0x198)
> [    5.837850]  r10:00000000 r9:00000000 r8:c0e02014 r7:00000001 r6:de4c7c70 r5:c0620ae0
> [    5.837865]  r4:da4d8e10
> [    5.837891] [<c0251c20>] (driver_probe_device) from [<c0251fd4>] (__device_attach_driver+0xc8/0x144)
> [    5.837913]  r9:00000000 r8:c0e02014 r6:de4c7c70 r5:da4d8e10 r4:c0620ae0
> [    5.837938] [<c0251f0c>] (__device_attach_driver) from [<c024f6b8>] (bus_for_each_drv+0x70/0xa4)
> [    5.837958]  r7:00000001 r6:c0251f0c r5:de4c7c70 r4:00000000
> [    5.837982] [<c024f648>] (bus_for_each_drv) from [<c02515f0>] (__device_attach+0xb0/0x11c)
> [    5.838001]  r6:c061e8d0 r5:da4d8e44 r4:da4d8e10
> [    5.838027] [<c0251540>] (__device_attach) from [<c02520ac>] (device_initial_probe+0x1c/0x20)
> [    5.838047]  r7:da4d8e10 r6:c061e8d0 r5:da4d8e10 r4:da4d8e18
> [    5.838073] [<c0252090>] (device_initial_probe) from [<c0250768>] (bus_probe_device+0x98/0xa0)
> [    5.838097] [<c02506d0>] (bus_probe_device) from [<c024d0ac>] (device_add+0x380/0x5dc)
> [    5.838117]  r7:da4d8e10 r6:de595e00 r5:00000000 r4:da4d8e18
> [    5.838142] [<c024cd2c>] (device_add) from [<c02d936c>] (of_device_add+0x44/0x4c)
> [    5.838164]  r10:c0563da4 r9:dfbf0a70 r8:dfbf0ac0 r7:00000000 r6:de595e00 r5:00000000
> [    5.838180]  r4:da4d8e00
> [    5.838205] [<c02d9328>] (of_device_add) from [<c02d9944>] (of_platform_device_create_pdata+0xa0/0xd0)
> [    5.838229] [<c02d98a4>] (of_platform_device_create_pdata) from [<c02d9994>] (of_platform_device_create+0x20/0x24)
> [    5.838252]  r9:dfbf0a70 r8:dfbf0780 r7:c0470470 r6:ddfe9f50 r5:00000000 r4:de595e00
> [    5.838280] [<c02d9974>] (of_platform_device_create) from [<c02dfc48>] (pl353_smc_probe+0x1b0/0x244)
> [    5.838305] [<c02dfa98>] (pl353_smc_probe) from [<c0223a34>] (amba_probe+0xa4/0xb8)
> [    5.838328]  r10:00000000 r9:c06262f4 r8:c0633ba0 r7:00000000 r6:c06262f4 r5:de595e00
> [    5.838345]  r4:c04706bc r3:c02dfa98
> [    5.838370] [<c0223990>] (amba_probe) from [<c02518f8>] (really_probe+0x27c/0x408)
> [    5.838391]  r7:00000000 r6:c0e0205c r5:de595e00 r4:c0e02058
> [    5.838416] [<c025167c>] (really_probe) from [<c0251d58>] (driver_probe_device+0x138/0x198)
> [    5.838439]  r10:c06311e0 r9:00000000 r8:00000000 r7:c0633ac8 r6:c06262f4 r5:c06262f4
> [    5.838455]  r4:de595e00
> [    5.838480] [<c0251c20>] (driver_probe_device) from [<c0251ef0>] (__driver_attach+0x138/0x154)
> [    5.838502]  r9:00000000 r8:00000000 r6:c06262f4 r5:de595e34 r4:de595e00
> [    5.838527] [<c0251db8>] (__driver_attach) from [<c024f5e0>] (bus_for_each_dev+0x68/0xa4)
> [    5.838547]  r7:c0633ac8 r6:c0251db8 r5:c06262f4 r4:de595e00
> [    5.838572] [<c024f578>] (bus_for_each_dev) from [<c0251100>] (driver_attach+0x2c/0x30)
> [    5.838591]  r6:c061c22c r5:da4cc900 r4:c06262f4
> [    5.838616] [<c02510d4>] (driver_attach) from [<c0250a74>] (bus_add_driver+0x1b8/0x278)
> [    5.838641] [<c02508bc>] (bus_add_driver) from [<c025270c>] (driver_register+0x88/0x11c)
> [    5.838663]  r8:c05eeeec r7:c06311e0 r6:c05ff420 r5:c05c8be0 r4:c06262f4
> [    5.838687] [<c0252684>] (driver_register) from [<c02238ac>] (amba_driver_register+0x60/0x64)
> [    5.838704]  r5:c05c8be0 r4:c0630960
> [    5.838730] [<c022384c>] (amba_driver_register) from [<c05c8c00>] (pl353_smc_driver_init+0x20/0x24)
> [    5.838756] [<c05c8be0>] (pl353_smc_driver_init) from [<c000ac60>] (do_one_initcall+0x8c/0x368)
> [    5.838779] [<c000abd4>] (do_one_initcall) from [<c05a0308>] (kernel_init_freeable+0x3ac/0x484)
> [    5.838802]  r9:c063a9c0 r8:c05eeeec r7:c063a9c0 r6:c05ff420 r5:00000007 r4:de4c6000
> [    5.838827] [<c059ff5c>] (kernel_init_freeable) from [<c043a3ac>] (kernel_init+0x1c/0x108)
> [    5.838849]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c043a390
> [    5.838866]  r4:0000a9c0
> [    5.838888] [<c043a390>] (kernel_init) from [<c00090ac>] (ret_from_fork+0x14/0x28)
> [    5.838905] Exception stack(0xde4c7fb0 to 0xde4c7ff8)
> [    5.838925] 7fa0:                                     00000000 00000000 00000000 00000000
> [    5.838947] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    5.838967] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    5.838984]  r5:c043a390 r4:00000000
> [    5.839001] irq event stamp: 224953
> [    5.839027] hardirqs last  enabled at (224959): [<c007d294>] console_unlock+0x4bc/0x664
> [    5.839053] hardirqs last disabled at (224964): [<c007cebc>] console_unlock+0xe4/0x664
> [    5.839078] softirqs last  enabled at (224936): [<c000a450>] __do_softirq+0x458/0x540
> [    5.839103] softirqs last disabled at (224921): [<c00299f8>] irq_exit+0x148/0x14c
> [    5.839123] ---[ end trace eb0330276aefb0c8 ]---
> 
> The respective mtd character devices were created, but e.g. reading them
> results in -EIO.
> 
> The device tested on works fine with v4.14 and a driver close to the
> xilinx kernel tree at github.
> 
> I acknowledge that th v12 submission predates the v4.19 release, but at
> this time, the driver will need reworking.
> 
> Helmut

This is the result of a coverity-scan fix; we chose not to return an
error value from nand_subop_get_addr/data_len() and instead WARN on
error conditions (that are purely coding mistakes, easily fixable).

The marvell_nand.c driver had the same issue, fixed there:

        21a268069203 mtd: rawnand: marvell: prevent harmless warnings

Thanks,
Miquèl


-- 
Miquel Raynal, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
