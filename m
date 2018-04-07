Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDGCve (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 22:51:34 -0400
Received: from home.keithp.com ([63.227.221.253]:59126 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeDGCvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 22:51:33 -0400
From: "Keith Packard" <keithp@keithp.com>
To: Jason Ekstrand <jason@jlekstrand.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: Add crtc_queue_syncobj and crtc_get_syncobj ioctls
In-Reply-To: <CAOFGe943O_premhAP0JLV4QMTqxxr3vgm2o_-7m1_S=dpj7dEw@mail.gmail.com>
References: <20180406235649.9494-1-keithp@keithp.com> <20180406235649.9494-2-keithp@keithp.com> <CAOFGe943O_premhAP0JLV4QMTqxxr3vgm2o_-7m1_S=dpj7dEw@mail.gmail.com>
Date: Fri, 06 Apr 2018 19:51:29 -0700
Message-ID: <87muyfpw3y.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Jason Ekstrand <jason@jlekstrand.net> writes:

> Is the given sequence number guaranteed to be hit in finite time?

Certainly, it's a finite value...

However, realistically, it's just like all of the other vblank
interfaces where you can specify a crazy sequence and block for a very
long time. So, no different from the current situation.

Of course, the only vulkan API available today only lets you wait for
the next vblank, so we'll be asking for a sequence which is one more
than the current sequence.

> Just to make sure I've got this straight, the client queues a syncobj with
> queue_syncobj to fire at a given sequence number.  Once the syncobj has
> fired (which it can find out by waiting on it), it then calls get_syncobj
> to figure out when it was fired?

If it cares, it can ask. It might not care at all, in which case it
wouldn't have to ask. The syncobj API doesn't provide any direct
information about the state of the object in the wait call.

> If so, what happens if a syncobj is re-used?  Do you just loose the
> information?

You can't reuse one of these -- the 'queue_syncobj' API creates a new
one each time.

> If we have a finite time guarantee, I'm kind-of thinking a sync_file might
> be better as it's a one-shot and doesn't have the information loss
> problem.  I'm not actually sure though.

It's a one-shot, once signaled, you're done with it.

> This whole "wait for a syncobj and then ask when it fired" thing is a bit
> odd.  I'll have to think on it.

Yeah, the event mechanism has the nice feature that you get data with
each event. I guess the alternative would be to have a way to get an
event when a sync object was ready; perhaps a call which provided a set
of syncobjs and delivered a DRM event when any of them was ready?

That has a lot of appeal; it turns the poll-like nature of the current
API into an epoll-like system. Hrm.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlrIMjIACgkQ2yIaaQAA
ABEeFQ//VOAUNr6itXcCXQg+ACwiPgSkqZ8virtYiHt1+7kglQdnU51sqslhE4wu
slw4ilv/c42fPxy9/8DVOcMU0HmuRN+5Inm4GxouMI1oAlH+KDTTaQEKTZMThaeU
9JSgjLpST1VOdAd0COMuyAIxCwQQI+03TZbmenqrR6zlkpgGq+6GhPSJT7ywCpiM
Fnc1K9UzN3QTgXBQd28bwZAP6G9CO4nCfRaIZEMprb4xQMO9xnlB/V0mZIMRPueY
bfanmntXZFV5Mi7TONmxFSYOp8wgajggUEJywlfiES2OrgBFpTcaV0EcEq982He5
BIM8TKT/xmAU2Lw3v36mJNOw9WxZaZoJEeJyn8AWA0NqG7pbczi10FFBoxtIX89I
0en5NuFbGTJvpOSQUOSSfdOEoi6SxkiSqdqAm0YVqkY8hUjjSLl9wM87jLzxBBkq
aE58VEM2NsgZNVc7X279cywvK8IghLlYkkSFa4wCNP8RWus1j26m0/7l+itiNaeB
sN8L9Pb1uurmbm8MN/xw1RmpS949y6w7Gxb8/71n3T09QpSxl4T9Q4+sVgtDGSzd
V6cJCIQPaxeQRjo6tnkgP3WZwZtIs6UYakB7cTLuR/F+ghGWT0Nl1bONp7PwEiox
au1ZqnwPnZRw/5Spb7JofE1ZdgclYveIIovR2HHEhoDXYxDINF0=
=4bBm
-----END PGP SIGNATURE-----
--=-=-=--
