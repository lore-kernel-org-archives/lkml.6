Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0415FC64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FE820684
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FE820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeJEIYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:24:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbeJEIYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:24:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD70EAF64;
        Fri,  5 Oct 2018 01:27:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 05 Oct 2018 11:27:37 +1000
Subject: [PATCH - resend] VFS: use synchronize_rcu_expedited() in namespace_unlock()
In-Reply-To: <87induxd3u.fsf@notabene.neil.brown.name>
References: <87y3nyd4pu.fsf@notabene.neil.brown.name> <20171026122743.GX3659@linux.vnet.ibm.com> <b8a1a898-850c-cc7a-2574-1bfd15cc9888@redhat.com> <20171127144125.GF3624@linux.vnet.ibm.com> <87induxd3u.fsf@notabene.neil.brown.name>
cc:     paulmck@linux.vnet.ibm.com, Florian Weimer <fweimer@redhat.com>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Message-ID: <87tvm1rxme.fsf@notabene.neil.brown.name>
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

I posted this last October, then again last November (cc:ing Linus)
Paul is happy enough with it, but no other response.
I'm hoping it can get applied this time....

Thanks,
NeilBrown


 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 99186556f8d3..02e978b22294 100644
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlu2vgoACgkQOeye3VZi
gbmZOA//e7G6KddOM7xLLW23abe74jzVfNmzYG7YEa3tyGYpMoZH0gIiqX7PE75F
+Q6LUHyw+TDdM2JT1lRas1U7IB6Nyw/5HuRPMLLYXUfLr1JQi3/76ulTzAlqSovY
l5MV5olJyGoOokx1XIskP2b1e1sw92uomSg6IsKLwfdBdlxdxp35DAHHZIJ9JEW1
NbekxZDfc9CVRDxzgMF9lb5AVRI3iVGm7V9yBYKH0jPZqrkB4uYHClFpgZmWopkn
Szearh1D9WiItMrFhQV21opgxCWUPiXCH0/z/pJVI4/uEZIC567REamXcjQSQ3Kg
tXXHI8QOQedMXZKCzJ/JdiYveehY8hVqwFIkBYuTvfyMHhK1W7QTLaCMZSwR7lWD
MB3z2IKF147yx6qvrWvk1jVGZX3cuI3vR0WrlALWU5GbDjcNIDGy6we64acClUzU
qKnuh/hPEbaw5lVc/unYGsdKhiO3URQ7tihR7BKrSHkso/C/C88z+J1oKkPE1Z+9
vlMLuOFpVjdP6zNKDRBrZ/cBapCydRGqEMHYX9TPWrh0T12LyiKsB+dOmKOkIpSu
giAILww+HPyfIGIcQrUUBaBHkJ+ErcGFgRStF9k0sh4EDPkdjRuwP5Q8FsUDS+57
jjG0fhAw+6clZk4ut1TWS2bAGYjbiXXL03LYCpgcudDg27+puQM=
=lAt5
-----END PGP SIGNATURE-----
--=-=-=--
