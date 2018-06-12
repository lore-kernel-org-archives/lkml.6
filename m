Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3341EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC475208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC475208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeFLJfF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:35:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40696 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933216AbeFLJfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:35:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE9B320733; Tue, 12 Jun 2018 11:34:59 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 46E2520733;
        Tue, 12 Jun 2018 11:34:49 +0200 (CEST)
Date:   Tue, 12 Jun 2018 11:34:49 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     axboe@kernel.dk, Dmitry Osipenko <digetx@gmail.com>,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180612113449.79dddb38@bbrezillon>
In-Reply-To: <53e36cff80e38e489959aa18471d0782@agner.ch>
References: <20180611205224.23340-1-stefan@agner.ch>
        <20180611205224.23340-5-stefan@agner.ch>
        <4258393.O1xtUOGbca@dimapc>
        <cb6f2ef0a5a41e001a2019caa1a18c23@agner.ch>
        <20180612102734.0ea3bfa5@bbrezillon>
        <53e36cff80e38e489959aa18471d0782@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 11:17:09 +0200
Stefan Agner <stefan@agner.ch> wrote:

> [also added Jens Axboe]
> 
> On 12.06.2018 10:27, Boris Brezillon wrote:
> > On Tue, 12 Jun 2018 10:06:42 +0200
> > Stefan Agner <stefan@agner.ch> wrote:
> >   
> >> On 12.06.2018 02:03, Dmitry Osipenko wrote:  
> >> > On Monday, 11 June 2018 23:52:22 MSK Stefan Agner wrote:  
> >> >> Add support for the NAND flash controller found on NVIDIA
> >> >> Tegra 2 SoCs. This implementation does not make use of the
> >> >> command queue feature. Regular operations/data transfers are
> >> >> done in PIO mode. Page read/writes with hardware ECC make
> >> >> use of the DMA for data transfer.
> >> >>
> >> >> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> >> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> >> ---
> >> >>  MAINTAINERS                       |    7 +
> >> >>  drivers/mtd/nand/raw/Kconfig      |    6 +
> >> >>  drivers/mtd/nand/raw/Makefile     |    1 +
> >> >>  drivers/mtd/nand/raw/tegra_nand.c | 1248 +++++++++++++++++++++++++++++
> >> >>  4 files changed, 1262 insertions(+)
> >> >>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
> >> >>  
> >> [snip]  
> >> >> +static int tegra_nand_cmd(struct nand_chip *chip,
> >> >> +			 const struct nand_subop *subop)
> >> >> +{
> >> >> +	const struct nand_op_instr *instr;
> >> >> +	const struct nand_op_instr *instr_data_in = NULL;
> >> >> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
> >> >> +	unsigned int op_id, size = 0, offset = 0;
> >> >> +	bool first_cmd = true;
> >> >> +	u32 reg, cmd = 0;
> >> >> +	int ret;
> >> >> +
> >> >> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> >> >> +		unsigned int naddrs, i;
> >> >> +		const u8 *addrs;
> >> >> +		u32 addr1 = 0, addr2 = 0;
> >> >> +
> >> >> +		instr = &subop->instrs[op_id];
> >> >> +
> >> >> +		switch (instr->type) {
> >> >> +		case NAND_OP_CMD_INSTR:
> >> >> +			if (first_cmd) {
> >> >> +				cmd |= COMMAND_CLE;
> >> >> +				writel_relaxed(instr->ctx.cmd.opcode,
> >> >> +					       ctrl->regs + CMD_REG1);
> >> >> +			} else {
> >> >> +				cmd |= COMMAND_SEC_CMD;
> >> >> +				writel_relaxed(instr->ctx.cmd.opcode,
> >> >> +					       ctrl->regs + CMD_REG2);
> >> >> +			}
> >> >> +			first_cmd = false;
> >> >> +			break;
> >> >> +		case NAND_OP_ADDR_INSTR:
> >> >> +			offset = nand_subop_get_addr_start_off(subop, op_id);
> >> >> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> >> >> +			addrs = &instr->ctx.addr.addrs[offset];
> >> >> +
> >> >> +			cmd |= COMMAND_ALE | COMMAND_ALE_SIZE(naddrs);
> >> >> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> >> >> +				addr1 |= *addrs++ << (BITS_PER_BYTE * i);
> >> >> +			naddrs -= i;
> >> >> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> >> >> +				addr2 |= *addrs++ << (BITS_PER_BYTE * i);
> >> >> +			writel_relaxed(addr1, ctrl->regs + ADDR_REG1);
> >> >> +			writel_relaxed(addr2, ctrl->regs + ADDR_REG2);
> >> >> +			break;
> >> >> +
> >> >> +		case NAND_OP_DATA_IN_INSTR:
> >> >> +			size = nand_subop_get_data_len(subop, op_id);
> >> >> +			offset = nand_subop_get_data_start_off(subop, op_id);
> >> >> +
> >> >> +			cmd |= COMMAND_TRANS_SIZE(size) | COMMAND_PIO |
> >> >> +				COMMAND_RX | COMMAND_A_VALID;
> >> >> +
> >> >> +			instr_data_in = instr;
> >> >> +			break;
> >> >> +
> >> >> +		case NAND_OP_DATA_OUT_INSTR:
> >> >> +			size = nand_subop_get_data_len(subop, op_id);
> >> >> +			offset = nand_subop_get_data_start_off(subop, op_id);
> >> >> +
> >> >> +			cmd |= COMMAND_TRANS_SIZE(size) | COMMAND_PIO |
> >> >> +				COMMAND_TX | COMMAND_A_VALID;
> >> >> +
> >> >> +			memcpy(&reg, instr->ctx.data.buf.out + offset, size);
> >> >> +			writel_relaxed(reg, ctrl->regs + RESP);
> >> >> +
> >> >> +			break;
> >> >> +		case NAND_OP_WAITRDY_INSTR:
> >> >> +			cmd |= COMMAND_RBSY_CHK;
> >> >> +			break;
> >> >> +
> >> >> +		}
> >> >> +	}
> >> >> +
> >> >> +	cmd |= COMMAND_GO | COMMAND_CE(ctrl->cur_cs);
> >> >> +	writel_relaxed(cmd, ctrl->regs + COMMAND);
> >> >> +	ret = wait_for_completion_io_timeout(&ctrl->command_complete,
> >> >> +					     msecs_to_jiffies(500));  
> >> >
> >> > It's not obvious to me whether _io_ variant is appropriate to use here, would
> >> > be nice if somebody could clarify that. Maybe block/ already does the IO
> >> > accounting itself and hence the IO time would be counted twice in that case.  
> >>
> >> Good that you bring this up.
> >>
> >> I don't think that there is any higher layer which could take care of
> >> accounting. Usually, with raw nand there is no block layer involved
> >> anyway.
> >>
> >> In a quick test it seems that only when using wait_for_completion_io I/O
> >> is properly accounted in the "wait" section of top.
> >>
> >> So far only a single driver (omap2) used the _io variant, but I think it
> >> is the right thing to do! After all, it is I/O...
> >>
> >> Boris or any other MTD maintainer, any comment on this?  
> > 
> > Given this definition of io_schedule_timeout() [1] (which is used when
> > you call wait_for_completion_io_timeout()), I'd say it's not useful to
> > use the _io_ version, simply because MTD devs are not exposed as blk
> > devices, and thus don't need the blk_schedule_flush_plug() that is done
> > is io_schedule_prepare(). But that also means MTD I/Os are not
> > accounted as I/Os :-(.  
> 
> Documentation of wait_for_completion_io says:
> "The caller is accounted as waiting for IO (which traditionally means
> blkio only)."
> 
> Which sounds as if it using _io is only an accounting thing...
> 
> The hint about blkio might suggest that there is more to it.
> 
> Is calling blk_schedule_flush_plug a problem for MTD?
> https://elixir.bootlin.com/linux/v4.17.1/source/include/linux/blkdev.h#L1355

It shouldn't. It might add a bit of work when a blk_plug is attached to
the task that is about to wait for I/Os (I honestly don't know what a
blk_plug is :-)).

> 
> > 
> > Let's go for the non-io version for now, since all drivers except omap2
> > seem to use this function.
> >   
> 
> I still think it would be nice and "the right thing" from a user
> perspective...

If we decide to switch to wait_for_completion_io_timeout(), I'd prefer
to do that for all drivers rather than just this one, and I'm still not
sure this is the right thing to do given the comment you pointed out
("which traditionally means blkio only").
