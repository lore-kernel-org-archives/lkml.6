Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A459B20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfANI1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:27:23 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:53241 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfANI1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:27:20 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6A07C240010;
        Mon, 14 Jan 2019 08:27:16 +0000 (UTC)
Date:   Mon, 14 Jan 2019 09:27:15 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: staging/android: questions regarding TODO entries
Message-ID: <20190114082715.GB3017@hle-laptop.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This todo entry from staging/android/TODO intriguates me:

    vsoc.c, uapi/vsoc_shm.h
     - The current driver uses the same wait queue for all of the futexes i=
n a
       region. This will cause false wakeups in regions with a large number=
 of
       waiting threads. We should eventually use multiple queues and select=
 the
       queue based on the region.

I am not sure to understand it very well.

What does "select the queue based on the region" mean here ? We already
have one queue per region, right ?

What I understand: there is one wait queue per region, meaning that if
threads T1 to Tn are waiting at offsets O1 to On (same region), then a
wakeup at offset Om will wake them all. In this case there is a perf issue
because only Tm (waiting for changes at offset Om) really wants to be
waken up here, the rest is a bunch of spurious wakeups.

Does the todo suggest to have one queue per offset ?

Also, this comment (drivers/staging/android/vsoc.c) mentions a worst case
of ten threads:

    /*
     * TODO(b/73664181): Use multiple futex wait queues.
     * We need to wake every sleeper when the condition changes. Typically
     * only a single thread will be waiting on the condition, but there
     * are exceptions. The worst case is about 10 threads.
     */

It is not clear to me how this value has been obtained, nor under which
conditions it might be true. There is no maximum to the number of threads
fitting in the wait queue, so how can we be sure that at most ten threads
will wait at the same offset ?

second, unrelated question:

In the VSOC_SELF_INTERRUPT ioctl (which might be removed in the future if
VSOC_WAIT_FOR_INCOMING_INTERRUPT disappears, right ?), incoming_signalled
is set to 1 but at no other place in the driver we reset it to zero. So,
once VSOC_SELF_INTERRUPT has been executed once,
VSOC_WAIT_FOR_INCOMING_INTERRUPT doesn't work anymore ?

Thanks for your work !

cheers,
Hugo

PS: cc-ing the result of get_maintainer.pl + contacts from todo. Please
tell me if this is not the right way to go.

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlw8R+MACgkQZYVUZx9w
0DT2Lgf+IVb50XARwq3FBO8TxRzNnjJ+X+99fje3+ycwYgDGQCbD1Kx/kCVDlk6C
JJp+9hlsyubFkXhgWhTMS1iOy7tPHSIq2n5UMYLxlwFQktQF3TyN1AKGXFioyBs5
XwTykvLbAP8fIqdVPGC9nTCevSsZFCrGe2FzGHvNsi8pqpSVeXALeFwTtCNb3Y2g
VzHoiRj0Fe3LjGntTU1n7pvvSriF7X91Bg1IFQ6ZZnSSVDVT9J+uKMy6p7XiKFOs
5ZYPRDyMD4CnCNDIvkpsY1j71eEB1+7C8emHGl8k6faxQhnvenHTlERhCPpp8RDK
jJnjm2XvGPqKwzSD6W9XTZS7VdFErQ==
=/cu2
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
