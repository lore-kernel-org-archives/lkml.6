Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCZVyP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:54:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57318 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeCZVyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:54:13 -0400
Date: Mon, 26 Mar 2018 23:53:59 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc: "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "Punnaiah Choudary Kalluri" <punnaia@xilinx.com>
Subject: Re: [LINUX PATCH v8 2/2] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Message-ID: <20180326235359.39825dfd@xps13>
In-Reply-To: <BY2PR02MB14114DD144070E22CEB8FC07AFA80@BY2PR02MB1411.namprd02.prod.outlook.com>
References: <1521024505-30677-1-git-send-email-nagasureshkumarrelli@gmail.com>
        <20180319233748.65b5a7b9@xps13>
        <BY2PR02MB14114DD144070E22CEB8FC07AFA80@BY2PR02MB1411.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

> > > +/**
> > > + * pl353_nand_read_buf_l - read chip data into buffer
> > > + * @chip:	Pointer to the NAND chip info structure
> > > + * @in:		Pointer to the buffer to store read data
> > > + * @len:	Number of bytes to read
> > > + * Return:	Always return zero
> > > + */
> > > +static int pl353_nand_read_buf_l(struct nand_chip *chip,
> > > +				     uint8_t *in,
> > > +				     unsigned int len)
> > > +{
> > > +	int i;
> > > +	unsigned long *ptr = (unsigned long *)in;
> > > +
> > > +	len >>= 2;
> > 
> > Can you please let the compiler optimize things? I don't find this very readable, I
> > would prefer a division here. And if this division by 4 is related to the size of *ptr,
> > please use the sizeof() macro. Otherwise please document this value.
> At a time, we are reading 4bytes. Hence >> 2.
> I didn't get your point.
> Are you saying instead of shifting, just use divide by 4?

I do.

> 
> > 
> > > +	for (i = 0; i < len; i++)
> > > +		ptr[i] = readl(chip->IO_ADDR_R);
> > 
> > Space
> Ok, I will update it
> > 
> > > +	return 0;
> > > +}
> > > +
> > > +static void pl353_nand_write_buf_l(struct nand_chip *chip, const uint8_t
> > *buf,
> > > +				int len)
> > > +{
> > > +	int i;
> > > +	unsigned long *ptr = (unsigned long *)buf;
> > > +
> > > +	for (i = 0; i < len; i++)
> > > +		writeb(ptr[i], chip->IO_ADDR_W);
> > 
> > Here you use writeb (as opposed to readl previously). Then, I guess you can also
> > read byte per byte. If so, you can drop both helpers and let the core use its
> > defaults ones: nand_read/write_buf().
> May be the function name I have written wrongly.
> When using writel, it should be nand_write_buf_l.
> But the thing is, when using exec_op, core is not calling chip->read_byte(), hence I added
> Byte reading.

Well, the point of using ->exec_op() is to forget about these hooks.
->exec_op() will ask you to read one byte if needed. You should forget
about ->read/write_byte/word/buf() hooks and delete them entirely.

> > 
> > Same for the next functions. Plus, if you don't use them inside
> > ->exec_op() implementation, they have to be removed anyway.
> The name of the function should change to buf_l, to do 4byte writes.
> The name is creating confusion.
> > 
> > > +}
> > > +
> > > +/**
> > > + * pl353_nand_write_buf - write buffer to chip
> > > + * @mtd:	Pointer to the mtd info structure
> > > + * @buf:	Pointer to the buffer to store read data
> > > + * @len:	Number of bytes to write
> > > + */
> > > +static void pl353_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
> > > +				int len)
> > > +{
> > > +	int i;
> > > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > > +	unsigned long *ptr = (unsigned long *)buf;
> > > +
> > > +	len >>= 2;
> > > +
> > > +	for (i = 0; i < len; i++)
> > > +		writel(ptr[i], chip->IO_ADDR_W);
> > > +}
> > > +
> > > +/**
> > > + * pl353_nand_read_buf - read chip data into buffer
> > > + * @chip:	Pointer to the NAND chip info structure
> > > + * @in:	Pointer to the buffer to store read data
> > > + * @len:	Number of bytes to read
> > > + * Return:	0 on success or error value on failure
> > > + */
> > > +static int pl353_nand_read_buf(struct nand_chip *chip,
> > > +				     uint8_t *in,
> > > +				     unsigned int len)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < len; i++)
> > > +		in[i] = readb(chip->IO_ADDR_R);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * pl353_nand_calculate_hwecc - Calculate Hardware ECC
> > > + * @mtd:	Pointer to the mtd_info structure
> > > + * @data:	Pointer to the page data
> > > + * @ecc_code:	Pointer to the ECC buffer where ECC data needs to be
> > stored
> > 
> > You store ECC in a variable called "code", can you please make it consistent?
> Miquel, I am not using any variable called "code"

I see "ecc_code", and ECC already stands for "Error Correcting Code".

> > 
> > > + *
> > > + * This function retrieves the Hardware ECC data from the controller
> > > +and returns
> > > + * ECC data back to the MTD subsystem.
> > > + *
> > > + * Return:	0 on success or error value on failure
> > > + */
> > > +static int pl353_nand_calculate_hwecc(struct mtd_info *mtd,
> > > +				const u8 *data, u8 *ecc_code)
> > > +{
> > > +	u32 ecc_value, ecc_status;
> > > +	u8 ecc_reg, ecc_byte;
> > > +	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> > > +	/* Wait till the ECC operation is complete or timeout */
> > > +	do {
> > > +		if (pl353_smc_ecc_is_busy())
> > 
> > Where does this function come from?
> The pl353 SMC has memory controller driver and this NAND driver is using those APIs.
> I sent patches to add the memory controller driver for pl353.
> https://www.spinics.net/lists/kernel/msg2748832.html
> https://www.spinics.net/lists/kernel/msg2748834.html
> https://www.spinics.net/lists/kernel/msg2748840.html
> 

ok, please add a reference in your cover letter to the functions that
are not yet merged and you would use in this series.


> > > +
> > > +	cmd_phase_addr = (unsigned long __force)xnand->nand_base + (
> > > +			 (((xnand->row_addr_cycles) + (xnand-
> > >col_addr_cycles))
> > > +			 << ADDR_CYCLES_SHIFT) |
> > > +			 (end_cmd_valid << END_CMD_VALID_SHIFT)
> > 	|
> > > +			 (COMMAND_PHASE)				|
> > > +			 (end_cmd << END_CMD_SHIFT)			|
> > 
> > Please don't align the '|'
> You mean, tabbing? 

Yes

> > 
> > > +			 (start_cmd << START_CMD_SHIFT));
> > > +	cmd_addr = (void __iomem * __force)cmd_phase_addr;
> > > +
> > > +	/* Get the data phase address */
> > > +	data_phase_addr = (unsigned long __force)xnand->nand_base + (
> > > +			  (0x0 << CLEAR_CS_SHIFT)			|
> > > +			  (0 << END_CMD_VALID_SHIFT)	|
> > > +			  (DATA_PHASE)					|
> > > +			  (end_cmd << END_CMD_SHIFT)			|
> > > +			  (0x0 << ECC_LAST_SHIFT));
> > > +
> > > +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> > > +	chip->IO_ADDR_W = chip->IO_ADDR_R;
> > > +	if (chip->options & NAND_BUSWIDTH_16)
> > > +		column >>= 1;
> > 
> >  / 2
> > 
> > > +	cmd_data = column;
> > > +	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> > > +		cmd_data |= page << 16;
> > > +		/* Another address cycle for devices > 128MiB */
> > > +		if (chip->chipsize > (128 << 20)) {
> > 
> > Now there is a flag for that in the core, called NAND_ROW_ADDR_3.
> I will check and update.
> > 
> > > +			pl353_nand_write32(cmd_addr, cmd_data);
> > > +			cmd_data = (page >> 16);
> > > +		}
> > > +	} else {
> > > +		cmd_data |= page << 8;
> > > +	}
> > 
> > Space
> Ok, I will update.
> > 
> > > +	pl353_nand_write32(cmd_addr, cmd_data); }
> > > +
> > > +/**
> > > + * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read
> > function
> > > + * @mtd:	Pointer to the mtd info structure
> > > + * @chip:	Pointer to the NAND chip info structure
> > > + * @page:	Page number to read
> > > + *
> > > + * Return:	Always return zero
> > > + */
> > > +static int pl353_nand_read_oob(struct mtd_info *mtd, struct nand_chip
> > *chip,
> > > +			    int page)
> > > +{
> > > +
> > > +	unsigned long data_phase_addr;
> > > +	uint8_t *p;
> > > +
> > > +	chip->pagebuf = -1;
> > > +	if (mtd->writesize < PL353_NAND_ECC_SIZE)
> > > +		return 0;
> > > +
> > > +	pl353_prepare_cmd(mtd, chip, page, mtd->writesize,
> > NAND_CMD_READ0,
> > > +		NAND_CMD_READSTART, 1);
> > 
> > Alignment
> Are you running any script apart from checkpatch?
> Any way I will correct it.

All my comments have been made "manually" without tool but you should
definitively run checkpatch.pl --strict on all your patches before
sending them.


> > > +
> > > +	return (status & NAND_STATUS_FAIL) ? -EIO : 0; }
> > > +
> > > +/**
> > > + * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
> > > + * @mtd:		Pointer to the mtd info structure
> > > + * @chip:		Pointer to the NAND chip info structure
> > > + * @buf:		Pointer to the data buffer
> > > + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> > > + * @page:		Page number to read
> > > + *
> > > + * Return:	Always return zero
> > > + */
> > > +static int pl353_nand_read_page_raw(struct mtd_info *mtd,
> > > +				struct nand_chip *chip,
> > > +				uint8_t *buf, int oob_required, int page)
> > 
> > Do you really need raw accessors?
> Yes, when using on-die ecc, this function is getting called.
> i.e. nand_micron.c is calling nand_set_features_op, with DATA_OUT_INSTR, and there
> we are using this.

I don't see any link between doing a nad_set_features_op and calling a
raw accessor. It's almost like the ->read_byte() hook, if there is
nothing specific to implement, just forget about it, ->exec_op() is
probably enough.

> > > +/**
> > > + * pl353_nand_select_chip - Select the flash device
> > > + * @mtd:	Pointer to the mtd info structure
> > > + * @chip:	Pointer to the NAND chip info structure
> > > + *
> > > + * This function is empty as the NAND controller handles chip select
> > > +line
> > > + * internally based on the chip address passed in command and data phase.
> > > + */
> > > +static void pl353_nand_select_chip(struct mtd_info *mtd, int chip) {
> > > +}
> > > +
> > > +/* NAND framework ->exec_op() hooks and related helpers */ static
> > > +void pl353_nfc_parse_instructions(struct nand_chip *chip,
> > > +					   const struct nand_subop *subop,
> > > +					   struct pl353_nfc_op *nfc_op)
> > > +{
> > > +	const struct nand_op_instr *instr = NULL;
> > > +	unsigned int op_id, offset, naddrs;
> > > +	int i;
> > > +	const u8 *addrs;
> > > +
> > > +	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
> > > +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> > > +
> > 
> > What is this for-loop for? I don't get it as you break the switch in every case?
> I think, breaking switch case only not for loop.

My bad, ok.

> > 
> > > +		nfc_op->len = nand_subop_get_data_len(subop, op_id);
> > > +
> > > +		instr = &subop->instrs[op_id];
> > > +		if (subop->ninstrs == 1)
> > > +			nfc_op->cmnds[0] = -1;
> > > +		switch (instr->type) {
> > > +		case NAND_OP_CMD_INSTR:
> > > +			nfc_op->type = NAND_OP_CMD_INSTR;
> > > +			nfc_op->end_cmd = op_id - 1;
> > > +			if (op_id)
> > 
> > You should put { } on the if also if the else statement needs braces.
> Ok, but I didn't see any warning from checkpatch.

Maybe with the --strict option?
Otherwise this is clearly stated in the kernel coding style
documentation.


> > > +static const struct nand_op_parser pl353_nfc_op_parser =
> > NAND_OP_PARSER(
> > > +	NAND_OP_PARSER_PATTERN(
> > > +		pl353_nand_cmd_function,
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> > > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
> > > +	 NAND_OP_PARSER_PATTERN(
> > > +		pl353_nand_cmd_function,
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> > > +	NAND_OP_PARSER_PATTERN(
> > > +		pl353_nand_cmd_function,
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
> > > +	 NAND_OP_PARSER_PATTERN(
> > > +		pl353_nand_cmd_function,
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> > > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> > > +	NAND_OP_PARSER_PATTERN(
> > > +		pl353_nand_cmd_function,
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> > > +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> > > +	NAND_OP_PARSER_PATTERN(
> > > +		pl353_nand_cmd_function,
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> > > +	NAND_OP_PARSER_PATTERN(
> > > +		pl353_nand_cmd_function,
> > > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> > > +	NAND_OP_PARSER_PATTERN(
> > > +		pl353_nand_cmd_function,
> > > +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> > 
> > I am pretty sure you can factorize all these patterns now. Use the "optional"
> > parameter for that.
> Can you explain little bit?  I didn't get.

All the patterns refer to the same function. This is fine.
But maybe you can factorize the parents using the "optional" parameter.
For example, if you have
* CMD + ADDR + DATA_IN
* CMD + DATA_IN
Maybe you can just state:
* CMD + [ADDR] + DATA_IN
With "[]" meaning the element is optional.


Thanks for addressing these comments.

Regards,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
