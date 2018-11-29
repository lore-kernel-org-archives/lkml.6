Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76077C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A75D2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A75D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeK3Kkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:40:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:41250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3Kkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:40:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A431AF4A;
        Thu, 29 Nov 2018 23:33:26 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Nov 2018 10:33:18 +1100
Cc:     paulmck@linux.vnet.ibm.com, Florian Weimer <fweimer@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH - resend*2] VFS: use synchronize_rcu_expedited() in namespace_unlock()
In-Reply-To: <20181005014002.GS32577@ZenIV.linux.org.uk>
References: <87y3nyd4pu.fsf@notabene.neil.brown.name> <20171026122743.GX3659@linux.vnet.ibm.com> <b8a1a898-850c-cc7a-2574-1bfd15cc9888@redhat.com> <20171127144125.GF3624@linux.vnet.ibm.com> <87induxd3u.fsf@notabene.neil.brown.name> <87tvm1rxme.fsf@notabene.neil.brown.name> <20181005014002.GS32577@ZenIV.linux.org.uk>
Message-ID: <87mupro3wh.fsf@notabene.neil.brown.name>
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


The synchronize_rcu() in namespace_unlock() is called every time
a filesystem is unmounted.  If a great many filesystems are mounted,
this can cause a noticable slow-down in, for example, system shutdown.

The sequence:
  mkdir -p /tmp/Mtest/{0..5000}
  time for i in /tmp/Mtest/*; do mount -t tmpfs tmpfs $i ; done
  time umount /tmp/Mtest/*

on a 4-cpu VM can report 8 seconds to mount the tmpfs filesystems, and
100 seconds to unmount them.

Boot the same VM with 1 CPU and it takes 18 seconds to mount the
tmpfs filesystems, but only 36 to unmount.

If we change the synchronize_rcu() to synchronize_rcu_expedited()
the umount time on a 4-cpu VM drop to 0.6 seconds

I think this 200-fold speed up is worth the slightly high system
impact of using synchronize_rcu_expedited().

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> (from general rcu p=
erspective)
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

Al Viro says "I can live with this one" but this still hasn't landed.
Maybe someone else could apply it?

Thanks,
NeilBrown

Full quote from Al on 5th Oct:
> Umm...  IIRC, the last one got sidetracked on the other thing in the seri=
es...
> <checks> that was s_anon stuff.  I can live with this one; FWIW, what kind
> of load would trigger the impact of the change?  Paul?
which Paul replied to.

 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a7f91265ea67..43a0d2c7449d 100644
=2D-- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1360,7 +1360,7 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
=20
=2D	synchronize_rcu();
+	synchronize_rcu_expedited();
=20
 	group_pin_kill(&head);
 }
=2D-=20
2.14.0.rc0.dirty

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwAdz4ACgkQOeye3VZi
gblqLg/+PwPLRxOkRa8exmADt69qsclBqzWP3tAL5qtTl0a3JuH0Tlv04YxeVbct
FUY/sqt6lG6pWf52eTrRWteCxlnQv22kJy+EO+rKmntuRzaF96R8g5Ri4ijQ66l3
xZcaQ8gG4313vG9lW2dj+4cGo4TuvJt/SZUmUI4nkthXfB0crChuZe/4f9G9s4Xx
hcBLnv+xbKS5Uf/ItQVXFx22aviLOCQqGnxEPY1U5jjX/Fkg8oX6lHHJEqdmdr/Q
S8qoMFbWQQgr2Sky4oN8FN3nMmwYoojukUFeA5ddc46M5hxbWqdTAWh+qk2HL4vB
5vCLTlzSf7eH6DP0augawbDr7cijzCjXVnQOU0G6nc6hlm7klVqJ3NUXwARtBpZt
FkMjeBzMRQDq4pXtTNhDueKpXDp9fCn4cKwh7nZIQGp7tyFEC4Dw5Xid7AATuszu
FpKXY9UY4ihm71Cgs4ZRV4lI8zK4LvAzJFLYBNtsgXzMi8ohIX2KV2JCrXKf9vXs
FtSsyKvCKxEjT2F7Q1+U8/TSvjxLIRUqC8WbMFqYNcRqcBw/KOQY+Dy6QTSjvH7d
rGb9gEguAsUlTQtCjFlt6+h+lmxBMPTCd7PGJv96LcP7NvZKK1gOf405m0d68s/c
KYv1PdmKX8e2Pnj6+prAq1f0lVjJOdJY6Oakw3MtQ203vrBEX/o=
=M18W
-----END PGP SIGNATURE-----
--=-=-=--
