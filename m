Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30754C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A1E223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLAxDash"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A1E223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeKPD4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:56:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41314 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeKPD4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:56:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so33111804qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m8xnfd4fa8f4zG2AS2xTneo1avObx9CW1Z0MhlUjWl0=;
        b=MLAxDashTlA/RCOVTuIUdxXDim2+yYxYD08v1pNf2hi+I+U9T/omeaTwd880za8G2Z
         wgwBoNOuBade+MOPDZjx+U0mAc8xiNGVCFVqQspdbVTHi/UAY/nbG/CQwckLrNlXJ0Rn
         l823pce8143iMJ09zUkqxRlswZ3oFHI3QdHyAStjgA881AsD8FHV4wx048pJl2yfOurK
         iT2SLDMlNplVYRDnbLeiJTtTNK6saaGj0U8QcfyBatHmn0zWHdVxgp9COwArgc1ccjsn
         JVdklzY9d3/vVo/P/hoQv37HPsa8ik51i0FOxXYA2A6VfYMa/d06ZCANJjj6fCJ1iCG/
         Ji2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m8xnfd4fa8f4zG2AS2xTneo1avObx9CW1Z0MhlUjWl0=;
        b=ucQrgPUxB9z3/bdipFM0wSkJl7rT8TBrAPrES7E0tbDvXguWmw1VbXjsxO9WEr5SIb
         fRNyBRmSI14ck/HP4In7kJtWFs2+Gc3BEsScb2UmOOMmsx31F/lr2v/OOmLlAK68UIkp
         9J/bOeBy3A/ErJRaDUAtakLvhdpn8n6YkY7GJo0IjKGAnSafmMsmN9CY1iunO6bgp4IX
         opsuQpmmF+z16fDajCdrYntRHJ1hb3YUeeT5cO7bUzXpYQffCBA/CE9NFQRUjdwk1qIZ
         FHrylgx56AE/N64pokwfkzcX47PVJodVC6Qv6FOhwZD26o04h6Eckwn8SYs5UtnSIi3S
         xrww==
X-Gm-Message-State: AGRZ1gLaae89VZ3oUMlc9srnv6Si0KEIyGO5IYmEOq5E5T4n5MjKQ5Ab
        FX+yIjtM3rsAPwlmM0EHh44=
X-Google-Smtp-Source: AJdET5ea/0jMOm830MoITZ/AtiGzwquGGe0phOqnyBZztllPBRwK+N99RKgRLtCa97lWLnFmYHym5A==
X-Received: by 2002:a0c:d602:: with SMTP id c2mr6992352qvj.151.1542304032328;
        Thu, 15 Nov 2018 09:47:12 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m20sm2050990qkk.66.2018.11.15.09.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 09:47:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6079821B4E;
        Thu, 15 Nov 2018 12:47:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Nov 2018 12:47:10 -0500
X-ME-Sender: <xms:HLHtW94msoDVipRe40t9vzHGX08GGipdYuQkxf_Jhd5-gCyTiXehYQ>
X-ME-Proxy: <xmx:HLHtW6zSxSEH2KuPn1ts7pcDL4E39UDicw-PRosWn8ZvqKSIoqv9og>
    <xmx:HLHtW7UJE2guXxwOlE2uBNeZ1R8aI_FdN5VRFwL8DLU4rwHagxBEGQ>
    <xmx:HLHtW5UF1j7M2lIcM7a-gjD0mEovtIT7EDl_BXOzSxphcypTiWZ_VQ>
    <xmx:HLHtW-PfrtpgmaUDQwwNi6LVWyUJA2GNm1LbhZbkAH3NiQZN8DV_Wg>
    <xmx:HLHtW9jcbzRoesAquls5Qyr7YFwvcmkeTnyKYDjpgqdHhGWPZMzgTA>
    <xmx:HrHtW0qzf3IU_Qb_7N3PWrlyvEgP4VmAZldanake0AgLZQ0Fmi-ZCA>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3CFC71034C;
        Thu, 15 Nov 2018 12:47:08 -0500 (EST)
Date:   Fri, 16 Nov 2018 01:54:20 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] tools/memory-model: Refactor some RCU relations
Message-ID: <20181115175420.GA3227@tardis>
References: <Pine.LNX.4.44L0.1811151116420.1308-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1811151116420.1308-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Thu, Nov 15, 2018 at 11:19:58AM -0500, Alan Stern wrote:
> In preparation for adding support for SRCU, refactor the definitions
> of rcu-fence, rcu-rscsi, rcu-link, and rb by moving the po and po?
> terms from the first two to the second two.  An rcu-gp relation is
> added; it is equivalent to gp with the po and po? terms removed.
>=20
> This is necessary because for SRCU, we will have to use the loc
> relation to check that the terms at the start and end of each disjunct
> in the definition of rcu-fence refer to the same srcu_struct
> location.  If these terms are hidden behind po and po?, there's no way
> to carry out this check.
>=20
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> ---
>=20
>=20
>  tools/memory-model/linux-kernel.cat |   25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -91,32 +91,37 @@ acyclic pb as propagation
>  (*******)
> =20
>  (*
> - * Effect of read-side critical section proceeds from the rcu_read_lock()
> - * onward on the one hand and from the rcu_read_unlock() backwards on the
> + * Effects of read-side critical sections proceed from the rcu_read_unlo=
ck()
> + * backwards on the one hand, and from the rcu_read_lock() forwards on t=
he
>   * other hand.
> + *
> + * In the definition of rcu-fence below, the po term at the left-hand si=
de
> + * of each disjunct and the po? term at the right-hand end have been fac=
tored
> + * out.  They have been moved into the definitions of rcu-link and rb.
>   *)
> -let rcu-rscsi =3D po ; rcu-rscs^-1 ; po?
> +let rcu-gp =3D [Sync-rcu]		(* Compare with gp *)
> +let rcu-rscsi =3D rcu-rscs^-1

Isn't it more straight-forward to use "rcu-rscs^-1" other than
"rcu-rscsi" in the definition of "rcu-fence", is it?

The introduction of "rcu-rscsi" makes sense in the first patch, but with
this refactoring, I think it's better we just don't use it.

Regards,
Boqun

> =20
>  (*
>   * The synchronize_rcu() strong fence is special in that it can order not
>   * one but two non-rf relations, but only in conjunction with an RCU
>   * read-side critical section.
>   *)
> -let rcu-link =3D hb* ; pb* ; prop
> +let rcu-link =3D po? ; hb* ; pb* ; prop ; po
> =20
>  (*
>   * Any sequence containing at least as many grace periods as RCU read-si=
de
>   * critical sections (joined by rcu-link) acts as a generalized strong f=
ence.
>   *)
> -let rec rcu-fence =3D gp |
> -	(gp ; rcu-link ; rcu-rscsi) |
> -	(rcu-rscsi ; rcu-link ; gp) |
> -	(gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
> -	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; gp) |
> +let rec rcu-fence =3D rcu-gp |
> +	(rcu-gp ; rcu-link ; rcu-rscsi) |
> +	(rcu-rscsi ; rcu-link ; rcu-gp) |
> +	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
> +	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
>  	(rcu-fence ; rcu-link ; rcu-fence)
> =20
>  (* rb orders instructions just as pb does *)
> -let rb =3D prop ; rcu-fence ; hb* ; pb*
> +let rb =3D prop ; po ; rcu-fence ; po? ; hb* ; pb*
> =20
>  irreflexive rb as rcu
> =20
>=20

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlvtssMACgkQSXnow7UH
+rj0+Af+IDIVrVlyk7c8RrloAC/DfX4vuHEoRyUxxQk5/sWXc0aXrxiNbHpIxc4p
qUSHQgc9YxzrLQtCzrb9WF9QkWbJkOm5JPeQutor4cwxaEzWv5hChO1BaXUoWP1S
nMmbPaB3/5YrZ10b6LbSsXZ0DfckfiXnpmL+geUZHeym6vfoEwkAAk/YqK9BngHq
M0IZy/64AIlIqikqC8IL++Flb/E7zfEVzOZq/Ch0PF8hR0n5uLoeApl3Tqzt6ZAk
ucnqhhmpF/w98eVUe7oWsPYifj/ZEadqzSgZ02qYeJd0F+L0Zvby8ZX4MjVKjLWI
9YJ1UPzEzep43A7Da9iNipfpr/1bRw==
=sjHZ
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
