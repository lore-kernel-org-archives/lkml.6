Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B6DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DFC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DFC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeH3Rn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:43:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48211 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbeH3Rn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:43:29 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fvNC4-00087K-7S; Thu, 30 Aug 2018 15:41:04 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fvNC3-0000J5-Fp; Thu, 30 Aug 2018 15:41:03 +0200
Date:   Thu, 30 Aug 2018 15:41:03 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/25] ubifs: Add authentication nodes to journal
Message-ID: <20180830134103.qftgy2hdlopfup5s@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
 <1901352.nUraZMrBkh@blindfold>
 <20180829143834.wwojzrwmpadxqiqk@pengutronix.de>
 <1631201.FhrAdlTAGn@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631201.FhrAdlTAGn@blindfold>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:31:44 up 78 days, 22:40, 48 users,  load average: 0.09, 0.09,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:54:30PM +0200, Richard Weinberger wrote:
> Am Mittwoch, 29. August 2018, 16:38:34 CEST schrieb Sascha Hauer:
> > On Mon, Aug 27, 2018 at 10:48:26PM +0200, Richard Weinberger wrote:
> > > >  	release_head(c, BASEHD);
> > > >  	kfree(dent);
> > > > +	ubifs_add_dirt(c, lnum, ubifs_auth_node_sz(c));
> > > 
> > > You have to account it immediately because while a commit you have no longer
> > > a reference to them?
> > > Upon replay you should have since you scan LEBs anyway.
> > 
> > What do you mean here? Is that a suggestion to change something?
> 
> I don't fully understand how you keep the lprops dirty counter correct for
> auth nodes. Hence the question.
> 
> Auth nodes are not referenced by the index, so you have to keep track of
> them manually.

Yes. That's why I call ubifs_add_dirt(c, lnum, ubifs_auth_node_sz(c))
each time I create an auth node.

> Is your current approach "mark them dirty immediately and rely on LPT commit"
> to not get lost of an auth node?

Yes, I mark the auth nodes dirty in the assumption that the correct
values are written on a LPT commit.

> 
> I expected auth nodes getting dirtied also during journal reply.

Yes, this happens in replay.c replay_bud(). "used" gets increased with
every node found except when it's an auth node. Here "used" is not
increased, the result is that the auth node adds to the dirty space.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
