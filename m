Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 79133C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4E9208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="162muyA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4E9208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934702AbeFMHg6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933732AbeFMHg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:36:56 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A572420891;
        Wed, 13 Jun 2018 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528875416;
        bh=zapFHhH/HhsTDcYm8nhZBYDyLSxOqE2PGrKqpXwMkXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=162muyA+yvaE5AeoDw2vzhEZu9TEI+VB5vZginIxH7OPGGFfDr52+sYPnu5avxmTC
         Oy65HrpCCeOxafXOQ/PAO+Vbhz92IdrV3UK41L56sY0O4nz9TEBwTKRs+1tZmqilN5
         iGfplxKzzhwkbBlPquaIUvMqDoZIQPJ9a5g3WeKM=
Date:   Wed, 13 Jun 2018 10:36:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, hans.westgaard.ry@oracle.com,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180613073653.GC3275@mtr-leonro.mtl.com>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180612203322.GG6314@ziepe.ca>
 <20180613000739.GA32191@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20180613000739.GA32191@bombadil.infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 12, 2018 at 05:07:39PM -0700, Matthew Wilcox wrote:
> On Tue, Jun 12, 2018 at 02:33:22PM -0600, Jason Gunthorpe wrote:
> > > @@ -377,13 +378,24 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
> > >  		goto error4;
> > >  	}
> > >
> > > -	spin_lock_irq(&port_priv->reg_lock);
> > > -	mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id);
> > > +	idr_preload(GFP_KERNEL);
> > > +	idr_lock(&ib_mad_clients);
> > > +	ret2 = idr_alloc_cyclic(&ib_mad_clients, mad_agent_priv, 0,
> > > +			(1 << 24), GFP_ATOMIC);
> >
> > I like this series, my only concern is this magic number here, at the
> > very least it deserves a big comment explaining why it
> > exists..
>
> Yes, you're right.  Maybe something like this ...
>
> /*
>  * The mlx4 driver uses the top byte to distinguish which virtual function
>  * generated the MAD, so we must avoid using it.
>  */
> #define AGENT_ID_LIMIT		(1 << 24)
>
> ...
>
> 	ret2 = idr_alloc_cyclic(&ib_mad_clients, mad_agent_priv, 0,
> 			AGENT_ID_LIMIT, GFP_ATOMIC);
>
> > Let me see if I can get someone to give it some test time, I assume
> > you haven't been able to test it it?
>
> I don't have any IB hardware.  Frankly I'm scared of Infiniband ;-)

I took it for regression, reliable results will be after -rc1 only.

Thanks

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbIMmVAAoJEORje4g2clinhC0QAKb9tFYihLRWT+2+/JJMEyZZ
blKKXZgQlxNnKWUNAn5iQhwsXNrQrmXR9S2nxKuVIenIrUrig57FG1ULp7jttsFq
qXiCIrYgHU78nvMmQnr78Xkjstm2EBkmKFnLWjVyPuDYp/IsJgcq4/q7lSu8gSAK
VMYrAkEQUD6k+oegXaiKLsLpMVIiU3VNSQvNA6+mJm3VWUI640sWRWiPuAo8KXsw
FqpS2dSMKVM+LLRpV1Xqtl+3HpvgL4rPHra+HXfQqbpNpDBwWsPa538DCFFp+Ep6
1F+6OsiD/m1xIZntX0hMNueUKEkNeEgI7nSJJC+PUb1BstOVQ2Z0W6+YmrX0XqyZ
Xc3I5kfyWmtvdulwGl4OatBiLzfj4ni6Wdj47+JF9r0b2beVJYj9rBJlUtRBAK5w
XwHqSfkh97F7S62609E376lsMgUiVIQ/4NfWFP/ESES5LeVtMr0jVNsaV9EIzzZs
3y3llRC1qM9p7iVFuM8Gbx2dL+eS0eUbQq4h84sLziNRK81ws2k0A49iLeRKk6ZJ
z91VT1FzT4K5KcRRRrtO3OXaEy/vbT3frtJUxEwuyxF2VHUahyZNvJSfkxY9LEUJ
32RyvQQZs6sQRZUcdsd8+zC51RIAUtoOsWRNbmC7R0E+MNbjf4Gg7IW9GIimtPTg
cP1PlC2rxb0gyIfawXUK
=1UG0
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
