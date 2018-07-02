Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2975C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBE225220
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBE225220
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933019AbeGBHn7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:43:59 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43100 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753425AbeGBHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:43:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 434D760A04A9;
        Mon,  2 Jul 2018 09:43:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 02aiSv2Im7sn; Mon,  2 Jul 2018 09:43:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0571060B3040;
        Mon,  2 Jul 2018 09:43:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cIENoVzzsvTG; Mon,  2 Jul 2018 09:43:54 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id DB9C160A04AC;
        Mon,  2 Jul 2018 09:43:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     dedekind1@gmail.com
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 1/2] ubi: provide a way to skip CRC checks
Date:   Mon, 02 Jul 2018 09:43:48 +0200
Message-ID: <1814021.2UnKZ8bNR8@blindfold>
In-Reply-To: <1530516625.469.82.camel@gmail.com>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com> <3f9cef553d4f5da3fe2d76113d79ada1f0fe5224.1530169759.git-series.quentin.schulz@bootlin.com> <1530516625.469.82.camel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Artem,

Am Montag, 2. Juli 2018, 09:30:25 CEST schrieb Artem Bityutskiy:
> Hi,
> 
> On Thu, 2018-06-28 at 09:40 +0200, Quentin Schulz wrote:
> > diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
> > index d4b2e87..e9e9ecb 100644
> > --- a/drivers/mtd/ubi/kapi.c
> > +++ b/drivers/mtd/ubi/kapi.c
> > @@ -202,7 +202,7 @@ struct ubi_volume_desc *ubi_open_volume(int ubi_num, int vol_id, int mode)
> >  	desc->mode = mode;
> >  
> >  	mutex_lock(&ubi->ckvol_mutex);
> > -	if (!vol->checked) {
> > +	if (!vol->checked && !vol->skip_check) {
> >  		/* This is the first open - check the volume */
> >  		err = ubi_check_volume(ubi, vol_id);
> >  		if (err < 0) {
> 
> Did you deliberately did not add a similar check to 'vol_cdev_write()' ?
> You want to skip checking on load but do have the checking after volume update ?
> Looks a bit inconsistent to me. At the very least deserves a comment in
> 'vol_cdev_write()' about why 'skip_check' flag is ignored there.

Well, the idea is skipping the check, not the crc32 on the medium.
That way we can later, if needed, offer a way to drop the flag but
and don't have to rewrite with crc32-enabled.

Thanks,
//richard
