Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B94C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08B320868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08B320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJLQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:55:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44700 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbeJLQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:55:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8AA2A207BB; Fri, 12 Oct 2018 11:23:33 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 41B5F20898;
        Fri, 12 Oct 2018 11:22:58 +0200 (CEST)
Date:   Fri, 12 Oct 2018 11:22:59 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: sa1100: avoid VLA in sa1100_setup_mtd
Message-ID: <20181012112259.56f3c44f@bbrezillon>
In-Reply-To: <CAK8P3a1zYoGtfe6PVEM-oLNxXQAt12iiNR1ZLiaGvrY5LFKwwA@mail.gmail.com>
References: <20181010184533.691620-1-arnd@arndb.de>
        <20181012111603.0d03e043@bbrezillon>
        <CAK8P3a1zYoGtfe6PVEM-oLNxXQAt12iiNR1ZLiaGvrY5LFKwwA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 11:19:52 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Fri, Oct 12, 2018 at 11:16 AM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > Hi Arnd,
> >
> > On Wed, 10 Oct 2018 20:44:50 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  
> > > Enabling -Wvla found another variable-length array with randconfig
> > > testing:
> > >
> > > drivers/mtd/maps/sa1100-flash.c: In function 'sa1100_setup_mtd':
> > > drivers/mtd/maps/sa1100-flash.c:224:10: error: ISO C90 forbids variable length array 'cdev' [-Werror=vla]
> > >
> > > As far as I can tell, there is an upper bound on the number of resources
> > > that can be passed, based on the number of CS lines on the bus.
> > > In practice, all boards we support have either one or two resources,
> > > but using six to be on the safe side has no extra cost.  
> >
> > Why not dynamically allocate cdev instead? That removes any kind of
> > guessing on the max value, and it shouldn't hurt much since this code is
> > in the probe path.  
> 
> Fine with me as well, If you prefer that one, please just add
> Reported-by: Arnd Bergmann <arnd@arndb.de>

Oh, I thought I'd let you send a v2, but I can do it if you prefer.
