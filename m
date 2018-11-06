Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B4C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1D820869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1D820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbeKFSxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:53:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41221 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbeKFSxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:53:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E34792073D; Tue,  6 Nov 2018 10:28:55 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 61299206FF;
        Tue,  6 Nov 2018 10:28:55 +0100 (CET)
Date:   Tue, 6 Nov 2018 10:28:51 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
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
Message-ID: <20181106102851.61deb97a@bbrezillon>
In-Reply-To: <a571904e-6296-bf62-e1fe-e25bf90040bb@amlogic.com>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
        <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
        <20181105165321.7ea2b45f@bbrezillon>
        <a571904e-6296-bf62-e1fe-e25bf90040bb@amlogic.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018 17:08:00 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> On 2018/11/5 23:53, Boris Brezillon wrote:
> > On Fri, 2 Nov 2018 00:42:21 +0800
> > Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> >   
> >> +#define NFC_REG_CMD		0x00
> >> +#define NFC_CMD_DRD		(0x8 << 14)
> >> +#define NFC_CMD_IDLE		(0xc << 14)
> >> +#define NFC_CMD_DWR		(0x4 << 14)
> >> +#define NFC_CMD_CLE		(0x5 << 14)
> >> +#define NFC_CMD_ALE		(0x6 << 14)
> >> +#define NFC_CMD_ADL		((0 << 16) | (3 << 20))
> >> +#define NFC_CMD_ADH		((1 << 16) | (3 << 20))
> >> +#define NFC_CMD_AIL		((2 << 16) | (3 << 20))
> >> +#define NFC_CMD_AIH		((3 << 16) | (3 << 20))
> >> +#define NFC_CMD_SEED		((8 << 16) | (3 << 20))
> >> +#define NFC_CMD_M2N		((0 << 17) | (2 << 20))
> >> +#define NFC_CMD_N2M		((1 << 17) | (2 << 20))
> >> +#define NFC_CMD_RB		BIT(20)
> >> +#define NFC_CMD_IO6		((0xb << 10) | (1 << 18))
> >> +#define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
> >> +#define NFC_CMD_RB_INT		BIT(14)
> >> +
> >> +#define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> >> +#define NFC_CMD_RB_TIMEOUT	0x18  
> > 
> > Where does this value come from? Is it the typical timeout value,
> > and if it is, what's the value in milli/microseconds?
> >   
> it is about 5.2ms when one nand cycle is 20ns and calculate it with the 
> max erase time of toshiba slc flash.i think it should be taken from the 
> sdr_timings.

Yes, it should. Or just pick the maximum value, since it's just a
timeout anyway and shouldn't expire if everything works as expected.

> >> +
> >> +static inline u8 meson_nfc_read_byte(struct mtd_info *mtd)
> >> +{
> >> +	struct nand_chip *nand = mtd_to_nand(mtd);
> >> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> >> +	u32 cmd;
> >> +
> >> +	cmd = nfc->param.chip_select | NFC_CMD_DRD | 0;
> >> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> +
> >> +	meson_nfc_drain_cmd(nfc);  
> > 
> > You probably don't want to drain the FIFO every time you read a byte on
> > the bus, and I guess the INPUT FIFO is at least as big as the CMD
> > FIFO, right? If that's the case, you should queue as much DRD cmd as
> > possible and only sync when the user explicitly requests it or when
> > the INPUT/READ FIFO is full.
> >   
> Register 'NFC_REG_BUF' can holds only 4 bytes, also DRD sends only one 
> nand cycle to read one byte and covers the 1st byte every time reading. 
> i think nfc controller is faster than nand cycle, but really it is not 
> high efficiency when reading so many bytes once.
> Or use dma command here like read_page and read_page_raw.

Yep, that's also an alternative, though you'll have to make sure the
buffer passed through the nand_op_inst is DMA-safe, and use a bounce
buffer when that's not the case.

> >> +
> >> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);  
> > 
> > As for the read_byte() implementation, I don't think you should force a
> > sync here.
> >   
> ok, it can send 30 bytes (command fifo size subtract 2 idle command ) 
> once with a sync.

Okay, still better than syncing after each transmitted byte.

> Or use dma command.

I guess that's the best option.

> 
> >> +}
> >> +
> >> +static void meson_nfc_write_buf(struct mtd_info *mtd,
> >> +				const u8 *buf, int len)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < len; i++)
> >> +		meson_nfc_write_byte(mtd, buf[i]);
> >> +}
> >> +
> >> +static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
> >> +						int page, bool in)
> >> +{
> >> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> >> +	const struct nand_sdr_timings *sdr =
> >> +		nand_get_sdr_timings(&nand->data_interface);
> >> +	int cs = nfc->param.chip_select;
> >> +	int i, cmd0, cmd_num;
> >> +	int ret = 0;
> >> +
> >> +	cmd0 = in ? NAND_CMD_READ0 : NAND_CMD_SEQIN;
> >> +	cmd_num = sizeof(struct nand_rw_cmd) / sizeof(int);
> >> +	if (!in)
> >> +		cmd_num--;
> >> +
> >> +	nfc->cmdfifo.rw.cmd0 = cs | NFC_CMD_CLE | cmd0;
> >> +	for (i = 0; i < MAX_CYCLE_COLUMN_ADDRS; i++)
> >> +		nfc->cmdfifo.rw.col[i] = cs | NFC_CMD_ALE | 0;
> >> +
> >> +	for (i = 0; i < MAX_CYCLE_ROW_ADDRS; i++)
> >> +		nfc->cmdfifo.rw.row[i] = cs | NFC_CMD_ALE | ROW_ADDER(page, i);
> >> +
> >> +	nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;  
> > 
> > Having a fixed size array for the column and row address cycles does
> > not sound like a good idea to me (depending on the NAND chip you
> > connect, the number of cycles for the row and column differ), which
> > makes me realize the nand_rw_cmd struct is not such a good thing...
> >   
> em , i will fix it by adding the size of the column and row address.
> is that ok?
> 
> >> +
> >> +	for (i = 0; i < cmd_num; i++)
> >> +		writel(nfc->cmdfifo.cmd[i], nfc->reg_base + NFC_REG_CMD);  
> > 
> > ... why not write directly to the CMD reg?
> >   
> 
> it seems that too many writel(xxx, nfc->reg_base + NFC_REG_CMD) in one 
> function; so I want to cache all the commands and write it in a loop.

Not sure why it makes a difference since you'll end up writing to
NFC_REG_CMD anyway.

BTW, you can probably use the writel_relaxed() instead of writel() when
writing to the CMD FIFO.

> 
> >> +
> >> +	if (in)
> >> +		meson_nfc_queue_rb(nfc, sdr->tR_max);
> >> +	else
> >> +		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int meson_nfc_write_page_sub(struct nand_chip *nand, const u8 *buf,
> >> +				    int page, int raw)
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(nand);
> >> +	const struct nand_sdr_timings *sdr =
> >> +		nand_get_sdr_timings(&nand->data_interface);
> >> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> >> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> >> +	dma_addr_t daddr, iaddr;
> >> +	u32 cmd;
> >> +	int ret;
> >> +
> >> +	daddr = dma_map_single(nfc->dev, (void *)meson_chip->data_buf,
> >> +			       mtd->writesize + mtd->oobsize,
> >> +			       DMA_TO_DEVICE);
> >> +	ret = dma_mapping_error(nfc->dev, daddr);
> >> +	if (ret) {
> >> +		dev_err(nfc->dev, "dma mapping error\n");
> >> +		goto err;
> >> +	}
> >> +
> >> +	iaddr = dma_map_single(nfc->dev, (void *)meson_chip->info_buf,
> >> +			       nand->ecc.steps * PER_INFO_BYTE,
> >> +			       DMA_TO_DEVICE);
> >> +	ret = dma_mapping_error(nfc->dev, iaddr);
> >> +	if (ret) {
> >> +		dev_err(nfc->dev, "dma mapping error\n");
> >> +		goto err_map_daddr;
> >> +	}
> >> +
> >> +	ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRWRITE);
> >> +	if (ret)
> >> +		goto err_map_iaddr;
> >> +
> >> +	cmd = GENCMDDADDRL(NFC_CMD_ADL, daddr);
> >> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> +
> >> +	cmd = GENCMDDADDRH(NFC_CMD_ADH, daddr);
> >> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> +
> >> +	cmd = GENCMDIADDRL(NFC_CMD_AIL, iaddr);
> >> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> +
> >> +	cmd = GENCMDIADDRH(NFC_CMD_AIH, iaddr);
> >> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> +
> >> +	meson_nfc_cmd_seed(nfc, page);
> >> +
> >> +	meson_nfc_cmd_access(nand, raw, DIRWRITE);
> >> +
> >> +	ret = meson_nfc_wait_dma_finish(nfc);
> >> +	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
> >> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> +	meson_nfc_queue_rb(nfc, sdr->tPROG_max);  
> > 
> > Don't you have a way to queue the PAGEPROG and WAIT_RB instructions
> > before the DMA finishes?
> >   
> 
> it runs:
> 1) dma transfer ddr data to nand page cache.
> 2) wait dma finish
> 3) send the PAGEPROG command
> 4) wait rb finish
> 
> meson_nfc_wait_dma_finish(nfc) waits command fifo empty. Maybe it is 
> difficult or uncessary to queue the PAGEPROG command and WAIT_RB between 
> 1) and 2).
> 
> is that right?
> 

Isn't the controller engine able to wait on the data transfer to be
complete before sending the next instruction in the CMD FIFO pipe?
I'm pretty sure it's able to do that, which would make
meson_nfc_wait_dma_finish() useless, and all you'd have to do is wait
for the CMD FIFO to be empty (assuming it guarantees the last command
has been executed).

> 
> >> +	}  
> > 
> > Don't you need a call to meson_nfc_wait_cmd_finish() here?
> >   
> it will be called in queue_rb, read_buf and write_buf. but i have no 
> idea whether it still needs to be called corresponding to 
> CMD_INSTR/ADDR_INSTR.To be strict, it should be called.

No, the synchronization is only needed before returning from
->exec_op(). Everything before can be queued without being
executed. Of course, if you run out of entries in the CMD/INPUT
FIFOs you'll have to do some sort of synchronization, but that should
be taken care of in your helpers.
