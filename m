Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeCVQch (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:32:37 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41522 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeCVQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:32:31 -0400
Message-ID: <1521736343.6308.25.camel@surriel.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
From: Rik van Riel <riel@surriel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Date: Thu, 22 Mar 2018 12:32:23 -0400
In-Reply-To: <3111105.SmgpqUHPkp@aspire.rjw.lan>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/wo3ltzQDl4MtaXa8Xl6"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/wo3ltzQDl4MtaXa8Xl6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-03-14 at 15:08 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> If poll_idle() is allowed to spin until need_resched() returns
> 'true',
> it may actually spin for a much longer time than expected by the idle
> governor, since set_tsk_need_resched() is not always called by the
> timer interrupt handler.  If that happens, the CPU may spend much
> more time than anticipated in the "polling" state.
>=20
> To prevent that from happening, limit the time of the spinning loop
> in poll_idle().
>=20
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

So ... about bisecting that other patch series...

It turned out I had this patch, which looks so
obviously correct, as patch #1 in my series.

It also turned out that this patch is responsible
for the entire 5-10% increase in CPU use for the
memcache style workload.

I wonder if keeping an idle HT thread much busier
than before slows down its sibling, or something
like that.

Let me go test the nohz idle series by itself,
without this patch.

--=20
All Rights Reversed.
--=-/wo3ltzQDl4MtaXa8Xl6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlqz2pcACgkQznnekoTE
3oMwawf+Kocem8kRVixqGOqKiJcIzk0d4kbZee1OPDXcUvq9RYOuSniFToDVPjiC
wweCzV+xxOeznm3VIblxvm69yN1jYav+M2CwuAb5piKd0FAiGOS//iDNfYZM+gyl
bLFj4L9IgjNvyPL+HylS7nn7I4CNbBHbFNpMAp9eJGlH199Rg7+yM4uZKvybxf/i
K/CQLr15BwgChmC1a+5FW427vTTNweqv/PinxxgRj14fZPEHrSxsEL83mjZBOycP
LiY+Kq38bCKUwELX28XjWD1gTW+hvWOexIEwuewZFTTi+7MrYpN78IC8cDODNdmB
QIGip6zWn1rTXBmCGsdBoimW1etaqg==
=tSxZ
-----END PGP SIGNATURE-----

--=-/wo3ltzQDl4MtaXa8Xl6--
