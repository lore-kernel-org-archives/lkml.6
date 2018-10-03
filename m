Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2908C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899E82082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899E82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJCUzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:55:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39413 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeJCUzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:55:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 00AAA2072B; Wed,  3 Oct 2018 16:06:35 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id B8414206A2;
        Wed,  3 Oct 2018 16:06:35 +0200 (CEST)
Date:   Wed, 3 Oct 2018 16:06:34 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: ams-delta: use ->exec_op()
Message-ID: <20181003160634.147dd95c@bbrezillon>
In-Reply-To: <4278198.vlhjLe5TOR@z50>
References: <20180719081508.5dafebde@bbrezillon>
        <20181003120028.9257-1-jmkrzyszt@gmail.com>
        <20181003143054.597b3a9e@bbrezillon>
        <4278198.vlhjLe5TOR@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Oct 2018 15:55:25 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
  
> > > 
> > > Implementation of NAND_OP_WAITRDY_INSTR has been based on legacy
> > > nand_wait_ready(),  
> > 
> > I don't remember what the ams-delta ->dev_ready()/->waitfunc() hooks
> > are doing, but is shouldn't be too hard to replace them by an
> > ams_delta_wait_ready() func.  
> 
> Default nand_wait() is used as ->waitfunc(), and ->dev_ready() returns R/B 
> GPIO pin status.

Okay. Then it might make sense to provide a generic helper to poll a
gpio.

void nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod)
{
	...
}

> 
> > > otherwise that function would probabaly have to be  
> > 
> > 				^ probably  
> 
> Do you think other drivers which now provide ->dev_ready() won't require 
> reimplementation of nand_wait_ready()?

It depends. I mean, most controllers support native R/B sensing, and in
case they do actually require you to poll the RB pin status, duplicating
the wait_ready() logic shouldn't be a problem. On the other hand, I
really want to get rid of ->dev_ready().
