Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeDDPef (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:34:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbeDDPed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:34:33 -0400
Date: Thu, 5 Apr 2018 01:34:22 +1000
From: Aleksa Sarai <asarai@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alban Crequy <alban.crequy@gmail.com>, Alban Crequy <alban@kinvolk.io>,
        Dongsu Park <dongsu@kinvolk.io>, Iago Lopez Galeiras <iago@kinvolk.io>,
        Stephen J Day <stephen.day@docker.com>,
        Michael Crosby <crosbymichael@gmail.com>,
        Jess Frazelle <acidburn@microsoft.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, containers@lists.linux-foundation.org
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc
 mounts when not fully visible
Message-ID: <20180404153422.mea4nup3ldc2q2qt@gordon>
References: <20180404115311.725-1-alban@kinvolk.io>
 <87tvsrjai0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xg6ha4rtuhb7wper"
Content-Disposition: inline
In-Reply-To: <87tvsrjai0.fsf@xmission.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xg6ha4rtuhb7wper
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-04-04, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > The following commands show my problem:
> >
> > $ sudo docker run -ti --rm --cap-add=3DSYS_ADMIN busybox sh -c 'unshare=
 -U -r -p -m -f mount -t proc proc /home && echo ok'
> > mount: permission denied (are you root?)
> >
> > $ sudo docker run -ti --rm --cap-add=3DSYS_ADMIN busybox sh -c 'mkdir -=
p /unmasked-proc && mount -t proc proc /unmasked-proc && unshare -U -r -p -=
m -f mount -t proc proc /home && echo ok'
> > ok
>=20
> Actually this does not show your problem because it does not reveal why
> you need to mount proc.
>=20
> That is a ``Doctor it hurts when I do this'' example where the Doctor
> will reasonably tell you ``Don't do that then''.

The context is that people want to run unprivileged runc inside a Docker
container, and mounting proc is part of setting up a container. But
Docker (and runc) have masks for /proc to stop containers from being
able to touch things like /proc/scsi and so on. The other possibility is
to give people an escape-hatch when setting up a container which
basically says "make this container slightly less secure so that I can
run containers inside it".

However I share your concern about the layer mixing with inheriting the
masks for the new procfs mount (what if you have a mount over a
particular process, now the mask is masking something completely
different, and a bunch of other possible problems).

> > For my use case, I will need to support at least the following entries:
> >
> > $ sudo docker run -ti --rm busybox sh -c 'mount|grep /proc/'
> > proc on /proc/asound type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/bus type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/fs type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/irq type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/sys type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/sysrq-trigger type proc (ro,nosuid,nodev,noexec,relatime)
> > tmpfs on /proc/kcore type tmpfs (rw,context=3D"...",nosuid,mode=3D755)
> > tmpfs on /proc/latency_stats type tmpfs (rw,context=3D"...",nosuid,mode=
=3D755)
> > tmpfs on /proc/timer_list type tmpfs (rw,context=3D"...",nosuid,mode=3D=
755)
> > tmpfs on /proc/sched_debug type tmpfs (rw,context=3D"...",nosuid,mode=
=3D755)
> > tmpfs on /proc/scsi type tmpfs (ro,seclabel,relatime)
>=20
> It looks like a cruft free cousin of proc that is just processes would
> be applicable to your usecase.

I think a procfs that only has processes would be a massive improvement
for a bunch of other reasons too. :D

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xg6ha4rtuhb7wper
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlrE8HsACgkQnhiqJn3b
jbRnow/+KccyoEV0xLBfJSPqejhSu8o8/aasXyqdJaAIM/GTI0/Xf6aT6pW4JZU/
m8IcgIKBrSDd6GmdkTE5MJ8s/Bqc5+EeDAbwfeJQeDzGFqBOXtmNvhs6YJrLG6pp
nZG7nwIsrxeKuL/yqyHNAZYpC5ii7zEe+GeEaeUf6gaxq6T5qklmDPWDS5kVRyza
4O+NpfSmd8MmOmCBNrwV90LxqdB+kso4MFAFXZzmhs9IzibpPdaBT8RWhJ8z0gCj
hZDtGHnY2gpjppgec+L35h9xHN3A1W93OVZAuzmX/JRWnRdimuv9URJlAH8k+GhW
gNIbXcoPQgDcRaSpGrimIqOiUAbNQXB0HUbsDwnmGlWWTESZ5nIVv3xftmew+QSR
M2AxI/vvii/HkvUMIgwAN8IGTzI+6ozJmT5wweDrRhKkFak88VlL7Kr+2+2yBxti
LCJmGhuqss3VEKYeXd5+43W+TEtCHE3gkAOtkU572XC25BmPxr4k446UxbUkagBk
FXPD5NbzEeASwzcVSJdvUF/hRSGztyRuSbYcBqRsxa+LUwIZSuW295Rh7EC3dpxl
eKtSMiyHnlj9Qg6AABfWo5qDI7OldL7EQmVYtW4NuXzaggh2SMqrdx+uERFcYDGE
mSFLWHc54ZN5gvuRPOtSCb5MGuVUtE3+Dtqe2AAtUk4m83CHOvc=
=0/iw
-----END PGP SIGNATURE-----

--xg6ha4rtuhb7wper--
