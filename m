Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030430AbeCAMcs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:32:48 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43744 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030313AbeCAMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:32:44 -0500
X-Google-Smtp-Source: AG47ELvgPRIkDbcvIvHbwXizeMd4/n2x/bdTdvo63feWz4pHAcBECin8pKTpn54jGE6ISBhwmwCb0AEQU+1yQ+AZAlg=
MIME-Version: 1.0
In-Reply-To: <6699002.vrpdlHjtgs@amdc3058>
References: <CGME20180301110252epcas2p3ea455cfb08b2f7edb4af6fbc95addc88@epcas2p3.samsung.com>
 <6699002.vrpdlHjtgs@amdc3058>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 14:32:42 +0200
Message-ID: <CAHp75VeVE6vBRAh4mUbgrTACqRuf3iXwNwoW9E9gRjpgWG_aTA@mail.gmail.com>
Subject: Re: [PATCH v2] ata: add Amiga Gayle PATA controller driver
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Philippe Ombredanne <pombredanne@nexb.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 1:02 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Add Amiga Gayle PATA controller driver. It enables libata support
> for the on-board IDE interfaces on some Amiga models (A600, A1200,
> A4000 and A4000T) and also for IDE interfaces on the Zorro expansion
> bus (M-Tech E-Matrix 530 expansion card).
>
> Thanks to John Paul Adrian Glaubitz and Michael Schmitz for help
> with testing the driver.




> +#include <linux/kernel.h>

> +#include <linux/module.h>
> +#include <linux/init.h>

Choose one of those two.

> +#include <linux/blkdev.h>
> +#include <linux/delay.h>
> +#include <scsi/scsi_host.h>
> +#include <scsi/scsi_cmnd.h>
> +#include <linux/ata.h>
> +#include <linux/libata.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/zorro.h>
> +#include <linux/platform_device.h>

Better to keep in order.

> +#include <asm/setup.h>
> +#include <asm/amigahw.h>
> +#include <asm/amigaints.h>
> +#include <asm/amigayle.h>
> +#include <asm/ide.h>

Ditto.

> +static bool pata_gayle_irq_check(struct ata_port *ap)
> +{
> +       u8 ch;
> +
> +       ch = z_readb((unsigned long)ap->private_data);

> +       if (!(ch & GAYLE_IRQ_IDE))
> +               return false;
> +       return true;

return !!(ch & GAYLE_IRQ_IDE);

?

> +}

> +static int __init pata_gayle_init_one(struct platform_device *pdev)
> +{

> +       pr_info(DRV_NAME ": Amiga Gayle IDE controller (A%u style)\n",
> +               pdata->explicit_ack ? 1200 : 4000);

What's wrong with dev_info() ?

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +       if (!res)
> +               return -ENODEV;

> +
> +       if (!devm_request_mem_region(&pdev->dev, res->start,
> +                                    resource_size(res), DRV_NAME)) {
> +               pr_err(DRV_NAME ": resources busy\n");
> +               return -EBUSY;
> +       }
> +

> +       base = ZTWO_VADDR(pdata->base);

Hmm... Can't you use devm_ioremap_resources() to get the virtual
address for I/O ?

> +       ap->private_data = (void *)ZTWO_VADDR(pdata->irqport);
> +
> +       ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", (unsigned long)base,
> +                     (unsigned long)base + GAYLE_CONTROL);

When you use explicit casting in printf() you are doing in 99.9% cases
something wrong.

> +       /* activate */

Noise.

> +       ret = ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
> +                               IRQF_SHARED, &pata_gayle_sht);
> +       if (ret)
> +               return ret;

> +}

-- 
With Best Regards,
Andy Shevchenko
