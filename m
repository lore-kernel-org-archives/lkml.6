Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F620C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED89021536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZekiCJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED89021536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeIZXOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbeIZXOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:14:18 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EB521531;
        Wed, 26 Sep 2018 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537981226;
        bh=EAomQYGN2qq6omP84n/S2FByNA5T9iSUrynILCcvv4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZekiCJrHo72awVPgCJhhUcta873ejr4ASM9FJ599g2D3oXVuAfU0RjFxpHcop/0F
         FLfpk93yIAQJz+ZX3kVDLFg69MLtxbT+spFePoD7EujxS64H7XShIu8Ya6HTZL+u9r
         /yuL8loZibZDfNUAFcIc5xvDz9OBRVzWw0inmbgo=
Date:   Wed, 26 Sep 2018 20:00:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 0/4] IB: decrease large contigous allocation
Message-ID: <20180926170012.GA1689@mtr-leonro.mtl.com>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <20180918144623.GI11367@ziepe.ca>
 <20180918212351.GB3661@mtr-leonro.mtl.com>
 <20180926184342.44deaa4f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qYrsQHciA3Wqs7Iv"
Content-Disposition: inline
In-Reply-To: <20180926184342.44deaa4f@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qYrsQHciA3Wqs7Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 26, 2018 at 06:43:42PM +0300, Jan Dakinevich wrote:
> On Wed, 19 Sep 2018 00:23:51 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
>
> > On Tue, Sep 18, 2018 at 08:46:23AM -0600, Jason Gunthorpe wrote:
> > > On Tue, Sep 18, 2018 at 04:03:42PM +0300, Jan Dakinevich wrote:
> > > > The size of mlx4_ib_device became too large to be allocated as
> > > > whole contigous block of memory. Currently it takes about 55K. On
> > > > architecture with 4K page it means 3rd order.
> > > >
> > > > This patch series makes an attempt to split mlx4_ib_device into
> > > > several parts and allocate them with less expensive kvzalloc
> > >
> > > Why split it up? Any reason not to just allocate the whole thing
> > > with kvzalloc?
> >
>
> This allocation could be triggered by userspace. It means that at
> _arbitrary_ time kernel could be asked for high order allocation.
>
> This case is considered unacceptable for system under significant load,
> since kernel would try to satisfy this memory request wasting the
> overall performance.

In such case, you won't do very much with mlx4_ib device. It will be
unusable.

>
> > And before we are rushing to dissect mlx4_ib driver, can you
> > explain the rationale behind this change? The mlx4_ib driver
> > represents high-performance device which needs enough memory
> > resources to operate. Those devices are limited by number
> > of PCIs and SRIOV VFs (upto 126) and very rare allocated/deallocated.
> >
> > I would like to see real rationale behind such change.
> >
> > Thanks
> >
> > >
> > > Jason
>
>
>
> --
> Best regards
> Jan Dakinevich

--qYrsQHciA3Wqs7Iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbq7scAAoJEORje4g2cliny78QAMfrZwnctaunVHovMlXHrNtm
CXJZ4wuNvp+gm5FHweqOYHjRvooBwl1SN3oO2VWp/BgFIEE2L1saRW6lXPHD7czW
BUPLBuPv9QDeMAr2PvOyqTtQGfMeZ4eAhUHaD/+E4DiOGb+JEpuq9SIxjEQUzzSB
xNOlEurFEc4NC0T3UQCreItcu1izQjGfbTEozN9ebxMr8jUUXFbSBzu7MIkKnQyy
Fr8j1S/NrVDd1VmUuYdb/Oa4Dx0c3kYJkVDTM9ohtbNvUopfyua2WRusuXJZCGis
8B5ZnSkw+6Kh/mJe1pynSI4QxTkS4CCF9dO+X1fq4mdFkJr8/hH+tHPae3hlUGeL
CrMiu9JPP2GZeCArTTik9THDRcDi5tUqWzxqXSN3X0o8t5IKP9SbquBivJJxD6qU
nwcrGGv5kjvQCEgBgr3taAZbdrotW6ZAfd0jLLGFNpvFvyOFMeY1Q+z3j1zNAbEA
Q1LTIH6CHIDMkRuBzigVC+gnj4pTmY0IalMC9lSHS5DvQSVH1LPpalEN7dToInjb
VJlNBoeF2cpmhlTKmkSGAZ+qW3Ns28b2Qn1WWitzwg6EGjFhMHca7LgSj1+CFjx1
wROCykhwKMBxqeUkpxQQshVg01IixRn2kbyI4xVjaqraeKzWjYXlZM+qXBb+J8l7
Gg2VpwMtPHmk4ZWGSuWP
=px7I
-----END PGP SIGNATURE-----

--qYrsQHciA3Wqs7Iv--
