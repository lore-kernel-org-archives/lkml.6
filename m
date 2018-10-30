Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6856C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7FD2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7FD2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeJ3NwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 09:52:16 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:54976 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeJ3NwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 09:52:16 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id B0F9E4296F;
        Tue, 30 Oct 2018 06:00:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id frgYADXi97fT; Tue, 30 Oct 2018 06:00:18 +0100 (CET)
Date:   Tue, 30 Oct 2018 16:00:12 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, surenb@google.com
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181030050012.u43lcvydy6nom3ul@yavin>
References: <20181029221037.87724-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxjaav5rzxv6e2sm"
Content-Disposition: inline
In-Reply-To: <20181029221037.87724-1-dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxjaav5rzxv6e2sm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-29, Daniel Colascione <dancol@google.com> wrote:
> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> write the signal number in base-10 ASCII to the kill file of the
> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
>=20
> Semantically, /proc/pid/kill works like kill(2), except that the
> process ID comes from the proc filesystem context instead of from an
> explicit system call parameter. This way, it's possible to avoid races
> between inspecting some aspect of a process and that process's PID
> being reused for some other process.

(Aside from any UX concerns other folks might have.)

I think it would be a good idea to (at least temporarily) restrict this
so that only processes that are in the same PID namespace as the /proc
being resolved through may use this interface. Otherwise you might have
cases where partial container breakouts can start sending signals to
PIDs they wouldn't normally be able to address.

> With /proc/pid/kill, it's possible to write a proper race-free and
> safe pkill(1). An approximation follows. A real program might use
> openat(2), having opened a process's /proc/pid directory explicitly,
> with the directory file descriptor serving as a sort of "process
> handle".

I do like the idea of holding a dirfd to /proc/$pid to address
processes, and it something I considered doing in runc. (Unfortunately
there are lots of things that make it a bit difficult to use /proc/$pid
exclusively for introspection of a process -- especially in the context
of containers.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--wxjaav5rzxv6e2sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvX5VwACgkQSnvnv3De
m58W1RAA4BTdMe+UnblWb6o2e7KZ+pRPIFZJ9eJJQ64yhw4i0yEu/bBCjsLccl51
uhVBZSKY4Gg9BpzuyqeFyDdZoSa4Ifcm1oeGlWq1ZKoBteq7lMxlqJ7aX9IydhLD
fsZ807py+YNIeaESyGcP2cKIJAsCkOnoGtSvNvUI/f3UyduS4PsjVu4Dn0Io1t2z
FDAx5xA283Em2qy8MXrVZ7pKc6wkynGnKX2Jo8Vhp2oovwSImc5onVNSX8VTV1Uh
uEwSd2ir5oRM/YTJP9aCoCLC4aRi7oBxEqcEgLtuIxuQn8h8XMsq0Nja3mnYgEaF
c17AJ996fX9SX0vP2lWFAHNGjqlbe8VIeq2terv3Jc7aNAyMCY7uJZM2dFcZKHnd
Ao5sdvBQ/3k/HD+KGJ58KPoGq7XJ+LwgfZGiajsla0DaaSRAO5N7vIEtBLiBu9t7
QVHFzys4N2LQ1B32kOSQqYxFwdBjH7i63msJtjZb+CxN/liroqzuc+W1TeH1lJMI
h1ybxiWGS098HGPw2caZ06zPbXKjU4JMviZ+xhFK8ebwXA2sYtW+ONEncXdMQwBX
wXs2Hfg9b4CvKvmSQpBitphb8skV1B8m2wZ1hgh56hR/F1A2HqT3oYTPdGfjBxoK
/ryxBlX+jVy24Jg3AK4n+w3SpBG55mVCLCBhfOstfJcn9vcUqus=
=X7U2
-----END PGP SIGNATURE-----

--wxjaav5rzxv6e2sm--
