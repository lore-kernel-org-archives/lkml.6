Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeCMU0Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:26:25 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38043 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeCMU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:26:23 -0400
X-Google-Smtp-Source: AG47ELs+wO6guPR/wW1K2zRxR0AZ70sAkzIonyQ4r1ZfrWviai8H9ZDB5asiU+ihtI/+g5poWiHE0XCnDYSo/KeQZVs=
MIME-Version: 1.0
In-Reply-To: <1520967094-13219-1-git-send-email-kan.liang@linux.intel.com>
References: <1520967094-13219-1-git-send-email-kan.liang@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 22:26:22 +0200
Message-ID: <CAHp75VdNETV5rzQp0nfe6G5vxcGU-Sm5ZT==4dMDttP1eoqXPQ@mail.gmail.com>
Subject: Re: [PATCH V2] perf/x86/intel/uncore: Querying number of CHAs from
 CAPID6 register
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Kroening, Gary" <gary.kroening@hpe.com>,
        "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 8:51 PM,  <kan.liang@linux.intel.com> wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The number of CHAs is miscalculated on multi PCI domain systems on
> Skylake server.
>
> (From Kroening, Gary:
>
> For systems with a single PCI segment, it is sufficient to look for the
> bus number to change in order to determine that all of the CHa's have
> been counted for a single socket.
> However, for multi PCI segment systems, each socket is given a new
> segment and the bus number does NOT change.  So looking only for the
> bus number to change ends up counting all of the CHa's on all sockets
> in the system.  This leads to writing CPU MSRs beyond a valid range and
> causes an error in ivbep_uncore_msr_init_box().)
>
> To determine the number of CHAs, it should read bits 27:0 in the CAPID6
> register located at Device 30, Function 3, Offset 0x9C. These 28 bits
> form a bit vector of available LLC slices and the CHAs that manage those
> slices.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore
> support")
> Reported-by: Kroening, Gary <gary.kroening@hpe.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>
> Changes since V1:
>  - add missed pci_dev_put()
>  - Drop ugly casting by using hweight32()
>  - Add comments for macros.
>
>  arch/x86/events/intel/uncore_snbep.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 6d8044a..8970f71 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3562,24 +3562,27 @@ static struct intel_uncore_type *skx_msr_uncores[] = {
>         NULL,
>  };
>
> +/*
> + * To determine the number of CHAs, it should read bits 27:0 in the CAPID6
> + * register which located at Device 30, Function 3, Offset 0x9C. PCI ID 0x2083.
> + */
> +#define SKX_CAPID6             0x9c
> +#define SKX_CHA_BIT_MASK       GENMASK(27, 0)
> +
>  static int skx_count_chabox(void)
>  {
> -       struct pci_dev *chabox_dev = NULL;
> -       int bus, count = 0;
> +       struct pci_dev *dev = NULL;
> +       u32 val = 0;
>
> -       while (1) {
> -               chabox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x208d, chabox_dev);
> -               if (!chabox_dev)
> -                       break;
> -               if (count == 0)
> -                       bus = chabox_dev->bus->number;
> -               if (bus != chabox_dev->bus->number)
> -                       break;
> -               count++;
> -       }
> +       dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
> +       if (!dev)
> +               goto out;
>
> -       pci_dev_put(chabox_dev);
> -       return count;
> +       pci_read_config_dword(dev, SKX_CAPID6, &val);
> +       val &= SKX_CHA_BIT_MASK;
> +out:
> +       pci_dev_put(dev);
> +       return hweight32(val);
>  }
>
>  void skx_uncore_cpu_init(void)
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
