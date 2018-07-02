Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D401C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5944325A78
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5944325A78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeGBHvi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:51:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47832 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753698AbeGBHvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:51:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7B516208B3; Mon,  2 Jul 2018 09:51:31 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 33AF820703;
        Mon,  2 Jul 2018 09:51:21 +0200 (CEST)
Date:   Mon, 2 Jul 2018 09:51:21 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 1/2] ubi: provide a way to skip CRC checks
Message-ID: <20180702095121.67bc61ef@bbrezillon>
In-Reply-To: <1530516625.469.82.camel@gmail.com>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
        <3f9cef553d4f5da3fe2d76113d79ada1f0fe5224.1530169759.git-series.quentin.schulz@bootlin.com>
        <1530516625.469.82.camel@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Mon, 02 Jul 2018 10:30:25 +0300
Artem Bityutskiy <dedekind1@gmail.com> wrote:

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

Yep, it's on purpose, I asked Quentin to keep the test on the update
volume path.

> Looks a bit inconsistent to me. At the very least deserves a comment in
> 'vol_cdev_write()' about why 'skip_check' flag is ignored there.

Well, I thought checking the CRC just after updating the volume made
sense, just to make sure things were written correctly on the medium.
Let's add a comment explaining why we keep the check here, unless you
see a strong reason to get rid of this check in the update path.

Regards,

Boris
