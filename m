Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007DFC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A709D23DB7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A709D23DB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeGEXDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:03:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753172AbeGEXDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:03:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E197AE67;
        Thu,  5 Jul 2018 23:03:12 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 06 Jul 2018 09:03:04 +1000
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 4/5] kbuild: disable KBUILD_MODNAME when building for mod.a
In-Reply-To: <CAK7LNAT9deaBb0aiFW+00G-S4FTVdN5GX-n3HbEUR07nzHQUmQ@mail.gmail.com>
References: <152929708853.17463.17302660556961083137.stgit@noble> <152929772052.17463.10728056000221362647.stgit@noble> <CAK7LNAR2n_Kf7HEwWgLwH8sjyVAiJUWkvV7ZAbkNn0KgVTUx1Q@mail.gmail.com> <87efgk0xx7.fsf@notabene.neil.brown.name> <CAK7LNAS22VUQytcX=BQt48qeAn9Rq00Sb555Gu98J+=8R_3OVA@mail.gmail.com> <87po02zmxt.fsf@notabene.neil.brown.name> <CAK7LNAT9deaBb0aiFW+00G-S4FTVdN5GX-n3HbEUR07nzHQUmQ@mail.gmail.com>
Message-ID: <878t6pz3o7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Jul 05 2018, Masahiro Yamada wrote:

> 2018-07-05 6:54 GMT+09:00 NeilBrown <neilb@suse.com>:
>> On Wed, Jul 04 2018, Masahiro Yamada wrote:
>>
>>> 2018-07-04 7:14 GMT+09:00 NeilBrown <neilb@suse.com>:
>>>>
>>>> Where I've been using these patches I've sometimes been adding
>>>>
>>>>   ccflags-y += -DKBUILD_MODNAME='"FOO"'
>>>>
>>>> to Makefiles so that modules_params get handled correctly on non-module
>>>> builds.  I've thought about instead allowing "modobj-name" to be defined
>>>> and requiring that it be set if either modobj-[yn] is set.  Then it gets
>>>> used for the KBUILD_MODNAME when building modobj modules.
>>>>
>>>> Would you prefer to always require KBUILD_MODNAME, or to use a default
>>>> name for dynamic-debug?
>>>>
>>>> Thanks,
>>>> NeilBrown
>>>
>>>
>>> I prefer flat directory structure for modules.
>>> Most of modules fit in a single directory.
>>
>> I'd prefer that too in general.
>> But some modules are bigger than others and some times it helps to
>> sub-divide a module.
>> xfs, btrfs, ceph, net/dccp, and lustre all already use multiple
>> directories despite the poor support, so clearly some developers
>> like a more structured approach to organizing their code.
>> Wouldn't it be good to allow them to make full use of the kbuild system?
>
>
> xfs is quite big, but the others are not too bad.
> You can collect files into a single directory if you want.
> If you mind the namespace, one tip might be to group files with prefix.
> For example,
>
>   drivers/btrfs/tests/foo.o  ->  drivers/btrfs/test-foo.o

Certainly that is possible.  We could even place all of linux in a
single directory, but that would be a bad idea.  Subdividing large
bodies of code into files and then directories is a widely used
practice.  Why do you want make it hard for people to structure their
code in the way that seems most suitable to them?
My particular interest is lustre which has quite a few more
subdirectories than btrfs or xfs.  It currently builds as nearly a dozen
modules, one per directory (and that is just the client side).  This
requires a lot more exports than should be necessary, and exposes
internal detail unnecessarily. I would much rather it were fewer
modules.

>
> I do not want to introduce a mess to core build scripts.

What mess are you referring to?  The code I provided follows the style
of the current code and has the same general level of complexity as the
current code.  How is it a mess?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls+o6kACgkQOeye3VZi
gbl84w/+MJe/Lry88t1fvjWN71gFfqHorZ9EEGcyioFHy+SfOegOtt9Zz9STko8E
+fP+YJBQfyHCzYj6Qs9N2VAHsKfZbdumcm3guZlR6iqW0ZBm3pU33uhHEcbvAiA4
EjiWDLZnRjvaJ31FSvgCGkmOuxtzNle/JH6IHO/xWHWmyi0+qXdSTI1JMHruvqFp
yUujjpzAwrvJJAiD4egwHLFM3Dv8mo7U+khwwD8I1+aENRI44hep9ryx9CDH/rVS
0o+yxxi7NUvNknF7pPJkTF99DH3Z7Unb9yNAupTsRuBA6hzawTgEhKTfFQYmXvnd
eOM0rAZ+R5dZ/Yl9QemhECDo/fwqXqtf1XpFT+zHrfwFwnyDd2d7YM5+QfSZ9FJn
k8GOEzl4tJw2Ce/a/+7FnbHMGYPqs4G/l0QEJTO8x+x3zWU+VwrauIKUgcDkrhvM
yPw83/pWrhzKZTayJNUL4uCwCyfX0kVnZptHopZvLDyoN/ncNjKOJPjZDjHiv3mZ
E6ypytTJ4yFiiFQkCV+zqqRUvK3n6clqDOfYiypxPn1yi61/vsXum/8fABVmQo5B
4qWilZVNdfKcaMYyVfFqimSVmhBDdLWLYUROq6FJUFx9TxvV2Lq5aaVJvVjZUrcF
joLZpUz7hYeZwmKTiTLIxJctgTSozrjEGZnfltRucopr2HEvQQg=
=CJ69
-----END PGP SIGNATURE-----
--=-=-=--
