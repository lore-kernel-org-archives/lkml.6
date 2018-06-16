Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE1320895
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 22:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE1320895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeFPWtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 18:49:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59667 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeFPWtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 18:49:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13666AC89;
        Sat, 16 Jun 2018 22:49:48 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     James Simmons <jsimmons@infradead.org>
Date:   Sun, 17 Jun 2018 08:49:40 +1000
Cc:     Oleg Drokin <green@linuxhacker.ru>,
        Andreas Dilger <andreas.dilger@whamcloud.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 01/11] staging: lustre: simplify use of interval-tree.
In-Reply-To: <alpine.LFD.2.21.1806160344210.6450@casper.infradead.org>
References: <152826510267.16761.14361003167157833896.stgit@noble> <152826511890.16761.16115276596203531205.stgit@noble> <alpine.LFD.2.21.1806160344210.6450@casper.infradead.org>
Message-ID: <87sh5mfit7.fsf@notabene.neil.brown.name>
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

On Sat, Jun 16 2018, James Simmons wrote:

>> Lustre has a private interval-tree implementation.  This
>> implementation (inexplicably) refuses to insert an interval if an
>> identical interval already exists.  It is OK with all sorts of
>> overlapping intervals, but identical intervals are rejected.
>
> I talked to Oleg about this since this changes the behavior. He is worried
> about having identical items that would end up being merged.  If we can=20
> guarantee by some other means there are no identical nodes, we are=20
> probably fine with the interval tree code allowing this. Oleg can explain=
=20
> better than me in this case.

I don't think this is a change in behaviour.
In the driver/staging client code, interval tree is being used in two
places and both of them have clumsy work-arounds for the fact that they
cannot insert duplicates in the interval tree.
The patch just cleans his up.

However if I have missed something, please provide details.
What "identical items" might get merged?

>=20=20
>> Both users of interval-tree in lustre would be simpler if this was not
>> the case.  They need to store all intervals, even if some are
>> identical.
>>=20
>> llite/range_lock.c add a rl_next_lock list_head to each lock.
>> If it cannot insert a new lock because the range is in use, it
>> attached the new lock to the existing lock using rl_next_lock.
>> This requires extra code to iterate over the rl_next_lock lists when
>> iterating over locks, and to update the list when deleting a lock from
>> the tree.
>>=20
>> ldlm_extend allocates a separate ldlm_interval which as a list of
>> ldlm_locks which share the same interval.  This is linked together
>> by over-loading the l_sl_policy which, for non-extent locks, is used
>> for linking together locks with the same policy.
>> This doesn't only require extra code, but also an extra memory
>> allocation.
>>=20
>> This patch removes all that complexity.
>> - interval_insert() now never fails.
>
> Its not really a failure. What it does is if it finds a already existing
> node with the range requested it returns the already existing node=20
> pointer. If not it just creates a new node and returns NULL. Sometimes
> identical request can happen. A good example of this is with HSM request
> on the MDS server. In that case sometimes we get identical progress
> reports which we want to filter out so not add the same data.

This example is server-side code which is not a focus at present.
Having a quick look, it looks like it would be easy enough to do a
lookup first and then only insert if the lookup failed.
I think this is a much nicer approach than never allowing duplicates in
the interval tree.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsllAUACgkQOeye3VZi
gbnf+BAAtbUPleL8Aq0gTjDET1nZx1mUvkd5MMHqam1z5U/vqMWk5sdlwAnxQMk6
pydJ2rNuyqQfesKJ9ZX2eIQI6DnWIF3+Qp5VNu23fdXkAkBV1U0NdtuZzzPgrJZy
WxXvLFSpP4Qx3vPI8xWjwAYxrQx5HJcvHMLTmiDIoAfaBu/Umxjjffj2LP44heyO
eqp/9cKyMVkmLYh03ysQVvkzr7yYKENRShaT4SnIg0DsehAAKgc2W8ZPzWSPzQVt
8VIc5wTENhGjHkEABjh9nSgH1LwwScw5kWPUUBTdP5oL+0zwgPGmFBcXzyA5wpxZ
YWnZSHtkWIT9xWryz3e6UgDfKWJ7JIPa6Yws2Y6A024F2w1W+H2+doKMIsGsKbxo
ZpKNBWYhzTadItW6DoSUY4ndR0/VDsrlpE1vkhil4gJReCoVISvO4VMYt/hKHXpq
EBuNguFoFgDG5XKyvb2MY2nieV8N4Lhgfa31yGtN/o6aSq8ZQSvbOM/qUN+35TjP
R8blk+IyiFQJ+Wxu1wCmwlIq0WhhYB/cHUpmY4GouL+olSLyyHufXL87pE8bIcpB
SQaxhL2pPBvS9vKiJHCniqGxF+g4t8BJXYi5Hg1Q6WI5tq7elHV+aOw4t0Y4dEGw
duYI6bvRsju23kzu5JJDIJEH+9Bxai4lkkj33gBtwoJBVwarXfs=
=09ih
-----END PGP SIGNATURE-----
--=-=-=--
