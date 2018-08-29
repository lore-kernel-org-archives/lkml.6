Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC30C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E612086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E612086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeH2KZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:25:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45543 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeH2KZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:25:23 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1futzP-0003yC-Fn; Wed, 29 Aug 2018 08:30:03 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1futzP-0007ci-73; Wed, 29 Aug 2018 08:30:03 +0200
Date:   Wed, 29 Aug 2018 08:30:03 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/25] ubifs: add helper functions for authentication
 support
Message-ID: <20180829063003.goc3eekjo42jkrgy@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
 <20180704124137.13396-11-s.hauer@pengutronix.de>
 <1675445.itdTWD7r8S@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675445.itdTWD7r8S@blindfold>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:27:26 up 77 days, 15:36, 50 users,  load average: 0.03, 0.07,
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

Hi Richard,

On Mon, Aug 27, 2018 at 02:50:37PM +0200, Richard Weinberger wrote:
> Am Mittwoch, 4. Juli 2018, 14:41:22 CEST schrieb Sascha Hauer:
> > This patch adds the various helper functions needed for authentication
> > support. We need functions to hash nodes, to embed HMACs into a node and
> > to compare hashes and HMACs. Most functions first check if this
> > filesystem is authenticated and bail out early if not, which makes the
> > functions safe to be called with disabled authentication.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > +void ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
> > +			     struct shash_desc *inhash)
> > +{
> > +	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
> > +	struct ubifs_auth_node *auth = node;
> > +	u8 hash[crypto_shash_descsize(c->hash_tfm)];
> 
> Doesn't this introduce a new VLA?
> Not that me make Kees unhappy. ;-)

/me just read https://lwn.net/Articles/749064/ and now realizes why this
is considered harmful.

Thanks for the review. I'll look into this and all the other points. I
guess that'll keep me busy for some time.

Thanks
  Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
