Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeCMRQv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:16:51 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35678 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCMRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:16:45 -0400
X-Google-Smtp-Source: AG47ELsWURopPfe291VeVNtVnHxIO73w8iMQ2JGWeVjv05Ag/V3LfF6bVDlA3IMiWsXEXE3BwGSmbFKSDxUaMSCXEOY=
MIME-Version: 1.0
In-Reply-To: <152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com> <152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 19:16:44 +0200
Message-ID: <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 2:50 AM, Gary R Hook <gary.hook@amd.com> wrote:

> +       default n

Redundant


> +#include <linux/pci.h>
> +#include <linux/iommu.h>
> +#include <linux/debugfs.h>

Keep in order?

> +#include "amd_iommu_proto.h"
> +#include "amd_iommu_types.h"

> +/* DebugFS helpers */
> +#define        OBUFP           (obuf + oboff)
> +#define        OBUFLEN         obuflen
> +#define        OBUFSPC         (OBUFLEN - oboff)
> +#define        OSCNPRINTF(fmt, ...) \
> +               scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)

I don't see any advantages of this. Other way around, they will simple
makes things hard to read an understand in place.


> +       for (i = start ; i <= end ; i++)

Missed {}

> +               if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
> +                   || amd_iommu_dev_table[i].data[1])
> +                       n++;
> +       return n;
> +}

> +
> +static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
> +                                         char __user *ubuf,
> +                                         size_t count, loff_t *offp)
> +{
> +       struct amd_iommu *iommu = filp->private_data;

> +       unsigned int obuflen = 512;

Sounds like way too much.

> +       if (!iommu)
> +               return 0;

When this possible?

> +       obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +       if (!obuf)
> +               return -ENOMEM;
> +
> +       n = amd_iommu_count_valid_dtes(0, 0xFFFF);
> +       oboff += OSCNPRINTF("%d\n", n);

> +       return ret;
> +}


> @@ -89,6 +89,7 @@
>  #define ACPI_DEVFLAG_ATSDIS             0x10000000
>
>  #define LOOP_TIMEOUT   100000
> +
>  /*
>   * ACPI table definitions
>   *

Doesn't belong to the patch.

> +#endif
> +
> +

Extra unneeded line.

-- 
With Best Regards,
Andy Shevchenko
