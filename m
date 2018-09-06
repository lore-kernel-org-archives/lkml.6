Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC06C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FC32075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PuSsu5Ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FC32075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbeIGBIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:08:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35325 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbeIGBIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:08:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A1DB821751;
        Thu,  6 Sep 2018 16:31:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 06 Sep 2018 16:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=DtqIiWdt4Wso9Rj6StRRr9L7ZYHci
        wFsrrxZJLUKl6Y=; b=PuSsu5OlRdRtdfeez6JgQBrs/y3krezGAwia9L+uKr/CL
        rEDDn2cJgr+fBLdzSM4iZkRI8YlxcJjJUFrP3Oqze1P7VGkkA+zmgXsxUw5ZXuxW
        cmjwOieLl8xt2TTb+XTDq8b4QvYftEqvz+AsFanu9rmyBiiRsjEkhtzvTRkX7RTI
        ek8j06g8ff/aQCT1ZW5dzrdO/bDhJb2ocGxU90kuIuS99dOyqaSpItzwe2Rb8OQ9
        Kqe/d210lO/L5ObuelWz99Uqr1zkTL05NvNARRCNCM6mMS40DPppcfsVjixmnzvr
        KfK+eoD2vPXArzE63FyflvEA0Yc/K7NBOHa+qVSiQ==
X-ME-Proxy: <xmx:pI6RW-fFVPxFghvPOZsajOqlULSxXFHVVFhDO0l0K3At_E0YEd440A>
    <xmx:pI6RW2Db-TXiGfJ5_P-Yuy-TaXhH8R2SUsTTBRPVAAGKfACwC80C9w>
    <xmx:pI6RW5_dO6DO0YOrdi929uc1m4pzCC1TXjeC7egEBpzaU2WVTcTNmg>
    <xmx:pI6RW5KExIHC2TEsq8XMwE0LPvNBayvNaelQ_GiJrcePEA23hSWEdA>
    <xmx:pI6RW6ixSioHee2bmoh9jZIZuZ0YeHO_hEwxE-T43oci9UwAYTUykw>
    <xmx:pI6RW8LBC_52lOLfshz7NLc2PMhtSt78ioTW5PkAppNQoUrmPy0EkA>
X-ME-Sender: <xms:pI6RW4Y1WNhpLt8Fe54DBh1Fot9uALRpkyQGsIg1BqlhrM3DHBU0cA>
Received: from mail-itl (ip5b40bfaa.dynamic.kabel-deutschland.de [91.64.191.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D9FEE4015;
        Thu,  6 Sep 2018 16:31:31 -0400 (EDT)
Date:   Thu, 6 Sep 2018 22:31:28 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/balloon: add runtime control for scrubbing ballooned
 out pages
Message-ID: <20180906203128.GJ1353@mail-itl>
References: <20180906153355.25363-1-marmarek@invisiblethingslab.com>
 <bf287a28-5e40-1ea2-a983-3d6a8e9a9869@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
Content-Disposition: inline
In-Reply-To: <bf287a28-5e40-1ea2-a983-3d6a8e9a9869@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 04:14:50PM -0400, Boris Ostrovsky wrote:
> On 09/06/2018 11:33 AM, Marek Marczykowski-G=C3=B3recki wrote:
> > Scrubbing pages on initial balloon down can take some time, especially
> > in nested virtualization case (nested EPT is slow). When HVM/PVH guest =
is
> > started with memory=3D significantly lower than maxmem=3D, all the extra
> > pages will be scrubbed before returning to Xen. But since most of them
> > weren't used at all at that point, Xen needs to populate them first
> > (from populate-on-demand pool). In nested virt case (Xen inside KVM)
> > this slows down the guest boot by 15-30s with just 1.5GB needed to be
> > returned to Xen.
> >
> > Add runtime parameter to enable/disable it, to allow initially disabling
> > scrubbing, then enable it back during boot (for example in initramfs).
> > Such usage relies on assumption that a) most pages ballooned out during
> > initial boot weren't used at all, and b) even if they were, very few
> > secrets are in the guest at that time (before any serious userspace
> > kicks in).
> >
> > Default behaviour is unchanged.
> >
> > Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblething=
slab.com>
> >
> > ---
> > Is module_param() a good thing for this? Other xen-balloon parameters a=
re
> > in /sys/devices/system/xen_memory, so maybe it would make sense to put
> > this one there too? But then, cmdline parameter would need to be added
> > separately and comment about core_param() suggests it shouldn't be used
> > if not absolutely necessary (is it?).
>=20
>=20
> You can also use cmdline_find_option() in the balloon driver.
>=20
> I would prefer that all tunables for the balloon driver live in the same
> place. (Note that in that case
> Documentation/ABI/stable/sysfs-devices-system-xen_memory will need to be
> updated).

Ok, will move that. This will also mean that it will affect only balloon
driver, not other users of mem-reservation.c (grant allocator). But
given the reason for this tunable, I think that's fine.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAluRjqAACgkQ24/THMrX
1ywXoQf9GslZ5mNMyTDoXZE1lz+20hZnloXps/YwcnK2/Ay5c3SGIrEmnd6vPDah
c4VUpATzbvRIDWgtkVlAohA1dunJXxEiG0kQfjPAkoPFbwtuY/O1/JW9m9vjnf4B
e9TBJ+IuN713Sh+6+AaBIfsNliiBnH6TCBL56v7EA3vi4t49oVPZ5Dp0xYjj7Tug
PmIL73QI99yol51gpGw0FZZTULlH7WqP2INzVsLhAQlhVyC7fN4wdskfBWnn9rao
aQpw6vIRu5TExGJn4hD8XjxIrfkkIGebvKVWATFHDHE/e1Z2lV0a++AitAg1l4zs
6vSnfcAZO8cVRQqD4SIPhDWGKtJJ1A==
=IoZO
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--
