Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB47C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BF120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BF120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeLJKTQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:19:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54048 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbeLJKTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:19:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2CD4320CE3; Mon, 10 Dec 2018 11:19:12 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB15720711;
        Mon, 10 Dec 2018 11:19:11 +0100 (CET)
Date:   Mon, 10 Dec 2018 11:19:09 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181210111909.35384eee@bbrezillon>
In-Reply-To: <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
        <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 09:41:51 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > +/* Instead of busy looping invoke readl_poll_timeout functionality.
> > > +*/ static int fspi_readl_poll_tout(struct nxp_fspi *f, void __iomem *base,
> > > +				u32 mask, u32 delay_us,
> > > +				u32 timeout_us, bool condition)
> > > +{
> > > +	u32 reg;
> > > +
> > > +	if (!f->devtype_data->little_endian)
> > > +		mask = (u32)cpu_to_be32(mask);
> > > +
> > > +	if (condition)
> > > +		return readl_poll_timeout(base, reg, (reg & mask),
> > > +					  delay_us, timeout_us);
> > > +	else
> > > +		return readl_poll_timeout(base, reg, !(reg & mask),
> > > +					  delay_us, timeout_us);  
> > 
> > I would rather use a local variable to store the condition:
> > 
> > bool c = condition ? (reg & mask):!(reg & mask);
> >   
> With these type of usage getting below warning messages.
>  
> drivers/spi/spi-nxp-fspi.c: In function ‘fspi_readl_poll_tout.isra.10.constprop’:
> drivers/spi/spi-nxp-fspi.c:446:21: warning: ‘reg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   bool cn = c ? (reg & mask) : !(reg & mask);
> 
> If assign value to reg = 0xffffffff then timeout is start getting hit for False case and if assign value 0 then start getting timeout hit for true case.
> 
> I would rather not try to modify this function.

I agree. Let's keep this function readable even if this implies
duplicating a few lines of code.

> 
> > return readl_poll_timeout(base, reg, c, delay_us, timeout_us);
> >   
> > > +}
> > > +
> > > +/*
> > > + * If the slave device content being changed by Write/Erase, need to
> > > + * invalidate the AHB buffer. This can be achieved by doing the reset
> > > + * of controller after setting MCR0[SWRESET] bit.
> > > + */
> > > +static inline void nxp_fspi_invalid(struct nxp_fspi *f) {
> > > +	u32 reg;
> > > +	int ret;
> > > +
> > > +	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
> > > +	fspi_writel(f, reg | FSPI_MCR0_SWRST, f->iobase + FSPI_MCR0);
> > > +
> > > +	/* w1c register, wait unit clear */
> > > +	ret = fspi_readl_poll_tout(f, f->iobase + FSPI_MCR0,
> > > +				   FSPI_MCR0_SWRST, 0, POLL_TOUT, false);
> > > +	WARN_ON(ret);
> > > +}
> > > +
> > > +static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
> > > +				 const struct spi_mem_op *op)
> > > +{
> > > +	void __iomem *base = f->iobase;
> > > +	u32 lutval[4] = {};
> > > +	int lutidx = 1, i;
> > > +
> > > +	/* cmd */
> > > +	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> > > +			     op->cmd.opcode);
> > > +
> > > +	/* addr bus width */
> > > +	if (op->addr.nbytes) {
> > > +		u32 addrlen = 0;
> > > +
> > > +		switch (op->addr.nbytes) {
> > > +		case 1:
> > > +			addrlen = ADDR8BIT;
> > > +			break;
> > > +		case 2:
> > > +			addrlen = ADDR16BIT;
> > > +			break;
> > > +		case 3:
> > > +			addrlen = ADDR24BIT;
> > > +			break;
> > > +		case 4:
> > > +			addrlen = ADDR32BIT;
> > > +			break;
> > > +		default:
> > > +			dev_err(f->dev, "In-correct address length\n");
> > > +			return;
> > > +		}  
> > 
> > You don't need to validate op->addr.nbytes here, this is already done in
> > nxp_fspi_supports_op().  
> 
> Yes, I need to validate op->addr.nbytes else LUT would going to be programmed for 0 addrlen.
> I have checked this on the target.

Also agree there. Some operations have 0 address bytes. We could also
test addr.buswidth, but I'm fine with the addr.nbytes test too.


> > > +static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device
> > > +*spi) {
> > > +	unsigned long rate = spi->max_speed_hz;
> > > +	int ret;
> > > +	uint64_t size_kb;
> > > +
> > > +	/*
> > > +	 * Return, if previously selected slave device is same as current
> > > +	 * requested slave device.
> > > +	 */
> > > +	if (f->selected == spi->chip_select)
> > > +		return;
> > > +
> > > +	/* Reset FLSHxxCR0 registers */
> > > +	fspi_writel(f, 0, f->iobase + FSPI_FLSHA1CR0);
> > > +	fspi_writel(f, 0, f->iobase + FSPI_FLSHA2CR0);
> > > +	fspi_writel(f, 0, f->iobase + FSPI_FLSHB1CR0);
> > > +	fspi_writel(f, 0, f->iobase + FSPI_FLSHB2CR0);
> > > +
> > > +	/* Assign controller memory mapped space as size, KBytes, of flash. */
> > > +	size_kb = FSPI_FLSHXCR0_SZ(f->memmap_phy_size);  
> >   
> Above description of this function, explains the reason for using memmap_phy_size.
> This is not the arbitrary size, but the memory mapped size being assigned to the controller.
> 
> > You are still using memory of arbitrary size (memmap_phy_size) for mapping the
> > flash. Why not use the same approach as in the QSPI driver and just map
> > ahb_buf_size until we implement the dirmap API?  
> The approach which being used in QSPI driver didn't work here, I have tried with that.
> In QSPI driver, while preparing LUT we are assigning read/write address in the LUT preparation and have to for some unknown hack have to provide macro for LUT_MODE instead of LUT_ADDR.
> But this thing didn't work for FlexSPI.
> I discussed with HW IP owner and they suggested only to use LUT_ADDR for specifying the address length of the command i.e. 3-byte or 4-byte address command (NOR) or 1-2 byte address command for NAND.

Actually, we would have used a LUT_ADDR too if the QSPI IP was support
ADDR instructions with a number of bytes < 3, but for some unknown
reasons it does not work. 

> 
> Thus, in LUT preparation we have assigned only the base address.
> Now if I have assigned ahb_buf_size to FSPI_FLSHXXCR0 register then for read/write data beyond limit of ahb_buf_size offset I get data corruption.

Why would you do that? We have the ->adjust_op_size() exactly for this
reason, so, if someone tries to do a spi_mem_op with data.nbytes >
ahb_buf_size you should return an error.

> 
> Thus, for generic approach have assigned FSPI_FLSHXXCR0 equal to the memory mapped size to the controller. This would also not going to depend on the number of CS present on the target.

I kind of agree with Frieder on that one, I think it's preferable to
limit the per-read-op size to ahb_buf_size and let the upper layer
split the request in several sub-requests. On the controller side of
things, you just have to have a mapping of ahb_buf_size per-CS. If you
want to further optimize things, implement the dirmap hooks.

> 
> > You are already aligning the AHB reads for this in nxp_fspi_adjust_op_size().
> >   
> Yes, max read data size can be ahb_buf_size. Thus we need to check max read size with ahb_buf_size.

Well, it's never a bad thing to check it twice, just in case the
spi-mem user is misusing the API.

> > > +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
> > > +				 const struct spi_mem_op *op)
> > > +{
> > > +	void __iomem *base = f->iobase;
> > > +	int i, j, ret;
> > > +	int size, tmp_size, wm_size;
> > > +	u32 data = 0;
> > > +	u32 *txbuf = (u32 *) op->data.buf.out;
> > > +
> > > +	/* clear the TX FIFO. */
> > > +	fspi_writel(f, FSPI_IPTXFCR_CLR, base + FSPI_IPTXFCR);
> > > +
> > > +	/* Default value of water mark level is 8 bytes. */
> > > +	wm_size = 8;
> > > +	size = op->data.nbytes / wm_size;
> > > +	for (i = 0; i < size; i++) {
> > > +		/* Wait for TXFIFO empty */
> > > +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > > +					   FSPI_INTR_IPTXWE, 0,
> > > +					   POLL_TOUT, true);
> > > +		WARN_ON(ret);
> > > +
> > > +		j = 0;
> > > +		tmp_size = wm_size;
> > > +		while (tmp_size > 0) {
> > > +			data = 0;
> > > +			memcpy(&data, txbuf, 4);
> > > +			fspi_writel(f, data, base + FSPI_TFDR + j * 4);
> > > +			tmp_size -= 4;
> > > +			j++;
> > > +			txbuf += 1;
> > > +		}
> > > +		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
> > > +	}
> > > +
> > > +	size = op->data.nbytes % wm_size;
> > > +	if (size) {
> > > +		/* Wait for TXFIFO empty */
> > > +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > > +					   FSPI_INTR_IPTXWE, 0,
> > > +					   POLL_TOUT, true);
> > > +		WARN_ON(ret);
> > > +
> > > +		j = 0;
> > > +		tmp_size = 0;
> > > +		while (size > 0) {
> > > +			data = 0;
> > > +			tmp_size = (size < 4) ? size : 4;
> > > +			memcpy(&data, txbuf, tmp_size);
> > > +			fspi_writel(f, data, base + FSPI_TFDR + j * 4);
> > > +			size -= tmp_size;
> > > +			j++;
> > > +			txbuf += 1;
> > > +		}
> > > +		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
> > > +	}  
> > 
> > All these nested loops to fill the TX buffer and also the ones below to read the
> > RX buffer look much more complicated than they should really be. Can you try to
> > make this more readable?  
> Yes
> > 
> > Maybe something like this would work:
> > 
> > for (i = 0; i < ALIGN_DOWN(op->data.nbytes, 8); i += 8) {
> > 	/* Wait for TXFIFO empty */
> > 	ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > 				   FSPI_INTR_IPTXWE, 0,
> > 				   POLL_TOUT, true);
> > 
> > 	fspi_writel(f, op->data.buf.out + i, base + FSPI_TFDR);
> > 	fspi_writel(f, op->data.buf.out + i + 4, base + FSPI_TFDR + 4);
> > 	fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR); }  
> With this above 2 lines we are hardcoding it for read/write with watermark size as 8 bytes.
> Watermark size can be variable and depends on the value of IPRXFCR/IPTXFCR register with default value as 8 bytes
> Thus, I would still prefer to use the internal for loop instead of 2 fspi_writel(...) for FSPI_TFDR and FSPI_TFDR + 4 register write commands.

Just like you're hardcoding wm_size to 8, so I don't see a difference
here. And I indeed prefer Frieder's version.
