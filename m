Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeDHCbL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 22:31:11 -0400
Received: from home.keithp.com ([63.227.221.253]:47796 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbeDHCbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 22:31:10 -0400
From: "Keith Packard" <keithp@keithp.com>
To: Jason Ekstrand <jason@jlekstrand.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: Add crtc_queue_syncobj and crtc_get_syncobj ioctls
In-Reply-To: <CAOFGe94tJG-GELF-RnokWOQHjrbAMOZp2EGM2=Vgh=hP0Ne1jg@mail.gmail.com>
References: <20180406235649.9494-1-keithp@keithp.com> <20180406235649.9494-2-keithp@keithp.com> <CAOFGe943O_premhAP0JLV4QMTqxxr3vgm2o_-7m1_S=dpj7dEw@mail.gmail.com> <87muyfpw3y.fsf@keithp.com> <CAOFGe94tJG-GELF-RnokWOQHjrbAMOZp2EGM2=Vgh=hP0Ne1jg@mail.gmail.com>
Date: Sat, 07 Apr 2018 19:31:05 -0700
Message-ID: <87k1tipgye.fsf@keithp.com>
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

> Yeah, I suppose an application could ask for 10k frames in the future or
> something ridiculous like that.  For sync_file, people strongly want a
> finite time guarantee for security/deadlock reasons.  I don't know how
> happy they would be with a finite time of 10 minutes...

Sure, we've put arbitrary finite limits on vblank counters in other
places, so adding some kind of arbitrary limit like a couple of seconds
would be entirely reasonable here. The Vulkan API doesn't need any of
this complexity at all; the one I'm doing only lets you create a fence
for the next vblank.

> Ok, that's not expected... Part of the point of sync objects is that
> they're re-usable.  The client is free to not re-use them or to be very
> careful about the recycling process.

Heh. I thought the opposite -- lightweight objects that you'd use once
and delete. I can certainly change the API to pass in an existing
syncobj rather than creating a new one. That would be easier in some
ways as it reduces the failure paths a bit.

> Is the event the important part or the moderately accurate timestamp?

I need the timestamp and sequence number, getting them in an event would
mean not having to make another syscall.

> We could probably modify drm_syncobj to have a "last signaled"
> timestamp that's queryable through an IOCTL.

That's exactly what I did, but it only works for these new syncobjs. The
fields are global and could be filled in by other bits of the code.

> Is the sequence number returned necessary?  Will it ever be different from
> the one requested?

Yes, when the application queues it just slightly too late.

The application doesn't actually need either of these values directly,
but the system needs them to respond to requests to queue presentation
at a specific time, so the vulkan driver wants 'recent' vblank
time/sequence data to estimate when a vblank will occur.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlrJfukACgkQ2yIaaQAA
ABHnRQ/9G44GtfqSHadKeZSHfUcx5/k/jS3LGmKn6hqBVfdGnO3qmQq8G4yRX3AK
S7khQ5z5lkHVloBEKJRA35W9KJVV/Fpae75QZ8o5koGowMW4C/Ue3MSK8Bl1v2L2
3Fqwua1purDj5GC8fasz5hTUVLB/gV7HVG1DXXb9vugbVjPJkrWhytmSJ0kJ40zv
ahqzwxCsOTLk186lX4Vqnv2kajkpOoEza0XUGG8DEwXYJF6xAojhmfwUPasFOqzc
Q32JO0DWQBi51TN/qovwTwVT6uEwwFCUy7bv1oQva9KUZLb5Uwm5TtCMw+9zf54S
MRuVMVXUnUS1sQtjMnLevDt9Y4Myz/WY+ita9SPJW0A9bC8DXIWYLWjU8bN/+v6S
svHk4I8aQ0KwCnth21IFPaoc712q72l4OWXVNbI1XVK6yAUj/mRhJbuYkHoyXbqH
rM6mAXmgrRVtnHGlbk2ul4Q8SIXJPBd6MO3g61C5/LiDO3c9/WAJShxDfXkCkTFV
pPPBWB1CMZdvcqIanqWMr/drGKt1wM5F0hZvCzE8oN4lIInXS4FLVfIeLeyx1wxH
PC8v22/qgkhQLCZQ4RRBsHKVxQWrjFRWp+uH6e31Ejis4F6fBgQlMf5ProI3qBVA
4gJLqQ8+gFvfR75KtXbHKeFQEtDC8jKHeH5SS93QEKzWg7Mi1ls=
=nkn4
-----END PGP SIGNATURE-----
--=-=-=--
