Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080E7C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D366217B9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D366217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeHDL4Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:56:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37020 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeHDL4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:56:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 26F54207AB; Sat,  4 Aug 2018 11:56:02 +0200 (CEST)
Received: from xps13 (AToulouse-657-1-1031-177.w92-134.abo.wanadoo.fr [92.134.9.177])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4CE4E206ED;
        Sat,  4 Aug 2018 11:56:01 +0200 (CEST)
Date:   Sat, 4 Aug 2018 11:56:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.co" <ada@thorsis.co>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: Re: [LINUX PATCH v11 3/3] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Message-ID: <20180804115602.2f44c007@xps13>
In-Reply-To: <MWHPR02MB26231B9223265E914250FACCAF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1531294612-29526-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180729211532.58c80a20@xps13>
 <MWHPR02MB26231B9223265E914250FACCAF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

> > > +/**
> > > + * pl353_nand_read_data_op - read chip data into buffer
> > > + * @chip:	Pointer to the NAND chip info structure
> > > + * @in:		Pointer to the buffer to store read data
> > > + * @len:	Number of bytes to read
> > > + * Return:	Always return zero
> > > + */
> > > +static int pl353_nand_read_data_op(struct nand_chip *chip,
> > > +				   u8 *in,
> > > +				   unsigned int len)
> > > +{
> > > +	int i;
> > > +	struct pl353_nand_info *xnfc =
> > > +		container_of(chip, struct pl353_nand_info, chip);
> > > +
> > > +	if (IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
> > > +	    IS_ALIGNED(len, sizeof(uint32_t))) {
> > > +		u32 *ptr = (u32 *)in;
> > > +
> > > +		len /= 4;
> > > +		for (i = 0; i < len; i++)
> > > +			ptr[i] = readl(xnfc->nandaddr);
> > > +	} else {
> > > +		for (i = 0; i < len; i++)
> > > +			in[i] = readb(xnfc->nandaddr);
> > > +	}  
> > 
> > What about reading 0-3 bytes with readb if the driver is not aligned, then doing aligned
> > access with readl until readb must be used again for the last 0-3 bytes?  
> The else case is handling that right?

No it's not. The else case reads byte per byte, always.

[...]

> > > +static int pl353_nand_calculate_hwecc(struct mtd_info *mtd,
> > > +				      const u8 *data, u8 *ecc)
> > > +{
> > > +	u32 ecc_value;
> > > +	u8 ecc_reg, ecc_byte, ecc_status;
> > > +	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> > > +
> > > +	/* Wait till the ECC operation is complete or timeout */
> > > +	do {
> > > +		if (pl353_smc_ecc_is_busy())
> > > +			cpu_relax();
> > > +		else
> > > +			break;
> > > +	} while (!time_after_eq(jiffies, timeout));
> > > +
> > > +	if (time_after_eq(jiffies, timeout)) {
> > > +		pr_err("%s timed out\n", __func__);
> > > +		return -ETIMEDOUT;
> > > +	}  
> > 
> > All of this should be done by the function calling nand_calculate_hwecc(), not here.  
> Ok, I will update it.
> > 
> > Plus, it should deserve a function on its own.  
> Ok, will add new one.
> >   
> > > +
> > > +	for (ecc_reg = 0; ecc_reg < 4; ecc_reg++) {
> > > +		/* Read ECC value for each block */  
> > 
> > So you assume here that there are 4, and only 4 "blocks" (I prefer "ECC chunks" or
> > "subpages"). Is it always the case? Or is it just how it works in your situation? I would rather
> > prefer a to define this value anyway.  
> Sure, I will define a macro as ECC chunks to represent 4.
> And there are always 4 ECC registers as per the controller. And there is no assumption here.

What about smaller or larger NAND chips? Maybe there are some
limitations in what chips are actually supported, then they should be
rejected.


[...]

> > > +static void pl353_prepare_cmd(struct mtd_info *mtd, struct
nand_chip *chip,
> > > +			      int page, int column, int start_cmd, int end_cmd,
> > > +			      bool read)
> > > +{
> > > +	unsigned long data_phase_addr;
> > > +	u32 end_cmd_valid = 0;
> > > +	unsigned long cmd_phase_addr = 0, cmd_data = 0;
> > > +
> > > +	struct pl353_nand_info *xnfc =
> > > +		container_of(chip, struct pl353_nand_info, chip);
> > > +
> > > +	end_cmd_valid = read ? 1 : 0;
> > > +
> > > +	cmd_phase_addr = (unsigned long __force)xnfc->nand_base +  
> > 
> > do you really need this cast?  
> As I said above, during command and data phases, we have to update the AXI Read/Write addresses with cycles, start command, end command
> And some extra info. Hence I am converting it to a value and then adding the above values and then again converting back as an
> Address.
> 
> >   
> > > +			 ((xnfc->addr_cycles
> > > +			 << ADDR_CYCLES_SHIFT) |
> > > +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> > > +			 (COMMAND_PHASE) |
> > > +			 (end_cmd << END_CMD_SHIFT) |
> > > +			 (start_cmd << START_CMD_SHIFT));  
> > 
> > So the number of address cycles changes the address where you should write the address
> > cycles? that's weird, no?  
> I agree, but the implementation of PL353 is like that.
> As I pointed the spec above, for every transfer we have to frame AXI Write address and Read address.
> 
> >   
> > > +
> > > +	/* Get the data phase address */
> > > +	data_phase_addr = (unsigned long __force)xnfc->nand_base +
> > > +			  ((0x0 << CLEAR_CS_SHIFT) |
> > > +			  (0 << END_CMD_VALID_SHIFT) |
> > > +			  (DATA_PHASE) |
> > > +			  (end_cmd << END_CMD_SHIFT) |
> > > +			  (0x0 << ECC_LAST_SHIFT));
> > > +  
> > Same question here?
> >   
> > > +	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;  
> > 
> > This should be done only once in the probe  
> No, as explained above, once we frame the Axi Write address/Read address with valid data, then we
> Are converting back as memory address with the casting.
> Do you see any issues with that?
> Let me know, is there an alternative to achieve the same. 
> All is about, constructing AXI Write address and Read address during command and data phases.

Ok, I'll ask Boris to also review your next version, once -rc1 is out.

Thanks,
Miquèl
