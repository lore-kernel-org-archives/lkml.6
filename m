Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FAF2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfABIdl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 03:33:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35807 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfABIdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 03:33:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF13520748; Wed,  2 Jan 2019 09:33:38 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr [90.88.149.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7FE27206A6;
        Wed,  2 Jan 2019 09:33:38 +0100 (CET)
Date:   Wed, 2 Jan 2019 09:33:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, peterpandong@micron.com,
        linux-kernel@vger.kernel.org
Subject: Re: [LINUX PATCH v12] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Message-ID: <20190102093338.3b4a8c69@xps13>
In-Reply-To: <20181221091750.GA19470@hp-probook-450>
References: <1533620414-3332-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20181221091750.GA19470@hp-probook-450>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

Switching Boris address.

Romain Perier <romain.perier@gmail.com> wrote on Fri, 21 Dec 2018
10:17:50 +0100:

> Hello,
> 
> I have rebased this patch onto 4.19.11. I use it on a Zynq7000-based
> board with a NAND chip Micron MT29F4G08ABADAH4, since ~2 weeks now.
> The only problem I have to report is that when I boot with an unchanged
> driver on my board, I get the following logs:
> 
> [    1.988797] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
> [    1.995184] nand: Micron MT29F4G08ABADAH4
> [    1.999187] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> [    2.402661] nand: timeout while waiting for chip to become ready
> [    2.408665] nand: timing mode 5 not acknowledged by the NAND chip
> [    2.416251] Bad block table not found for chip 0
> [    2.422278] Bad block table not found for chip 0
> [    2.426903] Scanning device for bad blocks
> [    2.431024] Bad eraseblock 0 at 0x000000000000
> [    2.435509] Bad eraseblock 1 at 0x000000020000
> [    2.439978] Bad eraseblock 2 at 0x000000040000
> [    2.444465] Bad eraseblock 3 at 0x000000060000
> [    2.448936] Bad eraseblock 4 at 0x000000080000
> [    2.453423] Bad eraseblock 5 at 0x0000000a0000
> [    2.457893] Bad eraseblock 6 at 0x0000000c0000
> [    2.462354] Bad eraseblock 7 at 0x0000000e0000
> [    2.466841] Bad eraseblock 8 at 0x000000100000
> [    2.471304] Bad eraseblock 9 at 0x000000120000
> [    2.475793] Bad eraseblock 10 at 0x000000140000
> [    2.480349] Bad eraseblock 11 at 0x000000160000
> 
> [...]
> 
> 
> After investigation, it seems that during the nand_scan phase, the NAND
> subsystem tests different timing modes on the NAND chip (mode 0 seems to be
> apply during reset, and then it tries to detect the best mode supported by the
> NAND chip). Only the mode 0 works here, trying the use the mode 5 resuls in an
> error (as you can see in the log) and a bad BBT detection. Both modes are
> supported by the NAND chip. In order to fix this, I had to put the nfc timing
> into the device node of the nfc, inside the DT (that's not a real fix, ihmo).

Thanks for testing! Indeed, the ->setup_data_interface() callback should be fixed.

> Except this, everything is working as expected. Everything is stable with correct
> performances.
> 
> If I can provide more informations, feel free to ask.

[...]

> > +static int pl353_setup_data_interface(struct mtd_info *mtd, int csline,
> > +				       const struct nand_data_interface *conf)
> > +{
> > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > +	struct pl353_nand_controller *xnfc =
> > +		container_of(chip, struct pl353_nand_controller, chip);
> > +	const struct nand_sdr_timings *sdr;
> > +	u32 timings[7], mckperiodps;
> > +
> > +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> > +		return 0;
> > +
> > +	sdr = nand_get_sdr_timings(conf);
> > +	if (IS_ERR(sdr))
> > +		return PTR_ERR(sdr);
> > +
> > +	/*
> > +	 * SDR timings are given in pico-seconds while NFC timings must be
> > +	 * expressed in NAND controller clock cycles.
> > +	 */
> > +	mckperiodps = NSEC_PER_SEC / clk_get_rate(xnfc->mclk);
> > +	mckperiodps *= 1000;
> > +	if (sdr->tRC_min <= 20000)
> > +		/*
> > +		 * PL353 SMC needs one extra read cycle in SDR Mode 5
> > +		 * This is not written anywhere in the datasheet but
> > +		 * the results observed during testing.
> > +		 */
> > +		timings[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps) + 1;
> > +	else
> > +		timings[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
> > +
> > +	timings[1] = DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
> > +	/*
> > +	 * For all SDR modes, PL353 SMC needs tREA max value as 1,
> > +	 * Results observed during testing.
> > +	 */
> > +	timings[2] = PL353_TREA_MAX_VALUE;
> > +	timings[3] = DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
> > +	timings[4] = DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
> > +	timings[5] = DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
> > +	timings[6] = DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
> > +	pl353_smc_set_cycles(timings);
> > +
> > +	return 0;
> > +}  
> 
> If I hack this function in order to limit the timings only to mode 0,
> everything works. Otherwise it hangs when it tries to apply mode 5.
> 

Maybe Naga is not using a chip compatible with mode 5 and did not ran
into this issue?


Thanks,
Miquèl
