Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeCNRYR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:24:17 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:45521 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNRYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:24:15 -0400
X-Google-Smtp-Source: AG47ELsad6z7uFf3GzgpziM6suHhmNygVEFmC0/vtlMtMLWtjM7qTn6bhy1ALIlLKqFT52jXxcHI2RQL2GZo4JKJ/YY=
MIME-Version: 1.0
In-Reply-To: <20180314102847.30459-1-douly.fnst@cn.fujitsu.com>
References: <20180314102847.30459-1-douly.fnst@cn.fujitsu.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 19:24:14 +0200
Message-ID: <CAHp75VfGPgbD8gBdvchBn5U8gH93zoHB9ja3KucUuxVNq+_MLg@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI / processor: Get accurate possible CPU count
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>, ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:28 PM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> +static void __init acpi_update_possible_map(void)
> +{
> +       unsigned int cpu, nr = 0;
> +

> +       if (nr_cpu_ids <= nr_unique_ids)
> +               return;
> +
> +       for_each_possible_cpu(cpu) {
> +               if (nr >= nr_unique_ids)
> +                       set_cpu_possible(cpu, false);
> +               nr++;
> +       }

IIUC this can be optimized to:

if (nr_unique_ids >= nr_cpu_ids)
    return;

/* Don't yet figure out if it's superfluous */
if (nr_unique_ids >= cpumask_last(cpu_possible_mask))
    return;

for_each_cpu_wrap(cpu, cpu_possible_mask, nr_unique_ids)
    set_cpu_possible(cpu, false);

> +       nr_cpu_ids = nr_unique_ids;
> +       pr_info("Allowing %d possible CPUs\n", nr_cpu_ids);
> +}

-- 
With Best Regards,
Andy Shevchenko
