Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E811C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0027E20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0027E20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeKAQC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:02:28 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:59226 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeKAQC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:02:27 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 04FA6A10D7;
        Thu,  1 Nov 2018 08:00:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 1ZI5LgM89CdB; Thu,  1 Nov 2018 08:00:42 +0100 (CET)
Date:   Thu, 1 Nov 2018 18:00:36 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com
Subject: Re: [RFC PATCH v2] Minimal non-child process exit notification
 support
Message-ID: <20181101070036.l24c2p432ohuwmqf@yavin>
References: <20181029175322.189042-1-dancol@google.com>
 <20181029192250.130551-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uai654nwee5vog4c"
Content-Disposition: inline
In-Reply-To: <20181029192250.130551-1-dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uai654nwee5vog4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-29, Daniel Colascione <dancol@google.com> wrote:
> This patch adds a new file under /proc/pid, /proc/pid/exithand.
> Attempting to read from an exithand file will block until the
> corresponding process exits, at which point the read will successfully
> complete with EOF.  The file descriptor supports both blocking
> operations and poll(2). It's intended to be a minimal interface for
> allowing a program to wait for the exit of a process that is not one
> of its children.
>=20
> Why might we want this interface? Android's lmkd kills processes in
> order to free memory in response to various memory pressure
> signals. It's desirable to wait until a killed process actually exits
> before moving on (if needed) to killing the next process. Since the
> processes that lmkd kills are not lmkd's children, lmkd currently
> lacks a way to wait for a process to actually die after being sent
> SIGKILL; today, lmkd resorts to polling the proc filesystem pid
> entry. This interface allow lmkd to give up polling and instead block
> and wait for process death.

I agree with the need for this interface (with a few caveats), but there
are a few points I'd like to make:

 * I don't think that making a new procfile is necessary. When you open
   /proc/$pid you already have a handle for the underlying process, and
   you can already poll to check whether the process has died (fstatat
   fails for instance). What if we just used an inotify event to tell
   userspace that the process has died -- to avoid userspace doing a
   poll loop?

 * There is a fairly old interface called the proc_connector which gives
   you global fork+exec+exit events (similar to kevents from FreeBSD
   though much less full-featured). I was working on some patches to
   extend proc_connector so that it could be used inside containers as
   well as unprivileged users. This would be another way we could
   implement this.

I'm really not a huge fan of the "blocking read" semantic (though if we
have to have it, can we at least provide as much information as you get
=66rom proc_connector -- such as the exit status?). Also maybe we should
integrate this into the exit machinery instead of this loop...

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--uai654nwee5vog4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvapJEACgkQSnvnv3De
m5/TmQ/9GtWsv8b6N4kHuqHB7WfMnXm9Kqq3nR4W1WcDGWK86NpjcvzyVKPJSMlV
B6gdnTWMfc9bqChvTqT5Q0/qgcbNqzzyDzWKG4JkMt0nDJBJ07tdvp32HXegWJlo
JMMulHkErG5fsKX7nf1OH6lGIz80WLKZnqm7/6Qic7l/nPpcW7oN6W9MZcHxMXl9
j5jFv/EPeTnQ9YFn+BkQStKCMdXl/7eIw46VRD62RfDykwH5qg4/zgpIOMEGsQts
OLNdNocCj6AB8vd2C0TJEJlfwczvjlFnEnDYwkMzPudmyp6Rl2If6YcWtjNet6ul
DXgM8zsHZ0Dd+EeUGJWe8Y2Lt2oWOi7LQtzcw99Oy//EmjX13IOcKWxgPJBihRK+
V/an7p0QiM060PW0u8RRFFYt0gWnkpb83nv+6x91aOcbdj+kdDMwRCMPsGZfq5yn
9WbqFxraygoZfsctSq2U6kQF6OpVoUzx01tqk9DT8mdGY/RxSb88DkTSvHdG3E7j
OPqJGZ+wKlof2/It6ca3ojGcuLC0T7uUa5VZrFp5lmK6w7+eoZwn2cWnxu7CvGM9
VdSizrpc50+2SwfSsKXs5cuIhWZrgB9yGruywDIz+1HAxnATKYtpYiTqEWc1rs29
/XOgzmCWLmhPqa53PoPv2ySMl1TcPn/iAygdT2+LjJ8xuFW+OR4=
=urye
-----END PGP SIGNATURE-----

--uai654nwee5vog4c--
