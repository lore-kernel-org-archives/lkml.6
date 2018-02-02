Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeBBUbP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:31:15 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43653 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBUbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:31:09 -0500
X-Google-Smtp-Source: AH8x227lkJLnJfIoyJroW3o2jiKIwcSmdCoIa2DyKfRxdptxhId1Z0lHE1z2CmPodvo+hkACnnPGs2OzEje3MRcrS80=
MIME-Version: 1.0
In-Reply-To: <20180202210036.3153-1-toshi.kani@hpe.com>
References: <20180202210036.3153-1-toshi.kani@hpe.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 2 Feb 2018 12:31:08 -0800
Message-ID: <CAPcyv4jPNxSKxb-kzaw8njhDHGUs7DOPASS_GBXbPGOFP4RN=g@mail.gmail.com>
Subject: Re: [PATCH] acpi, nfit: fix register dimm error handling
To: Toshi Kani <toshi.kani@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-nvdimm@lists.01.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 1:00 PM, Toshi Kani <toshi.kani@hpe.com> wrote:
> A NULL pointer reference kernel bug was observed when
> acpi_nfit_add_dimm() called in acpi_nfit_register_dimms()
> failed. This error path does not set nfit_mem->nvdimm, but
> the 2nd list_for_each_entry() loop in the function assumes
> it's always set. Add a check to nfit_mem->nvdimm.
>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/nfit/core.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index abeb4df4f22e..b28ce440a06f 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1867,6 +1867,9 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
>                 struct kernfs_node *nfit_kernfs;
>
>                 nvdimm = nfit_mem->nvdimm;
> +               if (!nvdimm)
> +                       continue;
> +
>                 nfit_kernfs = sysfs_get_dirent(nvdimm_kobj(nvdimm)->sd, "nfit");
>                 if (nfit_kernfs)
>                         nfit_mem->flags_attr = sysfs_get_dirent(nfit_kernfs,

Yes, I assume this also needs:

Cc: <stable@vger.kernel.org>
Fixes: ba9c8dd3c222 ("acpi, nfit: add dimm device notification support")
