Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408D4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E967D20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E967D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbeGWWzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:55:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388088AbeGWWzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:55:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9003CB034;
        Mon, 23 Jul 2018 21:52:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     paulmck@linux.vnet.ibm.com
Date:   Tue, 24 Jul 2018 07:52:03 +1000
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180723205625.GZ12945@linux.vnet.ibm.com>
References: <153086169828.24852.10332573315056854948.stgit@noble> <153086175009.24852.7782466383056542839.stgit@noble> <20180720075409.kfckhodsnvktift7@gondor.apana.org.au> <20180720144152.GW12945@linux.vnet.ibm.com> <87muulqq8q.fsf@notabene.neil.brown.name> <20180722215446.GH12945@linux.vnet.ibm.com> <87h8kqrhi0.fsf@notabene.neil.brown.name> <20180723205625.GZ12945@linux.vnet.ibm.com>
Message-ID: <87r2jtpqm4.fsf@notabene.neil.brown.name>
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

On Mon, Jul 23 2018, Paul E. McKenney wrote:

> On Mon, Jul 23, 2018 at 09:13:43AM +1000, NeilBrown wrote:
>> On Sun, Jul 22 2018, Paul E. McKenney wrote:
>> >
>> > One issue is that the ->func pointer can legitimately be NULL while on
>> > RCU's callback lists.  This happens when someone invokes kfree_rcu()
>> > with the rcu_head structure at the beginning of the enclosing structur=
e.
>> > I could add an offset to avoid this, or perhaps the kmalloc() folks
>> > could be persuaded Rao Shoaib's patch moving kfree_rcu() handling to
>> > the slab allocators, so that RCU only ever sees function pointers in
>> > the ->func field.
>> >
>> > Either way, this should be hidden behind an API to allow adjustments
>> > to be made if needed.  Maybe something like is_after_call_rcu()?
>> > This would (for example) allow debug-object checks to be used to catch
>> > check-after-free bugs.
>> >
>> > Would something of that sort work for you?
>>=20
>> Yes, if you could provide an is_after_call_rcu() API, that would
>> perfectly suit my use-case.
>
> After beating my head against the object-debug code a bit, I have to ask
> if it would be OK for you if the is_after_call_rcu() API also takes the
> function that was passed to RCU.

Sure.  It feels a bit clumsy, but I can see it could be easier to make
robust.
So yes: I'm fine with pass the same function and rcu_head to both
call_rcu() and is_after_call_rcu().  Actually, when I say it like that,
it seems less clumsy :-)

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltWTgMACgkQOeye3VZi
gbnG8Q//YF0igHPOWpE6aZhAOH4FlDOE+tN1Ca9tmmUYm4Dnze3suqB7QWSi9R8j
Y3MHUXHQu1eWtMDpU5oIUX3LYRu3TNkFoUf3BwssXxCUcosMYut6/E/RnJepdCl0
raLvjBc1XoHC7XUmLXnBSDXJSJOPIGVSZvkQx8PDCMwjRhYQC52rrl2ZzAcUjyDA
inmYj3RcleZ35sRXTdc6HffYuAeSlH/d7qtimtCtkwZRC+EMcrUCAv4lsUEH9PVG
zy4lhb1lkEUbktQXMVkOE5BSeemC9nVltkNbPw4kVdRv3FbRjqhZZR6UMTOJPaRL
okkHBrNe6g+/GXsLK4HljAHRyBMnHZ6li+Yql/waJfLP3JlA6Nm2TvTyLdPVu2rS
2xIqmGP6b+HO2qMJlvCSljPdN8SgcYXhJDWu945Layd5QHR783JXNqk37iwLXxy9
0pgzGYpjGdbPaEtNu8YGC05FHoHEDgV9jho7gS1CARM9LxVGSPNrMUm5VsId2eAO
NImoMnftvLKtX05DE59G2CJiYnkhEAO4y+CQXzgR59qJ44YHymdCbVEUv/7GF/Xa
PRkZGydsjMlilmvnaKiPXRV12yZ9Nr2U0B1kCFJKZkUWIcVh9fvEXABOgzGMfTyD
yIde3uHgOe/iEWTaBhdXYoxa+6oZ+rmNxVCdPlo1OwdaoeWz974=
=qUTC
-----END PGP SIGNATURE-----
--=-=-=--
