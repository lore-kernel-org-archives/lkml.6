Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7080DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28013214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28013214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeHUKu2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:50:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34161 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeHUKu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:50:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3505E20787; Tue, 21 Aug 2018 09:31:25 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id A5907204AE;
        Tue, 21 Aug 2018 09:31:24 +0200 (CEST)
Date:   Tue, 21 Aug 2018 09:31:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20180821093125.05fb46a4@xps13>
In-Reply-To: <MWHPR02MB26235AF18211E3FB39076396AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180820184013.57fd7b5c@bbrezillon>
        <MWHPR02MB26235AF18211E3FB39076396AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

> > And why is it an s32 and not a u32?  
> To monitor NAND_CMD_STATUS.
> Sometimes core will just send status command without reading back the status data and later
> It will try to read one byte using ->exec_op().
> So Arasan has FLASH_STS register and whenever we initiate a status command, the controller
> Will update this register with the value returned by the flash device.
> So we need to return this value when core is asking about 1 byte status value without issuing the command.
> And in driver we are using memset(nfc_op, 0, sizeof(struct anfc_op)), this will make cmnds[4] to zeros but 0x0 is also
> NAND_CMD_READ0, so inorder to differentiate whether to give status data or not, I just assigned 
> 	nfc_op->cmnds[0] = NAND_CMD_NONE;
> 
> May be this case we can now eliminate as per your suggestion(defining a separate hook for each pattern) and thanks for that.
> >   
> > > +	u32 type;
> > > +	u32 len;
> > > +	u32 naddrs;
> > > +	u32 col;
> > > +	u32 row;
> > > +	unsigned int data_instr_idx;
> > > +	unsigned int rdy_timeout_ms;
> > > +	unsigned int rdy_delay_ns;
> > > +	const struct nand_op_instr *data_instr; };  
> > 
> > Please make sure you actually need to redefine all these fields. Looks like some them could be
> > extracted directly from the nand_op_instr objects.  
> Ok, all these values are getting updated in anfc_parse_instructions()

In anfc_parse_instructions():

+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;

This looks pointless.

+			nfc_op->data_instr_idx = op_id;
+			break;
+		case NAND_OP_DATA_OUT_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			break;
+		case NAND_OP_WAITRDY_INSTR:
+			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;

This one also.

+			nfc_op->rdy_delay_ns = instr->delay_ns;

And this one too.

Once you'll have a per pattern callback, I suppose you won't need it
anymore.

> >   
> > > +
> > > +/**
> > > + * struct anfc_nand_chip - Defines the nand chip related information
> > > + * @node:		used to store NAND chips into a list.
> > > + * @chip:		NAND chip information structure.
> > > + * @bch:		Bch / Hamming mode enable/disable.
> > > + * @bchmode:		Bch mode.  
> > 
> > What's the difference between bch and bchmode?  
> @bch -> to select error correction method(either BCH or Hamming)
> @bchmode -> to select ECC correctability (4/8/12/24 bit ECC)

Then something like "strength" or "ecc_strength" would be more
meaningful.


Thanks,
Miquèl
