Date: Wed, 14 Mar 2018 14:22:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Cc: ard.biesheuvel@linaro.org, mingo@kernel.org, matt@codeblueprint.co.uk,
	sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
	dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
	robh+dt@kernel.org, mark.rutland@arm.com, rajanv@xilinx.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
Message-ID: <20180314132203.GB17229@kroah.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-3-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519154467-2896-3-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 11:21:05AM -0800, Jolly Shah wrote:
> This patch is adding communication layer with firmware.
> Firmware driver provides an interface to firmware APIs.
> Interface APIs can be used by any driver to communicate to
> PMUFW(Platform Management Unit). All requests go through ATF.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  arch/arm64/Kconfig.platforms                    |    1 +
>  drivers/firmware/Kconfig                        |    1 +
>  drivers/firmware/Makefile                       |    1 +
>  drivers/firmware/xilinx/Kconfig                 |    4 +
>  drivers/firmware/xilinx/Makefile                |    4 +
>  drivers/firmware/xilinx/zynqmp/Kconfig          |   16 +
>  drivers/firmware/xilinx/zynqmp/Makefile         |    4 +
>  drivers/firmware/xilinx/zynqmp/firmware.c       | 1051 +++++++++++++++++++++++

Why are you 2 levels deep?  Why not just drivers/firmware/zynqmp.c?  Or
at the worst:
	drivers/firmware/xilinx/zynqmp.c
Don't over do it, if we really get too many firmware drivers, we can
always move things around in the future.

>  include/linux/firmware/xilinx/zynqmp/firmware.h |  590 +++++++++++++

I still think this include directly depth is crazy.  What's wrong with:
	include/linux/firmware/zynqmp.h
?



>  9 files changed, 1672 insertions(+)
>  create mode 100644 drivers/firmware/xilinx/Kconfig
>  create mode 100644 drivers/firmware/xilinx/Makefile
>  create mode 100644 drivers/firmware/xilinx/zynqmp/Kconfig
>  create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
>  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
>  create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index fbedbd8..6454458 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -274,6 +274,7 @@ config ARCH_ZX
>  
>  config ARCH_ZYNQMP
>  	bool "Xilinx ZynqMP Family"
> +	select ZYNQMP_FIRMWARE

Select and not depends?

>  	help
>  	  This enables support for Xilinx ZynqMP Family
>  
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b7c7482..f41eb0d 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -257,5 +257,6 @@ source "drivers/firmware/google/Kconfig"
>  source "drivers/firmware/efi/Kconfig"
>  source "drivers/firmware/meson/Kconfig"
>  source "drivers/firmware/tegra/Kconfig"
> +source "drivers/firmware/xilinx/Kconfig"
>  
>  endmenu
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index b248238..f90363e 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -31,3 +31,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
>  obj-$(CONFIG_EFI)		+= efi/
>  obj-$(CONFIG_UEFI_CPER)		+= efi/
>  obj-y				+= tegra/
> +obj-y				+= xilinx/
> diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
> new file mode 100644
> index 0000000..eb4cdcf
> --- /dev/null
> +++ b/drivers/firmware/xilinx/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0+

2+ for a Kconfig file?

> +# Kconfig for Xilinx firmwares
> +
> +source "drivers/firmware/xilinx/zynqmp/Kconfig"
> diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
> new file mode 100644
> index 0000000..beff5dc
> --- /dev/null
> +++ b/drivers/firmware/xilinx/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0+

2+ for a Makefile?

> +# Makefile for Xilinx firmwares
> +
> +obj-$(CONFIG_ARCH_ZYNQMP) += zynqmp/
> diff --git a/drivers/firmware/xilinx/zynqmp/Kconfig b/drivers/firmware/xilinx/zynqmp/Kconfig
> new file mode 100644
> index 0000000..5054b80
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0+

Again...

> +# Kconfig for Xilinx ZynqMP firmware
> +
> +menu "Zynq MPSoC Firmware Drivers"
> +	depends on ARCH_ZYNQMP
> +
> +config ZYNQMP_FIRMWARE
> +	bool "Enable Xilinx Zynq MPSoC firmware interface"
> +	help
> +	  Firmware interface driver is used by different to
> +	  communicate with the firmware for various platform
> +	  management services.
> +	  Say yes to enable ZynqMP firmware interface driver.
> +	  In doubt, say N
> +
> +endmenu
> diff --git a/drivers/firmware/xilinx/zynqmp/Makefile b/drivers/firmware/xilinx/zynqmp/Makefile
> new file mode 100644
> index 0000000..c3ec669
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0+

And again?

> +# Makefile for Xilinx firmwares
> +
> +obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o
> diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
> new file mode 100644
> index 0000000..6979f4b
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/firmware.c
> @@ -0,0 +1,1051 @@
> +// SPDX-License-Identifier: GPL-2.0+

And I have to ask, you really mean "any future version"?

> +/*
> + * Xilinx Zynq MPSoC Firmware layer
> + *
> + *  Copyright (C) 2014-2018 Xilinx, Inc.
> + *
> + *  Michal Simek <michal.simek@xilinx.com>
> + *  Davorin Mista <davorin.mista@aggios.com>
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/compiler.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>

Why do you need a file in linux/firmware anyway?

> +struct zynqmp_eemi_ops {
> +	int (*get_api_version)(u32 *version);
> +	int (*get_chipid)(u32 *idcode, u32 *version);
> +	int (*reset_assert)(const enum zynqmp_pm_reset reset,
> +			    const enum zynqmp_pm_reset_action assert_flag);
> +	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
> +	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
> +	int (*fpga_get_status)(u32 *value);
> +	int (*sha_hash)(const u64 address, const u32 size, const u32 flags);
> +	int (*rsa)(const u64 address, const u32 size, const u32 flags);
> +	int (*request_suspend)(const u32 node,
> +			       const enum zynqmp_pm_request_ack ack,
> +			       const u32 latency,
> +			       const u32 state);
> +	int (*force_powerdown)(const u32 target,
> +			       const enum zynqmp_pm_request_ack ack);
> +	int (*request_wakeup)(const u32 node,
> +			      const bool set_addr,
> +			      const u64 address,
> +			      const enum zynqmp_pm_request_ack ack);
> +	int (*set_wakeup_source)(const u32 target,
> +				 const u32 wakeup_node,
> +				 const u32 enable);
> +	int (*system_shutdown)(const u32 type, const u32 subtype);
> +	int (*request_node)(const u32 node,
> +			    const u32 capabilities,
> +			    const u32 qos,
> +			    const enum zynqmp_pm_request_ack ack);
> +	int (*release_node)(const u32 node);
> +	int (*set_requirement)(const u32 node,
> +			       const u32 capabilities,
> +			       const u32 qos,
> +			       const enum zynqmp_pm_request_ack ack);
> +	int (*set_max_latency)(const u32 node, const u32 latency);
> +	int (*set_configuration)(const u32 physical_addr);
> +	int (*get_node_status)(const u32 node, u32 *const status,
> +			       u32 *const requirements, u32 *const usage);
> +	int (*get_operating_characteristic)(const u32 node,
> +					    const enum zynqmp_pm_opchar_type
> +					    type, u32 *const result);
> +	int (*init_finalize)(void);
> +	int (*set_suspend_mode)(u32 mode);
> +	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
> +	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
> +	int (*pinctrl_request)(const u32 pin);
> +	int (*pinctrl_release)(const u32 pin);
> +	int (*pinctrl_get_function)(const u32 pin, u32 *id);
> +	int (*pinctrl_set_function)(const u32 pin, const u32 id);
> +	int (*pinctrl_get_config)(const u32 pin, const u32 param, u32 *value);
> +	int (*pinctrl_set_config)(const u32 pin, const u32 param, u32 value);
> +	int (*clock_enable)(u32 clock_id);
> +	int (*clock_disable)(u32 clock_id);
> +	int (*clock_getstate)(u32 clock_id, u32 *state);
> +	int (*clock_setdivider)(u32 clock_id, u32 divider);
> +	int (*clock_getdivider)(u32 clock_id, u32 *divider);
> +	int (*clock_setrate)(u32 clock_id, u64 rate);
> +	int (*clock_getrate)(u32 clock_id, u64 *rate);
> +	int (*clock_setparent)(u32 clock_id, u32 parent_id);
> +	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
> +};

Why do you need this huge structure of pointers to functions, when you
only ever set them to 1 value, and no one even calls them?

Why not just export the needed symbols and call them directly?  What is
the indirection getting you here?

thanks,

greg k-h
