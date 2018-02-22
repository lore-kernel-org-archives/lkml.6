Date: Thu, 22 Feb 2018 17:36:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Or Idgar <idgar@virtualoco.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ghammer@redhat.com,
	Or Idgar <oridgar@gmail.com>
Subject: Re: [PATCH] drivers/virt: vm_gen_counter: initial driver
 implementation
Message-ID: <20180222163628.GA19172@kroah.com>
References: <20180222162038.28768-1-idgar@virtualoco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222162038.28768-1-idgar@virtualoco.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 06:20:38PM +0200, Or Idgar wrote:
> From: Or Idgar <oridgar@gmail.com>
> 
> This patch is a driver which expose the Virtual Machine Generation ID
> via sysfs. The ID is a UUID value used to differentiate between virtual
> machines.
> 
> The VM-Generation ID is a feature defined by Microsoft (paper:
> http://go.microsoft.com/fwlink/?LinkId=260709) and supported by multiple
> hypervisor vendors.
> 
> Signed-off-by: Or Idgar <oridgar@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-hypervisor |  13 +++
>  drivers/misc/Kconfig                       |   6 ++
>  drivers/misc/Makefile                      |   1 +
>  drivers/misc/vmgenid.c                     | 141 +++++++++++++++++++++++++++++
>  4 files changed, 161 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-hypervisor
>  create mode 100644 drivers/misc/vmgenid.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-hypervisor b/Documentation/ABI/testing/sysfs-hypervisor
> new file mode 100644
> index 000000000000..2f9a7b8eab70
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-hypervisor
> @@ -0,0 +1,13 @@
> +What:		/sys/hypervisor/vm_gen_counter

Shouldn't this go under the specific hypervisor you are running on?  Why
in the "root" of /sys/hypervisor?


> +Date:		February 2018
> +Contact:	Or Idgar <idgar@virtualoco.com>
> +		Gal Hammer <ghammer@redhat.com>
> +Description:	Expose the virtual machine generation ID. The directory
> +		contains two files: "generation_id" and "raw". Both files
> +		represent the same information.
> +
> +		"generation_id" file is a UUID string
> +		representation.
> +
> +		"raw" file is a 128-bit integer
> +		representation (binary).
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 03605f8fc0dc..5a74802bdfb4 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -500,6 +500,12 @@ config MISC_RTSX
>  	tristate
>  	default MISC_RTSX_PCI || MISC_RTSX_USB
>  
> +config VMGENID
> +	tristate "Virtual Machine Generation ID driver"
> +	help
> +	  This is a Virtual Machine Generation ID driver which provides
> +	  a virtual machine unique identifier.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c3c8624f4d95..067aa666bb6a 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> +obj-$(CONFIG_VMGENID)		+= vmgenid.o
>  
>  lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
>  lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
> diff --git a/drivers/misc/vmgenid.c b/drivers/misc/vmgenid.c
> new file mode 100644
> index 000000000000..9d7f09f9e7bd
> --- /dev/null
> +++ b/drivers/misc/vmgenid.c
> @@ -0,0 +1,141 @@
> +/*
> + * Virtual Machine Generation ID driver
> + *
> + * Copyright (C) 2018 Red Hat, Inc. All rights reserved.
> + *	Authors:
> + *	  Or Idgar <oridgar@gmail.com>
> + *	  Gal Hammer <ghammer@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

No SPDX line?  Please see the documentation for how to properly add this
as the first line of any new file.

I want some hypervisor people to weigh in on this before I can take
it...

thanks,

greg k-h
