Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E07C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE68920BED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE68920BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeHJCXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:23:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:43806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbeHJCXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:23:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 508B0AD37;
        Thu,  9 Aug 2018 23:56:14 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
Date:   Fri, 10 Aug 2018 09:56:07 +1000
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
In-Reply-To: <20180809130001.GG23873@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble> <20180808195445.GD23873@fieldses.org> <20180808200912.GE23873@fieldses.org> <20180808212832.GF23873@fieldses.org> <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org> <20180809130001.GG23873@fieldses.org>
Message-ID: <877ekzrt60.fsf@notabene.neil.brown.name>
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

On Thu, Aug 09 2018, J. Bruce Fields wrote:

> On Wed, Aug 08, 2018 at 06:50:06PM -0400, Jeff Layton wrote:
>> That seems like a legit problem.
>>=20
>> One possible fix might be to have the waiter on (1,2) walk down the
>> entire subtree and wake up any waiter that is waiting on a lock that
>> doesn't conflict with the lock on which it's waiting.
>>=20
>> So, before the task waiting on 1,2 goes back to sleep to wait on 2,2, it
>> could walk down its entire fl_blocked subtree and wake up anything
>> waiting on a lock that doesn't conflict with (2,2).
>>=20
>> That's potentially an expensive operation, but:
>>=20
>> a) the task is going back to sleep anyway, so letting it do a little
>> extra work before that should be no big deal
>
> I don't understand why cpu used by a process going to sleep is cheaper
> than cpu used in any other situation.
>
>> b) it's probably still cheaper than waking up the whole herd
>
> Yeah, I'd like to understand this.
>
> I feel like Neil's addressing two different performance costs:
>
> 	- the cost of waking up all the waiters
> 	- the cost of walking the list of waiters
>
> Are they equally important?

Probably not.  Reducing wakeups is likely the most important.

>
> If we only cared about the former, and only in simple cases, we could
> walk the entire list and skip waking up only the locks that conflict
> with the first one we wake.  We wouldn't need the tree.

Yes, we could do that. It would probably make the code simpler.
It would mean doing the conflicts() tests when performing wake-up rather
than prior to going to sleep.  In general it would mean doing the tests
more often, as the tree effectively records the results of the previous
time conflicts() was run.
You might get a quadratic effect though ... wouldn't you want to
skip anything that conflicts with anything that has been woken?

If the tree-management code turns out to be too complex, it would
certainly be an option.  I think the tree approach should result in less
total CPU usage..

Thanks for the thought - taking this simple approach really hadn't
occurred to me. :-(

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlts1JcACgkQOeye3VZi
gbkx8A/7BrroKFHv98IaALqQisj0VrPtO2da+PfQWiF3gVhs4+GJ0LrTt/9hRCdQ
qKMOIjIRI8uJ+SVJGMsga4s/9bGYgN0I2P8THms91GtxabQOVPSiXC1cJXCLvGny
JAYwZpcsVvOXyb2PKOI6X1tQe7HTuakykSJW5S0sMMSU3YEJXNRaIJVRmOqlhI8u
TIyeSDoJodcscKc7d6IajtuaBRDYh4N6M+1pKXIiOgfMC/yVokbvK5EGp9vApDCk
PK+XJnushEwraWi8F+2zPhevbTvjXuCavMpdi9PC7gC2gMKNoze1keAq99Z+ho7K
E+taUIb3pkxm+D8Eu44bAcJQ0n3JrJb4N5Z3RU+ye3xVUIAuU0c6UbLrH90lLl0i
sgPvZo5xTpzgkFlrJ7+euo4iisoKDzHTU5I8x10ig412ofLiH4AE7lprpaGFDNyy
EMUTu7l5JjDEBQvoWlAAC8AJ0Aiy97ipLRuUyfhJFDR7GlzubGm09xeWoLpUf9c4
WuSVGTOQ79tOWTsTGTEkqWaAR3sqaKeJECXNPMBLiPZk0CkEUYrWMG/BSvCsXegp
oi4EIh6i9CJaBN5nokmH+mTvNrdADaNZx3OyFU1VmtcXTVeU3lpKwJ4aE0HdDHpV
YLcVO26qg6nqoA9ILqHtAdrdoDSGs6dd2bZA7eMkAG2iBcd5Fgw=
=zWer
-----END PGP SIGNATURE-----
--=-=-=--
