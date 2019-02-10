Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2714DC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2E120836
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBJXhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:37:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:43732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfBJXhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:37:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BA92AA5C;
        Sun, 10 Feb 2019 23:37:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 11 Feb 2019 10:37:02 +1100
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] autofs: clear O_NONBLOCK on the pipe.
Message-ID: <871s4fi5b5.fsf@notabene.neil.brown.name>
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


autofs does not expect the pipe it is given
to have O_NONBLOCK set - specifically if __kernel_write()
in autofs_write() returns -EAGAIN, this is treated
as a fatal error and the pipe is closed.

For safety autofs should, therefore, clear the O_NONBLOCK flag.

Releases of systemd prior to 8th February 2019 used
  pipe2(p, O_NONBLOCK|O_CLOEXEC)
and thus (inadvertently) set this flag.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/autofs/autofs_i.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 3e59f0ed777b..331192bed0d5 100644
=2D-- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -215,6 +215,8 @@ static inline int autofs_prepare_pipe(struct file *pipe)
 		return -EINVAL;
 	/* We want a packet pipe */
 	pipe->f_flags |=3D O_DIRECT;
+	/* We don't expect -EAGAIN */
+	pipe->f_flags &=3D ~O_NONBLOCK;
 	return 0;
 }
=20
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlxgtZ8ACgkQOeye3VZi
gbkKfxAAovzwzLeVTTLauw7I0IV/UMT4W3i6kGU0oz3My/MjneljT69J03n9049j
LS+nZ0NwUx3sRjbVzZaExcG1v3W//72laRRGrZaYReyezH2oC1FVaDNwbDzO7QcV
poElvVKtf8XGi5jRzY2hF+Olvhudfg4DqaTOBCBqiqwJBJoR7SLhOOzp6nC+coem
0bLn3p6igW6W7M5J4n44RdQ0R+ITvKd8B3iuWrlDEel8cl/OMDHwbqS1ndPYBYJ+
e+gsWgSBb63GT0wG6l8ZjolVA0piF+H3Gol97kWo5lSwZdSyd/Ti4vfymBsmhSyi
dcrpcZ1/ymiXSWkY3q2T72UJfRWA7Zq9scRn4e71Pz7tADQaRh1BTBQ4dq9YzyOO
dwWfvYxowOXDUYqU9OIGwR0ct+yuuz+XEvX1u/2Xk+s60PHmY6IWvRy1qDmPc3eN
GaoiQA36psC6u3WiCkjVvPoCV7JJhrSTiNetnbqavRf21yTNowt9wtHokRFsE3+o
JBQRTcFta4mSDO0NZcZy1JJOrv6b4xhvuHap18qjqpWKWARe92SvfE8C64a+b7HO
kkWGgnuwSs6ywKP/nzvTMKDzVaBslB0/xKHSIvr7SuUyD3ZWzxWptKofuEkpVBxi
B/27RMA508BfXFXbiMpy5nqPwFz7Wgg6IMwS3deF6NCPPQ5cJK4=
=gIWk
-----END PGP SIGNATURE-----
--=-=-=--
