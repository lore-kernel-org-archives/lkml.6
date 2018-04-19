Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbeDSTKx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:10:53 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45800 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeDSTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:10:51 -0400
X-Google-Smtp-Source: AIpwx48cNOzO6twHekGuT71FOdbEydKwneFeCtc42sf1Cfa1QbxvTNWcjFTKBBp7Ek8Nkqvq32X01VmY6iqI2+wD8GM=
MIME-Version: 1.0
References: <1521810690-2576-1-git-send-email-kan.liang@linux.intel.com> <1521810690-2576-2-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1521810690-2576-2-git-send-email-kan.liang@linux.intel.com>
From: Stephane Eranian <eranian@google.com>
Date: Thu, 19 Apr 2018 19:10:39 +0000
Message-ID: <CABPqkBQu8KfU4k_-TcBh3c+cvTJDibQkZmeo4Tv3HRvHhqz8YQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] perf/x86/intel/uncore: Fix SBOX support for
 Broadwell CPUs
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Oskar Senft <osk@google.com>,
        mark@voidzero.net, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 6:12 AM Kan Liang <kan.liang@linux.intel.com> wrote:

> From: Oskar Senft <osk@google.com>

> This fixes SBOX support for Broadwell CPUs by checking the Power Control
> Unit CAPID4 register to determine the number of available SBOXes on the
> particular CPU before trying to enable them.

> Signed-off-by: Oskar Senft <osk@google.com>
> Tested-by: Mark van Dijk <mark@voidzero.net>
> Reviewed-by: Kan Liang <kan.liang@intel.com>

Could you please merge this change?
Thanks.

> ---
>   arch/x86/events/intel/uncore_snbep.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)

> diff --git a/arch/x86/events/intel/uncore_snbep.c
b/arch/x86/events/intel/uncore_snbep.c
> index 47c6910..715eb14 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3060,6 +3060,8 @@ static struct event_constraint
bdx_uncore_pcu_constraints[] = {

>   void bdx_uncore_cpu_init(void)
>   {
> +       int pkg = topology_phys_to_logical_pkg(0);
> +
>          if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
>                  bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
>          uncore_msr_uncores = bdx_msr_uncores;
> @@ -3067,7 +3069,15 @@ void bdx_uncore_cpu_init(void)
>          /* BDX-DE doesn't have SBOX */
>          if (boot_cpu_data.x86_model == 86)
>                  uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
> -
> +       /* Detect systems with no SBOXes */
> +       else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
> +               u32 capid4;
> +               pci_read_config_dword(
> +                       uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3],
> +                       0x94, &capid4);
> +               if (((capid4 >> 6) & 0x3) == 0)
> +                       bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
> +       }
>          hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
>   }

> @@ -3285,6 +3295,11 @@ static const struct pci_device_id
bdx_uncore_pci_ids[] = {
>                  PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
>                  .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
2),
>          },
> +       { /* PCU.3 (for Capability registers) */
> +               PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
> +               .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
> +                                                  HSWEP_PCI_PCU_3),
> +       },
>          { /* end: all zeroes */ }
>   };

> --
> 2.4.11
