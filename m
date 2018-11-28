Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B447C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1F82086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1F82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeK2CaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:30:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36700 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeK2CaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:30:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6604F20747; Wed, 28 Nov 2018 16:28:21 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0C42A20510;
        Wed, 28 Nov 2018 16:28:11 +0100 (CET)
Date:   Wed, 28 Nov 2018 16:28:10 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Message-ID: <20181128162810.597a7fd3@bbrezillon>
In-Reply-To: <b7adc960-c81d-19c6-2122-cd6781b64a17@kontron.de>
References: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
        <20181128154104.577d5923@bbrezillon>
        <7634bb45-6167-31e8-e169-b5c9bf7e2fc5@kontron.de>
        <20181128160215.45e5162e@bbrezillon>
        <b7adc960-c81d-19c6-2122-cd6781b64a17@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 15:19:37 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> On 28.11.18 16:02, Boris Brezillon wrote:
> > On Wed, 28 Nov 2018 14:55:45 +0000
> > Schrempf Frieder <frieder.schrempf@kontron.de> wrote:
> >   
> >> Hi Boris,
> >>
> >> On 28.11.18 15:41, Boris Brezillon wrote:  
> >>> On Tue, 27 Nov 2018 07:44:52 +0000
> >>> Schrempf Frieder <frieder.schrempf@kontron.de> wrote:
> >>>      
> >>>> Fix the size of the buffer allocated to store the in-memory BBT.
> >>>> This bug was previously hidden by a different bug, that was fixed in
> >>>> d098093ba06e.
> >>>>
> >>>> Fixes: 9c3736a3de21 ("mtd: nand: Add core infrastructure to deal with NAND devices")
> >>>> Cc: <stable@vger.kernel.org>
> >>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>  
> >>>
> >>> Looks like your From header does not match the SoB tag
> >>> ('Frieder Schrempf' vs 'Schrempf Frieder') and checkpatch does not like
> >>> that. I'll fix it when applying, but maybe you should fix
> >>> your .gitconfig to make them match.  
> >>
> >> Actually the From header in my local patch is correct (<first name>
> >> <last name>, Frieder Schrempf) as it comes from my git config. But since
> >> our company was renamed and our mail servers were transferred, our
> >> e-mails are sent with From=<last name> <first name>.
> >>
> >> It seems like git send-email or patchwork or whatever uses the
> >> information from the e-mail header instead of what is in the patch.
> >>
> >> I will try to raise this issue with our IT department as this would be
> >> best fixed on their side.  
> > 
> > There's another solution: make git send-email add a From header in the
> > message body.
> > 
> > git config --global sendemail.from "Schrempf Frieder <frieder.schrempf@kontron.de>"  
> 
> I don't get it. How would that change things? My From still wouldn't 
> match my SoB tags.

When there's a From line in the message Body, git am will use this one
instead of the one in the header section.
