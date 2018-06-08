Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id u4E7A6t7GlsNEAAAmS7hNA
	; Fri, 08 Jun 2018 12:51:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 66E42608B8; Fri,  8 Jun 2018 12:51:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6A0CB606FA;
	Fri,  8 Jun 2018 12:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A0CB606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbeFHMvo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:51:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751265AbeFHMvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:51:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6AE5020850; Fri,  8 Jun 2018 14:51:40 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 035C9203EC;
        Fri,  8 Jun 2018 14:51:29 +0200 (CEST)
Date: Fri, 8 Jun 2018 14:51:30 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Message-ID: <20180608145130.09f979f9@bbrezillon>
In-Reply-To: <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Fri, 8 Jun 2018 11:54:12 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Frieder,
> 
> I have tried to validate your patch on fsl,ls2080a target having 2 Spansion NOR flash, S25FS512S, as slave device.
> Below are my observations:
> 
> Observation 1:
> In Linux boot logs after driver probing is successful, getting below log messages
> [    1.435986] m25p80 spi0.0: found s25fl512s, expected m25p80
> [    1.441564] m25p80 spi0.0: s25fl512s (65536 Kbytes)
> [    1.446972] m25p80 spi0.1: found s25fl512s, expected m25p80
> [    1.452548] m25p80 spi0.1: s25fl512s (65536 Kbytes)
> 
> IMHO, we need to correct message as 'found s25fl512s, expected m25p80' as final underlying connected flash device is s25fl512s.

Not sure what you mean here. What would you like us to fix exactly?

> 
> Observation 2:
> I have observed data sanity issue after performing read/write operations using MTD interface. Explained below
> 
> root:~# mtd_debug erase /dev/mtd0 0x1000000 0x40000
> Erased 262144 bytes from address 0x01000000 in flash                      --> Erase at address 0x1000000 of erase size 0x40000
> root:~# mtd_debug read /dev/mtd0 0x0 0x100 rp
> Copied 256 bytes from address 0x00000000 in flash to rp                   --> Read 0x100 bytes from flash from address 0x0 in file rp
> root:~# mtd_debug write /dev/mtd0 0x1000000 0x100 rp
> Copied 256 bytes from rp to address 0x01000000 in flash                   --> Write 0x100 bytes to flash address 0x1000000 from file rp
> root:~# mtd_debug read /dev/mtd0 0x1000000 0x100 wp
> Copied 256 bytes from address 0x01000000 in flash to wp                  --> Read 0x100 bytes from flash from address 0x1000000 in file wp
> root:~# diff rp wp                                                                                           --> compare both rp and wp files, if they are different output comes on console stating file are different
> Files rp and wp differ
> root:~# hexdump wp
> 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> 0000040 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0000100
> root:~# hexdump rp
> 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> 0000040 2403 0000 0000 0000 0000 0000 0000 0000
> 0000050 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0000070 0011 0000 09e7 0000 0000 4411 9555 0050
> 0000080 0000 0000 0000 0000 f9bc afa1 0404 31e0
> 0000090 0000 0000 0400 31e0 0000 2010 08dc 31eb
> 00000a0 2880 0050 1300 31eb 4e20 8010 0000 80ff
> 00000b0 0000 0000 beef dead beef dead beef dead
> 00000c0 beef dead beef dead beef dead beef dead
> *
> 0000100
> root:~#
> 
> In hexdump output of the file which being read from address 0x1000000,wp, it can be observed that only first 64 bytes (0x40) are written on the flash.
> 
> Observation 3:
> As we can support JFFS2 filesystem on NOR flash, so we can expect JFFS2 commands should work fine on NOR flash.
> But with this driver change my mount command is not working.
> 
> In my target there are 2 flash slave devices connected, and I have given argument to create MTD partition like "mtdparts=20c0000.quadspi-1:5M(rcw),10M(test),46M(rootfs) " for 2nd flash.
> Below is output for /proc/mtd commands
>     root@ls1012ardb:~# cat /proc/mtd
>     dev:    size   erasesize  name
>     mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flash
>     mtd1: 00500000 00040000 "rcw"                               --> Second 64 MB flash device, 3 MTD partition are created for it.
>     mtd2: 00a00000 00040000 "test"
>     mtd3: 02e00000 00040000 "rootfs"
> 
>     root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
>     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please use it
>     Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: crng init done
>     Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
>     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
> 
> This command didn't finish successfully and there are lot of messages coming on console mentioning failure in jffs2_scan_eraseblock()
>     [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0000: 0x2886 instead
>     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0004: 0x7a3b instead
>     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0008: 0xb10f instead
> 
> If I remove this patch series and check with older implementation, JFFS2 mounting is working fine.

Problems 2 and 3 should definitely be fixed. That's weird because I
remember that Frieder tested the new driver with a NOR chip, maybe not
with JFFS2 though.

> 
> Observation 4:
> With previous driver, we can read content of flash directly using devmem command
> Like devmem 0x20000000  "Flash is connected at this Quad-SPI address"
> 
> But with new driver devmem interface reporting in-correct value.

This one is clearly not something we should fix. What you were doing is
unsafe (accessing the direct mapping from userspace without making sure
you're the only one to access the device), and making it even more
broken is IMO a better thing. You want to access the memory from
user-space, just use the standard MTD interface (/dev/mtdX).

[...]

> +
> +static void fsl_qspi_prepare_lut(struct fsl_qspi *q,
> +				 const struct spi_mem_op *op)
> +{
> +	void __iomem *base = q->iobase;
> +	u32 lutval[4] = {};
> +	int lutidx = 1, i;
> +
> +	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> +			     op->cmd.opcode);
> +
> +	/*
> +	 * For some unknown reason, using LUT_ADDR doesn't work in some
> +	 * cases (at least with only one byte long addresses), so
> +	 * let's use LUT_MODE to write the address bytes one by one
> +	 */
> +	for (i = 0; i < op->addr.nbytes; i++) {
> +		u8 addrbyte = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
> +
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_MODE,
> +					      LUT_PAD(op->addr.buswidth),
> +					      addrbyte);
> +		lutidx++;
> +	}
> +
> 
> For ADDR filling in LUT we should use LUT_ADDR only, needs to find out the reason for the issue and we shouldn't use LUT_MODE here.

Just try with a 16-bit address and you'll see it does not work. I don't
know why, and it's more something you should ask to someone working at
NXP ;-).

> I have few more comments regarding same, mentioned below.
> 
> +	if (op->dummy.nbytes) {
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
> +					      LUT_PAD(op->dummy.buswidth),
> +					      op->dummy.nbytes * 8 /
> +					      op->dummy.buswidth);
> +		lutidx++;
> +	}
> +
> +	if (op->data.nbytes) {
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx,
> +					      op->data.dir == SPI_MEM_DATA_IN ?
> +					      LUT_FSL_READ : LUT_FSL_WRITE,
> +					      LUT_PAD(op->data.buswidth),
> +					      0);
> +		lutidx++;
> +	}
> +
> +	lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_STOP, 0, 0);
> +
> +	/* unlock LUT */
> +	qspi_writel(q, QUADSPI_LUTKEY_VALUE, q->iobase + QUADSPI_LUTKEY);
> +	qspi_writel(q, QUADSPI_LCKER_UNLOCK, q->iobase + QUADSPI_LCKCR);
> +
> +	/* fill LUT */
> +	for (i = 0; i < ARRAY_SIZE(lutval); i++)
> +		qspi_writel(q, lutval[i], base + QUADSPI_LUT_REG(i));
> +
> +	/* lock LUT */
> +	qspi_writel(q, QUADSPI_LUTKEY_VALUE, q->iobase + QUADSPI_LUTKEY);
> +	qspi_writel(q, QUADSPI_LCKER_LOCK, q->iobase + QUADSPI_LCKCR); }
> +

[...]

> +static int fsl_qspi_exec_op(struct spi_mem *mem, const struct 
> +spi_mem_op *op) {
> +	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->master);
> +	void __iomem *base = q->iobase;
> +	int err = 0;
> +
> +	mutex_lock(&q->lock);
> +
> +	/* wait for the controller being ready */
> +	do {
> +		u32 status;
> +
> +		status = qspi_readl(q, base + QUADSPI_SR);
> +		if (status &
> +		    (QUADSPI_SR_IP_ACC_MASK | QUADSPI_SR_AHB_ACC_MASK)) {
> +			udelay(1);
> +			dev_dbg(q->dev, "The controller is busy, 0x%x\n",
> +				status);
> +			continue;
> +		}
> +		break;
> +	} while (1);
> +
> +	fsl_qspi_select_mem(q, mem->spi);
> +
> +	qspi_writel(q, q->memmap_phy, base + QUADSPI_SFAR);
> 
> SFAR should have the actual address where we are doing operation.

Not with the new approach. SFAR is now automatically reconfigured at
each access, and it works because we're not using a LUT_ADDR
instruction but a LUT_MODE one. Sure, I'd prefer to go for the clean
solution with a LUT_ADDR and the address passed through SFAR (+AHB
offset), but it does not work with anything that is not 24 bits or
32 bits wide, which means it does not work when you need to access a SPI
NAND device (on which some addresses are 16 bits wide).

> 
> For e.g. If reading from flash-0 offset 0x100000 than SFAR should have address as 0x20100000.
> As for 'read/write' request 'from/to' respectively been saved in struct spi_mem_op [op.val] this should be added to q->memmap_phy.

You're still thinking as if the driver was only controlling a NOR
device which can be directly addressed. This is not the case for NAND
devices where you first have to load the data in the NAND internal cache
and then read data from the cache.

> 
> In LUT preparation for ADDR, we should use ADDR_WIDTH as 3-byte or 4-byte addressing only.

Please have a look at SPI NAND datasheets and you'll see it's simply
not possible. So, either NXP doesn't want his QSPI controller to
interface with anything except NORs or we have to use the trick we have
here (LUT_MODE instead of LUT_ADDR).

> Start address should be saved in SFAR register.
> 
> +
> +	qspi_writel(q,
> +		    qspi_readl(q, base + QUADSPI_MCR) |
> +		    QUADSPI_MCR_CLR_RXF_MASK | QUADSPI_MCR_CLR_TXF_MASK,
> +		    base + QUADSPI_MCR);
> +
> +	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC | QUADSPI_SPTRCLR_IPPTRC,
> +		    base + QUADSPI_SPTRCLR);
> +
> +	fsl_qspi_prepare_lut(q, op);
> +
> +	/*
> +	 * If we have large chunks of data, we read them through the AHB bus
> +	 * by accessing the mapped memory. In all other cases we use
> +	 * IP commands to access the flash.
> +	 */
> +	if (op->data.nbytes > (q->devtype_data->rxfifo - 4) &&
> +	    op->data.dir == SPI_MEM_DATA_IN) {
> +		fsl_qspi_read_ahb(q, op);
> +	} else {
> +		qspi_writel(q,
> +			    QUADSPI_RBCT_WMRK_MASK | QUADSPI_RBCT_RXBRD_USEIPS,
> +			    base + QUADSPI_RBCT);
> +
> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> +			fsl_qspi_fill_txfifo(q, op);
> +
> +		err = fsl_qspi_do_op(q, op);
> +	}
> +
> +	mutex_unlock(&q->lock);
> +
> +	return err;
> +}

[...]

> 
> Also we should add more debug print messages under dev_dbg() like in func like fsl_qspi_prepare_lut() etc.
> 

Would you mind giving more details about where you'd like this traces
to be placed exactly and what information you'd like to display?

Thanks,

Boris
