Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8112C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACAA25408
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACAA25408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeGBH4T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:56:19 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43338 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbeGBH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:56:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8E1D660A04AC;
        Mon,  2 Jul 2018 09:56:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AD2_qy6G_05v; Mon,  2 Jul 2018 09:56:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4ED4760A04A9;
        Mon,  2 Jul 2018 09:56:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3fhyr-REtMcQ; Mon,  2 Jul 2018 09:56:15 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 2AF36609332A;
        Mon,  2 Jul 2018 09:56:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 1/2] ubi: provide a way to skip CRC checks
Date:   Mon, 02 Jul 2018 09:56:14 +0200
Message-ID: <1767453.cfoEQ8yxZA@blindfold>
In-Reply-To: <20180702095121.67bc61ef@bbrezillon>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com> <1530516625.469.82.camel@gmail.com> <20180702095121.67bc61ef@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 2. Juli 2018, 09:51:21 CEST schrieb Boris Brezillon:
> Hi Artem,
> 
> On Mon, 02 Jul 2018 10:30:25 +0300
> Artem Bityutskiy <dedekind1@gmail.com> wrote:
> 
> > Hi,
> > 
> > On Thu, 2018-06-28 at 09:40 +0200, Quentin Schulz wrote:
> > > diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
> > > index d4b2e87..e9e9ecb 100644
> > > --- a/drivers/mtd/ubi/kapi.c
> > > +++ b/drivers/mtd/ubi/kapi.c
> > > @@ -202,7 +202,7 @@ struct ubi_volume_desc *ubi_open_volume(int ubi_num, int vol_id, int mode)
> > >  	desc->mode = mode;
> > >  
> > >  	mutex_lock(&ubi->ckvol_mutex);
> > > -	if (!vol->checked) {
> > > +	if (!vol->checked && !vol->skip_check) {
> > >  		/* This is the first open - check the volume */
> > >  		err = ubi_check_volume(ubi, vol_id);
> > >  		if (err < 0) {  
> > 
> > Did you deliberately did not add a similar check to 'vol_cdev_write()' ?
> > You want to skip checking on load but do have the checking after volume update ?
> 
> Yep, it's on purpose, I asked Quentin to keep the test on the update
> volume path.
> 
> > Looks a bit inconsistent to me. At the very least deserves a comment in
> > 'vol_cdev_write()' about why 'skip_check' flag is ignored there.
> 
> Well, I thought checking the CRC just after updating the volume made
> sense, just to make sure things were written correctly on the medium.
> Let's add a comment explaining why we keep the check here, unless you
> see a strong reason to get rid of this check in the update path.

+1

I also vote for keeping the check.
vol->skip_check is really just "skip the check upon volume open".

Thanks,
//richard

