Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1DCC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172D02081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172D02081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeKFMio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:38:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:50490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbeKFMio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:38:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 416B1ADF1;
        Tue,  6 Nov 2018 03:15:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 06 Nov 2018 14:15:35 +1100
Cc:     paulmck@linux.vnet.ibm.com, Florian Weimer <fweimer@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH - resend] VFS: use synchronize_rcu_expedited() in namespace_unlock()
In-Reply-To: <87tvm1rxme.fsf@notabene.neil.brown.name>
References: <87y3nyd4pu.fsf@notabene.neil.brown.name> <20171026122743.GX3659@linux.vnet.ibm.com> <b8a1a898-850c-cc7a-2574-1bfd15cc9888@redhat.com> <20171127144125.GF3624@linux.vnet.ibm.com> <87induxd3u.fsf@notabene.neil.brown.name> <87tvm1rxme.fsf@notabene.neil.brown.name>
Message-ID: <87tvkuyjzc.fsf@notabene.neil.brown.name>
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

On Fri, Oct 05 2018, NeilBrown wrote:

> The synchronize_rcu() in namespace_unlock() is called every time
> a filesystem is unmounted.  If a great many filesystems are mounted,
> this can cause a noticable slow-down in, for example, system shutdown.
>
> The sequence:
>   mkdir -p /tmp/Mtest/{0..5000}
>   time for i in /tmp/Mtest/*; do mount -t tmpfs tmpfs $i ; done
>   time umount /tmp/Mtest/*
>
> on a 4-cpu VM can report 8 seconds to mount the tmpfs filesystems, and
> 100 seconds to unmount them.
>
> Boot the same VM with 1 CPU and it takes 18 seconds to mount the
> tmpfs filesystems, but only 36 to unmount.
>
> If we change the synchronize_rcu() to synchronize_rcu_expedited()
> the umount time on a 4-cpu VM drop to 0.6 seconds
>
> I think this 200-fold speed up is worth the slightly high system
> impact of using synchronize_rcu_expedited().
>
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> (from general rcu=
 perspective)
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>
> I posted this last October, then again last November (cc:ing Linus)
> Paul is happy enough with it, but no other response.
> I'm hoping it can get applied this time....

Hi Al,
 this isn't in 4.20-rc1.  Are you still waiting for something?

Thanks,
NeilBrown


>
> Thanks,
> NeilBrown
>
>
>  fs/namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 99186556f8d3..02e978b22294 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1360,7 +1360,7 @@ static void namespace_unlock(void)
>  	if (likely(hlist_empty(&head)))
>  		return;
>=20=20
> -	synchronize_rcu();
> +	synchronize_rcu_expedited();
>=20=20
>  	group_pin_kill(&head);
>  }
> --=20
> 2.14.0.rc0.dirty

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvhB1cACgkQOeye3VZi
gbnV2BAAlCVNzLY4N+BoSw9ckHCCi7ml0swun22exfC7j1z/zcy9EbnAArSPlcD9
9ZkG6F+LsDf5yuHyzwJxOQ8bhhkfs2MINrGm5F+J/ZfEY0y4R7dR8o3zPrbrydmO
5fbafqTdrqTg3+LgqC2TJnE93naJ5enrRjK1PqMlMo7NfFh9P3YG0mOa8QrF3RfV
FhEaOqlfPZ9tG2ZyiyIcRh41M/YcjfHT61g+yz85AT7kn7odPYLeDhE1gnlm13iN
l8H8OnoGvDfB9PCGgjQFXyP3SnTlu1GGjE2GjW+U4NQUEusRu85CcPlfJpRX+OpZ
azMhXsOzkjdnn8fGHy78kGANQh3EzrbxwALlISbe35joCMB9bIxAHDjBSnBXm74C
Jdh9P6vzfL70WRrI1Ln1UuZi7kNVHejPE7+WD8hCBM2bBuUecsn3fxPOf4uTl0JJ
y80W3S7ppISQ5LN7x1dQ9LM/Fi7Ya0onggE+3YC/mlF/oqKT/BA6VHXVJmKy3Gmd
i5RWU4NNFy+4P9uKArDjZIeUiulZCN22C9Q+l7e7sKfpOYLJMr+MoM6D+i2/BXWA
bH8T+xC25Olau2uHfl1LfKmVrQ5/CHj2bLqO2xnCWc10pCeQjNLGvDqU84K7OgX5
KgNLDceu6b2H9gNBACrThnIaJRougJSzUZQry/Gy78D1CQW2idc=
=zXDp
-----END PGP SIGNATURE-----
--=-=-=--
