Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C9AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866BF21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866BF21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeJJOeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:34:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbeJJOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E83B1AC52;
        Wed, 10 Oct 2018 07:13:18 +0000 (UTC)
Date:   Wed, 10 Oct 2018 18:14:47 +1100
From:   Aleksa Sarai <asarai@suse.de>
Cc:     Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <20181010071447.whwwxjdv54qfnvsr@mikami>
References: <20181009103752.21482-1-laurent@vivier.eu>
 <20181009103752.21482-2-laurent@vivier.eu>
 <20181009151641.GB10149@cisco>
 <409c22e3-1df8-cf7f-2462-ead2bb3020cf@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5jn6nwbw5w45hpy6"
Content-Disposition: inline
In-Reply-To: <409c22e3-1df8-cf7f-2462-ead2bb3020cf@vivier.eu>
o:      Laurent Vivier <laurent@vivier.eu>
User-Agent: NeoMutt/20180716
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5jn6nwbw5w45hpy6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-09, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 09/10/2018 =E0 17:16, Tycho Andersen a =E9crit=A0:
> > On Tue, Oct 09, 2018 at 12:37:52PM +0200, Laurent Vivier wrote:
> >> @@ -80,18 +74,32 @@ static int entry_count;
> >>   */
> >>  #define MAX_REGISTER_LENGTH 1920
> >> =20
> >> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
> >> +{
> >> +	struct binfmt_namespace *b_ns;
> >> +
> >> +	while (ns) {
> >> +		b_ns =3D READ_ONCE(ns->binfmt_ns);
> >> +		if (b_ns)
> >> +			return b_ns;
> >> +		ns =3D ns->parent;
> >> +	}
> >> +	WARN_ON_ONCE(1);
> >=20
> > It looks like we warn here,
> >=20
> >> @@ -133,17 +141,18 @@ static int load_misc_binary(struct linux_binprm =
*bprm)
> >>  	struct file *interp_file =3D NULL;
> >>  	int retval;
> >>  	int fd_binary =3D -1;
> >> +	struct binfmt_namespace *ns =3D binfmt_ns(current_user_ns());
> >> =20
> >>  	retval =3D -ENOEXEC;
> >> -	if (!enabled)
> >> +	if (!ns->enabled)
> >=20
> > ...but then in cases like this we immediately dereference the pointer
> > anyways and crash. Can we return some other error code here in the !ns
> > case so we don't crash?
>=20
> My concern here is I don't want to add code to check an error case that
> cannot happen. The first namespace binfmt_ns pointer is initialized with
> &init_binfmt_ns, so the return value cannot be NULL.

I'd argue that BUG() is a better thing to do then -- if doing a dummy
error path makes no sense. Though IIRC BUG() is no longer a popular
thing to do.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--5jn6nwbw5w45hpy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlu9puMACgkQnhiqJn3b
jbRLDBAAstmpL3yvxUBUsp+o1eDUI0ZuTqG4whpTYckWTtCm59TAn4wotIT5Pv0I
6f1SNATVnxq7U+ot1tCluNr0jXe1u/0S7ZvEY8zpHzWomc9CFUsM+yFENbCgDl0D
qmKMiKwlSYk8tEI3WnAfWb9l7hwrUoFCHrCmUUucrccDltvhiYaDRufoezcMqpEB
DtTchJIv+6bf1YcEbVa6xM8pG915ywtavVHlOMcUxtPuybk5RZGEcgZJo8Fn5PgF
HLCiVgiWdKNBY1Md2gTF6gf1zGp2tSc7e/ARUftL9JlE+hLIWudyLrpwMaXqfBMQ
4YxTM6xmHuCuW7ZgDg29zvQ4aJxRgoDrx438hYVemkUFxWAub56ZK7HHLv+Ls47Y
QKO5QAt1jRPGpMtPpABBgfFcb4nD+v4BY6eY3po8/pTpQv8P5by0HjjnV3K7/Jar
2UnvOCSOeZ6QbPI0gp1LYKkOBoINJSLkn8rHmjeM9xh8VtyktrlVelYTPH9/qdoQ
FLNVDUlxEig1c7FiKBhzPhNRDGWO5+hF4Ughg3A+kutPumILfuk1j1pCNZJM9HSz
pIYFmvpReZkFzOHlLeGLNFmym+OCf6q3+/QUX5P9L2saOkyALS4Aww/wxVOeKOrw
uJ4zc4NzmU48TmhAKlUBcnryN7EE/RhsEXamlcXQcdsGwW6cFok=
=AzDm
-----END PGP SIGNATURE-----

--5jn6nwbw5w45hpy6--
