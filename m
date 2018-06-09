Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fblyAnB3G1tSewAAmS7hNA
	; Sat, 09 Jun 2018 06:46:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3C6B6608B8; Sat,  9 Jun 2018 06:46:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B08F6600D0;
	Sat,  9 Jun 2018 06:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B08F6600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeFIGqT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:46:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50692 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753157AbeFIGqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:46:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EE7F7207C0; Sat,  9 Jun 2018 08:46:15 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 622DD20702;
        Sat,  9 Jun 2018 08:46:15 +0200 (CEST)
Date: Sat, 9 Jun 2018 08:46:15 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: mark.rutland@arm.com, benjamin.lindqvist@endian.se,
        pgaikwad@nvidia.com, dev@lynxeye.de, mirza.krak@gmail.com,
        richard@nod.at, pdeschrijver@nvidia.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        jonathanh@nvidia.com, marek.vasut@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org,
        linux-mtd@lists.infradead.org, Dmitry Osipenko <digetx@gmail.com>,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180609084615.6fba31ec@bbrezillon>
In-Reply-To: <20180609084157.0c2f12e6@bbrezillon>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-5-stefan@agner.ch>
        <cdca329f-0b8d-0604-4cfb-b95baf84c867@gmail.com>
        <d625dd8ca816543e03668b74921563c1@agner.ch>
        <20180609075256.725354d6@bbrezillon>
        <792ee71847f6f4752b8bcba65d22bf81@agner.ch>
        <20180609084157.0c2f12e6@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jun 2018 08:41:57 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Sat, 09 Jun 2018 08:23:51 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
> > On 09.06.2018 07:52, Boris Brezillon wrote:
> > > On Fri, 08 Jun 2018 23:51:01 +0200
> > > Stefan Agner <stefan@agner.ch> wrote:
> > > 
> > >   
> > >> >
> > >> > void tegra_nand_controller_reset(struct tegra_nand_controller *ctrl)
> > >> > {
> > >> > 	int err;
> > >> >
> > >> > 	disable_irq(ctrl->irq);
> > >> >
> > >> > 	err = reset_control_reset(ctrl->rst);
> > >> > 	if (err) {
> > >> > 		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
> > >> > 		msleep(HW_TIMEOUT);
> > >> > 	}
> > >> >
> > >> > 	writel_relaxed(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
> > >> > 	writel_relaxed(HWSTATUS_MASK, ctrl->regs + HWSTATUS_MASK);
> > >> > 	writel_relaxed(INT_MASK, ctrl->regs + ISR);  
> > >>
> > >> If we do a controller reset, there is much more state than that which
> > >> needs to be restored. A lot of it is not readily available currently
> > >> (timing, ECC settings...)  
> > > 
> > > This is actually a good test to detect what is not properly initialized
> > > by the driver. Timings should be configured correctly through  
> > > ->setup_data_interface(). ECC engine should be disabled by default and  
> > > only enabled when ->{read,write}_page() is called.
> > >   
> > 
> > Is setup_data_interface guaranteed to be called after a failed
> > ->exec_op()/{read,write}_page()?
> 
> No. Maybe I misunderstood when tegra_nand_controller_reset() was
> supposed to be called. That's something I would call only once, early
> in the probe function, so that the controller is placed in a well-known
> state before we start using it. Definitely not something you should
> call after each error.

Note that if you really want to reset the controller after an error,
you should also iterate over all chips and call nand_reset() on them.
