Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeDJRAQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:00:16 -0400
Received: from foss.arm.com ([217.140.101.70]:40844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeDJRAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:00:14 -0400
Subject: Re: [PATCH v8 2/3] mtd: spi-nor: add rockchip serial flash controller
 driver
To: Andy Yan <andy.yan@rock-chips.com>, cyrille.pitchen@wedev4u.fr,
        mchehab@kernel.org, robh+dt@kernel.org, linux-mtd@lists.infradead.org,
        shawn.lin@rock-chips.com, heiko@sntech.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        boris.brezillon@free-electrons.com
References: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
 <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <063beb0b-d6a1-c9da-6917-fda1184d50e2@arm.com>
Date: Tue, 10 Apr 2018 18:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, Shawn,

I saw mention of DMA while skimming through LAKML, so you win a drive-by 
review :)

On 08/02/18 12:18, Andy Yan wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Add Rockchip SFC(serial flash controller) driver.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> 
> ---
> 
> Changes in v8:
> - remove unused macro SFC_CMD_TRAN_BYTES_MASK
> - set max transfer length to 15.5KB
> - remove unnecessary buffer align check
> - remove the duplicate logic what spi-nor.c already does for spi_nor_write
> - add spi_nor_erase, as the SFC should get the erase address.
> 
> Changes in v7:
> - correct the fifo status check in pio read/write mode.
> - copy data from user buffer to dma buffer
> 
> Changes in v6:
> - fold in Andy's improvement for checking fifo level
>    before pio read
> - rename the controller to rv1108 since offically it's
>    renamed and acked by Rob.
> - use dma_coerce_mask_and_coherent suggested by Andy.
> 
> Changes in v5:
> - check if the buf is aligned to 32bit
> - check if the buf for dma comes from vmalloc
> - fix to use 1-1-n according to the current framework
> - avoid bytes cnt overflow
> 
> Changes in v4:
> - use uppercase DMA for description
> - simplify the code of get_if_type
> - use dma_dir to simplify the code
> - simplify the rockchip_sfc_do_rd_wr
> - some minor improvements
> - add reset controller when doing resume
> 
> Changes in v3:
> - use io{read32,write32}_rep to simplify the corner cases
> - remove more unnecessary bit definitions
> - some minor comment fixes and improvement
> - fix wrong unregister function
> - unify more code
> - use nor to avoid constantly replicating the whole
>    sfc->flash[sfc->num_chip].nor
> - add email for MODULE_AUTHOR
> - remove #if 1 --- #endif
> - extract DMA code to imporve the code structure
> - reset all when failing to do dma
> - pass sfc to get_if_type
> - rename sfc-no-dma to sfc-no-DMA
> 
> Changes in v2:
> - fix typos
> - add some comment for buffer and others operations
> - rename SFC_MAX_CHIP_NUM to MAX_CHIPSELECT_NUM
> - use u8 for cs
> - return -EINVAL for default case of get_if_type
> - use readl_poll_*() to check timeout cases
> - simplify and clarify some condition checks
> - rework the bitshifts to simplify the code
> - define SFC_CMD_DUMMY(x)
> - fix ummap for dma read path and finish all the
>    cache maintenance.
> - rename to rockchip_sfc_chip_priv and embed struct spi_nor
>    in it.
> - add MODULE_AUTHOR
> - add runtime PM and general PM support.
> - Thanks for Marek's comments. Link:
>    http://lists.infradead.org/pipermail/linux-mtd/2016-November/070321.html
> 
>   MAINTAINERS                        |   9 +
>   drivers/mtd/spi-nor/Kconfig        |   7 +
>   drivers/mtd/spi-nor/Makefile       |   1 +
>   drivers/mtd/spi-nor/rockchip-sfc.c | 942 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 959 insertions(+)
>   create mode 100644 drivers/mtd/spi-nor/rockchip-sfc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa71ab52f..0718bc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11704,6 +11704,15 @@ F:	drivers/gpio/gpio-bd9571mwv.c
>   F:	include/linux/mfd/bd9571mwv.h
>   F:	Documentation/devicetree/bindings/mfd/bd9571mwv.txt
>   
> +ROCKCHIP SERIAL FLASH CONTROLLER DRIVER
> +M:	Shawn Lin <shawn.lin@rock-chips.com>
> +M:	Andy Yan <andy.yan@rock-chips.com>
> +L:	linux-mtd@lists.infradead.org
> +L:	linux-rockchip@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mtd/rockchip-sfc.txt
> +F:	drivers/mtd/spi-nor/rockchip-sfc.c
> +
>   ROSE NETWORK LAYER
>   M:	Ralf Baechle <ralf@linux-mips.org>
>   L:	linux-hams@vger.kernel.org
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index 89da88e..f2898ea 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -129,4 +129,11 @@ config SPI_STM32_QUADSPI
>   	  This enables support for the STM32 Quad SPI controller.
>   	  We only connect the NOR to this controller.
>   
> +config SPI_ROCKCHIP_SFC
> +	tristate "Rockchip Serial Flash Controller(SFC)"
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on HAS_IOMEM && HAS_DMA
> +	help
> +	  This enables support for rockchip serial flash controller.
> +
>   endif # MTD_SPI_NOR
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index f4c61d2..c294156 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
>   obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
>   obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+= intel-spi-platform.o
>   obj-$(CONFIG_SPI_STM32_QUADSPI)	+= stm32-quadspi.o
> +obj-$(CONFIG_SPI_ROCKCHIP_SFC) += rockchip-sfc.o
> diff --git a/drivers/mtd/spi-nor/rockchip-sfc.c b/drivers/mtd/spi-nor/rockchip-sfc.c
> new file mode 100644
> index 0000000..6037101
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/rockchip-sfc.c
> @@ -0,0 +1,942 @@
> +/*
> + * Rockchip Serial Flash Controller Driver
> + *
> + * Copyright (c) 2017, Rockchip Inc.
> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/spi-nor.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +/* System control */
> +#define SFC_CTRL			0x0
> +#define  SFC_CTRL_COMMON_BITS_1		0x0
> +#define  SFC_CTRL_COMMON_BITS_2		0x1
> +#define  SFC_CTRL_COMMON_BITS_4		0x2
> +#define  SFC_CTRL_DATA_BITS_SHIFT	12
> +#define  SFC_CTRL_ADDR_BITS_SHIFT	10
> +#define  SFC_CTRL_CMD_BITS_SHIFT	8
> +#define  SFC_CTRL_PHASE_SEL_NEGETIVE	BIT(1)
> +
> +/* Interrupt mask */
> +#define SFC_IMR				0x4
> +#define  SFC_IMR_RX_FULL		BIT(0)
> +#define  SFC_IMR_RX_UFLOW		BIT(1)
> +#define  SFC_IMR_TX_OFLOW		BIT(2)
> +#define  SFC_IMR_TX_EMPTY		BIT(3)
> +#define  SFC_IMR_TRAN_FINISH		BIT(4)
> +#define  SFC_IMR_BUS_ERR		BIT(5)
> +#define  SFC_IMR_NSPI_ERR		BIT(6)
> +#define  SFC_IMR_DMA			BIT(7)
> +
> +/* Interrupt clear */
> +#define SFC_ICLR			0x8
> +#define  SFC_ICLR_RX_FULL		BIT(0)
> +#define  SFC_ICLR_RX_UFLOW		BIT(1)
> +#define  SFC_ICLR_TX_OFLOW		BIT(2)
> +#define  SFC_ICLR_TX_EMPTY		BIT(3)
> +#define  SFC_ICLR_TRAN_FINISH		BIT(4)
> +#define  SFC_ICLR_BUS_ERR		BIT(5)
> +#define  SFC_ICLR_NSPI_ERR		BIT(6)
> +#define  SFC_ICLR_DMA			BIT(7)
> +
> +/* FIFO threshold level */
> +#define SFC_FTLR			0xc
> +#define  SFC_FTLR_TX_SHIFT		0
> +#define  SFC_FTLR_TX_MASK		0x1f
> +#define  SFC_FTLR_RX_SHIFT		8
> +#define  SFC_FTLR_RX_MASK		0x1f
> +
> +/* Reset FSM and FIFO */
> +#define SFC_RCVR			0x10
> +#define  SFC_RCVR_RESET			BIT(0)
> +
> +/* Enhanced mode */
> +#define SFC_AX				0x14
> +
> +/* Address Bit number */
> +#define SFC_ABIT			0x18
> +
> +/* Interrupt status */
> +#define SFC_ISR				0x1c
> +#define  SFC_ISR_RX_FULL_SHIFT		BIT(0)
> +#define  SFC_ISR_RX_UFLOW_SHIFT		BIT(1)
> +#define  SFC_ISR_TX_OFLOW_SHIFT		BIT(2)
> +#define  SFC_ISR_TX_EMPTY_SHIFT		BIT(3)
> +#define  SFC_ISR_TX_FINISH_SHIFT	BIT(4)
> +#define  SFC_ISR_BUS_ERR_SHIFT		BIT(5)
> +#define  SFC_ISR_NSPI_ERR_SHIFT		BIT(6)
> +#define  SFC_ISR_DMA_SHIFT		BIT(7)
> +
> +/* FIFO status */
> +#define SFC_FSR				0x20
> +#define  SFC_FSR_TX_IS_FULL		BIT(0)
> +#define  SFC_FSR_TX_IS_EMPTY		BIT(1)
> +#define  SFC_FSR_RX_IS_EMPTY		BIT(2)
> +#define  SFC_FSR_RX_IS_FULL		BIT(3)
> +#define  SFC_FSR_TXLV_MASK		GENMASK(12, 8)
> +#define  SFC_FSR_TXLV_SHIFT		8
> +#define  SFC_FSR_RXLV_MASK		GENMASK(20, 16)
> +#define  SFC_FSR_RXLV_SHIFT		16
> +
> +/* FSM status */
> +#define SFC_SR				0x24
> +#define  SFC_SR_IS_IDLE			0x0
> +#define  SFC_SR_IS_BUSY			0x1
> +
> +/* Raw interrupt status */
> +#define SFC_RISR			0x28
> +#define  SFC_RISR_RX_FULL		BIT(0)
> +#define  SFC_RISR_RX_UNDERFLOW		BIT(1)
> +#define  SFC_RISR_TX_OVERFLOW		BIT(2)
> +#define  SFC_RISR_TX_EMPTY		BIT(3)
> +#define  SFC_RISR_TRAN_FINISH		BIT(4)
> +#define  SFC_RISR_BUS_ERR		BIT(5)
> +#define  SFC_RISR_NSPI_ERR		BIT(6)
> +#define  SFC_RISR_DMA			BIT(7)
> +
> +/* Master trigger */
> +#define SFC_DMA_TRIGGER			0x80
> +
> +/* Src or Dst addr for master */
> +#define SFC_DMA_ADDR			0x84
> +
> +/* Command */
> +#define SFC_CMD				0x100
> +#define  SFC_CMD_IDX_SHIFT		0
> +#define  SFC_CMD_DUMMY_SHIFT		8
> +#define  SFC_CMD_DIR_RD			0
> +#define  SFC_CMD_DIR_WR			1
> +#define  SFC_CMD_DIR_SHIFT		12
> +#define  SFC_CMD_ADDR_ZERO		(0x0 << 14)
> +#define  SFC_CMD_ADDR_24BITS		(0x1 << 14)
> +#define  SFC_CMD_ADDR_32BITS		(0x2 << 14)
> +#define  SFC_CMD_ADDR_FRS		(0x3 << 14)
> +#define  SFC_CMD_TRAN_BYTES_SHIFT	16
> +#define  SFC_CMD_CS_SHIFT		30
> +
> +/* Address */
> +#define SFC_ADDR			0x104
> +
> +/* Data */
> +#define SFC_DATA			0x108
> +
> +#define SFC_MAX_CHIPSELECT_NUM		4
> +
> +/* The SFC can transfer max 16KB - 1 at one time
> + * we set it to 15.5KB here for alignment.
> + */
> +#define SFC_MAX_TRANS_BYTES		(512 * 31)
> +
> +#define SFC_CMD_DUMMY(x) \
> +	((x) << SFC_CMD_DUMMY_SHIFT)
> +
> +enum rockchip_sfc_iftype {
> +	IF_TYPE_STD,
> +	IF_TYPE_DUAL,
> +	IF_TYPE_QUAD,
> +};
> +
> +struct rockchip_sfc;
> +struct rockchip_sfc_chip_priv {
> +	u8 cs;
> +	u32 clk_rate;
> +	struct spi_nor nor;
> +	struct rockchip_sfc *sfc;
> +};
> +
> +struct rockchip_sfc {
> +	struct device *dev;
> +	struct mutex lock;
> +	void __iomem *regbase;
> +	struct clk *hclk;
> +	struct clk *clk;
> +	/* virtual mapped addr for dma_buffer */
> +	void *buffer;
> +	dma_addr_t dma_buffer;
> +	struct completion cp;
> +	struct rockchip_sfc_chip_priv flash[SFC_MAX_CHIPSELECT_NUM];
> +	u32 num_chip;
> +	bool use_dma;
> +};
> +
> +static int get_if_type(struct rockchip_sfc *sfc, enum spi_nor_protocol proto)
> +{
> +	if (proto == SNOR_PROTO_1_1_2)
> +		return IF_TYPE_DUAL;
> +	else if (proto == SNOR_PROTO_1_1_4)
> +		return IF_TYPE_QUAD;
> +	else if (proto == SNOR_PROTO_1_1_1)
> +		return IF_TYPE_STD;
> +
> +	dev_err(sfc->dev, "unsupported SPI read mode\n");
> +
> +	return -EINVAL;
> +}
> +
> +static int rockchip_sfc_reset(struct rockchip_sfc *sfc)
> +{
> +	int err;
> +	u32 status;
> +
> +	writel_relaxed(SFC_RCVR_RESET, sfc->regbase + SFC_RCVR);
> +
> +	err = readl_poll_timeout(sfc->regbase + SFC_RCVR, status,
> +				 !(status & SFC_RCVR_RESET), 20,
> +				 jiffies_to_usecs(HZ));
> +	if (err)
> +		dev_err(sfc->dev, "SFC reset never finished\n");
> +
> +	/* Still need to clear the masked interrupt from RISR */
> +	writel_relaxed(SFC_ICLR_RX_FULL | SFC_ICLR_RX_UFLOW |
> +		       SFC_ICLR_TX_OFLOW | SFC_ICLR_TX_EMPTY |
> +		       SFC_ICLR_TRAN_FINISH | SFC_ICLR_BUS_ERR |
> +		       SFC_ICLR_NSPI_ERR | SFC_ICLR_DMA,
> +		       sfc->regbase + SFC_ICLR);
> +
> +	dev_info(sfc->dev, "reset\n");

This looks like unhelpful log spam - it's maybe worthy of a dev_dbg(), 
but can probably just go away entirely.

> +
> +	return err;
> +}
> +
> +static int rockchip_sfc_init(struct rockchip_sfc *sfc)
> +{
> +	int err;
> +
> +	err = rockchip_sfc_reset(sfc);
> +	if (err)
> +		return err;
> +
> +	/* Mask all eight interrupts */
> +	writel_relaxed(0xff, sfc->regbase + SFC_IMR);
> +
> +	writel_relaxed(SFC_CTRL_PHASE_SEL_NEGETIVE, sfc->regbase + SFC_CTRL);
> +
> +	return 0;
> +}
> +
> +static int rockchip_sfc_prep(struct spi_nor *nor, enum spi_nor_ops ops)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	int ret;
> +
> +	mutex_lock(&sfc->lock);
> +	pm_runtime_get_sync(sfc->dev);
> +
> +	ret = clk_set_rate(sfc->clk, priv->clk_rate);
> +	if (ret)
> +		goto out;
> +
> +	ret = clk_prepare_enable(sfc->clk);
> +	if (ret)
> +		goto out;
> +
> +	return 0;
> +
> +out:
> +	mutex_unlock(&sfc->lock);
> +	return ret;
> +}
> +
> +static void rockchip_sfc_unprep(struct spi_nor *nor, enum spi_nor_ops ops)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +
> +	clk_disable_unprepare(sfc->clk);
> +	mutex_unlock(&sfc->lock);
> +	pm_runtime_mark_last_busy(sfc->dev);
> +	pm_runtime_put_autosuspend(sfc->dev);
> +}
> +
> +static inline int rockchip_sfc_get_fifo_level(struct rockchip_sfc *sfc, int wr)
> +{
> +	u32 fsr = readl_relaxed(sfc->regbase + SFC_FSR);
> +	int level;
> +
> +	if (wr)
> +		level = (fsr & SFC_FSR_TXLV_MASK) >> SFC_FSR_TXLV_SHIFT;
> +	else
> +		level = (fsr & SFC_FSR_RXLV_MASK) >> SFC_FSR_RXLV_SHIFT;
> +
> +	return level;
> +}
> +
> +static int rockchip_sfc_wait_fifo_ready(struct rockchip_sfc *sfc, int wr, u32 timeout)
> +{
> +	unsigned long deadline = jiffies + timeout;
> +	int level;
> +
> +	while (!(level = rockchip_sfc_get_fifo_level(sfc, wr))) {
> +		if (time_after_eq(jiffies, deadline)) {
> +			dev_warn(sfc->dev, "%s fifo timeout\n", wr ? "write" : "read");
> +			return -ETIMEDOUT;
> +		}
> +		udelay(1);
> +	}
> +
> +	return level;
> +}
> +
> +/* The SFC_CTRL register is a global control register,
> + * when the controller is in busy state(SFC_SR),
> + * SFC_CTRL cannot be set.
> + */
> +static void rockchip_sfc_wait_idle(struct rockchip_sfc *sfc, u32 timeout_us)
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret = readl_poll_timeout(sfc->regbase + SFC_SR, status,
> +				!(status & SFC_SR_IS_BUSY),
> +				20, timeout_us);
> +	if (ret) {
> +		dev_err(sfc->dev, "wait sfc idle timeout\n");
> +		rockchip_sfc_reset(sfc);
> +	}
> +}
> +
> +static void rockchip_sfc_setup_ctrl(struct rockchip_sfc *sfc)
> +{
> +	u32 reg;
> +
> +	reg = IF_TYPE_STD << SFC_CTRL_DATA_BITS_SHIFT;
> +	reg |= IF_TYPE_STD << SFC_CTRL_ADDR_BITS_SHIFT;
> +	reg |= IF_TYPE_STD << SFC_CTRL_CMD_BITS_SHIFT;
> +	reg |= SFC_CTRL_PHASE_SEL_NEGETIVE;
> +
> +	rockchip_sfc_wait_idle(sfc, 10000);
> +
> +	writel_relaxed(reg, sfc->regbase + SFC_CTRL);
> +}
> +static int rockchip_sfc_op_reg(struct spi_nor *nor,
> +			       u8 opcode, int len, u8 optype)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	u32 reg;
> +
> +	rockchip_sfc_setup_ctrl(sfc);
> +
> +	reg = opcode << SFC_CMD_IDX_SHIFT;
> +	reg |= len << SFC_CMD_TRAN_BYTES_SHIFT;
> +	reg |= priv->cs << SFC_CMD_CS_SHIFT;
> +	reg |= optype << SFC_CMD_DIR_SHIFT;
> +	writel_relaxed(reg, sfc->regbase + SFC_CMD);
> +
> +	return 0;
> +}
> +
> +static int rockchip_sfc_write_fifo(struct rockchip_sfc *sfc, u8 *buf, int len)
> +{
> +	u8 bytes = len & 0x3;
> +	u32 dwords;
> +	int tx_level;
> +	u32 write_words;
> +	u32 tmp = 0;
> +
> +	if (len >= 4) {

This outer condition is entirely redundant, because if len < 4 then 
dwords = 0 anyway, thus you'd still skip the inner loop.

> +		dwords = len >> 2;
> +		while (dwords) {
> +			tx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_WR, HZ);
> +			if (tx_level < 0)
> +				return tx_level;
> +			write_words = min_t(u32, tx_level, dwords);
> +			iowrite32_rep(sfc->regbase + SFC_DATA, buf, write_words);

I think strictly you have an endianness issue here; these words get sent 
in native-endian byte order while everything else is explicitly 
little-endian.

> +			buf += write_words << 2;
> +			dwords -= write_words;
> +		}
> +	}
> +
> +	/* write the rest non word aligned bytes */
> +	if (bytes) {
> +		tx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_WR, HZ);
> +		if (tx_level < 0)
> +			return tx_level;
> +		memcpy(&tmp, buf, bytes);
> +		writel_relaxed(tmp, sfc->regbase + SFC_DATA);
> +	}
> +
> +	return len;
> +}
> +
> +static int rockchip_sfc_read_fifo(struct rockchip_sfc *sfc, u8 *buf, int len)
> +{
> +	u8 bytes = len & 0x3;
> +	u32 dwords;
> +	u8 read_words;
> +	int rx_level;
> +	int tmp;
> +
> +	/* word aligned access only */
> +	if (len >= 4) {

As above.

> +		dwords = len >> 2;
> +		while (dwords) {
> +			rx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_RD, HZ);
> +			if (rx_level < 0)
> +				return rx_level;
> +			read_words = min_t(u32, rx_level, dwords);
> +			ioread32_rep(sfc->regbase + SFC_DATA, buf, read_words);

As above.

> +			buf += read_words << 2;
> +			dwords -= read_words;
> +		}
> +	}
> +
> +	/* read the rest non word aligned bytes */
> +	if (bytes) {
> +		rx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_RD, HZ);
> +		if (rx_level < 0)
> +			return rx_level;
> +		tmp = readl_relaxed(sfc->regbase + SFC_DATA);
> +		memcpy(buf, &tmp, bytes);
> +	}
> +
> +	return len;
> +}
> +
> +static int rockchip_sfc_read_reg(struct spi_nor *nor, u8 opcode,
> +				 u8 *buf, int len)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	int ret;
> +	int trans;
> +
> +	trans = min_t(int, len, SFC_MAX_TRANS_BYTES);
> +	ret = rockchip_sfc_op_reg(nor, opcode, trans, SFC_CMD_DIR_RD);
> +	if (ret)
> +		return ret;
> +
> +	ret = rockchip_sfc_read_fifo(sfc, buf, trans);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int rockchip_sfc_write_reg(struct spi_nor *nor, u8 opcode,
> +				  u8 *buf, int len)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	int ret;
> +
> +	ret = rockchip_sfc_op_reg(nor, opcode, len, SFC_CMD_DIR_WR);
> +	if (ret)
> +		return ret;
> +	ret = rockchip_sfc_write_fifo(sfc, buf, len);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int rockchip_sfc_erase(struct spi_nor *nor, loff_t offs)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	u32 reg;
> +
> +	rockchip_sfc_setup_ctrl(sfc);
> +
> +	reg = nor->erase_opcode << SFC_CMD_IDX_SHIFT;
> +	reg |= (nor->addr_width == 4) ?
> +		SFC_CMD_ADDR_32BITS : SFC_CMD_ADDR_24BITS;
> +	reg |= priv->cs << SFC_CMD_CS_SHIFT;
> +	reg |= SFC_CMD_DIR_WR << SFC_CMD_DIR_SHIFT;
> +
> +	writel_relaxed(reg, sfc->regbase + SFC_CMD);
> +
> +	writel_relaxed(offs, sfc->regbase + SFC_ADDR);
> +
> +	return 0;
> +}
> +
> +static int rockchip_sfc_setup_transfer(struct spi_nor *nor,
> +					       loff_t from_to,
> +					       size_t len, u8 op_type)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	u8 if_type = IF_TYPE_STD;
> +	u32 reg;
> +
> +	if (op_type == SFC_CMD_DIR_RD)
> +		if_type = get_if_type(sfc, nor->read_proto);
> +
> +	rockchip_sfc_wait_idle(sfc, 10000);
> +
> +	writel_relaxed((if_type << SFC_CTRL_DATA_BITS_SHIFT) |
> +		       (IF_TYPE_STD << SFC_CTRL_ADDR_BITS_SHIFT) |
> +		       (IF_TYPE_STD << SFC_CTRL_CMD_BITS_SHIFT) |
> +		       SFC_CTRL_PHASE_SEL_NEGETIVE,
> +		       sfc->regbase + SFC_CTRL);
> +
> +	if (op_type == SFC_CMD_DIR_WR)
> +		reg = nor->program_opcode << SFC_CMD_IDX_SHIFT;
> +	else
> +		reg = nor->read_opcode << SFC_CMD_IDX_SHIFT;
> +
> +	reg |= op_type << SFC_CMD_DIR_SHIFT;
> +	reg |= (nor->addr_width == 4) ?
> +		SFC_CMD_ADDR_32BITS : SFC_CMD_ADDR_24BITS;
> +
> +	reg |= priv->cs << SFC_CMD_CS_SHIFT;
> +	reg |= len << SFC_CMD_TRAN_BYTES_SHIFT;
> +
> +	if (op_type == SFC_CMD_DIR_RD)
> +		reg |= SFC_CMD_DUMMY(nor->read_dummy);
> +
> +	writel_relaxed(reg, sfc->regbase + SFC_CMD);
> +	writel_relaxed(from_to, sfc->regbase + SFC_ADDR);
> +
> +	return 0;
> +}
> +
> +static int rockchip_sfc_do_dma_transfer(struct spi_nor *nor, loff_t from_to,
> +					dma_addr_t dma_buf, size_t len,
> +					u8 op_type)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	u32 reg;
> +	int err = 0;
> +
> +	init_completion(&sfc->cp);
> +
> +	writel_relaxed(SFC_ICLR_RX_FULL | SFC_ICLR_RX_UFLOW |
> +		       SFC_ICLR_TX_OFLOW | SFC_ICLR_TX_EMPTY |
> +		       SFC_ICLR_TRAN_FINISH | SFC_ICLR_BUS_ERR |
> +		       SFC_ICLR_NSPI_ERR | SFC_ICLR_DMA,
> +		       sfc->regbase + SFC_ICLR);
> +
> +	/* Enable transfer complete interrupt */
> +	reg = readl_relaxed(sfc->regbase + SFC_IMR);
> +	reg &= ~SFC_IMR_TRAN_FINISH;
> +	writel_relaxed(reg, sfc->regbase + SFC_IMR);
> +
> +	err = rockchip_sfc_setup_transfer(nor, from_to, len, op_type);
> +	if (err < 0)
> +		return err;
> +
> +	writel_relaxed(dma_buf, sfc->regbase + SFC_DMA_ADDR);
> +
> +	/*
> +	 * Start dma but note that the sfc->dma_buffer is derived from
> +	 * dmam_alloc_coherent so we don't actually need any sync operations
> +	 * for coherent dma memory.
> +	 */

It's true that you don't need any DMA-API-level synchronisation, but you 
still need to ensure that in the write case, the store to the device 
register is ordered after any store(s) of the data to the coherent buffer...

> +	writel_relaxed(0x1, sfc->regbase + SFC_DMA_TRIGGER);

i.e. if the device may start issuing DMA accesses as soon as it recieves 
this register write, then it should be a non-relaxed writel().

> +
> +	/* Wait for the interrupt. */
> +	if (!wait_for_completion_timeout(&sfc->cp, msecs_to_jiffies(2000))) {
> +		dev_err(sfc->dev, "DMA wait for transfer finish timeout\n");
> +		err = -ETIMEDOUT;
> +	}
> +
> +	writel_relaxed(SFC_ICLR_RX_FULL | SFC_ICLR_RX_UFLOW |
> +		       SFC_ICLR_TX_OFLOW | SFC_ICLR_TX_EMPTY |
> +		       SFC_ICLR_TRAN_FINISH | SFC_ICLR_BUS_ERR |
> +		       SFC_ICLR_NSPI_ERR | SFC_ICLR_DMA,
> +		       sfc->regbase + SFC_ICLR);
> +	/* Disable transfer finish interrupt */
> +	reg = readl_relaxed(sfc->regbase + SFC_IMR);
> +	reg |= SFC_IMR_TRAN_FINISH;
> +	writel_relaxed(reg, sfc->regbase + SFC_IMR);
> +
> +	if (err) {
> +		rockchip_sfc_reset(sfc);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int rockchip_sfc_pio_write(struct rockchip_sfc *sfc, u_char *buf,
> +					 size_t len)
> +{
> +	return rockchip_sfc_write_fifo(sfc, buf, len);
> +}
> +
> +static inline int rockchip_sfc_pio_read(struct rockchip_sfc *sfc, u_char *buf,
> +					size_t len)
> +{
> +	return rockchip_sfc_read_fifo(sfc, buf, len);
> +}
> +
> +static int rockchip_sfc_pio_transfer(struct spi_nor *nor, loff_t from_to,
> +				     size_t len, u_char *buf, u8 op_type)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	size_t trans;
> +	int ret;
> +
> +	trans = min_t(size_t, SFC_MAX_TRANS_BYTES, len);
> +	ret = rockchip_sfc_setup_transfer(nor, from_to, trans, op_type);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (op_type == SFC_CMD_DIR_WR)
> +		ret = rockchip_sfc_pio_write(sfc, buf, trans);
> +	else
> +		ret = rockchip_sfc_pio_read(sfc, buf, trans);
> +
> +	return ret;
> +}
> +
> +static int rockchip_sfc_dma_transfer(struct spi_nor *nor, loff_t from_to,
> +				     size_t len, u_char *buf, u8 op_type)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +	size_t trans;
> +	int ret;
> +
> +	trans = min_t(size_t, SFC_MAX_TRANS_BYTES, len);
> +
> +	if (op_type == SFC_CMD_DIR_WR)
> +		memcpy(sfc->buffer, buf, trans);
> +
> +	ret = rockchip_sfc_do_dma_transfer(nor, from_to, sfc->dma_buffer,
> +					   trans, op_type);
> +	if (ret) {
> +		dev_warn(nor->dev, "DMA timeout\n");
> +		return ret;
> +	}
> +
> +	if (op_type == SFC_CMD_DIR_RD)
> +		memcpy(buf, sfc->buffer, trans);
> +
> +	return trans;
> +}
> +
> +static ssize_t rockchip_sfc_do_rd_wr(struct spi_nor *nor, loff_t from_to,
> +				     size_t len, u_char *buf, u32 op_type)
> +{
> +	struct rockchip_sfc_chip_priv *priv = nor->priv;
> +	struct rockchip_sfc *sfc = priv->sfc;
> +
> +	/* DMA can only handle word anligned transfer chunks */
> +	if (likely(sfc->use_dma) && !(len & 0x3))
> +		return rockchip_sfc_dma_transfer(nor, from_to, len, buf, op_type);
> +	else
> +		return rockchip_sfc_pio_transfer(nor, from_to, len,
> +						 (u_char *)buf, op_type);

Nit: Pointless cast of buf to its own type (I guess this has moved from 
the write function below).

> +}
> +
> +static ssize_t rockchip_sfc_read(struct spi_nor *nor, loff_t from,
> +				 size_t len, u_char *read_buf)
> +{
> +	return rockchip_sfc_do_rd_wr(nor, from, len,
> +				     read_buf, SFC_CMD_DIR_RD);
> +}
> +
> +static ssize_t rockchip_sfc_write(struct spi_nor *nor, loff_t to,
> +				  size_t len, const u_char *write_buf)
> +{
> +	return rockchip_sfc_do_rd_wr(nor, to, len,
> +				     (u_char *)write_buf,
> +				     SFC_CMD_DIR_WR);
> +}
> +
> +static int rockchip_sfc_register(struct device_node *np,
> +				 struct rockchip_sfc *sfc)
> +{
> +	const struct spi_nor_hwcaps hwcaps = {
> +		.mask = SNOR_HWCAPS_READ |
> +			SNOR_HWCAPS_READ_FAST |
> +			SNOR_HWCAPS_READ_1_1_2 |
> +			SNOR_HWCAPS_READ_1_1_4 |
> +			SNOR_HWCAPS_PP,
> +	};
> +	struct device *dev = sfc->dev;
> +	struct mtd_info *mtd;
> +	struct spi_nor *nor;
> +	int ret;
> +
> +	nor = &sfc->flash[sfc->num_chip].nor;
> +	nor->dev = dev;
> +	spi_nor_set_flash_node(nor, np);
> +
> +	ret = of_property_read_u8(np, "reg", &sfc->flash[sfc->num_chip].cs);
> +	if (ret) {
> +		dev_err(dev, "No reg property for %s\n",
> +			np->full_name);
> +		return ret;
> +	}

Given that you later validate the total number of chips against the 
number of chip selects, is it worth making sure that the actual chip 
select values given are in range too?

Since the sfc->flash array is small and fixed, I'd be tempted to get rid 
of num_chip and just use the CS value as the index directly.

> +
> +	ret = of_property_read_u32(np, "spi-max-frequency",
> +				   &sfc->flash[sfc->num_chip].clk_rate);
> +	if (ret) {
> +		dev_err(dev, "No spi-max-frequency property for %s\n",
> +			np->full_name);
> +		return ret;
> +	}
> +
> +	sfc->flash[sfc->num_chip].sfc = sfc;
> +	nor->priv = &sfc->flash[sfc->num_chip];
> +
> +	nor->prepare = rockchip_sfc_prep;
> +	nor->unprepare = rockchip_sfc_unprep;
> +	nor->read_reg = rockchip_sfc_read_reg;
> +	nor->write_reg = rockchip_sfc_write_reg;
> +	nor->read = rockchip_sfc_read;
> +	nor->write = rockchip_sfc_write;
> +	nor->erase = rockchip_sfc_erase;
> +	ret = spi_nor_scan(nor, NULL, &hwcaps);
> +	if (ret)
> +		return ret;
> +
> +	mtd = &nor->mtd;
> +	mtd->name = np->name;
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret)
> +		return ret;
> +
> +	sfc->num_chip++;
> +	return 0;
> +}
> +
> +static void rockchip_sfc_unregister_all(struct rockchip_sfc *sfc)
> +{
> +	int i;
> +
> +	for (i = 0; i < sfc->num_chip; i++)
> +		mtd_device_unregister(&sfc->flash[i].nor.mtd);
> +}
> +
> +static int rockchip_sfc_register_all(struct rockchip_sfc *sfc)
> +{
> +	struct device *dev = sfc->dev;
> +	struct device_node *np;
> +	int ret;
> +
> +	for_each_available_child_of_node(dev->of_node, np) {
> +		ret = rockchip_sfc_register(np, sfc);
> +		if (ret)
> +			goto fail;
> +
> +		if (sfc->num_chip == SFC_MAX_CHIPSELECT_NUM) {
> +			dev_warn(dev, "Exceeds the max cs limitation\n");
> +			break;

Assuming SFC_MAX_CHIPSELECT_NUM means you have 4 usable chip select 
lines, surely this is going to supriously warn when the user happens to 
have all 4 hooked up?

> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	dev_err(dev, "Failed to register all chips\n");
> +	/* Unregister all the _registered_ nor flash */
> +	rockchip_sfc_unregister_all(sfc);
> +	return ret;
> +}
> +
> +static irqreturn_t rockchip_sfc_irq_handler(int irq, void *dev_id)
> +{
> +	struct rockchip_sfc *sfc = dev_id;
> +	u32 reg;
> +
> +	reg = readl_relaxed(sfc->regbase + SFC_RISR);

Equivalently to the write-to-device case above, in the read-from-device 
case you also need to make sure that the load which indicates "DMA 
complete" is ordered before any subsequent loads from the buffer, which 
in general means this should be a non-relaxed readl().

I appreciate that you almost certainly do get away with it on RV1108, 
since Cortex-A7 is hardly an aggressively speculating CPU with deep 
write buffers, but there's always the chance that that the same 
controller might end up in some future high-end SoC, or that someone 
blindly copies the code for a similar driver, where such correctness 
could start to matter.

> +
> +	/* Clear interrupt */
> +	writel_relaxed(reg, sfc->regbase + SFC_ICLR);
> +
> +	if (reg & SFC_RISR_TRAN_FINISH)
> +		complete(&sfc->cp);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rockchip_sfc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct rockchip_sfc *sfc;
> +	int ret;
> +
> +	sfc = devm_kzalloc(dev, sizeof(*sfc), GFP_KERNEL);
> +	if (!sfc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, sfc);
> +	sfc->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sfc->regbase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(sfc->regbase))
> +		return PTR_ERR(sfc->regbase);
> +
> +	sfc->clk = devm_clk_get(&pdev->dev, "sfc");
> +	if (IS_ERR(sfc->clk)) {
> +		dev_err(&pdev->dev, "Failed to get sfc interface clk\n");
> +		return PTR_ERR(sfc->clk);
> +	}
> +
> +	sfc->hclk = devm_clk_get(&pdev->dev, "hsfc");
> +	if (IS_ERR(sfc->hclk)) {
> +		dev_err(&pdev->dev, "Failed to get sfc ahp clk\n");
> +		return PTR_ERR(sfc->hclk);
> +	}
> +
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));

Do you really need to coerce the dma_mask pointer? The OF code already 
initialises it, so given that this looks like a DT-only driver I would 
expect to see a normal dma_set_mask_and_coherent() call here.

> +	if (ret) {
> +		dev_warn(dev, "Unable to set dma mask\n");
> +		return ret;
> +	}
> +
> +	sfc->buffer = dmam_alloc_coherent(dev, SFC_MAX_TRANS_BYTES,
> +					  &sfc->dma_buffer,
> +					  GFP_KERNEL);
> +	if (!sfc->buffer)
> +		return -ENOMEM;
> +
> +	mutex_init(&sfc->lock);
> +
> +	ret = clk_prepare_enable(sfc->hclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable hclk\n");
> +		goto err_hclk;
> +	}
> +
> +	ret = clk_prepare_enable(sfc->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable clk\n");
> +		goto err_clk;
> +	}
> +
> +	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node,
> +					      "rockchip,sfc-no-dma");

Nit: it's probably worth checking this *before* allocating a bounce 
buffer that you might not need.

Robin.

> +
> +	/* Find the irq */
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get the irq\n");
> +		goto err_irq;
> +	}
> +
> +	ret = devm_request_irq(dev, ret, rockchip_sfc_irq_handler,
> +			       0, pdev->name, sfc);
> +	if (ret) {
> +		dev_err(dev, "Failed to request irq\n");
> +		goto err_irq;
> +	}
> +
> +	sfc->num_chip = 0;
> +	ret = rockchip_sfc_init(sfc);
> +	if (ret)
> +		goto err_irq;
> +
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +
> +	ret = rockchip_sfc_register_all(sfc);
> +	if (ret)
> +		goto err_register;
> +
> +	clk_disable_unprepare(sfc->clk);
> +	pm_runtime_put_autosuspend(&pdev->dev);
> +
> +	return 0;
> +
> +err_register:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +err_irq:
> +	clk_disable_unprepare(sfc->clk);
> +err_clk:
> +	clk_disable_unprepare(sfc->hclk);
> +err_hclk:
> +	mutex_destroy(&sfc->lock);
> +	return ret;
> +}
> +
> +static int rockchip_sfc_remove(struct platform_device *pdev)
> +{
> +	struct rockchip_sfc *sfc = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
> +	rockchip_sfc_unregister_all(sfc);
> +	mutex_destroy(&sfc->lock);
> +	clk_disable_unprepare(sfc->clk);
> +	clk_disable_unprepare(sfc->hclk);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +int rockchip_sfc_runtime_suspend(struct device *dev)
> +{
> +	struct rockchip_sfc *sfc = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(sfc->hclk);
> +	return 0;
> +}
> +
> +int rockchip_sfc_runtime_resume(struct device *dev)
> +{
> +	struct rockchip_sfc *sfc = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(sfc->hclk);
> +	return rockchip_sfc_reset(sfc);
> +}
> +#endif /* CONFIG_PM */
> +
> +static const struct of_device_id rockchip_sfc_dt_ids[] = {
> +	{ .compatible = "rockchip,sfc"},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_sfc_dt_ids);
> +
> +static const struct dev_pm_ops rockchip_sfc_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(rockchip_sfc_runtime_suspend,
> +			   rockchip_sfc_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver rockchip_sfc_driver = {
> +	.driver = {
> +		.name	= "rockchip-sfc",
> +		.of_match_table = rockchip_sfc_dt_ids,
> +		.pm = &rockchip_sfc_dev_pm_ops,
> +	},
> +	.probe	= rockchip_sfc_probe,
> +	.remove	= rockchip_sfc_remove,
> +};
> +module_platform_driver(rockchip_sfc_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Rockchip Serial Flash Controller Driver");
> +MODULE_AUTHOR("Shawn Lin <shawn.lin@rock-chips.com>");
> 
