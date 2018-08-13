Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B2C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443F4217C8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443F4217C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeHMJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:12:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60599 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:12:30 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fp6O0-0000Lx-EW; Mon, 13 Aug 2018 08:31:28 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fp6Nz-0004Rb-SN; Mon, 13 Aug 2018 08:31:27 +0200
Date:   Mon, 13 Aug 2018 08:31:27 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 05/25] ubifs: implement ubifs_lpt_lookup using
 ubifs_pnode_lookup
Message-ID: <20180813063127.kpxw6d5amna5wpas@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
 <20180704124137.13396-6-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704124137.13396-6-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:29:21 up 61 days, 15:38, 52 users,  load average: 0.00, 0.05,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:41:17PM +0200, Sascha Hauer wrote:
> ubifs_lpt_lookup() starts by looking up the nth pnode in the LPT. We
> already have this functionality in ubifs_pnode_lookup(). Use this
> function rather than open coding its functionality.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/lpt.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
> index 6cd6f23d4512..cde7b9484157 100644
> --- a/fs/ubifs/lpt.c
> +++ b/fs/ubifs/lpt.c
> @@ -1478,27 +1478,11 @@ struct ubifs_pnode *ubifs_pnode_lookup(struct ubifs_info *c, int i)
>   */
>  struct ubifs_lprops *ubifs_lpt_lookup(struct ubifs_info *c, int lnum)
>  {
> -	int err, i, h, iip, shft;
> -	struct ubifs_nnode *nnode;
> +	int i, iip;
>  	struct ubifs_pnode *pnode;
>  
> -	if (!c->nroot) {
> -		err = ubifs_read_nnode(c, NULL, 0);
> -		if (err)
> -			return ERR_PTR(err);
> -	}
> -	nnode = c->nroot;
>  	i = lnum - c->main_first;
> -	shft = c->lpt_hght * UBIFS_LPT_FANOUT_SHIFT;
> -	for (h = 1; h < c->lpt_hght; h++) {
> -		iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
> -		shft -= UBIFS_LPT_FANOUT_SHIFT;
> -		nnode = ubifs_get_nnode(c, nnode, iip);
> -		if (IS_ERR(nnode))
> -			return ERR_CAST(nnode);
> -	}
> -	iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
> -	pnode = ubifs_get_pnode(c, nnode, iip);
> +	pnode = ubifs_pnode_lookup(c, i);

This should be

	ubifs_pnode_lookup(c, i >> UBIFS_LPT_FANOUT_SHIFT);

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
