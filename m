Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44FC20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44FC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbeKTGyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:54:31 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:42222 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbeKTGyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:54:31 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 1EE31497D9;
        Mon, 19 Nov 2018 21:29:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id mNbkx0gY0nFg; Mon, 19 Nov 2018 21:29:08 +0100 (CET)
Date:   Tue, 20 Nov 2018 07:28:57 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119202857.k5zw742xjfrw677j@yavin>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gtgc45ynebhhjwty"
Content-Disposition: inline
In-Reply-To: <20181119103241.5229-3-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gtgc45ynebhhjwty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> +	if (info) {
> +		ret =3D __copy_siginfo_from_user(sig, &kinfo, info);
> +		if (unlikely(ret))
> +			goto err;
> +		/*
> +		 * Not even root can pretend to send signals from the kernel.
> +		 * Nor can they impersonate a kill()/tgkill(), which adds
> +		 * source info.
> +		 */
> +		ret =3D -EPERM;
> +		if ((kinfo.si_code >=3D 0 || kinfo.si_code =3D=3D SI_TKILL) &&
> +		    (task_pid(current) !=3D pid))
> +			goto err;
> +	} else {
> +		prepare_kill_siginfo(sig, &kinfo);
> +	}

I wonder whether we should also have a pidns restriction here, since
currently it isn't possible for a container process using a pidns to
signal processes outside its pidns. AFAICS, this isn't done through an
explicit check -- it's a side-effect of processes in a pidns not being
able to address non-descendant-pidns processes.

But maybe it's reasonable to allow sending a procfd to a different pidns
and the same operations working on it? If we extend the procfd API to
allow process creation this would allow a container to create a process
outside its pidns.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--gtgc45ynebhhjwty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvzHQkACgkQSnvnv3De
m58IwBAAgHKh2abQgnpam0GUxYiHi88rnCgkNIbQ9UCsmfE565c+gUSS9jmJxDmJ
pbd3pdWcS1zZdRWC3mD75W6bYbnu0OEyKcJbjXXwR2+aK4Z98UJNtWtFPtFpny2T
U38WVhtyJafQ8GgAQB7WN5SAloUIv8vbMoIlZw5FJzehmks8528fJq4L6zDdc+Cv
xaB8Cn6MeWAyry5HM5534QTW4uAEdw0MQ8Q+n8H0tjbXPoJ9kLS7JsIbAm+VFTZJ
Lc4jfnm5VUHkHfCnpurJHBYJTtl6EsumWDAeQPG6hcQ3aBDFRGoWQ3GbrmfRwtqi
KQgy8SyVZ3RCxK9xJtW2keGMnLPxMaPNL1QWV9rlSPNhSzhbUupyYUKXnnjX9SD8
KG7V1bNv7CScO34o8gTCIv2wX1PVHRczZdbHTmx5aU78EFKFJmml+DdTR7QYUNb/
4GvnRCMRSrsewabQKfOroLVkg0lmicPh6SMvGujsfd2QDEenzRWHU9QxHzecXfYl
qH2Q/+LMa32WRLgG3/sVZLf4Pjy/UHHm/W4I9EkqWLrXjo/87wrMfWjxWCRdLDry
ongYz/FLqY56phw1ZkCPICh2UF9sCdQ3fOowyGfTDmOlphSsMIuZWfeITOproXS1
OBL5DWnAtBVP/ZIye1ctHRFF98bak0hIAgvx0YphLHrX9lt5w9g=
=Euc9
-----END PGP SIGNATURE-----

--gtgc45ynebhhjwty--
