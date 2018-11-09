Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF50C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22A620825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22A620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeKJGxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:53:12 -0500
Received: from anholt.net ([50.246.234.109]:45832 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeKJGxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:53:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E51B110A1314;
        Fri,  9 Nov 2018 13:10:51 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id U4U9VTzFJ08J; Fri,  9 Nov 2018 13:10:50 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8597B10A01F2;
        Fri,  9 Nov 2018 13:10:50 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 163CB2FE1B8F; Fri,  9 Nov 2018 13:10:50 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     zhoucm1 <zhoucm1@amd.com>, christian.koenig@amd.com,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm: Revert syncobj timeline changes.
In-Reply-To: <d9d76fbc-44ad-891d-e535-34d0e8f615de@amd.com>
References: <20181108160422.17743-1-eric@anholt.net> <20181108160422.17743-3-eric@anholt.net> <635caa27-eb0b-a4d6-5a1d-3fbe5382bd6b@amd.com> <c5af6df2-d5d5-5276-3628-4bac0fd53c98@gmail.com> <d9d76fbc-44ad-891d-e535-34d0e8f615de@amd.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 09 Nov 2018 13:10:49 -0800
Message-ID: <87d0rex8h2.fsf@anholt.net>
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

zhoucm1 <zhoucm1@amd.com> writes:

> On 2018=E5=B9=B411=E6=9C=8809=E6=97=A5 00:52, Christian K=C3=B6nig wrote:
>> Am 08.11.18 um 17:07 schrieb Koenig, Christian:
>>> Am 08.11.18 um 17:04 schrieb Eric Anholt:
>>>> Daniel suggested I submit this, since we're still seeing regressions
>>>> from it.=C2=A0 This is a revert to before 48197bc564c7 ("drm: add sync=
obj
>>>> timeline support v9") and its followon fixes.
>>> This is a harmless false positive from lockdep, Chouming and I are
>>> already working on a fix.
>>
>> On the other hand we had enough trouble with that patch, so if it=20
>> really bothers you feel free to add my Acked-by: Christian K=C3=B6nig=20
>> <christian.koenig@amd.com> and push it.
> NAK, please no, I don't think this needed, the Warning totally isn't=20
> related to syncobj timeline, but fence-array implementation flaw, just=20
> exposed by syncobj.
> In addition, Christian already has a fix for this Warning, I've tested.=20
> Please Christian send to public review.

I backed out my revert of #2 (#1 still necessary) after adding the
lockdep regression fix, and now my CTS run got oomkilled after just a
few hours, with these notable lines in the unreclaimable slab info list:

[ 6314.373099] drm_sched_fence        69095KB      69095KB
[ 6314.373653] kmemleak_object       428249KB     428384KB
[ 6314.373736] kmalloc-262144           256KB        256KB
[ 6314.373743] kmalloc-131072           128KB        128KB
[ 6314.373750] kmalloc-65536             64KB         64KB
[ 6314.373756] kmalloc-32768           1472KB       1728KB
[ 6314.373763] kmalloc-16384             64KB         64KB
[ 6314.373770] kmalloc-8192             208KB        208KB
[ 6314.373778] kmalloc-4096            2408KB       2408KB
[ 6314.373784] kmalloc-2048             288KB        336KB
[ 6314.373792] kmalloc-1024            1457KB       1512KB
[ 6314.373800] kmalloc-512              854KB       1048KB
[ 6314.373808] kmalloc-256              188KB        268KB
[ 6314.373817] kmalloc-192            69141KB      69142KB
[ 6314.373824] kmalloc-64             47703KB      47704KB
[ 6314.373886] kmalloc-128            46396KB      46396KB
[ 6314.373894] kmem_cache                31KB         35KB

No results from kmemleak, though.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvl99kACgkQtdYpNtH8
nuj9hw/+NbLJVtUTuhRABbEBNgTYLQ9qKQmErvhz+KGiANmLIkYSWxVTtLelfHN2
3tRO9YcuJkW6X9UEK2ntL1ptgyOpBJY8Ns9daPV7gqvuUu8B+Oy+Se2t1GR9m8A4
R2Lq60PZpOuqaQ13fPqsq4XnSqlW7DHDYoW0nCyzMklHMZJg9WHMZQdeZ3iaimrP
BGMV9AtZ7Bkjr4bPyq6i8ThGRVX7QoHfkyWQ/X64hfXgggQuz8c5ublHveLYosuF
S/yIgmwGepQD2UO5JeHrDAOnUf6LqixSsy7xudsSmC+M0DneuhWEvHJokaUt+F9g
0CnFZB+W6QCiv5MeI6+EUFSSJF/AjQbfOtzum1XHwpyIGIfaMS0AZZ6hpyMZL9W1
0viQZ/5fKbFqifUkz9GjK/Zko32yc0qicBms+LC1VMs05Z0i3n0FC1hJ/zgNsSJd
0T96Z2kNWMBGTOvqw/uxvWzHEBaXlz7v6BH4YrFUYNYWpiVSVstHMlTjdnNzLWDJ
7m2YsAjghnknGVazMg82WJLBPlZ3rzb3YirAnnh/X2sOcFUf1RG9KdC5Kv526IzO
Rx5OCNvln90P1Tn73xFTQzF/BDhFoy+n56AIj5SI67nEFYMDwQf74gwNzDF09f2O
NbFc1JVLxDUZKv2CWc5Yjsp24+Vsbgmaa6fh/ZfVjBlltGobb1Y=
=l4ru
-----END PGP SIGNATURE-----
--=-=-=--
