Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E56C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3A520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3A520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeKFBTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:19:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47777 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbeKFBTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:19:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AEDD220A8A; Mon,  5 Nov 2018 16:58:42 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 508F320728;
        Mon,  5 Nov 2018 16:53:25 +0100 (CET)
Date:   Mon, 5 Nov 2018 16:53:21 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181105165321.7ea2b45f@bbrezillon>
In-Reply-To: <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
        <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 00:42:21 +0800
Jianxin Pan <jianxin.pan@amlogic.com> wrote:

> +#define NFC_REG_CMD		0x00
> +#define NFC_CMD_DRD		(0x8 << 14)
> +#define NFC_CMD_IDLE		(0xc << 14)
> +#define NFC_CMD_DWR		(0x4 << 14)
> +#define NFC_CMD_CLE		(0x5 << 14)
> +#define NFC_CMD_ALE		(0x6 << 14)
> +#define NFC_CMD_ADL		((0 << 16) | (3 << 20))
> +#define NFC_CMD_ADH		((1 << 16) | (3 << 20))
> +#define NFC_CMD_AIL		((2 << 16) | (3 << 20))
> +#define NFC_CMD_AIH		((3 << 16) | (3 << 20))
> +#define NFC_CMD_SEED		((8 << 16) | (3 << 20))
> +#define NFC_CMD_M2N		((0 << 17) | (2 << 20))
> +#define NFC_CMD_N2M		((1 << 17) | (2 << 20))
> +#define NFC_CMD_RB		BIT(20)
> +#define NFC_CMD_IO6		((0xb << 10) | (1 << 18))
> +#define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
> +#define NFC_CMD_RB_INT		BIT(14)
> +
> +#define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> +#define NFC_CMD_RB_TIMEOUT	0x18

Where does this value come from? Is it the typical timeout value,
and if it is, what's the value in milli/microseconds?

> +
> +#define NFC_REG_CFG		0x04
> +#define NFC_REG_DADR		0x08
> +#define NFC_REG_IADR		0x0c
> +#define NFC_REG_BUF		0x10
> +#define NFC_REG_INFO		0x14
> +#define NFC_REG_DC		0x18
> +#define NFC_REG_ADR		0x1c
> +#define NFC_REG_DL		0x20
> +#define NFC_REG_DH		0x24
> +#define NFC_REG_CADR		0x28
> +#define NFC_REG_SADR		0x2c
> +#define NFC_REG_PINS		0x30
> +#define NFC_REG_VER		0x38
> +
> +#define NFC_RB_IRQ_EN		BIT(21)
> +#define NFC_INT_MASK		(3 << 20)
> +
> +#define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)	\
> +	(								\
> +		(cmd_dir)			|			\
> +		((ran) << 19)			|			\
> +		((bch) << 14)			|			\
> +		((short_mode) << 13)		|			\
> +		(((page_size) & 0x7f) << 6)	|			\
> +		((pages) & 0x3f)					\
> +	)
> +
> +#define GENCMDDADDRL(adl, addr)		((adl) | ((addr) & 0xffff))
> +#define GENCMDDADDRH(adh, addr)		((adh) | (((addr) >> 16) & 0xffff))
> +#define GENCMDIADDRL(ail, addr)		((ail) | ((addr) & 0xffff))
> +#define GENCMDIADDRH(aih, addr)		((aih) | (((addr) >> 16) & 0xffff))
> +
> +#define RB_STA(x)		(1 << (26 + (x)))
> +#define DMA_DIR(dir)		((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
> +
> +#define ECC_CHECK_RETURN_FF	(-1)
> +
> +#define NAND_CE0		(0xe << 10)
> +#define NAND_CE1		(0xd << 10)
> +
> +#define DMA_BUSY_TIMEOUT	0x100000
> +#define CMD_FIFO_EMPTY_TIMEOUT	1000
> +
> +#define MAX_CE_NUM		2
> +
> +/* eMMC clock register, misc control */
> +#define SD_EMMC_CLOCK		0x00
> +#define CLK_ALWAYS_ON		BIT(28)
> +#define CLK_SELECT_NAND		BIT(31)
> +#define CLK_DIV_MASK		GENMASK(5, 0)
> +
> +#define NFC_CLK_CYCLE		6
> +
> +/* nand flash controller delay 3 ns */
> +#define NFC_DEFAULT_DELAY	3000
> +
> +#define MAX_ECC_INDEX		10
> +
> +#define MUX_CLK_NUM_PARENTS	2
> +
> +#define ROW_ADDER(page, index)	(((page) >> (8 * (index))) & 0xff)
> +#define MAX_CYCLE_ROW_ADDRS	3
> +#define MAX_CYCLE_COLUMN_ADDRS	2
> +#define DIRREAD			1
> +#define DIRWRITE		0
> +
> +#define ECC_PARITY_BCH8_512B	14
> +
> +#define PER_INFO_BYTE		8
> +#define ECC_GET_PROTECTED_OOB_BYTE(x, y)			\
> +		((x) >> (8 * (y)) & GENMASK(7, 0))

		(le64_to_cpu(x) >> (8 * (y)) & GENMASK(7, 0))

> +
> +#define ECC_SET_PROTECTED_OOB_BYTE(x, y, z)			\
> +	{							\
> +		(x) &= (~((__le64)(0xff) << (8 * (y))));	\

It's probably better to memset(0) the info_buf so that you can drop
this masking step.

> +		(x) |= ((__le64)(z) << (8 * (y)));		\

		    |= cpu_to_le64((u64)z << (8 * (y)));

> +	}
> +
> +#define ECC_COMPLETE            BIT(31)
> +#define ECC_ERR_CNT(x)		(((x) >> 24) & GENMASK(5, 0))
> +#define ECC_ZERO_CNT(x)		(((x) >> 16) & GENMASK(5, 0))
> +
> +struct meson_nfc_nand_chip {
> +	struct list_head node;
> +	struct nand_chip nand;
> +	int clk_rate;
> +	int level1_divider;
> +	int bus_timing;
> +	int twb;
> +	int tadl;
> +
> +	int bch_mode;
> +	u8 *data_buf;
> +	__le64 *info_buf;
> +	int nsels;
> +	u8 sels[0];
> +};

Please use unsigned integers where having a negative value is not
possible. I'm pretty sure this is the case of all int fields in this
struct. The same applies to the other structs.

[...]

> +
> +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
> +				     unsigned int timeout_ms)
> +{
> +	u32 cmd_size = 0;
> +	int ret;
> +
> +	/* wait cmd fifo is empty */
> +	ret = readl_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
> +				 !NFC_CMD_GET_SIZE(cmd_size),
> +				 10, timeout_ms * 1000);

I guess you could use the relaxed version here.

> +	if (ret)
> +		dev_err(nfc->dev, "wait for empty cmd FIFO time out\n");
> +
> +	return ret;
> +}
> +
> +static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
> +{
> +	meson_nfc_drain_cmd(nfc);
> +
> +	return meson_nfc_wait_cmd_finish(nfc, DMA_BUSY_TIMEOUT);
> +}
> +
> +static inline __le64 nfc_info_ptr(struct nand_chip *nand, int index)

Drop inline specifiers for things that are defined in .c files. The
compiler should be smart enough to determine when inlining is
appropriate.

> +{
> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> +
> +	return le64_to_cpu(meson_chip->info_buf[index]);

According to the function prototype, you should return
meson_chip->info_buf[index] directly, but I'm not even sure why you
need this helper. Just access meson_chip->info_buf[] directly.

> +}
> +

[...]

> +
> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> +{
> +	u32 cmd, cfg;
> +	int ret = 0;
> +
> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> +	meson_nfc_drain_cmd(nfc);
> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> +
> +	cfg = readl(nfc->reg_base + NFC_REG_CFG);
> +	cfg |= (1 << 21);
> +	writel(cfg, nfc->reg_base + NFC_REG_CFG);
> +
> +	init_completion(&nfc->completion);
> +
> +	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
> +		| nfc->param.chip_select | NFC_CMD_RB_TIMEOUT;
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	ret = wait_for_completion_timeout(&nfc->completion,
> +					  msecs_to_jiffies(timeout_ms));
> +	if (ret == 0) {
> +		dev_err(nfc->dev, "wait nand irq timeout\n");
> +		ret = -1;
> +	}
> +	return ret;
> +}
> +
> +static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)

	       ^ meson_nfc_set_protected_oob_bytes()

> +{
> +	__le64 info;
> +	int i, count;
> +
> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
> +		info = nfc_info_ptr(nand, i);
> +		ECC_SET_PROTECTED_OOB_BYTE(info, 0, oob_buf[count]);
> +		ECC_SET_PROTECTED_OOB_BYTE(info, 1, oob_buf[count + 1]);

This is a NOOP: info is a local variable, so, anything you put in there
is just lost. It could work if nfc_info_ptr() was returning a pointer
and the local info var was also a pointer, but that's not the case
here.

BTW, maybe you don't need the ECC_SET/GET_PROTECTED_OOB_BYTE() macros.
Just do the conversion in the meson_nfc_get/set_protected_oob_bytes()
functions.

> +	}
> +}
> +
> +static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)

	       ^ meson_nfc_get_protected_oob_bytes()

> +{
> +	__le64 info;
> +	int i, count;
> +
> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
> +		info = nfc_info_ptr(nand, i);
> +		oob_buf[count] = ECC_GET_PROTECTED_OOB_BYTE(info, 0);
> +		oob_buf[count + 1] = ECC_GET_PROTECTED_OOB_BYTE(info, 1);
> +	}
> +}
> +
> +static int meson_nfc_ecc_correct(struct nand_chip *nand)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(nand);
> +	__le64 info;
> +	u32 bitflips = 0, i;
> +	int scramble;
> +	u8 zero_cnt;
> +
> +	scramble = (nand->options & NAND_NEED_SCRAMBLING) ? 1 : 0;
> +
> +	for (i = 0; i < nand->ecc.steps; i++) {
> +		info = nfc_info_ptr(nand, i);
> +		if (ECC_ERR_CNT(info) == 0x3f) {
> +			zero_cnt = ECC_ZERO_CNT(info);
> +			if (scramble && zero_cnt < nand->ecc.strength)
> +				return ECC_CHECK_RETURN_FF;
> +			mtd->ecc_stats.failed++;
> +			continue;
> +		}
> +		mtd->ecc_stats.corrected += ECC_ERR_CNT(info);
> +		bitflips = max_t(u32, bitflips, ECC_ERR_CNT(info));
> +	}
> +
> +	return bitflips;
> +}
> +
> +static inline u8 meson_nfc_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	u32 cmd;
> +
> +	cmd = nfc->param.chip_select | NFC_CMD_DRD | 0;
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	meson_nfc_drain_cmd(nfc);

You probably don't want to drain the FIFO every time you read a byte on
the bus, and I guess the INPUT FIFO is at least as big as the CMD
FIFO, right? If that's the case, you should queue as much DRD cmd as
possible and only sync when the user explicitly requests it or when
the INPUT/READ FIFO is full.

> +
> +	meson_nfc_wait_cmd_finish(nfc, 1000);
> +
> +	return readb(nfc->reg_base + NFC_REG_BUF);
> +}
> +
> +static void meson_nfc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		buf[i] = meson_nfc_read_byte(mtd);
> +}
> +
> +static void meson_nfc_write_byte(struct mtd_info *mtd, u8 byte)
> +{
> +	struct meson_nfc *nfc = nand_get_controller_data(mtd_to_nand(mtd));
> +	u32 cmd;
> +
> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> +
> +	cmd = nfc->param.chip_select | NFC_CMD_DWR | (byte & 0xff);
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);

Nope, tWB is not needed between 2 data-write cycles. It's only needed
when a wait-RB is requested after a write.

> +	meson_nfc_cmd_idle(nfc, 0);

Why do you need that one?

> +
> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);

As for the read_byte() implementation, I don't think you should force a
sync here.

> +}
> +
> +static void meson_nfc_write_buf(struct mtd_info *mtd,
> +				const u8 *buf, int len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		meson_nfc_write_byte(mtd, buf[i]);
> +}
> +
> +static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
> +						int page, bool in)
> +{
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	const struct nand_sdr_timings *sdr =
> +		nand_get_sdr_timings(&nand->data_interface);
> +	int cs = nfc->param.chip_select;
> +	int i, cmd0, cmd_num;
> +	int ret = 0;
> +
> +	cmd0 = in ? NAND_CMD_READ0 : NAND_CMD_SEQIN;
> +	cmd_num = sizeof(struct nand_rw_cmd) / sizeof(int);
> +	if (!in)
> +		cmd_num--;
> +
> +	nfc->cmdfifo.rw.cmd0 = cs | NFC_CMD_CLE | cmd0;
> +	for (i = 0; i < MAX_CYCLE_COLUMN_ADDRS; i++)
> +		nfc->cmdfifo.rw.col[i] = cs | NFC_CMD_ALE | 0;
> +
> +	for (i = 0; i < MAX_CYCLE_ROW_ADDRS; i++)
> +		nfc->cmdfifo.rw.row[i] = cs | NFC_CMD_ALE | ROW_ADDER(page, i);
> +
> +	nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;

Having a fixed size array for the column and row address cycles does
not sound like a good idea to me (depending on the NAND chip you
connect, the number of cycles for the row and column differ), which
makes me realize the nand_rw_cmd struct is not such a good thing...

> +
> +	for (i = 0; i < cmd_num; i++)
> +		writel(nfc->cmdfifo.cmd[i], nfc->reg_base + NFC_REG_CMD);

... why not write directly to the CMD reg?

> +
> +	if (in)
> +		meson_nfc_queue_rb(nfc, sdr->tR_max);
> +	else
> +		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
> +
> +	return ret;
> +}
> +
> +static int meson_nfc_write_page_sub(struct nand_chip *nand, const u8 *buf,
> +				    int page, int raw)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(nand);
> +	const struct nand_sdr_timings *sdr =
> +		nand_get_sdr_timings(&nand->data_interface);
> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	dma_addr_t daddr, iaddr;
> +	u32 cmd;
> +	int ret;
> +
> +	daddr = dma_map_single(nfc->dev, (void *)meson_chip->data_buf,
> +			       mtd->writesize + mtd->oobsize,
> +			       DMA_TO_DEVICE);
> +	ret = dma_mapping_error(nfc->dev, daddr);
> +	if (ret) {
> +		dev_err(nfc->dev, "dma mapping error\n");
> +		goto err;
> +	}
> +
> +	iaddr = dma_map_single(nfc->dev, (void *)meson_chip->info_buf,
> +			       nand->ecc.steps * PER_INFO_BYTE,
> +			       DMA_TO_DEVICE);
> +	ret = dma_mapping_error(nfc->dev, iaddr);
> +	if (ret) {
> +		dev_err(nfc->dev, "dma mapping error\n");
> +		goto err_map_daddr;
> +	}
> +
> +	ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRWRITE);
> +	if (ret)
> +		goto err_map_iaddr;
> +
> +	cmd = GENCMDDADDRL(NFC_CMD_ADL, daddr);
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	cmd = GENCMDDADDRH(NFC_CMD_ADH, daddr);
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	cmd = GENCMDIADDRL(NFC_CMD_AIL, iaddr);
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	cmd = GENCMDIADDRH(NFC_CMD_AIH, iaddr);
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	meson_nfc_cmd_seed(nfc, page);
> +
> +	meson_nfc_cmd_access(nand, raw, DIRWRITE);
> +
> +	ret = meson_nfc_wait_dma_finish(nfc);
> +	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +	meson_nfc_queue_rb(nfc, sdr->tPROG_max);

Don't you have a way to queue the PAGEPROG and WAIT_RB instructions
before the DMA finishes?

> +
> +err_map_iaddr:
> +	dma_unmap_single(nfc->dev, iaddr,
> +			 nand->ecc.steps * PER_INFO_BYTE, DMA_TO_DEVICE);
> +err_map_daddr:
> +	dma_unmap_single(nfc->dev, daddr,
> +			 mtd->writesize + mtd->oobsize, DMA_TO_DEVICE);
> +err:
> +	return ret;
> +}
> +

[...]

> +static int meson_nfc_exec_op(struct nand_chip *nand,
> +			     const struct nand_operation *op, bool check_only)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(nand);
> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	const struct nand_op_instr *instr = NULL;
> +	int ret = 0, cmd;
> +	unsigned int op_id;
> +	int i, delay_idle;
> +
> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
> +		instr = &op->instrs[op_id];
> +		delay_idle = DIV_ROUND_UP(PSEC_TO_NSEC(instr->delay_ns),
> +					  meson_chip->level1_divider
> +					  * NFC_CLK_CYCLE);

On multi-line operations, put the operator on the previous line:

					  meson_chip->level1_divider *
					  NFC_CLK_CYCLE);


> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			cmd = nfc->param.chip_select | NFC_CMD_CLE;
> +			cmd |= instr->ctx.cmd.opcode & 0xff;
> +			writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +			meson_nfc_cmd_idle(nfc, delay_idle);
> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			for (i = 0; i < instr->ctx.addr.naddrs; i++) {
> +				cmd = nfc->param.chip_select | NFC_CMD_ALE;
> +				cmd |= instr->ctx.addr.addrs[i] & 0xff;
> +				writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +			}
> +			meson_nfc_cmd_idle(nfc, delay_idle);
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			meson_nfc_read_buf(mtd, instr->ctx.data.buf.in,
> +					   instr->ctx.data.len);
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			meson_nfc_write_buf(mtd, instr->ctx.data.buf.out,
> +					    instr->ctx.data.len);
> +			break;
> +
> +		case NAND_OP_WAITRDY_INSTR:
> +			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
> +			meson_nfc_cmd_idle(nfc, delay_idle);
> +			break;
> +		}

I think you could move the meson_nfc_cmd_idle() call here, and only add
it when instr->delay_ns != 0:

		if (instr->delay_ns)
			meson_nfc_cmd_idle(nfc, delay_idle);

> +	}

Don't you need a call to meson_nfc_wait_cmd_finish() here?

> +	return ret;
> +}
