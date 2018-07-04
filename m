Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5C5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1E821AA6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1E821AA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeGDOpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:45:33 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59921
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752242AbeGDOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:45:32 -0400
X-IronPort-AV: E=Sophos;i="5.51,306,1526335200"; 
   d="scan'208";a="271710318"
Received: from atoulouse-658-1-200-119.w90-60.abo.wanadoo.fr (HELO hadrien.local) ([90.60.97.119])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 16:45:30 +0200
Date:   Wed, 4 Jul 2018 16:45:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D95BCDE@hasmsx108.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1807041644450.4944@hadrien>
References: <20180704093449.vryluk7khaudstgp@kili.mountain> <alpine.DEB.2.20.1807041358580.4387@hadrien> <20180704121600.hrezydpvpe4hyie3@mwanda> <5B8DA87D05A7694D9FA63FD143655C1B9D95BC46@hasmsx108.ger.corp.intel.com> <20180704141558.4645lmns7kerdahg@mwanda>
 <5B8DA87D05A7694D9FA63FD143655C1B9D95BCDE@hasmsx108.ger.corp.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Jul 2018, Winkler, Tomas wrote:

>
> > On Wed, Jul 04, 2018 at 01:57:44PM +0000, Winkler, Tomas wrote:
> > > >
> > > > On Wed, Jul 04, 2018 at 01:59:14PM +0200, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Wed, 4 Jul 2018, Dan Carpenter wrote:
> > > > >
> > > > > > We accidentally removed the check for negative returns without
> > > > > > considering the issue of type promotion.  The "if_version_length"
> > > > > > variable is type size_t so if __mei_cl_recv() returns a negative
> > > > > > then "bytes_recv" is type promoted to a high positive value and
> > > > > > treated as success.
> > > > > >
> > > > > > Fixes: 582ab27a063a ("mei: bus: fix received data size check in
> > > > > > NFC
> > > > > > fixup")
> > > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > >
> > > > > > diff --git a/drivers/misc/mei/bus-fixup.c
> > > > > > b/drivers/misc/mei/bus-fixup.c index 0208c4b027c5..fa0236a5e59a
> > > > > > 100644
> > > > > > --- a/drivers/misc/mei/bus-fixup.c
> > > > > > +++ b/drivers/misc/mei/bus-fixup.c
> > > > > > @@ -267,7 +267,7 @@ static int mei_nfc_if_version(struct mei_cl
> > > > > > *cl,
> > > > > >
> > > > > >  	ret = 0;
> > > > > >  	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length,
> > 0);
> > > > > > -	if (bytes_recv < if_version_length) {
> > > > > > +	if (bytes_recv < 0 || bytes_recv < if_version_length) {
> > > > >
> > > > > Is this preferred to adding an int cast?
> > > >
> > > > I don't think it matters.  I kind of like explicitly testing for
> > > > negative but maybe later people will just remove the check like we
> > > > did here?  You could do it a bunch of different ways:
> > > >
> > > > 1: if (ret < 0 || ret < ARRAY_SIZE(xxx))
> > > > 2: if (ret < (int)ARRAY_SIZE(xxx))
> > > > 3: if (ret != ARRAY_SIZE(xxx))
> > > >
> > > > They're all equivalent.  I guess I don't like casting too much.  My
> > > > first approach to fixing this was just to declare if_version_length
> > > > as an int, but then I saw that originally there was a "bytes_recv < 0"
> > > > check and decided to go that way instead.
> > >
> > > Actually bytes_recv should be probably of ssize_t type,  so could be the
> > if_version_length.
> > >
> > > How did you find this, I haven't seen it in reported by sparse, smatch and I
> > believe -Wsign-compare is suppressed in compilation warnings.
> >
> > It's a new thing.  Julia noticed this kind of bug first

Actually, I got it from Joe Perches, for the sizeof case :)

julia

> > and I have been mucking
> > around with it in Smatch as well.  My Smatch check has too many false
> > positives to publish right now because it thinks a some common functions
> > like ffs() return negative error codes.
>
> I guess this is why it is suppressed in the compilation warnings  in the first place.
> Maybe need to disable it selectively, like for fss, just not sure how bad is that with false positive reports.
>
>
> Thanks
> Tomas
>
>
