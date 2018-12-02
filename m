Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD194C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C75208A3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MrWDZKil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C75208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbeLBWL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 17:11:26 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:29530 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeLBWL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 17:11:26 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 7F6414293B;
        Sun,  2 Dec 2018 23:11:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:in-reply-to:mime-version:date:date
        :message-id:from:from:references:subject:subject:received; s=
        mail20150812; t=1543788681; bh=eoc+Y1GoglcZUH5ta+/LKqE+QeDFO2bUx
        gHYk2M2ol8=; b=MrWDZKil8si9EGpUWUWunkkzR2GE+JX0Rr1v3InrZ32JOKK3X
        BOjWivmzQbREYms5pYAgOoWGgNOBUaTw9B5nOWEyzM8UtFMyPQlaVnkNT5gsneUR
        5kLQBB9tPKPjY2yzI8GIBm+zAZDAFKcrBEWyOpS+lDGjdueH5QS1rqMInWDGt41d
        ZX0w60wtCCMqqm0vzvw5I6j0ZsLKyme3HorcATjHuaNW0BoA06OdxYzVOEbYkpan
        mzlmjrmoooOdrvXmgn2NnS6nhJ+nsCfred1qpIdse3A6KT0XD8QA7K2seVWEatlJ
        W5FOtWTZIvcrYHNY2tcsXkFPSUBcpZbTlGe8w==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id cnb6hgWyaoKA; Sun,  2 Dec 2018 23:11:21 +0100 (CET)
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     Andrey Melnikov <temnota.am@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <20181128041555.GE31885@thunk.org> <en52df-5dh.ln1@banana.localnet>
 <2547416.7Vy7A2kRpU@siriux>
 <CA+PODjo-da79FKQCmpcH9Z9CBq35HbWu2m+nB3si7WgD9w-kGA@mail.gmail.com>
 <cbdb2e6b-31a2-1e19-f51f-067dcbdcf183@mailbox.org>
 <CA+PODjpLRuc1u4SNSRqfWtx+Z+C8NGi6fs7yFuyKK0DwHggEdg@mail.gmail.com>
From:   Rainer Fiebig <jrf@mailbox.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jrf@mailbox.org; prefer-encrypt=mutual; keydata=
 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
 6/dT7HxuwnVIkER8kg==
Message-ID: <de67b507-ca54-e827-867e-76d57e531cb9@mailbox.org>
Date:   Sun, 2 Dec 2018 23:13:07 +0100
MIME-Version: 1.0
In-Reply-To: <CA+PODjpLRuc1u4SNSRqfWtx+Z+C8NGi6fs7yFuyKK0DwHggEdg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qgzTML2YGGPcmKqoL9spvq0ggi9nMdKZJ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qgzTML2YGGPcmKqoL9spvq0ggi9nMdKZJ
Content-Type: multipart/mixed; boundary="Rb1c4r416ZZi5uWMwxPuRNFku2girw7nt";
 protected-headers="v1"
From: Rainer Fiebig <jrf@mailbox.org>
To: Andrey Melnikov <temnota.am@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <de67b507-ca54-e827-867e-76d57e531cb9@mailbox.org>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <20181128041555.GE31885@thunk.org> <en52df-5dh.ln1@banana.localnet>
 <2547416.7Vy7A2kRpU@siriux>
 <CA+PODjo-da79FKQCmpcH9Z9CBq35HbWu2m+nB3si7WgD9w-kGA@mail.gmail.com>
 <cbdb2e6b-31a2-1e19-f51f-067dcbdcf183@mailbox.org>
 <CA+PODjpLRuc1u4SNSRqfWtx+Z+C8NGi6fs7yFuyKK0DwHggEdg@mail.gmail.com>
In-Reply-To: <CA+PODjpLRuc1u4SNSRqfWtx+Z+C8NGi6fs7yFuyKK0DwHggEdg@mail.gmail.com>

--Rb1c4r416ZZi5uWMwxPuRNFku2girw7nt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 02.12.18 um 21:19 schrieb Andrey Melnikov:
> =D1=87=D1=82, 29 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 01:08, R=
ainer Fiebig <jrf@mailbox.org>:
>>
>> Am 28.11.18 um 22:13 schrieb Andrey Melnikov:
>>> =D1=81=D1=80, 28 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 18:55,=
 Rainer Fiebig <jrf@mailbox.org>:
>>>>
>>>> Am Mittwoch, 28. November 2018, 13:02:56 schrieb Andrey Jr. Melnikov=
:
>>>>> In gmane.comp.file-systems.ext4 Theodore Y. Ts'o <tytso@mit.edu> wr=
ote:
>>>>>> On Wed, Nov 28, 2018 at 03:16:33AM +0300, Andrey Jr. Melnikov wrot=
e:
>>>>>>> Corrupted inodes - always directory, not touched at least year or=

>>>>>>> more for writing. Something wrong when updating atime?
>>>>>>
>>>>>> We're not sure.  The frustrating thing is that it's not reproducin=
g
>>>>>> for me.  I run extensive regression tests, and I'm using 4.19 on m=
y
>>>>>> development laptop without notcing any problems.  If I could repro=
duce
>>>>>> it, I could debug it, but since I can't, I need to rely on those w=
ho
>>>>>> are seeing the problem to help pinpoint the problem.
>>>>>
>>>>> My workstation hit this bug every time after boot. If you have an i=
dea - I
>>>>> may test it.
>>>>>
>>>>>> I'm trying to figure out common factors from those people who are
>>>>>> reporting problems.
>>>>>>
>>>>>> (a) What distribution are you running (it appears that many people=

>>>>>> reporting problems are running Ubuntu, but this may be a sampling
>>>>>> issue; lots of people run Ubuntu)?  (For the record, I'm using Deb=
ian
>>>>>> Testing.)
>>>>>
>>>>> Debian sid but self-build kernel from ubuntu mainline-ppa.
>>>>
>>>> You could try a vanilla 4.19.5 from https://www.kernel.org/
>>>> and compile it with your current .config.
>>>
>>> mainline-ppa use vanilla kernel. Patches only adds debian specific
>>> build infrastructure.
>>>
>>>> If you still see the errors, at least the Ubuntu-kernel could be rul=
ed out.
>>>>
>>>> In addition, if you still see the errors:
>>>>
>>>> - backup your .config in a *different* folder (so that you can later=
 re-use
>>>> it)
>>>> - do a "make mrproper" (deletes the .config, see above)
>>>> - do a "make defconfig"
>>>> - and compile the kernel with that new .config
>>>
>>> defconfig is great - for abstract hardware in vacuum.
>>>
>>>> If you still have the problem after that, you may want to learn how =
to bisect.
>>>> ;)
>>> I'm already know how-to bisect. From kernel 2.0 era. Without git ;)
>>>
>>> This problem simply non-bisectable, when same kernel corrupt FS on my=

>>> workstation but normally working on other servers.
>>> And now - FS corrupted again with disabled CONFIG_EXT4_ENCRYPTION. Gr=
eat.
>>
>> OK, - and now we are looking forward to *your* ideas how to solve this=
=2E
>=20
> After four days playing games around git bisect - real winner is
> debian gcc-8.2.0-9. Upgrade it to 8.2.0-10 or use 7.3.0-30 version for
> same kernel + config - does not exhibit ext4 corruption.
>=20
> I think I hit this https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D87859=

> with 8.2.0-9 version.
>=20
Good that it works for you. But others used gcc 5.4.0 or 6.3.0 and were
hit anyway: https://bugzilla.kernel.org/show_bug.cgi?id=3D201685#c165


--Rb1c4r416ZZi5uWMwxPuRNFku2girw7nt--

--qgzTML2YGGPcmKqoL9spvq0ggi9nMdKZJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6yx5PjBNuGB2qJXG8OH3JiWK+PUFAlwEWQMACgkQ8OH3JiWK
+PWGPg//dE+rE1YHVI8GwR+ILzz8Rsu+jneIh5Jn1dNqo9nrdleA6zE/HmQiVhey
Sj/ufcsdi0atD3TYrACyv4XTH0wSdX6iPmWWzxzPrzbgju/ynuo18R1tqxqlyo0d
CoACp+WoJDyZpzY8I70td4A+/NWfEzbFyaNfDCzyT78KfoOvsi/bVrEAOI4y29kz
RPQikUmuj6eI+6ixm3r8ATcJo3wJdUQF7iSfqwAC3SB7OsM9WXtFrJ7Ez03Qozs3
5f7FnifKN0sdMyCtWsCwa67R5qYVwnUOvtqRQQfHbCvNz7ftB6wP5z2j7An/UQz9
k7KbC9v0pcumMDR7VkVZBC9V07+Fr3QOWsjBWUFjK31oN0EGyDSWh9lBhR445Sro
lEMc0iX/llqQ/zzep0pXXP8VO1tYnWvRWjvJFuOLYK083NsgEu/3NQD7Xdk+WrNR
hTR10vh0vfLBwQlp4t1DGsEkz0V9Ma0yXc1+apbnSO9LpINCiJwfwo/isyqccP0M
f5TOr3HDFGSxCdT+kof72ZjCXWgAzSX4/l1XYDQwVTBqebbOw22Xple2Breh6Hsg
at2sbJUJtraLmnqm7CrHZGZBeye3lYV291DkrE5Tpo5cUSNapurkA9C9YCXeNqzm
esnjW1bKlWVLGp8gD6LiCBs9/gKaM9e08IpPMSG/PuJeqta4US0=
=SI+N
-----END PGP SIGNATURE-----

--qgzTML2YGGPcmKqoL9spvq0ggi9nMdKZJ--
