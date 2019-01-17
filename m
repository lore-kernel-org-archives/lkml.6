Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89B620657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547722870;
	bh=VN3kgnMKHQGi2eswyorXKOqND9YMEWrVRU8zFhRG4p8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DZ86YTuveQLYt8G+QF+jv6Xf/fEhS5U0ubVc4jAknsgUIC6/LF2Pgxt7U+p9E0xCY
	 hqtNawqDv/vMi3T+qiTvbAnCxb0ib+1LXFLK8+mrABP+vlCoFopb0ilE2ZDOds2t5Q
	 TY8E1AlW5h2vFwj/hj66jql6pM6/KMycaAA/QmDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfAQLBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:01:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43036 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbfAQLBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:01:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so5784904oie.10;
        Thu, 17 Jan 2019 03:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIA+Ukehi0waRescaoYbJ1AUOp6HQMBv7yTnbtoQPHs=;
        b=Bko1WE5DmrHm0dWv13mYFMcRA42ZuUL2HkF4CuRFf40PmfmX8opYxSbkWiftbD+Z/5
         xjFr1HYq/uNNeIgjZDW6S344ru1Dgp+ySyGM65n+pSTqeorE2otyzdQIRmuNcHqUqWyx
         mW0m7mZyi3bOaIcY3Hbeu0xCMWXxHfr1rUAl+/792oMWj21jejjkuNXTDUnQaJ5IEYDA
         NtDbFSfCgM4Q9F4+1MhK0leGZJtfieB5ugnJKHAS+7580+UnU9b19JLsDWjCHZy0jaev
         5qslmUYx3DfDdlBiaA/9sRW20kOfljy9GSzu5sl0+8CsYWJTb6sSk1vUpSB5PGb9NivB
         bWMA==
X-Gm-Message-State: AJcUukdIIhecR2kk30zog6JCwLg0HRVweih3E/Piajgnz5AdIsu4UyQQ
        ApvLs6+6FgFb3qRNcJsZ6SrH6ikc6zfoz44xs8c9hw==
X-Google-Smtp-Source: ALg8bN7OZT03eKoLNgehBIyi9rWPmEOfBIDWwLN6Ndl9ybgkk9BCn+XDCsztOR5+yAY0s0c8GttNhsJMxR1y+ev59nU=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr132879oix.246.1547722864498;
 Thu, 17 Jan 2019 03:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-4-keith.busch@intel.com>
In-Reply-To: <20190116175804.30196-4-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 12:00:53 +0100
Message-ID: <CAJZ5v0hEg3V7FoE6arwTTodVQ4uUZNLpwdOpjzh7PjqB3jguGw@mail.gmail.com>
Subject: Re: [PATCHv4 03/13] acpi/hmat: Parse and report heterogeneous memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Systems may provide different memory types and export this information
> in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
> tables provided by the platform and report the memory access and caching
> attributes.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/Kconfig       |   1 +
>  drivers/acpi/Makefile      |   1 +
>  drivers/acpi/hmat/Kconfig  |   8 ++
>  drivers/acpi/hmat/Makefile |   1 +
>  drivers/acpi/hmat/hmat.c   | 180 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 191 insertions(+)
>  create mode 100644 drivers/acpi/hmat/Kconfig
>  create mode 100644 drivers/acpi/hmat/Makefile
>  create mode 100644 drivers/acpi/hmat/hmat.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 90ff0a47c12e..b377f970adfd 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -465,6 +465,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
>           If you are unsure what to do, do not enable this option.
>
>  source "drivers/acpi/nfit/Kconfig"
> +source "drivers/acpi/hmat/Kconfig"
>
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 7c6afc111d76..bff8fbe5a6ab 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -79,6 +79,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)  += processor.o
>  obj-$(CONFIG_ACPI)             += container.o
>  obj-$(CONFIG_ACPI_THERMAL)     += thermal.o
>  obj-$(CONFIG_ACPI_NFIT)                += nfit/
> +obj-$(CONFIG_ACPI_HMAT)                += hmat/

Yes, I prefer it to go into a separate directory.

Who do you want to maintain it, me or Dan?

>  obj-$(CONFIG_ACPI)             += acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY)     += battery.o
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> new file mode 100644
> index 000000000000..a4034d37a311
> --- /dev/null
> +++ b/drivers/acpi/hmat/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config ACPI_HMAT
> +       bool "ACPI Heterogeneous Memory Attribute Table Support"
> +       depends on ACPI_NUMA
> +       help
> +        Parses representation of the ACPI Heterogeneous Memory Attributes
> +        Table (HMAT) and set the memory node relationships and access
> +        attributes.

What about:

"If set, this option causes the kernel to set the memory NUMA node
relationships and access attributes in accordance with ACPI HMAT
(Heterogeneous Memory Attributes Table)."

> diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
> new file mode 100644
> index 000000000000..e909051d3d00
> --- /dev/null
> +++ b/drivers/acpi/hmat/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ACPI_HMAT) := hmat.o
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> new file mode 100644
> index 000000000000..833a783868d5
> --- /dev/null
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Heterogeneous Memory Attributes Table (HMAT) representation
> + *
> + * Copyright (c) 2018, Intel Corporation.

Can you put a comment describing the code somewhat in here?

> + */
> +
> +#include <acpi/acpi_numa.h>
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/node.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>

Are all of the headers above really necessary to build the code?

> +
> +static __init const char *hmat_data_type(u8 type)
> +{
> +       switch (type) {
> +       case ACPI_HMAT_ACCESS_LATENCY:
> +               return "Access Latency";
> +       case ACPI_HMAT_READ_LATENCY:
> +               return "Read Latency";
> +       case ACPI_HMAT_WRITE_LATENCY:
> +               return "Write Latency";
> +       case ACPI_HMAT_ACCESS_BANDWIDTH:
> +               return "Access Bandwidth";
> +       case ACPI_HMAT_READ_BANDWIDTH:
> +               return "Read Bandwidth";
> +       case ACPI_HMAT_WRITE_BANDWIDTH:
> +               return "Write Bandwidth";
> +       default:
> +               return "Reserved";
> +       };
> +}
> +
> +static __init const char *hmat_data_type_suffix(u8 type)
> +{
> +       switch (type) {
> +       case ACPI_HMAT_ACCESS_LATENCY:
> +       case ACPI_HMAT_READ_LATENCY:
> +       case ACPI_HMAT_WRITE_LATENCY:
> +               return " nsec";
> +       case ACPI_HMAT_ACCESS_BANDWIDTH:
> +       case ACPI_HMAT_READ_BANDWIDTH:
> +       case ACPI_HMAT_WRITE_BANDWIDTH:
> +               return " MB/s";
> +       default:
> +               return "";
> +       };
> +}
> +
> +static __init int hmat_parse_locality(union acpi_subtable_headers *header,
> +                                     const unsigned long end)
> +{
> +       struct acpi_hmat_locality *loc = (void *)header;
> +       unsigned int init, targ, total_size, ipds, tpds;
> +       u32 *inits, *targs, value;
> +       u16 *entries;
> +       u8 type;
> +
> +       if (loc->header.length < sizeof(*loc)) {
> +               pr_err("HMAT: Unexpected locality header length: %d\n",
> +                       loc->header.length);

Why pr_err()?  Is the error really high-prio?

Same below.

> +               return -EINVAL;
> +       }
> +
> +       type = loc->data_type;
> +       ipds = loc->number_of_initiator_Pds;
> +       tpds = loc->number_of_target_Pds;
> +       total_size = sizeof(*loc) + sizeof(*entries) * ipds * tpds +
> +                    sizeof(*inits) * ipds + sizeof(*targs) * tpds;
> +       if (loc->header.length < total_size) {
> +               pr_err("HMAT: Unexpected locality header length:%d, minimum required:%d\n",
> +                       loc->header.length, total_size);
> +               return -EINVAL;
> +       }
> +
> +       pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%d Target Domains:%d Base:%lld\n",
> +               loc->flags, hmat_data_type(type), ipds, tpds,
> +               loc->entry_base_unit);
> +
> +       inits = (u32 *)(loc + 1);
> +       targs = &inits[ipds];
> +       entries = (u16 *)(&targs[tpds]);
> +       for (targ = 0; targ < tpds; targ++) {
> +               for (init = 0; init < ipds; init++) {
> +                       value = entries[init * tpds + targ];
> +                       value = (value * loc->entry_base_unit) / 10;
> +                       pr_info("  Initiator-Target[%d-%d]:%d%s\n",
> +                               inits[init], targs[targ], value,
> +                               hmat_data_type_suffix(type));
> +               }
> +       }
> +       return 0;
> +}

The format and meaning of what is printed into the log should be
documented somewhere IMO.

Of course, that applies to the functions below as well.

> +
> +static __init int hmat_parse_cache(union acpi_subtable_headers *header,
> +                                  const unsigned long end)
> +{
> +       struct acpi_hmat_cache *cache = (void *)header;
> +       u32 attrs;
> +
> +       if (cache->header.length < sizeof(*cache)) {
> +               pr_err("HMAT: Unexpected cache header length: %d\n",
> +                       cache->header.length);
> +               return -EINVAL;
> +       }
> +
> +       attrs = cache->cache_attributes;
> +       pr_info("HMAT: Cache: Domain:%d Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
> +               cache->memory_PD, cache->cache_size, attrs,
> +               cache->number_of_SMBIOShandles);
> +
> +       return 0;
> +}
> +
> +static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
> +                                          const unsigned long end)
> +{
> +       struct acpi_hmat_address_range *spa = (void *)header;
> +
> +       if (spa->header.length != sizeof(*spa)) {
> +               pr_err("HMAT: Unexpected address range header length: %d\n",
> +                       spa->header.length);
> +               return -EINVAL;
> +       }
> +       pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%d Memory Domain:%d\n",
> +               spa->physical_address_base, spa->physical_address_length,
> +               spa->flags, spa->processor_PD, spa->memory_PD);
> +       return 0;
> +}
> +
> +static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
> +                                     const unsigned long end)
> +{
> +       struct acpi_hmat_structure *hdr = (void *)header;
> +
> +       if (!hdr)
> +               return -EINVAL;
> +
> +       switch (hdr->type) {
> +       case ACPI_HMAT_TYPE_ADDRESS_RANGE:
> +               return hmat_parse_address_range(header, end);
> +       case ACPI_HMAT_TYPE_LOCALITY:
> +               return hmat_parse_locality(header, end);
> +       case ACPI_HMAT_TYPE_CACHE:
> +               return hmat_parse_cache(header, end);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static __init int hmat_init(void)
> +{
> +       struct acpi_table_header *tbl;
> +       enum acpi_hmat_type i;
> +       acpi_status status;
> +
> +       if (srat_disabled())
> +               return 0;
> +
> +       status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       for (i = ACPI_HMAT_TYPE_ADDRESS_RANGE; i < ACPI_HMAT_TYPE_RESERVED; i++) {
> +               if (acpi_table_parse_entries(ACPI_SIG_HMAT,
> +                                            sizeof(struct acpi_table_hmat), i,
> +                                            hmat_parse_subtable, 0) < 0)
> +                       goto out_put;
> +       }
> +out_put:
> +       acpi_put_table(tbl);
> +       return 0;
> +}
> +subsys_initcall(hmat_init);
> --

It looks like this particular patch only causes some extra messages to
be printed into the log, no attributes setting etc yet.

I would like the changelog to mention that.
