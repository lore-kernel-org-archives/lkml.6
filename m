Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D65EC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76502251A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76502251A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeGGD3w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:29:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932681AbeGGD3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:29:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 764C2AD99;
        Sat,  7 Jul 2018 03:29:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Date:   Sat, 07 Jul 2018 13:29:41 +1000
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH mm] VFS: seq_file: ensure ->from is valid.
In-Reply-To: <878t6nybj7.fsf@notabene.neil.brown.name>
References: <87vacsrt0r.fsf@notabene.neil.brown.name> <87fu3dihtf.fsf@notabene.neil.brown.name> <874lintqa6.fsf@notabene.neil.brown.name> <87y3fcegnn.fsf@notabene.neil.brown.name> <CAG48ez2yTZMye0W3_5R04bV-Qyaz-=zSiVonw_zvRQNH6dcfeg@mail.gmail.com> <878t6nybj7.fsf@notabene.neil.brown.name>
Message-ID: <87601ryb8a.fsf@notabene.neil.brown.name>
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


Previous patch ("VFS: simplify seq_file iteration code and interface")
removed code to set ->from to zero when ->count is zero, as ->from is
dead at that time.  However it didn't ensure ->from was set properly
whenever ->count becomes non-zero.
This can only happen when ->show() is called.  Of the three places it
is called one already has ->from set to zero.  The other two are
fixed by setting from to zero after fully flushing the buffer (at which
point ->count will also be zero).

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/seq_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index fd82585ab50f..1dea7a8a5255 100644
=2D-- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -220,6 +220,7 @@ ssize_t seq_read(struct file *file, char __user *buf, s=
ize_t size, loff_t *ppos)
 			goto Done;
 	}
 	/* we need at least one record in buffer */
+	m->from =3D 0;
 	p =3D m->op->start(m, &m->index);
 	while (1) {
 		err =3D PTR_ERR(p);
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltAM6UACgkQOeye3VZi
gbkCKxAAgsyjkLo3LicXGnA9025tgEQCFIJ/f8AmB84fU9mdwpQVeBcXPj9PQm6T
0VId2ZWT+X+o52RHje3Fff6X+tEBIddMvancpaY2z4qAws36obFCJYGkpXpbSiEX
taWdCg0i1Srnooi0pTK5Ksf1IApEOnFi61VRHfHw2E68AUEpGYZLJiiE2GlNKmb6
0+wxhlS6sv49+gvR0l2PsycE4ZOhfyQULvgMu51fHGcg2Fu8n3djcoU/q+gfI0Lb
gS9ldvLjW5qH+J09ix3FuHsgfmzRFVouCDXLqWXsqk1i3M/8y8+PRAxU/fhI8xnS
tjo0+hrXT5+2wRg+5nRzWRPpDoC066QEnIZP9qETdF7RsTeFZ7hHRzJfYItiM1zm
cKnXZutNnSc6tT1kRvbgAsTz0Zkj6Lwh2/OhU8VXHPdlKb0hKrkuvPRNWUNzTmuL
SuAgjluI0PeW2/K6Ecn/enNcInZuIthvkCHxq2FF7HTGg/wp4HppYaFmO4VuFR9v
blST0NHtsLa+V/JtJxnHf5s6/gXo1hdOUA2XyaXUxgACclQOlZYNxdh3OxCCrIDl
BJ2nsOavLt42gjLxe9kz8ES41uY4j6HMLod0ToOvWcZNrW3tP/84MFFLY3FXoMz/
glAOb61y1H8+0kJ6Y8Jk8w8E2S7t76cjcF6XfM6P3m9Vm0AlbvQ=
=Gkkb
-----END PGP SIGNATURE-----
--=-=-=--
