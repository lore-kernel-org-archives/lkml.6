Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99939C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679582087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfA2P64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:58:56 -0500
Received: from mail02.iobjects.de ([188.40.134.68]:35786 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfA2P64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:58:56 -0500
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 10:58:54 EST
Received: from tux.wizards.de (pD9EBF050.dip0.t-ipconnect.de [217.235.240.80])
        by mail02.iobjects.de (Postfix) with ESMTPSA id D43C14160E37;
        Tue, 29 Jan 2019 16:50:11 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 4CEE7F01620;
        Tue, 29 Jan 2019 16:50:11 +0100 (CET)
Subject: Re: [PATCH 4.19 006/103] net: phy: phy driver features are mandatory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Camelia Groza <camelia.groza@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20190129113159.567154026@linuxfoundation.org>
 <20190129113159.909710200@linuxfoundation.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <2f2aa129-e9fb-c75a-1b60-1821863986bf@applied-asynchrony.com>
Date:   Tue, 29 Jan 2019 16:50:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129113159.909710200@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 12:34 PM, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Camelia Groza <camelia.groza@nxp.com>
> 
> [ Upstream commit 3e64cf7a435ed0500e3adaa8aada2272d3ae8abc ]
> 
> Since phy driver features became a link_mode bitmap, phy drivers that
> don't have a list of features configured will cause the kernel to crash
> when probed.
> 
> Prevent the phy driver from registering if the features field is missing.
> 
> Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
> Reported-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/net/phy/phy_device.c |    5 +++++
>   include/linux/phy.h          |    4 ++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1917,6 +1917,11 @@ int phy_driver_register(struct phy_drive
>   {
>   	int retval;
>   
> +	if (WARN_ON(!new_driver->features)) {
> +		pr_err("%s: Driver features are missing\n", new_driver->name);
> +		return -EINVAL;
> +	}
> +
>   	new_driver->mdiodrv.flags |= MDIO_DEVICE_IS_PHY;
>   	new_driver->mdiodrv.driver.name = new_driver->name;
>   	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -491,8 +491,8 @@ struct phy_device {
>    *   only works for PHYs with IDs which match this field
>    * name: The friendly name of this PHY type
>    * phy_id_mask: Defines the important bits of the phy_id
> - * features: A list of features (speed, duplex, etc) supported
> - *   by this PHY
> + * features: A mandatory list of features (speed, duplex, etc)
> + *   supported by this PHY
>    * flags: A bitfield defining certain other features this PHY
>    *   supports (like interrupts)
>    *
> 

This patch leads to the following dump during boot and no working
network:

Jan 29 13:11:50 ragnarok kernel: RIP: 0010:phy_driver_register+0x5f/0x80 [libphy]
Jan 29 13:11:50 ragnarok kernel: Code: dd 06 a0 48 c7 47 40 30 e4 06 a0 48 89 77 10 c7 47 24 02 00 00 00 e8 10 5c 44 e1 89 c5 85 c0 0f 85 aa 1d 00 00 89 e8 5b 5d c3 <0f> 0b 48 c7 c7 f0 20 07 a0 48 89 c6 bd ea ff ff ff e8 c9 4c 02 e1
Jan 29 13:11:50 ragnarok kernel: RSP: 0018:ffffc90000df3c78 EFLAGS: 00010246
Jan 29 13:11:50 ragnarok kernel: RAX: ffffffffa0071c8d RBX: 0000000000000000 RCX: 0000000000000000
Jan 29 13:11:50 ragnarok kernel: RDX: 0000000000000000 RSI: ffffffffa0076900 RDI: ffffffffa0076040
Jan 29 13:11:50 ragnarok kernel: RBP: ffffffffa007a000 R08: 0000000000000044 R09: 0000000000000228
Jan 29 13:11:50 ragnarok kernel: R10: ffff888603a0d6f8 R11: 000000000000003c R12: ffff888601252d00
Jan 29 13:11:50 ragnarok kernel: R13: 0000000000000002 R14: ffffc90000df3e98 R15: ffffffffa0076900
Jan 29 13:11:50 ragnarok kernel: FS:  00007feea9ced800(0000) GS:ffff888607240000(0000) knlGS:0000000000000000
Jan 29 13:11:50 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 29 13:11:50 ragnarok kernel: CR2: 00007feea9cdfc42 CR3: 00000005fec64001 CR4: 00000000000606e0
Jan 29 13:11:50 ragnarok kernel: Call Trace:
Jan 29 13:11:50 ragnarok kernel:  ? 0xffffffffa007a000
Jan 29 13:11:50 ragnarok kernel:  phy_init+0x24/0x58 [libphy]
Jan 29 13:11:50 ragnarok kernel:  do_one_initcall+0x43/0x1af
Jan 29 13:11:50 ragnarok kernel:  ? _cond_resched+0x15/0x30
Jan 29 13:11:50 ragnarok kernel:  ? kmem_cache_alloc_trace+0x154/0x1b0
Jan 29 13:11:50 ragnarok kernel:  do_init_module+0x5a/0x210
Jan 29 13:11:50 ragnarok kernel:  load_module+0x203a/0x2500
Jan 29 13:11:50 ragnarok kernel:  ? vfs_read+0x10d/0x130
Jan 29 13:11:50 ragnarok kernel:  ? __se_sys_finit_module+0xb1/0xd0
Jan 29 13:11:50 ragnarok kernel:  __se_sys_finit_module+0xb1/0xd0
Jan 29 13:11:50 ragnarok kernel:  do_syscall_64+0x3e/0xe0
Jan 29 13:11:50 ragnarok kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan 29 13:11:50 ragnarok kernel: RIP: 0033:0x7feeaa2417c9
Jan 29 13:11:50 ragnarok kernel: Code: 00 00 00 75 05 48 83 c4 18 c3 e8 82 9c 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 87 c6 0c 00 f7 d8 64 89 01 48
Jan 29 13:11:50 ragnarok kernel: RSP: 002b:00007fff6fa6ea08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Jan 29 13:11:50 ragnarok kernel: RAX: ffffffffffffffda RBX: 000055c6eac06db0 RCX: 00007feeaa2417c9
Jan 29 13:11:50 ragnarok kernel: RDX: 0000000000000000 RSI: 00007feeaa4198fd RDI: 0000000000000006
Jan 29 13:11:50 ragnarok kernel: RBP: 00007feeaa4198fd R08: 0000000000000000 R09: 000055c6eac03000
Jan 29 13:11:50 ragnarok kernel: R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
Jan 29 13:11:50 ragnarok kernel: R13: 000055c6eabfc1d0 R14: 0000000000020000 R15: 000055c6eac06db0
Jan 29 13:11:50 ragnarok kernel: ---[ end trace 18e05a0afeb140b2 ]---
Jan 29 13:11:50 ragnarok kernel: libphy: Generic 10G PHY: Driver features are missing

Apparently the r8169 driver for my NIC does something wrong wrt. this
fix and the original commit (719655a14971), but regardless - reverting this
patch leads to a booting & working 4.19.19:

Jan 29 13:29:16 ragnarok kernel: libphy: r8169: probed
Jan 29 13:29:19 ragnarok kernel: RTL8211E Gigabit Ethernet r8169-400:00: attached PHY driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=r8169-400:00, irq=IGNORE)

I've cc'ed Heiner Kallweit who might know why phylib with this fix and r8169
don't like each other.

cheers,
Holger
