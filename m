Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83473C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5202120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5202120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeKIQDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:03:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:55824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727549AbeKIQDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:03:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53D67AF3E;
        Fri,  9 Nov 2018 06:24:13 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 09 Nov 2018 17:24:04 +1100
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] fs/locks: create a tree of dependent requests.
In-Reply-To: <20181109030913.GA8831@fieldses.org>
References: <154138128401.31651.1381177427603557514.stgit@noble> <154138144796.31651.14201944346371750178.stgit@noble> <20181108213030.GF6090@fieldses.org> <87k1lnw0ec.fsf@notabene.neil.brown.name> <20181109030913.GA8831@fieldses.org>
Message-ID: <87bm6ywyyj.fsf@notabene.neil.brown.name>
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

On Thu, Nov 08 2018, J. Bruce Fields wrote:

> On Fri, Nov 09, 2018 at 11:38:19AM +1100, NeilBrown wrote:
>> On Thu, Nov 08 2018, J. Bruce Fields wrote:
>>=20
>> > On Mon, Nov 05, 2018 at 12:30:48PM +1100, NeilBrown wrote:
>> >> When we find an existing lock which conflicts with a request,
>> >> and the request wants to wait, we currently add the request
>> >> to a list.  When the lock is removed, the whole list is woken.
>> >> This can cause the thundering-herd problem.
>> >> To reduce the problem, we make use of the (new) fact that
>> >> a pending request can itself have a list of blocked requests.
>> >> When we find a conflict, we look through the existing blocked request=
s.
>> >> If any one of them blocks the new request, the new request is attached
>> >> below that request, otherwise it is added to the list of blocked
>> >> requests, which are now known to be mutually non-conflicting.
>> >>=20
>> >> This way, when the lock is released, only a set of non-conflicting
>> >> locks will be woken, the rest can stay asleep.
>> >> If the lock request cannot be granted and the request needs to be
>> >> requeued, all the other requests it blocks will then be woken
>> >
>> > So, to make sure I understand: the tree of blocking locks only ever has
>> > three levels (the active lock, the locks blocking on it, and their
>> > children?)
>>=20
>> Not correct.
>> Blocks is only vertical, never horizontal.  Siblings never block each
>> other.
>> So one process hold a lock on a byte, and 27 other process want a lock
>> on that byte, then there will be 28 levels in a narrow tree - it is
>> effectively a queue.
>> Branching (via siblings) only happens when a child conflict with only
>> part of the lock held by the parent.
>> So if one process locks 32K, then two other processes request locks on
>> the 2 16K halves, then 4 processes request locks on the 8K quarters, and
>> so-on, then you could end up with 32767 processes in a binary tree, with
>> half of them all waiting on different individual bytes.
>
> Maybe I should actually read the code carefully instead of just skimming
> the changelog and jumping to conclusions.
>
> I think this is correct, but I wish we had an actual written-out
> argument that it's correct, because intuition isn't a great guide for
> posix file locks.
>
> Maybe:
>
> Waiting and applied locks are all kept in trees whose properties are:
>
> 	- the root of a tree may be an applied or unapplied lock.
> 	- every other node in the tree is an unapplied lock that
> 	  conflicts with every ancestor of that node.
>
> Every such tree begins life as an unapplied singleton which obviously
> satisfies the above properties.
>
> The only ways we modify trees preserve these properties:
>
> 	1. We may add a new child, but only after first verifying that it
> 	   conflicts with all of its ancestors.
> 	2. We may remove the root of a tree, creating a new singleton
> 	   tree from the root and N new trees rooted in the immediate
> 	   children.
> 	3. If the root of a tree is not currently an applied lock, we may
> 	   apply it (if possible).
> 	4. We may upgrade the root of the tree (either extend its range,
> 	   or upgrade its entire range from read to write).
>
> When an applied lock is modified in a way that reduces or downgrades any
> part of its range, we remove all its children (2 above).
>
> For each of those child trees: if the root of the tree applies, we do so
> (3).  If it doesn't, it must conflict with some applied lock.  We remove
> all of its children (2), and add it is a new leaf to the tree rooted in
> the applied lock (1).  We then repeat the process recursively with those
> children.
>

Thanks pretty thorough - and even looks correct.
I'll re-reading some time when it isn't late, and maybe make it into a
comment in the code.
I agree, this sort of documentation can be quite helpful.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvlKAUACgkQOeye3VZi
gbnnRg/8DK+Zv73yAzgSJvPbwxgXatREw2sbd8OQ10lTp4fEISzSUXb8fNs/AwiJ
j/ZKu7XV3gLmep7IA1GIR2piBPwuLeDvHsxVkIc3tQdtaGMTcqtTbRdYcsfvVT1u
77lV4AOnI2wXey1b03gFmEu2ZMCMe+Kk69nvTY6vnkRiCq+VZUbpKFHkHB1vf9DN
gpYnZnd2nR6FVYfh5SkjxhuzecZJWwnkA7GCO7oHShaeAu9bZXBwKivQNhJadQse
0Y6oNexj4gS5t4zvu3ZGEnait7QeeSOocq8Me6QiItqt0k0EBCiXfhnoVlthjxv9
29Q3IkPQQ7JfZKkn8FVgdvzG3j031BQbhvZ5HoSKLwkFptpAe9xYxbUhJwjvNBJy
HYHGGPdFy5oqbjcTTqt31YQUa+7xaYN4ObMkRt/6InjUpMIc1FjlcKuprdW7J9Tx
AfAYAmAt+jQys9RX81fktLzgX7Fv26sGT1h7NaPwhHfHKprDr05eYk2XU+T1OfQC
U3Qu3HAQ+ziKtk96dnsZufITY3pDIZBPS7IPfUCGHpgqGyVjik4Kem2V8twrgvcQ
E//XruPKNvf37eP9pIdjKv1f2uSg7vV1husdfmReGJOtlTlM/BgnfgAIuooMYAhY
DIzYGFL9gtQdOQc8Bv2cmueKcrq77RXLuDfKaP8zM/Zz20jXIQ0=
=0W5C
-----END PGP SIGNATURE-----
--=-=-=--
