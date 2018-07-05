Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED76C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8409F23F6D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8409F23F6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbeGEQ7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:59:14 -0400
Received: from anholt.net ([50.246.234.109]:60500 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753919AbeGEQ7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:59:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7791310A1616;
        Thu,  5 Jul 2018 09:59:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id EYG5fWJJpgD0; Thu,  5 Jul 2018 09:59:11 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 26F8E10A0F6A;
        Thu,  5 Jul 2018 09:59:11 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 929502FE2D94; Thu,  5 Jul 2018 09:59:10 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/v3d: Delay the scheduler timeout if we're still making progress.
In-Reply-To: <1530788347.15725.2.camel@pengutronix.de>
References: <20180703170515.6298-1-eric@anholt.net> <1530788347.15725.2.camel@pengutronix.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 05 Jul 2018 09:59:08 -0700
Message-ID: <87k1q97h5v.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lucas Stach <l.stach@pengutronix.de> writes:

> Am Dienstag, den 03.07.2018, 10:05 -0700 schrieb Eric Anholt:
>> GTF-GLES2.gtf.GL.acos.acos_float_vert_xvary submits jobs that take 4
>> seconds at maximum resolution, but we still want to reset quickly if a
>> job is really hung.=C2=A0=C2=A0Sample the CL's current address and the r=
eturn
>> address (since we call into tile lists repeatedly) and if either has
>> changed then assume we've made progress.
>
> So this means you are doubling your timeout? AFAICS for the first time
> you hit the timeout handler the cached ctca and ctra values will
> probably always differ from the current values. Maybe this warrants a
> mention in the commit message, as it's changing the behavior of the
> scheduler timeout.

I supposes that doubles the minimum timeout, but I don't think there's
any principled choice behind that value.

> Also how easy is it for userspace to construct such an infinite loop in
> the CL? Thinking about a rogue client DoSing the GPU while exploiting
> this check in the timeout handler to stay under the radar...

You'd need to have a big enough CL that you don't sample the same
location twice in a row, but otherwise it's trivial and equivalent to a
V3D33 igt case I wrote.  I don't think we as the kernel particularly
cares to protect from that case, though -- it's mainly "does a broken
WebGL shader take down your desktop?" which we will still be protecting
from.  If you wanted to protect from a general userspace attacker, you
could have a maximum 1 minute timeout or something, but I'm not sure
your life is actually much better when you let an arbitrary number of
clients submit many jobs to round-robin through each of which has a long
timeout like that.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAls+TlwACgkQtdYpNtH8
nuiQrQ/9GFoyG1AnSz7A2r3KD+58rHpwDCr4AYeVv2aUFQpYbtyKvHIACh35YRXW
1HAqm6kgwuDYWb0AbAX25VIZQ7rZ7toSZZOClIgTicboCrfF//Py//l3dU7jhhRH
XzRTYamK1PJud04RSIxvCrqhDuvbF8PVXQ+ckKjQtXmotFs162Owzj28MyhYGKrf
Kx5l/yNXgHR2GUB7VSS9Tmla68s/iu+WVnT5/gNA2GVZKnLyoiPg8D7ZXXoKVlZJ
7blVCAe40HtAF8KFxkBiT1TlF5VDM3fiAkRTDWMAL54vdCFkgF1Z70xDVH/FUsEj
JUw+cSVJQ94Kea+5i2fivmvufNgmfHs9NqWJ4dVjl7e3XKVLJg+u/IXtk3VgZqJG
glhS9TiBUAoOGrwcT+WW/Wk1F0F40U7VvzFKbL14VwcljHT5TzrjpfGIX1p5JQJC
ah5SzoWnINwCsjH8z5sYR9GtyRABFbpRybM5UWtFwjUiv5zlQ2Tp65ZOQG1lDyVN
d8dp13ytDqaQFPyRBBBtkebWvWbr8NnNAdMlMy6WhJBR7BD7Upb6kt7Jq613er8J
hE9fuUnZZjr/38205IADn4QNExOI8cby0I7MoBHHgXlMjG8bCfpLWR9GsEAgRLGN
JSBDnpU4D5Bhi6PwYTcBWxZ/F23sRIiCg1jJsrsUQ3mSVNdPp08=
=eDmE
-----END PGP SIGNATURE-----
--=-=-=--
