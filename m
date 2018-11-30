Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C300C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009752082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009752082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeK3MQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:16:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:50316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3MQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:16:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E84EB0DD;
        Fri, 30 Nov 2018 01:09:28 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 30 Nov 2018 12:09:20 +1100
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck@linux.vnet.ibm.com, Florian Weimer <fweimer@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH - resend*2] VFS: use synchronize_rcu_expedited() in namespace_unlock()
In-Reply-To: <20181129235222.GJ2217@ZenIV.linux.org.uk>
References: <87y3nyd4pu.fsf@notabene.neil.brown.name> <20171026122743.GX3659@linux.vnet.ibm.com> <b8a1a898-850c-cc7a-2574-1bfd15cc9888@redhat.com> <20171127144125.GF3624@linux.vnet.ibm.com> <87induxd3u.fsf@notabene.neil.brown.name> <87tvm1rxme.fsf@notabene.neil.brown.name> <20181005014002.GS32577@ZenIV.linux.org.uk> <87mupro3wh.fsf@notabene.neil.brown.name> <20181129235222.GJ2217@ZenIV.linux.org.uk>
Message-ID: <87k1kvnzgf.fsf@notabene.neil.brown.name>
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

On Thu, Nov 29 2018, Al Viro wrote:

> On Fri, Nov 30, 2018 at 10:33:18AM +1100, NeilBrown wrote:
>>=20
>> The synchronize_rcu() in namespace_unlock() is called every time
>> a filesystem is unmounted.  If a great many filesystems are mounted,
>> this can cause a noticable slow-down in, for example, system shutdown.
>>=20
>> The sequence:
>>   mkdir -p /tmp/Mtest/{0..5000}
>>   time for i in /tmp/Mtest/*; do mount -t tmpfs tmpfs $i ; done
>>   time umount /tmp/Mtest/*
>>=20
>> on a 4-cpu VM can report 8 seconds to mount the tmpfs filesystems, and
>> 100 seconds to unmount them.
>>=20
>> Boot the same VM with 1 CPU and it takes 18 seconds to mount the
>> tmpfs filesystems, but only 36 to unmount.
>>=20
>> If we change the synchronize_rcu() to synchronize_rcu_expedited()
>> the umount time on a 4-cpu VM drop to 0.6 seconds
>>=20
>> I think this 200-fold speed up is worth the slightly high system
>> impact of using synchronize_rcu_expedited().
>>=20
>> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> (from general rc=
u perspective)
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>=20
>> Al Viro says "I can live with this one" but this still hasn't landed.
>> Maybe someone else could apply it?
>
> Applied (in work.misc, once I push it out)

Excellent - thanks a lot :-)

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwAjcEACgkQOeye3VZi
gbko4g//XLXF+VP16o6Qh5aV6rw8fHBklFGwVnI0Xp6w64oyxDqsdt+he9D40zYO
pek2Q/Brwaqjbrs1NE0YfJ2ZmH4PLQTGI3xWBLW7Bx7EnUvEpbFap2gM9E7efLz3
U0ZSgI/m795vesaRW5GV0xJOEHL/I7fpZsY78lg+p7vwQmvG9AKHzxFXDdXHu5bn
DcjLm47i2fykdyt/5SbmoeWKgMIiQimfgRUFgO/fvbRsiFmjUx+zCHxzkGeixFfn
8UyvE7zxDAQAEGKVJ1JwrfikUlLm9TssEhzRgYdtqaWaA80IjpDXSG/O856K1F2Q
O5auYawp3D/+J+ZXC/pEsYuqwUp//sWeDQ3IoNbqqWg/+lufto/5dROLg9jdp6o9
vInPbZzVgtFJzYXxJY0ybf0CiQAz2yuID098Gydx5RTHV+GMx6XPBbYmkdOn0MsS
CMKan+a7D8wQfnmvCK8XiiZWQjx45yw2oPpr9mdpDME2fXAPpngFCL4GEAgYVNrL
RiT9MzjbanVM0VznjSbpIeyvv2loLCwhdUmK6mD+ECmEWZ4FgVpman8G/1CTczHV
x3Kw9tANoZjd0jXJhqdlJuE9BKwZ4kHUgTQSgGCYrIy7UIo1RWNHZq6gMiVtTFm8
zCU1VputwDWbJtFtP7xc8f2jIyanselRT9cK+KcZfqw/U4z00vM=
=McWo
-----END PGP SIGNATURE-----
--=-=-=--
