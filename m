Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF31C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF25F2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545314853;
	bh=1Zuy2GzBKlgz21F6tNh9wBJvufwSey8/K1T12KYOFyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=v69nG7/1FUwBrNcYxi9Wo4QCOobBRewNwXwijZQSLe0PxS16MvL+2M3P5qTEHiYRb
	 sPwOodtYcRHuXdnL3oKxnpztlFauqTRU3CRgxdmUTiCgVZruWCyV/VgvmA/kwaRULt
	 eMpwKf5rkVeYI9r7OzTGFyaO/lPSlIe5GTOwXYeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbeLTOHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731265AbeLTOHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:07:32 -0500
Received: from bbrezillon (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEFF4217D8;
        Thu, 20 Dec 2018 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545314851;
        bh=1Zuy2GzBKlgz21F6tNh9wBJvufwSey8/K1T12KYOFyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j12sTpwB2mY9JX1cWWVmKWaCv9yY+xdVDVKeHh6pq6Mu/46KLHyZJo0KutFv/+GnQ
         te0r2iJ9ExlUoOQuY9CJ2Y9GN35XRBAymFYJdZNzLt4Mcb+4OLfokmF+A1Bhmy9cWv
         UPj2RGtzWBGxK/YyffosXr8YspOprJYEPw5Q+Bck=
Date:   Thu, 20 Dec 2018 15:07:26 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/3] mtd: rawnand: Support bad block markers in first,
 second or last page
Message-ID: <20181220150715.5b19f480@bbrezillon>
In-Reply-To: <20181220145954.55ae36e9@bbrezillon>
References: <1545061693-29216-1-git-send-email-frieder.schrempf@kontron.de>
        <1545061693-29216-2-git-send-email-frieder.schrempf@kontron.de>
        <20181220145954.55ae36e9@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 14:59:54 +0100
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> >  
> >  /**
> > + * nand_bbm_page_offset - Get the page offsets for bad block markers
> > + * @chip: NAND chip object
> > + * @index: Index for the page offset  
> 
> Hm, the meaning of index is far from obvious. How about passing the
> current page instead (and return 1 if there are more pages to scan 0
> otherwise)?
> 
> Something like:
> 
> static int nand_bbm_get_next_page(struct nand_chip *chip, int page)
> {
> 	struct mtd_info *mtd = nand_to_mtd(chip);
> 	int last_page = ((mtd->erasesize - mtd->writesize) >>
> 			 chip->page_shift) & chip->pagemask;
> 
> 	if (page < 0 && chip->bbt_options & NAND_BBT_SCANFIRSTPAGE)
> 		return 0;
> 	else if (page < 1 && chip->bbt_options & NAND_BBT_SCAN2NDPAGE)
> 		return 1;
> 	else if (page < last_page &&
> 		 chip->bbt_options & NAND_BBT_SCANLASTPAGE)
> 		return last_page;
> 
> 	return -1;
> }
> 
> And yes, that means defining NAND_BBT_SCANFIRSTPAGE and setting it when
> appropriate.
> 

Oh, and you'll have to define NAND_BBT_SCANFIRST2PAGES like this

#define NAND_BBT_SCANFIRST2PAGES NAND_BBT_SCAN1STPAGE |	\
				 NAND_BBT_SCAN2NDPAGE

and then patch all users of NAND_BBT_SCAN2NDPAGE to use
NAND_BBT_SCANFIRST2PAGES instead.
