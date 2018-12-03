Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466AEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C507320848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C507320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLCUj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:39:27 -0500
Received: from anholt.net ([50.246.234.109]:53408 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCUj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:39:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E722210A156D;
        Mon,  3 Dec 2018 12:39:25 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id VJ-87A6l6Hr9; Mon,  3 Dec 2018 12:39:24 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id BC63510A0388;
        Mon,  3 Dec 2018 12:39:24 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 4861D2FE2D16; Mon,  3 Dec 2018 12:39:24 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Dave Emett <david.emett@broadcom.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Subject: Re: [PATCH 1/6] drm/v3d: Document cache flushing ABI.
In-Reply-To: <CAApk1dU5+Lf3oJhGUQQuWMA3iNpM3JBhbB8Vu5+tH7nHnWHicg@mail.gmail.com>
References: <20181201005759.28093-1-eric@anholt.net> <CAApk1dXwAtoFRRq971fwsE+yrbJT1kcYnjzSwShHBrXkU+nv_g@mail.gmail.com> <CAApk1dU5+Lf3oJhGUQQuWMA3iNpM3JBhbB8Vu5+tH7nHnWHicg@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 03 Dec 2018 12:39:23 -0800
Message-ID: <87tvju1h1g.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Dave Emett <david.emett@broadcom.com> writes:

> On Mon, 3 Dec 2018 at 17:22, Dave Emett <david.emett@broadcom.com> wrote:
>>
>> > + * The caches (L1T, slice, and L2T) will be flushed before the job
>> > + * executes.  The TLB writes are guaranteed to have been flushed by
>>
>> I would say before *each* job executes, as the caches are flushed
>> before both bin and render.
>> I wouldn't say "the caches" as not all of the V3D caches are flushed
>> before executing a control list. In particular, the VCD cache is not
>> cleared by the kernel driver (not even sure if there is a register
>> interface to do this); it is expected that the control list will do
>> this itself (using the CLEAR_VCD_CACHE instruction).
>> On 3.3 and earlier there is a separate L2C for instructions/uniforms
>> and a GCA. These do need to be flushed, and it looks like they are, so
>> they should be mentioned here.
>
> Correction: on *3.2* and earlier there is a separate L2C for
> instructions/uniforms. On 3.3 and earlier there is a GCA.
>
> It looks like we're currently unconditionally writing the L2C clear
> registers. We should really only be doing this on 3.2 and earlier.

OK, I've pushed the timeline name and tracing to drm-misc-next, and I'll
resend the rest with more comments and the L2C change and outside-in
invalidation once I'm far enough into this CTS run that I'm confident.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwFlHwACgkQtdYpNtH8
nujd8w//VIM8lAGKBZpA/G+kCgc9iZXX0PjX5i45LST36VvTyCAKgZXG9CF/OWSY
Sav8nz5nES0/tytM/jce8ScKw8xT30Uagp+fwa+fQlSkfFTCY1k+zTJXcTEJo7pe
CUrXt8M8GJ891uMs05rKs+zb9+n1kV9mbpTZWrqeqfYNmBYG3dvjvx5rNGiAqssZ
ayz77xI9NpViJ5p8/uLPuS4tXbnBWQyA7Z7giwlESIVIb5taPchhh26N4LklOc1q
OxQ01NZSXHbOVZa6I7cebAh+KOrjfDSe+X0jm07uZZEVpZfHHaWY1ll/DaaKPQN+
TiTVt4VKfNrBAB6B9/y/rs9gBa/BWWiLNxDBL8xx4X+WVlwbOce1LYBt6SpFTAvr
sWzlfKdDIeL4HdDxsARkAUrZndJytAWaDPw4rgd/ZqS/VpP35nZ6QC5E5+SgSHTo
qmA4ieWqOjdB5f59WHuyJR6Ib7xnYkc4FSnc+w2z63sID7ZzXgI3SJ1YFffeWNNS
rImJIpZDD1wXCnhvaZgkNLot8nry8S/lgOUq1G3wQLE492cnDeqL8XObsEo8p86j
6q7CsY+Y2NY1AUu3CKydLkZuKk8zq4AtQK1Ia0Oh20/pTRjjzMZN1eWDQ3/eXLu8
MAj+lmQw7v8zx5HqQb2f1sAJO/2wqTE5Z4gyHuOOjrksIbiTXcc=
=tuaX
-----END PGP SIGNATURE-----
--=-=-=--
