Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BLrUDsB2G1tgcgAAmS7hNA
	; Sat, 09 Jun 2018 06:42:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0EF85607E7; Sat,  9 Jun 2018 06:42:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 62254606FA;
	Sat,  9 Jun 2018 06:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62254606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbeFIGmC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:42:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50576 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752272AbeFIGmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:42:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EE3ED20799; Sat,  9 Jun 2018 08:41:57 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6419920702;
        Sat,  9 Jun 2018 08:41:57 +0200 (CEST)
Date: Sat, 9 Jun 2018 08:41:57 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: Dmitry Osipenko <digetx@gmail.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180609084157.0c2f12e6@bbrezillon>
In-Reply-To: <792ee71847f6f4752b8bcba65d22bf81@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-5-stefan@agner.ch>
        <cdca329f-0b8d-0604-4cfb-b95baf84c867@gmail.com>
        <d625dd8ca816543e03668b74921563c1@agner.ch>
        <20180609075256.725354d6@bbrezillon>
        <792ee71847f6f4752b8bcba65d22bf81@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jun 2018 08:23:51 +0200
Stefan Agner <stefan@agner.ch> wrote:

> On 09.06.2018 07:52, Boris Brezillon wrote:
> > On Fri, 08 Jun 2018 23:51:01 +0200
> > Stefan Agner <stefan@agner.ch> wrote:
> > 
> >   
> >> >
> >> > void tegra_nand_controller_reset(struct tegra_nand_controller *ctrl)
> >> > {
> >> > 	int err;
> >> >
> >> > 	disable_irq(ctrl->irq);
> >> >
> >> > 	err = reset_control_reset(ctrl->rst);
> >> > 	if (err) {
> >> > 		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
> >> > 		msleep(HW_TIMEOUT);
> >> > 	}
> >> >
> >> > 	writel_relaxed(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
> >> > 	writel_relaxed(HWSTATUS_MASK, ctrl->regs + HWSTATUS_MASK);
> >> > 	writel_relaxed(INT_MASK, ctrl->regs + ISR);  
> >>
> >> If we do a controller reset, there is much more state than that which
> >> needs to be restored. A lot of it is not readily available currently
> >> (timing, ECC settings...)  
> > 
> > This is actually a good test to detect what is not properly initialized
> > by the driver. Timings should be configured correctly through  
> > ->setup_data_interface(). ECC engine should be disabled by default and  
> > only enabled when ->{read,write}_page() is called.
> >   
> 
> Is setup_data_interface guaranteed to be called after a failed
> ->exec_op()/{read,write}_page()?

No. Maybe I misunderstood when tegra_nand_controller_reset() was
supposed to be called. That's something I would call only once, early
in the probe function, so that the controller is placed in a well-known
state before we start using it. Definitely not something you should
call after each error.

> 
> >>
> >> That seems a lot of work for a code path I do not intend to ever use :-)
> >>  
> > 
> > Not so sure it's a lot of work. If ECC and timing settings are the
> > only thing you need to initialize then it should work just fine.
> > Try with a controller reset and you'll know if you miss something ;-).  
> 
> Currently the setting gets written directly to the registers. Only the
> enable flag is set in the HW ECC {read,write}_page() functions. So I
> will have to store the complete register in the chip structure and write
> them on every {read,write}_page()?

Well, your solution works as long as you only have one chip connected
to the controller. What we usually set the ECC config in
->select_chip() (or at least make sure the current setting matches the
one we expect) and then enable the engine in read/write_page() (as you
seem to already do).
