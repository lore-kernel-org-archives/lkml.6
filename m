Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64065C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326E121834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326E121834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeHMJO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:14:56 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46372 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:14:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AF37F605D864;
        Mon, 13 Aug 2018 08:34:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JBrJgCKQCAIS; Mon, 13 Aug 2018 08:34:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2E017605D865;
        Mon, 13 Aug 2018 08:34:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R2B0w-fWxP_C; Mon, 13 Aug 2018 08:34:04 +0200 (CEST)
Received: from blindfold.localnet (089144210135.atnat0019.highway.a1.net [89.144.210.135])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 602DE605D864;
        Mon, 13 Aug 2018 08:34:03 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 05/25] ubifs: implement ubifs_lpt_lookup using ubifs_pnode_lookup
Date:   Mon, 13 Aug 2018 08:34:00 +0200
Message-ID: <8387142.nbJ7LYRgBX@blindfold>
In-Reply-To: <20180813063127.kpxw6d5amna5wpas@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de> <20180704124137.13396-6-s.hauer@pengutronix.de> <20180813063127.kpxw6d5amna5wpas@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 13. August 2018, 08:31:27 CEST schrieb Sascha Hauer:
> On Wed, Jul 04, 2018 at 02:41:17PM +0200, Sascha Hauer wrote:
> > ubifs_lpt_lookup() starts by looking up the nth pnode in the LPT. We
> > already have this functionality in ubifs_pnode_lookup(). Use this
> > function rather than open coding its functionality.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  fs/ubifs/lpt.c | 20 ++------------------
> >  1 file changed, 2 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
> > index 6cd6f23d4512..cde7b9484157 100644
> > --- a/fs/ubifs/lpt.c
> > +++ b/fs/ubifs/lpt.c
> > @@ -1478,27 +1478,11 @@ struct ubifs_pnode *ubifs_pnode_lookup(struct ubifs_info *c, int i)
> >   */
> >  struct ubifs_lprops *ubifs_lpt_lookup(struct ubifs_info *c, int lnum)
> >  {
> > -	int err, i, h, iip, shft;
> > -	struct ubifs_nnode *nnode;
> > +	int i, iip;
> >  	struct ubifs_pnode *pnode;
> >  
> > -	if (!c->nroot) {
> > -		err = ubifs_read_nnode(c, NULL, 0);
> > -		if (err)
> > -			return ERR_PTR(err);
> > -	}
> > -	nnode = c->nroot;
> >  	i = lnum - c->main_first;
> > -	shft = c->lpt_hght * UBIFS_LPT_FANOUT_SHIFT;
> > -	for (h = 1; h < c->lpt_hght; h++) {
> > -		iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
> > -		shft -= UBIFS_LPT_FANOUT_SHIFT;
> > -		nnode = ubifs_get_nnode(c, nnode, iip);
> > -		if (IS_ERR(nnode))
> > -			return ERR_CAST(nnode);
> > -	}
> > -	iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
> > -	pnode = ubifs_get_pnode(c, nnode, iip);
> > +	pnode = ubifs_pnode_lookup(c, i);
> 
> This should be
> 
> 	ubifs_pnode_lookup(c, i >> UBIFS_LPT_FANOUT_SHIFT);

Can you please add a helper function for that? These shift games are
always confusing and not easy to spot.

Thanks,
//richard



