Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6454AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2008D2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2008D2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeKAQIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:08:49 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:55766 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeKAQIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:08:48 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 753FD4BA77;
        Thu,  1 Nov 2018 08:07:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id eYYAC7niajHw; Thu,  1 Nov 2018 08:07:00 +0100 (CET)
Date:   Thu, 1 Nov 2018 18:06:52 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, christian@brauner.io,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v2] Minimal non-child process exit notification
 support
Message-ID: <20181101070652.jrc3jgdmykc27t4w@yavin>
References: <20181029175322.189042-1-dancol@google.com>
 <20181029192250.130551-1-dancol@google.com>
 <20181101070036.l24c2p432ohuwmqf@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q523ya7z4aumdipt"
Content-Disposition: inline
In-Reply-To: <20181101070036.l24c2p432ohuwmqf@yavin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q523ya7z4aumdipt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-01, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-10-29, Daniel Colascione <dancol@google.com> wrote:
> > This patch adds a new file under /proc/pid, /proc/pid/exithand.
> > Attempting to read from an exithand file will block until the
> > corresponding process exits, at which point the read will successfully
> > complete with EOF.  The file descriptor supports both blocking
> > operations and poll(2). It's intended to be a minimal interface for
> > allowing a program to wait for the exit of a process that is not one
> > of its children.
> >=20
> > Why might we want this interface? Android's lmkd kills processes in
> > order to free memory in response to various memory pressure
> > signals. It's desirable to wait until a killed process actually exits
> > before moving on (if needed) to killing the next process. Since the
> > processes that lmkd kills are not lmkd's children, lmkd currently
> > lacks a way to wait for a process to actually die after being sent
> > SIGKILL; today, lmkd resorts to polling the proc filesystem pid
> > entry. This interface allow lmkd to give up polling and instead block
> > and wait for process death.
>=20
> I agree with the need for this interface (with a few caveats), but there
> are a few points I'd like to make:
>=20
>  * I don't think that making a new procfile is necessary. When you open
>    /proc/$pid you already have a handle for the underlying process, and
>    you can already poll to check whether the process has died (fstatat
>    fails for instance). What if we just used an inotify event to tell
>    userspace that the process has died -- to avoid userspace doing a
>    poll loop?
>=20
>  * There is a fairly old interface called the proc_connector which gives
>    you global fork+exec+exit events (similar to kevents from FreeBSD
>    though much less full-featured). I was working on some patches to
>    extend proc_connector so that it could be used inside containers as
>    well as unprivileged users. This would be another way we could
>    implement this.
>=20
> I'm really not a huge fan of the "blocking read" semantic (though if we
> have to have it, can we at least provide as much information as you get
> from proc_connector -- such as the exit status?). Also maybe we should
> integrate this into the exit machinery instead of this loop...

In addition, given that you've posted two patches in the similar vein
but as separate patchsets -- would you mind re-sending them as a single
patchset (with all the relevant folks added to Cc)?

If the idea is to extend /proc/$pid to allow for various
fd-as-process-handle operations (which I agree with in principle), then
they should be a single patchset. I'm also a bit cautious about how
many procfiles the eventual goal is to add.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--q523ya7z4aumdipt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvapgwACgkQSnvnv3De
m5/VXA//dOMH+ASbpNogjnZluZaN6P2PnEWymuHIBenVgDdMQ3f3HpNNQfGqEPDW
d0Pezoyk8h3AyNzKxAtQzTUIFZKg7bzuchfP2TKdV9Apt5Y+BKX8q9BXQbOmPzkY
SN0yFSpT0zwPOFRRgymgJi4J55rBbXDapdoRfDay7zvSz4HrFQJbh9E8JCjILcmk
353BGSWyGbGCxm1dgsUuPpzY+of7bk1WLqL8oSIO4jcUQxM+c1BeeOOWxN0f4tDW
MlwMu6Z5qwtOw2SmovJdZgNhHsmhMyqs+JmHOxEw9ZOIA0Vx4nTUNYb5UtRiQ3hf
yUTZcqABVcXgMnV48Dx6EwQKrBr3Rf71qiHUnOtbar0jKNMOFdtaiM1KXtA3aawO
aeAD+VqtCxq0awxpT18Rr2xVlQCA+syQyoln4Rrs2Fc6zyN/tkI3imhGOOnUJLZj
cPsKPfZa1jsX0vDfhpqP0NmePnBJUubwVCZS5sF1a4IPMQw8O/No9FTCUF5H60uI
TIuZo7QwpHxl7bZOqa0PMQ+UwM1M3k1QpaCEJb4Pteo57SihkDVw9lyGlAIS2eDF
B/evkh9EreGEbv2wyN7V5xc8MSkA30SVJ6sM33U8L/a1D7GB/ZpwU4NFlpRFUFrZ
ltL0wLEEvsw85Ghh3OPyAACU880E8Xwbys1PPeO2XqeZjbTfGqQ=
=3qhz
-----END PGP SIGNATURE-----

--q523ya7z4aumdipt--
