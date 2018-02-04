Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBDI4U (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 03:56:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52161 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeBDI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 03:56:14 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] ACPI / x86: boot: Not all platforms require acpi_reduced_hw_init()
Date: Sun, 04 Feb 2018 09:54:35 +0100
Message-ID: <3139601.BsU5hxGGNu@aspire.rjw.lan>
In-Reply-To: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
References: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 17, 2018 6:34:07 PM CET Andy Shevchenko wrote:
> Some platforms might take care of legacy devices on theirs own.
> Let's allow them to do that by exporting a weak function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 2 +-
>  include/linux/acpi.h        | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index ec3a286163c3..9a714b79ebed 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1375,7 +1375,7 @@ static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
>   *
>   * We initialize the Hardware-reduced ACPI model here:
>   */
> -static void __init acpi_reduced_hw_init(void)
> +void __init __weak acpi_reduced_hw_init(void)
>  {
>  	if (acpi_gbl_reduced_hardware) {
>  		/*
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f0ea50ba0550..eb881516bce6 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -226,6 +226,8 @@ struct acpi_subtable_proc {
>  
>  void __iomem *__acpi_map_table(unsigned long phys, unsigned long size);
>  void __acpi_unmap_table(void __iomem *map, unsigned long size);
> +
> +void acpi_reduced_hw_init(void);
>  int early_acpi_boot_init(void);
>  int acpi_boot_init (void);
>  void acpi_boot_table_init (void);
> @@ -707,6 +709,7 @@ static inline struct device *acpi_get_first_physical_node(struct acpi_device *ad
>  static inline void acpi_early_init(void) { }
>  static inline void acpi_subsystem_init(void) { }
>  
> +static inline void acpi_reduced_hw_init(void) { }
>  static inline int early_acpi_boot_init(void)
>  {
>  	return 0;

May I suggest folding this into the [3/3]?

It would be clear why you need the __weak thing then.

OTOH, I guess you'll go for the new init callbacks rather.
