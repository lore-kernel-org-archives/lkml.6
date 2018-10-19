Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D589ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA5D21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA5D21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJSPeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:34:13 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:23115 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:34:13 -0400
Received: from [10.28.18.51] (10.28.18.51) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 19 Oct
 2018 15:29:05 +0800
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <linux-mtd@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
 <20181018213308.3f8a5279@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <09f76f17-05c4-d9e0-0167-f68e224f00c4@amlogic.com>
Date:   Fri, 19 Oct 2018 15:29:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018213308.3f8a5279@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.51]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/19 3:33, Boris Brezillon wrote:
> On Thu, 18 Oct 2018 13:09:05 +0800
> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> 
>> From: Liang Yang <liang.yang@amlogic.com>
>>
>> Add initial support for the Amlogic NAND flash controller which found
>> in the Meson-GXBB/GXL/AXG SoCs.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>   drivers/mtd/nand/raw/Kconfig      |   10 +
>>   drivers/mtd/nand/raw/Makefile     |    1 +
>>   drivers/mtd/nand/raw/meson_nand.c | 1370 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1381 insertions(+)
>>   create mode 100644 drivers/mtd/nand/raw/meson_nand.c
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index c7efc31..223b041 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -541,4 +541,14 @@ config MTD_NAND_TEGRA
>>   	  is supported. Extra OOB bytes when using HW ECC are currently
>>   	  not supported.
>>   
>> +config MTD_NAND_MESON
>> +	tristate "Support for NAND controller on Amlogic's Meson SoCs"
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	depends on COMMON_CLK_AMLOGIC
>> +	select COMMON_CLK_REGMAP_MESON
>> +	select MFD_SYSCON
>> +	help
>> +	  Enables support for NAND controller on Amlogic's Meson SoCs.
>> +	  This controller is found on Meson GXBB, GXL, AXG SoCs.
>> +
>>   endif # MTD_NAND
>> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
>> index 57159b3..a2cc2fe 100644
>> --- a/drivers/mtd/nand/raw/Makefile
>> +++ b/drivers/mtd/nand/raw/Makefile
>> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>>   obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>>   obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
>>   obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
>> +obj-$(CONFIG_MTD_NAND_MESON)		+= meson_nand.o
>>   
>>   nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
>>   nand-objs += nand_onfi.o
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> new file mode 100644
>> index 0000000..bcaac53
>> --- /dev/null
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -0,0 +1,1370 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Amlogic Meson Nand Flash Controller Driver
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Liang Yang <liang.yang@amlogic.com>
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/clk.h>
>> +#include <linux/mtd/rawnand.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +
>> +#define NFC_REG_CMD		0x00
>> +#define NFC_CMD_DRD		(0x8 << 14)
>> +#define NFC_CMD_IDLE		(0xc << 14)
>> +#define NFC_CMD_DWR		(0x4 << 14)
>> +#define NFC_CMD_CLE		(0x5 << 14)
>> +#define NFC_CMD_ALE		(0x6 << 14)
>> +#define NFC_CMD_ADL		((0 << 16) | (3 << 20))
>> +#define NFC_CMD_ADH		((1 << 16) | (3 << 20))
>> +#define NFC_CMD_AIL		((2 << 16) | (3 << 20))
>> +#define NFC_CMD_AIH		((3 << 16) | (3 << 20))
>> +#define NFC_CMD_SEED		((8 << 16) | (3 << 20))
>> +#define NFC_CMD_M2N		((0 << 17) | (2 << 20))
>> +#define NFC_CMD_N2M		((1 << 17) | (2 << 20))
>> +#define NFC_CMD_RB		BIT(20)
>> +#define NFC_CMD_IO6		((0xb << 10) | (1 << 18))
>> +
>> +#define NFC_REG_CFG		0x04
>> +#define NFC_REG_DADR		0x08
>> +#define NFC_REG_IADR		0x0c
>> +#define NFC_REG_BUF		0x10
>> +#define NFC_REG_INFO		0x14
>> +#define NFC_REG_DC		0x18
>> +#define NFC_REG_ADR		0x1c
>> +#define NFC_REG_DL		0x20
>> +#define NFC_REG_DH		0x24
>> +#define NFC_REG_CADR		0x28
>> +#define NFC_REG_SADR		0x2c
>> +#define NFC_REG_PINS		0x30
>> +#define NFC_REG_VER		0x38
>> +
>> +#define NFC_RB_IRQ_EN		BIT(21)
>> +#define NFC_INT_MASK		(3 << 20)
>> +
>> +#define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)	\
>> +	(								\
>> +		(cmd_dir)			|			\
>> +		((ran) << 19)			|			\
>> +		((bch) << 14)			|			\
>> +		((short_mode) << 13)		|			\
>> +		(((page_size) & 0x7f) << 6)	|			\
>> +		((pages) & 0x3f)					\
>> +	)
>> +
>> +#define GENCMDDADDRL(adl, addr)		((adl) | ((addr) & 0xffff))
>> +#define GENCMDDADDRH(adh, addr)		((adh) | (((addr) >> 16) & 0xffff))
>> +#define GENCMDIADDRL(ail, addr)		((ail) | ((addr) & 0xffff))
>> +#define GENCMDIADDRH(aih, addr)		((aih) | (((addr) >> 16) & 0xffff))
>> +
>> +#define RB_STA(x)		(1 << (26 + (x)))
>> +#define DMA_DIR(dir)		((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
>> +
>> +#define ECC_CHECK_RETURN_FF	(-1)
>> +
>> +#define NAND_CE0		(0xe << 10)
>> +#define NAND_CE1		(0xd << 10)
>> +
>> +#define DMA_BUSY_TIMEOUT	0x100000
>> +#define CMD_FIFO_EMPTY_TIMEOUT	1000
>> +
>> +#define MAX_CE_NUM		2
>> +
>> +/* eMMC clock register, misc control */
>> +#define SD_EMMC_CLOCK		0x00
>> +#define CLK_ALWAYS_ON		BIT(28)
>> +#define CLK_SELECT_NAND		BIT(31)
>> +#define CLK_DIV_MASK		GENMASK(5, 0)
>> +
>> +#define NFC_CLK_CYCLE		6
>> +
>> +/* nand flash controller delay 3 ns */
>> +#define NFC_DEFAULT_DELAY	3000
>> +
>> +#define MAX_ECC_INDEX		10
>> +
>> +#define MUX_CLK_NUM_PARENTS	2
>> +
>> +#define ROW_ADDER(page, index)	(((page) >> (8 * (index))) & 0xff)
>> +#define MAX_CYCLE_ROW_ADDRS	3
>> +#define MAX_CYCLE_COLUMN_ADDRS	2
>> +#define DIRREAD			1
>> +#define DIRWRITE		0
>> +
>> +#define ECC_PARITY_BCH8_512B	14
>> +
>> +struct meson_nfc_info_format {
>> +	u16 info_bytes;
>> +
>> +	/* bit[5:0] are valid */
>> +	u8 zero_cnt;
>> +	struct ecc_sta {
>> +		u8 eccerr_cnt : 6;
>> +		u8 notused : 1;
>> +		u8 completed : 1;
>> +	} ecc;
> 
> It's usually a bad idea to use bitfields for things like HW
> regs/descriptors fields because it's hard to tell where the bits are
> actually placed (not even sure the C standard defines how this should be
> done).
> 
ok.

>> +	u32 reserved;
>> +};
> 
> How about defining that the HW returns an array of __le64 instead and then
> define the following macros which you can use after converting in the
> CPU endianness
> 
> #define ECC_GET_PROTECTED_OOB_BYTE(x, y)	(((x) >> (8 * (1 + y)) & GENMASK(7, 0))
> #define ECC_COMPLETE			BIT(31)
> #define ECC_ERR_CNT(x)			(((x) >> 24) & GENMASK(5, 0))
> 
> (I'm not entirely sure the field positions are correct, but I'll let you
> check that).
> 
ok. i think it should be:

#define ECC_GET_PROTECTED_OOB_BYTE(x, y)	(((x) >> (8 * y) &
GENMASK(7, 0))

if x represents the u64 and y represents the index of the u64.



>> +
>> +#define PER_INFO_BYTE	(sizeof(struct meson_nfc_info_format))
>> +
>> +struct meson_nfc_nand_chip {
>> +	struct list_head node;
>> +	struct nand_chip nand;
>> +	bool is_scramble;
> 
> I think I already mentioned the NAND_NEED_SCRAMBLING flag []. Please
> drop this field and test (chip->flags & NAND_NEED_SCRAMBLING) instead.
> 
em, i use NAND_NEED_SCRAMBLING and is_scramble is set:
static int meson_nand_attach_chip(struct nand_chip *nand)
{
	......
	meson_chip->is_scramble =
		(nand->options & NAND_NEED_SCRAMBLING) ? 1 : 0;
	......
}

>> +	int bch_mode;
>> +	int nsels;
>> +	u8 sels[0];
>> +};
>> +
>> +struct meson_nand_ecc {
>> +	int bch;
>> +	int strength;
>> +};
>> +
>> +struct meson_nfc_data {
>> +	const struct nand_ecc_caps *ecc_caps;
>> +};
>> +
>> +struct meson_nfc_param {
>> +	int chip_select;
>> +	int rb_select;
>> +};
>> +
>> +struct nand_rw_cmd {
>> +	int cmd0;
>> +	int col[MAX_CYCLE_COLUMN_ADDRS];
>> +	int row[MAX_CYCLE_ROW_ADDRS];
>> +	int cmd1;
>> +};
>> +
>> +struct nand_timing {
>> +	int twb;
>> +	int tadl;
>> +	int twhr;
>> +};
>> +
>> +struct meson_nfc {
>> +	struct nand_controller controller;
>> +	struct clk *core_clk;
>> +	struct clk *device_clk;
>> +	struct clk *phase_tx;
>> +	struct clk *phase_rx;
>> +
>> +	struct device *dev;
>> +	void __iomem *reg_base;
>> +	struct regmap *reg_clk;
>> +	struct completion completion;
>> +	struct list_head chips;
>> +	const struct meson_nfc_data *data;
>> +	struct meson_nfc_param param;
>> +	struct nand_timing timing;
>> +	union {
>> +		int cmd[32];
>> +		struct nand_rw_cmd rw;
>> +	} cmdfifo;
>> +
>> +	dma_addr_t data_dma;
>> +	dma_addr_t info_dma;
>> +
>> +	unsigned long assigned_cs;
>> +
>> +	u8 *data_buf;
>> +	u8 *info_buf;
>> +};
>> +
>> +enum {
>> +	NFC_ECC_BCH8_1K		= 2,
>> +	NFC_ECC_BCH24_1K,
>> +	NFC_ECC_BCH30_1K,
>> +	NFC_ECC_BCH40_1K,
>> +	NFC_ECC_BCH50_1K,
>> +	NFC_ECC_BCH60_1K,
>> +};
>> +
>> +#define MESON_ECC_DATA(b, s)	{ .bch = (b),	.strength = (s)}
>> +
>> +static int meson_nand_calc_ecc_bytes(int step_size, int strength)
>> +{
>> +	int ecc_bytes;
>> +
>> +	if (step_size == 512 && strength == 8)
>> +		return ECC_PARITY_BCH8_512B;
>> +
>> +	ecc_bytes = DIV_ROUND_UP(strength * fls(step_size * 8), 8);
>> +	if (ecc_bytes % 2)
>> +		ecc_bytes++;
> 
> Just a tiny detail, but this can be replaced by ALIGN(ecc_bytes, 2).
> 

ok

>> +
>> +	return ecc_bytes;
>> +}
>> +
>> +NAND_ECC_CAPS_SINGLE(meson_gxl_ecc_caps,
>> +		     meson_nand_calc_ecc_bytes, 1024, 8, 24, 30, 40, 50, 60);
>> +NAND_ECC_CAPS_SINGLE(meson_axg_ecc_caps,
>> +		     meson_nand_calc_ecc_bytes, 1024, 8);
>> +
>> +static inline
>> +struct meson_nfc_nand_chip *to_meson_nand(struct nand_chip *nand)
>> +{
>> +	return container_of(nand, struct meson_nfc_nand_chip, nand);
>> +}
>> +
>> +static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>> +{
>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>> +
>> +	if (chip < 0 || chip > MAX_CE_NUM)
> 
> You can add a WARN_ON_ONCE() around chip > MAX_CE_NUM, because this should
> never happen.
> 

ok

>> +		return;
>> +
>> +	nfc->param.chip_select = meson_chip->sels[chip] ? NAND_CE1 : NAND_CE0;
>> +	nfc->param.rb_select = nfc->param.chip_select;
>> +}
>> +
>> +static inline void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
>> +{
>> +	writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
>> +	       nfc->reg_base + NFC_REG_CMD);
>> +}
>> +
>> +static inline void meson_nfc_cmd_seed(struct meson_nfc *nfc, u32 seed)
>> +{
>> +	writel(NFC_CMD_SEED | (0xc2 + (seed & 0x7fff)),
>> +	       nfc->reg_base + NFC_REG_CMD);
>> +}
>> +
>> +static void meson_nfc_cmd_access(struct meson_nfc *nfc,
>> +				 struct mtd_info *mtd, int raw, bool dir)
> 
> Just pass a nand_chip or a meson_nfc_nand_chip object here, nfc and mtd
> can be extracted from there.
> 
ok

>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>> +	u32 cmd, pagesize, pages;
>> +	int bch = meson_chip->bch_mode;
>> +	int len = mtd->writesize;
>> +	int scramble = meson_chip->is_scramble ? 1 : 0;
>> +
>> +	pagesize = nand->ecc.size;
>> +
>> +	if (raw) {
>> +		bch = NAND_ECC_NONE;
> 
> You set bch to NAND_ECC_NONE but never use the variable afterwards, is
> that normal?
> 
ok, i will fix it. it is not used.

>> +		len = mtd->writesize + mtd->oobsize;
>> +		cmd = (len & 0x3fff) | (scramble << 19) | DMA_DIR(dir);
> 
> Please use a macro to describe bit 19:
> 
> #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
> 

ok
>> +		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +		return;
>> +	}
>> +
>> +	pages = len / nand->ecc.size;
>> +
>> +	cmd = CMDRWGEN(DMA_DIR(dir), scramble, bch, 0, pagesize, pages);
>> +
>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +}
>> +
>> +static inline void meson_nfc_drain_cmd(struct meson_nfc *nfc)
>> +{
>> +	/*
>> +	 * Insert two commands to make sure all valid commands are finished.
>> +	 *
>> +	 * The Nand flash controller is designed as two stages pipleline -
>> +	 *  a) fetch and b) excute.
>> +	 * There might be cases when the driver see command queue is empty,
>> +	 * but the Nand flash controller still has two commands buffered,
>> +	 * one is fetched into NFC request queue (ready to run), and another
>> +	 * is actively executing. So pushing 2 "IDLE" commands guarantees that
>> +	 * the pipeline is emptied.
>> +	 */
>> +	meson_nfc_cmd_idle(nfc, 0);
>> +	meson_nfc_cmd_idle(nfc, 0);
>> +}
>> +
>> +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>> +				     unsigned int timeout_ms)
>> +{
>> +	u32 cmd_size = 0;
>> +	int ret;
>> +
>> +	/* wait cmd fifo is empty */
>> +	ret = readl_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>> +				 !((cmd_size >> 22) & 0x1f),
> 
> Define a macro to extract the cmd_size:
> 
> #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> 

ok
>> +				 10, timeout_ms * 1000);
>> +	if (ret)
>> +		dev_err(nfc->dev, "wait for empty cmd FIFO time out\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>> +{
>> +	meson_nfc_drain_cmd(nfc);
>> +
>> +	return meson_nfc_wait_cmd_finish(nfc, DMA_BUSY_TIMEOUT);
>> +}
>> +
>> +static inline
>> +struct meson_nfc_info_format *nfc_info_ptr(struct meson_nfc *nfc,
>> +					   int index)
>> +{
>> +	return (struct meson_nfc_info_format *)&nfc->info_buf[index * 8];
> 
> As said previously, I think ->info_buf should be an array of __le64, and
> all you should do here is
> 
> 	return le64_to_cpu(nfc->info_buf[index]);
> 
> Then you can use the macros defined above to extract the results you
> need.
> 

ok
>> +}
>> +
>> +static u8 *meson_nfc_oob_ptr(struct meson_nfc *nfc,
>> +			     struct mtd_info *mtd, int i)
>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +	int len;
>> +
>> +	len = nand->ecc.size * (i + 1) + (nand->ecc.bytes + 2) * i;
>> +
>> +	return nfc->data_buf + len;
>> +}
>> +
>> +static u8 *meson_nfc_data_ptr(struct meson_nfc *nfc,
>> +			      struct mtd_info *mtd, int i)
>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +	int len;
>> +	int temp;
>> +
>> +	temp = nand->ecc.size + nand->ecc.bytes;
>> +	len = (temp + 2) * i;
>> +
>> +	return nfc->data_buf + len;
>> +}
>> +
>> +static void meson_nfc_prase_data_oob(struct meson_nfc *nfc,
> 
> What does prase mean? Maybe _set_ and _get_ would be better that _prase_
> and _format_.
> 
>> +				     struct mtd_info *mtd, u8 *buf, u8 *oobbuf)
> 
> As said previously, please stop passing mtd objects around. Same goes
> for nfc if you already have to pass a nand_chip object.
> 

ok
>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +	int i, oob_len = 0;
>> +	u8 *dsrc, *osrc;
>> +
>> +	for (i = 0; i < mtd->writesize / nand->ecc.size; i++) {
> 
> You have ecc->steps for that, no need to do the division everytime.
> 

ok, it will fix it.
>> +		if (buf) {
>> +			dsrc = meson_nfc_data_ptr(nfc, mtd, i);
>> +			memcpy(buf, dsrc, nand->ecc.size);
>> +			buf += nand->ecc.size;
>> +		}
>> +		oob_len = nand->ecc.bytes + 2;
> 
> Looks like oob_len does not change, so you can move the oob_len
> assignment outside of this loop.
> 

em.i will fix it.

>> +		osrc = meson_nfc_oob_ptr(nfc, mtd, i);
>> +		memcpy(oobbuf, osrc, oob_len);
>> +		oobbuf += oob_len;
>> +	}
>> +}
>> +
>> +static void meson_nfc_format_data_oob(struct meson_nfc *nfc,
>> +				      struct mtd_info *mtd,
>> +				      const u8 *buf, u8 *oobbuf)
>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +	int i, oob_len = 0;
>> +	u8 *dsrc, *osrc;
>> +
>> +	for (i = 0; i < mtd->writesize / nand->ecc.size; i++) {
>> +		if (buf) {
>> +			dsrc = meson_nfc_data_ptr(nfc, mtd, i);
>> +			memcpy(dsrc, buf, nand->ecc.size);
>> +			buf += nand->ecc.size;
>> +		}
>> +		oob_len = nand->ecc.bytes + 2;
>> +		osrc = meson_nfc_oob_ptr(nfc, mtd, i);
>> +		memcpy(osrc, oobbuf, oob_len);
>> +		oobbuf += oob_len;
>> +	}
>> +}
>> +
>> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>> +{
>> +	u32 cmd, cfg;
>> +	int ret = 0;
>> +
>> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>> +	meson_nfc_drain_cmd(nfc);
>> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>> +
>> +	cfg = readl(nfc->reg_base + NFC_REG_CFG);
>> +	cfg |= (1 << 21);
>> +	writel(cfg, nfc->reg_base + NFC_REG_CFG);
>> +
>> +	init_completion(&nfc->completion);
>> +
>> +	cmd = NFC_CMD_RB | (0x1 << 14) | nfc->param.chip_select | 0x18;
> 
> Please define macros for all those magic values (0x18 and 1 << 14)
> 

ok
>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +
>> +	ret = wait_for_completion_timeout(&nfc->completion,
>> +					  msecs_to_jiffies(timeout_ms));
>> +	if (ret == 0) {
>> +		dev_err(nfc->dev, "wait nand irq timeout\n");
>> +		ret = -1;
> 
> 		      -ETIMEDOUT;
> 
>> +	}
>> +	return ret;
>> +}
>> +
>> +static void meson_nfc_set_user_byte(struct mtd_info *mtd,
>> +				    struct nand_chip *chip, u8 *oob_buf)
>> +{
>> +	struct meson_nfc *nfc = nand_get_controller_data(chip);
>> +	struct meson_nfc_info_format *info;
>> +	int i, count;
>> +
>> +	for (i = 0, count = 0; i < chip->ecc.steps; i++, count += 2) {
>> +		info = nfc_info_ptr(nfc, i);
>> +		info->info_bytes =
>> +			oob_buf[count] | (oob_buf[count + 1] << 8);
> 
> Use a macro to set/get protected OOB bytes.
> 
ok
>> +	}
>> +}
>> +
> 
> .
> 
