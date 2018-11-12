Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBFDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020982241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020982241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbeKMCHs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:07:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52020 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbeKMCHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:07:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF088207CF; Mon, 12 Nov 2018 17:13:51 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4923320701;
        Mon, 12 Nov 2018 17:13:51 +0100 (CET)
Date:   Mon, 12 Nov 2018 17:13:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Liang Yang <liang.yang@amlogic.com>, Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        Yixun Lan <yixun.lan@amlogic.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-mtd@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v6 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181112171351.4ac3506b@xps13>
In-Reply-To: <20181106112206.65a70a81@bbrezillon>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
        <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
        <20181105165321.7ea2b45f@bbrezillon>
        <a571904e-6296-bf62-e1fe-e25bf90040bb@amlogic.com>
        <20181106102851.61deb97a@bbrezillon>
        <ff02373e-c97b-182d-5b43-83d1e8f6d51a@amlogic.com>
        <20181106112206.65a70a81@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Tue, 6 Nov 2018
11:22:06 +0100:

> On Tue, 6 Nov 2018 18:00:37 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
> > On 2018/11/6 17:28, Boris Brezillon wrote:  
> > > On Tue, 6 Nov 2018 17:08:00 +0800
> > > Liang Yang <liang.yang@amlogic.com> wrote:
> > >     
> > >> On 2018/11/5 23:53, Boris Brezillon wrote:    
> > >>> On Fri, 2 Nov 2018 00:42:21 +0800
> > >>> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> > >>>        
> > >>>> +
> > >>>> +static inline u8 meson_nfc_read_byte(struct mtd_info *mtd)
> > >>>> +{
> > >>>> +	struct nand_chip *nand = mtd_to_nand(mtd);
> > >>>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> > >>>> +	u32 cmd;
> > >>>> +
> > >>>> +	cmd = nfc->param.chip_select | NFC_CMD_DRD | 0;
> > >>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> > >>>> +
> > >>>> +	meson_nfc_drain_cmd(nfc);    
> > >>>
> > >>> You probably don't want to drain the FIFO every time you read a byte on
> > >>> the bus, and I guess the INPUT FIFO is at least as big as the CMD
> > >>> FIFO, right? If that's the case, you should queue as much DRD cmd as
> > >>> possible and only sync when the user explicitly requests it or when
> > >>> the INPUT/READ FIFO is full.
> > >>>        
> > >> Register 'NFC_REG_BUF' can holds only 4 bytes, also DRD sends only one
> > >> nand cycle to read one byte and covers the 1st byte every time reading.
> > >> i think nfc controller is faster than nand cycle, but really it is not
> > >> high efficiency when reading so many bytes once.
> > >> Or use dma command here like read_page and read_page_raw.    
> > > 
> > > Yep, that's also an alternative, though you'll have to make sure the
> > > buffer passed through the nand_op_inst is DMA-safe, and use a bounce
> > > buffer when that's not the case.
> > >     
> > ok, i will try dma here.  
> 
> We should probably expose the bounce buf handling as generic helpers at
> the rawnand level:
> 
> void *nand_op_get_dma_safe_input_buf(struct nand_op_instr *instr)
> {
> 	void *buf;
> 
> 	if (WARN_ON(instr->type != NAND_OP_DATA_IN_INSTR))
> 		return NULL;
> 
> 	if (virt_addr_valid(instr->data.in) &&
> 	    !object_is_on_stack(instr->data.buf.in))
> 		return instr->data.buf.in;
> 
> 	return kzalloc(instr->data.len, GFP_KERNEL);
> }
> 
> void nand_op_put_dma_safe_input_buf(struct nand_op_instr *instr,
> 				    void *buf)
> {
> 	if (WARN_ON(instr->type != NAND_OP_DATA_IN_INSTR) ||
> 	    WARN_ON(!buf))
> 		return;
> 
> 	if (buf == instr->data.buf.in)
> 		return;
> 
> 	memcpy(instr->data.buf.in, buf, instr->data.len);
> 	kfree(buf);
> }
> 
> const void *nand_op_get_dma_safe_output_buf(struct nand_op_instr *instr)
> {
> 	void *buf;
> 
> 	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR))
> 		return NULL;
> 
> 	if (virt_addr_valid(instr->data.out) &&
> 	    !object_is_on_stack(instr->data.buf.out))
> 		return instr->data.buf.out;
> 
> 	return kmemdup(instr->data.buf.out, GFP_KERNEL);
> }
> 
> void nand_op_put_dma_safe_output_buf(struct nand_op_instr *instr,
> 				    void *buf)
> {
> 	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR) ||
> 	    WARN_ON(!buf))
> 		return;
> 
> 	if (buf != instr->data.buf.out)
> 		kfree(buf);
> }

Not that I am against such function, but maybe they should come with
comments stating that there is no reliable way to find if a buffer is
DMA-able at runtime and these are just sanity checks (ie. required, but
probably not enough). This is my understanding of Wolfram's recent talk
at ELCE [1]. I suppose using the CONFIG_DMA_API_DEBUG option could help
more reliably to find such issues.

[1] https://www.youtube.com/watch?v=JDwaMClvV-s

Thanks,
Miquèl
