Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD209C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8810F223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8810F223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeKLUvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:51:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43064 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbeKLUvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:51:07 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 19455207BD; Mon, 12 Nov 2018 11:58:21 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A8550206D8;
        Mon, 12 Nov 2018 11:58:10 +0100 (CET)
Date:   Mon, 12 Nov 2018 11:58:10 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Martin Lund <martin.lund@keep-it-simple.com>
Cc:     naga.sureshkumar.relli@xilinx.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, michals@xilinx.com, nagasuresh12@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20181112115810.6f931cfb@bbrezillon>
In-Reply-To: <CAB7pii1WbALtH1AHjocpC976ytrCV5gM6JGXawoN--scvEx8Mw@mail.gmail.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <CAB7pii1WbALtH1AHjocpC976ytrCV5gM6JGXawoN--scvEx8Mw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 11:55:36 +0100
Martin Lund <martin.lund@keep-it-simple.com> wrote:

> Hi Naga,
> 
> Just a few review comments for the v12 version.
> 
> On Fri, Nov 9, 2018 at 6:00 AM Naga Sureshkumar Relli
> <naga.sureshkumar.relli@xilinx.com> wrote:
> > +#define PKT_OFST               0x00
> > +#define PKT_CNT_SHIFT          12
> > +
> > +#define MEM_ADDR1_OFST         0x04
> > +#define MEM_ADDR2_OFST         0x08  
> 
> For the sake of readability I think *_OFFSET is preferred, especially
> since the driver already includes short macro names. I think this is
> similar to the EVNT vs EVENT point.
> The majority of drivers in the Linux kernel do not shorten OFFSET -> OFST.
> 
> 
> > +static void anfc_rw_pio_op(struct mtd_info *mtd, u8 *buf, int len,
> > +                          bool do_read, int prog, int pktcount, int pktsize)
> > +{
> > +       struct nand_chip *chip = mtd_to_nand(mtd);
> > +       struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> > +       struct anfc_nand_chip *achip = to_anfc_nand(chip);
> > +       u32 *bufptr = (u32 *)buf;
> > +       u32 cnt = 0, intr = 0;
> > +
> > +       anfc_config_dma(nfc, 0);
> > +
> > +       if (pktsize == 0)
> > +               pktsize = len;
> > +
> > +       anfc_setpktszcnt(nfc, pktsize, pktcount);
> > +
> > +       if (!achip->strength)
> > +               intr = MBIT_ERROR;
> > +
> > +       if (do_read)
> > +               intr |= READ_READY;
> > +       else
> > +               intr |= WRITE_READY;
> > +       anfc_enable_intrs(nfc, intr);
> > +       writel(prog, nfc->base + PROG_OFST);
> > +       while (cnt < pktcount) {
> > +               anfc_wait_for_event(nfc);
> > +               cnt++;
> > +               if (cnt == pktcount)
> > +                       anfc_enable_intrs(nfc, XFER_COMPLETE);
> > +               if (do_read)
> > +                       ioread32_rep(nfc->base + DATA_PORT_OFST, bufptr,
> > +                                    pktsize / 4);
> > +               else
> > +                       iowrite32_rep(nfc->base + DATA_PORT_OFST, bufptr,
> > +                                     pktsize / 4);
> > +               bufptr += (pktsize / 4);
> > +               if (cnt < pktcount)
> > +                       anfc_enable_intrs(nfc, intr);
> > +       }
> > +       anfc_wait_for_event(nfc);
> > +}  
> 
> Throughout the driver all calls to anfc_wait_for_event() ignores the
> timeout return value. It would be nice to see some error handling in
> case it times out - at minimum consider printing out an error message
> since timeout on NAND operations are fairly critical and should
> generally not occur. Perhaps even an argument can be made for
> returning -ETIMEDOUT in case of timeout.

Yes please, check anfc_wait_for_event() return code and propagate the
error to the upper layer.
