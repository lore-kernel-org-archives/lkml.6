Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E11DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2798E2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2798E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeIGPFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:05:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44671 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbeIGPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:05:48 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyDwz-0002EN-A9; Fri, 07 Sep 2018 12:25:17 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyDwy-0000sz-NS; Fri, 07 Sep 2018 12:25:16 +0200
Date:   Fri, 7 Sep 2018 12:25:16 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] ubifs: authentication: Add hashes to index nodes
Message-ID: <20180907102516.2dr3x3mevuu2l2mz@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
 <20180704124137.13396-14-s.hauer@pengutronix.de>
 <2092924.iTNEbfF25J@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2092924.iTNEbfF25J@blindfold>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:11:05 up 86 days, 19:20, 73 users,  load average: 0.30, 0.22,
 0.18
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:36:56PM +0200, Richard Weinberger wrote:
> > diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
> > index a47fced47823..a00809d4fe6f 100644
> > --- a/fs/ubifs/tnc.c
> > +++ b/fs/ubifs/tnc.c
> > @@ -488,6 +488,12 @@ static int try_read_node(const struct ubifs_info *c, void *buf, int type,
> >  	if (crc != node_crc)
> >  		return 0;
> >  
> > +	err = ubifs_node_check_hash(c, buf, zbr->hash);
> > +	if (err) {
> > +		ubifs_err(c, "hash mismatch on node at LEB %d:%d", lnum, offs);
> > +		return 0;
> > +	}
> 
> Hmm, I think a global "hash is bad" handler would be nice to have.
> That way we always report in the same way.

I created a function reporting a bad hash, so every failure goes through
the same code...

> 
> Maybe also a new file system specific ioctl to query whether a hash
> failure was noticed.

but I'll leave that for a later excercise if that's ok. I am unsure how
useful such an ioctl() is. It's too easy to interpret such a hash
mismatch as some kind of security violation when it's more likely just a
bug somewhere.

> > @@ -868,6 +877,23 @@ static int write_index(struct ubifs_info *c)
> >  		}
> >  		len = ubifs_idx_node_sz(c, znode->child_cnt);
> >  		ubifs_prepare_node(c, idx, len, 0);
> > +		ubifs_node_calc_hash(c, idx, hash);
> > +
> > +		mutex_lock(&c->tnc_mutex);
> 
> This lock looks correct too me.
> Just in case, you did test with lockdep enabled? :-)

Yes, I had lockdep enabled in all my tests.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
