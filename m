Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDIXqO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 19:46:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52814 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbeDIXqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 19:46:07 -0400
X-Google-Smtp-Source: AIpwx4+a4LWEsYacyoSDIuf1hAg01a7X3yULpzPu+AdQELCkIMpeJGmiryay1vCh+T8XRioNFEViRA==
Subject: Re: [PATCH] mtd: partitions: Handle add_mtd_device() failures
 gracefully
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523276721-4982-1-git-send-email-geert+renesas@glider.be>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <9bea3ad8-7e84-87c2-9963-de81ad4cb3bf@gmail.com>
Date: Mon, 9 Apr 2018 23:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523276721-4982-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 02:25 PM, Geert Uytterhoeven wrote:
> Currently add_mtd_device() failures are plainly ignored, which may lead
> to kernel crashes later.
> 
> E.g. after flipping SW17 on r8a7791/koelsch, to switch from the large to
> the small QSPI FLASH, without updating the partition description in DT,
> the following happens:
> 
>     m25p80 spi0.0: found s25sl032p, expected s25fl512s
>     3 fixed-partitions partitions found on MTD device spi0.0
>     Creating 3 MTD partitions on "spi0.0":
>     0x000000000000-0x000000080000 : "loader"
>     0x000000080000-0x000000600000 : "user"
>     mtd: partition "user" extends beyond the end of device "spi0.0" -- size truncated to 0x380000
> 
> The second partition is truncated correctly.
> 
>     0x000000600000-0x000004000000 : "flash"
>     mtd: partition "flash" is out of reach -- disabled
> 
> The third partition is disabled by allocate_partition(), which means
> fields like erasesize are not filled in.  Hence add_mtd_device() fails
> and screams, rightfully:
> 
>     ------------[ cut here ]------------
>     WARNING: CPU: 1 PID: 1 at drivers/mtd/mtdcore.c:508 add_mtd_device+0x2a0/0x2e0
>     Modules linked in:
>     CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-koelsch-08649-g58e35e77b00c075d #4029
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     [<c020f660>] (unwind_backtrace) from [<c020b2f4>] (show_stack+0x10/0x14)
>     [<c020b2f4>] (show_stack) from [<c076d088>] (dump_stack+0x7c/0x9c)
>     [<c076d088>] (dump_stack) from [<c02210d8>] (__warn+0xd4/0x104)
>     [<c02210d8>] (__warn) from [<c0221218>] (warn_slowpath_null+0x38/0x44)
>     [<c0221218>] (warn_slowpath_null) from [<c0553db4>] (add_mtd_device+0x2a0/0x2e0)
>     [<c0553db4>] (add_mtd_device) from [<c0556a70>] (add_mtd_partitions+0xd0/0x16c)
>     [<c0556a70>] (add_mtd_partitions) from [<c0553f88>] (mtd_device_parse_register+0xc4/0x1b4)
>     [<c0553f88>] (mtd_device_parse_register) from [<c055a97c>] (m25p_probe+0x148/0x188)
>     [<c055a97c>] (m25p_probe) from [<c055e278>] (spi_drv_probe+0x84/0xa0)
> 
>     [...]
> 
>     ---[ end trace d43ce221bca7ab5c ]---
> 
> However, that failure is ignored by add_mtd_partitions(), leading to a
> crash later:
> 
>     ------------[ cut here ]------------
>     kernel BUG at fs/sysfs/file.c:330!
>     Internal error: Oops - BUG: 0 [#1] SMP ARM
>     Modules linked in:
>     CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        4.16.0-koelsch-08649-g58e35e77b00c075d #4029
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     PC is at sysfs_create_file_ns+0x24/0x40
>     LR is at 0x1
>     pc : [<c03604cc>]    lr : [<00000001>]    psr: 60000013
>     sp : eb447c00  ip : 00000000  fp : c0e20174
>     r10: 00000003  r9 : c0e20150  r8 : eb7e3818
>     r7 : ea8b20f8  r6 : c0e2017c  r5 : 00000000  r4 : 00000000
>     r3 : 00000200  r2 : 00000000  r1 : c0e2019c  r0 : 00000000
>     Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>     Control: 30c5387d  Table: 40003000  DAC: 55555555
>     Process swapper/0 (pid: 1, stack limit = 0x7eba272f)
>     Stack: (0xeb447c00 to 0xeb448000)
> 
>     [...]
> 
>     [<c03604cc>] (sysfs_create_file_ns) from [<c036051c>] (sysfs_create_files+0x34/0x70)
>     [<c036051c>] (sysfs_create_files) from [<c0556288>] (mtd_add_partition_attrs+0x10/0x34)
>     [<c0556288>] (mtd_add_partition_attrs) from [<c0556a78>] (add_mtd_partitions+0xd8/0x16c)
>     [<c0556a78>] (add_mtd_partitions) from [<c0553f88>] (mtd_device_parse_register+0xc4/0x1b4)
>     [<c0553f88>] (mtd_device_parse_register) from [<c055a97c>] (m25p_probe+0x148/0x188)
>     [<c055a97c>] (m25p_probe) from [<c055e278>] (spi_drv_probe+0x84/0xa0)
> 
> Fix this by ignoring and freeing partitions that failed to add in
> add_mtd_partitions().  The same issue is present in mtd_add_partition(),
> so fix that as well.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I don't know if it is worthwhile factoring out the common handling.
> 
> Should allocate_partition() fail instead?  There's a comment saying
> "let's register it anyway to preserve ordering".
> ---
>  drivers/mtd/mtdpart.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 023516a632766c42..d41adc1397dcf95e 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -637,7 +637,14 @@ int mtd_add_partition(struct mtd_info *parent, const char *name,
>  	list_add(&new->list, &mtd_partitions);
>  	mutex_unlock(&mtd_partitions_mutex);
>  
> -	add_mtd_device(&new->mtd);
> +	ret = add_mtd_device(&new->mtd);
> +	if (ret) {
> +		mutex_lock(&mtd_partitions_mutex);
> +		list_del(&new->list);
> +		mutex_unlock(&mtd_partitions_mutex);
> +		free_partition(new);
> +		return ret;
> +	}
>  
>  	mtd_add_partition_attrs(new);
>  
> @@ -731,7 +738,7 @@ int add_mtd_partitions(struct mtd_info *master,
>  {
>  	struct mtd_part *slave;
>  	uint64_t cur_offset = 0;
> -	int i;
> +	int i, ret;
>  
>  	printk(KERN_NOTICE "Creating %d MTD partitions on \"%s\":\n", nbparts, master->name);
>  
> @@ -746,7 +753,15 @@ int add_mtd_partitions(struct mtd_info *master,
>  		list_add(&slave->list, &mtd_partitions);
>  		mutex_unlock(&mtd_partitions_mutex);
>  
> -		add_mtd_device(&slave->mtd);
> +		ret = add_mtd_device(&slave->mtd);
> +		if (ret) {
> +			mutex_lock(&mtd_partitions_mutex);
> +			list_del(&slave->list);
> +			mutex_unlock(&mtd_partitions_mutex);
> +			free_partition(slave);
> +			continue;
> +		}

Why is the partition even in the list in the first place ? Can we avoid
adding it rather than adding and removing it ?

>  		mtd_add_partition_attrs(slave);
>  		if (parts[i].types)
>  			mtd_parse_part(slave, parts[i].types);
> 


-- 
Best regards,
Marek Vasut
