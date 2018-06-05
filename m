Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeFESt6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:49:58 -0400
Received: from anholt.net ([50.246.234.109]:40434 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbeFESt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:49:57 -0400
From: Eric Anholt <eric@anholt.net>
To: Andrzej Hajda <a.hajda@samsung.com>, dri-devel@lists.freedesktop.org
Cc: Kevin Quigley <kevin@kquigley.co.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org,
        James Hughes <james.hughes@raspberrypi.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH] drm/vc4: Enable the DSI module and link before other enables.
In-Reply-To: <20180605082532eucas1p21328ec5bea7d588c81480829f862bdfd~1NhnMydDJ0562405624eucas1p2l@eucas1p2.samsung.com>
References: <CGME20180604194448epcas1p29627759e2d8c0b1388c6700a7da77a45@epcas1p2.samsung.com> <20180604194437.13790-1-eric@anholt.net> <20180605082532eucas1p21328ec5bea7d588c81480829f862bdfd~1NhnMydDJ0562405624eucas1p2l@eucas1p2.samsung.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Tue, 05 Jun 2018 11:49:53 -0700
Message-ID: <87lgbtt6em.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Andrzej Hajda <a.hajda@samsung.com> writes:

> On 04.06.2018 21:44, Eric Anholt wrote:
>> We want the DSI PHY to be enabled and the DSI module clocked before a
>> panel or bridge's prepare() function, since most DSI panel drivers
>> with a prepare() hook are doing DCS transactions inside of them.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Cc: Kevin Quigley <kevin@kquigley.co.uk>
>> Cc: James Hughes <james.hughes@raspberrypi.org>
>> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
>> ---
>>
>> I'm not sure it makes sense to enable CRTCs before encoders on vc4 at
>> all.  Why start scanning pixels before the encoder is ready to hear
>> about VSTART?  However, this patch will hopefully unblock people
>> trying to attach other panels to rpi
>
> But this patch is about enabling encoder before panel/bridge prepare. Or
> am I missing something.
> Anyway I would be more precise here, MIPI-DSI bus is used for two things:
> - control bus - accessing DSI device (configuration/detection,...),
> - video data bus - sending video stream.
>
> I suspect in prepare/pre_enable phase of DSI panel/bridge only control
> bus should be functional, video stream transfer does not make sense.
> So the best solution (I guess) would be to split DSI-encoder enable
> sequence into control bus enable and video transfer enable parts and
> call the former before 1st transfer request from device and the latter
> in encoder enable callback. Of course there will be a problem then with
> disabling sequence, ie stopping video stream should be performed in
> encoder's disable, but when we should disable control bus? If we do it
> in encoder's disable callback we could not perform transfers in
> post_disable cb of the bridge - in most cases (maybe all currently
> present in kernel) it will work, but it does not look ideal.
> All this recalls me discussion that hardwiring bridge callbacks into drm
> core is problematic and maybe it would be better to call downstream
> callbacks explicitly from upstream element - the callback order should
> depend on the local bus protocol, and should not be fixed in drm core.

It does seem like for DSI encoders they generally would need to be able
to control when the call down to the bridge happens.  However, from my
experience with panels, drivers are bad about calling both prepare and
enable, if their particular panel only cares about one of them.  So, how
about:

- encoders can call drm_bridge_disable_midlayer_calls() (any naming
  suggestions?) to flag this bridge as not wanting the calls from the
  atomic helpers.

- atomic helpers WARN if bridge midlayer_calls flag was set and
  drm_bridge_pre_enable/enable/disable/post_disable failed to be called
  by the encoder

- drm_bridge_detach() clears disable_midlayer_calls flag for the next
  encoder

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsW21EACgkQtdYpNtH8
nugQUg//QG8RdjfWVnErEusS3Hgz6j3s13xE2CYARmN71xz8wIrezEjJCcS7BFnE
6RIhGKBpityf29/bmEsIMGey+jkW0FgshAY3Z0v+q0dvj0hmge9qsMBSxRm4RCHL
mIXPa8KLndCUpiFKNLrwG7yNAo6aR3fn5E2Pdt+9wh1Ry8Mod+uSJH3s0SxL4+/s
66VmO2BlCnJKt1wWPNQ5qM+PqEapjpLmJvA3czN6NnvOlUasasr6eb8wIeTKHuTo
rg3iT7DqLvITRXidRv4ZMLPRZLhqnpObp3ApyEElToMFaYDgvu5VkMLJbzqA4+U3
cXGnjx9TV+D3iQG092GUV6GqFGI99OxGeGbx9A2NlUPuKlObo0HbFmX8qWWKBgCK
QsM+AYanClEFrofAyhLWY9RyvsRGS407cVpoy/tmpaZrais9oS862p1r4Ga1L9oB
8bHQPHazAOuRj9TkYr3yiIPTr4Kn/gKyZFymOo6pGgL6kezXcy8fLm/EW73bWJdB
nYchbQd7ri/TPJWCcN8wBlxH7DSqECPeRyr9QSjfhO8yOWW1oiWi7bsuA6BdLVh3
qmImGeM0PK6wNbIAWsrGIAoJyIhqVLgI0leOomKJ13KWQDZly4EO4mNpsx9C8g7U
yPME2kVFijK0+Xda/OR8xwp9ULyzzShfuKYkxK5wdBBMqbj1pXE=
=zJgH
-----END PGP SIGNATURE-----
--=-=-=--
