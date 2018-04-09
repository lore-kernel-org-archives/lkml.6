Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeDIURv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:17:51 -0400
Received: from anholt.net ([50.246.234.109]:53698 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeDIURu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:17:50 -0400
From: Eric Anholt <eric@anholt.net>
To: Daniel J Blueman <daniel@quora.org>, dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        boris.brezillon@bootlin.com
Subject: Re: drm/vc4: false-positive negative cursor position warning
In-Reply-To: <CAMVG2svG=HaK15JwZwg7PRJUR26FHrzSz3-OL01jz1wikHe+oQ@mail.gmail.com>
References: <CAMVG2svG=HaK15JwZwg7PRJUR26FHrzSz3-OL01jz1wikHe+oQ@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 09 Apr 2018 13:17:47 -0700
Message-ID: <87efjow2vo.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Daniel J Blueman <daniel@quora.org> writes:

> Hi Eric et al,
>
> In a number of windowing environments (eg GNOME 3) on Raspberry Pi 3B
> on 4.16.0 arm64, the mouse cursor top-left gets down to x,y -4,-4,
> tripping WARN_ON_ONCE(plane->state->crtc_x < 0 || plane->state->crtc_y
> < 0) [1], which therefore seems false-positive.
>
> Git history doesn't turn up any reason, eg it could cause undefined
> hardware behaviour, which it doesn't appear to, so would it be better
> to drop the warning, or adjust it to trip on x or y < -4 or so? If so,
> I'll prepare a patch to adjust it.

Ccing Boris, who's been doing work on the async update path.

Take a look at vc4_plane_setup_clipping_and_scaling(state) -- that has
the corrections necessary for negative x/y.  We're calling that too late
(through the avc4_plane_atomic_check() path) for this function's usage
of the offsets[].

Since it affects the computed src_w/h, we'd have to update those as well
in our async update.  Our async update is racy in a way that makes me
uncomfortable -- the HVS could process our display list at any point in
our writel() sequence, which is not very atomic.  Maybe we should be
using a double-buffered HVS display list per element, and then have the
main display list jump into each element's current display list and back
out, so that we can do async flips to new plane state by just commiting
a single writel() to the new HVS display element list.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrLymsACgkQtdYpNtH8
nuj5fg//XBsczp78xkJVye15Ntq5VUgYlDQnk3p1gVgxWK6V3RnTO36VPZONwp4d
khLQNqavaZq2dakrEdDeFevp+FxwqpNEcahv9iuQrUaouE1BMO9fyvs6yztnw3i6
efuSDRSGMWYhOPiH68vl2rrGWwjRuxGR0IXBtnhBEgqQr6lXYpxODaETrefhKZyS
AUDfIIMrmzv/Q8H6FEuACFcmeVXmwPCnS0CfnJEaXTy4c6izh4PxqbN9aeZFm+ih
63bUQ8DXTPkSAVkEB2n4o2olW++SlEzDcj/xk1UJIPCJfEK8VKravUE5dVrP9GA7
UG5klqKCLcWc0oNh4O5V0UHPQLC+wQpgTufbhsfKbikhr19FP2xCpWCN8DINYYdN
TFoTbFraNN2nxYe6fVpYDTlCqPPwsefAbCD9oC5QT2XDzyjYYBTxQrHOnh7FojBd
XoPkX7g0SY0nn/+poQJA+hfWWgQqzytcSli6hqTo466C6JtQryJlkQVgN5rmnZFG
c7llKvfmyK81m4iTbbDD2VLurIlPSTwKNZRAvG1FUa5T6B5cVj+3gY4C7O/BiSMU
OCnRfuLMcHb/5AYr5F+QqiPXFaPwobnKJ1hfpmNFX8PNcMJNa+UOF67W4pHaK6yl
vm1VHAKA0uXZFntGftYCcOoTIxXafhgGHBTem3VeGCjJXNZtHrw=
=YPEv
-----END PGP SIGNATURE-----
--=-=-=--
