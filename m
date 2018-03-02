Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934471AbeCBXMT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:12:19 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33950 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934264AbeCBXMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:12:16 -0500
X-Google-Smtp-Source: AG47ELsizhegRSSi0W5HKl3KZ2C9D7ClGGxOwsWPvkqCVYoDfYbv4QODRrIWs+u00CxizNHarkdgag==
Date: Fri, 2 Mar 2018 17:12:13 -0600
From: Rob Herring <robh@kernel.org>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        phil.edworthy@renesas.com, Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm: add basic support for Renesas RZ/N1 boards
Message-ID: <20180302231213.yzlccr762n762ljt@rob-hp-laptop>
References: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
 <1519647518-15579-2-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519647518-15579-2-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:18:19PM +0000, Michel Pollet wrote:
> This adds the Renesas RZ/N1 CPU and bare bone support.
> 
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> This also relies on the bootloader to set the pinctrl and clocks.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt |   3 +-
>  arch/arm/boot/dts/rzn1.dtsi                        |  94 +++
>  arch/arm/mach-shmobile/Kconfig                     |   5 +
>  arch/arm/mach-shmobile/Makefile                    |   1 +
>  arch/arm/mach-shmobile/setup-r9a06g032.c           |  60 ++
>  .../dt-bindings/interrupt-controller/rzn1-irq.h    | 137 ++++
>  include/dt-bindings/soc/renesas,rzn1-map.h         | 173 +++++
>  include/soc/rzn1/sysctrl.h                         | 736 +++++++++++++++++++++
>  8 files changed, 1208 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/rzn1.dtsi
>  create mode 100644 arch/arm/mach-shmobile/setup-r9a06g032.c
>  create mode 100644 include/dt-bindings/interrupt-controller/rzn1-irq.h
>  create mode 100644 include/dt-bindings/soc/renesas,rzn1-map.h
>  create mode 100644 include/soc/rzn1/sysctrl.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 63edc11..153f69bb 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -47,7 +47,8 @@ SoCs:
>      compatible = "renesas,r8a77980"
>    - R-Car D3 (R8A77995)
>      compatible = "renesas,r8a77995"
> -
> +  - RZ/N1D (R9A06G032)
> +    compatible = "renesas,r9a06g032"
>  
>  Boards:
>  
> diff --git a/arch/arm/boot/dts/rzn1.dtsi b/arch/arm/boot/dts/rzn1.dtsi
> new file mode 100644
> index 0000000..bc134b0
> --- /dev/null
> +++ b/arch/arm/boot/dts/rzn1.dtsi
> @@ -0,0 +1,94 @@
> +/*
> + * Base Device Tree Source for the Renesas RZ/N1 SoC
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * SPDX-License-Identifier: GPL-2.0

Goes on the first line now.

> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/rzn1-irq.h>
> +#include <dt-bindings/soc/renesas,rzn1-map.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "skeleton.dtsi"

Don't use skeleton.dtsi. We're trying to remove it.

> +
> +/ {
> +	compatible = "renesas,r9a06g032";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0>;
> +		};
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <1>;
> +		};
> +	};
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +	arm_timer: timer {
> +		compatible = "arm,armv7-timer";
> +		arm,cpu-registers-not-fw-configured;
> +		interrupts =
> +			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +	gic: interrupt-controller@RZN1_GIC_BASE {

Don't use macros for unit-addresses.

> +		compatible = "arm,cortex-a7-gic";
> +		reg = <0x44101000 0x1000>,	/* Distributer */
> +		      <0x44102000 0x1000>,	/* CPU interface */
> +		      <0x44104000 0x2000>,	/* Virt interface control */
> +		      <0x44106000 0x2000>;	/* Virt CPU interface */
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupts =
> +			<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
> +				IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +	clocks: clocks@0 {

Build with W=1 and W=12 and fix those warnings.

> +		/*
> +		 * this is fixed clock for now,
> +		 * until the clock driver is merged
> +		 */
> +		clk_uarts: clk_uarts@0 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <47619047>;
> +		};
> +	};
> +	bus {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		uart0: serial@RZN1_UART0_BASE {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <RZN1_UART0_BASE RZN1_UART0_SIZE>;
> +			interrupts = <GIC_SPI RZN1_IRQ_UART0
> +					IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clocks = <&clk_uarts>;
> +			clock-names = "baudclk";
> +			status = "disabled";
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 280e731..e2cd7aa 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -110,6 +110,11 @@ config ARCH_R8A7794
>  	bool "R-Car E2 (R8A77940)"
>  	select ARCH_RCAR_GEN2
>  
> +config ARCH_R9A06G032
> +	bool "RZ/N1D (R9A06G032)"
> +	select ARM_AMBA
> +	select CPU_V7
> +
>  config ARCH_SH73A0
>  	bool "SH-Mobile AG5 (R8A73A00)"
>  	select ARCH_RMOBILE
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index 1939f52..a63e5c2 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
>  obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
>  obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
>  obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
> +obj-$(CONFIG_ARCH_R9A06G032)	+= setup-r9a06g032.o
>  
>  # CPU reset vector handling objects
>  cpu-y				:= platsmp.o headsmp.o
> diff --git a/arch/arm/mach-shmobile/setup-r9a06g032.c b/arch/arm/mach-shmobile/setup-r9a06g032.c
> new file mode 100644
> index 0000000..453c0b2
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/setup-r9a06g032.c
> @@ -0,0 +1,60 @@
> +/*
> + * RZ/N1 processor support file
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> + *
> + */
> + /* SPDX-License-Identifier: GPL-2.0 */

First line and use // style comments in .c files.

> +
> +#include <asm/mach/arch.h>
> +#include <dt-bindings/soc/renesas,rzn1-map.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <soc/rzn1/sysctrl.h>
> +
> +static void __iomem *sysctrl_base_addr;
> +
> +static void rzn1_sysctrl_init(void)
> +{
> +	if (sysctrl_base_addr)
> +		return;

You already checked this below.

> +	sysctrl_base_addr = ioremap(RZN1_SYSTEM_CTRL_BASE,
> +					RZN1_SYSTEM_CTRL_SIZE);
> +	BUG_ON(!sysctrl_base_addr);
> +}
> +
> +void __iomem *rzn1_sysctrl_base(void)
> +{
> +	if (!sysctrl_base_addr)
> +		rzn1_sysctrl_init();
> +	return sysctrl_base_addr;
> +}
> +EXPORT_SYMBOL(rzn1_sysctrl_base);
> +
> +static void rzn1_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	rzn1_sysctrl_writel(
> +			rzn1_sysctrl_readl(RZN1_SYSCTRL_REG_RSTEN) |
> +			BIT(RZN1_SYSCTRL_REG_RSTEN_SWRST_EN) |
> +				BIT(RZN1_SYSCTRL_REG_RSTEN_MRESET_EN),
> +			RZN1_SYSCTRL_REG_RSTEN);
> +	rzn1_sysctrl_writel(
> +			rzn1_sysctrl_readl(RZN1_SYSCTRL_REG_RSTCTRL) |
> +			BIT(RZN1_SYSCTRL_REG_RSTCTRL_SWRST_REQ),
> +			RZN1_SYSCTRL_REG_RSTCTRL);
> +}
> +
> +#ifdef CONFIG_USE_OF

This should always be true.

> +static const char *rzn1_boards_compat_dt[] __initconst = {
> +	"renesas,r9a06g032",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(RZN1_DT, "Renesas RZ/N1 (Device Tree)")
> +	.dt_compat      = rzn1_boards_compat_dt,
> +	.restart	= rzn1_restart,
> +MACHINE_END
> +#endif /* CONFIG_USE_OF */
> diff --git a/include/dt-bindings/interrupt-controller/rzn1-irq.h b/include/dt-bindings/interrupt-controller/rzn1-irq.h
> new file mode 100644
> index 0000000..6f56e5b
> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/rzn1-irq.h
> @@ -0,0 +1,137 @@
> +/*
> + * This file was autogenerated from design documents
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + * All rights reserved.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
> + */
> +
> +#ifndef __RZN1_IRQ_H__
> +#define __RZN1_IRQ_H__
> +
> +#define RZN1_IRQ_ADC			0
> +#define RZN1_IRQ_I2C0			1
> +#define RZN1_IRQ_I2C1			2
> +#define RZN1_IRQ_SAFETY_FILTERING	3
> +#define RZN1_IRQ_UART0			6
> +#define RZN1_IRQ_UART1			7
> +#define RZN1_IRQ_UART2			8
> +#define RZN1_IRQ_ECC_4MB		11
> +#define RZN1_IRQ_ECC_2MB		12
> +#define RZN1_IRQ_CM3_LOCKUP		13
> +#define RZN1_IRQ_CM3_TRING_0		14
> +#define RZN1_IRQ_CM3_TRING_1		15
> +#define RZN1_IRQ_HWRTOS_BRAMERR		16
> +#define RZN1_IRQ_HWRTOS_BUFDMA		17
> +#define RZN1_IRQ_HWRTOS_BUFDMAERR	18
> +#define RZN1_IRQ_HWRTOS_ETHMII		19
> +#define RZN1_IRQ_HWRTOS_ETHPAUSE	20
> +#define RZN1_IRQ_HWRTOS_ETHRXDERR	21
> +#define RZN1_IRQ_HWRTOS_ETHRXDMA	22
> +#define RZN1_IRQ_HWRTOS_ETHRXERR	23
> +#define RZN1_IRQ_HWRTOS_ETHRXFIFO	24
> +#define RZN1_IRQ_HWRTOS_ETHTX		25
> +#define RZN1_IRQ_HWRTOS_ETHTXDERR	26
> +#define RZN1_IRQ_HWRTOS_ETHTXDMA	27
> +#define RZN1_IRQ_HWRTOS_ETHTXFIFO	28
> +#define RZN1_IRQ_HWRTOS_ETHTXFIFOERR	29
> +#define RZN1_IRQ_HWRTOS			30
> +#define RZN1_IRQ_HWRTOS_MACDMARXFRM	31
> +#define RZN1_IRQ_HWRTOS_TM_LPI_AST	32
> +#define RZN1_IRQ_HWRTOS_TM_LPI_DEAST	33
> +#define RZN1_IRQ_GMAC0_SBD		34
> +#define RZN1_IRQ_GMAC0_LPI		35
> +#define RZN1_IRQ_GMAC0_PMT		36
> +#define RZN1_IRQ_GMAC1_SBD		37
> +#define RZN1_IRQ_GMAC1_LPI		38
> +#define RZN1_IRQ_GMAC1_PMT		39
> +#define RZN1_IRQ_SWITCHDLR		40
> +#define RZN1_IRQ_SWITCH			42
> +#define RZN1_IRQ_SWITCHPRP		43
> +#define RZN1_IRQ_ETHSWHUB		44
> +#define RZN1_IRQ_ETHSWPTRN		45
> +#define RZN1_IRQ_CAT_RST		46
> +#define RZN1_IRQ_CAT_SYNC_0		47
> +#define RZN1_IRQ_CAT_SYNC_1		48
> +#define RZN1_IRQ_CAT_WDT		49	/* shared */
> +#define RZN1_IRQ_S3_DIVCLK		49	/* shared */

That's good way to hide shared interrupts from someone reading the dts 
file...

> +#define RZN1_IRQ_CAT_EOF		50	/* shared */
> +#define RZN1_IRQ_S3_CONCLK		50	/* shared */
> +#define RZN1_IRQ_HSR_PTP		50	/* shared */
> +#define RZN1_IRQ_CAT_SOF		51	/* shared */
> +#define RZN1_IRQ_S3_0			51	/* shared */
> +#define RZN1_IRQ_HSR_CPU		51	/* shared */
> +#define RZN1_IRQ_CAT			52	/* shared */
> +#define RZN1_IRQ_S3_1			52	/* shared */
> +#define RZN1_IRQ_NOCFIREWALL		53
> +#define RZN1_IRQ_CRYPTO0		54
> +#define RZN1_IRQ_CRYPTO1		55
> +#define RZN1_IRQ_DMA0			56
> +#define RZN1_IRQ_DMA1			57
> +#define RZN1_IRQ_NAND			58
> +#define RZN1_IRQ_IPCM0			59
> +#define RZN1_IRQ_IPCM1			60
> +#define RZN1_IRQ_IPCM2			61
> +#define RZN1_IRQ_MSEBIM			62
> +#define RZN1_IRQ_MSEBIS			63
> +#define RZN1_IRQ_QSPI0			64
> +#define RZN1_IRQ_QSPI1			65
> +#define RZN1_IRQ_RTCATINTAL		66
> +#define RZN1_IRQ_RTCATINTR		67
> +#define RZN1_IRQ_RTCATINT1S		68
> +#define RZN1_IRQ_SDIO0			69
> +#define RZN1_IRQ_SDIO0_WKUP		70
> +#define RZN1_IRQ_SDIO1			71
> +#define RZN1_IRQ_SDIO1_WKUP		72
> +#define RZN1_IRQ_WATCHDOG_RESETN0	73
> +#define RZN1_IRQ_WATCHDOG_RESETN1	74
> +#define RZN1_IRQ_WATCHDOG_CM3_RESETN	75
> +#define RZN1_IRQ_DDRC			76
> +#define RZN1_IRQ_USBF_EPC		77
> +#define RZN1_IRQ_USBF			78
> +#define RZN1_IRQ_USBH_BIND		79
> +#define RZN1_IRQ_SPI0			80
> +#define RZN1_IRQ_SPI1			81
> +#define RZN1_IRQ_SPI2			82
> +#define RZN1_IRQ_SPI3			83
> +#define RZN1_IRQ_SPI4			84
> +#define RZN1_IRQ_SPI5			85
> +#define RZN1_IRQ_UART3			86
> +#define RZN1_IRQ_UART4			87
> +#define RZN1_IRQ_UART5			88
> +#define RZN1_IRQ_UART6			89
> +#define RZN1_IRQ_UART7			90
> +#define RZN1_IRQ_CAN0			95
> +#define RZN1_IRQ_CAN1			96
> +#define RZN1_IRQ_LCD			97
> +#define RZN1_IRQ_WATCHDOGSAFE0		100
> +#define RZN1_IRQ_WATCHDOGSAFE1		101
> +#define RZN1_IRQ_RESET			102
> +#define RZN1_IRQ_GPIO0			103
> +#define RZN1_IRQ_GPIO1			104
> +#define RZN1_IRQ_GPIO2			105
> +#define RZN1_IRQ_GPIO3			106
> +#define RZN1_IRQ_GPIO4			107
> +#define RZN1_IRQ_GPIO5			108
> +#define RZN1_IRQ_GPIO6			109
> +#define RZN1_IRQ_GPIO7			110
> +#define RZN1_IRQ_TIMER0_0		112
> +#define RZN1_IRQ_TIMER0_1		113
> +#define RZN1_IRQ_TIMER0_2		114
> +#define RZN1_IRQ_TIMER0_3		115
> +#define RZN1_IRQ_TIMER0_4		116
> +#define RZN1_IRQ_TIMER0_5		117
> +#define RZN1_IRQ_TIMER0_6		118
> +#define RZN1_IRQ_TIMER0_7		119
> +#define RZN1_IRQ_TIMER1_0		120
> +#define RZN1_IRQ_TIMER1_1		121
> +#define RZN1_IRQ_TIMER1_2		122
> +#define RZN1_IRQ_TIMER1_3		123
> +#define RZN1_IRQ_TIMER1_4		124
> +#define RZN1_IRQ_TIMER1_5		125
> +#define RZN1_IRQ_TIMER1_6		126
> +#define RZN1_IRQ_TIMER1_7		127
> +#define RZN1_IRQ_AXIERR			155
> +
> +#endif /* __RZN1_IRQ_H__ */
> diff --git a/include/dt-bindings/soc/renesas,rzn1-map.h b/include/dt-bindings/soc/renesas,rzn1-map.h
> new file mode 100644
> index 0000000..fa76c31
> --- /dev/null
> +++ b/include/dt-bindings/soc/renesas,rzn1-map.h
> @@ -0,0 +1,173 @@
> +/*
> + * This file was autogenerated from design documents
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + * All rights reserved.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
> + */
> +
> +#ifndef __RZN1_MEMORY_MAP_H__
> +#define __RZN1_MEMORY_MAP_H__

Drop this. We don't do defines for register addresses.

> +
> +#define RZN1_ROM_BASE			0x00000000
> +#define RZN1_ROM_SIZE			0x10000		/* 64 KB */
> +#define RZN1_SRAM_ID_BASE		0x04000000
> +#define RZN1_SRAM_ID_SIZE		0x100000	/* 1 MB */
> +#define RZN1_V_QSPI_BASE		0x10000000
> +#define RZN1_V_QSPI_SIZE		0x10000000	/* 256 MB */
> +#define RZN1_SRAM_SYS_BASE		0x20000000
> +#define RZN1_SRAM_SYS_SIZE		0x100000	/* 1 MB */
> +#define RZN1_QSPI_BASE			0x40005000
> +#define RZN1_QSPI_SIZE			0x1000		/* 4 KB */
> +#define RZN1_RTC_BASE			0x40006000
> +#define RZN1_RTC_SIZE			0x1000		/* 4 KB */
> +#define RZN1_OTP_BASE			0x40007000
> +#define RZN1_OTP_SIZE			0x1000		/* 4 KB */
> +#define RZN1_WATCHDOG0_BASE		0x40008000
> +#define RZN1_WATCHDOG0_SIZE		0x1000		/* 4 KB */
> +#define RZN1_WATCHDOG1_BASE		0x40009000
> +#define RZN1_WATCHDOG1_SIZE		0x1000		/* 4 KB */
> +#define RZN1_WATCHDOG_M3_BASE		0x4000A000
> +#define RZN1_WATCHDOG_M3_SIZE		0x1000		/* 4 KB */
> +#define RZN1_MAILBOX_BASE		0x4000B000
> +#define RZN1_MAILBOX_SIZE		0x1000		/* 4 KB */
> +#define RZN1_SYSTEM_CTRL_BASE		0x4000C000
> +#define RZN1_SYSTEM_CTRL_SIZE		0x1000		/* 4 KB */
> +#define RZN1_DDR_BASE			0x4000D000
> +#define RZN1_DDR_SIZE			0x1000		/* 4 KB */
> +#define RZN1_DDRPHY_BASE		0x4000E000
> +#define RZN1_DDRPHY_SIZE		0x1000		/* 4 KB */
> +#define RZN1_QSPI1_BASE			0x4000E000	/* RZ/N1S only */
> +#define RZN1_QSPI1_SIZE			0x1000		/* 4 KB */
> +#define RZN1_PACKET_ENGINE_BASE		0x40010000
> +#define RZN1_PACKET_ENGINE_SIZE		0x1000		/* 4 KB */
> +#define RZN1_USB_DEV_BASE		0x4001E000
> +#define RZN1_USB_DEV_SIZE		0x2000		/* 8 KB */
> +#define RZN1_USB_HOST_BASE		0x40020000
> +#define RZN1_USB_HOST_SIZE		0x20000		/* 128 KB */
> +#define RZN1_PUBLIC_KEY_PROC_BASE	0x40040000
> +#define RZN1_PUBLIC_KEY_PROC_SIZE	0x10000		/* 64 KB */
> +#define RZN1_UART0_BASE			0x40060000
> +#define RZN1_UART0_SIZE			0x400		/* 1 KB */
> +#define RZN1_UART1_BASE			0x40061000
> +#define RZN1_UART1_SIZE			0x400		/* 1 KB */
> +#define RZN1_UART2_BASE			0x40062000
> +#define RZN1_UART2_SIZE			0x400		/* 1 KB */
> +#define RZN1_I2C0_BASE			0x40063000
> +#define RZN1_I2C0_SIZE			0x100		/* 256 bytes */
> +#define RZN1_I2C1_BASE			0x40064000
> +#define RZN1_I2C1_SIZE			0x100		/* 256 bytes */
> +#define RZN1_ADC_BASE			0x40065000
> +#define RZN1_ADC_SIZE			0x1000		/* 4 KB */
> +#define RZN1_CONFIG_SOC_BASE		0x40066000
> +#define RZN1_CONFIG_SOC_SIZE		0x2000		/* 8 KB */
> +#define RZN1_PINCTRL_BASE		0x40067000
> +#define RZN1_PINCTRL_SIZE		0x1000		/* 4 KB */
> +#define RZN1_PWM_BASE			0x40068000
> +#define RZN1_PWM_SIZE			0x4000		/* 16 KB */
> +#define RZN1_DELTASIGMA_BASE		0x4006C000
> +#define RZN1_DELTASIGMA_SIZE		0x400		/* 1 KB */
> +#define RZN1_SGPIO0_BASE		0x4006D000
> +#define RZN1_SGPIO0_SIZE		0x400		/* 1 KB */
> +#define RZN1_SGPIO1_BASE		0x4006E000
> +#define RZN1_SGPIO1_SIZE		0x400		/* 1 KB */
> +#define RZN1_MSEBI_M1_BASE		0x40080000
> +#define RZN1_MSEBI_M1_SIZE		0x40000		/* 256 KB */
> +#define RZN1_MSEBI_M0_BASE		0x400C0000
> +#define RZN1_MSEBI_M0_SIZE		0x2000		/* 8 KB */
> +#define RZN1_MSEBI_S_BASE		0x400C2000
> +#define RZN1_MSEBI_S_SIZE		0x1000		/* 4 KB */
> +#define RZN1_RIN_CTRL_REG_BASE		0x400E0000
> +#define RZN1_RIN_CTRL_REG_SIZE		0x20000		/* 128 KB */
> +#define RZN1_SDIO0_BASE			0x40100000
> +#define RZN1_SDIO0_SIZE			0x1000		/* 4 KB */
> +#define RZN1_SDIO1_BASE			0x40101000
> +#define RZN1_SDIO1_SIZE			0x1000		/* 4 KB */
> +#define RZN1_NAND_BASE			0x40102000
> +#define RZN1_NAND_SIZE			0x2000		/* 8 KB */
> +#define RZN1_DMA0_BASE			0x40104000
> +#define RZN1_DMA0_SIZE			0x1000		/* 4 KB */
> +#define RZN1_DMA1_BASE			0x40105000
> +#define RZN1_DMA1_SIZE			0x1000		/* 4 KB */
> +#define RZN1_GMAC0_BASE			0x44000000
> +#define RZN1_GMAC0_SIZE			0x2000		/* 8 KB */
> +#define RZN1_GMAC1_BASE			0x44002000
> +#define RZN1_GMAC1_SIZE			0x2000		/* 8 KB */
> +#define RZN1_ETHERCAT_BASE		0x44010000
> +#define RZN1_ETHERCAT_SIZE		0x10000		/* 64 KB */
> +#define RZN1_SERCOS_BASE		0x44020000
> +#define RZN1_SERCOS_SIZE		0x10000		/* 64 KB */
> +#define RZN1_SWITCH_CTRL_REG_BASE	0x44030000
> +#define RZN1_SWITCH_CTRL_REG_SIZE	0x10000		/* 64 KB */
> +#define RZN1_HSR_CPU_BASE		0x44040000
> +#define RZN1_HSR_CPU_SIZE		0x8000		/* 32 KB */
> +#define RZN1_HSR_CORE_BASE		0x44048000
> +#define RZN1_HSR_CORE_SIZE		0x4000		/* 16 KB */
> +#define RZN1_HSR_PTP_BASE		0x4404C000
> +#define RZN1_HSR_PTP_SIZE		0x4000		/* 16 KB */
> +#define RZN1_SWITCH_BASE		0x44050000
> +#define RZN1_SWITCH_SIZE		0x10000		/* 64 KB */
> +#define RZN1_GIC_BASE			0x44100000
> +#define RZN1_GIC_SIZE			0x8000		/* 32 KB */
> +#define RZN1_CSDAP_BASE			0x45000000
> +#define RZN1_CSDAP_SIZE			0x200000	/* 2 MB */
> +#define RZN1_UART3_BASE			0x50000000
> +#define RZN1_UART3_SIZE			0x400		/* 1 KB */
> +#define RZN1_UART4_BASE			0x50001000
> +#define RZN1_UART4_SIZE			0x400		/* 1 KB */
> +#define RZN1_UART5_BASE			0x50002000
> +#define RZN1_UART5_SIZE			0x400		/* 1 KB */
> +#define RZN1_UART6_BASE			0x50003000
> +#define RZN1_UART6_SIZE			0x400		/* 1 KB */
> +#define RZN1_UART7_BASE			0x50004000
> +#define RZN1_UART7_SIZE			0x400		/* 1 KB */
> +#define RZN1_SPI0_BASE			0x50005000
> +#define RZN1_SPI0_SIZE			0x400		/* 1 KB */
> +#define RZN1_SPI1_BASE			0x50006000
> +#define RZN1_SPI1_SIZE			0x400		/* 1 KB */
> +#define RZN1_SPI2_BASE			0x50007000
> +#define RZN1_SPI2_SIZE			0x400		/* 1 KB */
> +#define RZN1_SPI3_BASE			0x50008000
> +#define RZN1_SPI3_SIZE			0x400		/* 1 KB */
> +#define RZN1_SPI4_BASE			0x50009000
> +#define RZN1_SPI4_SIZE			0x400		/* 1 KB */
> +#define RZN1_SPI5_BASE			0x5000A000
> +#define RZN1_SPI5_SIZE			0x400		/* 1 KB */
> +#define RZN1_GPIO0_BASE			0x5000B000
> +#define RZN1_GPIO0_SIZE			0x80		/* 128 bytes */
> +#define RZN1_GPIO1_BASE			0x5000C000
> +#define RZN1_GPIO1_SIZE			0x80		/* 128 bytes */
> +#define RZN1_GPIO2_BASE			0x5000D000
> +#define RZN1_GPIO2_SIZE			0x80		/* 128 bytes */
> +#define RZN1_SGPIO3_BASE		0x5000F000
> +#define RZN1_SGPIO3_SIZE		0x400		/* 1 KB */
> +#define RZN1_SGPIO4_BASE		0x50010000
> +#define RZN1_SGPIO4_SIZE		0x400		/* 1 KB */
> +#define RZN1_PINCTRL_L2_BASE		0x51000000
> +#define RZN1_PINCTRL_L2_SIZE		0x800		/* 2 KB */
> +#define RZN1_TIMER0_BASE		0x51001000
> +#define RZN1_TIMER0_SIZE		0x400		/* 1 KB */
> +#define RZN1_TIMER1_BASE		0x51002000
> +#define RZN1_TIMER1_SIZE		0x400		/* 1 KB */
> +#define RZN1_WATCHDOGSAFE0_BASE		0x51003000
> +#define RZN1_WATCHDOGSAFE0_SIZE		0x400		/* 1 KB */
> +#define RZN1_WATCHDOGSAFE1_BASE		0x51004000
> +#define RZN1_WATCHDOGSAFE1_SIZE		0x400		/* 1 KB */
> +#define RZN1_CLKMONITORING_BASE		0x51005000
> +#define RZN1_CLKMONITORING_SIZE		0x400		/* 1 KB */
> +#define RZN1_RESET_BASE			0x51006000
> +#define RZN1_RESET_SIZE			0x400		/* 1 KB */
> +#define RZN1_CAN0_BASE			0x52104000
> +#define RZN1_CAN0_SIZE			0x800		/* 2 KB */
> +#define RZN1_CAN1_BASE			0x52105000
> +#define RZN1_CAN1_SIZE			0x800		/* 2 KB */
> +#define RZN1_SEMAPHORE_BASE		0x53000000
> +#define RZN1_SEMAPHORE_SIZE		0x4000		/* 16 KB */
> +#define RZN1_LCD_BASE			0x53004000
> +#define RZN1_LCD_SIZE			0x1000		/* 4 KB */
> +#define RZN1_V_DDR_BASE			0x80000000
> +#define RZN1_V_QSPI1_BASE		0xA0000000	/* RZ/N1S only */
> +#define RZN1_V_QSPI1_SIZE		0x10000000	/* 256 MB */
> +
> +#endif /* __RZN1_MEMORY_MAP_H__ */
> diff --git a/include/soc/rzn1/sysctrl.h b/include/soc/rzn1/sysctrl.h
> new file mode 100644
> index 0000000..01db08f
> --- /dev/null
> +++ b/include/soc/rzn1/sysctrl.h
> @@ -0,0 +1,736 @@
> +/*
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + * All rights reserved.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
> + */
> +
> +#ifndef __RZN1_SYSCTRL_H__
> +#define __RZN1_SYSCTRL_H__
> +
> +#include <linux/io.h>
> +#include <dt-bindings/soc/renesas,rzn1-map.h>
> +
> +/*
> + * Auto-generated from SYSCTRL_ipxact.xml
> + */
> +#define RZN1_SYSCTRL_REG_CFG_USB		0x0
> +#define RZN1_SYSCTRL_REG_CFG_USB_DIRPD			0
> +#define RZN1_SYSCTRL_REG_CFG_USB_H2MODE			1
> +#define RZN1_SYSCTRL_REG_CFG_USB_FRCLK48MOD		2
> +#define RZN1_SYSCTRL_REG_OPMODE			0x4
> +#define RZN1_SYSCTRL_REG_OPMODE_DDRMOD			0
> +#define RZN1_SYSCTRL_REG_OPMODE_OPPMOD			1
> +#define RZN1_SYSCTRL_REG_OPMODE_CA7BOOTSRC		2
> +#define RZN1_SYSCTRL_REG_OPMODE_CA7BOOTSRC_MASK		0xc
> +#define RZN1_SYSCTRL_REG_OPMODE_CM3BOOTSEL		4
> +#define RZN1_SYSCTRL_REG_OPMODE_LCD2PU			5
> +#define RZN1_SYSCTRL_REG_OPMODE_LCD1PU			6
> +#define RZN1_SYSCTRL_REG_CFG_SDIO0		0x8
> +#define RZN1_SYSCTRL_REG_CFG_SDIO0_BASECLKFREQ		0
> +#define RZN1_SYSCTRL_REG_CFG_SDIO0_BASECLKFREQ_MASK	0xff
> +#define RZN1_SYSCTRL_REG_CFG_SDIO0_SLOTTYPE		8
> +#define RZN1_SYSCTRL_REG_CFG_SDIO0_SLOTTYPE_MASK	0x300
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0		0xc
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0_CLKEN_B		4
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SDIO0		0x10
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SDIO0_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SDIO0_MIRACK_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SDIO0_MISTAT_A		2
> +#define RZN1_SYSCTRL_REG_DBGCON			0x14
> +#define RZN1_SYSCTRL_REG_DBGCON_PR_DBG_EN		0
> +#define RZN1_SYSCTRL_REG_DBGCON_CM3WD_DBG_EN		1
> +#define RZN1_SYSCTRL_REG_DBGCON_CA7WD0_DBG_EN		2
> +#define RZN1_SYSCTRL_REG_DBGCON_CA7WD1_DBG_EN		3
> +#define RZN1_SYSCTRL_REG_SYSSTAT		0x18
> +#define RZN1_SYSCTRL_REG_SYSSTAT_CA7_STANDBYWFE		0
> +#define RZN1_SYSCTRL_REG_SYSSTAT_CA7_STANDBYWFE_MASK	0x3
> +#define RZN1_SYSCTRL_REG_SYSSTAT_CA7_STANDBYWFI		2
> +#define RZN1_SYSCTRL_REG_SYSSTAT_CA7_STANDBYWFI_MASK	0xc
> +#define RZN1_SYSCTRL_REG_SYSSTAT_CA7_STANDBYWFIL2	4
> +#define RZN1_SYSCTRL_REG_SYSSTAT_CA7_COREVDDON		5
> +#define RZN1_SYSCTRL_REG_SYSSTAT_PKGMODE		6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB		0x1c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB_MIREQ_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB_CLKEN_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB_MIREQ_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB_CLKEN_C		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB_CLKEN_E		6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_USB_RSTN_F		7
> +#define RZN1_SYSCTRL_REG_PWRSTAT_USB		0x20
> +#define RZN1_SYSCTRL_REG_PWRSTAT_USB_MIRACK_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_USB_MISTAT_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_USB_MIRACK_B		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_USB_MISTAT_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CRYPTO		0x24
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CRYPTO_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CRYPTO_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CRYPTO_MIREQ_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CRYPTO_CLKEN_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CRYPTO_RSTN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CRYPTO_SLVRDY_B	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CRYPTO_RSTN_A_ZERO	6
> +#define RZN1_SYSCTRL_REG_PWRSTAT_CRYPTO		0x28
> +#define RZN1_SYSCTRL_REG_PWRSTAT_CRYPTO_MIRACK_A	0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_CRYPTO_MISTAT_A	1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_CRYPTO_SCON_B		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MSEBI		0x2c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MSEBI_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MSEBI_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MSEBI_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MSEBI_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MSEBI_CLKEN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MSEBI_RSTN_B		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MSEBI_SLVRDY_B		6
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MSEBI		0x30
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MSEBI_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MSEBI_MIRACK_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MSEBI_MISTAT_A		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MSEBI_SCON_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0		0x34
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_SLVRDY_B		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_C		6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_C		7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_SLVRDY_C		8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_D		9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_D		10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_SLVRDY_D		11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_E		12
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_E		13
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_SLVRDY_E		14
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_F		15
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_F		16
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_SLVRDY_F		17
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_H1		18
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_H1		19
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_H2		20
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_H2		21
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_I1		22
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_I1		23
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_I2		24
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_I2		25
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_J1		26
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_J1		27
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_CLKEN_J2		28
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_RSTN_J2		29
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_0_UARTCLKSEL	30
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0		0x38
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_B		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_C		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_D		3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_E		4
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_F		5
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_N		6
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_O		7
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_P		8
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG0_SCON_R		9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1		0x3c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_CLKEN_N		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_RSTN_N		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_SLVRDY_N		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_CLKEN_O		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_RSTN_O		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_SLVRDY_O		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_CLKEN_K		6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_RSTN_K		7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_CLKEN_L		8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_RSTN_L		9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_CLKEN_M		10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_RSTN_M		11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_CLKEN_P		12
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_RSTN_P		13
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_SLVRDY_P		14
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_CLKEN_R		15
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_RSTN_R		16
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_1_SLVRDY_R		17
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1	0x40
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_A	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_A	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_B	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_B	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_C	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_C		7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_C	8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_D	9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_D		10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_D	11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_E	12
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_E		13
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_E	14
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_F	15
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_F		16
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_F	17
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_G	18
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_G		19
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_G	20
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_H	21
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_H		22
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_H	23
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_I	24
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_I		25
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_I	26
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_CLKEN_J	27
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_RSTN_J		28
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW1_SLVRDY_J	29
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2	0x44
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_CLKEN_K	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_RSTN_K		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_SLVRDY_K	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_CLKEN_L	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_RSTN_L		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_SLVRDY_L	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_CLKEN_M	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_RSTN_M		7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_SLVRDY_M	8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_CLKEN_N	9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_RSTN_N		10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_SLVRDY_N	11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_CLKEN_O	12
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_RSTN_O		13
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_SLVRDY_O	14
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_CLKEN_P	15
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_RSTN_P		16
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_FW2_SLVRDY_P	17
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6DIV	0x48
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6DIV_DIV	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6DIV_DIV_MASK	0x7f
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6DIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA		0x4c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA_CLKEN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA_RSTN_B		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA_SLVRDY_B		6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DMA_MIREQ_B		7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASH		0x50
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASH_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASH_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASH_SLVRDY_A	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASH_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASH_CLKEN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASH_RSTN_B		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0		0x54
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0_CLKEN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0_RSTN_B		5
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DMA		0x58
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DMA_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DMA_MIRACK_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DMA_MISTAT_A		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DMA_SCON_B		3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DMA_MIRACK_B		4
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DMA_MISTAT_B		5
> +#define RZN1_SYSCTRL_REG_PWRSTAT_NFLASH		0x5c
> +#define RZN1_SYSCTRL_REG_PWRSTAT_NFLASH_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_NFLASH_MIRACK_A	1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_NFLASH_MISTAT_A	2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_QSPI0		0x60
> +#define RZN1_SYSCTRL_REG_PWRSTAT_QSPI0_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_QSPI0_MIRACK_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_QSPI0_MISTAT_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1DIV	0x64
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1DIV_DIV_MASK	0x7f
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1DIV_BUSY		31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DDRC		0x64
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DDRC_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DDRC_MIREQ_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DDRC_RSTN_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DDRC_CLKEN_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_DDRC_RSTN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_EETH		0x68
> +#define RZN1_SYSCTRL_REG_PWRCTRL_EETH_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_EETH_CLKEN_B		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_EETH_CLKEN_C		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC0		0x6c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC0_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC0_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC0_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC0_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC1		0x70
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC1_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC1_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC1_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_MAC1_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DDRC		0x74
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DDRC_MIRACK_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_DDRC_MISTAT_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MAC0		0x78
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MAC0_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MAC0_MIRACK_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MAC0_MISTAT_A		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MAC1		0x7c
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MAC1_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MAC1_MIRACK_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_MAC1_MISTAT_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ECAT		0x80
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ECAT_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ECAT_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ECAT_MIREQ_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ECAT_CLKEN_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ECAT_RSTN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ECAT_CLKEN_C		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SERCOS		0x84
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SERCOS_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SERCOS_MIREQ_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SERCOS_RSTN_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SERCOS_RSTN_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SERCOS_CLKEN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SERCOS_CLKEN_C		5
> +#define RZN1_SYSCTRL_REG_PWRSTAT_ECAT		0x88
> +#define RZN1_SYSCTRL_REG_PWRSTAT_ECAT_MIRACK_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_ECAT_MISTAT_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SERCOS		0x8c
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SERCOS_MIRACK_A	0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SERCOS_MISTAT_A	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1		0x90
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1_CLKEN_B		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI1_RSTN_B		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HSR		0x90
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HSR_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HSR_MIREQ_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HSR_RSTN_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HSR_CLKEN_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HSR_CLKEN_C		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HSR_RSTN_C		5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHDIV	0x94
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHDIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHDIV_DIV_MASK	0x7f
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHDIV_BUSY		31
> +#define RZN1_SYSCTRL_REG_PWRSTAT_QSPI1		0x98
> +#define RZN1_SYSCTRL_REG_PWRSTAT_QSPI1_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_QSPI1_MIRACK_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_QSPI1_MISTAT_A		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_HSR		0x98
> +#define RZN1_SYSCTRL_REG_PWRSTAT_HSR_MIRACK_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_HSR_MISTAT_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SWITCH		0x9c
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SWITCH_SCON_A		0
> +#define RZN1_SYSCTRL_REG_CFG_DMAMUX		0xa0
> +/* DMAMUX_D1MX0 to DMAMUX_D2MX15 */
> +#define RZN1_SYSCTRL_REG_CFG_DMAMUX_D(_d, _m) (((_d) * 16) + (_m))
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_PTEN_1A	0xa4
> +#define RZN1_SYSCTRL_REG_RSTSTAT		0xa8
> +#define RZN1_SYSCTRL_REG_RSTSTAT_WDA7RST_ST		1
> +#define RZN1_SYSCTRL_REG_RSTSTAT_WDA7RST_ST_MASK	0x6
> +#define RZN1_SYSCTRL_REG_RSTSTAT_WDM3RST_ST		3
> +#define RZN1_SYSCTRL_REG_RSTSTAT_CM3LOCKUPRST_ST	4
> +#define RZN1_SYSCTRL_REG_RSTSTAT_CM3SYSRESET_ST		5
> +#define RZN1_SYSCTRL_REG_RSTSTAT_SWRST_ST		6
> +#define RZN1_SYSCTRL_REG_RSTSTAT_PORRST_ST		31
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_PTEN_1B	0xb0
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_PTEN_2A	0xb4
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_PTEN_2B	0xb8
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC		0xbc
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC_TRIG0		0
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC_TRIG0_MASK	0x1f
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC_TRIG1		8
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC_TRIG1_MASK	0x1f00
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC_TRIG2		16
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC_TRIG2_MASK	0x1f0000
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC_TRIG3		24
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_TSRC_TRIG3_MASK	0x1f000000
> +#define RZN1_SYSCTRL_REG_USBSTAT		0xc0
> +#define RZN1_SYSCTRL_REG_USBSTAT_PLL_LOCK		0
> +#define RZN1_SYSCTRL_REG_CFG_SDIO1		0xc4
> +#define RZN1_SYSCTRL_REG_CFG_SDIO1_BASECLKFREQ		0
> +#define RZN1_SYSCTRL_REG_CFG_SDIO1_BASECLKFREQ_MASK	0xff
> +#define RZN1_SYSCTRL_REG_CFG_SDIO1_SLOTTYPE		8
> +#define RZN1_SYSCTRL_REG_CFG_SDIO1_SLOTTYPE_MASK	0x300
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1		0xc8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1_MIREQ_A		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1_CLKEN_B		4
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SDIO1		0xcc
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SDIO1_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SDIO1_MIRACK_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SDIO1_MISTAT_A		2
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT	0xd0
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT_F_SEC	0
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT_I_SEC	1
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT_Z_SEC	2
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT_YD_SEC	3
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT_YC_SEC	4
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT_YS_SEC	5
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT_CSA_SEC	6
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_INIT_CSB_SEC	7
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG	0xd4
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_UA_SEC	0
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_UB_SEC	1
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_J_SEC	2
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_K_SEC	3
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_NA_SEC	4
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_NB_SEC	5
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_QA_SEC	6
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_QB_SEC	7
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_RA_SEC	8
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_PC_SEC	9
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_MA_SEC	10
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_MB_SEC	11
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_MC_SEC	12
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_MD_SEC	13
> +#define RZN1_SYSCTRL_REG_CFG_FW_STATIC_TZA_TARG_W_SEC	14
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_PTEN_3A	0xd8
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_PTEN_3B	0xdc
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_PTEN_3B_PORTEN	0
> +#define RZN1_SYSCTRL_REG_CFG_GPIOT_PTEN_3B_PORTEN_MASK	0x3ff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_OPPDIV		0xe0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_OPPDIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_OPPDIV_DIV_MASK	0x1f
> +#define RZN1_SYSCTRL_REG_PWRCTRL_OPPDIV_BUSY		31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CA7DIV		0xe4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CA7DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CA7DIV_DIV_MASK	0x7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CA7DIV_BUSY		31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ	0xe8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_CLKEN_Q	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_RSTN_Q	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_SLVRDY_Q	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_CLKEN_R	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_RSTN_R	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_SLVRDY_R	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_CLKEN_S	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_RSTN_S	7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_SLVRDY_S	8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_CLKEN_T	9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_RSTN_T	10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_SLVRDY_T	11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_CLKEN_U	12
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_RSTN_U	13
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_SLVRDY_U	14
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_CLKEN_V	15
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_RSTN_V	16
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_SLVRDY_V	17
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_CLKEN_W	18
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_RSTN_W	19
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_SLVRDY_W	20
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_CLKEN_X	21
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_RSTN_X	22
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG2_25MHZ_SLVRDY_X	23
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2	0xec
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AG1	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AG1	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AG2	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AG2	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AH1	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AH1	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AH2	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AH2	7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AI1	8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AI1	9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AI2	10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AI2	11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AJ1	12
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AJ1	13
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AJ2	14
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AJ2	15
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AK1	16
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AK1	17
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AK2	18
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AK2	19
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AL1	20
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AL1	21
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_CLKEN_AL2	22
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_RSTN_AL2	23
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2_UARTCLKSEL	24
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ	0xf0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_CLKEN_Y	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_RSTN_Y	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_SLVRDY_Y	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_CLKEN_Z	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_RSTN_Z	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_SLVRDY_Z	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_CLKEN_AA	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_RSTN_AA	7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_SLVRDY_AA	8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_CLKEN_AB	9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_RSTN_AB	10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_SLVRDY_AB	11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_CLKEN_UF	12
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_RSTN_UF	13
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG3_48MHZ_MIREQ_UF	14
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW		0xf4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_CLKEN_AC	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_RSTN_AC		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_SLVRDY_AC	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_CLKEN_AD	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_RSTN_AD		4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_SLVRDY_AD	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_CLKEN_AE	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_RSTN_AE		7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_SLVRDY_AE	8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_CLKEN_AF	9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_RSTN_AF		10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_SLVRDY_AF	11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_CLKEN_UI	12
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_RSTN_UI		13
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_FW_MIREQ_UI	14
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2DIV	0xf8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2DIV_DIV_MASK	0xff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR2DIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3	0xfc
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3_CLKEN_AM	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3_RSTN_AM	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3_CLKEN_AN	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3_RSTN_AN	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3_CLKEN_AO	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3_RSTN_AO	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3_CLKEN_AP	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3_RSTN_AP	7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3DIV	0x100
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3DIV_DIV_MASK	0xff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR3DIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4	0x104
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4_CLKEN_AQ	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4_RSTN_AQ	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4_CLKEN_AR	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4_RSTN_AR	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4_CLKEN_AS	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4_RSTN_AS	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4_CLKEN_AT	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4_RSTN_AT	7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4DIV	0x108
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4DIV_DIV_MASK	0xff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG1_PR4DIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1	0x10c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1_CLKEN_AU	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1_RSTN_AU	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1_CLKEN_AV	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1_RSTN_AV	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1_CLKEN_AW	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1_RSTN_AW	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1_CLKEN_AX	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1_RSTN_AX	7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1DIV	0x110
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1DIV_DIV_MASK	0xff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG4_PR1DIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6	0x114
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_CLKEN_BC	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_RSTN_BC	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_SLVRDY_BC	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_CLKEN_BD	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_RSTN_BD	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_SLVRDY_BD	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_CLKEN_BE	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_RSTN_BE	7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_SLVRDY_BE	8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_CLKEN_BF	9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_RSTN_BF	10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PGEXT2_PR6_SLVRDY_BF	11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5	0x118
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_CLKEN_AZ	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_RSTN_AZ	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_SLVRDY_AZ	5
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_CLKEN_BA	6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_RSTN_BA	7
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_SLVRDY_BA	8
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_CLKEN_BB	9
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_RSTN_BB	10
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5_SLVRDY_BB	11
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5DIV	0x11c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5DIV_DIV_MASK	0x7f
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG5_PR5DIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_RSTEN			0x120
> +#define RZN1_SYSCTRL_REG_RSTEN_MRESET_EN		0
> +#define RZN1_SYSCTRL_REG_RSTEN_WDA7RST_EN		1
> +#define RZN1_SYSCTRL_REG_RSTEN_WDA7RST_EN_MASK		0x6
> +#define RZN1_SYSCTRL_REG_RSTEN_WDM3RST_EN		3
> +#define RZN1_SYSCTRL_REG_RSTEN_CM3LOCKUPRST_EN		4
> +#define RZN1_SYSCTRL_REG_RSTEN_CM3SYSRESET_EN		5
> +#define RZN1_SYSCTRL_REG_RSTEN_SWRST_EN			6
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0DIV	0x124
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0DIV_DIV_MASK	0x7f
> +#define RZN1_SYSCTRL_REG_PWRCTRL_QSPI0DIV_BUSY		31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0DIV	0x128
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0DIV_DIV_MASK	0xff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO0DIV_BUSY		31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1DIV	0x12c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1DIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1DIV_DIV_MASK	0xff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SDIO1DIV_BUSY		31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCH		0x130
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCH_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCH_SLVRDY_A	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCH_CLKEN_B		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCH_RSTN_B		3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_ADCDIV	0x134
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_ADCDIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_ADCDIV_DIV_MASK	0x3ff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_ADCDIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_I2CDIV	0x138
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_I2CDIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_I2CDIV_DIV_MASK	0x7f
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_I2CDIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_UARTDIV	0x13c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_UARTDIV_DIV	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_UARTDIV_DIV_MASK	0xff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_UARTDIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RTC		0x140
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RTC_CLKEN_RTC		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RTC_RST_RTC		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RTC_IDLE_REQ		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RTC_RSTN_FW_RTC	3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_RTC		0x144
> +#define RZN1_SYSCTRL_REG_PWRSTAT_RTC_RTC_IACK		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_RTC_RTC_IDLE		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_RTC_PWR_GOOD		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASHDIV	0x148
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASHDIV_DIV		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASHDIV_DIV_MASK	0x7f
> +#define RZN1_SYSCTRL_REG_PWRCTRL_NFLASHDIV_BUSY		31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_MOTORDIV	0x150
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_MOTORDIV_DIV	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_MOTORDIV_DIV_MASK	0xf
> +#define RZN1_SYSCTRL_REG_PWRCTRL_PG0_MOTORDIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ROM		0x154
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ROM_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ROM_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_ROM_SLVRDY_A		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW		0x158
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_B		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_C		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_D		3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_E		4
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_F		5
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_G		6
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_H		7
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_I		8
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_J		9
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_K		10
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_L		11
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_M		12
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_N		13
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_O		14
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG1_FW_SCON_P		15
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ	0x15c
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ_SCON_Q	0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ_SCON_R	1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ_SCON_S	2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ_SCON_T	3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ_SCON_U	4
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ_SCON_V	5
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ_SCON_W	6
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG2_25MHZ_SCON_X	7
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG3_48MHZ	0x160
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG3_48MHZ_SCON_Y	0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG3_48MHZ_SCON_Z	1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG3_48MHZ_SCON_AA	2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG3_48MHZ_SCON_AB	3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG3_48MHZ_MIRACK_UF	4
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG3_48MHZ_MISTAT_UF	5
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG4_FW		0x164
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG4_FW_SCON_AC		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG4_FW_SCON_AD		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG4_FW_SCON_AE		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG4_FW_SCON_AF		3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG4_FW_MIRACK_UI	4
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG4_FW_MISTAT_UI	5
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG5_PR5	0x168
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG5_PR5_SCON_AZ	1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG5_PR5_SCON_BA	2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PG5_PR5_SCON_BB	3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PGEXT2_PR6	0x16c
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PGEXT2_PR6_SCON_BC	0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PGEXT2_PR6_SCON_BD	1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PGEXT2_PR6_SCON_BE	2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_PGEXT2_PR6_SCON_BF	3
> +#define RZN1_SYSCTRL_REG_PWRSTAT_ROM		0x170
> +#define RZN1_SYSCTRL_REG_PWRSTAT_ROM_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CM3		0x174
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CM3_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CM3_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_CM3_MIREQ_A		2
> +#define RZN1_SYSCTRL_REG_PWRSTAT_CM3		0x178
> +#define RZN1_SYSCTRL_REG_PWRSTAT_CM3_MIRACK_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_CM3_MISTAT_A		1
> +#define RZN1_SYSCTRL_REG_PWRSTAT_RINCTRL	0x17c
> +#define RZN1_SYSCTRL_REG_PWRSTAT_RINCTRL_SCON_A		0
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SWITCHCTRL	0x180
> +#define RZN1_SYSCTRL_REG_PWRSTAT_SWITCHCTRL_SCON_A	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RINCTRL	0x184
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RINCTRL_CLKEN_A	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RINCTRL_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_RINCTRL_SLVRDY_A	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHCTRL	0x188
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHCTRL_CLKEN_A	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHCTRL_RSTN_A	1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHCTRL_SLVRDY_A	2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHCTRL_RSTN_CLK25	3
> +#define RZN1_SYSCTRL_REG_PWRCTRL_SWITCHCTRL_RSTN_ETH	4
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HWRTOS		0x18c
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HWRTOS_CLKEN_A		0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HWRTOS_RSTN_A		1
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HWRTOS_CLKEN_B		2
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HWRTOS_MDCDIV	0x190
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HWRTOS_MDCDIV_DIV	0
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HWRTOS_MDCDIV_DIV_MASK	0x3ff
> +#define RZN1_SYSCTRL_REG_PWRCTRL_HWRTOS_MDCDIV_BUSY	31
> +#define RZN1_SYSCTRL_REG_RSTCTRL		0x198
> +#define RZN1_SYSCTRL_REG_RSTCTRL_WDA7RST_REQ		1
> +#define RZN1_SYSCTRL_REG_RSTCTRL_WDA7RST_REQ_MASK	0x6
> +#define RZN1_SYSCTRL_REG_RSTCTRL_WDM3RST_REQ		3
> +#define RZN1_SYSCTRL_REG_RSTCTRL_CM3LOCKUPRST_REQ	4
> +#define RZN1_SYSCTRL_REG_RSTCTRL_CM3SYSRESET_REQ	5
> +#define RZN1_SYSCTRL_REG_RSTCTRL_SWRST_REQ		6
> +#define RZN1_SYSCTRL_REG_VERSION		0x19c
> +#define RZN1_SYSCTRL_REG_VERSION_MINOR			0
> +#define RZN1_SYSCTRL_REG_VERSION_MINOR_MASK		0xf
> +#define RZN1_SYSCTRL_REG_VERSION_MAJOR			4
> +#define RZN1_SYSCTRL_REG_VERSION_MAJOR_MASK		0xf0
> +#define RZN1_SYSCTRL_REG_VERSION_PROD			8
> +#define RZN1_SYSCTRL_REG_BOOTADDR		0x204
> +
> +#define RZN1_SYSCTRL_REGSIZE			520
> +
> +/*
> + * Get the base address for the sysctrl block.
> + * Ensure use does not conflict with anything else that acesses the SYSCTRL
> + */
> +void __iomem *rzn1_sysctrl_base(void);
> +
> +static inline u32 rzn1_sysctrl_readl(u32 reg)
> +{
> +	BUG_ON(reg >= RZN1_SYSTEM_CTRL_SIZE);
> +	return readl(rzn1_sysctrl_base() + reg);
> +}
> +
> +static inline void rzn1_sysctrl_writel(u32 value, u32 reg)
> +{
> +	BUG_ON(reg >= RZN1_SYSTEM_CTRL_SIZE);
> +	writel(value, rzn1_sysctrl_base() + reg);
> +}
> +
> +#endif /* __RZN1_SYSCTRL_H__ */
> -- 
> 2.7.4
> 
