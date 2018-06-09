Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mdIWBEJrG1tyRAAAmS7hNA
	; Sat, 09 Jun 2018 05:53:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0934608B8; Sat,  9 Jun 2018 05:53:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 716696032D;
	Sat,  9 Jun 2018 05:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 716696032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeFIFxC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 01:53:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50184 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbeFIFxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 01:53:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2D700207CA; Sat,  9 Jun 2018 07:52:58 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9DC33203EC;
        Sat,  9 Jun 2018 07:52:57 +0200 (CEST)
Date: Sat, 9 Jun 2018 07:52:56 +0200
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
Message-ID: <20180609075256.725354d6@bbrezillon>
In-Reply-To: <d625dd8ca816543e03668b74921563c1@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-5-stefan@agner.ch>
        <cdca329f-0b8d-0604-4cfb-b95baf84c867@gmail.com>
        <d625dd8ca816543e03668b74921563c1@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jun 2018 23:51:01 +0200
Stefan Agner <stefan@agner.ch> wrote:


> > 
> > void tegra_nand_controller_reset(struct tegra_nand_controller *ctrl)
> > {
> > 	int err;
> > 
> > 	disable_irq(ctrl->irq);
> > 
> > 	err = reset_control_reset(ctrl->rst);
> > 	if (err) {
> > 		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
> > 		msleep(HW_TIMEOUT);
> > 	}
> > 
> > 	writel_relaxed(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
> > 	writel_relaxed(HWSTATUS_MASK, ctrl->regs + HWSTATUS_MASK);
> > 	writel_relaxed(INT_MASK, ctrl->regs + ISR);  
> 
> If we do a controller reset, there is much more state than that which
> needs to be restored. A lot of it is not readily available currently
> (timing, ECC settings...)

This is actually a good test to detect what is not properly initialized
by the driver. Timings should be configured correctly through
->setup_data_interface(). ECC engine should be disabled by default and
only enabled when ->{read,write}_page() is called.

> 
> That seems a lot of work for a code path I do not intend to ever use :-)
> 

Not so sure it's a lot of work. If ECC and timing settings are the
only thing you need to initialize then it should work just fine.
Try with a controller reset and you'll know if you miss something ;-).
