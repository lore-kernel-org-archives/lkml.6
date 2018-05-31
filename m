Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754232AbeEaJBJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:01:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43180 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754070AbeEaJBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:01:01 -0400
Date: Thu, 31 May 2018 11:00:08 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next] net: mvpp2: Split the PPv2 driver to a
 dedicated directory
Message-ID: <20180531090008.GD12371@kwain>
References: <20180531080743.4218-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180531080743.4218-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, May 31, 2018 at 10:07:43AM +0200, Maxime Chevallier wrote:
> As the mvpp2 driver is growing, move this driver to a dedicated
> directory and split it into several files.
> 
> Since this driver has a lot of register defines and structure
> definitions, it can benefit from having all of this into a dedicated
> header file, named mvpp2.h.
> 
> A good chunk of the mvpp2 code is dedicated to Header Parser handling, so
> we introduce mvpp2_prs.h where all Header Parser definitions are located,
> and mvpp2_prs.c containing the related code.
> 
> In the same way, mvpp2_cls.h and mvpp2_cls.c are created to contain
> Classifier and RSS related code.
> 
> The former 'mvpp2.c' file is renamed 'mvpp2_main.c' so that we can keep
> the driver binary named 'mvpp2'.
> 
> This commit is only about spliting the driver into multiple files and
> doesn't introduce any new function, feature or fix besides removing
> 'static' keywords when needed.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Tested-by: Antoine Tenart <antoine.tenart@bootlin.com>

Thanks!
Antoine

> ---
> This is based on the latest net-next, I expect no conflicts but due to
> the amount of code this patchs touches, it can easily become un-appliable.
> 
> Tell me if that's the case, I'll be happy to rebase it if needed.
> 
>  drivers/net/ethernet/marvell/Makefile              |    2 +-
>  drivers/net/ethernet/marvell/mvpp2/Makefile        |    7 +
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h         | 1046 +++++
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     |  141 +
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h     |   44 +
>  .../marvell/{mvpp2.c => mvpp2/mvpp2_main.c}        | 4272 +-------------------
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     | 2467 +++++++++++
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h     |  314 ++
>  8 files changed, 4217 insertions(+), 4076 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/mvpp2/Makefile
>  create mode 100644 drivers/net/ethernet/marvell/mvpp2/mvpp2.h
>  create mode 100644 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
>  create mode 100644 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
>  rename drivers/net/ethernet/marvell/{mvpp2.c => mvpp2/mvpp2_main.c} (54%)
>  create mode 100644 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
>  create mode 100644 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
> 
> diff --git a/drivers/net/ethernet/marvell/Makefile b/drivers/net/ethernet/marvell/Makefile
> index 9498ed26dbe5..55d4d10aa7d3 100644
> --- a/drivers/net/ethernet/marvell/Makefile
> +++ b/drivers/net/ethernet/marvell/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_MVMDIO) += mvmdio.o
>  obj-$(CONFIG_MV643XX_ETH) += mv643xx_eth.o
>  obj-$(CONFIG_MVNETA_BM) += mvneta_bm.o
>  obj-$(CONFIG_MVNETA) += mvneta.o
> -obj-$(CONFIG_MVPP2) += mvpp2.o
> +obj-$(CONFIG_MVPP2) += mvpp2/
>  obj-$(CONFIG_PXA168_ETH) += pxa168_eth.o
>  obj-$(CONFIG_SKGE) += skge.o
>  obj-$(CONFIG_SKY2) += sky2.o
> diff --git a/drivers/net/ethernet/marvell/mvpp2/Makefile b/drivers/net/ethernet/marvell/mvpp2/Makefile
> new file mode 100644
> index 000000000000..4d11dd9e3246
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/mvpp2/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the Marvell PPv2 driver.
> +#
> +obj-$(CONFIG_MVPP2) := mvpp2.o
> +
> +mvpp2-objs := mvpp2_main.o mvpp2_prs.o mvpp2_cls.o
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> new file mode 100644
> index 000000000000..def00dc3eb4e
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -0,0 +1,1046 @@
> +/*
> + * Definitions for Marvell PPv2 network controller for Armada 375 SoC.
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Marcin Wojtas <mw@semihalf.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#ifndef _MVPP2_H_
> +#define _MVPP2_H_
> +
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +#include <linux/phy.h>
> +#include <linux/phylink.h>
> +
> +/* Fifo Registers */
> +#define MVPP2_RX_DATA_FIFO_SIZE_REG(port)	(0x00 + 4 * (port))
> +#define MVPP2_RX_ATTR_FIFO_SIZE_REG(port)	(0x20 + 4 * (port))
> +#define MVPP2_RX_MIN_PKT_SIZE_REG		0x60
> +#define MVPP2_RX_FIFO_INIT_REG			0x64
> +#define MVPP22_TX_FIFO_THRESH_REG(port)		(0x8840 + 4 * (port))
> +#define MVPP22_TX_FIFO_SIZE_REG(port)		(0x8860 + 4 * (port))
> +
> +/* RX DMA Top Registers */
> +#define MVPP2_RX_CTRL_REG(port)			(0x140 + 4 * (port))
> +#define     MVPP2_RX_LOW_LATENCY_PKT_SIZE(s)	(((s) & 0xfff) << 16)
> +#define     MVPP2_RX_USE_PSEUDO_FOR_CSUM_MASK	BIT(31)
> +#define MVPP2_POOL_BUF_SIZE_REG(pool)		(0x180 + 4 * (pool))
> +#define     MVPP2_POOL_BUF_SIZE_OFFSET		5
> +#define MVPP2_RXQ_CONFIG_REG(rxq)		(0x800 + 4 * (rxq))
> +#define     MVPP2_SNOOP_PKT_SIZE_MASK		0x1ff
> +#define     MVPP2_SNOOP_BUF_HDR_MASK		BIT(9)
> +#define     MVPP2_RXQ_POOL_SHORT_OFFS		20
> +#define     MVPP21_RXQ_POOL_SHORT_MASK		0x700000
> +#define     MVPP22_RXQ_POOL_SHORT_MASK		0xf00000
> +#define     MVPP2_RXQ_POOL_LONG_OFFS		24
> +#define     MVPP21_RXQ_POOL_LONG_MASK		0x7000000
> +#define     MVPP22_RXQ_POOL_LONG_MASK		0xf000000
> +#define     MVPP2_RXQ_PACKET_OFFSET_OFFS	28
> +#define     MVPP2_RXQ_PACKET_OFFSET_MASK	0x70000000
> +#define     MVPP2_RXQ_DISABLE_MASK		BIT(31)
> +
> +/* Top Registers */
> +#define MVPP2_MH_REG(port)			(0x5040 + 4 * (port))
> +#define MVPP2_DSA_EXTENDED			BIT(5)
> +
> +/* Parser Registers */
> +#define MVPP2_PRS_INIT_LOOKUP_REG		0x1000
> +#define     MVPP2_PRS_PORT_LU_MAX		0xf
> +#define     MVPP2_PRS_PORT_LU_MASK(port)	(0xff << ((port) * 4))
> +#define     MVPP2_PRS_PORT_LU_VAL(port, val)	((val) << ((port) * 4))
> +#define MVPP2_PRS_INIT_OFFS_REG(port)		(0x1004 + ((port) & 4))
> +#define     MVPP2_PRS_INIT_OFF_MASK(port)	(0x3f << (((port) % 4) * 8))
> +#define     MVPP2_PRS_INIT_OFF_VAL(port, val)	((val) << (((port) % 4) * 8))
> +#define MVPP2_PRS_MAX_LOOP_REG(port)		(0x100c + ((port) & 4))
> +#define     MVPP2_PRS_MAX_LOOP_MASK(port)	(0xff << (((port) % 4) * 8))
> +#define     MVPP2_PRS_MAX_LOOP_VAL(port, val)	((val) << (((port) % 4) * 8))
> +#define MVPP2_PRS_TCAM_IDX_REG			0x1100
> +#define MVPP2_PRS_TCAM_DATA_REG(idx)		(0x1104 + (idx) * 4)
> +#define     MVPP2_PRS_TCAM_INV_MASK		BIT(31)
> +#define MVPP2_PRS_SRAM_IDX_REG			0x1200
> +#define MVPP2_PRS_SRAM_DATA_REG(idx)		(0x1204 + (idx) * 4)
> +#define MVPP2_PRS_TCAM_CTRL_REG			0x1230
> +#define     MVPP2_PRS_TCAM_EN_MASK		BIT(0)
> +
> +/* RSS Registers */
> +#define MVPP22_RSS_INDEX			0x1500
> +#define     MVPP22_RSS_INDEX_TABLE_ENTRY(idx)	(idx)
> +#define     MVPP22_RSS_INDEX_TABLE(idx)		((idx) << 8)
> +#define     MVPP22_RSS_INDEX_QUEUE(idx)		((idx) << 16)
> +#define MVPP22_RSS_TABLE_ENTRY			0x1508
> +#define MVPP22_RSS_TABLE			0x1510
> +#define     MVPP22_RSS_TABLE_POINTER(p)		(p)
> +#define MVPP22_RSS_WIDTH			0x150c
> +
> +/* Classifier Registers */
> +#define MVPP2_CLS_MODE_REG			0x1800
> +#define     MVPP2_CLS_MODE_ACTIVE_MASK		BIT(0)
> +#define MVPP2_CLS_PORT_WAY_REG			0x1810
> +#define     MVPP2_CLS_PORT_WAY_MASK(port)	(1 << (port))
> +#define MVPP2_CLS_LKP_INDEX_REG			0x1814
> +#define     MVPP2_CLS_LKP_INDEX_WAY_OFFS	6
> +#define MVPP2_CLS_LKP_TBL_REG			0x1818
> +#define     MVPP2_CLS_LKP_TBL_RXQ_MASK		0xff
> +#define     MVPP2_CLS_LKP_TBL_LOOKUP_EN_MASK	BIT(25)
> +#define MVPP2_CLS_FLOW_INDEX_REG		0x1820
> +#define MVPP2_CLS_FLOW_TBL0_REG			0x1824
> +#define MVPP2_CLS_FLOW_TBL1_REG			0x1828
> +#define MVPP2_CLS_FLOW_TBL2_REG			0x182c
> +#define MVPP2_CLS_OVERSIZE_RXQ_LOW_REG(port)	(0x1980 + ((port) * 4))
> +#define     MVPP2_CLS_OVERSIZE_RXQ_LOW_BITS	3
> +#define     MVPP2_CLS_OVERSIZE_RXQ_LOW_MASK	0x7
> +#define MVPP2_CLS_SWFWD_P2HQ_REG(port)		(0x19b0 + ((port) * 4))
> +#define MVPP2_CLS_SWFWD_PCTRL_REG		0x19d0
> +#define     MVPP2_CLS_SWFWD_PCTRL_MASK(port)	(1 << (port))
> +
> +/* Descriptor Manager Top Registers */
> +#define MVPP2_RXQ_NUM_REG			0x2040
> +#define MVPP2_RXQ_DESC_ADDR_REG			0x2044
> +#define     MVPP22_DESC_ADDR_OFFS		8
> +#define MVPP2_RXQ_DESC_SIZE_REG			0x2048
> +#define     MVPP2_RXQ_DESC_SIZE_MASK		0x3ff0
> +#define MVPP2_RXQ_STATUS_UPDATE_REG(rxq)	(0x3000 + 4 * (rxq))
> +#define     MVPP2_RXQ_NUM_PROCESSED_OFFSET	0
> +#define     MVPP2_RXQ_NUM_NEW_OFFSET		16
> +#define MVPP2_RXQ_STATUS_REG(rxq)		(0x3400 + 4 * (rxq))
> +#define     MVPP2_RXQ_OCCUPIED_MASK		0x3fff
> +#define     MVPP2_RXQ_NON_OCCUPIED_OFFSET	16
> +#define     MVPP2_RXQ_NON_OCCUPIED_MASK		0x3fff0000
> +#define MVPP2_RXQ_THRESH_REG			0x204c
> +#define     MVPP2_OCCUPIED_THRESH_OFFSET	0
> +#define     MVPP2_OCCUPIED_THRESH_MASK		0x3fff
> +#define MVPP2_RXQ_INDEX_REG			0x2050
> +#define MVPP2_TXQ_NUM_REG			0x2080
> +#define MVPP2_TXQ_DESC_ADDR_REG			0x2084
> +#define MVPP2_TXQ_DESC_SIZE_REG			0x2088
> +#define     MVPP2_TXQ_DESC_SIZE_MASK		0x3ff0
> +#define MVPP2_TXQ_THRESH_REG			0x2094
> +#define	    MVPP2_TXQ_THRESH_OFFSET		16
> +#define	    MVPP2_TXQ_THRESH_MASK		0x3fff
> +#define MVPP2_AGGR_TXQ_UPDATE_REG		0x2090
> +#define MVPP2_TXQ_INDEX_REG			0x2098
> +#define MVPP2_TXQ_PREF_BUF_REG			0x209c
> +#define     MVPP2_PREF_BUF_PTR(desc)		((desc) & 0xfff)
> +#define     MVPP2_PREF_BUF_SIZE_4		(BIT(12) | BIT(13))
> +#define     MVPP2_PREF_BUF_SIZE_16		(BIT(12) | BIT(14))
> +#define     MVPP2_PREF_BUF_THRESH(val)		((val) << 17)
> +#define     MVPP2_TXQ_DRAIN_EN_MASK		BIT(31)
> +#define MVPP2_TXQ_PENDING_REG			0x20a0
> +#define     MVPP2_TXQ_PENDING_MASK		0x3fff
> +#define MVPP2_TXQ_INT_STATUS_REG		0x20a4
> +#define MVPP2_TXQ_SENT_REG(txq)			(0x3c00 + 4 * (txq))
> +#define     MVPP2_TRANSMITTED_COUNT_OFFSET	16
> +#define     MVPP2_TRANSMITTED_COUNT_MASK	0x3fff0000
> +#define MVPP2_TXQ_RSVD_REQ_REG			0x20b0
> +#define     MVPP2_TXQ_RSVD_REQ_Q_OFFSET		16
> +#define MVPP2_TXQ_RSVD_RSLT_REG			0x20b4
> +#define     MVPP2_TXQ_RSVD_RSLT_MASK		0x3fff
> +#define MVPP2_TXQ_RSVD_CLR_REG			0x20b8
> +#define     MVPP2_TXQ_RSVD_CLR_OFFSET		16
> +#define MVPP2_AGGR_TXQ_DESC_ADDR_REG(cpu)	(0x2100 + 4 * (cpu))
> +#define     MVPP22_AGGR_TXQ_DESC_ADDR_OFFS	8
> +#define MVPP2_AGGR_TXQ_DESC_SIZE_REG(cpu)	(0x2140 + 4 * (cpu))
> +#define     MVPP2_AGGR_TXQ_DESC_SIZE_MASK	0x3ff0
> +#define MVPP2_AGGR_TXQ_STATUS_REG(cpu)		(0x2180 + 4 * (cpu))
> +#define     MVPP2_AGGR_TXQ_PENDING_MASK		0x3fff
> +#define MVPP2_AGGR_TXQ_INDEX_REG(cpu)		(0x21c0 + 4 * (cpu))
> +
> +/* MBUS bridge registers */
> +#define MVPP2_WIN_BASE(w)			(0x4000 + ((w) << 2))
> +#define MVPP2_WIN_SIZE(w)			(0x4020 + ((w) << 2))
> +#define MVPP2_WIN_REMAP(w)			(0x4040 + ((w) << 2))
> +#define MVPP2_BASE_ADDR_ENABLE			0x4060
> +
> +/* AXI Bridge Registers */
> +#define MVPP22_AXI_BM_WR_ATTR_REG		0x4100
> +#define MVPP22_AXI_BM_RD_ATTR_REG		0x4104
> +#define MVPP22_AXI_AGGRQ_DESCR_RD_ATTR_REG	0x4110
> +#define MVPP22_AXI_TXQ_DESCR_WR_ATTR_REG	0x4114
> +#define MVPP22_AXI_TXQ_DESCR_RD_ATTR_REG	0x4118
> +#define MVPP22_AXI_RXQ_DESCR_WR_ATTR_REG	0x411c
> +#define MVPP22_AXI_RX_DATA_WR_ATTR_REG		0x4120
> +#define MVPP22_AXI_TX_DATA_RD_ATTR_REG		0x4130
> +#define MVPP22_AXI_RD_NORMAL_CODE_REG		0x4150
> +#define MVPP22_AXI_RD_SNOOP_CODE_REG		0x4154
> +#define MVPP22_AXI_WR_NORMAL_CODE_REG		0x4160
> +#define MVPP22_AXI_WR_SNOOP_CODE_REG		0x4164
> +
> +/* Values for AXI Bridge registers */
> +#define MVPP22_AXI_ATTR_CACHE_OFFS		0
> +#define MVPP22_AXI_ATTR_DOMAIN_OFFS		12
> +
> +#define MVPP22_AXI_CODE_CACHE_OFFS		0
> +#define MVPP22_AXI_CODE_DOMAIN_OFFS		4
> +
> +#define MVPP22_AXI_CODE_CACHE_NON_CACHE		0x3
> +#define MVPP22_AXI_CODE_CACHE_WR_CACHE		0x7
> +#define MVPP22_AXI_CODE_CACHE_RD_CACHE		0xb
> +
> +#define MVPP22_AXI_CODE_DOMAIN_OUTER_DOM	2
> +#define MVPP22_AXI_CODE_DOMAIN_SYSTEM		3
> +
> +/* Interrupt Cause and Mask registers */
> +#define MVPP2_ISR_TX_THRESHOLD_REG(port)	(0x5140 + 4 * (port))
> +#define     MVPP2_MAX_ISR_TX_THRESHOLD		0xfffff0
> +
> +#define MVPP2_ISR_RX_THRESHOLD_REG(rxq)		(0x5200 + 4 * (rxq))
> +#define     MVPP2_MAX_ISR_RX_THRESHOLD		0xfffff0
> +#define MVPP21_ISR_RXQ_GROUP_REG(port)		(0x5400 + 4 * (port))
> +
> +#define MVPP22_ISR_RXQ_GROUP_INDEX_REG		0x5400
> +#define MVPP22_ISR_RXQ_GROUP_INDEX_SUBGROUP_MASK 0xf
> +#define MVPP22_ISR_RXQ_GROUP_INDEX_GROUP_MASK	0x380
> +#define MVPP22_ISR_RXQ_GROUP_INDEX_GROUP_OFFSET	7
> +
> +#define MVPP22_ISR_RXQ_GROUP_INDEX_SUBGROUP_MASK 0xf
> +#define MVPP22_ISR_RXQ_GROUP_INDEX_GROUP_MASK	0x380
> +
> +#define MVPP22_ISR_RXQ_SUB_GROUP_CONFIG_REG	0x5404
> +#define MVPP22_ISR_RXQ_SUB_GROUP_STARTQ_MASK	0x1f
> +#define MVPP22_ISR_RXQ_SUB_GROUP_SIZE_MASK	0xf00
> +#define MVPP22_ISR_RXQ_SUB_GROUP_SIZE_OFFSET	8
> +
> +#define MVPP2_ISR_ENABLE_REG(port)		(0x5420 + 4 * (port))
> +#define     MVPP2_ISR_ENABLE_INTERRUPT(mask)	((mask) & 0xffff)
> +#define     MVPP2_ISR_DISABLE_INTERRUPT(mask)	(((mask) << 16) & 0xffff0000)
> +#define MVPP2_ISR_RX_TX_CAUSE_REG(port)		(0x5480 + 4 * (port))
> +#define     MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK	0xffff
> +#define     MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_MASK	0xff0000
> +#define     MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_OFFSET	16
> +#define     MVPP2_CAUSE_RX_FIFO_OVERRUN_MASK	BIT(24)
> +#define     MVPP2_CAUSE_FCS_ERR_MASK		BIT(25)
> +#define     MVPP2_CAUSE_TX_FIFO_UNDERRUN_MASK	BIT(26)
> +#define     MVPP2_CAUSE_TX_EXCEPTION_SUM_MASK	BIT(29)
> +#define     MVPP2_CAUSE_RX_EXCEPTION_SUM_MASK	BIT(30)
> +#define     MVPP2_CAUSE_MISC_SUM_MASK		BIT(31)
> +#define MVPP2_ISR_RX_TX_MASK_REG(port)		(0x54a0 + 4 * (port))
> +#define MVPP2_ISR_PON_RX_TX_MASK_REG		0x54bc
> +#define     MVPP2_PON_CAUSE_RXQ_OCCUP_DESC_ALL_MASK	0xffff
> +#define     MVPP2_PON_CAUSE_TXP_OCCUP_DESC_ALL_MASK	0x3fc00000
> +#define     MVPP2_PON_CAUSE_MISC_SUM_MASK		BIT(31)
> +#define MVPP2_ISR_MISC_CAUSE_REG		0x55b0
> +
> +/* Buffer Manager registers */
> +#define MVPP2_BM_POOL_BASE_REG(pool)		(0x6000 + ((pool) * 4))
> +#define     MVPP2_BM_POOL_BASE_ADDR_MASK	0xfffff80
> +#define MVPP2_BM_POOL_SIZE_REG(pool)		(0x6040 + ((pool) * 4))
> +#define     MVPP2_BM_POOL_SIZE_MASK		0xfff0
> +#define MVPP2_BM_POOL_READ_PTR_REG(pool)	(0x6080 + ((pool) * 4))
> +#define     MVPP2_BM_POOL_GET_READ_PTR_MASK	0xfff0
> +#define MVPP2_BM_POOL_PTRS_NUM_REG(pool)	(0x60c0 + ((pool) * 4))
> +#define     MVPP2_BM_POOL_PTRS_NUM_MASK		0xfff0
> +#define MVPP2_BM_BPPI_READ_PTR_REG(pool)	(0x6100 + ((pool) * 4))
> +#define MVPP2_BM_BPPI_PTRS_NUM_REG(pool)	(0x6140 + ((pool) * 4))
> +#define     MVPP2_BM_BPPI_PTR_NUM_MASK		0x7ff
> +#define MVPP22_BM_POOL_PTRS_NUM_MASK		0xfff8
> +#define     MVPP2_BM_BPPI_PREFETCH_FULL_MASK	BIT(16)
> +#define MVPP2_BM_POOL_CTRL_REG(pool)		(0x6200 + ((pool) * 4))
> +#define     MVPP2_BM_START_MASK			BIT(0)
> +#define     MVPP2_BM_STOP_MASK			BIT(1)
> +#define     MVPP2_BM_STATE_MASK			BIT(4)
> +#define     MVPP2_BM_LOW_THRESH_OFFS		8
> +#define     MVPP2_BM_LOW_THRESH_MASK		0x7f00
> +#define     MVPP2_BM_LOW_THRESH_VALUE(val)	((val) << \
> +						MVPP2_BM_LOW_THRESH_OFFS)
> +#define     MVPP2_BM_HIGH_THRESH_OFFS		16
> +#define     MVPP2_BM_HIGH_THRESH_MASK		0x7f0000
> +#define     MVPP2_BM_HIGH_THRESH_VALUE(val)	((val) << \
> +						MVPP2_BM_HIGH_THRESH_OFFS)
> +#define MVPP2_BM_INTR_CAUSE_REG(pool)		(0x6240 + ((pool) * 4))
> +#define     MVPP2_BM_RELEASED_DELAY_MASK	BIT(0)
> +#define     MVPP2_BM_ALLOC_FAILED_MASK		BIT(1)
> +#define     MVPP2_BM_BPPE_EMPTY_MASK		BIT(2)
> +#define     MVPP2_BM_BPPE_FULL_MASK		BIT(3)
> +#define     MVPP2_BM_AVAILABLE_BP_LOW_MASK	BIT(4)
> +#define MVPP2_BM_INTR_MASK_REG(pool)		(0x6280 + ((pool) * 4))
> +#define MVPP2_BM_PHY_ALLOC_REG(pool)		(0x6400 + ((pool) * 4))
> +#define     MVPP2_BM_PHY_ALLOC_GRNTD_MASK	BIT(0)
> +#define MVPP2_BM_VIRT_ALLOC_REG			0x6440
> +#define MVPP22_BM_ADDR_HIGH_ALLOC		0x6444
> +#define     MVPP22_BM_ADDR_HIGH_PHYS_MASK	0xff
> +#define     MVPP22_BM_ADDR_HIGH_VIRT_MASK	0xff00
> +#define     MVPP22_BM_ADDR_HIGH_VIRT_SHIFT	8
> +#define MVPP2_BM_PHY_RLS_REG(pool)		(0x6480 + ((pool) * 4))
> +#define     MVPP2_BM_PHY_RLS_MC_BUFF_MASK	BIT(0)
> +#define     MVPP2_BM_PHY_RLS_PRIO_EN_MASK	BIT(1)
> +#define     MVPP2_BM_PHY_RLS_GRNTD_MASK		BIT(2)
> +#define MVPP2_BM_VIRT_RLS_REG			0x64c0
> +#define MVPP22_BM_ADDR_HIGH_RLS_REG		0x64c4
> +#define     MVPP22_BM_ADDR_HIGH_PHYS_RLS_MASK	0xff
> +#define     MVPP22_BM_ADDR_HIGH_VIRT_RLS_MASK	0xff00
> +#define     MVPP22_BM_ADDR_HIGH_VIRT_RLS_SHIFT	8
> +
> +/* TX Scheduler registers */
> +#define MVPP2_TXP_SCHED_PORT_INDEX_REG		0x8000
> +#define MVPP2_TXP_SCHED_Q_CMD_REG		0x8004
> +#define     MVPP2_TXP_SCHED_ENQ_MASK		0xff
> +#define     MVPP2_TXP_SCHED_DISQ_OFFSET		8
> +#define MVPP2_TXP_SCHED_CMD_1_REG		0x8010
> +#define MVPP2_TXP_SCHED_PERIOD_REG		0x8018
> +#define MVPP2_TXP_SCHED_MTU_REG			0x801c
> +#define     MVPP2_TXP_MTU_MAX			0x7FFFF
> +#define MVPP2_TXP_SCHED_REFILL_REG		0x8020
> +#define     MVPP2_TXP_REFILL_TOKENS_ALL_MASK	0x7ffff
> +#define     MVPP2_TXP_REFILL_PERIOD_ALL_MASK	0x3ff00000
> +#define     MVPP2_TXP_REFILL_PERIOD_MASK(v)	((v) << 20)
> +#define MVPP2_TXP_SCHED_TOKEN_SIZE_REG		0x8024
> +#define     MVPP2_TXP_TOKEN_SIZE_MAX		0xffffffff
> +#define MVPP2_TXQ_SCHED_REFILL_REG(q)		(0x8040 + ((q) << 2))
> +#define     MVPP2_TXQ_REFILL_TOKENS_ALL_MASK	0x7ffff
> +#define     MVPP2_TXQ_REFILL_PERIOD_ALL_MASK	0x3ff00000
> +#define     MVPP2_TXQ_REFILL_PERIOD_MASK(v)	((v) << 20)
> +#define MVPP2_TXQ_SCHED_TOKEN_SIZE_REG(q)	(0x8060 + ((q) << 2))
> +#define     MVPP2_TXQ_TOKEN_SIZE_MAX		0x7fffffff
> +#define MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(q)	(0x8080 + ((q) << 2))
> +#define     MVPP2_TXQ_TOKEN_CNTR_MAX		0xffffffff
> +
> +/* TX general registers */
> +#define MVPP2_TX_SNOOP_REG			0x8800
> +#define MVPP2_TX_PORT_FLUSH_REG			0x8810
> +#define     MVPP2_TX_PORT_FLUSH_MASK(port)	(1 << (port))
> +
> +/* LMS registers */
> +#define MVPP2_SRC_ADDR_MIDDLE			0x24
> +#define MVPP2_SRC_ADDR_HIGH			0x28
> +#define MVPP2_PHY_AN_CFG0_REG			0x34
> +#define     MVPP2_PHY_AN_STOP_SMI0_MASK		BIT(7)
> +#define MVPP2_MNG_EXTENDED_GLOBAL_CTRL_REG	0x305c
> +#define     MVPP2_EXT_GLOBAL_CTRL_DEFAULT	0x27
> +
> +/* Per-port registers */
> +#define MVPP2_GMAC_CTRL_0_REG			0x0
> +#define     MVPP2_GMAC_PORT_EN_MASK		BIT(0)
> +#define     MVPP2_GMAC_PORT_TYPE_MASK		BIT(1)
> +#define     MVPP2_GMAC_MAX_RX_SIZE_OFFS		2
> +#define     MVPP2_GMAC_MAX_RX_SIZE_MASK		0x7ffc
> +#define     MVPP2_GMAC_MIB_CNTR_EN_MASK		BIT(15)
> +#define MVPP2_GMAC_CTRL_1_REG			0x4
> +#define     MVPP2_GMAC_PERIODIC_XON_EN_MASK	BIT(1)
> +#define     MVPP2_GMAC_GMII_LB_EN_MASK		BIT(5)
> +#define     MVPP2_GMAC_PCS_LB_EN_BIT		6
> +#define     MVPP2_GMAC_PCS_LB_EN_MASK		BIT(6)
> +#define     MVPP2_GMAC_SA_LOW_OFFS		7
> +#define MVPP2_GMAC_CTRL_2_REG			0x8
> +#define     MVPP2_GMAC_INBAND_AN_MASK		BIT(0)
> +#define     MVPP2_GMAC_FLOW_CTRL_MASK		GENMASK(2, 1)
> +#define     MVPP2_GMAC_PCS_ENABLE_MASK		BIT(3)
> +#define     MVPP2_GMAC_INTERNAL_CLK_MASK	BIT(4)
> +#define     MVPP2_GMAC_DISABLE_PADDING		BIT(5)
> +#define     MVPP2_GMAC_PORT_RESET_MASK		BIT(6)
> +#define MVPP2_GMAC_AUTONEG_CONFIG		0xc
> +#define     MVPP2_GMAC_FORCE_LINK_DOWN		BIT(0)
> +#define     MVPP2_GMAC_FORCE_LINK_PASS		BIT(1)
> +#define     MVPP2_GMAC_IN_BAND_AUTONEG		BIT(2)
> +#define     MVPP2_GMAC_IN_BAND_AUTONEG_BYPASS	BIT(3)
> +#define     MVPP2_GMAC_IN_BAND_RESTART_AN	BIT(4)
> +#define     MVPP2_GMAC_CONFIG_MII_SPEED	BIT(5)
> +#define     MVPP2_GMAC_CONFIG_GMII_SPEED	BIT(6)
> +#define     MVPP2_GMAC_AN_SPEED_EN		BIT(7)
> +#define     MVPP2_GMAC_FC_ADV_EN		BIT(9)
> +#define     MVPP2_GMAC_FC_ADV_ASM_EN		BIT(10)
> +#define     MVPP2_GMAC_FLOW_CTRL_AUTONEG	BIT(11)
> +#define     MVPP2_GMAC_CONFIG_FULL_DUPLEX	BIT(12)
> +#define     MVPP2_GMAC_AN_DUPLEX_EN		BIT(13)
> +#define MVPP2_GMAC_STATUS0			0x10
> +#define     MVPP2_GMAC_STATUS0_LINK_UP		BIT(0)
> +#define     MVPP2_GMAC_STATUS0_GMII_SPEED	BIT(1)
> +#define     MVPP2_GMAC_STATUS0_MII_SPEED	BIT(2)
> +#define     MVPP2_GMAC_STATUS0_FULL_DUPLEX	BIT(3)
> +#define     MVPP2_GMAC_STATUS0_RX_PAUSE		BIT(6)
> +#define     MVPP2_GMAC_STATUS0_TX_PAUSE		BIT(7)
> +#define     MVPP2_GMAC_STATUS0_AN_COMPLETE	BIT(11)
> +#define MVPP2_GMAC_PORT_FIFO_CFG_1_REG		0x1c
> +#define     MVPP2_GMAC_TX_FIFO_MIN_TH_OFFS	6
> +#define     MVPP2_GMAC_TX_FIFO_MIN_TH_ALL_MASK	0x1fc0
> +#define     MVPP2_GMAC_TX_FIFO_MIN_TH_MASK(v)	(((v) << 6) & \
> +					MVPP2_GMAC_TX_FIFO_MIN_TH_ALL_MASK)
> +#define MVPP22_GMAC_INT_STAT			0x20
> +#define     MVPP22_GMAC_INT_STAT_LINK		BIT(1)
> +#define MVPP22_GMAC_INT_MASK			0x24
> +#define     MVPP22_GMAC_INT_MASK_LINK_STAT	BIT(1)
> +#define MVPP22_GMAC_CTRL_4_REG			0x90
> +#define     MVPP22_CTRL4_EXT_PIN_GMII_SEL	BIT(0)
> +#define     MVPP22_CTRL4_RX_FC_EN		BIT(3)
> +#define     MVPP22_CTRL4_TX_FC_EN		BIT(4)
> +#define     MVPP22_CTRL4_DP_CLK_SEL		BIT(5)
> +#define     MVPP22_CTRL4_SYNC_BYPASS_DIS	BIT(6)
> +#define     MVPP22_CTRL4_QSGMII_BYPASS_ACTIVE	BIT(7)
> +#define MVPP22_GMAC_INT_SUM_MASK		0xa4
> +#define     MVPP22_GMAC_INT_SUM_MASK_LINK_STAT	BIT(1)
> +
> +/* Per-port XGMAC registers. PPv2.2 only, only for GOP port 0,
> + * relative to port->base.
> + */
> +#define MVPP22_XLG_CTRL0_REG			0x100
> +#define     MVPP22_XLG_CTRL0_PORT_EN		BIT(0)
> +#define     MVPP22_XLG_CTRL0_MAC_RESET_DIS	BIT(1)
> +#define     MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN	BIT(7)
> +#define     MVPP22_XLG_CTRL0_TX_FLOW_CTRL_EN	BIT(8)
> +#define     MVPP22_XLG_CTRL0_MIB_CNT_DIS	BIT(14)
> +#define MVPP22_XLG_CTRL1_REG			0x104
> +#define     MVPP22_XLG_CTRL1_FRAMESIZELIMIT_OFFS	0
> +#define     MVPP22_XLG_CTRL1_FRAMESIZELIMIT_MASK	0x1fff
> +#define MVPP22_XLG_STATUS			0x10c
> +#define     MVPP22_XLG_STATUS_LINK_UP		BIT(0)
> +#define MVPP22_XLG_INT_STAT			0x114
> +#define     MVPP22_XLG_INT_STAT_LINK		BIT(1)
> +#define MVPP22_XLG_INT_MASK			0x118
> +#define     MVPP22_XLG_INT_MASK_LINK		BIT(1)
> +#define MVPP22_XLG_CTRL3_REG			0x11c
> +#define     MVPP22_XLG_CTRL3_MACMODESELECT_MASK	(7 << 13)
> +#define     MVPP22_XLG_CTRL3_MACMODESELECT_GMAC	(0 << 13)
> +#define     MVPP22_XLG_CTRL3_MACMODESELECT_10G	(1 << 13)
> +#define MVPP22_XLG_EXT_INT_MASK			0x15c
> +#define     MVPP22_XLG_EXT_INT_MASK_XLG		BIT(1)
> +#define     MVPP22_XLG_EXT_INT_MASK_GIG		BIT(2)
> +#define MVPP22_XLG_CTRL4_REG			0x184
> +#define     MVPP22_XLG_CTRL4_FWD_FC		BIT(5)
> +#define     MVPP22_XLG_CTRL4_FWD_PFC		BIT(6)
> +#define     MVPP22_XLG_CTRL4_MACMODSELECT_GMAC	BIT(12)
> +#define     MVPP22_XLG_CTRL4_EN_IDLE_CHECK	BIT(14)
> +
> +/* SMI registers. PPv2.2 only, relative to priv->iface_base. */
> +#define MVPP22_SMI_MISC_CFG_REG			0x1204
> +#define     MVPP22_SMI_POLLING_EN		BIT(10)
> +
> +#define MVPP22_GMAC_BASE(port)		(0x7000 + (port) * 0x1000 + 0xe00)
> +
> +#define MVPP2_CAUSE_TXQ_SENT_DESC_ALL_MASK	0xff
> +
> +/* Descriptor ring Macros */
> +#define MVPP2_QUEUE_NEXT_DESC(q, index) \
> +	(((index) < (q)->last_desc) ? ((index) + 1) : 0)
> +
> +/* XPCS registers. PPv2.2 only */
> +#define MVPP22_MPCS_BASE(port)			(0x7000 + (port) * 0x1000)
> +#define MVPP22_MPCS_CTRL			0x14
> +#define     MVPP22_MPCS_CTRL_FWD_ERR_CONN	BIT(10)
> +#define MVPP22_MPCS_CLK_RESET			0x14c
> +#define     MAC_CLK_RESET_SD_TX			BIT(0)
> +#define     MAC_CLK_RESET_SD_RX			BIT(1)
> +#define     MAC_CLK_RESET_MAC			BIT(2)
> +#define     MVPP22_MPCS_CLK_RESET_DIV_RATIO(n)	((n) << 4)
> +#define     MVPP22_MPCS_CLK_RESET_DIV_SET	BIT(11)
> +
> +/* XPCS registers. PPv2.2 only */
> +#define MVPP22_XPCS_BASE(port)			(0x7400 + (port) * 0x1000)
> +#define MVPP22_XPCS_CFG0			0x0
> +#define     MVPP22_XPCS_CFG0_PCS_MODE(n)	((n) << 3)
> +#define     MVPP22_XPCS_CFG0_ACTIVE_LANE(n)	((n) << 5)
> +
> +/* System controller registers. Accessed through a regmap. */
> +#define GENCONF_SOFT_RESET1				0x1108
> +#define     GENCONF_SOFT_RESET1_GOP			BIT(6)
> +#define GENCONF_PORT_CTRL0				0x1110
> +#define     GENCONF_PORT_CTRL0_BUS_WIDTH_SELECT		BIT(1)
> +#define     GENCONF_PORT_CTRL0_RX_DATA_SAMPLE		BIT(29)
> +#define     GENCONF_PORT_CTRL0_CLK_DIV_PHASE_CLR	BIT(31)
> +#define GENCONF_PORT_CTRL1				0x1114
> +#define     GENCONF_PORT_CTRL1_EN(p)			BIT(p)
> +#define     GENCONF_PORT_CTRL1_RESET(p)			(BIT(p) << 28)
> +#define GENCONF_CTRL0					0x1120
> +#define     GENCONF_CTRL0_PORT0_RGMII			BIT(0)
> +#define     GENCONF_CTRL0_PORT1_RGMII_MII		BIT(1)
> +#define     GENCONF_CTRL0_PORT1_RGMII			BIT(2)
> +
> +/* Various constants */
> +
> +/* Coalescing */
> +#define MVPP2_TXDONE_COAL_PKTS_THRESH	64
> +#define MVPP2_TXDONE_HRTIMER_PERIOD_NS	1000000UL
> +#define MVPP2_TXDONE_COAL_USEC		1000
> +#define MVPP2_RX_COAL_PKTS		32
> +#define MVPP2_RX_COAL_USEC		64
> +
> +/* The two bytes Marvell header. Either contains a special value used
> + * by Marvell switches when a specific hardware mode is enabled (not
> + * supported by this driver) or is filled automatically by zeroes on
> + * the RX side. Those two bytes being at the front of the Ethernet
> + * header, they allow to have the IP header aligned on a 4 bytes
> + * boundary automatically: the hardware skips those two bytes on its
> + * own.
> + */
> +#define MVPP2_MH_SIZE			2
> +#define MVPP2_ETH_TYPE_LEN		2
> +#define MVPP2_PPPOE_HDR_SIZE		8
> +#define MVPP2_VLAN_TAG_LEN		4
> +#define MVPP2_VLAN_TAG_EDSA_LEN		8
> +
> +/* Lbtd 802.3 type */
> +#define MVPP2_IP_LBDT_TYPE		0xfffa
> +
> +#define MVPP2_TX_CSUM_MAX_SIZE		9800
> +
> +/* Timeout constants */
> +#define MVPP2_TX_DISABLE_TIMEOUT_MSEC	1000
> +#define MVPP2_TX_PENDING_TIMEOUT_MSEC	1000
> +
> +#define MVPP2_TX_MTU_MAX		0x7ffff
> +
> +/* Maximum number of T-CONTs of PON port */
> +#define MVPP2_MAX_TCONT			16
> +
> +/* Maximum number of supported ports */
> +#define MVPP2_MAX_PORTS			4
> +
> +/* Maximum number of TXQs used by single port */
> +#define MVPP2_MAX_TXQ			8
> +
> +/* MVPP2_MAX_TSO_SEGS is the maximum number of fragments to allow in the GSO
> + * skb. As we need a maxium of two descriptors per fragments (1 header, 1 data),
> + * multiply this value by two to count the maximum number of skb descs needed.
> + */
> +#define MVPP2_MAX_TSO_SEGS		300
> +#define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
> +
> +/* Dfault number of RXQs in use */
> +#define MVPP2_DEFAULT_RXQ		4
> +
> +/* Max number of Rx descriptors */
> +#define MVPP2_MAX_RXD_MAX		1024
> +#define MVPP2_MAX_RXD_DFLT		128
> +
> +/* Max number of Tx descriptors */
> +#define MVPP2_MAX_TXD_MAX		2048
> +#define MVPP2_MAX_TXD_DFLT		1024
> +
> +/* Amount of Tx descriptors that can be reserved at once by CPU */
> +#define MVPP2_CPU_DESC_CHUNK		64
> +
> +/* Max number of Tx descriptors in each aggregated queue */
> +#define MVPP2_AGGR_TXQ_SIZE		256
> +
> +/* Descriptor aligned size */
> +#define MVPP2_DESC_ALIGNED_SIZE		32
> +
> +/* Descriptor alignment mask */
> +#define MVPP2_TX_DESC_ALIGN		(MVPP2_DESC_ALIGNED_SIZE - 1)
> +
> +/* RX FIFO constants */
> +#define MVPP2_RX_FIFO_PORT_DATA_SIZE_32KB	0x8000
> +#define MVPP2_RX_FIFO_PORT_DATA_SIZE_8KB	0x2000
> +#define MVPP2_RX_FIFO_PORT_DATA_SIZE_4KB	0x1000
> +#define MVPP2_RX_FIFO_PORT_ATTR_SIZE_32KB	0x200
> +#define MVPP2_RX_FIFO_PORT_ATTR_SIZE_8KB	0x80
> +#define MVPP2_RX_FIFO_PORT_ATTR_SIZE_4KB	0x40
> +#define MVPP2_RX_FIFO_PORT_MIN_PKT		0x80
> +
> +/* TX FIFO constants */
> +#define MVPP22_TX_FIFO_DATA_SIZE_10KB		0xa
> +#define MVPP22_TX_FIFO_DATA_SIZE_3KB		0x3
> +#define MVPP2_TX_FIFO_THRESHOLD_MIN		256
> +#define MVPP2_TX_FIFO_THRESHOLD_10KB	\
> +	(MVPP22_TX_FIFO_DATA_SIZE_10KB * 1024 - MVPP2_TX_FIFO_THRESHOLD_MIN)
> +#define MVPP2_TX_FIFO_THRESHOLD_3KB	\
> +	(MVPP22_TX_FIFO_DATA_SIZE_3KB * 1024 - MVPP2_TX_FIFO_THRESHOLD_MIN)
> +
> +/* RX buffer constants */
> +#define MVPP2_SKB_SHINFO_SIZE \
> +	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
> +
> +#define MVPP2_RX_PKT_SIZE(mtu) \
> +	ALIGN((mtu) + MVPP2_MH_SIZE + MVPP2_VLAN_TAG_LEN + \
> +	      ETH_HLEN + ETH_FCS_LEN, cache_line_size())
> +
> +#define MVPP2_RX_BUF_SIZE(pkt_size)	((pkt_size) + NET_SKB_PAD)
> +#define MVPP2_RX_TOTAL_SIZE(buf_size)	((buf_size) + MVPP2_SKB_SHINFO_SIZE)
> +#define MVPP2_RX_MAX_PKT_SIZE(total_size) \
> +	((total_size) - NET_SKB_PAD - MVPP2_SKB_SHINFO_SIZE)
> +
> +#define MVPP2_BIT_TO_BYTE(bit)		((bit) / 8)
> +
> +/* IPv6 max L3 address size */
> +#define MVPP2_MAX_L3_ADDR_SIZE		16
> +
> +/* Port flags */
> +#define MVPP2_F_LOOPBACK		BIT(0)
> +
> +/* Marvell tag types */
> +enum mvpp2_tag_type {
> +	MVPP2_TAG_TYPE_NONE = 0,
> +	MVPP2_TAG_TYPE_MH   = 1,
> +	MVPP2_TAG_TYPE_DSA  = 2,
> +	MVPP2_TAG_TYPE_EDSA = 3,
> +	MVPP2_TAG_TYPE_VLAN = 4,
> +	MVPP2_TAG_TYPE_LAST = 5
> +};
> +
> +/* L2 cast enum */
> +enum mvpp2_prs_l2_cast {
> +	MVPP2_PRS_L2_UNI_CAST,
> +	MVPP2_PRS_L2_MULTI_CAST,
> +};
> +
> +/* L3 cast enum */
> +enum mvpp2_prs_l3_cast {
> +	MVPP2_PRS_L3_UNI_CAST,
> +	MVPP2_PRS_L3_MULTI_CAST,
> +	MVPP2_PRS_L3_BROAD_CAST
> +};
> +
> +/* BM constants */
> +#define MVPP2_BM_JUMBO_BUF_NUM		512
> +#define MVPP2_BM_LONG_BUF_NUM		1024
> +#define MVPP2_BM_SHORT_BUF_NUM		2048
> +#define MVPP2_BM_POOL_SIZE_MAX		(16*1024 - MVPP2_BM_POOL_PTR_ALIGN/4)
> +#define MVPP2_BM_POOL_PTR_ALIGN		128
> +
> +/* BM cookie (32 bits) definition */
> +#define MVPP2_BM_COOKIE_POOL_OFFS	8
> +#define MVPP2_BM_COOKIE_CPU_OFFS	24
> +
> +#define MVPP2_BM_SHORT_FRAME_SIZE		512
> +#define MVPP2_BM_LONG_FRAME_SIZE		2048
> +#define MVPP2_BM_JUMBO_FRAME_SIZE		10240
> +/* BM short pool packet size
> + * These value assure that for SWF the total number
> + * of bytes allocated for each buffer will be 512
> + */
> +#define MVPP2_BM_SHORT_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_SHORT_FRAME_SIZE)
> +#define MVPP2_BM_LONG_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_LONG_FRAME_SIZE)
> +#define MVPP2_BM_JUMBO_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_JUMBO_FRAME_SIZE)
> +
> +#define MVPP21_ADDR_SPACE_SZ		0
> +#define MVPP22_ADDR_SPACE_SZ		SZ_64K
> +
> +#define MVPP2_MAX_THREADS		8
> +#define MVPP2_MAX_QVECS			MVPP2_MAX_THREADS
> +
> +/* GMAC MIB Counters register definitions */
> +#define MVPP21_MIB_COUNTERS_OFFSET		0x1000
> +#define MVPP21_MIB_COUNTERS_PORT_SZ		0x400
> +#define MVPP22_MIB_COUNTERS_OFFSET		0x0
> +#define MVPP22_MIB_COUNTERS_PORT_SZ		0x100
> +
> +#define MVPP2_MIB_GOOD_OCTETS_RCVD		0x0
> +#define MVPP2_MIB_BAD_OCTETS_RCVD		0x8
> +#define MVPP2_MIB_CRC_ERRORS_SENT		0xc
> +#define MVPP2_MIB_UNICAST_FRAMES_RCVD		0x10
> +#define MVPP2_MIB_BROADCAST_FRAMES_RCVD		0x18
> +#define MVPP2_MIB_MULTICAST_FRAMES_RCVD		0x1c
> +#define MVPP2_MIB_FRAMES_64_OCTETS		0x20
> +#define MVPP2_MIB_FRAMES_65_TO_127_OCTETS	0x24
> +#define MVPP2_MIB_FRAMES_128_TO_255_OCTETS	0x28
> +#define MVPP2_MIB_FRAMES_256_TO_511_OCTETS	0x2c
> +#define MVPP2_MIB_FRAMES_512_TO_1023_OCTETS	0x30
> +#define MVPP2_MIB_FRAMES_1024_TO_MAX_OCTETS	0x34
> +#define MVPP2_MIB_GOOD_OCTETS_SENT		0x38
> +#define MVPP2_MIB_UNICAST_FRAMES_SENT		0x40
> +#define MVPP2_MIB_MULTICAST_FRAMES_SENT		0x48
> +#define MVPP2_MIB_BROADCAST_FRAMES_SENT		0x4c
> +#define MVPP2_MIB_FC_SENT			0x54
> +#define MVPP2_MIB_FC_RCVD			0x58
> +#define MVPP2_MIB_RX_FIFO_OVERRUN		0x5c
> +#define MVPP2_MIB_UNDERSIZE_RCVD		0x60
> +#define MVPP2_MIB_FRAGMENTS_RCVD		0x64
> +#define MVPP2_MIB_OVERSIZE_RCVD			0x68
> +#define MVPP2_MIB_JABBER_RCVD			0x6c
> +#define MVPP2_MIB_MAC_RCV_ERROR			0x70
> +#define MVPP2_MIB_BAD_CRC_EVENT			0x74
> +#define MVPP2_MIB_COLLISION			0x78
> +#define MVPP2_MIB_LATE_COLLISION		0x7c
> +
> +#define MVPP2_MIB_COUNTERS_STATS_DELAY		(1 * HZ)
> +
> +#define MVPP2_DESC_DMA_MASK	DMA_BIT_MASK(40)
> +
> +/* Definitions */
> +
> +/* Shared Packet Processor resources */
> +struct mvpp2 {
> +	/* Shared registers' base addresses */
> +	void __iomem *lms_base;
> +	void __iomem *iface_base;
> +
> +	/* On PPv2.2, each "software thread" can access the base
> +	 * register through a separate address space, each 64 KB apart
> +	 * from each other. Typically, such address spaces will be
> +	 * used per CPU.
> +	 */
> +	void __iomem *swth_base[MVPP2_MAX_THREADS];
> +
> +	/* On PPv2.2, some port control registers are located into the system
> +	 * controller space. These registers are accessible through a regmap.
> +	 */
> +	struct regmap *sysctrl_base;
> +
> +	/* Common clocks */
> +	struct clk *pp_clk;
> +	struct clk *gop_clk;
> +	struct clk *mg_clk;
> +	struct clk *mg_core_clk;
> +	struct clk *axi_clk;
> +
> +	/* List of pointers to port structures */
> +	int port_count;
> +	struct mvpp2_port *port_list[MVPP2_MAX_PORTS];
> +
> +	/* Aggregated TXQs */
> +	struct mvpp2_tx_queue *aggr_txqs;
> +
> +	/* BM pools */
> +	struct mvpp2_bm_pool *bm_pools;
> +
> +	/* PRS shadow table */
> +	struct mvpp2_prs_shadow *prs_shadow;
> +	/* PRS auxiliary table for double vlan entries control */
> +	bool *prs_double_vlans;
> +
> +	/* Tclk value */
> +	u32 tclk;
> +
> +	/* HW version */
> +	enum { MVPP21, MVPP22 } hw_version;
> +
> +	/* Maximum number of RXQs per port */
> +	unsigned int max_port_rxqs;
> +
> +	/* Workqueue to gather hardware statistics */
> +	char queue_name[30];
> +	struct workqueue_struct *stats_queue;
> +};
> +
> +struct mvpp2_pcpu_stats {
> +	struct	u64_stats_sync syncp;
> +	u64	rx_packets;
> +	u64	rx_bytes;
> +	u64	tx_packets;
> +	u64	tx_bytes;
> +};
> +
> +/* Per-CPU port control */
> +struct mvpp2_port_pcpu {
> +	struct hrtimer tx_done_timer;
> +	bool timer_scheduled;
> +	/* Tasklet for egress finalization */
> +	struct tasklet_struct tx_done_tasklet;
> +};
> +
> +struct mvpp2_queue_vector {
> +	int irq;
> +	struct napi_struct napi;
> +	enum { MVPP2_QUEUE_VECTOR_SHARED, MVPP2_QUEUE_VECTOR_PRIVATE } type;
> +	int sw_thread_id;
> +	u16 sw_thread_mask;
> +	int first_rxq;
> +	int nrxqs;
> +	u32 pending_cause_rx;
> +	struct mvpp2_port *port;
> +};
> +
> +struct mvpp2_port {
> +	u8 id;
> +
> +	/* Index of the port from the "group of ports" complex point
> +	 * of view
> +	 */
> +	int gop_id;
> +
> +	int link_irq;
> +
> +	struct mvpp2 *priv;
> +
> +	/* Firmware node associated to the port */
> +	struct fwnode_handle *fwnode;
> +
> +	/* Is a PHY always connected to the port */
> +	bool has_phy;
> +
> +	/* Per-port registers' base address */
> +	void __iomem *base;
> +	void __iomem *stats_base;
> +
> +	struct mvpp2_rx_queue **rxqs;
> +	unsigned int nrxqs;
> +	struct mvpp2_tx_queue **txqs;
> +	unsigned int ntxqs;
> +	struct net_device *dev;
> +
> +	int pkt_size;
> +
> +	/* Per-CPU port control */
> +	struct mvpp2_port_pcpu __percpu *pcpu;
> +
> +	/* Flags */
> +	unsigned long flags;
> +
> +	u16 tx_ring_size;
> +	u16 rx_ring_size;
> +	struct mvpp2_pcpu_stats __percpu *stats;
> +	u64 *ethtool_stats;
> +
> +	/* Per-port work and its lock to gather hardware statistics */
> +	struct mutex gather_stats_lock;
> +	struct delayed_work stats_work;
> +
> +	struct device_node *of_node;
> +
> +	phy_interface_t phy_interface;
> +	struct phylink *phylink;
> +	struct phy *comphy;
> +
> +	struct mvpp2_bm_pool *pool_long;
> +	struct mvpp2_bm_pool *pool_short;
> +
> +	/* Index of first port's physical RXQ */
> +	u8 first_rxq;
> +
> +	struct mvpp2_queue_vector qvecs[MVPP2_MAX_QVECS];
> +	unsigned int nqvecs;
> +	bool has_tx_irqs;
> +
> +	u32 tx_time_coal;
> +};
> +
> +/* The mvpp2_tx_desc and mvpp2_rx_desc structures describe the
> + * layout of the transmit and reception DMA descriptors, and their
> + * layout is therefore defined by the hardware design
> + */
> +
> +#define MVPP2_TXD_L3_OFF_SHIFT		0
> +#define MVPP2_TXD_IP_HLEN_SHIFT		8
> +#define MVPP2_TXD_L4_CSUM_FRAG		BIT(13)
> +#define MVPP2_TXD_L4_CSUM_NOT		BIT(14)
> +#define MVPP2_TXD_IP_CSUM_DISABLE	BIT(15)
> +#define MVPP2_TXD_PADDING_DISABLE	BIT(23)
> +#define MVPP2_TXD_L4_UDP		BIT(24)
> +#define MVPP2_TXD_L3_IP6		BIT(26)
> +#define MVPP2_TXD_L_DESC		BIT(28)
> +#define MVPP2_TXD_F_DESC		BIT(29)
> +
> +#define MVPP2_RXD_ERR_SUMMARY		BIT(15)
> +#define MVPP2_RXD_ERR_CODE_MASK		(BIT(13) | BIT(14))
> +#define MVPP2_RXD_ERR_CRC		0x0
> +#define MVPP2_RXD_ERR_OVERRUN		BIT(13)
> +#define MVPP2_RXD_ERR_RESOURCE		(BIT(13) | BIT(14))
> +#define MVPP2_RXD_BM_POOL_ID_OFFS	16
> +#define MVPP2_RXD_BM_POOL_ID_MASK	(BIT(16) | BIT(17) | BIT(18))
> +#define MVPP2_RXD_HWF_SYNC		BIT(21)
> +#define MVPP2_RXD_L4_CSUM_OK		BIT(22)
> +#define MVPP2_RXD_IP4_HEADER_ERR	BIT(24)
> +#define MVPP2_RXD_L4_TCP		BIT(25)
> +#define MVPP2_RXD_L4_UDP		BIT(26)
> +#define MVPP2_RXD_L3_IP4		BIT(28)
> +#define MVPP2_RXD_L3_IP6		BIT(30)
> +#define MVPP2_RXD_BUF_HDR		BIT(31)
> +
> +/* HW TX descriptor for PPv2.1 */
> +struct mvpp21_tx_desc {
> +	u32 command;		/* Options used by HW for packet transmitting.*/
> +	u8  packet_offset;	/* the offset from the buffer beginning	*/
> +	u8  phys_txq;		/* destination queue ID			*/
> +	u16 data_size;		/* data size of transmitted packet in bytes */
> +	u32 buf_dma_addr;	/* physical addr of transmitted buffer	*/
> +	u32 buf_cookie;		/* cookie for access to TX buffer in tx path */
> +	u32 reserved1[3];	/* hw_cmd (for future use, BM, PON, PNC) */
> +	u32 reserved2;		/* reserved (for future use)		*/
> +};
> +
> +/* HW RX descriptor for PPv2.1 */
> +struct mvpp21_rx_desc {
> +	u32 status;		/* info about received packet		*/
> +	u16 reserved1;		/* parser_info (for future use, PnC)	*/
> +	u16 data_size;		/* size of received packet in bytes	*/
> +	u32 buf_dma_addr;	/* physical address of the buffer	*/
> +	u32 buf_cookie;		/* cookie for access to RX buffer in rx path */
> +	u16 reserved2;		/* gem_port_id (for future use, PON)	*/
> +	u16 reserved3;		/* csum_l4 (for future use, PnC)	*/
> +	u8  reserved4;		/* bm_qset (for future use, BM)		*/
> +	u8  reserved5;
> +	u16 reserved6;		/* classify_info (for future use, PnC)	*/
> +	u32 reserved7;		/* flow_id (for future use, PnC) */
> +	u32 reserved8;
> +};
> +
> +/* HW TX descriptor for PPv2.2 */
> +struct mvpp22_tx_desc {
> +	u32 command;
> +	u8  packet_offset;
> +	u8  phys_txq;
> +	u16 data_size;
> +	u64 reserved1;
> +	u64 buf_dma_addr_ptp;
> +	u64 buf_cookie_misc;
> +};
> +
> +/* HW RX descriptor for PPv2.2 */
> +struct mvpp22_rx_desc {
> +	u32 status;
> +	u16 reserved1;
> +	u16 data_size;
> +	u32 reserved2;
> +	u32 reserved3;
> +	u64 buf_dma_addr_key_hash;
> +	u64 buf_cookie_misc;
> +};
> +
> +/* Opaque type used by the driver to manipulate the HW TX and RX
> + * descriptors
> + */
> +struct mvpp2_tx_desc {
> +	union {
> +		struct mvpp21_tx_desc pp21;
> +		struct mvpp22_tx_desc pp22;
> +	};
> +};
> +
> +struct mvpp2_rx_desc {
> +	union {
> +		struct mvpp21_rx_desc pp21;
> +		struct mvpp22_rx_desc pp22;
> +	};
> +};
> +
> +struct mvpp2_txq_pcpu_buf {
> +	/* Transmitted SKB */
> +	struct sk_buff *skb;
> +
> +	/* Physical address of transmitted buffer */
> +	dma_addr_t dma;
> +
> +	/* Size transmitted */
> +	size_t size;
> +};
> +
> +/* Per-CPU Tx queue control */
> +struct mvpp2_txq_pcpu {
> +	int cpu;
> +
> +	/* Number of Tx DMA descriptors in the descriptor ring */
> +	int size;
> +
> +	/* Number of currently used Tx DMA descriptor in the
> +	 * descriptor ring
> +	 */
> +	int count;
> +
> +	int wake_threshold;
> +	int stop_threshold;
> +
> +	/* Number of Tx DMA descriptors reserved for each CPU */
> +	int reserved_num;
> +
> +	/* Infos about transmitted buffers */
> +	struct mvpp2_txq_pcpu_buf *buffs;
> +
> +	/* Index of last TX DMA descriptor that was inserted */
> +	int txq_put_index;
> +
> +	/* Index of the TX DMA descriptor to be cleaned up */
> +	int txq_get_index;
> +
> +	/* DMA buffer for TSO headers */
> +	char *tso_headers;
> +	dma_addr_t tso_headers_dma;
> +};
> +
> +struct mvpp2_tx_queue {
> +	/* Physical number of this Tx queue */
> +	u8 id;
> +
> +	/* Logical number of this Tx queue */
> +	u8 log_id;
> +
> +	/* Number of Tx DMA descriptors in the descriptor ring */
> +	int size;
> +
> +	/* Number of currently used Tx DMA descriptor in the descriptor ring */
> +	int count;
> +
> +	/* Per-CPU control of physical Tx queues */
> +	struct mvpp2_txq_pcpu __percpu *pcpu;
> +
> +	u32 done_pkts_coal;
> +
> +	/* Virtual address of thex Tx DMA descriptors array */
> +	struct mvpp2_tx_desc *descs;
> +
> +	/* DMA address of the Tx DMA descriptors array */
> +	dma_addr_t descs_dma;
> +
> +	/* Index of the last Tx DMA descriptor */
> +	int last_desc;
> +
> +	/* Index of the next Tx DMA descriptor to process */
> +	int next_desc_to_proc;
> +};
> +
> +struct mvpp2_rx_queue {
> +	/* RX queue number, in the range 0-31 for physical RXQs */
> +	u8 id;
> +
> +	/* Num of rx descriptors in the rx descriptor ring */
> +	int size;
> +
> +	u32 pkts_coal;
> +	u32 time_coal;
> +
> +	/* Virtual address of the RX DMA descriptors array */
> +	struct mvpp2_rx_desc *descs;
> +
> +	/* DMA address of the RX DMA descriptors array */
> +	dma_addr_t descs_dma;
> +
> +	/* Index of the last RX DMA descriptor */
> +	int last_desc;
> +
> +	/* Index of the next RX DMA descriptor to process */
> +	int next_desc_to_proc;
> +
> +	/* ID of port to which physical RXQ is mapped */
> +	int port;
> +
> +	/* Port's logic RXQ number to which physical RXQ is mapped */
> +	int logic_rxq;
> +};
> +
> +struct mvpp2_bm_pool {
> +	/* Pool number in the range 0-7 */
> +	int id;
> +
> +	/* Buffer Pointers Pool External (BPPE) size */
> +	int size;
> +	/* BPPE size in bytes */
> +	int size_bytes;
> +	/* Number of buffers for this pool */
> +	int buf_num;
> +	/* Pool buffer size */
> +	int buf_size;
> +	/* Packet size */
> +	int pkt_size;
> +	int frag_size;
> +
> +	/* BPPE virtual base address */
> +	u32 *virt_addr;
> +	/* BPPE DMA base address */
> +	dma_addr_t dma_addr;
> +
> +	/* Ports using BM pool */
> +	u32 port_map;
> +};
> +
> +#define IS_TSO_HEADER(txq_pcpu, addr) \
> +	((addr) >= (txq_pcpu)->tso_headers_dma && \
> +	 (addr) < (txq_pcpu)->tso_headers_dma + \
> +	 (txq_pcpu)->size * TSO_HEADER_SIZE)
> +
> +#define MVPP2_DRIVER_NAME "mvpp2"
> +#define MVPP2_DRIVER_VERSION "1.0"
> +
> +void mvpp2_write(struct mvpp2 *priv, u32 offset, u32 data);
> +u32 mvpp2_read(struct mvpp2 *priv, u32 offset);
> +
> +u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset);
> +
> +void mvpp2_percpu_write(struct mvpp2 *priv, int cpu, u32 offset, u32 data);
> +u32 mvpp2_percpu_read(struct mvpp2 *priv, int cpu, u32 offset);
> +
> +void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, int cpu, u32 offset,
> +				u32 data);
> +
> +#endif
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
> new file mode 100644
> index 000000000000..8581d5b17dd5
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
> @@ -0,0 +1,141 @@
> +/*
> + * RSS and Classifier helpers for Marvell PPv2 Network Controller
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Marcin Wojtas <mw@semihalf.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include "mvpp2.h"
> +#include "mvpp2_cls.h"
> +
> +/* Update classification flow table registers */
> +static void mvpp2_cls_flow_write(struct mvpp2 *priv,
> +				 struct mvpp2_cls_flow_entry *fe)
> +{
> +	mvpp2_write(priv, MVPP2_CLS_FLOW_INDEX_REG, fe->index);
> +	mvpp2_write(priv, MVPP2_CLS_FLOW_TBL0_REG,  fe->data[0]);
> +	mvpp2_write(priv, MVPP2_CLS_FLOW_TBL1_REG,  fe->data[1]);
> +	mvpp2_write(priv, MVPP2_CLS_FLOW_TBL2_REG,  fe->data[2]);
> +}
> +
> +/* Update classification lookup table register */
> +static void mvpp2_cls_lookup_write(struct mvpp2 *priv,
> +				   struct mvpp2_cls_lookup_entry *le)
> +{
> +	u32 val;
> +
> +	val = (le->way << MVPP2_CLS_LKP_INDEX_WAY_OFFS) | le->lkpid;
> +	mvpp2_write(priv, MVPP2_CLS_LKP_INDEX_REG, val);
> +	mvpp2_write(priv, MVPP2_CLS_LKP_TBL_REG, le->data);
> +}
> +
> +/* Classifier default initialization */
> +void mvpp2_cls_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_cls_lookup_entry le;
> +	struct mvpp2_cls_flow_entry fe;
> +	int index;
> +
> +	/* Enable classifier */
> +	mvpp2_write(priv, MVPP2_CLS_MODE_REG, MVPP2_CLS_MODE_ACTIVE_MASK);
> +
> +	/* Clear classifier flow table */
> +	memset(&fe.data, 0, sizeof(fe.data));
> +	for (index = 0; index < MVPP2_CLS_FLOWS_TBL_SIZE; index++) {
> +		fe.index = index;
> +		mvpp2_cls_flow_write(priv, &fe);
> +	}
> +
> +	/* Clear classifier lookup table */
> +	le.data = 0;
> +	for (index = 0; index < MVPP2_CLS_LKP_TBL_SIZE; index++) {
> +		le.lkpid = index;
> +		le.way = 0;
> +		mvpp2_cls_lookup_write(priv, &le);
> +
> +		le.way = 1;
> +		mvpp2_cls_lookup_write(priv, &le);
> +	}
> +}
> +
> +void mvpp2_cls_port_config(struct mvpp2_port *port)
> +{
> +	struct mvpp2_cls_lookup_entry le;
> +	u32 val;
> +
> +	/* Set way for the port */
> +	val = mvpp2_read(port->priv, MVPP2_CLS_PORT_WAY_REG);
> +	val &= ~MVPP2_CLS_PORT_WAY_MASK(port->id);
> +	mvpp2_write(port->priv, MVPP2_CLS_PORT_WAY_REG, val);
> +
> +	/* Pick the entry to be accessed in lookup ID decoding table
> +	 * according to the way and lkpid.
> +	 */
> +	le.lkpid = port->id;
> +	le.way = 0;
> +	le.data = 0;
> +
> +	/* Set initial CPU queue for receiving packets */
> +	le.data &= ~MVPP2_CLS_LKP_TBL_RXQ_MASK;
> +	le.data |= port->first_rxq;
> +
> +	/* Disable classification engines */
> +	le.data &= ~MVPP2_CLS_LKP_TBL_LOOKUP_EN_MASK;
> +
> +	/* Update lookup ID table entry */
> +	mvpp2_cls_lookup_write(port->priv, &le);
> +}
> +
> +/* Set CPU queue number for oversize packets */
> +void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port)
> +{
> +	u32 val;
> +
> +	mvpp2_write(port->priv, MVPP2_CLS_OVERSIZE_RXQ_LOW_REG(port->id),
> +		    port->first_rxq & MVPP2_CLS_OVERSIZE_RXQ_LOW_MASK);
> +
> +	mvpp2_write(port->priv, MVPP2_CLS_SWFWD_P2HQ_REG(port->id),
> +		    (port->first_rxq >> MVPP2_CLS_OVERSIZE_RXQ_LOW_BITS));
> +
> +	val = mvpp2_read(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG);
> +	val |= MVPP2_CLS_SWFWD_PCTRL_MASK(port->id);
> +	mvpp2_write(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG, val);
> +}
> +
> +void mvpp22_init_rss(struct mvpp2_port *port)
> +{
> +	struct mvpp2 *priv = port->priv;
> +	int i;
> +
> +	/* Set the table width: replace the whole classifier Rx queue number
> +	 * with the ones configured in RSS table entries.
> +	 */
> +	mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_TABLE(0));
> +	mvpp2_write(priv, MVPP22_RSS_WIDTH, 8);
> +
> +	/* Loop through the classifier Rx Queues and map them to a RSS table.
> +	 * Map them all to the first table (0) by default.
> +	 */
> +	for (i = 0; i < MVPP2_CLS_RX_QUEUES; i++) {
> +		mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_QUEUE(i));
> +		mvpp2_write(priv, MVPP22_RSS_TABLE,
> +			    MVPP22_RSS_TABLE_POINTER(0));
> +	}
> +
> +	/* Configure the first table to evenly distribute the packets across
> +	 * real Rx Queues. The table entries map a hash to an port Rx Queue.
> +	 */
> +	for (i = 0; i < MVPP22_RSS_TABLE_ENTRIES; i++) {
> +		u32 sel = MVPP22_RSS_INDEX_TABLE(0) |
> +			  MVPP22_RSS_INDEX_TABLE_ENTRY(i);
> +		mvpp2_write(priv, MVPP22_RSS_INDEX, sel);
> +
> +		mvpp2_write(priv, MVPP22_RSS_TABLE_ENTRY, i % port->nrxqs);
> +	}
> +
> +}
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
> new file mode 100644
> index 000000000000..8e1d7f9ffa0b
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
> @@ -0,0 +1,44 @@
> +/*
> + * RSS and Classifier definitions for Marvell PPv2 Network Controller
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Marcin Wojtas <mw@semihalf.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef _MVPP2_CLS_H_
> +#define _MVPP2_CLS_H_
> +
> +/* Classifier constants */
> +#define MVPP2_CLS_FLOWS_TBL_SIZE	512
> +#define MVPP2_CLS_FLOWS_TBL_DATA_WORDS	3
> +#define MVPP2_CLS_LKP_TBL_SIZE		64
> +#define MVPP2_CLS_RX_QUEUES		256
> +
> +/* RSS constants */
> +#define MVPP22_RSS_TABLE_ENTRIES	32
> +
> +struct mvpp2_cls_flow_entry {
> +	u32 index;
> +	u32 data[MVPP2_CLS_FLOWS_TBL_DATA_WORDS];
> +};
> +
> +struct mvpp2_cls_lookup_entry {
> +	u32 lkpid;
> +	u32 way;
> +	u32 data;
> +};
> +
> +void mvpp22_init_rss(struct mvpp2_port *port);
> +
> +void mvpp2_cls_init(struct mvpp2 *priv);
> +
> +void mvpp2_cls_port_config(struct mvpp2_port *port);
> +
> +void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port);
> +
> +#endif
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> similarity index 54%
> rename from drivers/net/ethernet/marvell/mvpp2.c
> rename to drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 6847cd431aa0..45622bffd81a 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -40,846 +40,9 @@
>  #include <net/ipv6.h>
>  #include <net/tso.h>
>  
> -/* Fifo Registers */
> -#define MVPP2_RX_DATA_FIFO_SIZE_REG(port)	(0x00 + 4 * (port))
> -#define MVPP2_RX_ATTR_FIFO_SIZE_REG(port)	(0x20 + 4 * (port))
> -#define MVPP2_RX_MIN_PKT_SIZE_REG		0x60
> -#define MVPP2_RX_FIFO_INIT_REG			0x64
> -#define MVPP22_TX_FIFO_THRESH_REG(port)		(0x8840 + 4 * (port))
> -#define MVPP22_TX_FIFO_SIZE_REG(port)		(0x8860 + 4 * (port))
> -
> -/* RX DMA Top Registers */
> -#define MVPP2_RX_CTRL_REG(port)			(0x140 + 4 * (port))
> -#define     MVPP2_RX_LOW_LATENCY_PKT_SIZE(s)	(((s) & 0xfff) << 16)
> -#define     MVPP2_RX_USE_PSEUDO_FOR_CSUM_MASK	BIT(31)
> -#define MVPP2_POOL_BUF_SIZE_REG(pool)		(0x180 + 4 * (pool))
> -#define     MVPP2_POOL_BUF_SIZE_OFFSET		5
> -#define MVPP2_RXQ_CONFIG_REG(rxq)		(0x800 + 4 * (rxq))
> -#define     MVPP2_SNOOP_PKT_SIZE_MASK		0x1ff
> -#define     MVPP2_SNOOP_BUF_HDR_MASK		BIT(9)
> -#define     MVPP2_RXQ_POOL_SHORT_OFFS		20
> -#define     MVPP21_RXQ_POOL_SHORT_MASK		0x700000
> -#define     MVPP22_RXQ_POOL_SHORT_MASK		0xf00000
> -#define     MVPP2_RXQ_POOL_LONG_OFFS		24
> -#define     MVPP21_RXQ_POOL_LONG_MASK		0x7000000
> -#define     MVPP22_RXQ_POOL_LONG_MASK		0xf000000
> -#define     MVPP2_RXQ_PACKET_OFFSET_OFFS	28
> -#define     MVPP2_RXQ_PACKET_OFFSET_MASK	0x70000000
> -#define     MVPP2_RXQ_DISABLE_MASK		BIT(31)
> -
> -/* Top Registers */
> -#define MVPP2_MH_REG(port)			(0x5040 + 4 * (port))
> -#define MVPP2_DSA_EXTENDED			BIT(5)
> -
> -/* Parser Registers */
> -#define MVPP2_PRS_INIT_LOOKUP_REG		0x1000
> -#define     MVPP2_PRS_PORT_LU_MAX		0xf
> -#define     MVPP2_PRS_PORT_LU_MASK(port)	(0xff << ((port) * 4))
> -#define     MVPP2_PRS_PORT_LU_VAL(port, val)	((val) << ((port) * 4))
> -#define MVPP2_PRS_INIT_OFFS_REG(port)		(0x1004 + ((port) & 4))
> -#define     MVPP2_PRS_INIT_OFF_MASK(port)	(0x3f << (((port) % 4) * 8))
> -#define     MVPP2_PRS_INIT_OFF_VAL(port, val)	((val) << (((port) % 4) * 8))
> -#define MVPP2_PRS_MAX_LOOP_REG(port)		(0x100c + ((port) & 4))
> -#define     MVPP2_PRS_MAX_LOOP_MASK(port)	(0xff << (((port) % 4) * 8))
> -#define     MVPP2_PRS_MAX_LOOP_VAL(port, val)	((val) << (((port) % 4) * 8))
> -#define MVPP2_PRS_TCAM_IDX_REG			0x1100
> -#define MVPP2_PRS_TCAM_DATA_REG(idx)		(0x1104 + (idx) * 4)
> -#define     MVPP2_PRS_TCAM_INV_MASK		BIT(31)
> -#define MVPP2_PRS_SRAM_IDX_REG			0x1200
> -#define MVPP2_PRS_SRAM_DATA_REG(idx)		(0x1204 + (idx) * 4)
> -#define MVPP2_PRS_TCAM_CTRL_REG			0x1230
> -#define     MVPP2_PRS_TCAM_EN_MASK		BIT(0)
> -
> -/* RSS Registers */
> -#define MVPP22_RSS_INDEX			0x1500
> -#define     MVPP22_RSS_INDEX_TABLE_ENTRY(idx)	(idx)
> -#define     MVPP22_RSS_INDEX_TABLE(idx)		((idx) << 8)
> -#define     MVPP22_RSS_INDEX_QUEUE(idx)		((idx) << 16)
> -#define MVPP22_RSS_TABLE_ENTRY			0x1508
> -#define MVPP22_RSS_TABLE			0x1510
> -#define     MVPP22_RSS_TABLE_POINTER(p)		(p)
> -#define MVPP22_RSS_WIDTH			0x150c
> -
> -/* Classifier Registers */
> -#define MVPP2_CLS_MODE_REG			0x1800
> -#define     MVPP2_CLS_MODE_ACTIVE_MASK		BIT(0)
> -#define MVPP2_CLS_PORT_WAY_REG			0x1810
> -#define     MVPP2_CLS_PORT_WAY_MASK(port)	(1 << (port))
> -#define MVPP2_CLS_LKP_INDEX_REG			0x1814
> -#define     MVPP2_CLS_LKP_INDEX_WAY_OFFS	6
> -#define MVPP2_CLS_LKP_TBL_REG			0x1818
> -#define     MVPP2_CLS_LKP_TBL_RXQ_MASK		0xff
> -#define     MVPP2_CLS_LKP_TBL_LOOKUP_EN_MASK	BIT(25)
> -#define MVPP2_CLS_FLOW_INDEX_REG		0x1820
> -#define MVPP2_CLS_FLOW_TBL0_REG			0x1824
> -#define MVPP2_CLS_FLOW_TBL1_REG			0x1828
> -#define MVPP2_CLS_FLOW_TBL2_REG			0x182c
> -#define MVPP2_CLS_OVERSIZE_RXQ_LOW_REG(port)	(0x1980 + ((port) * 4))
> -#define     MVPP2_CLS_OVERSIZE_RXQ_LOW_BITS	3
> -#define     MVPP2_CLS_OVERSIZE_RXQ_LOW_MASK	0x7
> -#define MVPP2_CLS_SWFWD_P2HQ_REG(port)		(0x19b0 + ((port) * 4))
> -#define MVPP2_CLS_SWFWD_PCTRL_REG		0x19d0
> -#define     MVPP2_CLS_SWFWD_PCTRL_MASK(port)	(1 << (port))
> -
> -/* Descriptor Manager Top Registers */
> -#define MVPP2_RXQ_NUM_REG			0x2040
> -#define MVPP2_RXQ_DESC_ADDR_REG			0x2044
> -#define     MVPP22_DESC_ADDR_OFFS		8
> -#define MVPP2_RXQ_DESC_SIZE_REG			0x2048
> -#define     MVPP2_RXQ_DESC_SIZE_MASK		0x3ff0
> -#define MVPP2_RXQ_STATUS_UPDATE_REG(rxq)	(0x3000 + 4 * (rxq))
> -#define     MVPP2_RXQ_NUM_PROCESSED_OFFSET	0
> -#define     MVPP2_RXQ_NUM_NEW_OFFSET		16
> -#define MVPP2_RXQ_STATUS_REG(rxq)		(0x3400 + 4 * (rxq))
> -#define     MVPP2_RXQ_OCCUPIED_MASK		0x3fff
> -#define     MVPP2_RXQ_NON_OCCUPIED_OFFSET	16
> -#define     MVPP2_RXQ_NON_OCCUPIED_MASK		0x3fff0000
> -#define MVPP2_RXQ_THRESH_REG			0x204c
> -#define     MVPP2_OCCUPIED_THRESH_OFFSET	0
> -#define     MVPP2_OCCUPIED_THRESH_MASK		0x3fff
> -#define MVPP2_RXQ_INDEX_REG			0x2050
> -#define MVPP2_TXQ_NUM_REG			0x2080
> -#define MVPP2_TXQ_DESC_ADDR_REG			0x2084
> -#define MVPP2_TXQ_DESC_SIZE_REG			0x2088
> -#define     MVPP2_TXQ_DESC_SIZE_MASK		0x3ff0
> -#define MVPP2_TXQ_THRESH_REG			0x2094
> -#define	    MVPP2_TXQ_THRESH_OFFSET		16
> -#define	    MVPP2_TXQ_THRESH_MASK		0x3fff
> -#define MVPP2_AGGR_TXQ_UPDATE_REG		0x2090
> -#define MVPP2_TXQ_INDEX_REG			0x2098
> -#define MVPP2_TXQ_PREF_BUF_REG			0x209c
> -#define     MVPP2_PREF_BUF_PTR(desc)		((desc) & 0xfff)
> -#define     MVPP2_PREF_BUF_SIZE_4		(BIT(12) | BIT(13))
> -#define     MVPP2_PREF_BUF_SIZE_16		(BIT(12) | BIT(14))
> -#define     MVPP2_PREF_BUF_THRESH(val)		((val) << 17)
> -#define     MVPP2_TXQ_DRAIN_EN_MASK		BIT(31)
> -#define MVPP2_TXQ_PENDING_REG			0x20a0
> -#define     MVPP2_TXQ_PENDING_MASK		0x3fff
> -#define MVPP2_TXQ_INT_STATUS_REG		0x20a4
> -#define MVPP2_TXQ_SENT_REG(txq)			(0x3c00 + 4 * (txq))
> -#define     MVPP2_TRANSMITTED_COUNT_OFFSET	16
> -#define     MVPP2_TRANSMITTED_COUNT_MASK	0x3fff0000
> -#define MVPP2_TXQ_RSVD_REQ_REG			0x20b0
> -#define     MVPP2_TXQ_RSVD_REQ_Q_OFFSET		16
> -#define MVPP2_TXQ_RSVD_RSLT_REG			0x20b4
> -#define     MVPP2_TXQ_RSVD_RSLT_MASK		0x3fff
> -#define MVPP2_TXQ_RSVD_CLR_REG			0x20b8
> -#define     MVPP2_TXQ_RSVD_CLR_OFFSET		16
> -#define MVPP2_AGGR_TXQ_DESC_ADDR_REG(cpu)	(0x2100 + 4 * (cpu))
> -#define     MVPP22_AGGR_TXQ_DESC_ADDR_OFFS	8
> -#define MVPP2_AGGR_TXQ_DESC_SIZE_REG(cpu)	(0x2140 + 4 * (cpu))
> -#define     MVPP2_AGGR_TXQ_DESC_SIZE_MASK	0x3ff0
> -#define MVPP2_AGGR_TXQ_STATUS_REG(cpu)		(0x2180 + 4 * (cpu))
> -#define     MVPP2_AGGR_TXQ_PENDING_MASK		0x3fff
> -#define MVPP2_AGGR_TXQ_INDEX_REG(cpu)		(0x21c0 + 4 * (cpu))
> -
> -/* MBUS bridge registers */
> -#define MVPP2_WIN_BASE(w)			(0x4000 + ((w) << 2))
> -#define MVPP2_WIN_SIZE(w)			(0x4020 + ((w) << 2))
> -#define MVPP2_WIN_REMAP(w)			(0x4040 + ((w) << 2))
> -#define MVPP2_BASE_ADDR_ENABLE			0x4060
> -
> -/* AXI Bridge Registers */
> -#define MVPP22_AXI_BM_WR_ATTR_REG		0x4100
> -#define MVPP22_AXI_BM_RD_ATTR_REG		0x4104
> -#define MVPP22_AXI_AGGRQ_DESCR_RD_ATTR_REG	0x4110
> -#define MVPP22_AXI_TXQ_DESCR_WR_ATTR_REG	0x4114
> -#define MVPP22_AXI_TXQ_DESCR_RD_ATTR_REG	0x4118
> -#define MVPP22_AXI_RXQ_DESCR_WR_ATTR_REG	0x411c
> -#define MVPP22_AXI_RX_DATA_WR_ATTR_REG		0x4120
> -#define MVPP22_AXI_TX_DATA_RD_ATTR_REG		0x4130
> -#define MVPP22_AXI_RD_NORMAL_CODE_REG		0x4150
> -#define MVPP22_AXI_RD_SNOOP_CODE_REG		0x4154
> -#define MVPP22_AXI_WR_NORMAL_CODE_REG		0x4160
> -#define MVPP22_AXI_WR_SNOOP_CODE_REG		0x4164
> -
> -/* Values for AXI Bridge registers */
> -#define MVPP22_AXI_ATTR_CACHE_OFFS		0
> -#define MVPP22_AXI_ATTR_DOMAIN_OFFS		12
> -
> -#define MVPP22_AXI_CODE_CACHE_OFFS		0
> -#define MVPP22_AXI_CODE_DOMAIN_OFFS		4
> -
> -#define MVPP22_AXI_CODE_CACHE_NON_CACHE		0x3
> -#define MVPP22_AXI_CODE_CACHE_WR_CACHE		0x7
> -#define MVPP22_AXI_CODE_CACHE_RD_CACHE		0xb
> -
> -#define MVPP22_AXI_CODE_DOMAIN_OUTER_DOM	2
> -#define MVPP22_AXI_CODE_DOMAIN_SYSTEM		3
> -
> -/* Interrupt Cause and Mask registers */
> -#define MVPP2_ISR_TX_THRESHOLD_REG(port)	(0x5140 + 4 * (port))
> -#define     MVPP2_MAX_ISR_TX_THRESHOLD		0xfffff0
> -
> -#define MVPP2_ISR_RX_THRESHOLD_REG(rxq)		(0x5200 + 4 * (rxq))
> -#define     MVPP2_MAX_ISR_RX_THRESHOLD		0xfffff0
> -#define MVPP21_ISR_RXQ_GROUP_REG(port)		(0x5400 + 4 * (port))
> -
> -#define MVPP22_ISR_RXQ_GROUP_INDEX_REG		0x5400
> -#define MVPP22_ISR_RXQ_GROUP_INDEX_SUBGROUP_MASK 0xf
> -#define MVPP22_ISR_RXQ_GROUP_INDEX_GROUP_MASK	0x380
> -#define MVPP22_ISR_RXQ_GROUP_INDEX_GROUP_OFFSET	7
> -
> -#define MVPP22_ISR_RXQ_GROUP_INDEX_SUBGROUP_MASK 0xf
> -#define MVPP22_ISR_RXQ_GROUP_INDEX_GROUP_MASK	0x380
> -
> -#define MVPP22_ISR_RXQ_SUB_GROUP_CONFIG_REG	0x5404
> -#define MVPP22_ISR_RXQ_SUB_GROUP_STARTQ_MASK	0x1f
> -#define MVPP22_ISR_RXQ_SUB_GROUP_SIZE_MASK	0xf00
> -#define MVPP22_ISR_RXQ_SUB_GROUP_SIZE_OFFSET	8
> -
> -#define MVPP2_ISR_ENABLE_REG(port)		(0x5420 + 4 * (port))
> -#define     MVPP2_ISR_ENABLE_INTERRUPT(mask)	((mask) & 0xffff)
> -#define     MVPP2_ISR_DISABLE_INTERRUPT(mask)	(((mask) << 16) & 0xffff0000)
> -#define MVPP2_ISR_RX_TX_CAUSE_REG(port)		(0x5480 + 4 * (port))
> -#define     MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK	0xffff
> -#define     MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_MASK	0xff0000
> -#define     MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_OFFSET	16
> -#define     MVPP2_CAUSE_RX_FIFO_OVERRUN_MASK	BIT(24)
> -#define     MVPP2_CAUSE_FCS_ERR_MASK		BIT(25)
> -#define     MVPP2_CAUSE_TX_FIFO_UNDERRUN_MASK	BIT(26)
> -#define     MVPP2_CAUSE_TX_EXCEPTION_SUM_MASK	BIT(29)
> -#define     MVPP2_CAUSE_RX_EXCEPTION_SUM_MASK	BIT(30)
> -#define     MVPP2_CAUSE_MISC_SUM_MASK		BIT(31)
> -#define MVPP2_ISR_RX_TX_MASK_REG(port)		(0x54a0 + 4 * (port))
> -#define MVPP2_ISR_PON_RX_TX_MASK_REG		0x54bc
> -#define     MVPP2_PON_CAUSE_RXQ_OCCUP_DESC_ALL_MASK	0xffff
> -#define     MVPP2_PON_CAUSE_TXP_OCCUP_DESC_ALL_MASK	0x3fc00000
> -#define     MVPP2_PON_CAUSE_MISC_SUM_MASK		BIT(31)
> -#define MVPP2_ISR_MISC_CAUSE_REG		0x55b0
> -
> -/* Buffer Manager registers */
> -#define MVPP2_BM_POOL_BASE_REG(pool)		(0x6000 + ((pool) * 4))
> -#define     MVPP2_BM_POOL_BASE_ADDR_MASK	0xfffff80
> -#define MVPP2_BM_POOL_SIZE_REG(pool)		(0x6040 + ((pool) * 4))
> -#define     MVPP2_BM_POOL_SIZE_MASK		0xfff0
> -#define MVPP2_BM_POOL_READ_PTR_REG(pool)	(0x6080 + ((pool) * 4))
> -#define     MVPP2_BM_POOL_GET_READ_PTR_MASK	0xfff0
> -#define MVPP2_BM_POOL_PTRS_NUM_REG(pool)	(0x60c0 + ((pool) * 4))
> -#define     MVPP2_BM_POOL_PTRS_NUM_MASK		0xfff0
> -#define MVPP2_BM_BPPI_READ_PTR_REG(pool)	(0x6100 + ((pool) * 4))
> -#define MVPP2_BM_BPPI_PTRS_NUM_REG(pool)	(0x6140 + ((pool) * 4))
> -#define     MVPP2_BM_BPPI_PTR_NUM_MASK		0x7ff
> -#define MVPP22_BM_POOL_PTRS_NUM_MASK		0xfff8
> -#define     MVPP2_BM_BPPI_PREFETCH_FULL_MASK	BIT(16)
> -#define MVPP2_BM_POOL_CTRL_REG(pool)		(0x6200 + ((pool) * 4))
> -#define     MVPP2_BM_START_MASK			BIT(0)
> -#define     MVPP2_BM_STOP_MASK			BIT(1)
> -#define     MVPP2_BM_STATE_MASK			BIT(4)
> -#define     MVPP2_BM_LOW_THRESH_OFFS		8
> -#define     MVPP2_BM_LOW_THRESH_MASK		0x7f00
> -#define     MVPP2_BM_LOW_THRESH_VALUE(val)	((val) << \
> -						MVPP2_BM_LOW_THRESH_OFFS)
> -#define     MVPP2_BM_HIGH_THRESH_OFFS		16
> -#define     MVPP2_BM_HIGH_THRESH_MASK		0x7f0000
> -#define     MVPP2_BM_HIGH_THRESH_VALUE(val)	((val) << \
> -						MVPP2_BM_HIGH_THRESH_OFFS)
> -#define MVPP2_BM_INTR_CAUSE_REG(pool)		(0x6240 + ((pool) * 4))
> -#define     MVPP2_BM_RELEASED_DELAY_MASK	BIT(0)
> -#define     MVPP2_BM_ALLOC_FAILED_MASK		BIT(1)
> -#define     MVPP2_BM_BPPE_EMPTY_MASK		BIT(2)
> -#define     MVPP2_BM_BPPE_FULL_MASK		BIT(3)
> -#define     MVPP2_BM_AVAILABLE_BP_LOW_MASK	BIT(4)
> -#define MVPP2_BM_INTR_MASK_REG(pool)		(0x6280 + ((pool) * 4))
> -#define MVPP2_BM_PHY_ALLOC_REG(pool)		(0x6400 + ((pool) * 4))
> -#define     MVPP2_BM_PHY_ALLOC_GRNTD_MASK	BIT(0)
> -#define MVPP2_BM_VIRT_ALLOC_REG			0x6440
> -#define MVPP22_BM_ADDR_HIGH_ALLOC		0x6444
> -#define     MVPP22_BM_ADDR_HIGH_PHYS_MASK	0xff
> -#define     MVPP22_BM_ADDR_HIGH_VIRT_MASK	0xff00
> -#define     MVPP22_BM_ADDR_HIGH_VIRT_SHIFT	8
> -#define MVPP2_BM_PHY_RLS_REG(pool)		(0x6480 + ((pool) * 4))
> -#define     MVPP2_BM_PHY_RLS_MC_BUFF_MASK	BIT(0)
> -#define     MVPP2_BM_PHY_RLS_PRIO_EN_MASK	BIT(1)
> -#define     MVPP2_BM_PHY_RLS_GRNTD_MASK		BIT(2)
> -#define MVPP2_BM_VIRT_RLS_REG			0x64c0
> -#define MVPP22_BM_ADDR_HIGH_RLS_REG		0x64c4
> -#define     MVPP22_BM_ADDR_HIGH_PHYS_RLS_MASK	0xff
> -#define     MVPP22_BM_ADDR_HIGH_VIRT_RLS_MASK	0xff00
> -#define     MVPP22_BM_ADDR_HIGH_VIRT_RLS_SHIFT	8
> -
> -/* TX Scheduler registers */
> -#define MVPP2_TXP_SCHED_PORT_INDEX_REG		0x8000
> -#define MVPP2_TXP_SCHED_Q_CMD_REG		0x8004
> -#define     MVPP2_TXP_SCHED_ENQ_MASK		0xff
> -#define     MVPP2_TXP_SCHED_DISQ_OFFSET		8
> -#define MVPP2_TXP_SCHED_CMD_1_REG		0x8010
> -#define MVPP2_TXP_SCHED_PERIOD_REG		0x8018
> -#define MVPP2_TXP_SCHED_MTU_REG			0x801c
> -#define     MVPP2_TXP_MTU_MAX			0x7FFFF
> -#define MVPP2_TXP_SCHED_REFILL_REG		0x8020
> -#define     MVPP2_TXP_REFILL_TOKENS_ALL_MASK	0x7ffff
> -#define     MVPP2_TXP_REFILL_PERIOD_ALL_MASK	0x3ff00000
> -#define     MVPP2_TXP_REFILL_PERIOD_MASK(v)	((v) << 20)
> -#define MVPP2_TXP_SCHED_TOKEN_SIZE_REG		0x8024
> -#define     MVPP2_TXP_TOKEN_SIZE_MAX		0xffffffff
> -#define MVPP2_TXQ_SCHED_REFILL_REG(q)		(0x8040 + ((q) << 2))
> -#define     MVPP2_TXQ_REFILL_TOKENS_ALL_MASK	0x7ffff
> -#define     MVPP2_TXQ_REFILL_PERIOD_ALL_MASK	0x3ff00000
> -#define     MVPP2_TXQ_REFILL_PERIOD_MASK(v)	((v) << 20)
> -#define MVPP2_TXQ_SCHED_TOKEN_SIZE_REG(q)	(0x8060 + ((q) << 2))
> -#define     MVPP2_TXQ_TOKEN_SIZE_MAX		0x7fffffff
> -#define MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(q)	(0x8080 + ((q) << 2))
> -#define     MVPP2_TXQ_TOKEN_CNTR_MAX		0xffffffff
> -
> -/* TX general registers */
> -#define MVPP2_TX_SNOOP_REG			0x8800
> -#define MVPP2_TX_PORT_FLUSH_REG			0x8810
> -#define     MVPP2_TX_PORT_FLUSH_MASK(port)	(1 << (port))
> -
> -/* LMS registers */
> -#define MVPP2_SRC_ADDR_MIDDLE			0x24
> -#define MVPP2_SRC_ADDR_HIGH			0x28
> -#define MVPP2_PHY_AN_CFG0_REG			0x34
> -#define     MVPP2_PHY_AN_STOP_SMI0_MASK		BIT(7)
> -#define MVPP2_MNG_EXTENDED_GLOBAL_CTRL_REG	0x305c
> -#define     MVPP2_EXT_GLOBAL_CTRL_DEFAULT	0x27
> -
> -/* Per-port registers */
> -#define MVPP2_GMAC_CTRL_0_REG			0x0
> -#define     MVPP2_GMAC_PORT_EN_MASK		BIT(0)
> -#define     MVPP2_GMAC_PORT_TYPE_MASK		BIT(1)
> -#define     MVPP2_GMAC_MAX_RX_SIZE_OFFS		2
> -#define     MVPP2_GMAC_MAX_RX_SIZE_MASK		0x7ffc
> -#define     MVPP2_GMAC_MIB_CNTR_EN_MASK		BIT(15)
> -#define MVPP2_GMAC_CTRL_1_REG			0x4
> -#define     MVPP2_GMAC_PERIODIC_XON_EN_MASK	BIT(1)
> -#define     MVPP2_GMAC_GMII_LB_EN_MASK		BIT(5)
> -#define     MVPP2_GMAC_PCS_LB_EN_BIT		6
> -#define     MVPP2_GMAC_PCS_LB_EN_MASK		BIT(6)
> -#define     MVPP2_GMAC_SA_LOW_OFFS		7
> -#define MVPP2_GMAC_CTRL_2_REG			0x8
> -#define     MVPP2_GMAC_INBAND_AN_MASK		BIT(0)
> -#define     MVPP2_GMAC_FLOW_CTRL_MASK		GENMASK(2, 1)
> -#define     MVPP2_GMAC_PCS_ENABLE_MASK		BIT(3)
> -#define     MVPP2_GMAC_INTERNAL_CLK_MASK	BIT(4)
> -#define     MVPP2_GMAC_DISABLE_PADDING		BIT(5)
> -#define     MVPP2_GMAC_PORT_RESET_MASK		BIT(6)
> -#define MVPP2_GMAC_AUTONEG_CONFIG		0xc
> -#define     MVPP2_GMAC_FORCE_LINK_DOWN		BIT(0)
> -#define     MVPP2_GMAC_FORCE_LINK_PASS		BIT(1)
> -#define     MVPP2_GMAC_IN_BAND_AUTONEG		BIT(2)
> -#define     MVPP2_GMAC_IN_BAND_AUTONEG_BYPASS	BIT(3)
> -#define     MVPP2_GMAC_IN_BAND_RESTART_AN	BIT(4)
> -#define     MVPP2_GMAC_CONFIG_MII_SPEED	BIT(5)
> -#define     MVPP2_GMAC_CONFIG_GMII_SPEED	BIT(6)
> -#define     MVPP2_GMAC_AN_SPEED_EN		BIT(7)
> -#define     MVPP2_GMAC_FC_ADV_EN		BIT(9)
> -#define     MVPP2_GMAC_FC_ADV_ASM_EN		BIT(10)
> -#define     MVPP2_GMAC_FLOW_CTRL_AUTONEG	BIT(11)
> -#define     MVPP2_GMAC_CONFIG_FULL_DUPLEX	BIT(12)
> -#define     MVPP2_GMAC_AN_DUPLEX_EN		BIT(13)
> -#define MVPP2_GMAC_STATUS0			0x10
> -#define     MVPP2_GMAC_STATUS0_LINK_UP		BIT(0)
> -#define     MVPP2_GMAC_STATUS0_GMII_SPEED	BIT(1)
> -#define     MVPP2_GMAC_STATUS0_MII_SPEED	BIT(2)
> -#define     MVPP2_GMAC_STATUS0_FULL_DUPLEX	BIT(3)
> -#define     MVPP2_GMAC_STATUS0_RX_PAUSE		BIT(6)
> -#define     MVPP2_GMAC_STATUS0_TX_PAUSE		BIT(7)
> -#define     MVPP2_GMAC_STATUS0_AN_COMPLETE	BIT(11)
> -#define MVPP2_GMAC_PORT_FIFO_CFG_1_REG		0x1c
> -#define     MVPP2_GMAC_TX_FIFO_MIN_TH_OFFS	6
> -#define     MVPP2_GMAC_TX_FIFO_MIN_TH_ALL_MASK	0x1fc0
> -#define     MVPP2_GMAC_TX_FIFO_MIN_TH_MASK(v)	(((v) << 6) & \
> -					MVPP2_GMAC_TX_FIFO_MIN_TH_ALL_MASK)
> -#define MVPP22_GMAC_INT_STAT			0x20
> -#define     MVPP22_GMAC_INT_STAT_LINK		BIT(1)
> -#define MVPP22_GMAC_INT_MASK			0x24
> -#define     MVPP22_GMAC_INT_MASK_LINK_STAT	BIT(1)
> -#define MVPP22_GMAC_CTRL_4_REG			0x90
> -#define     MVPP22_CTRL4_EXT_PIN_GMII_SEL	BIT(0)
> -#define     MVPP22_CTRL4_RX_FC_EN		BIT(3)
> -#define     MVPP22_CTRL4_TX_FC_EN		BIT(4)
> -#define     MVPP22_CTRL4_DP_CLK_SEL		BIT(5)
> -#define     MVPP22_CTRL4_SYNC_BYPASS_DIS	BIT(6)
> -#define     MVPP22_CTRL4_QSGMII_BYPASS_ACTIVE	BIT(7)
> -#define MVPP22_GMAC_INT_SUM_MASK		0xa4
> -#define     MVPP22_GMAC_INT_SUM_MASK_LINK_STAT	BIT(1)
> -
> -/* Per-port XGMAC registers. PPv2.2 only, only for GOP port 0,
> - * relative to port->base.
> - */
> -#define MVPP22_XLG_CTRL0_REG			0x100
> -#define     MVPP22_XLG_CTRL0_PORT_EN		BIT(0)
> -#define     MVPP22_XLG_CTRL0_MAC_RESET_DIS	BIT(1)
> -#define     MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN	BIT(7)
> -#define     MVPP22_XLG_CTRL0_TX_FLOW_CTRL_EN	BIT(8)
> -#define     MVPP22_XLG_CTRL0_MIB_CNT_DIS	BIT(14)
> -#define MVPP22_XLG_CTRL1_REG			0x104
> -#define     MVPP22_XLG_CTRL1_FRAMESIZELIMIT_OFFS	0
> -#define     MVPP22_XLG_CTRL1_FRAMESIZELIMIT_MASK	0x1fff
> -#define MVPP22_XLG_STATUS			0x10c
> -#define     MVPP22_XLG_STATUS_LINK_UP		BIT(0)
> -#define MVPP22_XLG_INT_STAT			0x114
> -#define     MVPP22_XLG_INT_STAT_LINK		BIT(1)
> -#define MVPP22_XLG_INT_MASK			0x118
> -#define     MVPP22_XLG_INT_MASK_LINK		BIT(1)
> -#define MVPP22_XLG_CTRL3_REG			0x11c
> -#define     MVPP22_XLG_CTRL3_MACMODESELECT_MASK	(7 << 13)
> -#define     MVPP22_XLG_CTRL3_MACMODESELECT_GMAC	(0 << 13)
> -#define     MVPP22_XLG_CTRL3_MACMODESELECT_10G	(1 << 13)
> -#define MVPP22_XLG_EXT_INT_MASK			0x15c
> -#define     MVPP22_XLG_EXT_INT_MASK_XLG		BIT(1)
> -#define     MVPP22_XLG_EXT_INT_MASK_GIG		BIT(2)
> -#define MVPP22_XLG_CTRL4_REG			0x184
> -#define     MVPP22_XLG_CTRL4_FWD_FC		BIT(5)
> -#define     MVPP22_XLG_CTRL4_FWD_PFC		BIT(6)
> -#define     MVPP22_XLG_CTRL4_MACMODSELECT_GMAC	BIT(12)
> -#define     MVPP22_XLG_CTRL4_EN_IDLE_CHECK	BIT(14)
> -
> -/* SMI registers. PPv2.2 only, relative to priv->iface_base. */
> -#define MVPP22_SMI_MISC_CFG_REG			0x1204
> -#define     MVPP22_SMI_POLLING_EN		BIT(10)
> -
> -#define MVPP22_GMAC_BASE(port)		(0x7000 + (port) * 0x1000 + 0xe00)
> -
> -#define MVPP2_CAUSE_TXQ_SENT_DESC_ALL_MASK	0xff
> -
> -/* Descriptor ring Macros */
> -#define MVPP2_QUEUE_NEXT_DESC(q, index) \
> -	(((index) < (q)->last_desc) ? ((index) + 1) : 0)
> -
> -/* XPCS registers. PPv2.2 only */
> -#define MVPP22_MPCS_BASE(port)			(0x7000 + (port) * 0x1000)
> -#define MVPP22_MPCS_CTRL			0x14
> -#define     MVPP22_MPCS_CTRL_FWD_ERR_CONN	BIT(10)
> -#define MVPP22_MPCS_CLK_RESET			0x14c
> -#define     MAC_CLK_RESET_SD_TX			BIT(0)
> -#define     MAC_CLK_RESET_SD_RX			BIT(1)
> -#define     MAC_CLK_RESET_MAC			BIT(2)
> -#define     MVPP22_MPCS_CLK_RESET_DIV_RATIO(n)	((n) << 4)
> -#define     MVPP22_MPCS_CLK_RESET_DIV_SET	BIT(11)
> -
> -/* XPCS registers. PPv2.2 only */
> -#define MVPP22_XPCS_BASE(port)			(0x7400 + (port) * 0x1000)
> -#define MVPP22_XPCS_CFG0			0x0
> -#define     MVPP22_XPCS_CFG0_PCS_MODE(n)	((n) << 3)
> -#define     MVPP22_XPCS_CFG0_ACTIVE_LANE(n)	((n) << 5)
> -
> -/* System controller registers. Accessed through a regmap. */
> -#define GENCONF_SOFT_RESET1				0x1108
> -#define     GENCONF_SOFT_RESET1_GOP			BIT(6)
> -#define GENCONF_PORT_CTRL0				0x1110
> -#define     GENCONF_PORT_CTRL0_BUS_WIDTH_SELECT		BIT(1)
> -#define     GENCONF_PORT_CTRL0_RX_DATA_SAMPLE		BIT(29)
> -#define     GENCONF_PORT_CTRL0_CLK_DIV_PHASE_CLR	BIT(31)
> -#define GENCONF_PORT_CTRL1				0x1114
> -#define     GENCONF_PORT_CTRL1_EN(p)			BIT(p)
> -#define     GENCONF_PORT_CTRL1_RESET(p)			(BIT(p) << 28)
> -#define GENCONF_CTRL0					0x1120
> -#define     GENCONF_CTRL0_PORT0_RGMII			BIT(0)
> -#define     GENCONF_CTRL0_PORT1_RGMII_MII		BIT(1)
> -#define     GENCONF_CTRL0_PORT1_RGMII			BIT(2)
> -
> -/* Various constants */
> -
> -/* Coalescing */
> -#define MVPP2_TXDONE_COAL_PKTS_THRESH	64
> -#define MVPP2_TXDONE_HRTIMER_PERIOD_NS	1000000UL
> -#define MVPP2_TXDONE_COAL_USEC		1000
> -#define MVPP2_RX_COAL_PKTS		32
> -#define MVPP2_RX_COAL_USEC		64
> -
> -/* The two bytes Marvell header. Either contains a special value used
> - * by Marvell switches when a specific hardware mode is enabled (not
> - * supported by this driver) or is filled automatically by zeroes on
> - * the RX side. Those two bytes being at the front of the Ethernet
> - * header, they allow to have the IP header aligned on a 4 bytes
> - * boundary automatically: the hardware skips those two bytes on its
> - * own.
> - */
> -#define MVPP2_MH_SIZE			2
> -#define MVPP2_ETH_TYPE_LEN		2
> -#define MVPP2_PPPOE_HDR_SIZE		8
> -#define MVPP2_VLAN_TAG_LEN		4
> -#define MVPP2_VLAN_TAG_EDSA_LEN		8
> -
> -/* Lbtd 802.3 type */
> -#define MVPP2_IP_LBDT_TYPE		0xfffa
> -
> -#define MVPP2_TX_CSUM_MAX_SIZE		9800
> -
> -/* Timeout constants */
> -#define MVPP2_TX_DISABLE_TIMEOUT_MSEC	1000
> -#define MVPP2_TX_PENDING_TIMEOUT_MSEC	1000
> -
> -#define MVPP2_TX_MTU_MAX		0x7ffff
> -
> -/* Maximum number of T-CONTs of PON port */
> -#define MVPP2_MAX_TCONT			16
> -
> -/* Maximum number of supported ports */
> -#define MVPP2_MAX_PORTS			4
> -
> -/* Maximum number of TXQs used by single port */
> -#define MVPP2_MAX_TXQ			8
> -
> -/* MVPP2_MAX_TSO_SEGS is the maximum number of fragments to allow in the GSO
> - * skb. As we need a maxium of two descriptors per fragments (1 header, 1 data),
> - * multiply this value by two to count the maximum number of skb descs needed.
> - */
> -#define MVPP2_MAX_TSO_SEGS		300
> -#define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
> -
> -/* Dfault number of RXQs in use */
> -#define MVPP2_DEFAULT_RXQ		4
> -
> -/* Max number of Rx descriptors */
> -#define MVPP2_MAX_RXD_MAX		1024
> -#define MVPP2_MAX_RXD_DFLT		128
> -
> -/* Max number of Tx descriptors */
> -#define MVPP2_MAX_TXD_MAX		2048
> -#define MVPP2_MAX_TXD_DFLT		1024
> -
> -/* Amount of Tx descriptors that can be reserved at once by CPU */
> -#define MVPP2_CPU_DESC_CHUNK		64
> -
> -/* Max number of Tx descriptors in each aggregated queue */
> -#define MVPP2_AGGR_TXQ_SIZE		256
> -
> -/* Descriptor aligned size */
> -#define MVPP2_DESC_ALIGNED_SIZE		32
> -
> -/* Descriptor alignment mask */
> -#define MVPP2_TX_DESC_ALIGN		(MVPP2_DESC_ALIGNED_SIZE - 1)
> -
> -/* RX FIFO constants */
> -#define MVPP2_RX_FIFO_PORT_DATA_SIZE_32KB	0x8000
> -#define MVPP2_RX_FIFO_PORT_DATA_SIZE_8KB	0x2000
> -#define MVPP2_RX_FIFO_PORT_DATA_SIZE_4KB	0x1000
> -#define MVPP2_RX_FIFO_PORT_ATTR_SIZE_32KB	0x200
> -#define MVPP2_RX_FIFO_PORT_ATTR_SIZE_8KB	0x80
> -#define MVPP2_RX_FIFO_PORT_ATTR_SIZE_4KB	0x40
> -#define MVPP2_RX_FIFO_PORT_MIN_PKT		0x80
> -
> -/* TX FIFO constants */
> -#define MVPP22_TX_FIFO_DATA_SIZE_10KB		0xa
> -#define MVPP22_TX_FIFO_DATA_SIZE_3KB		0x3
> -#define MVPP2_TX_FIFO_THRESHOLD_MIN		256
> -#define MVPP2_TX_FIFO_THRESHOLD_10KB	\
> -	(MVPP22_TX_FIFO_DATA_SIZE_10KB * 1024 - MVPP2_TX_FIFO_THRESHOLD_MIN)
> -#define MVPP2_TX_FIFO_THRESHOLD_3KB	\
> -	(MVPP22_TX_FIFO_DATA_SIZE_3KB * 1024 - MVPP2_TX_FIFO_THRESHOLD_MIN)
> -
> -/* RX buffer constants */
> -#define MVPP2_SKB_SHINFO_SIZE \
> -	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
> -
> -#define MVPP2_RX_PKT_SIZE(mtu) \
> -	ALIGN((mtu) + MVPP2_MH_SIZE + MVPP2_VLAN_TAG_LEN + \
> -	      ETH_HLEN + ETH_FCS_LEN, cache_line_size())
> -
> -#define MVPP2_RX_BUF_SIZE(pkt_size)	((pkt_size) + NET_SKB_PAD)
> -#define MVPP2_RX_TOTAL_SIZE(buf_size)	((buf_size) + MVPP2_SKB_SHINFO_SIZE)
> -#define MVPP2_RX_MAX_PKT_SIZE(total_size) \
> -	((total_size) - NET_SKB_PAD - MVPP2_SKB_SHINFO_SIZE)
> -
> -#define MVPP2_BIT_TO_BYTE(bit)		((bit) / 8)
> -
> -/* IPv6 max L3 address size */
> -#define MVPP2_MAX_L3_ADDR_SIZE		16
> -
> -/* Port flags */
> -#define MVPP2_F_LOOPBACK		BIT(0)
> -
> -/* Marvell tag types */
> -enum mvpp2_tag_type {
> -	MVPP2_TAG_TYPE_NONE = 0,
> -	MVPP2_TAG_TYPE_MH   = 1,
> -	MVPP2_TAG_TYPE_DSA  = 2,
> -	MVPP2_TAG_TYPE_EDSA = 3,
> -	MVPP2_TAG_TYPE_VLAN = 4,
> -	MVPP2_TAG_TYPE_LAST = 5
> -};
> -
> -/* Parser constants */
> -#define MVPP2_PRS_TCAM_SRAM_SIZE	256
> -#define MVPP2_PRS_TCAM_WORDS		6
> -#define MVPP2_PRS_SRAM_WORDS		4
> -#define MVPP2_PRS_FLOW_ID_SIZE		64
> -#define MVPP2_PRS_FLOW_ID_MASK		0x3f
> -#define MVPP2_PRS_TCAM_ENTRY_INVALID	1
> -#define MVPP2_PRS_TCAM_DSA_TAGGED_BIT	BIT(5)
> -#define MVPP2_PRS_IPV4_HEAD		0x40
> -#define MVPP2_PRS_IPV4_HEAD_MASK	0xf0
> -#define MVPP2_PRS_IPV4_MC		0xe0
> -#define MVPP2_PRS_IPV4_MC_MASK		0xf0
> -#define MVPP2_PRS_IPV4_BC_MASK		0xff
> -#define MVPP2_PRS_IPV4_IHL		0x5
> -#define MVPP2_PRS_IPV4_IHL_MASK		0xf
> -#define MVPP2_PRS_IPV6_MC		0xff
> -#define MVPP2_PRS_IPV6_MC_MASK		0xff
> -#define MVPP2_PRS_IPV6_HOP_MASK		0xff
> -#define MVPP2_PRS_TCAM_PROTO_MASK	0xff
> -#define MVPP2_PRS_TCAM_PROTO_MASK_L	0x3f
> -#define MVPP2_PRS_DBL_VLANS_MAX		100
> -#define MVPP2_PRS_CAST_MASK		BIT(0)
> -#define MVPP2_PRS_MCAST_VAL		BIT(0)
> -#define MVPP2_PRS_UCAST_VAL		0x0
> -
> -/* Tcam structure:
> - * - lookup ID - 4 bits
> - * - port ID - 1 byte
> - * - additional information - 1 byte
> - * - header data - 8 bytes
> - * The fields are represented by MVPP2_PRS_TCAM_DATA_REG(5)->(0).
> - */
> -#define MVPP2_PRS_AI_BITS			8
> -#define MVPP2_PRS_PORT_MASK			0xff
> -#define MVPP2_PRS_LU_MASK			0xf
> -#define MVPP2_PRS_TCAM_DATA_BYTE(offs)		\
> -				    (((offs) - ((offs) % 2)) * 2 + ((offs) % 2))
> -#define MVPP2_PRS_TCAM_DATA_BYTE_EN(offs)	\
> -					      (((offs) * 2) - ((offs) % 2)  + 2)
> -#define MVPP2_PRS_TCAM_AI_BYTE			16
> -#define MVPP2_PRS_TCAM_PORT_BYTE		17
> -#define MVPP2_PRS_TCAM_LU_BYTE			20
> -#define MVPP2_PRS_TCAM_EN_OFFS(offs)		((offs) + 2)
> -#define MVPP2_PRS_TCAM_INV_WORD			5
> -
> -#define MVPP2_PRS_VID_TCAM_BYTE         2
> -
> -/* TCAM range for unicast and multicast filtering. We have 25 entries per port,
> - * with 4 dedicated to UC filtering and the rest to multicast filtering.
> - * Additionnally we reserve one entry for the broadcast address, and one for
> - * each port's own address.
> - */
> -#define MVPP2_PRS_MAC_UC_MC_FILT_MAX	25
> -#define MVPP2_PRS_MAC_RANGE_SIZE	80
> -
> -/* Number of entries per port dedicated to UC and MC filtering */
> -#define MVPP2_PRS_MAC_UC_FILT_MAX	4
> -#define MVPP2_PRS_MAC_MC_FILT_MAX	(MVPP2_PRS_MAC_UC_MC_FILT_MAX - \
> -					 MVPP2_PRS_MAC_UC_FILT_MAX)
> -
> -/* There is a TCAM range reserved for VLAN filtering entries, range size is 33
> - * 10 VLAN ID filter entries per port
> - * 1 default VLAN filter entry per port
> - * It is assumed that there are 3 ports for filter, not including loopback port
> - */
> -#define MVPP2_PRS_VLAN_FILT_MAX		11
> -#define MVPP2_PRS_VLAN_FILT_RANGE_SIZE	33
> -
> -#define MVPP2_PRS_VLAN_FILT_MAX_ENTRY   (MVPP2_PRS_VLAN_FILT_MAX - 2)
> -#define MVPP2_PRS_VLAN_FILT_DFLT_ENTRY  (MVPP2_PRS_VLAN_FILT_MAX - 1)
> -
> -/* Tcam entries ID */
> -#define MVPP2_PE_DROP_ALL		0
> -#define MVPP2_PE_FIRST_FREE_TID		1
> -
> -/* MAC filtering range */
> -#define MVPP2_PE_MAC_RANGE_END		(MVPP2_PE_VID_FILT_RANGE_START - 1)
> -#define MVPP2_PE_MAC_RANGE_START	(MVPP2_PE_MAC_RANGE_END - \
> -						MVPP2_PRS_MAC_RANGE_SIZE + 1)
> -/* VLAN filtering range */
> -#define MVPP2_PE_VID_FILT_RANGE_END     (MVPP2_PRS_TCAM_SRAM_SIZE - 31)
> -#define MVPP2_PE_VID_FILT_RANGE_START   (MVPP2_PE_VID_FILT_RANGE_END - \
> -					 MVPP2_PRS_VLAN_FILT_RANGE_SIZE + 1)
> -#define MVPP2_PE_LAST_FREE_TID          (MVPP2_PE_MAC_RANGE_START - 1)
> -#define MVPP2_PE_IP6_EXT_PROTO_UN	(MVPP2_PRS_TCAM_SRAM_SIZE - 30)
> -#define MVPP2_PE_IP6_ADDR_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 29)
> -#define MVPP2_PE_IP4_ADDR_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 28)
> -#define MVPP2_PE_LAST_DEFAULT_FLOW	(MVPP2_PRS_TCAM_SRAM_SIZE - 27)
> -#define MVPP2_PE_FIRST_DEFAULT_FLOW	(MVPP2_PRS_TCAM_SRAM_SIZE - 22)
> -#define MVPP2_PE_EDSA_TAGGED		(MVPP2_PRS_TCAM_SRAM_SIZE - 21)
> -#define MVPP2_PE_EDSA_UNTAGGED		(MVPP2_PRS_TCAM_SRAM_SIZE - 20)
> -#define MVPP2_PE_DSA_TAGGED		(MVPP2_PRS_TCAM_SRAM_SIZE - 19)
> -#define MVPP2_PE_DSA_UNTAGGED		(MVPP2_PRS_TCAM_SRAM_SIZE - 18)
> -#define MVPP2_PE_ETYPE_EDSA_TAGGED	(MVPP2_PRS_TCAM_SRAM_SIZE - 17)
> -#define MVPP2_PE_ETYPE_EDSA_UNTAGGED	(MVPP2_PRS_TCAM_SRAM_SIZE - 16)
> -#define MVPP2_PE_ETYPE_DSA_TAGGED	(MVPP2_PRS_TCAM_SRAM_SIZE - 15)
> -#define MVPP2_PE_ETYPE_DSA_UNTAGGED	(MVPP2_PRS_TCAM_SRAM_SIZE - 14)
> -#define MVPP2_PE_MH_DEFAULT		(MVPP2_PRS_TCAM_SRAM_SIZE - 13)
> -#define MVPP2_PE_DSA_DEFAULT		(MVPP2_PRS_TCAM_SRAM_SIZE - 12)
> -#define MVPP2_PE_IP6_PROTO_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 11)
> -#define MVPP2_PE_IP4_PROTO_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 10)
> -#define MVPP2_PE_ETH_TYPE_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 9)
> -#define MVPP2_PE_VID_FLTR_DEFAULT	(MVPP2_PRS_TCAM_SRAM_SIZE - 8)
> -#define MVPP2_PE_VID_EDSA_FLTR_DEFAULT	(MVPP2_PRS_TCAM_SRAM_SIZE - 7)
> -#define MVPP2_PE_VLAN_DBL		(MVPP2_PRS_TCAM_SRAM_SIZE - 6)
> -#define MVPP2_PE_VLAN_NONE		(MVPP2_PRS_TCAM_SRAM_SIZE - 5)
> -/* reserved */
> -#define MVPP2_PE_MAC_MC_PROMISCUOUS	(MVPP2_PRS_TCAM_SRAM_SIZE - 3)
> -#define MVPP2_PE_MAC_UC_PROMISCUOUS	(MVPP2_PRS_TCAM_SRAM_SIZE - 2)
> -#define MVPP2_PE_MAC_NON_PROMISCUOUS	(MVPP2_PRS_TCAM_SRAM_SIZE - 1)
> -
> -#define MVPP2_PRS_VID_PORT_FIRST(port)	(MVPP2_PE_VID_FILT_RANGE_START + \
> -					 ((port) * MVPP2_PRS_VLAN_FILT_MAX))
> -#define MVPP2_PRS_VID_PORT_LAST(port)	(MVPP2_PRS_VID_PORT_FIRST(port) \
> -					 + MVPP2_PRS_VLAN_FILT_MAX_ENTRY)
> -/* Index of default vid filter for given port */
> -#define MVPP2_PRS_VID_PORT_DFLT(port)	(MVPP2_PRS_VID_PORT_FIRST(port) \
> -					 + MVPP2_PRS_VLAN_FILT_DFLT_ENTRY)
> -
> -/* Sram structure
> - * The fields are represented by MVPP2_PRS_TCAM_DATA_REG(3)->(0).
> - */
> -#define MVPP2_PRS_SRAM_RI_OFFS			0
> -#define MVPP2_PRS_SRAM_RI_WORD			0
> -#define MVPP2_PRS_SRAM_RI_CTRL_OFFS		32
> -#define MVPP2_PRS_SRAM_RI_CTRL_WORD		1
> -#define MVPP2_PRS_SRAM_RI_CTRL_BITS		32
> -#define MVPP2_PRS_SRAM_SHIFT_OFFS		64
> -#define MVPP2_PRS_SRAM_SHIFT_SIGN_BIT		72
> -#define MVPP2_PRS_SRAM_UDF_OFFS			73
> -#define MVPP2_PRS_SRAM_UDF_BITS			8
> -#define MVPP2_PRS_SRAM_UDF_MASK			0xff
> -#define MVPP2_PRS_SRAM_UDF_SIGN_BIT		81
> -#define MVPP2_PRS_SRAM_UDF_TYPE_OFFS		82
> -#define MVPP2_PRS_SRAM_UDF_TYPE_MASK		0x7
> -#define MVPP2_PRS_SRAM_UDF_TYPE_L3		1
> -#define MVPP2_PRS_SRAM_UDF_TYPE_L4		4
> -#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_OFFS	85
> -#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_MASK	0x3
> -#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD		1
> -#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_IP4_ADD	2
> -#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_IP6_ADD	3
> -#define MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS		87
> -#define MVPP2_PRS_SRAM_OP_SEL_UDF_BITS		2
> -#define MVPP2_PRS_SRAM_OP_SEL_UDF_MASK		0x3
> -#define MVPP2_PRS_SRAM_OP_SEL_UDF_ADD		0
> -#define MVPP2_PRS_SRAM_OP_SEL_UDF_IP4_ADD	2
> -#define MVPP2_PRS_SRAM_OP_SEL_UDF_IP6_ADD	3
> -#define MVPP2_PRS_SRAM_OP_SEL_BASE_OFFS		89
> -#define MVPP2_PRS_SRAM_AI_OFFS			90
> -#define MVPP2_PRS_SRAM_AI_CTRL_OFFS		98
> -#define MVPP2_PRS_SRAM_AI_CTRL_BITS		8
> -#define MVPP2_PRS_SRAM_AI_MASK			0xff
> -#define MVPP2_PRS_SRAM_NEXT_LU_OFFS		106
> -#define MVPP2_PRS_SRAM_NEXT_LU_MASK		0xf
> -#define MVPP2_PRS_SRAM_LU_DONE_BIT		110
> -#define MVPP2_PRS_SRAM_LU_GEN_BIT		111
> -
> -/* Sram result info bits assignment */
> -#define MVPP2_PRS_RI_MAC_ME_MASK		0x1
> -#define MVPP2_PRS_RI_DSA_MASK			0x2
> -#define MVPP2_PRS_RI_VLAN_MASK			(BIT(2) | BIT(3))
> -#define MVPP2_PRS_RI_VLAN_NONE			0x0
> -#define MVPP2_PRS_RI_VLAN_SINGLE		BIT(2)
> -#define MVPP2_PRS_RI_VLAN_DOUBLE		BIT(3)
> -#define MVPP2_PRS_RI_VLAN_TRIPLE		(BIT(2) | BIT(3))
> -#define MVPP2_PRS_RI_CPU_CODE_MASK		0x70
> -#define MVPP2_PRS_RI_CPU_CODE_RX_SPEC		BIT(4)
> -#define MVPP2_PRS_RI_L2_CAST_MASK		(BIT(9) | BIT(10))
> -#define MVPP2_PRS_RI_L2_UCAST			0x0
> -#define MVPP2_PRS_RI_L2_MCAST			BIT(9)
> -#define MVPP2_PRS_RI_L2_BCAST			BIT(10)
> -#define MVPP2_PRS_RI_PPPOE_MASK			0x800
> -#define MVPP2_PRS_RI_L3_PROTO_MASK		(BIT(12) | BIT(13) | BIT(14))
> -#define MVPP2_PRS_RI_L3_UN			0x0
> -#define MVPP2_PRS_RI_L3_IP4			BIT(12)
> -#define MVPP2_PRS_RI_L3_IP4_OPT			BIT(13)
> -#define MVPP2_PRS_RI_L3_IP4_OTHER		(BIT(12) | BIT(13))
> -#define MVPP2_PRS_RI_L3_IP6			BIT(14)
> -#define MVPP2_PRS_RI_L3_IP6_EXT			(BIT(12) | BIT(14))
> -#define MVPP2_PRS_RI_L3_ARP			(BIT(13) | BIT(14))
> -#define MVPP2_PRS_RI_L3_ADDR_MASK		(BIT(15) | BIT(16))
> -#define MVPP2_PRS_RI_L3_UCAST			0x0
> -#define MVPP2_PRS_RI_L3_MCAST			BIT(15)
> -#define MVPP2_PRS_RI_L3_BCAST			(BIT(15) | BIT(16))
> -#define MVPP2_PRS_RI_IP_FRAG_MASK		0x20000
> -#define MVPP2_PRS_RI_IP_FRAG_TRUE		BIT(17)
> -#define MVPP2_PRS_RI_UDF3_MASK			0x300000
> -#define MVPP2_PRS_RI_UDF3_RX_SPECIAL		BIT(21)
> -#define MVPP2_PRS_RI_L4_PROTO_MASK		0x1c00000
> -#define MVPP2_PRS_RI_L4_TCP			BIT(22)
> -#define MVPP2_PRS_RI_L4_UDP			BIT(23)
> -#define MVPP2_PRS_RI_L4_OTHER			(BIT(22) | BIT(23))
> -#define MVPP2_PRS_RI_UDF7_MASK			0x60000000
> -#define MVPP2_PRS_RI_UDF7_IP6_LITE		BIT(29)
> -#define MVPP2_PRS_RI_DROP_MASK			0x80000000
> -
> -/* Sram additional info bits assignment */
> -#define MVPP2_PRS_IPV4_DIP_AI_BIT		BIT(0)
> -#define MVPP2_PRS_IPV6_NO_EXT_AI_BIT		BIT(0)
> -#define MVPP2_PRS_IPV6_EXT_AI_BIT		BIT(1)
> -#define MVPP2_PRS_IPV6_EXT_AH_AI_BIT		BIT(2)
> -#define MVPP2_PRS_IPV6_EXT_AH_LEN_AI_BIT	BIT(3)
> -#define MVPP2_PRS_IPV6_EXT_AH_L4_AI_BIT		BIT(4)
> -#define MVPP2_PRS_SINGLE_VLAN_AI		0
> -#define MVPP2_PRS_DBL_VLAN_AI_BIT		BIT(7)
> -#define MVPP2_PRS_EDSA_VID_AI_BIT		BIT(0)
> -
> -/* DSA/EDSA type */
> -#define MVPP2_PRS_TAGGED		true
> -#define MVPP2_PRS_UNTAGGED		false
> -#define MVPP2_PRS_EDSA			true
> -#define MVPP2_PRS_DSA			false
> -
> -/* MAC entries, shadow udf */
> -enum mvpp2_prs_udf {
> -	MVPP2_PRS_UDF_MAC_DEF,
> -	MVPP2_PRS_UDF_MAC_RANGE,
> -	MVPP2_PRS_UDF_L2_DEF,
> -	MVPP2_PRS_UDF_L2_DEF_COPY,
> -	MVPP2_PRS_UDF_L2_USER,
> -};
> -
> -/* Lookup ID */
> -enum mvpp2_prs_lookup {
> -	MVPP2_PRS_LU_MH,
> -	MVPP2_PRS_LU_MAC,
> -	MVPP2_PRS_LU_DSA,
> -	MVPP2_PRS_LU_VLAN,
> -	MVPP2_PRS_LU_VID,
> -	MVPP2_PRS_LU_L2,
> -	MVPP2_PRS_LU_PPPOE,
> -	MVPP2_PRS_LU_IP4,
> -	MVPP2_PRS_LU_IP6,
> -	MVPP2_PRS_LU_FLOWS,
> -	MVPP2_PRS_LU_LAST,
> -};
> -
> -/* L2 cast enum */
> -enum mvpp2_prs_l2_cast {
> -	MVPP2_PRS_L2_UNI_CAST,
> -	MVPP2_PRS_L2_MULTI_CAST,
> -};
> -
> -/* L3 cast enum */
> -enum mvpp2_prs_l3_cast {
> -	MVPP2_PRS_L3_UNI_CAST,
> -	MVPP2_PRS_L3_MULTI_CAST,
> -	MVPP2_PRS_L3_BROAD_CAST
> -};
> -
> -/* Classifier constants */
> -#define MVPP2_CLS_FLOWS_TBL_SIZE	512
> -#define MVPP2_CLS_FLOWS_TBL_DATA_WORDS	3
> -#define MVPP2_CLS_LKP_TBL_SIZE		64
> -#define MVPP2_CLS_RX_QUEUES		256
> -
> -/* RSS constants */
> -#define MVPP22_RSS_TABLE_ENTRIES	32
> -
> -/* BM constants */
> -#define MVPP2_BM_JUMBO_BUF_NUM		512
> -#define MVPP2_BM_LONG_BUF_NUM		1024
> -#define MVPP2_BM_SHORT_BUF_NUM		2048
> -#define MVPP2_BM_POOL_SIZE_MAX		(16*1024 - MVPP2_BM_POOL_PTR_ALIGN/4)
> -#define MVPP2_BM_POOL_PTR_ALIGN		128
> -
> -/* BM cookie (32 bits) definition */
> -#define MVPP2_BM_COOKIE_POOL_OFFS	8
> -#define MVPP2_BM_COOKIE_CPU_OFFS	24
> -
> -#define MVPP2_BM_SHORT_FRAME_SIZE		512
> -#define MVPP2_BM_LONG_FRAME_SIZE		2048
> -#define MVPP2_BM_JUMBO_FRAME_SIZE		10240
> -/* BM short pool packet size
> - * These value assure that for SWF the total number
> - * of bytes allocated for each buffer will be 512
> - */
> -#define MVPP2_BM_SHORT_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_SHORT_FRAME_SIZE)
> -#define MVPP2_BM_LONG_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_LONG_FRAME_SIZE)
> -#define MVPP2_BM_JUMBO_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_JUMBO_FRAME_SIZE)
> -
> -#define MVPP21_ADDR_SPACE_SZ		0
> -#define MVPP22_ADDR_SPACE_SZ		SZ_64K
> -
> -#define MVPP2_MAX_THREADS		8
> -#define MVPP2_MAX_QVECS			MVPP2_MAX_THREADS
> +#include "mvpp2.h"
> +#include "mvpp2_prs.h"
> +#include "mvpp2_cls.h"
>  
>  enum mvpp2_bm_pool_log_num {
>  	MVPP2_BM_SHORT,
> @@ -889,3256 +52,248 @@ enum mvpp2_bm_pool_log_num {
>  };
>  
>  static struct {
> -	int pkt_size;
> -	int buf_num;
> -} mvpp2_pools[MVPP2_BM_POOLS_NUM];
> -
> -/* GMAC MIB Counters register definitions */
> -#define MVPP21_MIB_COUNTERS_OFFSET		0x1000
> -#define MVPP21_MIB_COUNTERS_PORT_SZ		0x400
> -#define MVPP22_MIB_COUNTERS_OFFSET		0x0
> -#define MVPP22_MIB_COUNTERS_PORT_SZ		0x100
> -
> -#define MVPP2_MIB_GOOD_OCTETS_RCVD		0x0
> -#define MVPP2_MIB_BAD_OCTETS_RCVD		0x8
> -#define MVPP2_MIB_CRC_ERRORS_SENT		0xc
> -#define MVPP2_MIB_UNICAST_FRAMES_RCVD		0x10
> -#define MVPP2_MIB_BROADCAST_FRAMES_RCVD		0x18
> -#define MVPP2_MIB_MULTICAST_FRAMES_RCVD		0x1c
> -#define MVPP2_MIB_FRAMES_64_OCTETS		0x20
> -#define MVPP2_MIB_FRAMES_65_TO_127_OCTETS	0x24
> -#define MVPP2_MIB_FRAMES_128_TO_255_OCTETS	0x28
> -#define MVPP2_MIB_FRAMES_256_TO_511_OCTETS	0x2c
> -#define MVPP2_MIB_FRAMES_512_TO_1023_OCTETS	0x30
> -#define MVPP2_MIB_FRAMES_1024_TO_MAX_OCTETS	0x34
> -#define MVPP2_MIB_GOOD_OCTETS_SENT		0x38
> -#define MVPP2_MIB_UNICAST_FRAMES_SENT		0x40
> -#define MVPP2_MIB_MULTICAST_FRAMES_SENT		0x48
> -#define MVPP2_MIB_BROADCAST_FRAMES_SENT		0x4c
> -#define MVPP2_MIB_FC_SENT			0x54
> -#define MVPP2_MIB_FC_RCVD			0x58
> -#define MVPP2_MIB_RX_FIFO_OVERRUN		0x5c
> -#define MVPP2_MIB_UNDERSIZE_RCVD		0x60
> -#define MVPP2_MIB_FRAGMENTS_RCVD		0x64
> -#define MVPP2_MIB_OVERSIZE_RCVD			0x68
> -#define MVPP2_MIB_JABBER_RCVD			0x6c
> -#define MVPP2_MIB_MAC_RCV_ERROR			0x70
> -#define MVPP2_MIB_BAD_CRC_EVENT			0x74
> -#define MVPP2_MIB_COLLISION			0x78
> -#define MVPP2_MIB_LATE_COLLISION		0x7c
> -
> -#define MVPP2_MIB_COUNTERS_STATS_DELAY		(1 * HZ)
> -
> -#define MVPP2_DESC_DMA_MASK	DMA_BIT_MASK(40)
> -
> -/* Definitions */
> -
> -/* Shared Packet Processor resources */
> -struct mvpp2 {
> -	/* Shared registers' base addresses */
> -	void __iomem *lms_base;
> -	void __iomem *iface_base;
> -
> -	/* On PPv2.2, each "software thread" can access the base
> -	 * register through a separate address space, each 64 KB apart
> -	 * from each other. Typically, such address spaces will be
> -	 * used per CPU.
> -	 */
> -	void __iomem *swth_base[MVPP2_MAX_THREADS];
> -
> -	/* On PPv2.2, some port control registers are located into the system
> -	 * controller space. These registers are accessible through a regmap.
> -	 */
> -	struct regmap *sysctrl_base;
> -
> -	/* Common clocks */
> -	struct clk *pp_clk;
> -	struct clk *gop_clk;
> -	struct clk *mg_clk;
> -	struct clk *mg_core_clk;
> -	struct clk *axi_clk;
> -
> -	/* List of pointers to port structures */
> -	int port_count;
> -	struct mvpp2_port *port_list[MVPP2_MAX_PORTS];
> -
> -	/* Aggregated TXQs */
> -	struct mvpp2_tx_queue *aggr_txqs;
> -
> -	/* BM pools */
> -	struct mvpp2_bm_pool *bm_pools;
> -
> -	/* PRS shadow table */
> -	struct mvpp2_prs_shadow *prs_shadow;
> -	/* PRS auxiliary table for double vlan entries control */
> -	bool *prs_double_vlans;
> -
> -	/* Tclk value */
> -	u32 tclk;
> -
> -	/* HW version */
> -	enum { MVPP21, MVPP22 } hw_version;
> -
> -	/* Maximum number of RXQs per port */
> -	unsigned int max_port_rxqs;
> -
> -	/* Workqueue to gather hardware statistics */
> -	char queue_name[30];
> -	struct workqueue_struct *stats_queue;
> -};
> -
> -struct mvpp2_pcpu_stats {
> -	struct	u64_stats_sync syncp;
> -	u64	rx_packets;
> -	u64	rx_bytes;
> -	u64	tx_packets;
> -	u64	tx_bytes;
> -};
> -
> -/* Per-CPU port control */
> -struct mvpp2_port_pcpu {
> -	struct hrtimer tx_done_timer;
> -	bool timer_scheduled;
> -	/* Tasklet for egress finalization */
> -	struct tasklet_struct tx_done_tasklet;
> -};
> -
> -struct mvpp2_queue_vector {
> -	int irq;
> -	struct napi_struct napi;
> -	enum { MVPP2_QUEUE_VECTOR_SHARED, MVPP2_QUEUE_VECTOR_PRIVATE } type;
> -	int sw_thread_id;
> -	u16 sw_thread_mask;
> -	int first_rxq;
> -	int nrxqs;
> -	u32 pending_cause_rx;
> -	struct mvpp2_port *port;
> -};
> -
> -struct mvpp2_port {
> -	u8 id;
> -
> -	/* Index of the port from the "group of ports" complex point
> -	 * of view
> -	 */
> -	int gop_id;
> -
> -	int link_irq;
> -
> -	struct mvpp2 *priv;
> -
> -	/* Firmware node associated to the port */
> -	struct fwnode_handle *fwnode;
> -
> -	/* Is a PHY always connected to the port */
> -	bool has_phy;
> -
> -	/* Per-port registers' base address */
> -	void __iomem *base;
> -	void __iomem *stats_base;
> -
> -	struct mvpp2_rx_queue **rxqs;
> -	unsigned int nrxqs;
> -	struct mvpp2_tx_queue **txqs;
> -	unsigned int ntxqs;
> -	struct net_device *dev;
> -
> -	int pkt_size;
> -
> -	/* Per-CPU port control */
> -	struct mvpp2_port_pcpu __percpu *pcpu;
> -
> -	/* Flags */
> -	unsigned long flags;
> -
> -	u16 tx_ring_size;
> -	u16 rx_ring_size;
> -	struct mvpp2_pcpu_stats __percpu *stats;
> -	u64 *ethtool_stats;
> -
> -	/* Per-port work and its lock to gather hardware statistics */
> -	struct mutex gather_stats_lock;
> -	struct delayed_work stats_work;
> -
> -	struct device_node *of_node;
> -
> -	phy_interface_t phy_interface;
> -	struct phylink *phylink;
> -	struct phy *comphy;
> -
> -	struct mvpp2_bm_pool *pool_long;
> -	struct mvpp2_bm_pool *pool_short;
> -
> -	/* Index of first port's physical RXQ */
> -	u8 first_rxq;
> -
> -	struct mvpp2_queue_vector qvecs[MVPP2_MAX_QVECS];
> -	unsigned int nqvecs;
> -	bool has_tx_irqs;
> -
> -	u32 tx_time_coal;
> -};
> -
> -/* The mvpp2_tx_desc and mvpp2_rx_desc structures describe the
> - * layout of the transmit and reception DMA descriptors, and their
> - * layout is therefore defined by the hardware design
> - */
> -
> -#define MVPP2_TXD_L3_OFF_SHIFT		0
> -#define MVPP2_TXD_IP_HLEN_SHIFT		8
> -#define MVPP2_TXD_L4_CSUM_FRAG		BIT(13)
> -#define MVPP2_TXD_L4_CSUM_NOT		BIT(14)
> -#define MVPP2_TXD_IP_CSUM_DISABLE	BIT(15)
> -#define MVPP2_TXD_PADDING_DISABLE	BIT(23)
> -#define MVPP2_TXD_L4_UDP		BIT(24)
> -#define MVPP2_TXD_L3_IP6		BIT(26)
> -#define MVPP2_TXD_L_DESC		BIT(28)
> -#define MVPP2_TXD_F_DESC		BIT(29)
> -
> -#define MVPP2_RXD_ERR_SUMMARY		BIT(15)
> -#define MVPP2_RXD_ERR_CODE_MASK		(BIT(13) | BIT(14))
> -#define MVPP2_RXD_ERR_CRC		0x0
> -#define MVPP2_RXD_ERR_OVERRUN		BIT(13)
> -#define MVPP2_RXD_ERR_RESOURCE		(BIT(13) | BIT(14))
> -#define MVPP2_RXD_BM_POOL_ID_OFFS	16
> -#define MVPP2_RXD_BM_POOL_ID_MASK	(BIT(16) | BIT(17) | BIT(18))
> -#define MVPP2_RXD_HWF_SYNC		BIT(21)
> -#define MVPP2_RXD_L4_CSUM_OK		BIT(22)
> -#define MVPP2_RXD_IP4_HEADER_ERR	BIT(24)
> -#define MVPP2_RXD_L4_TCP		BIT(25)
> -#define MVPP2_RXD_L4_UDP		BIT(26)
> -#define MVPP2_RXD_L3_IP4		BIT(28)
> -#define MVPP2_RXD_L3_IP6		BIT(30)
> -#define MVPP2_RXD_BUF_HDR		BIT(31)
> -
> -/* HW TX descriptor for PPv2.1 */
> -struct mvpp21_tx_desc {
> -	u32 command;		/* Options used by HW for packet transmitting.*/
> -	u8  packet_offset;	/* the offset from the buffer beginning	*/
> -	u8  phys_txq;		/* destination queue ID			*/
> -	u16 data_size;		/* data size of transmitted packet in bytes */
> -	u32 buf_dma_addr;	/* physical addr of transmitted buffer	*/
> -	u32 buf_cookie;		/* cookie for access to TX buffer in tx path */
> -	u32 reserved1[3];	/* hw_cmd (for future use, BM, PON, PNC) */
> -	u32 reserved2;		/* reserved (for future use)		*/
> -};
> -
> -/* HW RX descriptor for PPv2.1 */
> -struct mvpp21_rx_desc {
> -	u32 status;		/* info about received packet		*/
> -	u16 reserved1;		/* parser_info (for future use, PnC)	*/
> -	u16 data_size;		/* size of received packet in bytes	*/
> -	u32 buf_dma_addr;	/* physical address of the buffer	*/
> -	u32 buf_cookie;		/* cookie for access to RX buffer in rx path */
> -	u16 reserved2;		/* gem_port_id (for future use, PON)	*/
> -	u16 reserved3;		/* csum_l4 (for future use, PnC)	*/
> -	u8  reserved4;		/* bm_qset (for future use, BM)		*/
> -	u8  reserved5;
> -	u16 reserved6;		/* classify_info (for future use, PnC)	*/
> -	u32 reserved7;		/* flow_id (for future use, PnC) */
> -	u32 reserved8;
> -};
> -
> -/* HW TX descriptor for PPv2.2 */
> -struct mvpp22_tx_desc {
> -	u32 command;
> -	u8  packet_offset;
> -	u8  phys_txq;
> -	u16 data_size;
> -	u64 reserved1;
> -	u64 buf_dma_addr_ptp;
> -	u64 buf_cookie_misc;
> -};
> -
> -/* HW RX descriptor for PPv2.2 */
> -struct mvpp22_rx_desc {
> -	u32 status;
> -	u16 reserved1;
> -	u16 data_size;
> -	u32 reserved2;
> -	u32 reserved3;
> -	u64 buf_dma_addr_key_hash;
> -	u64 buf_cookie_misc;
> -};
> -
> -/* Opaque type used by the driver to manipulate the HW TX and RX
> - * descriptors
> - */
> -struct mvpp2_tx_desc {
> -	union {
> -		struct mvpp21_tx_desc pp21;
> -		struct mvpp22_tx_desc pp22;
> -	};
> -};
> -
> -struct mvpp2_rx_desc {
> -	union {
> -		struct mvpp21_rx_desc pp21;
> -		struct mvpp22_rx_desc pp22;
> -	};
> -};
> -
> -struct mvpp2_txq_pcpu_buf {
> -	/* Transmitted SKB */
> -	struct sk_buff *skb;
> -
> -	/* Physical address of transmitted buffer */
> -	dma_addr_t dma;
> -
> -	/* Size transmitted */
> -	size_t size;
> -};
> -
> -/* Per-CPU Tx queue control */
> -struct mvpp2_txq_pcpu {
> -	int cpu;
> -
> -	/* Number of Tx DMA descriptors in the descriptor ring */
> -	int size;
> -
> -	/* Number of currently used Tx DMA descriptor in the
> -	 * descriptor ring
> -	 */
> -	int count;
> -
> -	int wake_threshold;
> -	int stop_threshold;
> -
> -	/* Number of Tx DMA descriptors reserved for each CPU */
> -	int reserved_num;
> -
> -	/* Infos about transmitted buffers */
> -	struct mvpp2_txq_pcpu_buf *buffs;
> -
> -	/* Index of last TX DMA descriptor that was inserted */
> -	int txq_put_index;
> -
> -	/* Index of the TX DMA descriptor to be cleaned up */
> -	int txq_get_index;
> -
> -	/* DMA buffer for TSO headers */
> -	char *tso_headers;
> -	dma_addr_t tso_headers_dma;
> -};
> -
> -struct mvpp2_tx_queue {
> -	/* Physical number of this Tx queue */
> -	u8 id;
> -
> -	/* Logical number of this Tx queue */
> -	u8 log_id;
> -
> -	/* Number of Tx DMA descriptors in the descriptor ring */
> -	int size;
> -
> -	/* Number of currently used Tx DMA descriptor in the descriptor ring */
> -	int count;
> -
> -	/* Per-CPU control of physical Tx queues */
> -	struct mvpp2_txq_pcpu __percpu *pcpu;
> -
> -	u32 done_pkts_coal;
> -
> -	/* Virtual address of thex Tx DMA descriptors array */
> -	struct mvpp2_tx_desc *descs;
> -
> -	/* DMA address of the Tx DMA descriptors array */
> -	dma_addr_t descs_dma;
> -
> -	/* Index of the last Tx DMA descriptor */
> -	int last_desc;
> -
> -	/* Index of the next Tx DMA descriptor to process */
> -	int next_desc_to_proc;
> -};
> -
> -struct mvpp2_rx_queue {
> -	/* RX queue number, in the range 0-31 for physical RXQs */
> -	u8 id;
> -
> -	/* Num of rx descriptors in the rx descriptor ring */
> -	int size;
> -
> -	u32 pkts_coal;
> -	u32 time_coal;
> -
> -	/* Virtual address of the RX DMA descriptors array */
> -	struct mvpp2_rx_desc *descs;
> -
> -	/* DMA address of the RX DMA descriptors array */
> -	dma_addr_t descs_dma;
> -
> -	/* Index of the last RX DMA descriptor */
> -	int last_desc;
> -
> -	/* Index of the next RX DMA descriptor to process */
> -	int next_desc_to_proc;
> -
> -	/* ID of port to which physical RXQ is mapped */
> -	int port;
> -
> -	/* Port's logic RXQ number to which physical RXQ is mapped */
> -	int logic_rxq;
> -};
> -
> -union mvpp2_prs_tcam_entry {
> -	u32 word[MVPP2_PRS_TCAM_WORDS];
> -	u8  byte[MVPP2_PRS_TCAM_WORDS * 4];
> -};
> -
> -union mvpp2_prs_sram_entry {
> -	u32 word[MVPP2_PRS_SRAM_WORDS];
> -	u8  byte[MVPP2_PRS_SRAM_WORDS * 4];
> -};
> -
> -struct mvpp2_prs_entry {
> -	u32 index;
> -	union mvpp2_prs_tcam_entry tcam;
> -	union mvpp2_prs_sram_entry sram;
> -};
> -
> -struct mvpp2_prs_shadow {
> -	bool valid;
> -	bool finish;
> -
> -	/* Lookup ID */
> -	int lu;
> -
> -	/* User defined offset */
> -	int udf;
> -
> -	/* Result info */
> -	u32 ri;
> -	u32 ri_mask;
> -};
> -
> -struct mvpp2_cls_flow_entry {
> -	u32 index;
> -	u32 data[MVPP2_CLS_FLOWS_TBL_DATA_WORDS];
> -};
> -
> -struct mvpp2_cls_lookup_entry {
> -	u32 lkpid;
> -	u32 way;
> -	u32 data;
> -};
> -
> -struct mvpp2_bm_pool {
> -	/* Pool number in the range 0-7 */
> -	int id;
> -
> -	/* Buffer Pointers Pool External (BPPE) size */
> -	int size;
> -	/* BPPE size in bytes */
> -	int size_bytes;
> -	/* Number of buffers for this pool */
> -	int buf_num;
> -	/* Pool buffer size */
> -	int buf_size;
> -	/* Packet size */
> -	int pkt_size;
> -	int frag_size;
> -
> -	/* BPPE virtual base address */
> -	u32 *virt_addr;
> -	/* BPPE DMA base address */
> -	dma_addr_t dma_addr;
> -
> -	/* Ports using BM pool */
> -	u32 port_map;
> -};
> -
> -#define IS_TSO_HEADER(txq_pcpu, addr) \
> -	((addr) >= (txq_pcpu)->tso_headers_dma && \
> -	 (addr) < (txq_pcpu)->tso_headers_dma + \
> -	 (txq_pcpu)->size * TSO_HEADER_SIZE)
> -
> -/* The prototype is added here to be used in start_dev when using ACPI. This
> - * will be removed once phylink is used for all modes (dt+ACPI).
> - */
> -static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
> -			     const struct phylink_link_state *state);
> -
> -/* Queue modes */
> -#define MVPP2_QDIST_SINGLE_MODE	0
> -#define MVPP2_QDIST_MULTI_MODE	1
> -
> -static int queue_mode = MVPP2_QDIST_SINGLE_MODE;
> -
> -module_param(queue_mode, int, 0444);
> -MODULE_PARM_DESC(queue_mode, "Set queue_mode (single=0, multi=1)");
> -
> -#define MVPP2_DRIVER_NAME "mvpp2"
> -#define MVPP2_DRIVER_VERSION "1.0"
> -
> -/* Utility/helper methods */
> -
> -static void mvpp2_write(struct mvpp2 *priv, u32 offset, u32 data)
> -{
> -	writel(data, priv->swth_base[0] + offset);
> -}
> -
> -static u32 mvpp2_read(struct mvpp2 *priv, u32 offset)
> -{
> -	return readl(priv->swth_base[0] + offset);
> -}
> -
> -static u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
> -{
> -	return readl_relaxed(priv->swth_base[0] + offset);
> -}
> -/* These accessors should be used to access:
> - *
> - * - per-CPU registers, where each CPU has its own copy of the
> - *   register.
> - *
> - *   MVPP2_BM_VIRT_ALLOC_REG
> - *   MVPP2_BM_ADDR_HIGH_ALLOC
> - *   MVPP22_BM_ADDR_HIGH_RLS_REG
> - *   MVPP2_BM_VIRT_RLS_REG
> - *   MVPP2_ISR_RX_TX_CAUSE_REG
> - *   MVPP2_ISR_RX_TX_MASK_REG
> - *   MVPP2_TXQ_NUM_REG
> - *   MVPP2_AGGR_TXQ_UPDATE_REG
> - *   MVPP2_TXQ_RSVD_REQ_REG
> - *   MVPP2_TXQ_RSVD_RSLT_REG
> - *   MVPP2_TXQ_SENT_REG
> - *   MVPP2_RXQ_NUM_REG
> - *
> - * - global registers that must be accessed through a specific CPU
> - *   window, because they are related to an access to a per-CPU
> - *   register
> - *
> - *   MVPP2_BM_PHY_ALLOC_REG    (related to MVPP2_BM_VIRT_ALLOC_REG)
> - *   MVPP2_BM_PHY_RLS_REG      (related to MVPP2_BM_VIRT_RLS_REG)
> - *   MVPP2_RXQ_THRESH_REG      (related to MVPP2_RXQ_NUM_REG)
> - *   MVPP2_RXQ_DESC_ADDR_REG   (related to MVPP2_RXQ_NUM_REG)
> - *   MVPP2_RXQ_DESC_SIZE_REG   (related to MVPP2_RXQ_NUM_REG)
> - *   MVPP2_RXQ_INDEX_REG       (related to MVPP2_RXQ_NUM_REG)
> - *   MVPP2_TXQ_PENDING_REG     (related to MVPP2_TXQ_NUM_REG)
> - *   MVPP2_TXQ_DESC_ADDR_REG   (related to MVPP2_TXQ_NUM_REG)
> - *   MVPP2_TXQ_DESC_SIZE_REG   (related to MVPP2_TXQ_NUM_REG)
> - *   MVPP2_TXQ_INDEX_REG       (related to MVPP2_TXQ_NUM_REG)
> - *   MVPP2_TXQ_PENDING_REG     (related to MVPP2_TXQ_NUM_REG)
> - *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
> - *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
> - */
> -static void mvpp2_percpu_write(struct mvpp2 *priv, int cpu,
> -			       u32 offset, u32 data)
> -{
> -	writel(data, priv->swth_base[cpu] + offset);
> -}
> -
> -static u32 mvpp2_percpu_read(struct mvpp2 *priv, int cpu,
> -			     u32 offset)
> -{
> -	return readl(priv->swth_base[cpu] + offset);
> -}
> -
> -static void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, int cpu,
> -				       u32 offset, u32 data)
> -{
> -	writel_relaxed(data, priv->swth_base[cpu] + offset);
> -}
> -
> -static u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, int cpu,
> -				     u32 offset)
> -{
> -	return readl_relaxed(priv->swth_base[cpu] + offset);
> -}
> -
> -static dma_addr_t mvpp2_txdesc_dma_addr_get(struct mvpp2_port *port,
> -					    struct mvpp2_tx_desc *tx_desc)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		return tx_desc->pp21.buf_dma_addr;
> -	else
> -		return tx_desc->pp22.buf_dma_addr_ptp & MVPP2_DESC_DMA_MASK;
> -}
> -
> -static void mvpp2_txdesc_dma_addr_set(struct mvpp2_port *port,
> -				      struct mvpp2_tx_desc *tx_desc,
> -				      dma_addr_t dma_addr)
> -{
> -	dma_addr_t addr, offset;
> -
> -	addr = dma_addr & ~MVPP2_TX_DESC_ALIGN;
> -	offset = dma_addr & MVPP2_TX_DESC_ALIGN;
> -
> -	if (port->priv->hw_version == MVPP21) {
> -		tx_desc->pp21.buf_dma_addr = addr;
> -		tx_desc->pp21.packet_offset = offset;
> -	} else {
> -		u64 val = (u64)addr;
> -
> -		tx_desc->pp22.buf_dma_addr_ptp &= ~MVPP2_DESC_DMA_MASK;
> -		tx_desc->pp22.buf_dma_addr_ptp |= val;
> -		tx_desc->pp22.packet_offset = offset;
> -	}
> -}
> -
> -static size_t mvpp2_txdesc_size_get(struct mvpp2_port *port,
> -				    struct mvpp2_tx_desc *tx_desc)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		return tx_desc->pp21.data_size;
> -	else
> -		return tx_desc->pp22.data_size;
> -}
> -
> -static void mvpp2_txdesc_size_set(struct mvpp2_port *port,
> -				  struct mvpp2_tx_desc *tx_desc,
> -				  size_t size)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		tx_desc->pp21.data_size = size;
> -	else
> -		tx_desc->pp22.data_size = size;
> -}
> -
> -static void mvpp2_txdesc_txq_set(struct mvpp2_port *port,
> -				 struct mvpp2_tx_desc *tx_desc,
> -				 unsigned int txq)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		tx_desc->pp21.phys_txq = txq;
> -	else
> -		tx_desc->pp22.phys_txq = txq;
> -}
> -
> -static void mvpp2_txdesc_cmd_set(struct mvpp2_port *port,
> -				 struct mvpp2_tx_desc *tx_desc,
> -				 unsigned int command)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		tx_desc->pp21.command = command;
> -	else
> -		tx_desc->pp22.command = command;
> -}
> -
> -static unsigned int mvpp2_txdesc_offset_get(struct mvpp2_port *port,
> -					    struct mvpp2_tx_desc *tx_desc)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		return tx_desc->pp21.packet_offset;
> -	else
> -		return tx_desc->pp22.packet_offset;
> -}
> -
> -static dma_addr_t mvpp2_rxdesc_dma_addr_get(struct mvpp2_port *port,
> -					    struct mvpp2_rx_desc *rx_desc)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		return rx_desc->pp21.buf_dma_addr;
> -	else
> -		return rx_desc->pp22.buf_dma_addr_key_hash & MVPP2_DESC_DMA_MASK;
> -}
> -
> -static unsigned long mvpp2_rxdesc_cookie_get(struct mvpp2_port *port,
> -					     struct mvpp2_rx_desc *rx_desc)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		return rx_desc->pp21.buf_cookie;
> -	else
> -		return rx_desc->pp22.buf_cookie_misc & MVPP2_DESC_DMA_MASK;
> -}
> -
> -static size_t mvpp2_rxdesc_size_get(struct mvpp2_port *port,
> -				    struct mvpp2_rx_desc *rx_desc)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		return rx_desc->pp21.data_size;
> -	else
> -		return rx_desc->pp22.data_size;
> -}
> -
> -static u32 mvpp2_rxdesc_status_get(struct mvpp2_port *port,
> -				   struct mvpp2_rx_desc *rx_desc)
> -{
> -	if (port->priv->hw_version == MVPP21)
> -		return rx_desc->pp21.status;
> -	else
> -		return rx_desc->pp22.status;
> -}
> -
> -static void mvpp2_txq_inc_get(struct mvpp2_txq_pcpu *txq_pcpu)
> -{
> -	txq_pcpu->txq_get_index++;
> -	if (txq_pcpu->txq_get_index == txq_pcpu->size)
> -		txq_pcpu->txq_get_index = 0;
> -}
> -
> -static void mvpp2_txq_inc_put(struct mvpp2_port *port,
> -			      struct mvpp2_txq_pcpu *txq_pcpu,
> -			      struct sk_buff *skb,
> -			      struct mvpp2_tx_desc *tx_desc)
> -{
> -	struct mvpp2_txq_pcpu_buf *tx_buf =
> -		txq_pcpu->buffs + txq_pcpu->txq_put_index;
> -	tx_buf->skb = skb;
> -	tx_buf->size = mvpp2_txdesc_size_get(port, tx_desc);
> -	tx_buf->dma = mvpp2_txdesc_dma_addr_get(port, tx_desc) +
> -		mvpp2_txdesc_offset_get(port, tx_desc);
> -	txq_pcpu->txq_put_index++;
> -	if (txq_pcpu->txq_put_index == txq_pcpu->size)
> -		txq_pcpu->txq_put_index = 0;
> -}
> -
> -/* Get number of physical egress port */
> -static inline int mvpp2_egress_port(struct mvpp2_port *port)
> -{
> -	return MVPP2_MAX_TCONT + port->id;
> -}
> -
> -/* Get number of physical TXQ */
> -static inline int mvpp2_txq_phys(int port, int txq)
> -{
> -	return (MVPP2_MAX_TCONT + port) * MVPP2_MAX_TXQ + txq;
> -}
> -
> -/* Parser configuration routines */
> -
> -/* Update parser tcam and sram hw entries */
> -static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
> -{
> -	int i;
> -
> -	if (pe->index > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
> -		return -EINVAL;
> -
> -	/* Clear entry invalidation bit */
> -	pe->tcam.word[MVPP2_PRS_TCAM_INV_WORD] &= ~MVPP2_PRS_TCAM_INV_MASK;
> -
> -	/* Write tcam index - indirect access */
> -	mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, pe->index);
> -	for (i = 0; i < MVPP2_PRS_TCAM_WORDS; i++)
> -		mvpp2_write(priv, MVPP2_PRS_TCAM_DATA_REG(i), pe->tcam.word[i]);
> -
> -	/* Write sram index - indirect access */
> -	mvpp2_write(priv, MVPP2_PRS_SRAM_IDX_REG, pe->index);
> -	for (i = 0; i < MVPP2_PRS_SRAM_WORDS; i++)
> -		mvpp2_write(priv, MVPP2_PRS_SRAM_DATA_REG(i), pe->sram.word[i]);
> -
> -	return 0;
> -}
> -
> -/* Initialize tcam entry from hw */
> -static int mvpp2_prs_init_from_hw(struct mvpp2 *priv,
> -				  struct mvpp2_prs_entry *pe, int tid)
> -{
> -	int i;
> -
> -	if (tid > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
> -		return -EINVAL;
> -
> -	memset(pe, 0, sizeof(*pe));
> -	pe->index = tid;
> -
> -	/* Write tcam index - indirect access */
> -	mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, pe->index);
> -
> -	pe->tcam.word[MVPP2_PRS_TCAM_INV_WORD] = mvpp2_read(priv,
> -			      MVPP2_PRS_TCAM_DATA_REG(MVPP2_PRS_TCAM_INV_WORD));
> -	if (pe->tcam.word[MVPP2_PRS_TCAM_INV_WORD] & MVPP2_PRS_TCAM_INV_MASK)
> -		return MVPP2_PRS_TCAM_ENTRY_INVALID;
> -
> -	for (i = 0; i < MVPP2_PRS_TCAM_WORDS; i++)
> -		pe->tcam.word[i] = mvpp2_read(priv, MVPP2_PRS_TCAM_DATA_REG(i));
> -
> -	/* Write sram index - indirect access */
> -	mvpp2_write(priv, MVPP2_PRS_SRAM_IDX_REG, pe->index);
> -	for (i = 0; i < MVPP2_PRS_SRAM_WORDS; i++)
> -		pe->sram.word[i] = mvpp2_read(priv, MVPP2_PRS_SRAM_DATA_REG(i));
> -
> -	return 0;
> -}
> -
> -/* Invalidate tcam hw entry */
> -static void mvpp2_prs_hw_inv(struct mvpp2 *priv, int index)
> -{
> -	/* Write index - indirect access */
> -	mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, index);
> -	mvpp2_write(priv, MVPP2_PRS_TCAM_DATA_REG(MVPP2_PRS_TCAM_INV_WORD),
> -		    MVPP2_PRS_TCAM_INV_MASK);
> -}
> -
> -/* Enable shadow table entry and set its lookup ID */
> -static void mvpp2_prs_shadow_set(struct mvpp2 *priv, int index, int lu)
> -{
> -	priv->prs_shadow[index].valid = true;
> -	priv->prs_shadow[index].lu = lu;
> -}
> -
> -/* Update ri fields in shadow table entry */
> -static void mvpp2_prs_shadow_ri_set(struct mvpp2 *priv, int index,
> -				    unsigned int ri, unsigned int ri_mask)
> -{
> -	priv->prs_shadow[index].ri_mask = ri_mask;
> -	priv->prs_shadow[index].ri = ri;
> -}
> -
> -/* Update lookup field in tcam sw entry */
> -static void mvpp2_prs_tcam_lu_set(struct mvpp2_prs_entry *pe, unsigned int lu)
> -{
> -	int enable_off = MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_LU_BYTE);
> -
> -	pe->tcam.byte[MVPP2_PRS_TCAM_LU_BYTE] = lu;
> -	pe->tcam.byte[enable_off] = MVPP2_PRS_LU_MASK;
> -}
> -
> -/* Update mask for single port in tcam sw entry */
> -static void mvpp2_prs_tcam_port_set(struct mvpp2_prs_entry *pe,
> -				    unsigned int port, bool add)
> -{
> -	int enable_off = MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_PORT_BYTE);
> -
> -	if (add)
> -		pe->tcam.byte[enable_off] &= ~(1 << port);
> -	else
> -		pe->tcam.byte[enable_off] |= 1 << port;
> -}
> -
> -/* Update port map in tcam sw entry */
> -static void mvpp2_prs_tcam_port_map_set(struct mvpp2_prs_entry *pe,
> -					unsigned int ports)
> -{
> -	unsigned char port_mask = MVPP2_PRS_PORT_MASK;
> -	int enable_off = MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_PORT_BYTE);
> -
> -	pe->tcam.byte[MVPP2_PRS_TCAM_PORT_BYTE] = 0;
> -	pe->tcam.byte[enable_off] &= ~port_mask;
> -	pe->tcam.byte[enable_off] |= ~ports & MVPP2_PRS_PORT_MASK;
> -}
> -
> -/* Obtain port map from tcam sw entry */
> -static unsigned int mvpp2_prs_tcam_port_map_get(struct mvpp2_prs_entry *pe)
> -{
> -	int enable_off = MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_PORT_BYTE);
> -
> -	return ~(pe->tcam.byte[enable_off]) & MVPP2_PRS_PORT_MASK;
> -}
> -
> -/* Set byte of data and its enable bits in tcam sw entry */
> -static void mvpp2_prs_tcam_data_byte_set(struct mvpp2_prs_entry *pe,
> -					 unsigned int offs, unsigned char byte,
> -					 unsigned char enable)
> -{
> -	pe->tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE(offs)] = byte;
> -	pe->tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE_EN(offs)] = enable;
> -}
> -
> -/* Get byte of data and its enable bits from tcam sw entry */
> -static void mvpp2_prs_tcam_data_byte_get(struct mvpp2_prs_entry *pe,
> -					 unsigned int offs, unsigned char *byte,
> -					 unsigned char *enable)
> -{
> -	*byte = pe->tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE(offs)];
> -	*enable = pe->tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE_EN(offs)];
> -}
> -
> -/* Compare tcam data bytes with a pattern */
> -static bool mvpp2_prs_tcam_data_cmp(struct mvpp2_prs_entry *pe, int offs,
> -				    u16 data)
> -{
> -	int off = MVPP2_PRS_TCAM_DATA_BYTE(offs);
> -	u16 tcam_data;
> -
> -	tcam_data = (pe->tcam.byte[off + 1] << 8) | pe->tcam.byte[off];
> -	if (tcam_data != data)
> -		return false;
> -	return true;
> -}
> -
> -/* Update ai bits in tcam sw entry */
> -static void mvpp2_prs_tcam_ai_update(struct mvpp2_prs_entry *pe,
> -				     unsigned int bits, unsigned int enable)
> -{
> -	int i, ai_idx = MVPP2_PRS_TCAM_AI_BYTE;
> -
> -	for (i = 0; i < MVPP2_PRS_AI_BITS; i++) {
> -		if (!(enable & BIT(i)))
> -			continue;
> -
> -		if (bits & BIT(i))
> -			pe->tcam.byte[ai_idx] |= 1 << i;
> -		else
> -			pe->tcam.byte[ai_idx] &= ~(1 << i);
> -	}
> -
> -	pe->tcam.byte[MVPP2_PRS_TCAM_EN_OFFS(ai_idx)] |= enable;
> -}
> -
> -/* Get ai bits from tcam sw entry */
> -static int mvpp2_prs_tcam_ai_get(struct mvpp2_prs_entry *pe)
> -{
> -	return pe->tcam.byte[MVPP2_PRS_TCAM_AI_BYTE];
> -}
> -
> -/* Set ethertype in tcam sw entry */
> -static void mvpp2_prs_match_etype(struct mvpp2_prs_entry *pe, int offset,
> -				  unsigned short ethertype)
> -{
> -	mvpp2_prs_tcam_data_byte_set(pe, offset + 0, ethertype >> 8, 0xff);
> -	mvpp2_prs_tcam_data_byte_set(pe, offset + 1, ethertype & 0xff, 0xff);
> -}
> -
> -/* Set vid in tcam sw entry */
> -static void mvpp2_prs_match_vid(struct mvpp2_prs_entry *pe, int offset,
> -				unsigned short vid)
> -{
> -	mvpp2_prs_tcam_data_byte_set(pe, offset + 0, (vid & 0xf00) >> 8, 0xf);
> -	mvpp2_prs_tcam_data_byte_set(pe, offset + 1, vid & 0xff, 0xff);
> -}
> -
> -/* Set bits in sram sw entry */
> -static void mvpp2_prs_sram_bits_set(struct mvpp2_prs_entry *pe, int bit_num,
> -				    int val)
> -{
> -	pe->sram.byte[MVPP2_BIT_TO_BYTE(bit_num)] |= (val << (bit_num % 8));
> -}
> -
> -/* Clear bits in sram sw entry */
> -static void mvpp2_prs_sram_bits_clear(struct mvpp2_prs_entry *pe, int bit_num,
> -				      int val)
> -{
> -	pe->sram.byte[MVPP2_BIT_TO_BYTE(bit_num)] &= ~(val << (bit_num % 8));
> -}
> -
> -/* Update ri bits in sram sw entry */
> -static void mvpp2_prs_sram_ri_update(struct mvpp2_prs_entry *pe,
> -				     unsigned int bits, unsigned int mask)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < MVPP2_PRS_SRAM_RI_CTRL_BITS; i++) {
> -		int ri_off = MVPP2_PRS_SRAM_RI_OFFS;
> -
> -		if (!(mask & BIT(i)))
> -			continue;
> -
> -		if (bits & BIT(i))
> -			mvpp2_prs_sram_bits_set(pe, ri_off + i, 1);
> -		else
> -			mvpp2_prs_sram_bits_clear(pe, ri_off + i, 1);
> -
> -		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_RI_CTRL_OFFS + i, 1);
> -	}
> -}
> -
> -/* Obtain ri bits from sram sw entry */
> -static int mvpp2_prs_sram_ri_get(struct mvpp2_prs_entry *pe)
> -{
> -	return pe->sram.word[MVPP2_PRS_SRAM_RI_WORD];
> -}
> -
> -/* Update ai bits in sram sw entry */
> -static void mvpp2_prs_sram_ai_update(struct mvpp2_prs_entry *pe,
> -				     unsigned int bits, unsigned int mask)
> -{
> -	unsigned int i;
> -	int ai_off = MVPP2_PRS_SRAM_AI_OFFS;
> -
> -	for (i = 0; i < MVPP2_PRS_SRAM_AI_CTRL_BITS; i++) {
> -		if (!(mask & BIT(i)))
> -			continue;
> -
> -		if (bits & BIT(i))
> -			mvpp2_prs_sram_bits_set(pe, ai_off + i, 1);
> -		else
> -			mvpp2_prs_sram_bits_clear(pe, ai_off + i, 1);
> -
> -		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_AI_CTRL_OFFS + i, 1);
> -	}
> -}
> -
> -/* Read ai bits from sram sw entry */
> -static int mvpp2_prs_sram_ai_get(struct mvpp2_prs_entry *pe)
> -{
> -	u8 bits;
> -	int ai_off = MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_AI_OFFS);
> -	int ai_en_off = ai_off + 1;
> -	int ai_shift = MVPP2_PRS_SRAM_AI_OFFS % 8;
> -
> -	bits = (pe->sram.byte[ai_off] >> ai_shift) |
> -	       (pe->sram.byte[ai_en_off] << (8 - ai_shift));
> -
> -	return bits;
> -}
> -
> -/* In sram sw entry set lookup ID field of the tcam key to be used in the next
> - * lookup interation
> - */
> -static void mvpp2_prs_sram_next_lu_set(struct mvpp2_prs_entry *pe,
> -				       unsigned int lu)
> -{
> -	int sram_next_off = MVPP2_PRS_SRAM_NEXT_LU_OFFS;
> -
> -	mvpp2_prs_sram_bits_clear(pe, sram_next_off,
> -				  MVPP2_PRS_SRAM_NEXT_LU_MASK);
> -	mvpp2_prs_sram_bits_set(pe, sram_next_off, lu);
> -}
> -
> -/* In the sram sw entry set sign and value of the next lookup offset
> - * and the offset value generated to the classifier
> - */
> -static void mvpp2_prs_sram_shift_set(struct mvpp2_prs_entry *pe, int shift,
> -				     unsigned int op)
> -{
> -	/* Set sign */
> -	if (shift < 0) {
> -		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_SHIFT_SIGN_BIT, 1);
> -		shift = 0 - shift;
> -	} else {
> -		mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_SHIFT_SIGN_BIT, 1);
> -	}
> -
> -	/* Set value */
> -	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_SHIFT_OFFS)] =
> -							   (unsigned char)shift;
> -
> -	/* Reset and set operation */
> -	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_SHIFT_OFFS,
> -				  MVPP2_PRS_SRAM_OP_SEL_SHIFT_MASK);
> -	mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_OP_SEL_SHIFT_OFFS, op);
> -
> -	/* Set base offset as current */
> -	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_BASE_OFFS, 1);
> -}
> -
> -/* In the sram sw entry set sign and value of the user defined offset
> - * generated to the classifier
> - */
> -static void mvpp2_prs_sram_offset_set(struct mvpp2_prs_entry *pe,
> -				      unsigned int type, int offset,
> -				      unsigned int op)
> -{
> -	/* Set sign */
> -	if (offset < 0) {
> -		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_UDF_SIGN_BIT, 1);
> -		offset = 0 - offset;
> -	} else {
> -		mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_UDF_SIGN_BIT, 1);
> -	}
> -
> -	/* Set value */
> -	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_UDF_OFFS,
> -				  MVPP2_PRS_SRAM_UDF_MASK);
> -	mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_UDF_OFFS, offset);
> -	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_UDF_OFFS +
> -					MVPP2_PRS_SRAM_UDF_BITS)] &=
> -	      ~(MVPP2_PRS_SRAM_UDF_MASK >> (8 - (MVPP2_PRS_SRAM_UDF_OFFS % 8)));
> -	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_UDF_OFFS +
> -					MVPP2_PRS_SRAM_UDF_BITS)] |=
> -				(offset >> (8 - (MVPP2_PRS_SRAM_UDF_OFFS % 8)));
> -
> -	/* Set offset type */
> -	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_UDF_TYPE_OFFS,
> -				  MVPP2_PRS_SRAM_UDF_TYPE_MASK);
> -	mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_UDF_TYPE_OFFS, type);
> -
> -	/* Set offset operation */
> -	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_MASK);
> -	mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS, op);
> -
> -	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS +
> -					MVPP2_PRS_SRAM_OP_SEL_UDF_BITS)] &=
> -					     ~(MVPP2_PRS_SRAM_OP_SEL_UDF_MASK >>
> -				    (8 - (MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS % 8)));
> -
> -	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS +
> -					MVPP2_PRS_SRAM_OP_SEL_UDF_BITS)] |=
> -			     (op >> (8 - (MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS % 8)));
> -
> -	/* Set base offset as current */
> -	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_BASE_OFFS, 1);
> -}
> -
> -/* Find parser flow entry */
> -static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	/* Go through the all entires with MVPP2_PRS_LU_FLOWS */
> -	for (tid = MVPP2_PRS_TCAM_SRAM_SIZE - 1; tid >= 0; tid--) {
> -		u8 bits;
> -
> -		if (!priv->prs_shadow[tid].valid ||
> -		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_FLOWS)
> -			continue;
> -
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -		bits = mvpp2_prs_sram_ai_get(&pe);
> -
> -		/* Sram store classification lookup ID in AI bits [5:0] */
> -		if ((bits & MVPP2_PRS_FLOW_ID_MASK) == flow)
> -			return tid;
> -	}
> -
> -	return -ENOENT;
> -}
> -
> -/* Return first free tcam index, seeking from start to end */
> -static int mvpp2_prs_tcam_first_free(struct mvpp2 *priv, unsigned char start,
> -				     unsigned char end)
> -{
> -	int tid;
> -
> -	if (start > end)
> -		swap(start, end);
> -
> -	if (end >= MVPP2_PRS_TCAM_SRAM_SIZE)
> -		end = MVPP2_PRS_TCAM_SRAM_SIZE - 1;
> -
> -	for (tid = start; tid <= end; tid++) {
> -		if (!priv->prs_shadow[tid].valid)
> -			return tid;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/* Enable/disable dropping all mac da's */
> -static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
> -{
> -	struct mvpp2_prs_entry pe;
> -
> -	if (priv->prs_shadow[MVPP2_PE_DROP_ALL].valid) {
> -		/* Entry exist - update port only */
> -		mvpp2_prs_init_from_hw(priv, &pe, MVPP2_PE_DROP_ALL);
> -	} else {
> -		/* Entry doesn't exist - create new */
> -		memset(&pe, 0, sizeof(pe));
> -		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
> -		pe.index = MVPP2_PE_DROP_ALL;
> -
> -		/* Non-promiscuous mode for all ports - DROP unknown packets */
> -		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_DROP_MASK,
> -					 MVPP2_PRS_RI_DROP_MASK);
> -
> -		mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -
> -		/* Update shadow table */
> -		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> -
> -		/* Mask all ports */
> -		mvpp2_prs_tcam_port_map_set(&pe, 0);
> -	}
> -
> -	/* Update port mask */
> -	mvpp2_prs_tcam_port_set(&pe, port, add);
> -
> -	mvpp2_prs_hw_write(priv, &pe);
> -}
> -
> -/* Set port to unicast or multicast promiscuous mode */
> -static void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
> -				      enum mvpp2_prs_l2_cast l2_cast, bool add)
> -{
> -	struct mvpp2_prs_entry pe;
> -	unsigned char cast_match;
> -	unsigned int ri;
> -	int tid;
> -
> -	if (l2_cast == MVPP2_PRS_L2_UNI_CAST) {
> -		cast_match = MVPP2_PRS_UCAST_VAL;
> -		tid = MVPP2_PE_MAC_UC_PROMISCUOUS;
> -		ri = MVPP2_PRS_RI_L2_UCAST;
> -	} else {
> -		cast_match = MVPP2_PRS_MCAST_VAL;
> -		tid = MVPP2_PE_MAC_MC_PROMISCUOUS;
> -		ri = MVPP2_PRS_RI_L2_MCAST;
> -	}
> -
> -	/* promiscuous mode - Accept unknown unicast or multicast packets */
> -	if (priv->prs_shadow[tid].valid) {
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -	} else {
> -		memset(&pe, 0, sizeof(pe));
> -		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
> -		pe.index = tid;
> -
> -		/* Continue - set next lookup */
> -		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_DSA);
> -
> -		/* Set result info bits */
> -		mvpp2_prs_sram_ri_update(&pe, ri, MVPP2_PRS_RI_L2_CAST_MASK);
> -
> -		/* Match UC or MC addresses */
> -		mvpp2_prs_tcam_data_byte_set(&pe, 0, cast_match,
> -					     MVPP2_PRS_CAST_MASK);
> -
> -		/* Shift to ethertype */
> -		mvpp2_prs_sram_shift_set(&pe, 2 * ETH_ALEN,
> -					 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -		/* Mask all ports */
> -		mvpp2_prs_tcam_port_map_set(&pe, 0);
> -
> -		/* Update shadow table */
> -		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> -	}
> -
> -	/* Update port mask */
> -	mvpp2_prs_tcam_port_set(&pe, port, add);
> -
> -	mvpp2_prs_hw_write(priv, &pe);
> -}
> -
> -/* Set entry for dsa packets */
> -static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
> -				  bool tagged, bool extend)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid, shift;
> -
> -	if (extend) {
> -		tid = tagged ? MVPP2_PE_EDSA_TAGGED : MVPP2_PE_EDSA_UNTAGGED;
> -		shift = 8;
> -	} else {
> -		tid = tagged ? MVPP2_PE_DSA_TAGGED : MVPP2_PE_DSA_UNTAGGED;
> -		shift = 4;
> -	}
> -
> -	if (priv->prs_shadow[tid].valid) {
> -		/* Entry exist - update port only */
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -	} else {
> -		/* Entry doesn't exist - create new */
> -		memset(&pe, 0, sizeof(pe));
> -		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_DSA);
> -		pe.index = tid;
> -
> -		/* Update shadow table */
> -		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_DSA);
> -
> -		if (tagged) {
> -			/* Set tagged bit in DSA tag */
> -			mvpp2_prs_tcam_data_byte_set(&pe, 0,
> -					     MVPP2_PRS_TCAM_DSA_TAGGED_BIT,
> -					     MVPP2_PRS_TCAM_DSA_TAGGED_BIT);
> -
> -			/* Set ai bits for next iteration */
> -			if (extend)
> -				mvpp2_prs_sram_ai_update(&pe, 1,
> -							MVPP2_PRS_SRAM_AI_MASK);
> -			else
> -				mvpp2_prs_sram_ai_update(&pe, 0,
> -							MVPP2_PRS_SRAM_AI_MASK);
> -
> -			/* Set result info bits to 'single vlan' */
> -			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_SINGLE,
> -						 MVPP2_PRS_RI_VLAN_MASK);
> -			/* If packet is tagged continue check vid filtering */
> -			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VID);
> -		} else {
> -			/* Shift 4 bytes for DSA tag or 8 bytes for EDSA tag*/
> -			mvpp2_prs_sram_shift_set(&pe, shift,
> -					MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -			/* Set result info bits to 'no vlans' */
> -			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_NONE,
> -						 MVPP2_PRS_RI_VLAN_MASK);
> -			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> -		}
> -
> -		/* Mask all ports */
> -		mvpp2_prs_tcam_port_map_set(&pe, 0);
> -	}
> -
> -	/* Update port mask */
> -	mvpp2_prs_tcam_port_set(&pe, port, add);
> -
> -	mvpp2_prs_hw_write(priv, &pe);
> -}
> -
> -/* Set entry for dsa ethertype */
> -static void mvpp2_prs_dsa_tag_ethertype_set(struct mvpp2 *priv, int port,
> -					    bool add, bool tagged, bool extend)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid, shift, port_mask;
> -
> -	if (extend) {
> -		tid = tagged ? MVPP2_PE_ETYPE_EDSA_TAGGED :
> -		      MVPP2_PE_ETYPE_EDSA_UNTAGGED;
> -		port_mask = 0;
> -		shift = 8;
> -	} else {
> -		tid = tagged ? MVPP2_PE_ETYPE_DSA_TAGGED :
> -		      MVPP2_PE_ETYPE_DSA_UNTAGGED;
> -		port_mask = MVPP2_PRS_PORT_MASK;
> -		shift = 4;
> -	}
> -
> -	if (priv->prs_shadow[tid].valid) {
> -		/* Entry exist - update port only */
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -	} else {
> -		/* Entry doesn't exist - create new */
> -		memset(&pe, 0, sizeof(pe));
> -		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_DSA);
> -		pe.index = tid;
> -
> -		/* Set ethertype */
> -		mvpp2_prs_match_etype(&pe, 0, ETH_P_EDSA);
> -		mvpp2_prs_match_etype(&pe, 2, 0);
> -
> -		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_DSA_MASK,
> -					 MVPP2_PRS_RI_DSA_MASK);
> -		/* Shift ethertype + 2 byte reserved + tag*/
> -		mvpp2_prs_sram_shift_set(&pe, 2 + MVPP2_ETH_TYPE_LEN + shift,
> -					 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -		/* Update shadow table */
> -		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_DSA);
> -
> -		if (tagged) {
> -			/* Set tagged bit in DSA tag */
> -			mvpp2_prs_tcam_data_byte_set(&pe,
> -						     MVPP2_ETH_TYPE_LEN + 2 + 3,
> -						 MVPP2_PRS_TCAM_DSA_TAGGED_BIT,
> -						 MVPP2_PRS_TCAM_DSA_TAGGED_BIT);
> -			/* Clear all ai bits for next iteration */
> -			mvpp2_prs_sram_ai_update(&pe, 0,
> -						 MVPP2_PRS_SRAM_AI_MASK);
> -			/* If packet is tagged continue check vlans */
> -			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> -		} else {
> -			/* Set result info bits to 'no vlans' */
> -			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_NONE,
> -						 MVPP2_PRS_RI_VLAN_MASK);
> -			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> -		}
> -		/* Mask/unmask all ports, depending on dsa type */
> -		mvpp2_prs_tcam_port_map_set(&pe, port_mask);
> -	}
> -
> -	/* Update port mask */
> -	mvpp2_prs_tcam_port_set(&pe, port, add);
> -
> -	mvpp2_prs_hw_write(priv, &pe);
> -}
> -
> -/* Search for existing single/triple vlan entry */
> -static int mvpp2_prs_vlan_find(struct mvpp2 *priv, unsigned short tpid, int ai)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	/* Go through the all entries with MVPP2_PRS_LU_VLAN */
> -	for (tid = MVPP2_PE_FIRST_FREE_TID;
> -	     tid <= MVPP2_PE_LAST_FREE_TID; tid++) {
> -		unsigned int ri_bits, ai_bits;
> -		bool match;
> -
> -		if (!priv->prs_shadow[tid].valid ||
> -		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
> -			continue;
> -
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -		match = mvpp2_prs_tcam_data_cmp(&pe, 0, swab16(tpid));
> -		if (!match)
> -			continue;
> -
> -		/* Get vlan type */
> -		ri_bits = mvpp2_prs_sram_ri_get(&pe);
> -		ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
> -
> -		/* Get current ai value from tcam */
> -		ai_bits = mvpp2_prs_tcam_ai_get(&pe);
> -		/* Clear double vlan bit */
> -		ai_bits &= ~MVPP2_PRS_DBL_VLAN_AI_BIT;
> -
> -		if (ai != ai_bits)
> -			continue;
> -
> -		if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
> -		    ri_bits == MVPP2_PRS_RI_VLAN_TRIPLE)
> -			return tid;
> -	}
> -
> -	return -ENOENT;
> -}
> -
> -/* Add/update single/triple vlan entry */
> -static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
> -			      unsigned int port_map)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid_aux, tid;
> -	int ret = 0;
> -
> -	memset(&pe, 0, sizeof(pe));
> -
> -	tid = mvpp2_prs_vlan_find(priv, tpid, ai);
> -
> -	if (tid < 0) {
> -		/* Create new tcam entry */
> -		tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_LAST_FREE_TID,
> -						MVPP2_PE_FIRST_FREE_TID);
> -		if (tid < 0)
> -			return tid;
> -
> -		/* Get last double vlan tid */
> -		for (tid_aux = MVPP2_PE_LAST_FREE_TID;
> -		     tid_aux >= MVPP2_PE_FIRST_FREE_TID; tid_aux--) {
> -			unsigned int ri_bits;
> -
> -			if (!priv->prs_shadow[tid_aux].valid ||
> -			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
> -				continue;
> -
> -			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
> -			ri_bits = mvpp2_prs_sram_ri_get(&pe);
> -			if ((ri_bits & MVPP2_PRS_RI_VLAN_MASK) ==
> -			    MVPP2_PRS_RI_VLAN_DOUBLE)
> -				break;
> -		}
> -
> -		if (tid <= tid_aux)
> -			return -EINVAL;
> -
> -		memset(&pe, 0, sizeof(pe));
> -		pe.index = tid;
> -		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> -
> -		mvpp2_prs_match_etype(&pe, 0, tpid);
> -
> -		/* VLAN tag detected, proceed with VID filtering */
> -		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VID);
> -
> -		/* Clear all ai bits for next iteration */
> -		mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> -
> -		if (ai == MVPP2_PRS_SINGLE_VLAN_AI) {
> -			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_SINGLE,
> -						 MVPP2_PRS_RI_VLAN_MASK);
> -		} else {
> -			ai |= MVPP2_PRS_DBL_VLAN_AI_BIT;
> -			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_TRIPLE,
> -						 MVPP2_PRS_RI_VLAN_MASK);
> -		}
> -		mvpp2_prs_tcam_ai_update(&pe, ai, MVPP2_PRS_SRAM_AI_MASK);
> -
> -		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
> -	} else {
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -	}
> -	/* Update ports' mask */
> -	mvpp2_prs_tcam_port_map_set(&pe, port_map);
> -
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return ret;
> -}
> -
> -/* Get first free double vlan ai number */
> -static int mvpp2_prs_double_vlan_ai_free_get(struct mvpp2 *priv)
> -{
> -	int i;
> -
> -	for (i = 1; i < MVPP2_PRS_DBL_VLANS_MAX; i++) {
> -		if (!priv->prs_double_vlans[i])
> -			return i;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/* Search for existing double vlan entry */
> -static int mvpp2_prs_double_vlan_find(struct mvpp2 *priv, unsigned short tpid1,
> -				      unsigned short tpid2)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	/* Go through the all entries with MVPP2_PRS_LU_VLAN */
> -	for (tid = MVPP2_PE_FIRST_FREE_TID;
> -	     tid <= MVPP2_PE_LAST_FREE_TID; tid++) {
> -		unsigned int ri_mask;
> -		bool match;
> -
> -		if (!priv->prs_shadow[tid].valid ||
> -		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
> -			continue;
> -
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -
> -		match = mvpp2_prs_tcam_data_cmp(&pe, 0, swab16(tpid1)) &&
> -			mvpp2_prs_tcam_data_cmp(&pe, 4, swab16(tpid2));
> -
> -		if (!match)
> -			continue;
> -
> -		ri_mask = mvpp2_prs_sram_ri_get(&pe) & MVPP2_PRS_RI_VLAN_MASK;
> -		if (ri_mask == MVPP2_PRS_RI_VLAN_DOUBLE)
> -			return tid;
> -	}
> -
> -	return -ENOENT;
> -}
> -
> -/* Add or update double vlan entry */
> -static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
> -				     unsigned short tpid2,
> -				     unsigned int port_map)
> -{
> -	int tid_aux, tid, ai, ret = 0;
> -	struct mvpp2_prs_entry pe;
> -
> -	memset(&pe, 0, sizeof(pe));
> -
> -	tid = mvpp2_prs_double_vlan_find(priv, tpid1, tpid2);
> -
> -	if (tid < 0) {
> -		/* Create new tcam entry */
> -		tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -				MVPP2_PE_LAST_FREE_TID);
> -		if (tid < 0)
> -			return tid;
> -
> -		/* Set ai value for new double vlan entry */
> -		ai = mvpp2_prs_double_vlan_ai_free_get(priv);
> -		if (ai < 0)
> -			return ai;
> -
> -		/* Get first single/triple vlan tid */
> -		for (tid_aux = MVPP2_PE_FIRST_FREE_TID;
> -		     tid_aux <= MVPP2_PE_LAST_FREE_TID; tid_aux++) {
> -			unsigned int ri_bits;
> -
> -			if (!priv->prs_shadow[tid_aux].valid ||
> -			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
> -				continue;
> -
> -			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
> -			ri_bits = mvpp2_prs_sram_ri_get(&pe);
> -			ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
> -			if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
> -			    ri_bits == MVPP2_PRS_RI_VLAN_TRIPLE)
> -				break;
> -		}
> -
> -		if (tid >= tid_aux)
> -			return -ERANGE;
> -
> -		memset(&pe, 0, sizeof(pe));
> -		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> -		pe.index = tid;
> -
> -		priv->prs_double_vlans[ai] = true;
> -
> -		mvpp2_prs_match_etype(&pe, 0, tpid1);
> -		mvpp2_prs_match_etype(&pe, 4, tpid2);
> -
> -		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> -		/* Shift 4 bytes - skip outer vlan tag */
> -		mvpp2_prs_sram_shift_set(&pe, MVPP2_VLAN_TAG_LEN,
> -					 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_DOUBLE,
> -					 MVPP2_PRS_RI_VLAN_MASK);
> -		mvpp2_prs_sram_ai_update(&pe, ai | MVPP2_PRS_DBL_VLAN_AI_BIT,
> -					 MVPP2_PRS_SRAM_AI_MASK);
> -
> -		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
> -	} else {
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -	}
> -
> -	/* Update ports' mask */
> -	mvpp2_prs_tcam_port_map_set(&pe, port_map);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return ret;
> -}
> -
> -/* IPv4 header parsing for fragmentation and L4 offset */
> -static int mvpp2_prs_ip4_proto(struct mvpp2 *priv, unsigned short proto,
> -			       unsigned int ri, unsigned int ri_mask)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	if ((proto != IPPROTO_TCP) && (proto != IPPROTO_UDP) &&
> -	    (proto != IPPROTO_IGMP))
> -		return -EINVAL;
> -
> -	/* Not fragmented packet */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP4);
> -	pe.index = tid;
> -
> -	/* Set next lu to IPv4 */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_sram_shift_set(&pe, 12, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	/* Set L4 offset */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L4,
> -				  sizeof(struct iphdr) - 4,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -	mvpp2_prs_sram_ai_update(&pe, MVPP2_PRS_IPV4_DIP_AI_BIT,
> -				 MVPP2_PRS_IPV4_DIP_AI_BIT);
> -	mvpp2_prs_sram_ri_update(&pe, ri, ri_mask | MVPP2_PRS_RI_IP_FRAG_MASK);
> -
> -	mvpp2_prs_tcam_data_byte_set(&pe, 2, 0x00,
> -				     MVPP2_PRS_TCAM_PROTO_MASK_L);
> -	mvpp2_prs_tcam_data_byte_set(&pe, 3, 0x00,
> -				     MVPP2_PRS_TCAM_PROTO_MASK);
> -
> -	mvpp2_prs_tcam_data_byte_set(&pe, 5, proto, MVPP2_PRS_TCAM_PROTO_MASK);
> -	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_IPV4_DIP_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Fragmented packet */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	pe.index = tid;
> -	/* Clear ri before updating */
> -	pe.sram.word[MVPP2_PRS_SRAM_RI_WORD] = 0x0;
> -	pe.sram.word[MVPP2_PRS_SRAM_RI_CTRL_WORD] = 0x0;
> -	mvpp2_prs_sram_ri_update(&pe, ri, ri_mask);
> -
> -	mvpp2_prs_sram_ri_update(&pe, ri | MVPP2_PRS_RI_IP_FRAG_TRUE,
> -				 ri_mask | MVPP2_PRS_RI_IP_FRAG_MASK);
> -
> -	mvpp2_prs_tcam_data_byte_set(&pe, 2, 0x00, 0x0);
> -	mvpp2_prs_tcam_data_byte_set(&pe, 3, 0x00, 0x0);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* IPv4 L3 multicast or broadcast */
> -static int mvpp2_prs_ip4_cast(struct mvpp2 *priv, unsigned short l3_cast)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int mask, tid;
> -
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP4);
> -	pe.index = tid;
> -
> -	switch (l3_cast) {
> -	case MVPP2_PRS_L3_MULTI_CAST:
> -		mvpp2_prs_tcam_data_byte_set(&pe, 0, MVPP2_PRS_IPV4_MC,
> -					     MVPP2_PRS_IPV4_MC_MASK);
> -		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_MCAST,
> -					 MVPP2_PRS_RI_L3_ADDR_MASK);
> -		break;
> -	case  MVPP2_PRS_L3_BROAD_CAST:
> -		mask = MVPP2_PRS_IPV4_BC_MASK;
> -		mvpp2_prs_tcam_data_byte_set(&pe, 0, mask, mask);
> -		mvpp2_prs_tcam_data_byte_set(&pe, 1, mask, mask);
> -		mvpp2_prs_tcam_data_byte_set(&pe, 2, mask, mask);
> -		mvpp2_prs_tcam_data_byte_set(&pe, 3, mask, mask);
> -		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_BCAST,
> -					 MVPP2_PRS_RI_L3_ADDR_MASK);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	/* Finished: go to flowid generation */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV4_DIP_AI_BIT,
> -				 MVPP2_PRS_IPV4_DIP_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* Set entries for protocols over IPv6  */
> -static int mvpp2_prs_ip6_proto(struct mvpp2 *priv, unsigned short proto,
> -			       unsigned int ri, unsigned int ri_mask)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	if ((proto != IPPROTO_TCP) && (proto != IPPROTO_UDP) &&
> -	    (proto != IPPROTO_ICMPV6) && (proto != IPPROTO_IPIP))
> -		return -EINVAL;
> -
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	pe.index = tid;
> -
> -	/* Finished: go to flowid generation */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_ri_update(&pe, ri, ri_mask);
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L4,
> -				  sizeof(struct ipv6hdr) - 6,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	mvpp2_prs_tcam_data_byte_set(&pe, 0, proto, MVPP2_PRS_TCAM_PROTO_MASK);
> -	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> -				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Write HW */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP6);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* IPv6 L3 multicast entry */
> -static int mvpp2_prs_ip6_cast(struct mvpp2 *priv, unsigned short l3_cast)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	if (l3_cast != MVPP2_PRS_L3_MULTI_CAST)
> -		return -EINVAL;
> -
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	pe.index = tid;
> -
> -	/* Finished: go to flowid generation */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_MCAST,
> -				 MVPP2_PRS_RI_L3_ADDR_MASK);
> -	mvpp2_prs_sram_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> -				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> -	/* Shift back to IPv6 NH */
> -	mvpp2_prs_sram_shift_set(&pe, -18, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -	mvpp2_prs_tcam_data_byte_set(&pe, 0, MVPP2_PRS_IPV6_MC,
> -				     MVPP2_PRS_IPV6_MC_MASK);
> -	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP6);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* Parser per-port initialization */
> -static void mvpp2_prs_hw_port_init(struct mvpp2 *priv, int port, int lu_first,
> -				   int lu_max, int offset)
> -{
> -	u32 val;
> -
> -	/* Set lookup ID */
> -	val = mvpp2_read(priv, MVPP2_PRS_INIT_LOOKUP_REG);
> -	val &= ~MVPP2_PRS_PORT_LU_MASK(port);
> -	val |=  MVPP2_PRS_PORT_LU_VAL(port, lu_first);
> -	mvpp2_write(priv, MVPP2_PRS_INIT_LOOKUP_REG, val);
> -
> -	/* Set maximum number of loops for packet received from port */
> -	val = mvpp2_read(priv, MVPP2_PRS_MAX_LOOP_REG(port));
> -	val &= ~MVPP2_PRS_MAX_LOOP_MASK(port);
> -	val |= MVPP2_PRS_MAX_LOOP_VAL(port, lu_max);
> -	mvpp2_write(priv, MVPP2_PRS_MAX_LOOP_REG(port), val);
> -
> -	/* Set initial offset for packet header extraction for the first
> -	 * searching loop
> -	 */
> -	val = mvpp2_read(priv, MVPP2_PRS_INIT_OFFS_REG(port));
> -	val &= ~MVPP2_PRS_INIT_OFF_MASK(port);
> -	val |= MVPP2_PRS_INIT_OFF_VAL(port, offset);
> -	mvpp2_write(priv, MVPP2_PRS_INIT_OFFS_REG(port), val);
> -}
> -
> -/* Default flow entries initialization for all ports */
> -static void mvpp2_prs_def_flow_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int port;
> -
> -	for (port = 0; port < MVPP2_MAX_PORTS; port++) {
> -		memset(&pe, 0, sizeof(pe));
> -		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -		pe.index = MVPP2_PE_FIRST_DEFAULT_FLOW - port;
> -
> -		/* Mask all ports */
> -		mvpp2_prs_tcam_port_map_set(&pe, 0);
> -
> -		/* Set flow ID*/
> -		mvpp2_prs_sram_ai_update(&pe, port, MVPP2_PRS_FLOW_ID_MASK);
> -		mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_DONE_BIT, 1);
> -
> -		/* Update shadow table and hw entry */
> -		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_FLOWS);
> -		mvpp2_prs_hw_write(priv, &pe);
> -	}
> -}
> -
> -/* Set default entry for Marvell Header field */
> -static void mvpp2_prs_mh_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -
> -	memset(&pe, 0, sizeof(pe));
> -
> -	pe.index = MVPP2_PE_MH_DEFAULT;
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MH);
> -	mvpp2_prs_sram_shift_set(&pe, MVPP2_MH_SIZE,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_MAC);
> -
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MH);
> -	mvpp2_prs_hw_write(priv, &pe);
> -}
> -
> -/* Set default entires (place holder) for promiscuous, non-promiscuous and
> - * multicast MAC addresses
> - */
> -static void mvpp2_prs_mac_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -
> -	memset(&pe, 0, sizeof(pe));
> -
> -	/* Non-promiscuous mode for all ports - DROP unknown packets */
> -	pe.index = MVPP2_PE_MAC_NON_PROMISCUOUS;
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
> -
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_DROP_MASK,
> -				 MVPP2_PRS_RI_DROP_MASK);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Create dummy entries for drop all and promiscuous modes */
> -	mvpp2_prs_mac_drop_all_set(priv, 0, false);
> -	mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_UNI_CAST, false);
> -	mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_MULTI_CAST, false);
> -}
> -
> -/* Set default entries for various types of dsa packets */
> -static void mvpp2_prs_dsa_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -
> -	/* None tagged EDSA entry - place holder */
> -	mvpp2_prs_dsa_tag_set(priv, 0, false, MVPP2_PRS_UNTAGGED,
> -			      MVPP2_PRS_EDSA);
> -
> -	/* Tagged EDSA entry - place holder */
> -	mvpp2_prs_dsa_tag_set(priv, 0, false, MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> -
> -	/* None tagged DSA entry - place holder */
> -	mvpp2_prs_dsa_tag_set(priv, 0, false, MVPP2_PRS_UNTAGGED,
> -			      MVPP2_PRS_DSA);
> -
> -	/* Tagged DSA entry - place holder */
> -	mvpp2_prs_dsa_tag_set(priv, 0, false, MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> -
> -	/* None tagged EDSA ethertype entry - place holder*/
> -	mvpp2_prs_dsa_tag_ethertype_set(priv, 0, false,
> -					MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> -
> -	/* Tagged EDSA ethertype entry - place holder*/
> -	mvpp2_prs_dsa_tag_ethertype_set(priv, 0, false,
> -					MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> -
> -	/* None tagged DSA ethertype entry */
> -	mvpp2_prs_dsa_tag_ethertype_set(priv, 0, true,
> -					MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> -
> -	/* Tagged DSA ethertype entry */
> -	mvpp2_prs_dsa_tag_ethertype_set(priv, 0, true,
> -					MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> -
> -	/* Set default entry, in case DSA or EDSA tag not found */
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_DSA);
> -	pe.index = MVPP2_PE_DSA_DEFAULT;
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> -
> -	/* Shift 0 bytes */
> -	mvpp2_prs_sram_shift_set(&pe, 0, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> -
> -	/* Clear all sram ai bits for next iteration */
> -	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> -
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	mvpp2_prs_hw_write(priv, &pe);
> -}
> -
> -/* Initialize parser entries for VID filtering */
> -static void mvpp2_prs_vid_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -
> -	memset(&pe, 0, sizeof(pe));
> -
> -	/* Set default vid entry */
> -	pe.index = MVPP2_PE_VID_FLTR_DEFAULT;
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_EDSA_VID_AI_BIT);
> -
> -	/* Skip VLAN header - Set offset to 4 bytes */
> -	mvpp2_prs_sram_shift_set(&pe, MVPP2_VLAN_TAG_LEN,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -	/* Clear all ai bits for next iteration */
> -	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> -
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> -
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Set default vid entry for extended DSA*/
> -	memset(&pe, 0, sizeof(pe));
> -
> -	/* Set default vid entry */
> -	pe.index = MVPP2_PE_VID_EDSA_FLTR_DEFAULT;
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_EDSA_VID_AI_BIT,
> -				 MVPP2_PRS_EDSA_VID_AI_BIT);
> -
> -	/* Skip VLAN header - Set offset to 8 bytes */
> -	mvpp2_prs_sram_shift_set(&pe, MVPP2_VLAN_TAG_EDSA_LEN,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -	/* Clear all ai bits for next iteration */
> -	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> -
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> -
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
> -	mvpp2_prs_hw_write(priv, &pe);
> -}
> -
> -/* Match basic ethertypes */
> -static int mvpp2_prs_etype_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	/* Ethertype: PPPoE */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> -	pe.index = tid;
> -
> -	mvpp2_prs_match_etype(&pe, 0, ETH_P_PPP_SES);
> -
> -	mvpp2_prs_sram_shift_set(&pe, MVPP2_PPPOE_HDR_SIZE,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_PPPOE);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_PPPOE_MASK,
> -				 MVPP2_PRS_RI_PPPOE_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> -	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> -	priv->prs_shadow[pe.index].finish = false;
> -	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_PPPOE_MASK,
> -				MVPP2_PRS_RI_PPPOE_MASK);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Ethertype: ARP */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> -	pe.index = tid;
> -
> -	mvpp2_prs_match_etype(&pe, 0, ETH_P_ARP);
> -
> -	/* Generate flow in the next iteration*/
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_ARP,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -	/* Set L3 offset */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> -				  MVPP2_ETH_TYPE_LEN,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> -	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> -	priv->prs_shadow[pe.index].finish = true;
> -	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_ARP,
> -				MVPP2_PRS_RI_L3_PROTO_MASK);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Ethertype: LBTD */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> -	pe.index = tid;
> -
> -	mvpp2_prs_match_etype(&pe, 0, MVPP2_IP_LBDT_TYPE);
> -
> -	/* Generate flow in the next iteration*/
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_CPU_CODE_RX_SPEC |
> -				 MVPP2_PRS_RI_UDF3_RX_SPECIAL,
> -				 MVPP2_PRS_RI_CPU_CODE_MASK |
> -				 MVPP2_PRS_RI_UDF3_MASK);
> -	/* Set L3 offset */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> -				  MVPP2_ETH_TYPE_LEN,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> -	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> -	priv->prs_shadow[pe.index].finish = true;
> -	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_CPU_CODE_RX_SPEC |
> -				MVPP2_PRS_RI_UDF3_RX_SPECIAL,
> -				MVPP2_PRS_RI_CPU_CODE_MASK |
> -				MVPP2_PRS_RI_UDF3_MASK);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Ethertype: IPv4 without options */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> -	pe.index = tid;
> -
> -	mvpp2_prs_match_etype(&pe, 0, ETH_P_IP);
> -	mvpp2_prs_tcam_data_byte_set(&pe, MVPP2_ETH_TYPE_LEN,
> -				     MVPP2_PRS_IPV4_HEAD | MVPP2_PRS_IPV4_IHL,
> -				     MVPP2_PRS_IPV4_HEAD_MASK |
> -				     MVPP2_PRS_IPV4_IHL_MASK);
> -
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP4,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -	/* Skip eth_type + 4 bytes of IP header */
> -	mvpp2_prs_sram_shift_set(&pe, MVPP2_ETH_TYPE_LEN + 4,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	/* Set L3 offset */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> -				  MVPP2_ETH_TYPE_LEN,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> -	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> -	priv->prs_shadow[pe.index].finish = false;
> -	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_IP4,
> -				MVPP2_PRS_RI_L3_PROTO_MASK);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Ethertype: IPv4 with options */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	pe.index = tid;
> -
> -	/* Clear tcam data before updating */
> -	pe.tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE(MVPP2_ETH_TYPE_LEN)] = 0x0;
> -	pe.tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE_EN(MVPP2_ETH_TYPE_LEN)] = 0x0;
> -
> -	mvpp2_prs_tcam_data_byte_set(&pe, MVPP2_ETH_TYPE_LEN,
> -				     MVPP2_PRS_IPV4_HEAD,
> -				     MVPP2_PRS_IPV4_HEAD_MASK);
> -
> -	/* Clear ri before updating */
> -	pe.sram.word[MVPP2_PRS_SRAM_RI_WORD] = 0x0;
> -	pe.sram.word[MVPP2_PRS_SRAM_RI_CTRL_WORD] = 0x0;
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP4_OPT,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> -	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> -	priv->prs_shadow[pe.index].finish = false;
> -	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_IP4_OPT,
> -				MVPP2_PRS_RI_L3_PROTO_MASK);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Ethertype: IPv6 without options */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> -	pe.index = tid;
> -
> -	mvpp2_prs_match_etype(&pe, 0, ETH_P_IPV6);
> -
> -	/* Skip DIP of IPV6 header */
> -	mvpp2_prs_sram_shift_set(&pe, MVPP2_ETH_TYPE_LEN + 8 +
> -				 MVPP2_MAX_L3_ADDR_SIZE,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP6,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -	/* Set L3 offset */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> -				  MVPP2_ETH_TYPE_LEN,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> -	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> -	priv->prs_shadow[pe.index].finish = false;
> -	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_IP6,
> -				MVPP2_PRS_RI_L3_PROTO_MASK);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Default entry for MVPP2_PRS_LU_L2 - Unknown ethtype */
> -	memset(&pe, 0, sizeof(struct mvpp2_prs_entry));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> -	pe.index = MVPP2_PE_ETH_TYPE_UN;
> -
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Generate flow in the next iteration*/
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UN,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -	/* Set L3 offset even it's unknown L3 */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> -				  MVPP2_ETH_TYPE_LEN,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> -	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> -	priv->prs_shadow[pe.index].finish = true;
> -	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_UN,
> -				MVPP2_PRS_RI_L3_PROTO_MASK);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* Configure vlan entries and detect up to 2 successive VLAN tags.
> - * Possible options:
> - * 0x8100, 0x88A8
> - * 0x8100, 0x8100
> - * 0x8100
> - * 0x88A8
> - */
> -static int mvpp2_prs_vlan_init(struct platform_device *pdev, struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int err;
> -
> -	priv->prs_double_vlans = devm_kcalloc(&pdev->dev, sizeof(bool),
> -					      MVPP2_PRS_DBL_VLANS_MAX,
> -					      GFP_KERNEL);
> -	if (!priv->prs_double_vlans)
> -		return -ENOMEM;
> -
> -	/* Double VLAN: 0x8100, 0x88A8 */
> -	err = mvpp2_prs_double_vlan_add(priv, ETH_P_8021Q, ETH_P_8021AD,
> -					MVPP2_PRS_PORT_MASK);
> -	if (err)
> -		return err;
> -
> -	/* Double VLAN: 0x8100, 0x8100 */
> -	err = mvpp2_prs_double_vlan_add(priv, ETH_P_8021Q, ETH_P_8021Q,
> -					MVPP2_PRS_PORT_MASK);
> -	if (err)
> -		return err;
> -
> -	/* Single VLAN: 0x88a8 */
> -	err = mvpp2_prs_vlan_add(priv, ETH_P_8021AD, MVPP2_PRS_SINGLE_VLAN_AI,
> -				 MVPP2_PRS_PORT_MASK);
> -	if (err)
> -		return err;
> -
> -	/* Single VLAN: 0x8100 */
> -	err = mvpp2_prs_vlan_add(priv, ETH_P_8021Q, MVPP2_PRS_SINGLE_VLAN_AI,
> -				 MVPP2_PRS_PORT_MASK);
> -	if (err)
> -		return err;
> -
> -	/* Set default double vlan entry */
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> -	pe.index = MVPP2_PE_VLAN_DBL;
> -
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VID);
> -
> -	/* Clear ai for next iterations */
> -	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_DOUBLE,
> -				 MVPP2_PRS_RI_VLAN_MASK);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_DBL_VLAN_AI_BIT,
> -				 MVPP2_PRS_DBL_VLAN_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Set default vlan none entry */
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> -	pe.index = MVPP2_PE_VLAN_NONE;
> -
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_NONE,
> -				 MVPP2_PRS_RI_VLAN_MASK);
> -
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* Set entries for PPPoE ethertype */
> -static int mvpp2_prs_pppoe_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	/* IPv4 over PPPoE with options */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_PPPOE);
> -	pe.index = tid;
> -
> -	mvpp2_prs_match_etype(&pe, 0, PPP_IP);
> -
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP4_OPT,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -	/* Skip eth_type + 4 bytes of IP header */
> -	mvpp2_prs_sram_shift_set(&pe, MVPP2_ETH_TYPE_LEN + 4,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	/* Set L3 offset */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> -				  MVPP2_ETH_TYPE_LEN,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_PPPOE);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* IPv4 over PPPoE without options */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	pe.index = tid;
> -
> -	mvpp2_prs_tcam_data_byte_set(&pe, MVPP2_ETH_TYPE_LEN,
> -				     MVPP2_PRS_IPV4_HEAD | MVPP2_PRS_IPV4_IHL,
> -				     MVPP2_PRS_IPV4_HEAD_MASK |
> -				     MVPP2_PRS_IPV4_IHL_MASK);
> -
> -	/* Clear ri before updating */
> -	pe.sram.word[MVPP2_PRS_SRAM_RI_WORD] = 0x0;
> -	pe.sram.word[MVPP2_PRS_SRAM_RI_CTRL_WORD] = 0x0;
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP4,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_PPPOE);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* IPv6 over PPPoE */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_PPPOE);
> -	pe.index = tid;
> -
> -	mvpp2_prs_match_etype(&pe, 0, PPP_IPV6);
> -
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP6,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -	/* Skip eth_type + 4 bytes of IPv6 header */
> -	mvpp2_prs_sram_shift_set(&pe, MVPP2_ETH_TYPE_LEN + 4,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	/* Set L3 offset */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> -				  MVPP2_ETH_TYPE_LEN,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_PPPOE);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Non-IP over PPPoE */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_PPPOE);
> -	pe.index = tid;
> -
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UN,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK);
> -
> -	/* Finished: go to flowid generation */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	/* Set L3 offset even if it's unknown L3 */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> -				  MVPP2_ETH_TYPE_LEN,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_PPPOE);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* Initialize entries for IPv4 */
> -static int mvpp2_prs_ip4_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int err;
> -
> -	/* Set entries for TCP, UDP and IGMP over IPv4 */
> -	err = mvpp2_prs_ip4_proto(priv, IPPROTO_TCP, MVPP2_PRS_RI_L4_TCP,
> -				  MVPP2_PRS_RI_L4_PROTO_MASK);
> -	if (err)
> -		return err;
> -
> -	err = mvpp2_prs_ip4_proto(priv, IPPROTO_UDP, MVPP2_PRS_RI_L4_UDP,
> -				  MVPP2_PRS_RI_L4_PROTO_MASK);
> -	if (err)
> -		return err;
> -
> -	err = mvpp2_prs_ip4_proto(priv, IPPROTO_IGMP,
> -				  MVPP2_PRS_RI_CPU_CODE_RX_SPEC |
> -				  MVPP2_PRS_RI_UDF3_RX_SPECIAL,
> -				  MVPP2_PRS_RI_CPU_CODE_MASK |
> -				  MVPP2_PRS_RI_UDF3_MASK);
> -	if (err)
> -		return err;
> -
> -	/* IPv4 Broadcast */
> -	err = mvpp2_prs_ip4_cast(priv, MVPP2_PRS_L3_BROAD_CAST);
> -	if (err)
> -		return err;
> -
> -	/* IPv4 Multicast */
> -	err = mvpp2_prs_ip4_cast(priv, MVPP2_PRS_L3_MULTI_CAST);
> -	if (err)
> -		return err;
> -
> -	/* Default IPv4 entry for unknown protocols */
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP4);
> -	pe.index = MVPP2_PE_IP4_PROTO_UN;
> -
> -	/* Set next lu to IPv4 */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_sram_shift_set(&pe, 12, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -	/* Set L4 offset */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L4,
> -				  sizeof(struct iphdr) - 4,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -	mvpp2_prs_sram_ai_update(&pe, MVPP2_PRS_IPV4_DIP_AI_BIT,
> -				 MVPP2_PRS_IPV4_DIP_AI_BIT);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L4_OTHER,
> -				 MVPP2_PRS_RI_L4_PROTO_MASK);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_IPV4_DIP_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Default IPv4 entry for unicast address */
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP4);
> -	pe.index = MVPP2_PE_IP4_ADDR_UN;
> -
> -	/* Finished: go to flowid generation */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UCAST,
> -				 MVPP2_PRS_RI_L3_ADDR_MASK);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV4_DIP_AI_BIT,
> -				 MVPP2_PRS_IPV4_DIP_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* Initialize entries for IPv6 */
> -static int mvpp2_prs_ip6_init(struct mvpp2 *priv)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid, err;
> -
> -	/* Set entries for TCP, UDP and ICMP over IPv6 */
> -	err = mvpp2_prs_ip6_proto(priv, IPPROTO_TCP,
> -				  MVPP2_PRS_RI_L4_TCP,
> -				  MVPP2_PRS_RI_L4_PROTO_MASK);
> -	if (err)
> -		return err;
> -
> -	err = mvpp2_prs_ip6_proto(priv, IPPROTO_UDP,
> -				  MVPP2_PRS_RI_L4_UDP,
> -				  MVPP2_PRS_RI_L4_PROTO_MASK);
> -	if (err)
> -		return err;
> -
> -	err = mvpp2_prs_ip6_proto(priv, IPPROTO_ICMPV6,
> -				  MVPP2_PRS_RI_CPU_CODE_RX_SPEC |
> -				  MVPP2_PRS_RI_UDF3_RX_SPECIAL,
> -				  MVPP2_PRS_RI_CPU_CODE_MASK |
> -				  MVPP2_PRS_RI_UDF3_MASK);
> -	if (err)
> -		return err;
> -
> -	/* IPv4 is the last header. This is similar case as 6-TCP or 17-UDP */
> -	/* Result Info: UDF7=1, DS lite */
> -	err = mvpp2_prs_ip6_proto(priv, IPPROTO_IPIP,
> -				  MVPP2_PRS_RI_UDF7_IP6_LITE,
> -				  MVPP2_PRS_RI_UDF7_MASK);
> -	if (err)
> -		return err;
> -
> -	/* IPv6 multicast */
> -	err = mvpp2_prs_ip6_cast(priv, MVPP2_PRS_L3_MULTI_CAST);
> -	if (err)
> -		return err;
> -
> -	/* Entry for checking hop limit */
> -	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> -					MVPP2_PE_LAST_FREE_TID);
> -	if (tid < 0)
> -		return tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	pe.index = tid;
> -
> -	/* Finished: go to flowid generation */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UN |
> -				 MVPP2_PRS_RI_DROP_MASK,
> -				 MVPP2_PRS_RI_L3_PROTO_MASK |
> -				 MVPP2_PRS_RI_DROP_MASK);
> -
> -	mvpp2_prs_tcam_data_byte_set(&pe, 1, 0x00, MVPP2_PRS_IPV6_HOP_MASK);
> -	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> -				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Default IPv6 entry for unknown protocols */
> -	memset(&pe, 0, sizeof(pe));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	pe.index = MVPP2_PE_IP6_PROTO_UN;
> -
> -	/* Finished: go to flowid generation */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L4_OTHER,
> -				 MVPP2_PRS_RI_L4_PROTO_MASK);
> -	/* Set L4 offset relatively to our current place */
> -	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L4,
> -				  sizeof(struct ipv6hdr) - 4,
> -				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> -				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Default IPv6 entry for unknown ext protocols */
> -	memset(&pe, 0, sizeof(struct mvpp2_prs_entry));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	pe.index = MVPP2_PE_IP6_EXT_PROTO_UN;
> -
> -	/* Finished: go to flowid generation */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L4_OTHER,
> -				 MVPP2_PRS_RI_L4_PROTO_MASK);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV6_EXT_AI_BIT,
> -				 MVPP2_PRS_IPV6_EXT_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	/* Default IPv6 entry for unicast address */
> -	memset(&pe, 0, sizeof(struct mvpp2_prs_entry));
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	pe.index = MVPP2_PE_IP6_ADDR_UN;
> -
> -	/* Finished: go to IPv6 again */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP6);
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UCAST,
> -				 MVPP2_PRS_RI_L3_ADDR_MASK);
> -	mvpp2_prs_sram_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> -				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> -	/* Shift back to IPV6 NH */
> -	mvpp2_prs_sram_shift_set(&pe, -18, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> -	/* Unmask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> -
> -	/* Update shadow table and hw entry */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP6);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* Find tcam entry with matched pair <vid,port> */
> -static int mvpp2_prs_vid_range_find(struct mvpp2 *priv, int pmap, u16 vid,
> -				    u16 mask)
> -{
> -	unsigned char byte[2], enable[2];
> -	struct mvpp2_prs_entry pe;
> -	u16 rvid, rmask;
> -	int tid;
> -
> -	/* Go through the all entries with MVPP2_PRS_LU_VID */
> -	for (tid = MVPP2_PE_VID_FILT_RANGE_START;
> -	     tid <= MVPP2_PE_VID_FILT_RANGE_END; tid++) {
> -		if (!priv->prs_shadow[tid].valid ||
> -		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VID)
> -			continue;
> -
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -
> -		mvpp2_prs_tcam_data_byte_get(&pe, 2, &byte[0], &enable[0]);
> -		mvpp2_prs_tcam_data_byte_get(&pe, 3, &byte[1], &enable[1]);
> -
> -		rvid = ((byte[0] & 0xf) << 8) + byte[1];
> -		rmask = ((enable[0] & 0xf) << 8) + enable[1];
> -
> -		if (rvid != vid || rmask != mask)
> -			continue;
> -
> -		return tid;
> -	}
> -
> -	return -ENOENT;
> -}
> -
> -/* Write parser entry for VID filtering */
> -static int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
> -{
> -	unsigned int vid_start = MVPP2_PE_VID_FILT_RANGE_START +
> -				 port->id * MVPP2_PRS_VLAN_FILT_MAX;
> -	unsigned int mask = 0xfff, reg_val, shift;
> -	struct mvpp2 *priv = port->priv;
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -
> -	/* Scan TCAM and see if entry with this <vid,port> already exist */
> -	tid = mvpp2_prs_vid_range_find(priv, (1 << port->id), vid, mask);
> -
> -	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
> -	if (reg_val & MVPP2_DSA_EXTENDED)
> -		shift = MVPP2_VLAN_TAG_EDSA_LEN;
> -	else
> -		shift = MVPP2_VLAN_TAG_LEN;
> -
> -	/* No such entry */
> -	if (tid < 0) {
> -
> -		/* Go through all entries from first to last in vlan range */
> -		tid = mvpp2_prs_tcam_first_free(priv, vid_start,
> -						vid_start +
> -						MVPP2_PRS_VLAN_FILT_MAX_ENTRY);
> -
> -		/* There isn't room for a new VID filter */
> -		if (tid < 0)
> -			return tid;
> -
> -		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
> -		pe.index = tid;
> -
> -		/* Mask all ports */
> -		mvpp2_prs_tcam_port_map_set(&pe, 0);
> -	} else {
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -	}
> -
> -	/* Enable the current port */
> -	mvpp2_prs_tcam_port_set(&pe, port->id, true);
> -
> -	/* Continue - set next lookup */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> -
> -	/* Skip VLAN header - Set offset to 4 or 8 bytes */
> -	mvpp2_prs_sram_shift_set(&pe, shift, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -	/* Set match on VID */
> -	mvpp2_prs_match_vid(&pe, MVPP2_PRS_VID_TCAM_BYTE, vid);
> -
> -	/* Clear all ai bits for next iteration */
> -	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> -
> -	/* Update shadow table */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
> -	mvpp2_prs_hw_write(priv, &pe);
> -
> -	return 0;
> -}
> -
> -/* Write parser entry for VID filtering */
> -static void mvpp2_prs_vid_entry_remove(struct mvpp2_port *port, u16 vid)
> -{
> -	struct mvpp2 *priv = port->priv;
> -	int tid;
> -
> -	/* Scan TCAM and see if entry with this <vid,port> already exist */
> -	tid = mvpp2_prs_vid_range_find(priv, (1 << port->id), vid, 0xfff);
> -
> -	/* No such entry */
> -	if (tid < 0)
> -		return;
> -
> -	mvpp2_prs_hw_inv(priv, tid);
> -	priv->prs_shadow[tid].valid = false;
> -}
> -
> -/* Remove all existing VID filters on this port */
> -static void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
> -{
> -	struct mvpp2 *priv = port->priv;
> -	int tid;
> -
> -	for (tid = MVPP2_PRS_VID_PORT_FIRST(port->id);
> -	     tid <= MVPP2_PRS_VID_PORT_LAST(port->id); tid++) {
> -		if (priv->prs_shadow[tid].valid)
> -			mvpp2_prs_vid_entry_remove(port, tid);
> -	}
> -}
> -
> -/* Remove VID filering entry for this port */
> -static void mvpp2_prs_vid_disable_filtering(struct mvpp2_port *port)
> -{
> -	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
> -	struct mvpp2 *priv = port->priv;
> -
> -	/* Invalidate the guard entry */
> -	mvpp2_prs_hw_inv(priv, tid);
> -
> -	priv->prs_shadow[tid].valid = false;
> -}
> -
> -/* Add guard entry that drops packets when no VID is matched on this port */
> -static void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
> -{
> -	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
> -	struct mvpp2 *priv = port->priv;
> -	unsigned int reg_val, shift;
> -	struct mvpp2_prs_entry pe;
> -
> -	if (priv->prs_shadow[tid].valid)
> -		return;
> -
> -	memset(&pe, 0, sizeof(pe));
> -
> -	pe.index = tid;
> -
> -	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
> -	if (reg_val & MVPP2_DSA_EXTENDED)
> -		shift = MVPP2_VLAN_TAG_EDSA_LEN;
> -	else
> -		shift = MVPP2_VLAN_TAG_LEN;
> -
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
> -
> -	/* Mask all ports */
> -	mvpp2_prs_tcam_port_map_set(&pe, 0);
> -
> -	/* Update port mask */
> -	mvpp2_prs_tcam_port_set(&pe, port->id, true);
> -
> -	/* Continue - set next lookup */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> -
> -	/* Skip VLAN header - Set offset to 4 or 8 bytes */
> -	mvpp2_prs_sram_shift_set(&pe, shift, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> -
> -	/* Drop VLAN packets that don't belong to any VIDs on this port */
> -	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_DROP_MASK,
> -				 MVPP2_PRS_RI_DROP_MASK);
> -
> -	/* Clear all ai bits for next iteration */
> -	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> -
> -	/* Update shadow table */
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
> -	mvpp2_prs_hw_write(priv, &pe);
> -}
> -
> -/* Parser default initialization */
> -static int mvpp2_prs_default_init(struct platform_device *pdev,
> -				  struct mvpp2 *priv)
> -{
> -	int err, index, i;
> -
> -	/* Enable tcam table */
> -	mvpp2_write(priv, MVPP2_PRS_TCAM_CTRL_REG, MVPP2_PRS_TCAM_EN_MASK);
> -
> -	/* Clear all tcam and sram entries */
> -	for (index = 0; index < MVPP2_PRS_TCAM_SRAM_SIZE; index++) {
> -		mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, index);
> -		for (i = 0; i < MVPP2_PRS_TCAM_WORDS; i++)
> -			mvpp2_write(priv, MVPP2_PRS_TCAM_DATA_REG(i), 0);
> -
> -		mvpp2_write(priv, MVPP2_PRS_SRAM_IDX_REG, index);
> -		for (i = 0; i < MVPP2_PRS_SRAM_WORDS; i++)
> -			mvpp2_write(priv, MVPP2_PRS_SRAM_DATA_REG(i), 0);
> -	}
> -
> -	/* Invalidate all tcam entries */
> -	for (index = 0; index < MVPP2_PRS_TCAM_SRAM_SIZE; index++)
> -		mvpp2_prs_hw_inv(priv, index);
> -
> -	priv->prs_shadow = devm_kcalloc(&pdev->dev, MVPP2_PRS_TCAM_SRAM_SIZE,
> -					sizeof(*priv->prs_shadow),
> -					GFP_KERNEL);
> -	if (!priv->prs_shadow)
> -		return -ENOMEM;
> -
> -	/* Always start from lookup = 0 */
> -	for (index = 0; index < MVPP2_MAX_PORTS; index++)
> -		mvpp2_prs_hw_port_init(priv, index, MVPP2_PRS_LU_MH,
> -				       MVPP2_PRS_PORT_LU_MAX, 0);
> -
> -	mvpp2_prs_def_flow_init(priv);
> -
> -	mvpp2_prs_mh_init(priv);
> -
> -	mvpp2_prs_mac_init(priv);
> -
> -	mvpp2_prs_dsa_init(priv);
> -
> -	mvpp2_prs_vid_init(priv);
> -
> -	err = mvpp2_prs_etype_init(priv);
> -	if (err)
> -		return err;
> -
> -	err = mvpp2_prs_vlan_init(pdev, priv);
> -	if (err)
> -		return err;
> -
> -	err = mvpp2_prs_pppoe_init(priv);
> -	if (err)
> -		return err;
> -
> -	err = mvpp2_prs_ip6_init(priv);
> -	if (err)
> -		return err;
> -
> -	err = mvpp2_prs_ip4_init(priv);
> -	if (err)
> -		return err;
> -
> -	return 0;
> -}
> -
> -/* Compare MAC DA with tcam entry data */
> -static bool mvpp2_prs_mac_range_equals(struct mvpp2_prs_entry *pe,
> -				       const u8 *da, unsigned char *mask)
> -{
> -	unsigned char tcam_byte, tcam_mask;
> -	int index;
> -
> -	for (index = 0; index < ETH_ALEN; index++) {
> -		mvpp2_prs_tcam_data_byte_get(pe, index, &tcam_byte, &tcam_mask);
> -		if (tcam_mask != mask[index])
> -			return false;
> -
> -		if ((tcam_mask & tcam_byte) != (da[index] & mask[index]))
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
> -/* Find tcam entry with matched pair <MAC DA, port> */
> -static int
> -mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
> -			    unsigned char *mask, int udf_type)
> -{
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	/* Go through the all entires with MVPP2_PRS_LU_MAC */
> -	for (tid = MVPP2_PE_MAC_RANGE_START;
> -	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
> -		unsigned int entry_pmap;
> -
> -		if (!priv->prs_shadow[tid].valid ||
> -		    (priv->prs_shadow[tid].lu != MVPP2_PRS_LU_MAC) ||
> -		    (priv->prs_shadow[tid].udf != udf_type))
> -			continue;
> -
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -		entry_pmap = mvpp2_prs_tcam_port_map_get(&pe);
> -
> -		if (mvpp2_prs_mac_range_equals(&pe, da, mask) &&
> -		    entry_pmap == pmap)
> -			return tid;
> -	}
> -
> -	return -ENOENT;
> -}
> -
> -/* Update parser's mac da entry */
> -static int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da,
> -				   bool add)
> -{
> -	unsigned char mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> -	struct mvpp2 *priv = port->priv;
> -	unsigned int pmap, len, ri;
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> -
> -	memset(&pe, 0, sizeof(pe));
> -
> -	/* Scan TCAM and see if entry with this <MAC DA, port> already exist */
> -	tid = mvpp2_prs_mac_da_range_find(priv, BIT(port->id), da, mask,
> -					  MVPP2_PRS_UDF_MAC_DEF);
> -
> -	/* No such entry */
> -	if (tid < 0) {
> -		if (!add)
> -			return 0;
> -
> -		/* Create new TCAM entry */
> -		/* Go through the all entries from first to last */
> -		tid = mvpp2_prs_tcam_first_free(priv,
> -						MVPP2_PE_MAC_RANGE_START,
> -						MVPP2_PE_MAC_RANGE_END);
> -		if (tid < 0)
> -			return tid;
> -
> -		pe.index = tid;
> -
> -		/* Mask all ports */
> -		mvpp2_prs_tcam_port_map_set(&pe, 0);
> -	} else {
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -	}
> -
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
> -
> -	/* Update port mask */
> -	mvpp2_prs_tcam_port_set(&pe, port->id, add);
> -
> -	/* Invalidate the entry if no ports are left enabled */
> -	pmap = mvpp2_prs_tcam_port_map_get(&pe);
> -	if (pmap == 0) {
> -		if (add)
> -			return -EINVAL;
> -
> -		mvpp2_prs_hw_inv(priv, pe.index);
> -		priv->prs_shadow[pe.index].valid = false;
> -		return 0;
> -	}
> -
> -	/* Continue - set next lookup */
> -	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_DSA);
> -
> -	/* Set match on DA */
> -	len = ETH_ALEN;
> -	while (len--)
> -		mvpp2_prs_tcam_data_byte_set(&pe, len, da[len], 0xff);
> +	int pkt_size;
> +	int buf_num;
> +} mvpp2_pools[MVPP2_BM_POOLS_NUM];
>  
> -	/* Set result info bits */
> -	if (is_broadcast_ether_addr(da)) {
> -		ri = MVPP2_PRS_RI_L2_BCAST;
> -	} else if (is_multicast_ether_addr(da)) {
> -		ri = MVPP2_PRS_RI_L2_MCAST;
> -	} else {
> -		ri = MVPP2_PRS_RI_L2_UCAST;
> +/* The prototype is added here to be used in start_dev when using ACPI. This
> + * will be removed once phylink is used for all modes (dt+ACPI).
> + */
> +static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
> +			     const struct phylink_link_state *state);
>  
> -		if (ether_addr_equal(da, port->dev->dev_addr))
> -			ri |= MVPP2_PRS_RI_MAC_ME_MASK;
> -	}
> +/* Queue modes */
> +#define MVPP2_QDIST_SINGLE_MODE	0
> +#define MVPP2_QDIST_MULTI_MODE	1
>  
> -	mvpp2_prs_sram_ri_update(&pe, ri, MVPP2_PRS_RI_L2_CAST_MASK |
> -				 MVPP2_PRS_RI_MAC_ME_MASK);
> -	mvpp2_prs_shadow_ri_set(priv, pe.index, ri, MVPP2_PRS_RI_L2_CAST_MASK |
> -				MVPP2_PRS_RI_MAC_ME_MASK);
> +static int queue_mode = MVPP2_QDIST_SINGLE_MODE;
>  
> -	/* Shift to ethertype */
> -	mvpp2_prs_sram_shift_set(&pe, 2 * ETH_ALEN,
> -				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +module_param(queue_mode, int, 0444);
> +MODULE_PARM_DESC(queue_mode, "Set queue_mode (single=0, multi=1)");
>  
> -	/* Update shadow table and hw entry */
> -	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_MAC_DEF;
> -	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> -	mvpp2_prs_hw_write(priv, &pe);
> +/* Utility/helper methods */
>  
> -	return 0;
> +void mvpp2_write(struct mvpp2 *priv, u32 offset, u32 data)
> +{
> +	writel(data, priv->swth_base[0] + offset);
>  }
>  
> -static int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da)
> +u32 mvpp2_read(struct mvpp2 *priv, u32 offset)
>  {
> -	struct mvpp2_port *port = netdev_priv(dev);
> -	int err;
> -
> -	/* Remove old parser entry */
> -	err = mvpp2_prs_mac_da_accept(port, dev->dev_addr, false);
> -	if (err)
> -		return err;
> -
> -	/* Add new parser entry */
> -	err = mvpp2_prs_mac_da_accept(port, da, true);
> -	if (err)
> -		return err;
> -
> -	/* Set addr in the device */
> -	ether_addr_copy(dev->dev_addr, da);
> -
> -	return 0;
> +	return readl(priv->swth_base[0] + offset);
>  }
>  
> -static void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
> +u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
>  {
> -	struct mvpp2 *priv = port->priv;
> -	struct mvpp2_prs_entry pe;
> -	unsigned long pmap;
> -	int index, tid;
> -
> -	for (tid = MVPP2_PE_MAC_RANGE_START;
> -	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
> -		unsigned char da[ETH_ALEN], da_mask[ETH_ALEN];
> -
> -		if (!priv->prs_shadow[tid].valid ||
> -		    (priv->prs_shadow[tid].lu != MVPP2_PRS_LU_MAC) ||
> -		    (priv->prs_shadow[tid].udf != MVPP2_PRS_UDF_MAC_DEF))
> -			continue;
> -
> -		mvpp2_prs_init_from_hw(priv, &pe, tid);
> -
> -		pmap = mvpp2_prs_tcam_port_map_get(&pe);
> -
> -		/* We only want entries active on this port */
> -		if (!test_bit(port->id, &pmap))
> -			continue;
> -
> -		/* Read mac addr from entry */
> -		for (index = 0; index < ETH_ALEN; index++)
> -			mvpp2_prs_tcam_data_byte_get(&pe, index, &da[index],
> -						     &da_mask[index]);
> -
> -		/* Special cases : Don't remove broadcast and port's own
> -		 * address
> -		 */
> -		if (is_broadcast_ether_addr(da) ||
> -		    ether_addr_equal(da, port->dev->dev_addr))
> -			continue;
> -
> -		/* Remove entry from TCAM */
> -		mvpp2_prs_mac_da_accept(port, da, false);
> -	}
> +	return readl_relaxed(priv->swth_base[0] + offset);
>  }
> -
> -static int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
> +/* These accessors should be used to access:
> + *
> + * - per-CPU registers, where each CPU has its own copy of the
> + *   register.
> + *
> + *   MVPP2_BM_VIRT_ALLOC_REG
> + *   MVPP2_BM_ADDR_HIGH_ALLOC
> + *   MVPP22_BM_ADDR_HIGH_RLS_REG
> + *   MVPP2_BM_VIRT_RLS_REG
> + *   MVPP2_ISR_RX_TX_CAUSE_REG
> + *   MVPP2_ISR_RX_TX_MASK_REG
> + *   MVPP2_TXQ_NUM_REG
> + *   MVPP2_AGGR_TXQ_UPDATE_REG
> + *   MVPP2_TXQ_RSVD_REQ_REG
> + *   MVPP2_TXQ_RSVD_RSLT_REG
> + *   MVPP2_TXQ_SENT_REG
> + *   MVPP2_RXQ_NUM_REG
> + *
> + * - global registers that must be accessed through a specific CPU
> + *   window, because they are related to an access to a per-CPU
> + *   register
> + *
> + *   MVPP2_BM_PHY_ALLOC_REG    (related to MVPP2_BM_VIRT_ALLOC_REG)
> + *   MVPP2_BM_PHY_RLS_REG      (related to MVPP2_BM_VIRT_RLS_REG)
> + *   MVPP2_RXQ_THRESH_REG      (related to MVPP2_RXQ_NUM_REG)
> + *   MVPP2_RXQ_DESC_ADDR_REG   (related to MVPP2_RXQ_NUM_REG)
> + *   MVPP2_RXQ_DESC_SIZE_REG   (related to MVPP2_RXQ_NUM_REG)
> + *   MVPP2_RXQ_INDEX_REG       (related to MVPP2_RXQ_NUM_REG)
> + *   MVPP2_TXQ_PENDING_REG     (related to MVPP2_TXQ_NUM_REG)
> + *   MVPP2_TXQ_DESC_ADDR_REG   (related to MVPP2_TXQ_NUM_REG)
> + *   MVPP2_TXQ_DESC_SIZE_REG   (related to MVPP2_TXQ_NUM_REG)
> + *   MVPP2_TXQ_INDEX_REG       (related to MVPP2_TXQ_NUM_REG)
> + *   MVPP2_TXQ_PENDING_REG     (related to MVPP2_TXQ_NUM_REG)
> + *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
> + *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
> + */
> +void mvpp2_percpu_write(struct mvpp2 *priv, int cpu,
> +			       u32 offset, u32 data)
>  {
> -	switch (type) {
> -	case MVPP2_TAG_TYPE_EDSA:
> -		/* Add port to EDSA entries */
> -		mvpp2_prs_dsa_tag_set(priv, port, true,
> -				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> -		mvpp2_prs_dsa_tag_set(priv, port, true,
> -				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> -		/* Remove port from DSA entries */
> -		mvpp2_prs_dsa_tag_set(priv, port, false,
> -				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> -		mvpp2_prs_dsa_tag_set(priv, port, false,
> -				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> -		break;
> -
> -	case MVPP2_TAG_TYPE_DSA:
> -		/* Add port to DSA entries */
> -		mvpp2_prs_dsa_tag_set(priv, port, true,
> -				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> -		mvpp2_prs_dsa_tag_set(priv, port, true,
> -				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> -		/* Remove port from EDSA entries */
> -		mvpp2_prs_dsa_tag_set(priv, port, false,
> -				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> -		mvpp2_prs_dsa_tag_set(priv, port, false,
> -				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> -		break;
> -
> -	case MVPP2_TAG_TYPE_MH:
> -	case MVPP2_TAG_TYPE_NONE:
> -		/* Remove port form EDSA and DSA entries */
> -		mvpp2_prs_dsa_tag_set(priv, port, false,
> -				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> -		mvpp2_prs_dsa_tag_set(priv, port, false,
> -				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> -		mvpp2_prs_dsa_tag_set(priv, port, false,
> -				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> -		mvpp2_prs_dsa_tag_set(priv, port, false,
> -				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> -		break;
> -
> -	default:
> -		if ((type < 0) || (type > MVPP2_TAG_TYPE_EDSA))
> -			return -EINVAL;
> -	}
> -
> -	return 0;
> +	writel(data, priv->swth_base[cpu] + offset);
>  }
>  
> -/* Set prs flow for the port */
> -static int mvpp2_prs_def_flow(struct mvpp2_port *port)
> +u32 mvpp2_percpu_read(struct mvpp2 *priv, int cpu,
> +			     u32 offset)
>  {
> -	struct mvpp2_prs_entry pe;
> -	int tid;
> +	return readl(priv->swth_base[cpu] + offset);
> +}
>  
> -	memset(&pe, 0, sizeof(pe));
> +void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, int cpu,
> +				       u32 offset, u32 data)
> +{
> +	writel_relaxed(data, priv->swth_base[cpu] + offset);
> +}
>  
> -	tid = mvpp2_prs_flow_find(port->priv, port->id);
> +u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, int cpu,
> +				     u32 offset)
> +{
> +	return readl_relaxed(priv->swth_base[cpu] + offset);
> +}
>  
> -	/* Such entry not exist */
> -	if (tid < 0) {
> -		/* Go through the all entires from last to first */
> -		tid = mvpp2_prs_tcam_first_free(port->priv,
> -						MVPP2_PE_LAST_FREE_TID,
> -					       MVPP2_PE_FIRST_FREE_TID);
> -		if (tid < 0)
> -			return tid;
> +static dma_addr_t mvpp2_txdesc_dma_addr_get(struct mvpp2_port *port,
> +					    struct mvpp2_tx_desc *tx_desc)
> +{
> +	if (port->priv->hw_version == MVPP21)
> +		return tx_desc->pp21.buf_dma_addr;
> +	else
> +		return tx_desc->pp22.buf_dma_addr_ptp & MVPP2_DESC_DMA_MASK;
> +}
>  
> -		pe.index = tid;
> +static void mvpp2_txdesc_dma_addr_set(struct mvpp2_port *port,
> +				      struct mvpp2_tx_desc *tx_desc,
> +				      dma_addr_t dma_addr)
> +{
> +	dma_addr_t addr, offset;
>  
> -		/* Set flow ID*/
> -		mvpp2_prs_sram_ai_update(&pe, port->id, MVPP2_PRS_FLOW_ID_MASK);
> -		mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_DONE_BIT, 1);
> +	addr = dma_addr & ~MVPP2_TX_DESC_ALIGN;
> +	offset = dma_addr & MVPP2_TX_DESC_ALIGN;
>  
> -		/* Update shadow table */
> -		mvpp2_prs_shadow_set(port->priv, pe.index, MVPP2_PRS_LU_FLOWS);
> +	if (port->priv->hw_version == MVPP21) {
> +		tx_desc->pp21.buf_dma_addr = addr;
> +		tx_desc->pp21.packet_offset = offset;
>  	} else {
> -		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
> -	}
> -
> -	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> -	mvpp2_prs_tcam_port_map_set(&pe, (1 << port->id));
> -	mvpp2_prs_hw_write(port->priv, &pe);
> +		u64 val = (u64)addr;
>  
> -	return 0;
> +		tx_desc->pp22.buf_dma_addr_ptp &= ~MVPP2_DESC_DMA_MASK;
> +		tx_desc->pp22.buf_dma_addr_ptp |= val;
> +		tx_desc->pp22.packet_offset = offset;
> +	}
>  }
>  
> -/* Classifier configuration routines */
> -
> -/* Update classification flow table registers */
> -static void mvpp2_cls_flow_write(struct mvpp2 *priv,
> -				 struct mvpp2_cls_flow_entry *fe)
> +static size_t mvpp2_txdesc_size_get(struct mvpp2_port *port,
> +				    struct mvpp2_tx_desc *tx_desc)
>  {
> -	mvpp2_write(priv, MVPP2_CLS_FLOW_INDEX_REG, fe->index);
> -	mvpp2_write(priv, MVPP2_CLS_FLOW_TBL0_REG,  fe->data[0]);
> -	mvpp2_write(priv, MVPP2_CLS_FLOW_TBL1_REG,  fe->data[1]);
> -	mvpp2_write(priv, MVPP2_CLS_FLOW_TBL2_REG,  fe->data[2]);
> +	if (port->priv->hw_version == MVPP21)
> +		return tx_desc->pp21.data_size;
> +	else
> +		return tx_desc->pp22.data_size;
>  }
>  
> -/* Update classification lookup table register */
> -static void mvpp2_cls_lookup_write(struct mvpp2 *priv,
> -				   struct mvpp2_cls_lookup_entry *le)
> +static void mvpp2_txdesc_size_set(struct mvpp2_port *port,
> +				  struct mvpp2_tx_desc *tx_desc,
> +				  size_t size)
>  {
> -	u32 val;
> -
> -	val = (le->way << MVPP2_CLS_LKP_INDEX_WAY_OFFS) | le->lkpid;
> -	mvpp2_write(priv, MVPP2_CLS_LKP_INDEX_REG, val);
> -	mvpp2_write(priv, MVPP2_CLS_LKP_TBL_REG, le->data);
> +	if (port->priv->hw_version == MVPP21)
> +		tx_desc->pp21.data_size = size;
> +	else
> +		tx_desc->pp22.data_size = size;
>  }
>  
> -/* Classifier default initialization */
> -static void mvpp2_cls_init(struct mvpp2 *priv)
> +static void mvpp2_txdesc_txq_set(struct mvpp2_port *port,
> +				 struct mvpp2_tx_desc *tx_desc,
> +				 unsigned int txq)
>  {
> -	struct mvpp2_cls_lookup_entry le;
> -	struct mvpp2_cls_flow_entry fe;
> -	int index;
> -
> -	/* Enable classifier */
> -	mvpp2_write(priv, MVPP2_CLS_MODE_REG, MVPP2_CLS_MODE_ACTIVE_MASK);
> -
> -	/* Clear classifier flow table */
> -	memset(&fe.data, 0, sizeof(fe.data));
> -	for (index = 0; index < MVPP2_CLS_FLOWS_TBL_SIZE; index++) {
> -		fe.index = index;
> -		mvpp2_cls_flow_write(priv, &fe);
> -	}
> -
> -	/* Clear classifier lookup table */
> -	le.data = 0;
> -	for (index = 0; index < MVPP2_CLS_LKP_TBL_SIZE; index++) {
> -		le.lkpid = index;
> -		le.way = 0;
> -		mvpp2_cls_lookup_write(priv, &le);
> -
> -		le.way = 1;
> -		mvpp2_cls_lookup_write(priv, &le);
> -	}
> +	if (port->priv->hw_version == MVPP21)
> +		tx_desc->pp21.phys_txq = txq;
> +	else
> +		tx_desc->pp22.phys_txq = txq;
>  }
>  
> -static void mvpp2_cls_port_config(struct mvpp2_port *port)
> +static void mvpp2_txdesc_cmd_set(struct mvpp2_port *port,
> +				 struct mvpp2_tx_desc *tx_desc,
> +				 unsigned int command)
>  {
> -	struct mvpp2_cls_lookup_entry le;
> -	u32 val;
> +	if (port->priv->hw_version == MVPP21)
> +		tx_desc->pp21.command = command;
> +	else
> +		tx_desc->pp22.command = command;
> +}
>  
> -	/* Set way for the port */
> -	val = mvpp2_read(port->priv, MVPP2_CLS_PORT_WAY_REG);
> -	val &= ~MVPP2_CLS_PORT_WAY_MASK(port->id);
> -	mvpp2_write(port->priv, MVPP2_CLS_PORT_WAY_REG, val);
> +static unsigned int mvpp2_txdesc_offset_get(struct mvpp2_port *port,
> +					    struct mvpp2_tx_desc *tx_desc)
> +{
> +	if (port->priv->hw_version == MVPP21)
> +		return tx_desc->pp21.packet_offset;
> +	else
> +		return tx_desc->pp22.packet_offset;
> +}
>  
> -	/* Pick the entry to be accessed in lookup ID decoding table
> -	 * according to the way and lkpid.
> -	 */
> -	le.lkpid = port->id;
> -	le.way = 0;
> -	le.data = 0;
> +static dma_addr_t mvpp2_rxdesc_dma_addr_get(struct mvpp2_port *port,
> +					    struct mvpp2_rx_desc *rx_desc)
> +{
> +	if (port->priv->hw_version == MVPP21)
> +		return rx_desc->pp21.buf_dma_addr;
> +	else
> +		return rx_desc->pp22.buf_dma_addr_key_hash & MVPP2_DESC_DMA_MASK;
> +}
>  
> -	/* Set initial CPU queue for receiving packets */
> -	le.data &= ~MVPP2_CLS_LKP_TBL_RXQ_MASK;
> -	le.data |= port->first_rxq;
> +static unsigned long mvpp2_rxdesc_cookie_get(struct mvpp2_port *port,
> +					     struct mvpp2_rx_desc *rx_desc)
> +{
> +	if (port->priv->hw_version == MVPP21)
> +		return rx_desc->pp21.buf_cookie;
> +	else
> +		return rx_desc->pp22.buf_cookie_misc & MVPP2_DESC_DMA_MASK;
> +}
>  
> -	/* Disable classification engines */
> -	le.data &= ~MVPP2_CLS_LKP_TBL_LOOKUP_EN_MASK;
> +static size_t mvpp2_rxdesc_size_get(struct mvpp2_port *port,
> +				    struct mvpp2_rx_desc *rx_desc)
> +{
> +	if (port->priv->hw_version == MVPP21)
> +		return rx_desc->pp21.data_size;
> +	else
> +		return rx_desc->pp22.data_size;
> +}
>  
> -	/* Update lookup ID table entry */
> -	mvpp2_cls_lookup_write(port->priv, &le);
> +static u32 mvpp2_rxdesc_status_get(struct mvpp2_port *port,
> +				   struct mvpp2_rx_desc *rx_desc)
> +{
> +	if (port->priv->hw_version == MVPP21)
> +		return rx_desc->pp21.status;
> +	else
> +		return rx_desc->pp22.status;
>  }
>  
> -/* Set CPU queue number for oversize packets */
> -static void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port)
> +static void mvpp2_txq_inc_get(struct mvpp2_txq_pcpu *txq_pcpu)
>  {
> -	u32 val;
> +	txq_pcpu->txq_get_index++;
> +	if (txq_pcpu->txq_get_index == txq_pcpu->size)
> +		txq_pcpu->txq_get_index = 0;
> +}
>  
> -	mvpp2_write(port->priv, MVPP2_CLS_OVERSIZE_RXQ_LOW_REG(port->id),
> -		    port->first_rxq & MVPP2_CLS_OVERSIZE_RXQ_LOW_MASK);
> +static void mvpp2_txq_inc_put(struct mvpp2_port *port,
> +			      struct mvpp2_txq_pcpu *txq_pcpu,
> +			      struct sk_buff *skb,
> +			      struct mvpp2_tx_desc *tx_desc)
> +{
> +	struct mvpp2_txq_pcpu_buf *tx_buf =
> +		txq_pcpu->buffs + txq_pcpu->txq_put_index;
> +	tx_buf->skb = skb;
> +	tx_buf->size = mvpp2_txdesc_size_get(port, tx_desc);
> +	tx_buf->dma = mvpp2_txdesc_dma_addr_get(port, tx_desc) +
> +		mvpp2_txdesc_offset_get(port, tx_desc);
> +	txq_pcpu->txq_put_index++;
> +	if (txq_pcpu->txq_put_index == txq_pcpu->size)
> +		txq_pcpu->txq_put_index = 0;
> +}
>  
> -	mvpp2_write(port->priv, MVPP2_CLS_SWFWD_P2HQ_REG(port->id),
> -		    (port->first_rxq >> MVPP2_CLS_OVERSIZE_RXQ_LOW_BITS));
> +/* Get number of physical egress port */
> +static inline int mvpp2_egress_port(struct mvpp2_port *port)
> +{
> +	return MVPP2_MAX_TCONT + port->id;
> +}
>  
> -	val = mvpp2_read(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG);
> -	val |= MVPP2_CLS_SWFWD_PCTRL_MASK(port->id);
> -	mvpp2_write(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG, val);
> +/* Get number of physical TXQ */
> +static inline int mvpp2_txq_phys(int port, int txq)
> +{
> +	return (MVPP2_MAX_TCONT + port) * MVPP2_MAX_TXQ + txq;
>  }
>  
>  static void *mvpp2_frag_alloc(const struct mvpp2_bm_pool *pool)
> @@ -7118,39 +3273,6 @@ static void mvpp2_irqs_deinit(struct mvpp2_port *port)
>  	}
>  }
>  
> -static void mvpp22_init_rss(struct mvpp2_port *port)
> -{
> -	struct mvpp2 *priv = port->priv;
> -	int i;
> -
> -	/* Set the table width: replace the whole classifier Rx queue number
> -	 * with the ones configured in RSS table entries.
> -	 */
> -	mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_TABLE(0));
> -	mvpp2_write(priv, MVPP22_RSS_WIDTH, 8);
> -
> -	/* Loop through the classifier Rx Queues and map them to a RSS table.
> -	 * Map them all to the first table (0) by default.
> -	 */
> -	for (i = 0; i < MVPP2_CLS_RX_QUEUES; i++) {
> -		mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_QUEUE(i));
> -		mvpp2_write(priv, MVPP22_RSS_TABLE,
> -			    MVPP22_RSS_TABLE_POINTER(0));
> -	}
> -
> -	/* Configure the first table to evenly distribute the packets across
> -	 * real Rx Queues. The table entries map a hash to an port Rx Queue.
> -	 */
> -	for (i = 0; i < MVPP22_RSS_TABLE_ENTRIES; i++) {
> -		u32 sel = MVPP22_RSS_INDEX_TABLE(0) |
> -			  MVPP22_RSS_INDEX_TABLE_ENTRY(i);
> -		mvpp2_write(priv, MVPP22_RSS_INDEX, sel);
> -
> -		mvpp2_write(priv, MVPP22_RSS_TABLE_ENTRY, i % port->nrxqs);
> -	}
> -
> -}
> -
>  static int mvpp2_open(struct net_device *dev)
>  {
>  	struct mvpp2_port *port = netdev_priv(dev);
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
> new file mode 100644
> index 000000000000..6bb69f086794
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
> @@ -0,0 +1,2467 @@
> +/*
> + * Header Parser helpers for Marvell PPv2 Network Controller
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Marcin Wojtas <mw@semihalf.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/platform_device.h>
> +#include <uapi/linux/ppp_defs.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
> +
> +#include "mvpp2.h"
> +#include "mvpp2_prs.h"
> +
> +/* Update parser tcam and sram hw entries */
> +static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
> +{
> +	int i;
> +
> +	if (pe->index > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
> +		return -EINVAL;
> +
> +	/* Clear entry invalidation bit */
> +	pe->tcam.word[MVPP2_PRS_TCAM_INV_WORD] &= ~MVPP2_PRS_TCAM_INV_MASK;
> +
> +	/* Write tcam index - indirect access */
> +	mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, pe->index);
> +	for (i = 0; i < MVPP2_PRS_TCAM_WORDS; i++)
> +		mvpp2_write(priv, MVPP2_PRS_TCAM_DATA_REG(i), pe->tcam.word[i]);
> +
> +	/* Write sram index - indirect access */
> +	mvpp2_write(priv, MVPP2_PRS_SRAM_IDX_REG, pe->index);
> +	for (i = 0; i < MVPP2_PRS_SRAM_WORDS; i++)
> +		mvpp2_write(priv, MVPP2_PRS_SRAM_DATA_REG(i), pe->sram.word[i]);
> +
> +	return 0;
> +}
> +
> +/* Initialize tcam entry from hw */
> +static int mvpp2_prs_init_from_hw(struct mvpp2 *priv,
> +				  struct mvpp2_prs_entry *pe, int tid)
> +{
> +	int i;
> +
> +	if (tid > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
> +		return -EINVAL;
> +
> +	memset(pe, 0, sizeof(*pe));
> +	pe->index = tid;
> +
> +	/* Write tcam index - indirect access */
> +	mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, pe->index);
> +
> +	pe->tcam.word[MVPP2_PRS_TCAM_INV_WORD] = mvpp2_read(priv,
> +			      MVPP2_PRS_TCAM_DATA_REG(MVPP2_PRS_TCAM_INV_WORD));
> +	if (pe->tcam.word[MVPP2_PRS_TCAM_INV_WORD] & MVPP2_PRS_TCAM_INV_MASK)
> +		return MVPP2_PRS_TCAM_ENTRY_INVALID;
> +
> +	for (i = 0; i < MVPP2_PRS_TCAM_WORDS; i++)
> +		pe->tcam.word[i] = mvpp2_read(priv, MVPP2_PRS_TCAM_DATA_REG(i));
> +
> +	/* Write sram index - indirect access */
> +	mvpp2_write(priv, MVPP2_PRS_SRAM_IDX_REG, pe->index);
> +	for (i = 0; i < MVPP2_PRS_SRAM_WORDS; i++)
> +		pe->sram.word[i] = mvpp2_read(priv, MVPP2_PRS_SRAM_DATA_REG(i));
> +
> +	return 0;
> +}
> +
> +/* Invalidate tcam hw entry */
> +static void mvpp2_prs_hw_inv(struct mvpp2 *priv, int index)
> +{
> +	/* Write index - indirect access */
> +	mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, index);
> +	mvpp2_write(priv, MVPP2_PRS_TCAM_DATA_REG(MVPP2_PRS_TCAM_INV_WORD),
> +		    MVPP2_PRS_TCAM_INV_MASK);
> +}
> +
> +/* Enable shadow table entry and set its lookup ID */
> +static void mvpp2_prs_shadow_set(struct mvpp2 *priv, int index, int lu)
> +{
> +	priv->prs_shadow[index].valid = true;
> +	priv->prs_shadow[index].lu = lu;
> +}
> +
> +/* Update ri fields in shadow table entry */
> +static void mvpp2_prs_shadow_ri_set(struct mvpp2 *priv, int index,
> +				    unsigned int ri, unsigned int ri_mask)
> +{
> +	priv->prs_shadow[index].ri_mask = ri_mask;
> +	priv->prs_shadow[index].ri = ri;
> +}
> +
> +/* Update lookup field in tcam sw entry */
> +static void mvpp2_prs_tcam_lu_set(struct mvpp2_prs_entry *pe, unsigned int lu)
> +{
> +	int enable_off = MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_LU_BYTE);
> +
> +	pe->tcam.byte[MVPP2_PRS_TCAM_LU_BYTE] = lu;
> +	pe->tcam.byte[enable_off] = MVPP2_PRS_LU_MASK;
> +}
> +
> +/* Update mask for single port in tcam sw entry */
> +static void mvpp2_prs_tcam_port_set(struct mvpp2_prs_entry *pe,
> +				    unsigned int port, bool add)
> +{
> +	int enable_off = MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_PORT_BYTE);
> +
> +	if (add)
> +		pe->tcam.byte[enable_off] &= ~(1 << port);
> +	else
> +		pe->tcam.byte[enable_off] |= 1 << port;
> +}
> +
> +/* Update port map in tcam sw entry */
> +static void mvpp2_prs_tcam_port_map_set(struct mvpp2_prs_entry *pe,
> +					unsigned int ports)
> +{
> +	unsigned char port_mask = MVPP2_PRS_PORT_MASK;
> +	int enable_off = MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_PORT_BYTE);
> +
> +	pe->tcam.byte[MVPP2_PRS_TCAM_PORT_BYTE] = 0;
> +	pe->tcam.byte[enable_off] &= ~port_mask;
> +	pe->tcam.byte[enable_off] |= ~ports & MVPP2_PRS_PORT_MASK;
> +}
> +
> +/* Obtain port map from tcam sw entry */
> +static unsigned int mvpp2_prs_tcam_port_map_get(struct mvpp2_prs_entry *pe)
> +{
> +	int enable_off = MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_PORT_BYTE);
> +
> +	return ~(pe->tcam.byte[enable_off]) & MVPP2_PRS_PORT_MASK;
> +}
> +
> +/* Set byte of data and its enable bits in tcam sw entry */
> +static void mvpp2_prs_tcam_data_byte_set(struct mvpp2_prs_entry *pe,
> +					 unsigned int offs, unsigned char byte,
> +					 unsigned char enable)
> +{
> +	pe->tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE(offs)] = byte;
> +	pe->tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE_EN(offs)] = enable;
> +}
> +
> +/* Get byte of data and its enable bits from tcam sw entry */
> +static void mvpp2_prs_tcam_data_byte_get(struct mvpp2_prs_entry *pe,
> +					 unsigned int offs, unsigned char *byte,
> +					 unsigned char *enable)
> +{
> +	*byte = pe->tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE(offs)];
> +	*enable = pe->tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE_EN(offs)];
> +}
> +
> +/* Compare tcam data bytes with a pattern */
> +static bool mvpp2_prs_tcam_data_cmp(struct mvpp2_prs_entry *pe, int offs,
> +				    u16 data)
> +{
> +	int off = MVPP2_PRS_TCAM_DATA_BYTE(offs);
> +	u16 tcam_data;
> +
> +	tcam_data = (pe->tcam.byte[off + 1] << 8) | pe->tcam.byte[off];
> +	if (tcam_data != data)
> +		return false;
> +	return true;
> +}
> +
> +/* Update ai bits in tcam sw entry */
> +static void mvpp2_prs_tcam_ai_update(struct mvpp2_prs_entry *pe,
> +				     unsigned int bits, unsigned int enable)
> +{
> +	int i, ai_idx = MVPP2_PRS_TCAM_AI_BYTE;
> +
> +	for (i = 0; i < MVPP2_PRS_AI_BITS; i++) {
> +		if (!(enable & BIT(i)))
> +			continue;
> +
> +		if (bits & BIT(i))
> +			pe->tcam.byte[ai_idx] |= 1 << i;
> +		else
> +			pe->tcam.byte[ai_idx] &= ~(1 << i);
> +	}
> +
> +	pe->tcam.byte[MVPP2_PRS_TCAM_EN_OFFS(ai_idx)] |= enable;
> +}
> +
> +/* Get ai bits from tcam sw entry */
> +static int mvpp2_prs_tcam_ai_get(struct mvpp2_prs_entry *pe)
> +{
> +	return pe->tcam.byte[MVPP2_PRS_TCAM_AI_BYTE];
> +}
> +
> +/* Set ethertype in tcam sw entry */
> +static void mvpp2_prs_match_etype(struct mvpp2_prs_entry *pe, int offset,
> +				  unsigned short ethertype)
> +{
> +	mvpp2_prs_tcam_data_byte_set(pe, offset + 0, ethertype >> 8, 0xff);
> +	mvpp2_prs_tcam_data_byte_set(pe, offset + 1, ethertype & 0xff, 0xff);
> +}
> +
> +/* Set vid in tcam sw entry */
> +static void mvpp2_prs_match_vid(struct mvpp2_prs_entry *pe, int offset,
> +				unsigned short vid)
> +{
> +	mvpp2_prs_tcam_data_byte_set(pe, offset + 0, (vid & 0xf00) >> 8, 0xf);
> +	mvpp2_prs_tcam_data_byte_set(pe, offset + 1, vid & 0xff, 0xff);
> +}
> +
> +/* Set bits in sram sw entry */
> +static void mvpp2_prs_sram_bits_set(struct mvpp2_prs_entry *pe, int bit_num,
> +				    int val)
> +{
> +	pe->sram.byte[MVPP2_BIT_TO_BYTE(bit_num)] |= (val << (bit_num % 8));
> +}
> +
> +/* Clear bits in sram sw entry */
> +static void mvpp2_prs_sram_bits_clear(struct mvpp2_prs_entry *pe, int bit_num,
> +				      int val)
> +{
> +	pe->sram.byte[MVPP2_BIT_TO_BYTE(bit_num)] &= ~(val << (bit_num % 8));
> +}
> +
> +/* Update ri bits in sram sw entry */
> +static void mvpp2_prs_sram_ri_update(struct mvpp2_prs_entry *pe,
> +				     unsigned int bits, unsigned int mask)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < MVPP2_PRS_SRAM_RI_CTRL_BITS; i++) {
> +		int ri_off = MVPP2_PRS_SRAM_RI_OFFS;
> +
> +		if (!(mask & BIT(i)))
> +			continue;
> +
> +		if (bits & BIT(i))
> +			mvpp2_prs_sram_bits_set(pe, ri_off + i, 1);
> +		else
> +			mvpp2_prs_sram_bits_clear(pe, ri_off + i, 1);
> +
> +		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_RI_CTRL_OFFS + i, 1);
> +	}
> +}
> +
> +/* Obtain ri bits from sram sw entry */
> +static int mvpp2_prs_sram_ri_get(struct mvpp2_prs_entry *pe)
> +{
> +	return pe->sram.word[MVPP2_PRS_SRAM_RI_WORD];
> +}
> +
> +/* Update ai bits in sram sw entry */
> +static void mvpp2_prs_sram_ai_update(struct mvpp2_prs_entry *pe,
> +				     unsigned int bits, unsigned int mask)
> +{
> +	unsigned int i;
> +	int ai_off = MVPP2_PRS_SRAM_AI_OFFS;
> +
> +	for (i = 0; i < MVPP2_PRS_SRAM_AI_CTRL_BITS; i++) {
> +		if (!(mask & BIT(i)))
> +			continue;
> +
> +		if (bits & BIT(i))
> +			mvpp2_prs_sram_bits_set(pe, ai_off + i, 1);
> +		else
> +			mvpp2_prs_sram_bits_clear(pe, ai_off + i, 1);
> +
> +		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_AI_CTRL_OFFS + i, 1);
> +	}
> +}
> +
> +/* Read ai bits from sram sw entry */
> +static int mvpp2_prs_sram_ai_get(struct mvpp2_prs_entry *pe)
> +{
> +	u8 bits;
> +	int ai_off = MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_AI_OFFS);
> +	int ai_en_off = ai_off + 1;
> +	int ai_shift = MVPP2_PRS_SRAM_AI_OFFS % 8;
> +
> +	bits = (pe->sram.byte[ai_off] >> ai_shift) |
> +	       (pe->sram.byte[ai_en_off] << (8 - ai_shift));
> +
> +	return bits;
> +}
> +
> +/* In sram sw entry set lookup ID field of the tcam key to be used in the next
> + * lookup interation
> + */
> +static void mvpp2_prs_sram_next_lu_set(struct mvpp2_prs_entry *pe,
> +				       unsigned int lu)
> +{
> +	int sram_next_off = MVPP2_PRS_SRAM_NEXT_LU_OFFS;
> +
> +	mvpp2_prs_sram_bits_clear(pe, sram_next_off,
> +				  MVPP2_PRS_SRAM_NEXT_LU_MASK);
> +	mvpp2_prs_sram_bits_set(pe, sram_next_off, lu);
> +}
> +
> +/* In the sram sw entry set sign and value of the next lookup offset
> + * and the offset value generated to the classifier
> + */
> +static void mvpp2_prs_sram_shift_set(struct mvpp2_prs_entry *pe, int shift,
> +				     unsigned int op)
> +{
> +	/* Set sign */
> +	if (shift < 0) {
> +		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_SHIFT_SIGN_BIT, 1);
> +		shift = 0 - shift;
> +	} else {
> +		mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_SHIFT_SIGN_BIT, 1);
> +	}
> +
> +	/* Set value */
> +	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_SHIFT_OFFS)] =
> +							   (unsigned char)shift;
> +
> +	/* Reset and set operation */
> +	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_SHIFT_OFFS,
> +				  MVPP2_PRS_SRAM_OP_SEL_SHIFT_MASK);
> +	mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_OP_SEL_SHIFT_OFFS, op);
> +
> +	/* Set base offset as current */
> +	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_BASE_OFFS, 1);
> +}
> +
> +/* In the sram sw entry set sign and value of the user defined offset
> + * generated to the classifier
> + */
> +static void mvpp2_prs_sram_offset_set(struct mvpp2_prs_entry *pe,
> +				      unsigned int type, int offset,
> +				      unsigned int op)
> +{
> +	/* Set sign */
> +	if (offset < 0) {
> +		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_UDF_SIGN_BIT, 1);
> +		offset = 0 - offset;
> +	} else {
> +		mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_UDF_SIGN_BIT, 1);
> +	}
> +
> +	/* Set value */
> +	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_UDF_OFFS,
> +				  MVPP2_PRS_SRAM_UDF_MASK);
> +	mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_UDF_OFFS, offset);
> +	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_UDF_OFFS +
> +					MVPP2_PRS_SRAM_UDF_BITS)] &=
> +	      ~(MVPP2_PRS_SRAM_UDF_MASK >> (8 - (MVPP2_PRS_SRAM_UDF_OFFS % 8)));
> +	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_UDF_OFFS +
> +					MVPP2_PRS_SRAM_UDF_BITS)] |=
> +				(offset >> (8 - (MVPP2_PRS_SRAM_UDF_OFFS % 8)));
> +
> +	/* Set offset type */
> +	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_UDF_TYPE_OFFS,
> +				  MVPP2_PRS_SRAM_UDF_TYPE_MASK);
> +	mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_UDF_TYPE_OFFS, type);
> +
> +	/* Set offset operation */
> +	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_MASK);
> +	mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS, op);
> +
> +	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS +
> +					MVPP2_PRS_SRAM_OP_SEL_UDF_BITS)] &=
> +					     ~(MVPP2_PRS_SRAM_OP_SEL_UDF_MASK >>
> +				    (8 - (MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS % 8)));
> +
> +	pe->sram.byte[MVPP2_BIT_TO_BYTE(MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS +
> +					MVPP2_PRS_SRAM_OP_SEL_UDF_BITS)] |=
> +			     (op >> (8 - (MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS % 8)));
> +
> +	/* Set base offset as current */
> +	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_BASE_OFFS, 1);
> +}
> +
> +/* Find parser flow entry */
> +static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	/* Go through the all entires with MVPP2_PRS_LU_FLOWS */
> +	for (tid = MVPP2_PRS_TCAM_SRAM_SIZE - 1; tid >= 0; tid--) {
> +		u8 bits;
> +
> +		if (!priv->prs_shadow[tid].valid ||
> +		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_FLOWS)
> +			continue;
> +
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +		bits = mvpp2_prs_sram_ai_get(&pe);
> +
> +		/* Sram store classification lookup ID in AI bits [5:0] */
> +		if ((bits & MVPP2_PRS_FLOW_ID_MASK) == flow)
> +			return tid;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/* Return first free tcam index, seeking from start to end */
> +static int mvpp2_prs_tcam_first_free(struct mvpp2 *priv, unsigned char start,
> +				     unsigned char end)
> +{
> +	int tid;
> +
> +	if (start > end)
> +		swap(start, end);
> +
> +	if (end >= MVPP2_PRS_TCAM_SRAM_SIZE)
> +		end = MVPP2_PRS_TCAM_SRAM_SIZE - 1;
> +
> +	for (tid = start; tid <= end; tid++) {
> +		if (!priv->prs_shadow[tid].valid)
> +			return tid;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/* Enable/disable dropping all mac da's */
> +static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
> +{
> +	struct mvpp2_prs_entry pe;
> +
> +	if (priv->prs_shadow[MVPP2_PE_DROP_ALL].valid) {
> +		/* Entry exist - update port only */
> +		mvpp2_prs_init_from_hw(priv, &pe, MVPP2_PE_DROP_ALL);
> +	} else {
> +		/* Entry doesn't exist - create new */
> +		memset(&pe, 0, sizeof(pe));
> +		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
> +		pe.index = MVPP2_PE_DROP_ALL;
> +
> +		/* Non-promiscuous mode for all ports - DROP unknown packets */
> +		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_DROP_MASK,
> +					 MVPP2_PRS_RI_DROP_MASK);
> +
> +		mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +
> +		/* Update shadow table */
> +		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> +
> +		/* Mask all ports */
> +		mvpp2_prs_tcam_port_map_set(&pe, 0);
> +	}
> +
> +	/* Update port mask */
> +	mvpp2_prs_tcam_port_set(&pe, port, add);
> +
> +	mvpp2_prs_hw_write(priv, &pe);
> +}
> +
> +/* Set port to unicast or multicast promiscuous mode */
> +void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
> +			       enum mvpp2_prs_l2_cast l2_cast, bool add)
> +{
> +	struct mvpp2_prs_entry pe;
> +	unsigned char cast_match;
> +	unsigned int ri;
> +	int tid;
> +
> +	if (l2_cast == MVPP2_PRS_L2_UNI_CAST) {
> +		cast_match = MVPP2_PRS_UCAST_VAL;
> +		tid = MVPP2_PE_MAC_UC_PROMISCUOUS;
> +		ri = MVPP2_PRS_RI_L2_UCAST;
> +	} else {
> +		cast_match = MVPP2_PRS_MCAST_VAL;
> +		tid = MVPP2_PE_MAC_MC_PROMISCUOUS;
> +		ri = MVPP2_PRS_RI_L2_MCAST;
> +	}
> +
> +	/* promiscuous mode - Accept unknown unicast or multicast packets */
> +	if (priv->prs_shadow[tid].valid) {
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +	} else {
> +		memset(&pe, 0, sizeof(pe));
> +		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
> +		pe.index = tid;
> +
> +		/* Continue - set next lookup */
> +		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_DSA);
> +
> +		/* Set result info bits */
> +		mvpp2_prs_sram_ri_update(&pe, ri, MVPP2_PRS_RI_L2_CAST_MASK);
> +
> +		/* Match UC or MC addresses */
> +		mvpp2_prs_tcam_data_byte_set(&pe, 0, cast_match,
> +					     MVPP2_PRS_CAST_MASK);
> +
> +		/* Shift to ethertype */
> +		mvpp2_prs_sram_shift_set(&pe, 2 * ETH_ALEN,
> +					 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +		/* Mask all ports */
> +		mvpp2_prs_tcam_port_map_set(&pe, 0);
> +
> +		/* Update shadow table */
> +		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> +	}
> +
> +	/* Update port mask */
> +	mvpp2_prs_tcam_port_set(&pe, port, add);
> +
> +	mvpp2_prs_hw_write(priv, &pe);
> +}
> +
> +/* Set entry for dsa packets */
> +static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
> +				  bool tagged, bool extend)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid, shift;
> +
> +	if (extend) {
> +		tid = tagged ? MVPP2_PE_EDSA_TAGGED : MVPP2_PE_EDSA_UNTAGGED;
> +		shift = 8;
> +	} else {
> +		tid = tagged ? MVPP2_PE_DSA_TAGGED : MVPP2_PE_DSA_UNTAGGED;
> +		shift = 4;
> +	}
> +
> +	if (priv->prs_shadow[tid].valid) {
> +		/* Entry exist - update port only */
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +	} else {
> +		/* Entry doesn't exist - create new */
> +		memset(&pe, 0, sizeof(pe));
> +		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_DSA);
> +		pe.index = tid;
> +
> +		/* Update shadow table */
> +		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_DSA);
> +
> +		if (tagged) {
> +			/* Set tagged bit in DSA tag */
> +			mvpp2_prs_tcam_data_byte_set(&pe, 0,
> +					     MVPP2_PRS_TCAM_DSA_TAGGED_BIT,
> +					     MVPP2_PRS_TCAM_DSA_TAGGED_BIT);
> +
> +			/* Set ai bits for next iteration */
> +			if (extend)
> +				mvpp2_prs_sram_ai_update(&pe, 1,
> +							MVPP2_PRS_SRAM_AI_MASK);
> +			else
> +				mvpp2_prs_sram_ai_update(&pe, 0,
> +							MVPP2_PRS_SRAM_AI_MASK);
> +
> +			/* Set result info bits to 'single vlan' */
> +			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_SINGLE,
> +						 MVPP2_PRS_RI_VLAN_MASK);
> +			/* If packet is tagged continue check vid filtering */
> +			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VID);
> +		} else {
> +			/* Shift 4 bytes for DSA tag or 8 bytes for EDSA tag*/
> +			mvpp2_prs_sram_shift_set(&pe, shift,
> +					MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +			/* Set result info bits to 'no vlans' */
> +			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_NONE,
> +						 MVPP2_PRS_RI_VLAN_MASK);
> +			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> +		}
> +
> +		/* Mask all ports */
> +		mvpp2_prs_tcam_port_map_set(&pe, 0);
> +	}
> +
> +	/* Update port mask */
> +	mvpp2_prs_tcam_port_set(&pe, port, add);
> +
> +	mvpp2_prs_hw_write(priv, &pe);
> +}
> +
> +/* Set entry for dsa ethertype */
> +static void mvpp2_prs_dsa_tag_ethertype_set(struct mvpp2 *priv, int port,
> +					    bool add, bool tagged, bool extend)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid, shift, port_mask;
> +
> +	if (extend) {
> +		tid = tagged ? MVPP2_PE_ETYPE_EDSA_TAGGED :
> +		      MVPP2_PE_ETYPE_EDSA_UNTAGGED;
> +		port_mask = 0;
> +		shift = 8;
> +	} else {
> +		tid = tagged ? MVPP2_PE_ETYPE_DSA_TAGGED :
> +		      MVPP2_PE_ETYPE_DSA_UNTAGGED;
> +		port_mask = MVPP2_PRS_PORT_MASK;
> +		shift = 4;
> +	}
> +
> +	if (priv->prs_shadow[tid].valid) {
> +		/* Entry exist - update port only */
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +	} else {
> +		/* Entry doesn't exist - create new */
> +		memset(&pe, 0, sizeof(pe));
> +		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_DSA);
> +		pe.index = tid;
> +
> +		/* Set ethertype */
> +		mvpp2_prs_match_etype(&pe, 0, ETH_P_EDSA);
> +		mvpp2_prs_match_etype(&pe, 2, 0);
> +
> +		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_DSA_MASK,
> +					 MVPP2_PRS_RI_DSA_MASK);
> +		/* Shift ethertype + 2 byte reserved + tag*/
> +		mvpp2_prs_sram_shift_set(&pe, 2 + MVPP2_ETH_TYPE_LEN + shift,
> +					 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +		/* Update shadow table */
> +		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_DSA);
> +
> +		if (tagged) {
> +			/* Set tagged bit in DSA tag */
> +			mvpp2_prs_tcam_data_byte_set(&pe,
> +						     MVPP2_ETH_TYPE_LEN + 2 + 3,
> +						 MVPP2_PRS_TCAM_DSA_TAGGED_BIT,
> +						 MVPP2_PRS_TCAM_DSA_TAGGED_BIT);
> +			/* Clear all ai bits for next iteration */
> +			mvpp2_prs_sram_ai_update(&pe, 0,
> +						 MVPP2_PRS_SRAM_AI_MASK);
> +			/* If packet is tagged continue check vlans */
> +			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> +		} else {
> +			/* Set result info bits to 'no vlans' */
> +			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_NONE,
> +						 MVPP2_PRS_RI_VLAN_MASK);
> +			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> +		}
> +		/* Mask/unmask all ports, depending on dsa type */
> +		mvpp2_prs_tcam_port_map_set(&pe, port_mask);
> +	}
> +
> +	/* Update port mask */
> +	mvpp2_prs_tcam_port_set(&pe, port, add);
> +
> +	mvpp2_prs_hw_write(priv, &pe);
> +}
> +
> +/* Search for existing single/triple vlan entry */
> +static int mvpp2_prs_vlan_find(struct mvpp2 *priv, unsigned short tpid, int ai)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	/* Go through the all entries with MVPP2_PRS_LU_VLAN */
> +	for (tid = MVPP2_PE_FIRST_FREE_TID;
> +	     tid <= MVPP2_PE_LAST_FREE_TID; tid++) {
> +		unsigned int ri_bits, ai_bits;
> +		bool match;
> +
> +		if (!priv->prs_shadow[tid].valid ||
> +		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
> +			continue;
> +
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +		match = mvpp2_prs_tcam_data_cmp(&pe, 0, swab16(tpid));
> +		if (!match)
> +			continue;
> +
> +		/* Get vlan type */
> +		ri_bits = mvpp2_prs_sram_ri_get(&pe);
> +		ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
> +
> +		/* Get current ai value from tcam */
> +		ai_bits = mvpp2_prs_tcam_ai_get(&pe);
> +		/* Clear double vlan bit */
> +		ai_bits &= ~MVPP2_PRS_DBL_VLAN_AI_BIT;
> +
> +		if (ai != ai_bits)
> +			continue;
> +
> +		if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
> +		    ri_bits == MVPP2_PRS_RI_VLAN_TRIPLE)
> +			return tid;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/* Add/update single/triple vlan entry */
> +static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
> +			      unsigned int port_map)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid_aux, tid;
> +	int ret = 0;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	tid = mvpp2_prs_vlan_find(priv, tpid, ai);
> +
> +	if (tid < 0) {
> +		/* Create new tcam entry */
> +		tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_LAST_FREE_TID,
> +						MVPP2_PE_FIRST_FREE_TID);
> +		if (tid < 0)
> +			return tid;
> +
> +		/* Get last double vlan tid */
> +		for (tid_aux = MVPP2_PE_LAST_FREE_TID;
> +		     tid_aux >= MVPP2_PE_FIRST_FREE_TID; tid_aux--) {
> +			unsigned int ri_bits;
> +
> +			if (!priv->prs_shadow[tid_aux].valid ||
> +			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
> +				continue;
> +
> +			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
> +			ri_bits = mvpp2_prs_sram_ri_get(&pe);
> +			if ((ri_bits & MVPP2_PRS_RI_VLAN_MASK) ==
> +			    MVPP2_PRS_RI_VLAN_DOUBLE)
> +				break;
> +		}
> +
> +		if (tid <= tid_aux)
> +			return -EINVAL;
> +
> +		memset(&pe, 0, sizeof(pe));
> +		pe.index = tid;
> +		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> +
> +		mvpp2_prs_match_etype(&pe, 0, tpid);
> +
> +		/* VLAN tag detected, proceed with VID filtering */
> +		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VID);
> +
> +		/* Clear all ai bits for next iteration */
> +		mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> +
> +		if (ai == MVPP2_PRS_SINGLE_VLAN_AI) {
> +			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_SINGLE,
> +						 MVPP2_PRS_RI_VLAN_MASK);
> +		} else {
> +			ai |= MVPP2_PRS_DBL_VLAN_AI_BIT;
> +			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_TRIPLE,
> +						 MVPP2_PRS_RI_VLAN_MASK);
> +		}
> +		mvpp2_prs_tcam_ai_update(&pe, ai, MVPP2_PRS_SRAM_AI_MASK);
> +
> +		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
> +	} else {
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +	}
> +	/* Update ports' mask */
> +	mvpp2_prs_tcam_port_map_set(&pe, port_map);
> +
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return ret;
> +}
> +
> +/* Get first free double vlan ai number */
> +static int mvpp2_prs_double_vlan_ai_free_get(struct mvpp2 *priv)
> +{
> +	int i;
> +
> +	for (i = 1; i < MVPP2_PRS_DBL_VLANS_MAX; i++) {
> +		if (!priv->prs_double_vlans[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/* Search for existing double vlan entry */
> +static int mvpp2_prs_double_vlan_find(struct mvpp2 *priv, unsigned short tpid1,
> +				      unsigned short tpid2)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	/* Go through the all entries with MVPP2_PRS_LU_VLAN */
> +	for (tid = MVPP2_PE_FIRST_FREE_TID;
> +	     tid <= MVPP2_PE_LAST_FREE_TID; tid++) {
> +		unsigned int ri_mask;
> +		bool match;
> +
> +		if (!priv->prs_shadow[tid].valid ||
> +		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
> +			continue;
> +
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +
> +		match = mvpp2_prs_tcam_data_cmp(&pe, 0, swab16(tpid1)) &&
> +			mvpp2_prs_tcam_data_cmp(&pe, 4, swab16(tpid2));
> +
> +		if (!match)
> +			continue;
> +
> +		ri_mask = mvpp2_prs_sram_ri_get(&pe) & MVPP2_PRS_RI_VLAN_MASK;
> +		if (ri_mask == MVPP2_PRS_RI_VLAN_DOUBLE)
> +			return tid;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/* Add or update double vlan entry */
> +static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
> +				     unsigned short tpid2,
> +				     unsigned int port_map)
> +{
> +	int tid_aux, tid, ai, ret = 0;
> +	struct mvpp2_prs_entry pe;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	tid = mvpp2_prs_double_vlan_find(priv, tpid1, tpid2);
> +
> +	if (tid < 0) {
> +		/* Create new tcam entry */
> +		tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +				MVPP2_PE_LAST_FREE_TID);
> +		if (tid < 0)
> +			return tid;
> +
> +		/* Set ai value for new double vlan entry */
> +		ai = mvpp2_prs_double_vlan_ai_free_get(priv);
> +		if (ai < 0)
> +			return ai;
> +
> +		/* Get first single/triple vlan tid */
> +		for (tid_aux = MVPP2_PE_FIRST_FREE_TID;
> +		     tid_aux <= MVPP2_PE_LAST_FREE_TID; tid_aux++) {
> +			unsigned int ri_bits;
> +
> +			if (!priv->prs_shadow[tid_aux].valid ||
> +			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
> +				continue;
> +
> +			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
> +			ri_bits = mvpp2_prs_sram_ri_get(&pe);
> +			ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
> +			if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
> +			    ri_bits == MVPP2_PRS_RI_VLAN_TRIPLE)
> +				break;
> +		}
> +
> +		if (tid >= tid_aux)
> +			return -ERANGE;
> +
> +		memset(&pe, 0, sizeof(pe));
> +		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> +		pe.index = tid;
> +
> +		priv->prs_double_vlans[ai] = true;
> +
> +		mvpp2_prs_match_etype(&pe, 0, tpid1);
> +		mvpp2_prs_match_etype(&pe, 4, tpid2);
> +
> +		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> +		/* Shift 4 bytes - skip outer vlan tag */
> +		mvpp2_prs_sram_shift_set(&pe, MVPP2_VLAN_TAG_LEN,
> +					 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_DOUBLE,
> +					 MVPP2_PRS_RI_VLAN_MASK);
> +		mvpp2_prs_sram_ai_update(&pe, ai | MVPP2_PRS_DBL_VLAN_AI_BIT,
> +					 MVPP2_PRS_SRAM_AI_MASK);
> +
> +		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
> +	} else {
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +	}
> +
> +	/* Update ports' mask */
> +	mvpp2_prs_tcam_port_map_set(&pe, port_map);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return ret;
> +}
> +
> +/* IPv4 header parsing for fragmentation and L4 offset */
> +static int mvpp2_prs_ip4_proto(struct mvpp2 *priv, unsigned short proto,
> +			       unsigned int ri, unsigned int ri_mask)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	if ((proto != IPPROTO_TCP) && (proto != IPPROTO_UDP) &&
> +	    (proto != IPPROTO_IGMP))
> +		return -EINVAL;
> +
> +	/* Not fragmented packet */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP4);
> +	pe.index = tid;
> +
> +	/* Set next lu to IPv4 */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_sram_shift_set(&pe, 12, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	/* Set L4 offset */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L4,
> +				  sizeof(struct iphdr) - 4,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +	mvpp2_prs_sram_ai_update(&pe, MVPP2_PRS_IPV4_DIP_AI_BIT,
> +				 MVPP2_PRS_IPV4_DIP_AI_BIT);
> +	mvpp2_prs_sram_ri_update(&pe, ri, ri_mask | MVPP2_PRS_RI_IP_FRAG_MASK);
> +
> +	mvpp2_prs_tcam_data_byte_set(&pe, 2, 0x00,
> +				     MVPP2_PRS_TCAM_PROTO_MASK_L);
> +	mvpp2_prs_tcam_data_byte_set(&pe, 3, 0x00,
> +				     MVPP2_PRS_TCAM_PROTO_MASK);
> +
> +	mvpp2_prs_tcam_data_byte_set(&pe, 5, proto, MVPP2_PRS_TCAM_PROTO_MASK);
> +	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_IPV4_DIP_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Fragmented packet */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	pe.index = tid;
> +	/* Clear ri before updating */
> +	pe.sram.word[MVPP2_PRS_SRAM_RI_WORD] = 0x0;
> +	pe.sram.word[MVPP2_PRS_SRAM_RI_CTRL_WORD] = 0x0;
> +	mvpp2_prs_sram_ri_update(&pe, ri, ri_mask);
> +
> +	mvpp2_prs_sram_ri_update(&pe, ri | MVPP2_PRS_RI_IP_FRAG_TRUE,
> +				 ri_mask | MVPP2_PRS_RI_IP_FRAG_MASK);
> +
> +	mvpp2_prs_tcam_data_byte_set(&pe, 2, 0x00, 0x0);
> +	mvpp2_prs_tcam_data_byte_set(&pe, 3, 0x00, 0x0);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* IPv4 L3 multicast or broadcast */
> +static int mvpp2_prs_ip4_cast(struct mvpp2 *priv, unsigned short l3_cast)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int mask, tid;
> +
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP4);
> +	pe.index = tid;
> +
> +	switch (l3_cast) {
> +	case MVPP2_PRS_L3_MULTI_CAST:
> +		mvpp2_prs_tcam_data_byte_set(&pe, 0, MVPP2_PRS_IPV4_MC,
> +					     MVPP2_PRS_IPV4_MC_MASK);
> +		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_MCAST,
> +					 MVPP2_PRS_RI_L3_ADDR_MASK);
> +		break;
> +	case  MVPP2_PRS_L3_BROAD_CAST:
> +		mask = MVPP2_PRS_IPV4_BC_MASK;
> +		mvpp2_prs_tcam_data_byte_set(&pe, 0, mask, mask);
> +		mvpp2_prs_tcam_data_byte_set(&pe, 1, mask, mask);
> +		mvpp2_prs_tcam_data_byte_set(&pe, 2, mask, mask);
> +		mvpp2_prs_tcam_data_byte_set(&pe, 3, mask, mask);
> +		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_BCAST,
> +					 MVPP2_PRS_RI_L3_ADDR_MASK);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Finished: go to flowid generation */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV4_DIP_AI_BIT,
> +				 MVPP2_PRS_IPV4_DIP_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* Set entries for protocols over IPv6  */
> +static int mvpp2_prs_ip6_proto(struct mvpp2 *priv, unsigned short proto,
> +			       unsigned int ri, unsigned int ri_mask)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	if ((proto != IPPROTO_TCP) && (proto != IPPROTO_UDP) &&
> +	    (proto != IPPROTO_ICMPV6) && (proto != IPPROTO_IPIP))
> +		return -EINVAL;
> +
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	pe.index = tid;
> +
> +	/* Finished: go to flowid generation */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_ri_update(&pe, ri, ri_mask);
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L4,
> +				  sizeof(struct ipv6hdr) - 6,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	mvpp2_prs_tcam_data_byte_set(&pe, 0, proto, MVPP2_PRS_TCAM_PROTO_MASK);
> +	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> +				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Write HW */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP6);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* IPv6 L3 multicast entry */
> +static int mvpp2_prs_ip6_cast(struct mvpp2 *priv, unsigned short l3_cast)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	if (l3_cast != MVPP2_PRS_L3_MULTI_CAST)
> +		return -EINVAL;
> +
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	pe.index = tid;
> +
> +	/* Finished: go to flowid generation */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_MCAST,
> +				 MVPP2_PRS_RI_L3_ADDR_MASK);
> +	mvpp2_prs_sram_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> +				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> +	/* Shift back to IPv6 NH */
> +	mvpp2_prs_sram_shift_set(&pe, -18, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +	mvpp2_prs_tcam_data_byte_set(&pe, 0, MVPP2_PRS_IPV6_MC,
> +				     MVPP2_PRS_IPV6_MC_MASK);
> +	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP6);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* Parser per-port initialization */
> +static void mvpp2_prs_hw_port_init(struct mvpp2 *priv, int port, int lu_first,
> +				   int lu_max, int offset)
> +{
> +	u32 val;
> +
> +	/* Set lookup ID */
> +	val = mvpp2_read(priv, MVPP2_PRS_INIT_LOOKUP_REG);
> +	val &= ~MVPP2_PRS_PORT_LU_MASK(port);
> +	val |=  MVPP2_PRS_PORT_LU_VAL(port, lu_first);
> +	mvpp2_write(priv, MVPP2_PRS_INIT_LOOKUP_REG, val);
> +
> +	/* Set maximum number of loops for packet received from port */
> +	val = mvpp2_read(priv, MVPP2_PRS_MAX_LOOP_REG(port));
> +	val &= ~MVPP2_PRS_MAX_LOOP_MASK(port);
> +	val |= MVPP2_PRS_MAX_LOOP_VAL(port, lu_max);
> +	mvpp2_write(priv, MVPP2_PRS_MAX_LOOP_REG(port), val);
> +
> +	/* Set initial offset for packet header extraction for the first
> +	 * searching loop
> +	 */
> +	val = mvpp2_read(priv, MVPP2_PRS_INIT_OFFS_REG(port));
> +	val &= ~MVPP2_PRS_INIT_OFF_MASK(port);
> +	val |= MVPP2_PRS_INIT_OFF_VAL(port, offset);
> +	mvpp2_write(priv, MVPP2_PRS_INIT_OFFS_REG(port), val);
> +}
> +
> +/* Default flow entries initialization for all ports */
> +static void mvpp2_prs_def_flow_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int port;
> +
> +	for (port = 0; port < MVPP2_MAX_PORTS; port++) {
> +		memset(&pe, 0, sizeof(pe));
> +		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +		pe.index = MVPP2_PE_FIRST_DEFAULT_FLOW - port;
> +
> +		/* Mask all ports */
> +		mvpp2_prs_tcam_port_map_set(&pe, 0);
> +
> +		/* Set flow ID*/
> +		mvpp2_prs_sram_ai_update(&pe, port, MVPP2_PRS_FLOW_ID_MASK);
> +		mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_DONE_BIT, 1);
> +
> +		/* Update shadow table and hw entry */
> +		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_FLOWS);
> +		mvpp2_prs_hw_write(priv, &pe);
> +	}
> +}
> +
> +/* Set default entry for Marvell Header field */
> +static void mvpp2_prs_mh_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	pe.index = MVPP2_PE_MH_DEFAULT;
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MH);
> +	mvpp2_prs_sram_shift_set(&pe, MVPP2_MH_SIZE,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_MAC);
> +
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MH);
> +	mvpp2_prs_hw_write(priv, &pe);
> +}
> +
> +/* Set default entires (place holder) for promiscuous, non-promiscuous and
> + * multicast MAC addresses
> + */
> +static void mvpp2_prs_mac_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	/* Non-promiscuous mode for all ports - DROP unknown packets */
> +	pe.index = MVPP2_PE_MAC_NON_PROMISCUOUS;
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
> +
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_DROP_MASK,
> +				 MVPP2_PRS_RI_DROP_MASK);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Create dummy entries for drop all and promiscuous modes */
> +	mvpp2_prs_mac_drop_all_set(priv, 0, false);
> +	mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_UNI_CAST, false);
> +	mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_MULTI_CAST, false);
> +}
> +
> +/* Set default entries for various types of dsa packets */
> +static void mvpp2_prs_dsa_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +
> +	/* None tagged EDSA entry - place holder */
> +	mvpp2_prs_dsa_tag_set(priv, 0, false, MVPP2_PRS_UNTAGGED,
> +			      MVPP2_PRS_EDSA);
> +
> +	/* Tagged EDSA entry - place holder */
> +	mvpp2_prs_dsa_tag_set(priv, 0, false, MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> +
> +	/* None tagged DSA entry - place holder */
> +	mvpp2_prs_dsa_tag_set(priv, 0, false, MVPP2_PRS_UNTAGGED,
> +			      MVPP2_PRS_DSA);
> +
> +	/* Tagged DSA entry - place holder */
> +	mvpp2_prs_dsa_tag_set(priv, 0, false, MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> +
> +	/* None tagged EDSA ethertype entry - place holder*/
> +	mvpp2_prs_dsa_tag_ethertype_set(priv, 0, false,
> +					MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> +
> +	/* Tagged EDSA ethertype entry - place holder*/
> +	mvpp2_prs_dsa_tag_ethertype_set(priv, 0, false,
> +					MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> +
> +	/* None tagged DSA ethertype entry */
> +	mvpp2_prs_dsa_tag_ethertype_set(priv, 0, true,
> +					MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> +
> +	/* Tagged DSA ethertype entry */
> +	mvpp2_prs_dsa_tag_ethertype_set(priv, 0, true,
> +					MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> +
> +	/* Set default entry, in case DSA or EDSA tag not found */
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_DSA);
> +	pe.index = MVPP2_PE_DSA_DEFAULT;
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> +
> +	/* Shift 0 bytes */
> +	mvpp2_prs_sram_shift_set(&pe, 0, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> +
> +	/* Clear all sram ai bits for next iteration */
> +	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> +
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	mvpp2_prs_hw_write(priv, &pe);
> +}
> +
> +/* Initialize parser entries for VID filtering */
> +static void mvpp2_prs_vid_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	/* Set default vid entry */
> +	pe.index = MVPP2_PE_VID_FLTR_DEFAULT;
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_EDSA_VID_AI_BIT);
> +
> +	/* Skip VLAN header - Set offset to 4 bytes */
> +	mvpp2_prs_sram_shift_set(&pe, MVPP2_VLAN_TAG_LEN,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +	/* Clear all ai bits for next iteration */
> +	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> +
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> +
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Set default vid entry for extended DSA*/
> +	memset(&pe, 0, sizeof(pe));
> +
> +	/* Set default vid entry */
> +	pe.index = MVPP2_PE_VID_EDSA_FLTR_DEFAULT;
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_EDSA_VID_AI_BIT,
> +				 MVPP2_PRS_EDSA_VID_AI_BIT);
> +
> +	/* Skip VLAN header - Set offset to 8 bytes */
> +	mvpp2_prs_sram_shift_set(&pe, MVPP2_VLAN_TAG_EDSA_LEN,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +	/* Clear all ai bits for next iteration */
> +	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> +
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> +
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
> +	mvpp2_prs_hw_write(priv, &pe);
> +}
> +
> +/* Match basic ethertypes */
> +static int mvpp2_prs_etype_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	/* Ethertype: PPPoE */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> +	pe.index = tid;
> +
> +	mvpp2_prs_match_etype(&pe, 0, ETH_P_PPP_SES);
> +
> +	mvpp2_prs_sram_shift_set(&pe, MVPP2_PPPOE_HDR_SIZE,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_PPPOE);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_PPPOE_MASK,
> +				 MVPP2_PRS_RI_PPPOE_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> +	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> +	priv->prs_shadow[pe.index].finish = false;
> +	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_PPPOE_MASK,
> +				MVPP2_PRS_RI_PPPOE_MASK);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Ethertype: ARP */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> +	pe.index = tid;
> +
> +	mvpp2_prs_match_etype(&pe, 0, ETH_P_ARP);
> +
> +	/* Generate flow in the next iteration*/
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_ARP,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +	/* Set L3 offset */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> +				  MVPP2_ETH_TYPE_LEN,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> +	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> +	priv->prs_shadow[pe.index].finish = true;
> +	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_ARP,
> +				MVPP2_PRS_RI_L3_PROTO_MASK);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Ethertype: LBTD */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> +	pe.index = tid;
> +
> +	mvpp2_prs_match_etype(&pe, 0, MVPP2_IP_LBDT_TYPE);
> +
> +	/* Generate flow in the next iteration*/
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_CPU_CODE_RX_SPEC |
> +				 MVPP2_PRS_RI_UDF3_RX_SPECIAL,
> +				 MVPP2_PRS_RI_CPU_CODE_MASK |
> +				 MVPP2_PRS_RI_UDF3_MASK);
> +	/* Set L3 offset */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> +				  MVPP2_ETH_TYPE_LEN,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> +	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> +	priv->prs_shadow[pe.index].finish = true;
> +	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_CPU_CODE_RX_SPEC |
> +				MVPP2_PRS_RI_UDF3_RX_SPECIAL,
> +				MVPP2_PRS_RI_CPU_CODE_MASK |
> +				MVPP2_PRS_RI_UDF3_MASK);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Ethertype: IPv4 without options */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> +	pe.index = tid;
> +
> +	mvpp2_prs_match_etype(&pe, 0, ETH_P_IP);
> +	mvpp2_prs_tcam_data_byte_set(&pe, MVPP2_ETH_TYPE_LEN,
> +				     MVPP2_PRS_IPV4_HEAD | MVPP2_PRS_IPV4_IHL,
> +				     MVPP2_PRS_IPV4_HEAD_MASK |
> +				     MVPP2_PRS_IPV4_IHL_MASK);
> +
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP4,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +	/* Skip eth_type + 4 bytes of IP header */
> +	mvpp2_prs_sram_shift_set(&pe, MVPP2_ETH_TYPE_LEN + 4,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	/* Set L3 offset */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> +				  MVPP2_ETH_TYPE_LEN,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> +	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> +	priv->prs_shadow[pe.index].finish = false;
> +	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_IP4,
> +				MVPP2_PRS_RI_L3_PROTO_MASK);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Ethertype: IPv4 with options */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	pe.index = tid;
> +
> +	/* Clear tcam data before updating */
> +	pe.tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE(MVPP2_ETH_TYPE_LEN)] = 0x0;
> +	pe.tcam.byte[MVPP2_PRS_TCAM_DATA_BYTE_EN(MVPP2_ETH_TYPE_LEN)] = 0x0;
> +
> +	mvpp2_prs_tcam_data_byte_set(&pe, MVPP2_ETH_TYPE_LEN,
> +				     MVPP2_PRS_IPV4_HEAD,
> +				     MVPP2_PRS_IPV4_HEAD_MASK);
> +
> +	/* Clear ri before updating */
> +	pe.sram.word[MVPP2_PRS_SRAM_RI_WORD] = 0x0;
> +	pe.sram.word[MVPP2_PRS_SRAM_RI_CTRL_WORD] = 0x0;
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP4_OPT,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> +	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> +	priv->prs_shadow[pe.index].finish = false;
> +	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_IP4_OPT,
> +				MVPP2_PRS_RI_L3_PROTO_MASK);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Ethertype: IPv6 without options */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> +	pe.index = tid;
> +
> +	mvpp2_prs_match_etype(&pe, 0, ETH_P_IPV6);
> +
> +	/* Skip DIP of IPV6 header */
> +	mvpp2_prs_sram_shift_set(&pe, MVPP2_ETH_TYPE_LEN + 8 +
> +				 MVPP2_MAX_L3_ADDR_SIZE,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP6,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +	/* Set L3 offset */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> +				  MVPP2_ETH_TYPE_LEN,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> +	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> +	priv->prs_shadow[pe.index].finish = false;
> +	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_IP6,
> +				MVPP2_PRS_RI_L3_PROTO_MASK);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Default entry for MVPP2_PRS_LU_L2 - Unknown ethtype */
> +	memset(&pe, 0, sizeof(struct mvpp2_prs_entry));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_L2);
> +	pe.index = MVPP2_PE_ETH_TYPE_UN;
> +
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Generate flow in the next iteration*/
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UN,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +	/* Set L3 offset even it's unknown L3 */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> +				  MVPP2_ETH_TYPE_LEN,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_L2);
> +	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_L2_DEF;
> +	priv->prs_shadow[pe.index].finish = true;
> +	mvpp2_prs_shadow_ri_set(priv, pe.index, MVPP2_PRS_RI_L3_UN,
> +				MVPP2_PRS_RI_L3_PROTO_MASK);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* Configure vlan entries and detect up to 2 successive VLAN tags.
> + * Possible options:
> + * 0x8100, 0x88A8
> + * 0x8100, 0x8100
> + * 0x8100
> + * 0x88A8
> + */
> +static int mvpp2_prs_vlan_init(struct platform_device *pdev, struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int err;
> +
> +	priv->prs_double_vlans = devm_kcalloc(&pdev->dev, sizeof(bool),
> +					      MVPP2_PRS_DBL_VLANS_MAX,
> +					      GFP_KERNEL);
> +	if (!priv->prs_double_vlans)
> +		return -ENOMEM;
> +
> +	/* Double VLAN: 0x8100, 0x88A8 */
> +	err = mvpp2_prs_double_vlan_add(priv, ETH_P_8021Q, ETH_P_8021AD,
> +					MVPP2_PRS_PORT_MASK);
> +	if (err)
> +		return err;
> +
> +	/* Double VLAN: 0x8100, 0x8100 */
> +	err = mvpp2_prs_double_vlan_add(priv, ETH_P_8021Q, ETH_P_8021Q,
> +					MVPP2_PRS_PORT_MASK);
> +	if (err)
> +		return err;
> +
> +	/* Single VLAN: 0x88a8 */
> +	err = mvpp2_prs_vlan_add(priv, ETH_P_8021AD, MVPP2_PRS_SINGLE_VLAN_AI,
> +				 MVPP2_PRS_PORT_MASK);
> +	if (err)
> +		return err;
> +
> +	/* Single VLAN: 0x8100 */
> +	err = mvpp2_prs_vlan_add(priv, ETH_P_8021Q, MVPP2_PRS_SINGLE_VLAN_AI,
> +				 MVPP2_PRS_PORT_MASK);
> +	if (err)
> +		return err;
> +
> +	/* Set default double vlan entry */
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> +	pe.index = MVPP2_PE_VLAN_DBL;
> +
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VID);
> +
> +	/* Clear ai for next iterations */
> +	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_DOUBLE,
> +				 MVPP2_PRS_RI_VLAN_MASK);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_DBL_VLAN_AI_BIT,
> +				 MVPP2_PRS_DBL_VLAN_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Set default vlan none entry */
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
> +	pe.index = MVPP2_PE_VLAN_NONE;
> +
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_NONE,
> +				 MVPP2_PRS_RI_VLAN_MASK);
> +
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* Set entries for PPPoE ethertype */
> +static int mvpp2_prs_pppoe_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	/* IPv4 over PPPoE with options */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_PPPOE);
> +	pe.index = tid;
> +
> +	mvpp2_prs_match_etype(&pe, 0, PPP_IP);
> +
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP4_OPT,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +	/* Skip eth_type + 4 bytes of IP header */
> +	mvpp2_prs_sram_shift_set(&pe, MVPP2_ETH_TYPE_LEN + 4,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	/* Set L3 offset */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> +				  MVPP2_ETH_TYPE_LEN,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_PPPOE);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* IPv4 over PPPoE without options */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	pe.index = tid;
> +
> +	mvpp2_prs_tcam_data_byte_set(&pe, MVPP2_ETH_TYPE_LEN,
> +				     MVPP2_PRS_IPV4_HEAD | MVPP2_PRS_IPV4_IHL,
> +				     MVPP2_PRS_IPV4_HEAD_MASK |
> +				     MVPP2_PRS_IPV4_IHL_MASK);
> +
> +	/* Clear ri before updating */
> +	pe.sram.word[MVPP2_PRS_SRAM_RI_WORD] = 0x0;
> +	pe.sram.word[MVPP2_PRS_SRAM_RI_CTRL_WORD] = 0x0;
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP4,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_PPPOE);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* IPv6 over PPPoE */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_PPPOE);
> +	pe.index = tid;
> +
> +	mvpp2_prs_match_etype(&pe, 0, PPP_IPV6);
> +
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_IP6,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +	/* Skip eth_type + 4 bytes of IPv6 header */
> +	mvpp2_prs_sram_shift_set(&pe, MVPP2_ETH_TYPE_LEN + 4,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	/* Set L3 offset */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> +				  MVPP2_ETH_TYPE_LEN,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_PPPOE);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Non-IP over PPPoE */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_PPPOE);
> +	pe.index = tid;
> +
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UN,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK);
> +
> +	/* Finished: go to flowid generation */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	/* Set L3 offset even if it's unknown L3 */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L3,
> +				  MVPP2_ETH_TYPE_LEN,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_PPPOE);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* Initialize entries for IPv4 */
> +static int mvpp2_prs_ip4_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int err;
> +
> +	/* Set entries for TCP, UDP and IGMP over IPv4 */
> +	err = mvpp2_prs_ip4_proto(priv, IPPROTO_TCP, MVPP2_PRS_RI_L4_TCP,
> +				  MVPP2_PRS_RI_L4_PROTO_MASK);
> +	if (err)
> +		return err;
> +
> +	err = mvpp2_prs_ip4_proto(priv, IPPROTO_UDP, MVPP2_PRS_RI_L4_UDP,
> +				  MVPP2_PRS_RI_L4_PROTO_MASK);
> +	if (err)
> +		return err;
> +
> +	err = mvpp2_prs_ip4_proto(priv, IPPROTO_IGMP,
> +				  MVPP2_PRS_RI_CPU_CODE_RX_SPEC |
> +				  MVPP2_PRS_RI_UDF3_RX_SPECIAL,
> +				  MVPP2_PRS_RI_CPU_CODE_MASK |
> +				  MVPP2_PRS_RI_UDF3_MASK);
> +	if (err)
> +		return err;
> +
> +	/* IPv4 Broadcast */
> +	err = mvpp2_prs_ip4_cast(priv, MVPP2_PRS_L3_BROAD_CAST);
> +	if (err)
> +		return err;
> +
> +	/* IPv4 Multicast */
> +	err = mvpp2_prs_ip4_cast(priv, MVPP2_PRS_L3_MULTI_CAST);
> +	if (err)
> +		return err;
> +
> +	/* Default IPv4 entry for unknown protocols */
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP4);
> +	pe.index = MVPP2_PE_IP4_PROTO_UN;
> +
> +	/* Set next lu to IPv4 */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_sram_shift_set(&pe, 12, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +	/* Set L4 offset */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L4,
> +				  sizeof(struct iphdr) - 4,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +	mvpp2_prs_sram_ai_update(&pe, MVPP2_PRS_IPV4_DIP_AI_BIT,
> +				 MVPP2_PRS_IPV4_DIP_AI_BIT);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L4_OTHER,
> +				 MVPP2_PRS_RI_L4_PROTO_MASK);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_IPV4_DIP_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Default IPv4 entry for unicast address */
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP4);
> +	pe.index = MVPP2_PE_IP4_ADDR_UN;
> +
> +	/* Finished: go to flowid generation */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UCAST,
> +				 MVPP2_PRS_RI_L3_ADDR_MASK);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV4_DIP_AI_BIT,
> +				 MVPP2_PRS_IPV4_DIP_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* Initialize entries for IPv6 */
> +static int mvpp2_prs_ip6_init(struct mvpp2 *priv)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid, err;
> +
> +	/* Set entries for TCP, UDP and ICMP over IPv6 */
> +	err = mvpp2_prs_ip6_proto(priv, IPPROTO_TCP,
> +				  MVPP2_PRS_RI_L4_TCP,
> +				  MVPP2_PRS_RI_L4_PROTO_MASK);
> +	if (err)
> +		return err;
> +
> +	err = mvpp2_prs_ip6_proto(priv, IPPROTO_UDP,
> +				  MVPP2_PRS_RI_L4_UDP,
> +				  MVPP2_PRS_RI_L4_PROTO_MASK);
> +	if (err)
> +		return err;
> +
> +	err = mvpp2_prs_ip6_proto(priv, IPPROTO_ICMPV6,
> +				  MVPP2_PRS_RI_CPU_CODE_RX_SPEC |
> +				  MVPP2_PRS_RI_UDF3_RX_SPECIAL,
> +				  MVPP2_PRS_RI_CPU_CODE_MASK |
> +				  MVPP2_PRS_RI_UDF3_MASK);
> +	if (err)
> +		return err;
> +
> +	/* IPv4 is the last header. This is similar case as 6-TCP or 17-UDP */
> +	/* Result Info: UDF7=1, DS lite */
> +	err = mvpp2_prs_ip6_proto(priv, IPPROTO_IPIP,
> +				  MVPP2_PRS_RI_UDF7_IP6_LITE,
> +				  MVPP2_PRS_RI_UDF7_MASK);
> +	if (err)
> +		return err;
> +
> +	/* IPv6 multicast */
> +	err = mvpp2_prs_ip6_cast(priv, MVPP2_PRS_L3_MULTI_CAST);
> +	if (err)
> +		return err;
> +
> +	/* Entry for checking hop limit */
> +	tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
> +					MVPP2_PE_LAST_FREE_TID);
> +	if (tid < 0)
> +		return tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	pe.index = tid;
> +
> +	/* Finished: go to flowid generation */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UN |
> +				 MVPP2_PRS_RI_DROP_MASK,
> +				 MVPP2_PRS_RI_L3_PROTO_MASK |
> +				 MVPP2_PRS_RI_DROP_MASK);
> +
> +	mvpp2_prs_tcam_data_byte_set(&pe, 1, 0x00, MVPP2_PRS_IPV6_HOP_MASK);
> +	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> +				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Default IPv6 entry for unknown protocols */
> +	memset(&pe, 0, sizeof(pe));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	pe.index = MVPP2_PE_IP6_PROTO_UN;
> +
> +	/* Finished: go to flowid generation */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L4_OTHER,
> +				 MVPP2_PRS_RI_L4_PROTO_MASK);
> +	/* Set L4 offset relatively to our current place */
> +	mvpp2_prs_sram_offset_set(&pe, MVPP2_PRS_SRAM_UDF_TYPE_L4,
> +				  sizeof(struct ipv6hdr) - 4,
> +				  MVPP2_PRS_SRAM_OP_SEL_UDF_ADD);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> +				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Default IPv6 entry for unknown ext protocols */
> +	memset(&pe, 0, sizeof(struct mvpp2_prs_entry));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	pe.index = MVPP2_PE_IP6_EXT_PROTO_UN;
> +
> +	/* Finished: go to flowid generation */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_GEN_BIT, 1);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L4_OTHER,
> +				 MVPP2_PRS_RI_L4_PROTO_MASK);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, MVPP2_PRS_IPV6_EXT_AI_BIT,
> +				 MVPP2_PRS_IPV6_EXT_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP4);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	/* Default IPv6 entry for unicast address */
> +	memset(&pe, 0, sizeof(struct mvpp2_prs_entry));
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	pe.index = MVPP2_PE_IP6_ADDR_UN;
> +
> +	/* Finished: go to IPv6 again */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_IP6);
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_L3_UCAST,
> +				 MVPP2_PRS_RI_L3_ADDR_MASK);
> +	mvpp2_prs_sram_ai_update(&pe, MVPP2_PRS_IPV6_NO_EXT_AI_BIT,
> +				 MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> +	/* Shift back to IPV6 NH */
> +	mvpp2_prs_sram_shift_set(&pe, -18, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +	mvpp2_prs_tcam_ai_update(&pe, 0, MVPP2_PRS_IPV6_NO_EXT_AI_BIT);
> +	/* Unmask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
> +
> +	/* Update shadow table and hw entry */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_IP6);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* Find tcam entry with matched pair <vid,port> */
> +static int mvpp2_prs_vid_range_find(struct mvpp2 *priv, int pmap, u16 vid,
> +				    u16 mask)
> +{
> +	unsigned char byte[2], enable[2];
> +	struct mvpp2_prs_entry pe;
> +	u16 rvid, rmask;
> +	int tid;
> +
> +	/* Go through the all entries with MVPP2_PRS_LU_VID */
> +	for (tid = MVPP2_PE_VID_FILT_RANGE_START;
> +	     tid <= MVPP2_PE_VID_FILT_RANGE_END; tid++) {
> +		if (!priv->prs_shadow[tid].valid ||
> +		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VID)
> +			continue;
> +
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +
> +		mvpp2_prs_tcam_data_byte_get(&pe, 2, &byte[0], &enable[0]);
> +		mvpp2_prs_tcam_data_byte_get(&pe, 3, &byte[1], &enable[1]);
> +
> +		rvid = ((byte[0] & 0xf) << 8) + byte[1];
> +		rmask = ((enable[0] & 0xf) << 8) + enable[1];
> +
> +		if (rvid != vid || rmask != mask)
> +			continue;
> +
> +		return tid;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/* Write parser entry for VID filtering */
> +int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
> +{
> +	unsigned int vid_start = MVPP2_PE_VID_FILT_RANGE_START +
> +				 port->id * MVPP2_PRS_VLAN_FILT_MAX;
> +	unsigned int mask = 0xfff, reg_val, shift;
> +	struct mvpp2 *priv = port->priv;
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	/* Scan TCAM and see if entry with this <vid,port> already exist */
> +	tid = mvpp2_prs_vid_range_find(priv, (1 << port->id), vid, mask);
> +
> +	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
> +	if (reg_val & MVPP2_DSA_EXTENDED)
> +		shift = MVPP2_VLAN_TAG_EDSA_LEN;
> +	else
> +		shift = MVPP2_VLAN_TAG_LEN;
> +
> +	/* No such entry */
> +	if (tid < 0) {
> +
> +		/* Go through all entries from first to last in vlan range */
> +		tid = mvpp2_prs_tcam_first_free(priv, vid_start,
> +						vid_start +
> +						MVPP2_PRS_VLAN_FILT_MAX_ENTRY);
> +
> +		/* There isn't room for a new VID filter */
> +		if (tid < 0)
> +			return tid;
> +
> +		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
> +		pe.index = tid;
> +
> +		/* Mask all ports */
> +		mvpp2_prs_tcam_port_map_set(&pe, 0);
> +	} else {
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +	}
> +
> +	/* Enable the current port */
> +	mvpp2_prs_tcam_port_set(&pe, port->id, true);
> +
> +	/* Continue - set next lookup */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> +
> +	/* Skip VLAN header - Set offset to 4 or 8 bytes */
> +	mvpp2_prs_sram_shift_set(&pe, shift, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +	/* Set match on VID */
> +	mvpp2_prs_match_vid(&pe, MVPP2_PRS_VID_TCAM_BYTE, vid);
> +
> +	/* Clear all ai bits for next iteration */
> +	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> +
> +	/* Update shadow table */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +/* Write parser entry for VID filtering */
> +void mvpp2_prs_vid_entry_remove(struct mvpp2_port *port, u16 vid)
> +{
> +	struct mvpp2 *priv = port->priv;
> +	int tid;
> +
> +	/* Scan TCAM and see if entry with this <vid,port> already exist */
> +	tid = mvpp2_prs_vid_range_find(priv, (1 << port->id), vid, 0xfff);
> +
> +	/* No such entry */
> +	if (tid < 0)
> +		return;
> +
> +	mvpp2_prs_hw_inv(priv, tid);
> +	priv->prs_shadow[tid].valid = false;
> +}
> +
> +/* Remove all existing VID filters on this port */
> +void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
> +{
> +	struct mvpp2 *priv = port->priv;
> +	int tid;
> +
> +	for (tid = MVPP2_PRS_VID_PORT_FIRST(port->id);
> +	     tid <= MVPP2_PRS_VID_PORT_LAST(port->id); tid++) {
> +		if (priv->prs_shadow[tid].valid)
> +			mvpp2_prs_vid_entry_remove(port, tid);
> +	}
> +}
> +
> +/* Remove VID filering entry for this port */
> +void mvpp2_prs_vid_disable_filtering(struct mvpp2_port *port)
> +{
> +	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
> +	struct mvpp2 *priv = port->priv;
> +
> +	/* Invalidate the guard entry */
> +	mvpp2_prs_hw_inv(priv, tid);
> +
> +	priv->prs_shadow[tid].valid = false;
> +}
> +
> +/* Add guard entry that drops packets when no VID is matched on this port */
> +void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
> +{
> +	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
> +	struct mvpp2 *priv = port->priv;
> +	unsigned int reg_val, shift;
> +	struct mvpp2_prs_entry pe;
> +
> +	if (priv->prs_shadow[tid].valid)
> +		return;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	pe.index = tid;
> +
> +	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
> +	if (reg_val & MVPP2_DSA_EXTENDED)
> +		shift = MVPP2_VLAN_TAG_EDSA_LEN;
> +	else
> +		shift = MVPP2_VLAN_TAG_LEN;
> +
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
> +
> +	/* Mask all ports */
> +	mvpp2_prs_tcam_port_map_set(&pe, 0);
> +
> +	/* Update port mask */
> +	mvpp2_prs_tcam_port_set(&pe, port->id, true);
> +
> +	/* Continue - set next lookup */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_L2);
> +
> +	/* Skip VLAN header - Set offset to 4 or 8 bytes */
> +	mvpp2_prs_sram_shift_set(&pe, shift, MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +	/* Drop VLAN packets that don't belong to any VIDs on this port */
> +	mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_DROP_MASK,
> +				 MVPP2_PRS_RI_DROP_MASK);
> +
> +	/* Clear all ai bits for next iteration */
> +	mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
> +
> +	/* Update shadow table */
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
> +	mvpp2_prs_hw_write(priv, &pe);
> +}
> +
> +/* Parser default initialization */
> +int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
> +{
> +	int err, index, i;
> +
> +	/* Enable tcam table */
> +	mvpp2_write(priv, MVPP2_PRS_TCAM_CTRL_REG, MVPP2_PRS_TCAM_EN_MASK);
> +
> +	/* Clear all tcam and sram entries */
> +	for (index = 0; index < MVPP2_PRS_TCAM_SRAM_SIZE; index++) {
> +		mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, index);
> +		for (i = 0; i < MVPP2_PRS_TCAM_WORDS; i++)
> +			mvpp2_write(priv, MVPP2_PRS_TCAM_DATA_REG(i), 0);
> +
> +		mvpp2_write(priv, MVPP2_PRS_SRAM_IDX_REG, index);
> +		for (i = 0; i < MVPP2_PRS_SRAM_WORDS; i++)
> +			mvpp2_write(priv, MVPP2_PRS_SRAM_DATA_REG(i), 0);
> +	}
> +
> +	/* Invalidate all tcam entries */
> +	for (index = 0; index < MVPP2_PRS_TCAM_SRAM_SIZE; index++)
> +		mvpp2_prs_hw_inv(priv, index);
> +
> +	priv->prs_shadow = devm_kcalloc(&pdev->dev, MVPP2_PRS_TCAM_SRAM_SIZE,
> +					sizeof(*priv->prs_shadow),
> +					GFP_KERNEL);
> +	if (!priv->prs_shadow)
> +		return -ENOMEM;
> +
> +	/* Always start from lookup = 0 */
> +	for (index = 0; index < MVPP2_MAX_PORTS; index++)
> +		mvpp2_prs_hw_port_init(priv, index, MVPP2_PRS_LU_MH,
> +				       MVPP2_PRS_PORT_LU_MAX, 0);
> +
> +	mvpp2_prs_def_flow_init(priv);
> +
> +	mvpp2_prs_mh_init(priv);
> +
> +	mvpp2_prs_mac_init(priv);
> +
> +	mvpp2_prs_dsa_init(priv);
> +
> +	mvpp2_prs_vid_init(priv);
> +
> +	err = mvpp2_prs_etype_init(priv);
> +	if (err)
> +		return err;
> +
> +	err = mvpp2_prs_vlan_init(pdev, priv);
> +	if (err)
> +		return err;
> +
> +	err = mvpp2_prs_pppoe_init(priv);
> +	if (err)
> +		return err;
> +
> +	err = mvpp2_prs_ip6_init(priv);
> +	if (err)
> +		return err;
> +
> +	err = mvpp2_prs_ip4_init(priv);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +/* Compare MAC DA with tcam entry data */
> +static bool mvpp2_prs_mac_range_equals(struct mvpp2_prs_entry *pe,
> +				       const u8 *da, unsigned char *mask)
> +{
> +	unsigned char tcam_byte, tcam_mask;
> +	int index;
> +
> +	for (index = 0; index < ETH_ALEN; index++) {
> +		mvpp2_prs_tcam_data_byte_get(pe, index, &tcam_byte, &tcam_mask);
> +		if (tcam_mask != mask[index])
> +			return false;
> +
> +		if ((tcam_mask & tcam_byte) != (da[index] & mask[index]))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* Find tcam entry with matched pair <MAC DA, port> */
> +static int
> +mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
> +			    unsigned char *mask, int udf_type)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	/* Go through the all entires with MVPP2_PRS_LU_MAC */
> +	for (tid = MVPP2_PE_MAC_RANGE_START;
> +	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
> +		unsigned int entry_pmap;
> +
> +		if (!priv->prs_shadow[tid].valid ||
> +		    (priv->prs_shadow[tid].lu != MVPP2_PRS_LU_MAC) ||
> +		    (priv->prs_shadow[tid].udf != udf_type))
> +			continue;
> +
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +		entry_pmap = mvpp2_prs_tcam_port_map_get(&pe);
> +
> +		if (mvpp2_prs_mac_range_equals(&pe, da, mask) &&
> +		    entry_pmap == pmap)
> +			return tid;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/* Update parser's mac da entry */
> +int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
> +{
> +	unsigned char mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> +	struct mvpp2 *priv = port->priv;
> +	unsigned int pmap, len, ri;
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	/* Scan TCAM and see if entry with this <MAC DA, port> already exist */
> +	tid = mvpp2_prs_mac_da_range_find(priv, BIT(port->id), da, mask,
> +					  MVPP2_PRS_UDF_MAC_DEF);
> +
> +	/* No such entry */
> +	if (tid < 0) {
> +		if (!add)
> +			return 0;
> +
> +		/* Create new TCAM entry */
> +		/* Go through the all entries from first to last */
> +		tid = mvpp2_prs_tcam_first_free(priv,
> +						MVPP2_PE_MAC_RANGE_START,
> +						MVPP2_PE_MAC_RANGE_END);
> +		if (tid < 0)
> +			return tid;
> +
> +		pe.index = tid;
> +
> +		/* Mask all ports */
> +		mvpp2_prs_tcam_port_map_set(&pe, 0);
> +	} else {
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +	}
> +
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
> +
> +	/* Update port mask */
> +	mvpp2_prs_tcam_port_set(&pe, port->id, add);
> +
> +	/* Invalidate the entry if no ports are left enabled */
> +	pmap = mvpp2_prs_tcam_port_map_get(&pe);
> +	if (pmap == 0) {
> +		if (add)
> +			return -EINVAL;
> +
> +		mvpp2_prs_hw_inv(priv, pe.index);
> +		priv->prs_shadow[pe.index].valid = false;
> +		return 0;
> +	}
> +
> +	/* Continue - set next lookup */
> +	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_DSA);
> +
> +	/* Set match on DA */
> +	len = ETH_ALEN;
> +	while (len--)
> +		mvpp2_prs_tcam_data_byte_set(&pe, len, da[len], 0xff);
> +
> +	/* Set result info bits */
> +	if (is_broadcast_ether_addr(da)) {
> +		ri = MVPP2_PRS_RI_L2_BCAST;
> +	} else if (is_multicast_ether_addr(da)) {
> +		ri = MVPP2_PRS_RI_L2_MCAST;
> +	} else {
> +		ri = MVPP2_PRS_RI_L2_UCAST;
> +
> +		if (ether_addr_equal(da, port->dev->dev_addr))
> +			ri |= MVPP2_PRS_RI_MAC_ME_MASK;
> +	}
> +
> +	mvpp2_prs_sram_ri_update(&pe, ri, MVPP2_PRS_RI_L2_CAST_MASK |
> +				 MVPP2_PRS_RI_MAC_ME_MASK);
> +	mvpp2_prs_shadow_ri_set(priv, pe.index, ri, MVPP2_PRS_RI_L2_CAST_MASK |
> +				MVPP2_PRS_RI_MAC_ME_MASK);
> +
> +	/* Shift to ethertype */
> +	mvpp2_prs_sram_shift_set(&pe, 2 * ETH_ALEN,
> +				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
> +
> +	/* Update shadow table and hw entry */
> +	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_MAC_DEF;
> +	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
> +	mvpp2_prs_hw_write(priv, &pe);
> +
> +	return 0;
> +}
> +
> +int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da)
> +{
> +	struct mvpp2_port *port = netdev_priv(dev);
> +	int err;
> +
> +	/* Remove old parser entry */
> +	err = mvpp2_prs_mac_da_accept(port, dev->dev_addr, false);
> +	if (err)
> +		return err;
> +
> +	/* Add new parser entry */
> +	err = mvpp2_prs_mac_da_accept(port, da, true);
> +	if (err)
> +		return err;
> +
> +	/* Set addr in the device */
> +	ether_addr_copy(dev->dev_addr, da);
> +
> +	return 0;
> +}
> +
> +void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
> +{
> +	struct mvpp2 *priv = port->priv;
> +	struct mvpp2_prs_entry pe;
> +	unsigned long pmap;
> +	int index, tid;
> +
> +	for (tid = MVPP2_PE_MAC_RANGE_START;
> +	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
> +		unsigned char da[ETH_ALEN], da_mask[ETH_ALEN];
> +
> +		if (!priv->prs_shadow[tid].valid ||
> +		    (priv->prs_shadow[tid].lu != MVPP2_PRS_LU_MAC) ||
> +		    (priv->prs_shadow[tid].udf != MVPP2_PRS_UDF_MAC_DEF))
> +			continue;
> +
> +		mvpp2_prs_init_from_hw(priv, &pe, tid);
> +
> +		pmap = mvpp2_prs_tcam_port_map_get(&pe);
> +
> +		/* We only want entries active on this port */
> +		if (!test_bit(port->id, &pmap))
> +			continue;
> +
> +		/* Read mac addr from entry */
> +		for (index = 0; index < ETH_ALEN; index++)
> +			mvpp2_prs_tcam_data_byte_get(&pe, index, &da[index],
> +						     &da_mask[index]);
> +
> +		/* Special cases : Don't remove broadcast and port's own
> +		 * address
> +		 */
> +		if (is_broadcast_ether_addr(da) ||
> +		    ether_addr_equal(da, port->dev->dev_addr))
> +			continue;
> +
> +		/* Remove entry from TCAM */
> +		mvpp2_prs_mac_da_accept(port, da, false);
> +	}
> +}
> +
> +int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
> +{
> +	switch (type) {
> +	case MVPP2_TAG_TYPE_EDSA:
> +		/* Add port to EDSA entries */
> +		mvpp2_prs_dsa_tag_set(priv, port, true,
> +				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> +		mvpp2_prs_dsa_tag_set(priv, port, true,
> +				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> +		/* Remove port from DSA entries */
> +		mvpp2_prs_dsa_tag_set(priv, port, false,
> +				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> +		mvpp2_prs_dsa_tag_set(priv, port, false,
> +				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> +		break;
> +
> +	case MVPP2_TAG_TYPE_DSA:
> +		/* Add port to DSA entries */
> +		mvpp2_prs_dsa_tag_set(priv, port, true,
> +				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> +		mvpp2_prs_dsa_tag_set(priv, port, true,
> +				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> +		/* Remove port from EDSA entries */
> +		mvpp2_prs_dsa_tag_set(priv, port, false,
> +				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> +		mvpp2_prs_dsa_tag_set(priv, port, false,
> +				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> +		break;
> +
> +	case MVPP2_TAG_TYPE_MH:
> +	case MVPP2_TAG_TYPE_NONE:
> +		/* Remove port form EDSA and DSA entries */
> +		mvpp2_prs_dsa_tag_set(priv, port, false,
> +				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
> +		mvpp2_prs_dsa_tag_set(priv, port, false,
> +				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> +		mvpp2_prs_dsa_tag_set(priv, port, false,
> +				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
> +		mvpp2_prs_dsa_tag_set(priv, port, false,
> +				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> +		break;
> +
> +	default:
> +		if ((type < 0) || (type > MVPP2_TAG_TYPE_EDSA))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Set prs flow for the port */
> +int mvpp2_prs_def_flow(struct mvpp2_port *port)
> +{
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +
> +	memset(&pe, 0, sizeof(pe));
> +
> +	tid = mvpp2_prs_flow_find(port->priv, port->id);
> +
> +	/* Such entry not exist */
> +	if (tid < 0) {
> +		/* Go through the all entires from last to first */
> +		tid = mvpp2_prs_tcam_first_free(port->priv,
> +						MVPP2_PE_LAST_FREE_TID,
> +					       MVPP2_PE_FIRST_FREE_TID);
> +		if (tid < 0)
> +			return tid;
> +
> +		pe.index = tid;
> +
> +		/* Set flow ID*/
> +		mvpp2_prs_sram_ai_update(&pe, port->id, MVPP2_PRS_FLOW_ID_MASK);
> +		mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_DONE_BIT, 1);
> +
> +		/* Update shadow table */
> +		mvpp2_prs_shadow_set(port->priv, pe.index, MVPP2_PRS_LU_FLOWS);
> +	} else {
> +		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
> +	}
> +
> +	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
> +	mvpp2_prs_tcam_port_map_set(&pe, (1 << port->id));
> +	mvpp2_prs_hw_write(port->priv, &pe);
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
> new file mode 100644
> index 000000000000..22fbbc4c8b28
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
> @@ -0,0 +1,314 @@
> +/*
> + * Header Parser definitions for Marvell PPv2 Network Controller
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Marcin Wojtas <mw@semihalf.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +
> +#include "mvpp2.h"
> +
> +#ifndef _MVPP2_PRS_H_
> +#define _MVPP2_PRS_H_
> +
> +/* Parser constants */
> +#define MVPP2_PRS_TCAM_SRAM_SIZE	256
> +#define MVPP2_PRS_TCAM_WORDS		6
> +#define MVPP2_PRS_SRAM_WORDS		4
> +#define MVPP2_PRS_FLOW_ID_SIZE		64
> +#define MVPP2_PRS_FLOW_ID_MASK		0x3f
> +#define MVPP2_PRS_TCAM_ENTRY_INVALID	1
> +#define MVPP2_PRS_TCAM_DSA_TAGGED_BIT	BIT(5)
> +#define MVPP2_PRS_IPV4_HEAD		0x40
> +#define MVPP2_PRS_IPV4_HEAD_MASK	0xf0
> +#define MVPP2_PRS_IPV4_MC		0xe0
> +#define MVPP2_PRS_IPV4_MC_MASK		0xf0
> +#define MVPP2_PRS_IPV4_BC_MASK		0xff
> +#define MVPP2_PRS_IPV4_IHL		0x5
> +#define MVPP2_PRS_IPV4_IHL_MASK		0xf
> +#define MVPP2_PRS_IPV6_MC		0xff
> +#define MVPP2_PRS_IPV6_MC_MASK		0xff
> +#define MVPP2_PRS_IPV6_HOP_MASK		0xff
> +#define MVPP2_PRS_TCAM_PROTO_MASK	0xff
> +#define MVPP2_PRS_TCAM_PROTO_MASK_L	0x3f
> +#define MVPP2_PRS_DBL_VLANS_MAX		100
> +#define MVPP2_PRS_CAST_MASK		BIT(0)
> +#define MVPP2_PRS_MCAST_VAL		BIT(0)
> +#define MVPP2_PRS_UCAST_VAL		0x0
> +
> +/* Tcam structure:
> + * - lookup ID - 4 bits
> + * - port ID - 1 byte
> + * - additional information - 1 byte
> + * - header data - 8 bytes
> + * The fields are represented by MVPP2_PRS_TCAM_DATA_REG(5)->(0).
> + */
> +#define MVPP2_PRS_AI_BITS			8
> +#define MVPP2_PRS_PORT_MASK			0xff
> +#define MVPP2_PRS_LU_MASK			0xf
> +#define MVPP2_PRS_TCAM_DATA_BYTE(offs)		\
> +				    (((offs) - ((offs) % 2)) * 2 + ((offs) % 2))
> +#define MVPP2_PRS_TCAM_DATA_BYTE_EN(offs)	\
> +					      (((offs) * 2) - ((offs) % 2)  + 2)
> +#define MVPP2_PRS_TCAM_AI_BYTE			16
> +#define MVPP2_PRS_TCAM_PORT_BYTE		17
> +#define MVPP2_PRS_TCAM_LU_BYTE			20
> +#define MVPP2_PRS_TCAM_EN_OFFS(offs)		((offs) + 2)
> +#define MVPP2_PRS_TCAM_INV_WORD			5
> +
> +#define MVPP2_PRS_VID_TCAM_BYTE         2
> +
> +/* TCAM range for unicast and multicast filtering. We have 25 entries per port,
> + * with 4 dedicated to UC filtering and the rest to multicast filtering.
> + * Additionnally we reserve one entry for the broadcast address, and one for
> + * each port's own address.
> + */
> +#define MVPP2_PRS_MAC_UC_MC_FILT_MAX	25
> +#define MVPP2_PRS_MAC_RANGE_SIZE	80
> +
> +/* Number of entries per port dedicated to UC and MC filtering */
> +#define MVPP2_PRS_MAC_UC_FILT_MAX	4
> +#define MVPP2_PRS_MAC_MC_FILT_MAX	(MVPP2_PRS_MAC_UC_MC_FILT_MAX - \
> +					 MVPP2_PRS_MAC_UC_FILT_MAX)
> +
> +/* There is a TCAM range reserved for VLAN filtering entries, range size is 33
> + * 10 VLAN ID filter entries per port
> + * 1 default VLAN filter entry per port
> + * It is assumed that there are 3 ports for filter, not including loopback port
> + */
> +#define MVPP2_PRS_VLAN_FILT_MAX		11
> +#define MVPP2_PRS_VLAN_FILT_RANGE_SIZE	33
> +
> +#define MVPP2_PRS_VLAN_FILT_MAX_ENTRY   (MVPP2_PRS_VLAN_FILT_MAX - 2)
> +#define MVPP2_PRS_VLAN_FILT_DFLT_ENTRY  (MVPP2_PRS_VLAN_FILT_MAX - 1)
> +
> +/* Tcam entries ID */
> +#define MVPP2_PE_DROP_ALL		0
> +#define MVPP2_PE_FIRST_FREE_TID		1
> +
> +/* MAC filtering range */
> +#define MVPP2_PE_MAC_RANGE_END		(MVPP2_PE_VID_FILT_RANGE_START - 1)
> +#define MVPP2_PE_MAC_RANGE_START	(MVPP2_PE_MAC_RANGE_END - \
> +						MVPP2_PRS_MAC_RANGE_SIZE + 1)
> +/* VLAN filtering range */
> +#define MVPP2_PE_VID_FILT_RANGE_END     (MVPP2_PRS_TCAM_SRAM_SIZE - 31)
> +#define MVPP2_PE_VID_FILT_RANGE_START   (MVPP2_PE_VID_FILT_RANGE_END - \
> +					 MVPP2_PRS_VLAN_FILT_RANGE_SIZE + 1)
> +#define MVPP2_PE_LAST_FREE_TID          (MVPP2_PE_MAC_RANGE_START - 1)
> +#define MVPP2_PE_IP6_EXT_PROTO_UN	(MVPP2_PRS_TCAM_SRAM_SIZE - 30)
> +#define MVPP2_PE_IP6_ADDR_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 29)
> +#define MVPP2_PE_IP4_ADDR_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 28)
> +#define MVPP2_PE_LAST_DEFAULT_FLOW	(MVPP2_PRS_TCAM_SRAM_SIZE - 27)
> +#define MVPP2_PE_FIRST_DEFAULT_FLOW	(MVPP2_PRS_TCAM_SRAM_SIZE - 22)
> +#define MVPP2_PE_EDSA_TAGGED		(MVPP2_PRS_TCAM_SRAM_SIZE - 21)
> +#define MVPP2_PE_EDSA_UNTAGGED		(MVPP2_PRS_TCAM_SRAM_SIZE - 20)
> +#define MVPP2_PE_DSA_TAGGED		(MVPP2_PRS_TCAM_SRAM_SIZE - 19)
> +#define MVPP2_PE_DSA_UNTAGGED		(MVPP2_PRS_TCAM_SRAM_SIZE - 18)
> +#define MVPP2_PE_ETYPE_EDSA_TAGGED	(MVPP2_PRS_TCAM_SRAM_SIZE - 17)
> +#define MVPP2_PE_ETYPE_EDSA_UNTAGGED	(MVPP2_PRS_TCAM_SRAM_SIZE - 16)
> +#define MVPP2_PE_ETYPE_DSA_TAGGED	(MVPP2_PRS_TCAM_SRAM_SIZE - 15)
> +#define MVPP2_PE_ETYPE_DSA_UNTAGGED	(MVPP2_PRS_TCAM_SRAM_SIZE - 14)
> +#define MVPP2_PE_MH_DEFAULT		(MVPP2_PRS_TCAM_SRAM_SIZE - 13)
> +#define MVPP2_PE_DSA_DEFAULT		(MVPP2_PRS_TCAM_SRAM_SIZE - 12)
> +#define MVPP2_PE_IP6_PROTO_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 11)
> +#define MVPP2_PE_IP4_PROTO_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 10)
> +#define MVPP2_PE_ETH_TYPE_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 9)
> +#define MVPP2_PE_VID_FLTR_DEFAULT	(MVPP2_PRS_TCAM_SRAM_SIZE - 8)
> +#define MVPP2_PE_VID_EDSA_FLTR_DEFAULT	(MVPP2_PRS_TCAM_SRAM_SIZE - 7)
> +#define MVPP2_PE_VLAN_DBL		(MVPP2_PRS_TCAM_SRAM_SIZE - 6)
> +#define MVPP2_PE_VLAN_NONE		(MVPP2_PRS_TCAM_SRAM_SIZE - 5)
> +/* reserved */
> +#define MVPP2_PE_MAC_MC_PROMISCUOUS	(MVPP2_PRS_TCAM_SRAM_SIZE - 3)
> +#define MVPP2_PE_MAC_UC_PROMISCUOUS	(MVPP2_PRS_TCAM_SRAM_SIZE - 2)
> +#define MVPP2_PE_MAC_NON_PROMISCUOUS	(MVPP2_PRS_TCAM_SRAM_SIZE - 1)
> +
> +#define MVPP2_PRS_VID_PORT_FIRST(port)	(MVPP2_PE_VID_FILT_RANGE_START + \
> +					 ((port) * MVPP2_PRS_VLAN_FILT_MAX))
> +#define MVPP2_PRS_VID_PORT_LAST(port)	(MVPP2_PRS_VID_PORT_FIRST(port) \
> +					 + MVPP2_PRS_VLAN_FILT_MAX_ENTRY)
> +/* Index of default vid filter for given port */
> +#define MVPP2_PRS_VID_PORT_DFLT(port)	(MVPP2_PRS_VID_PORT_FIRST(port) \
> +					 + MVPP2_PRS_VLAN_FILT_DFLT_ENTRY)
> +
> +/* Sram structure
> + * The fields are represented by MVPP2_PRS_TCAM_DATA_REG(3)->(0).
> + */
> +#define MVPP2_PRS_SRAM_RI_OFFS			0
> +#define MVPP2_PRS_SRAM_RI_WORD			0
> +#define MVPP2_PRS_SRAM_RI_CTRL_OFFS		32
> +#define MVPP2_PRS_SRAM_RI_CTRL_WORD		1
> +#define MVPP2_PRS_SRAM_RI_CTRL_BITS		32
> +#define MVPP2_PRS_SRAM_SHIFT_OFFS		64
> +#define MVPP2_PRS_SRAM_SHIFT_SIGN_BIT		72
> +#define MVPP2_PRS_SRAM_UDF_OFFS			73
> +#define MVPP2_PRS_SRAM_UDF_BITS			8
> +#define MVPP2_PRS_SRAM_UDF_MASK			0xff
> +#define MVPP2_PRS_SRAM_UDF_SIGN_BIT		81
> +#define MVPP2_PRS_SRAM_UDF_TYPE_OFFS		82
> +#define MVPP2_PRS_SRAM_UDF_TYPE_MASK		0x7
> +#define MVPP2_PRS_SRAM_UDF_TYPE_L3		1
> +#define MVPP2_PRS_SRAM_UDF_TYPE_L4		4
> +#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_OFFS	85
> +#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_MASK	0x3
> +#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD		1
> +#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_IP4_ADD	2
> +#define MVPP2_PRS_SRAM_OP_SEL_SHIFT_IP6_ADD	3
> +#define MVPP2_PRS_SRAM_OP_SEL_UDF_OFFS		87
> +#define MVPP2_PRS_SRAM_OP_SEL_UDF_BITS		2
> +#define MVPP2_PRS_SRAM_OP_SEL_UDF_MASK		0x3
> +#define MVPP2_PRS_SRAM_OP_SEL_UDF_ADD		0
> +#define MVPP2_PRS_SRAM_OP_SEL_UDF_IP4_ADD	2
> +#define MVPP2_PRS_SRAM_OP_SEL_UDF_IP6_ADD	3
> +#define MVPP2_PRS_SRAM_OP_SEL_BASE_OFFS		89
> +#define MVPP2_PRS_SRAM_AI_OFFS			90
> +#define MVPP2_PRS_SRAM_AI_CTRL_OFFS		98
> +#define MVPP2_PRS_SRAM_AI_CTRL_BITS		8
> +#define MVPP2_PRS_SRAM_AI_MASK			0xff
> +#define MVPP2_PRS_SRAM_NEXT_LU_OFFS		106
> +#define MVPP2_PRS_SRAM_NEXT_LU_MASK		0xf
> +#define MVPP2_PRS_SRAM_LU_DONE_BIT		110
> +#define MVPP2_PRS_SRAM_LU_GEN_BIT		111
> +
> +/* Sram result info bits assignment */
> +#define MVPP2_PRS_RI_MAC_ME_MASK		0x1
> +#define MVPP2_PRS_RI_DSA_MASK			0x2
> +#define MVPP2_PRS_RI_VLAN_MASK			(BIT(2) | BIT(3))
> +#define MVPP2_PRS_RI_VLAN_NONE			0x0
> +#define MVPP2_PRS_RI_VLAN_SINGLE		BIT(2)
> +#define MVPP2_PRS_RI_VLAN_DOUBLE		BIT(3)
> +#define MVPP2_PRS_RI_VLAN_TRIPLE		(BIT(2) | BIT(3))
> +#define MVPP2_PRS_RI_CPU_CODE_MASK		0x70
> +#define MVPP2_PRS_RI_CPU_CODE_RX_SPEC		BIT(4)
> +#define MVPP2_PRS_RI_L2_CAST_MASK		(BIT(9) | BIT(10))
> +#define MVPP2_PRS_RI_L2_UCAST			0x0
> +#define MVPP2_PRS_RI_L2_MCAST			BIT(9)
> +#define MVPP2_PRS_RI_L2_BCAST			BIT(10)
> +#define MVPP2_PRS_RI_PPPOE_MASK			0x800
> +#define MVPP2_PRS_RI_L3_PROTO_MASK		(BIT(12) | BIT(13) | BIT(14))
> +#define MVPP2_PRS_RI_L3_UN			0x0
> +#define MVPP2_PRS_RI_L3_IP4			BIT(12)
> +#define MVPP2_PRS_RI_L3_IP4_OPT			BIT(13)
> +#define MVPP2_PRS_RI_L3_IP4_OTHER		(BIT(12) | BIT(13))
> +#define MVPP2_PRS_RI_L3_IP6			BIT(14)
> +#define MVPP2_PRS_RI_L3_IP6_EXT			(BIT(12) | BIT(14))
> +#define MVPP2_PRS_RI_L3_ARP			(BIT(13) | BIT(14))
> +#define MVPP2_PRS_RI_L3_ADDR_MASK		(BIT(15) | BIT(16))
> +#define MVPP2_PRS_RI_L3_UCAST			0x0
> +#define MVPP2_PRS_RI_L3_MCAST			BIT(15)
> +#define MVPP2_PRS_RI_L3_BCAST			(BIT(15) | BIT(16))
> +#define MVPP2_PRS_RI_IP_FRAG_MASK		0x20000
> +#define MVPP2_PRS_RI_IP_FRAG_TRUE		BIT(17)
> +#define MVPP2_PRS_RI_UDF3_MASK			0x300000
> +#define MVPP2_PRS_RI_UDF3_RX_SPECIAL		BIT(21)
> +#define MVPP2_PRS_RI_L4_PROTO_MASK		0x1c00000
> +#define MVPP2_PRS_RI_L4_TCP			BIT(22)
> +#define MVPP2_PRS_RI_L4_UDP			BIT(23)
> +#define MVPP2_PRS_RI_L4_OTHER			(BIT(22) | BIT(23))
> +#define MVPP2_PRS_RI_UDF7_MASK			0x60000000
> +#define MVPP2_PRS_RI_UDF7_IP6_LITE		BIT(29)
> +#define MVPP2_PRS_RI_DROP_MASK			0x80000000
> +
> +/* Sram additional info bits assignment */
> +#define MVPP2_PRS_IPV4_DIP_AI_BIT		BIT(0)
> +#define MVPP2_PRS_IPV6_NO_EXT_AI_BIT		BIT(0)
> +#define MVPP2_PRS_IPV6_EXT_AI_BIT		BIT(1)
> +#define MVPP2_PRS_IPV6_EXT_AH_AI_BIT		BIT(2)
> +#define MVPP2_PRS_IPV6_EXT_AH_LEN_AI_BIT	BIT(3)
> +#define MVPP2_PRS_IPV6_EXT_AH_L4_AI_BIT		BIT(4)
> +#define MVPP2_PRS_SINGLE_VLAN_AI		0
> +#define MVPP2_PRS_DBL_VLAN_AI_BIT		BIT(7)
> +#define MVPP2_PRS_EDSA_VID_AI_BIT		BIT(0)
> +
> +/* DSA/EDSA type */
> +#define MVPP2_PRS_TAGGED		true
> +#define MVPP2_PRS_UNTAGGED		false
> +#define MVPP2_PRS_EDSA			true
> +#define MVPP2_PRS_DSA			false
> +
> +/* MAC entries, shadow udf */
> +enum mvpp2_prs_udf {
> +	MVPP2_PRS_UDF_MAC_DEF,
> +	MVPP2_PRS_UDF_MAC_RANGE,
> +	MVPP2_PRS_UDF_L2_DEF,
> +	MVPP2_PRS_UDF_L2_DEF_COPY,
> +	MVPP2_PRS_UDF_L2_USER,
> +};
> +
> +/* Lookup ID */
> +enum mvpp2_prs_lookup {
> +	MVPP2_PRS_LU_MH,
> +	MVPP2_PRS_LU_MAC,
> +	MVPP2_PRS_LU_DSA,
> +	MVPP2_PRS_LU_VLAN,
> +	MVPP2_PRS_LU_VID,
> +	MVPP2_PRS_LU_L2,
> +	MVPP2_PRS_LU_PPPOE,
> +	MVPP2_PRS_LU_IP4,
> +	MVPP2_PRS_LU_IP6,
> +	MVPP2_PRS_LU_FLOWS,
> +	MVPP2_PRS_LU_LAST,
> +};
> +
> +union mvpp2_prs_tcam_entry {
> +	u32 word[MVPP2_PRS_TCAM_WORDS];
> +	u8  byte[MVPP2_PRS_TCAM_WORDS * 4];
> +};
> +
> +union mvpp2_prs_sram_entry {
> +	u32 word[MVPP2_PRS_SRAM_WORDS];
> +	u8  byte[MVPP2_PRS_SRAM_WORDS * 4];
> +};
> +
> +struct mvpp2_prs_entry {
> +	u32 index;
> +	union mvpp2_prs_tcam_entry tcam;
> +	union mvpp2_prs_sram_entry sram;
> +};
> +
> +struct mvpp2_prs_shadow {
> +	bool valid;
> +	bool finish;
> +
> +	/* Lookup ID */
> +	int lu;
> +
> +	/* User defined offset */
> +	int udf;
> +
> +	/* Result info */
> +	u32 ri;
> +	u32 ri_mask;
> +};
> +
> +int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv);
> +
> +int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add);
> +
> +int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type);
> +
> +int mvpp2_prs_def_flow(struct mvpp2_port *port);
> +
> +void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port);
> +
> +void mvpp2_prs_vid_disable_filtering(struct mvpp2_port *port);
> +
> +int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid);
> +
> +void mvpp2_prs_vid_entry_remove(struct mvpp2_port *port, u16 vid);
> +
> +void mvpp2_prs_vid_remove_all(struct mvpp2_port *port);
> +
> +void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
> +			       enum mvpp2_prs_l2_cast l2_cast, bool add);
> +
> +void mvpp2_prs_mac_del_all(struct mvpp2_port *port);
> +
> +int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da);
> +
> +#endif
> -- 
> 2.11.0
> 

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
