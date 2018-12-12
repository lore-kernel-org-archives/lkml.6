Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703EFC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B5520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeLLItT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:49:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:51686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbeLLItS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:49:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA959AEE5;
        Wed, 12 Dec 2018 08:49:16 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed, 12 Dec 2018 19:49:08 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <20181212080037.j2zs22t57uxdu2jr@gondor.apana.org.au>
References: <153086101070.2825.6850140624411927465.stgit@noble> <153086109256.2825.15329014177598382684.stgit@noble> <87zhtkeimx.fsf@notabene.neil.brown.name> <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au> <87k1kico1o.fsf@notabene.neil.brown.name> <20181211051755.modgomqzszkbiihe@gondor.apana.org.au> <87mupbvch0.fsf@notabene.neil.brown.name> <20181212054601.wbzpxjunnsfi62mz@gondor.apana.org.au> <87efanuu06.fsf@notabene.neil.brown.name> <20181212080037.j2zs22t57uxdu2jr@gondor.apana.org.au>
Message-ID: <87bm5ruo3f.fsf@notabene.neil.brown.name>
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

On Wed, Dec 12 2018, Herbert Xu wrote:

> On Wed, Dec 12, 2018 at 05:41:29PM +1100, NeilBrown wrote:
>>
>> So you would substantially slow down the rhashtable_walk_start() step.
>
> This whole thing is meant for uses such as /proc and netlink
> enumeration.  Speed is definitely not a prerogative of these
> iterators.

An RCU grace period is typically 10s of milliseconds.  It doesn't take
very many of those to start being noticed.

>
> For that matter, if speed was an issue then surely you would
> not drop out of the RCU read lock at all while iterating.

tipc_nl_sk_walk() drops out of RCU for every object.
I don't know what it is used for, but I doubt that making it thousands
of times slower would be a good thing.

>
> It sounds to me like you're trying to use this interface for
> something that it's simply not designed to do.

I'm just trying to make sure we have a reliable data structure which I
can use without having to be worried that I might accidentally hit some
unsupported behaviour.

I don't really see why you think my patch is all that complex.
The only conceptual change is that hash chains are now ordered, and
ordered chains are easy to understand.
The biggest part of the code change is just moving some code from
rhashtable_walk_start() to rhashtable_walk_next().

Why don't you like it?

Thanks,
NeilBrown


>
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwQy4QACgkQOeye3VZi
gblkTQ//aGC2XgRa2qz3JmjjtDp+Ch09Z4Rk3veIGlfFtSm7z1bAZiLiufyw9fJo
Fq5Ayb8FoVcaHHqLV9ye76F29aikCCVHeU3JyXb905NZ4St5XZjSy3cK1qOQjrJl
JSi6Hx0DQv3Mcu8lmtoZz9sihneMzAIfGk83Fb1gw8ErKttn++EeU1KWfQsdfBBB
o8PqEYZS+ZrjRrX2ZT+jBp0kk+JB2EAkxEKIcPwLI/7SNnGqmW+odmkaTR5kSxfp
jq/vTc1PuLTrUNk9K6/T4k3eBKzEe1wnPyYBrkkMXJ7e7k8JTkNdlgmeC5XsW3sr
nXZEfd0h8K5Vsp9eSjEZkvBD+h1y95C5kJRN83kaafpf+IO1EOywrXCmqT1zjlOn
+GjatL4ObCT+3w02oXF6QWzCPnzjxUb952AlEsjBPPHp32JQPJEk/mldF+dCmAc1
arksxrv01we2DbUQMZijpo4sNpW4/qdpI4y/3XY1GA9phwkRGoGmVv9nfsFt9l+Y
tyE5vQSOXSh/t5warfdIenReJRhbO/FhQgvcM3SBd5FA60GpDs34cabneAwufAzh
ABnnbvczhjrpwaOdeEkN3U7TXUsOOQCM8NsmBrfxKNkkbxTU60tmk7x9+YnPt8NI
1VDJ4ynA9T/Cpj/aIV/+IXzRjjO2rmLo+B8dQy2mXB2K7Kb4TZ8=
=cBv0
-----END PGP SIGNATURE-----
--=-=-=--
