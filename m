Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E3CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0649D20858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0649D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeH2PNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:13:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55213 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2PNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:13:02 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fuySi-0000qJ-3v; Wed, 29 Aug 2018 13:16:36 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fuySh-0000vP-KW; Wed, 29 Aug 2018 13:16:35 +0200
Date:   Wed, 29 Aug 2018 13:16:35 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/25] ubifs: Add hashes to the tree node cache
Message-ID: <20180829111635.zfgaosho3ambuk6t@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
 <20180704124137.13396-13-s.hauer@pengutronix.de>
 <3260968.WmIi4lir0Q@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3260968.WmIi4lir0Q@blindfold>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:15:44 up 77 days, 20:24, 60 users,  load average: 0.14, 0.08,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:18:25PM +0200, Richard Weinberger wrote:
> Am Mittwoch, 4. Juli 2018, 14:41:24 CEST schrieb Sascha Hauer:
> > As part of the UBIFS authentication support every branch in the index
> > gets a hash covering the referenced node. To make that happen the tree
> > node cache needs hashes over the nodes. This patch adds a hash argument
> > to ubifs_tnc_add() and ubifs_tnc_add_nm(). The hashes are calculated
> > from the callers of these functions which actually prepare the nodes.
> > With this patch all the leaf nodes of the index tree get hashes, but
> > currently nothing is done with these hashes, this is left for a later
> > patch.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  fs/ubifs/journal.c | 93 ++++++++++++++++++++++++++++++++++------------
> >  fs/ubifs/replay.c  |  4 +-
> >  fs/ubifs/tnc.c     | 10 ++++-
> >  fs/ubifs/ubifs.h   |  7 +++-
> >  4 files changed, 84 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> > index 754d969eb27e..55b35bc33c31 100644
> > --- a/fs/ubifs/journal.c
> > +++ b/fs/ubifs/journal.c
> > @@ -517,6 +517,9 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
> >  	struct ubifs_dent_node *dent;
> >  	struct ubifs_ino_node *ino;
> >  	union ubifs_key dent_key, ino_key;
> > +	u8 hash_dent[UBIFS_MAX_HASH_LEN];
> > +	u8 hash_ino[UBIFS_MAX_HASH_LEN];
> > +	u8 hash_ino_host[UBIFS_MAX_HASH_LEN];
> 
> With authentication enabled, this makes perfectly sense.
> But if someone builds UBIFS without and has a memory constraint system,
> we could save by setting UBIFS_MAX_HASH_LEN to 0. What do you think?
> Although, we need another define to not influence ubifs-media.h.

I gave it a try and it looks good. Will do it that way.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
