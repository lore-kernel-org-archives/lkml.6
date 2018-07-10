Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A1CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7452089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7452089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeGJKcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:32:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751515AbeGJKcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:32:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42938AD78;
        Tue, 10 Jul 2018 10:32:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 10 Jul 2018 20:32:23 +1000
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Wang <wvw@google.com>, Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
In-Reply-To: <20180710075328.GG3008@phenom.ffwll.local>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch> <20180709162509.29343-1-daniel.vetter@ffwll.ch> <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org> <20180710075328.GG3008@phenom.ffwll.local>
Message-ID: <871scbwfd4.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10 2018, Daniel Vetter wrote:

> On Mon, Jul 09, 2018 at 04:30:01PM -0700, Andrew Morton wrote:
>> On Mon,  9 Jul 2018 18:25:09 +0200 Daniel Vetter <daniel.vetter@ffwll.ch=
> wrote:
>>=20
>> > To avoid compilers complainig about ambigious else blocks when putting
>> > an if condition into a for_each macro one needs to invert the
>> > condition and add a dummy else. We have a nice little convenience
>> > macro for that in drm headers, let's move it out. Subsequent patches
>> > will roll it out to other places.
>> >=20
>> > The issue the compilers complain about are nested if with an else
>> > block and no {} to disambiguate which if the else belongs to. The C
>> > standard is clear, but in practice people forget:
>> >=20
>> > if (foo)
>> > 	if (bar)
>> > 		/* something */
>> > 	else
>> > 		/* something else
>>=20
>> um, yeah, don't do that.  Kernel coding style is very much to do
>>=20
>> 	if (foo) {
>> 		if (bar)
>> 			/* something */
>> 		else
>> 			/* something else
>> 	}
>>=20
>> And if not doing that generates a warning then, well, do that.
>>=20
>> > The same can happen in a for_each macro when it also contains an if
>> > condition at the end, except the compiler message is now really
>> > confusing since there's only 1 if:
>> >=20
>> > for_each_something()
>> > 	if (bar)
>> > 		/* something */
>> > 	else
>> > 		/* something else
>> >=20
>> > The for_each_if() macro, by inverting the condition and adding an
>> > else, avoids the compiler warning.
>>=20
>> Ditto.
>>=20
>> > Motivated by a discussion with Andy and Yisheng, who want to add
>> > another for_each_macro which would benefit from for_each_if() instead
>> > of hand-rolling it.
>>=20
>> Ditto.
>>=20
>> > v2: Explain a bit better what this is good for, after the discussion
>> > with Peter Z.
>>=20
>> Presumably the above was discussed in whatever-thread-that-was.
>
> So there's a bunch of open coded versions of this already in kernel
> headers (at least the ones I've found). Not counting the big pile of
> existing users in drm. They are all wrong and should be reverted to a
> plain if? That why there's a bunch more patches in this series.
>
> And yes I made it clear in the discussion that if you sprinkle enough {}
> there's no warning, should have probably captured this here.
>
> Aka a formal Nack-pls-keep-your-stuff-in-drm: would be appreciated so I
> can stop bothering with this.

I think is it problematic to have macros like

#define for_each_foo(...) for (......) if (....)

because
   for_each_foo(...)
      if (x) ....; else ......;

is handled badly.
So in that sense, your work seems like a good thing.

However it isn't clear to me that you need a new macro.
The above macro could simply be changed to

#define for_each_foo(...) for (......) if (!....);else

Clearly people don't always think to do this, but would adding a macro
help people to think?

If we were to have a macro, it isn't clear to me that for_each_if() is a
good name.
Every other macro I've seen that starts "for_each_" causes the body to
loop.  This one doesn't.  If someone doesn't know what for_each_if()
does and sees it in code, they are unlikely to jump to the right
conclusion.
I would suggest that "__if" would be a better choice.  I think most
people would guess that means "like 'if', but a bit different", which is
fairly accurate.

I think the only sure way to avoid bad macros being written is to teach
some static checker to warn about any macro with a dangling "if".
Possibly checkpatch.pl could do that (but I'm not volunteering).

I do agree that it would be good to do something, and if people find
for_each_fi() to actually reduce the number of poorly written macros,
then I don't object to it.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltEizcACgkQOeye3VZi
gbkIRA/9Gdq2PO/PLeUxQ1OV2giyRABxX/KIlSN+6Yi9WdFxz2l1v+8ea5CSjT4W
ZK7iRRGzsKTFfZKl5EoaxgHG4iHsI3dBgZVmc3YKD1BI9xOyBoClw2hTaDSw8awo
Sgbmq5I0mV+dsSF4FuzkbfaZ923LwIqVlcztAWl7U+M1ISds2Ou03NlT45iSwWhU
mRPuPfYTI9bciPcYaaTRkmSacjKdvCtzUZmbhT62nidy42a/fquKLNhv/s5D4hlt
TyeArWMFdeKDwr255ffglMKiaMNBFUrEElhvFRyBnAgWI/tEVhte5Hu+MZbtboG5
t2DKblGUpc8VpDlPsUlP75SntsTmtj5Rz6KA8EVWoVpjQxeaieBkBNowPiWDdvRx
COlSytBaFRBxIqWSMNK/wzMZ6fLHkJy0WS+9YgAdU/l1asbI6wvVPHGyjmSQVgSj
aRWNuXhhbaT5W9o0rUlUlwPO/kEBtokMpGynrlgLTqdaxFzNM4ia0wHBUbb7tDOO
whiTdZ43c0uMQg8Stp+30XmcuIhJwjv9ZIJVpdMOSfmM3URd67PpyUHQJMIHZnJs
LqbIG4QJUCAVlxVF8zy6ETtKXRsRpJeqvclrDSL0sRFaP18c2iZ3ykDhzq3AFYtt
ffZpAvlO5DRTc+SlKtIs/P9YwZGiPhaHaT5Kfis5XPRuOCc83rk=
=0/YR
-----END PGP SIGNATURE-----
--=-=-=--
