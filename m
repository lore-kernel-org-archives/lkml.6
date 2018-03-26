Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeCZQc1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:32:27 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51894 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeCZQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:32:26 -0400
Message-ID: <1522081932.6308.54.camel@surriel.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
From: Rik van Riel <riel@surriel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 26 Mar 2018 12:32:12 -0400
In-Reply-To: <5810003.D8QGLjubHr@aspire.rjw.lan>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>
         <4731938.EeADOapqQb@aspire.rjw.lan> <1522008952.6308.46.camel@surriel.com>
         <5810003.D8QGLjubHr@aspire.rjw.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ucnamkVniI4tw5M2J9fN"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ucnamkVniI4tw5M2J9fN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-03-25 at 23:34 +0200, Rafael J. Wysocki wrote:
> On Sunday, March 25, 2018 10:15:52 PM CEST Rik van Riel wrote:
> >=20
> > I plan to try two more things:
> >=20
> > 1) Disable polling on SMT systems, with
> >    the idea that putting one thread to
> >    sleep with monitor/mwait in C1 will
> >    allow the other thread to run faster.
>=20
> Sounds plausible.

Plausible, but wrong. Tests showed that CPU use
during the peak load of this test increased from
about 71% to about 78% with this change, or just
under 10% increase relative to the baseline.

Coincidentally, that is the same CPU use increase
I have seen with the poll_idle() changes. Not sure
if that means anything...

> > 2) Insert more cpu_relax() calls into the
> >    main loop, so the CPU core spends more
> >    of its time in cpu_relax() and less
> >    time doing other things:
>=20
> Well, maybe it's a matter of doing cpu_relax() between any other bits
> of
> significant computation in there:

I tried that, as well, and some other variations.

Every single change to poll_idle() that I tried
seems to result in a 9-10% relative increase in
CPU use during the peak load of the test.

During the busiest parts of the load, every CPU
sees on the order of 20k context switches a second.

kind regards,

Rik
--=20
All Rights Reversed.
--=-ucnamkVniI4tw5M2J9fN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlq5IIwACgkQznnekoTE
3oNfqQf/aUT2A5acAB2jRngl22drrFj7G/XIdJzWfL22J/dEO6/cqRTpQTIiA1v8
2tQ5xgsrqGpxCiOnnrhS9vi1hpM8EJRK09rykYlnoGMqwjI9Rx1MpkyC/LcKuE7B
VkaD4jHM3Xzs2AmO73xPBJamGD+G0lnofEUuNVBfg/s7ihRfpnOgoGRn+oJ3yBhZ
ZFfuuef7SLUpVBmwg5oJxdpGY4z7r3DC84wlWx/waS72sQdV9YF476yye10pIfvH
/MxIylEsB+2YCvkYGXA7tAAR5nEClmAu2nsHIOPguGe11LPS/1At3S0DUSxlBksV
lVKEFtOv1fu8Wsi7cvWHqgfSoiCD+w==
=SamN
-----END PGP SIGNATURE-----

--=-ucnamkVniI4tw5M2J9fN--
