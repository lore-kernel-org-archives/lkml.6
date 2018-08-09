Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EDB22394
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EDB22394
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeHJAjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:39:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726890AbeHJAjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:39:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC05BAE66;
        Thu,  9 Aug 2018 22:12:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 10 Aug 2018 08:12:43 +1000
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
In-Reply-To: <20180809173245.GM23873@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble> <20180809173245.GM23873@fieldses.org>
Message-ID: <87lg9frxyc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Aug 09 2018, J. Bruce Fields wrote:

> I think there's also a problem with multiple tasks sharing the same
> lock owner.
>
> So, all locks are exclusive locks for the same range.  We have four
> tasks.  Tasks 1 and 4 share the same owner, the others' owners are
> distinct.
>
> 	- Task 1 gets a lock.
> 	- Task 2 gets a conflicting lock.
> 	- Task 3 gets another conflicting lock.  So now we the tree is
> 		3->2->1.
> 	- Task 1's lock is released.
> 	- Before task 2 is scheduled, task 4 acquires a new lock.
> 	- Task 2 waits on task 4's lock, we now have
> 		3->2->4.
>
> Task 3 shouldn't be waiting--the lock it's requesting has the same owner
> as the lock task 4 holds--but we fail to wake up task 3.

So task 1 and task 4 are threads in the one process - OK.
Tasks 2 and 3 are threads in two other processes.

So 2 and 3 conflict with either 1 or 4 equally - why should task 3 be
woken?

I suspect you got the numbers bit mixed up, but in any case, the
"conflict()" function that is passed around takes ownership into account
when assessing if one lock conflicts with another.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltsvFsACgkQOeye3VZi
gbnd5g/9HP79msN6KOY9iUVDlp6PPFKF9RC0kvf4INOz05YM/AxZ6EccXZxg/jdq
WagfSxoKDD2qPf1WjoxzgMI0WTkbvNi/1YiOEC41HfGWZbMtwRCNjNcg+rw3pmLz
sTvyjsstGalxLVu1nEmdYLGt0RieTl6WzcUIEoWH3IxIqSqkyQRxJ/VFwlk+JYVX
t9N9uMyrGsEEEvMWEZ+IDK6RGodHwKbmSmpCmVYTPaqGYZ6Dd9pz+ZSSdNgwp9qQ
FjlkFBIMvKWzXJDa1mmZpaWZcXylCgBxCAelGsd8AMtxGApABtuJbezwjpL2BbXK
x/UrsBeIYU3EuF9TBa52vrq4eTo8OKyXxJl66R2YPsPwmgkDLlfep0ToBZcPbhkl
vF1fhB+tfXJ297wblupWOHKDuNDA8Vl++Fmjhql7s174yN4Ak6W8gD6Tmgrsb5Yl
3gnzRh+9+Q7muFIsKD+QEo7dSa9Lk4TV0xYN3COHD3ey2tNXzkhl3a/WSk/CpmMh
QnlQqypsKyHA8T4WxqOLE70K+wBsxdp5Ct0gG8Mm12ApO+IETidp48SJNGRicZul
90OcUHXhx8SieIQkJrb1hOwAhp0vmk2oZlZT0eO1f31yJq9OaU+SkR7+qCHgl/Yd
Hnfgei/bnHlTdA9/YOqPjjX/2MqV+lfHmu3wWBErz2Ot5mwrkMQ=
=Ei+X
-----END PGP SIGNATURE-----
--=-=-=--
