Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8193DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BA620849
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0+13FjZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BA620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbeGKMMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKMMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:12:50 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B55D2077B;
        Wed, 11 Jul 2018 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531310928;
        bh=YIs3IWxq03oCvSTSSU26mQ1+W92YyEKP7mOsyOYTDR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0+13FjZOVhQ6c4/+jQ61djGGVN4Vb7+35oIrbrf05TPWjdz2qO9xgmVqlwLOAw2a4
         LrznAnQsQFToQHFATqtJCf8IpAFtfM2tjIYzhoGK9q/AXg3qRbMfizeQeGRYiHIr4I
         YepfRTHIVclC1rLceN6WHoPK41m4fr6rTb2jH598=
Date:   Wed, 11 Jul 2018 15:08:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180711120845.GA7750@mtr-leonro.mtl.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <20180627074421.GF32348@dhcp22.suse.cz>
 <20180709122908.GJ22049@dhcp22.suse.cz>
 <20180710134040.GG3014@mtr-leonro.mtl.com>
 <20180710141410.GP14284@dhcp22.suse.cz>
 <20180710162020.GJ3014@mtr-leonro.mtl.com>
 <20180711090353.GD20050@dhcp22.suse.cz>
 <20180711101447.GU3014@mtr-leonro.mtl.com>
 <20180711111318.GL20050@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20180711111318.GL20050@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2018 at 01:13:18PM +0200, Michal Hocko wrote:
> On Wed 11-07-18 13:14:47, Leon Romanovsky wrote:
> > On Wed, Jul 11, 2018 at 11:03:53AM +0200, Michal Hocko wrote:
> > > On Tue 10-07-18 19:20:20, Leon Romanovsky wrote:
> > > > On Tue, Jul 10, 2018 at 04:14:10PM +0200, Michal Hocko wrote:
> > > > > On Tue 10-07-18 16:40:40, Leon Romanovsky wrote:
> > > > > > On Mon, Jul 09, 2018 at 02:29:08PM +0200, Michal Hocko wrote:
> > > > > > > On Wed 27-06-18 09:44:21, Michal Hocko wrote:
> > > > > > > > This is the v2 of RFC based on the feedback I've received so far. The
> > > > > > > > code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
> > > > > > > > because I have no idea how.
> > > > > > > >
> > > > > > > > Any further feedback is highly appreciated of course.
> > > > > > >
> > > > > > > Any other feedback before I post this as non-RFC?
> > > > > >
> > > > > > From mlx5 perspective, who is primary user of umem_odp.c your change looks ok.
> > > > >
> > > > > Can I assume your Acked-by?
> > > >
> > > > I didn't have a chance to test it because it applies on our rdma-next, but
> > > > fails to compile.
> > >
> > > What is the compilation problem? Is it caused by the patch or some other
> > > unrelated changed?
> >
> > Thanks for pushing me to take a look on it.
> > Your patch needs the following hunk to properly compile at least on my system.
>
> I suspect you were trying the original version. I've posted an updated
> patch here http://lkml.kernel.org/r/20180627074421.GF32348@dhcp22.suse.cz
> and all these issues should be fixed there. Including many other fixes.
>

Ohh, you used --reply-to, IMHO it is best way to make sure that the
patch will be lost :)

> Could you have a look at that one please?

I grabbed it, the results will be overnight only.

Thanks

> --
> Michal Hocko
> SUSE Labs

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbRfNNAAoJEORje4g2clinlVwP+gOTolhbvb7Z7rdf1A/MW8q6
SOrUeHuzbfpi3QwcJOQv9305fjVWOQ8Sgqv9xbYw19ISxlIY+B/tm+XgbUEcMHMC
P0TYVuLz2SGJCRoovqICZ49NzestzlGyn3Nv5AGoKG2JAzWXphtHROIkGt3SNraX
O1B+izek2DrruThuLEtQbNHx+gI9QP7YZhdz7ClbNO2VwxIGQZcCvhjc2fG1v6ab
dkXKZ3QS05bm5rQO2+VFV3WhAFtkUwocqyjrGrbvn6IgDWYPmXmXhbjhSbLs4V+w
ggj4kwUQd0R/QQY126lOtkvZKQk/EZu+GmumNpLqeTY0AF+vX4SOMrsZreekaQIw
4ZzouQ0yFyBGIYO/i+zQaAyAgwJBf0b1nyWl+OZyY8E03e2COp0GF2sdiTMo5K+N
G9msVCQhavJsWawiL+1RyzgfLHipcnp4dYCFDqpqbZR/3Kx7ld1OBWT0JzbhuqZW
x4uelzSwBAzeZW2Hj2TYfMNuaRlHBiJi7Bqct8b2avsftTvGvUdQKbtxxxXzd1SI
J1OgzS/WFi/Ao+UW0yFVXWKtitaIMzCVhZroYZs4BUoKJq8fLjGSaXxEPfUfLQmT
SjbLYA8IVUQLJs3yx/2TJrRxu2ti8zUhnv+jJfcG0T7LT5CjL9Qe7Yx8lMy+u4eR
ngUiQqGK0WJWIaQq3r19
=g6/F
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
