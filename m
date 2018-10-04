Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8110C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965FF2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965FF2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeJDUxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:53:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40467 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbeJDUxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:53:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3221E208B7; Thu,  4 Oct 2018 15:59:33 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id EA5EE20890;
        Thu,  4 Oct 2018 15:59:32 +0200 (CEST)
Date:   Thu, 4 Oct 2018 15:59:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: ams-delta: use ->exec_op()
Message-ID: <20181004155933.0a32c4ac@bbrezillon>
In-Reply-To: <7546835.d2Xs8Qh0bZ@z50>
References: <20180719081508.5dafebde@bbrezillon>
        <4278198.vlhjLe5TOR@z50>
        <20181003160634.147dd95c@bbrezillon>
        <7546835.d2Xs8Qh0bZ@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Oct 2018 15:52:57 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Hi Boris,
> 
> On Wednesday, October 3, 2018 4:06:34 PM CEST Boris Brezillon wrote:
> > On Wed, 03 Oct 2018 15:55:25 +0200
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> >     
> > > > > 
> > > > > Implementation of NAND_OP_WAITRDY_INSTR has been based on legacy
> > > > > nand_wait_ready(),    
> > > > 
> > > > I don't remember what the ams-delta ->dev_ready()/->waitfunc() hooks
> > > > are doing, but is shouldn't be too hard to replace them by an
> > > > ams_delta_wait_ready() func.    
> > > 
> > > Default nand_wait() is used as ->waitfunc(), and ->dev_ready() returns R/B 
> > > GPIO pin status.  
> > 
> > Okay. Then it might make sense to provide a generic helper to poll a
> > gpio.
> > 
> > void nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod)
> > {
> > 	...
> > }  
> 
> How about a still more generic helper which accepts dev_ready() callback as an 
> argument?

Nope, I still prefer the GPIO based one. We'll see if others need a
a more generic helper, but I doubt it.
