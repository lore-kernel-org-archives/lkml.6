Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2000C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80038241A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80038241A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeGDAKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:10:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:57418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752197AbeGDAKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:10:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "Cc"
        occurs 4 times
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB9CCAFC0;
        Wed,  4 Jul 2018 00:10:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Date:   Wed, 04 Jul 2018 10:10:39 +1000
Cc:     Anthony DeRobertis <aderobertis@metrics.net>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: fix multiple-put race.
In-Reply-To: <afbfd186-1f06-a03c-79b5-c98a12d35c75@metrics.net>
References: <20180222073330.36259-1-carmark.dlut@gmail.com> <afbfd186-1f06-a03c-79b5-c98a12d35c75@metrics.net>
cc:     Lei Xue <carmark.dlut@gmail.com>
cc:     Vegard Nossum <vegard.nossum@gmail.com>
Message-ID: <877emb2740.fsf@notabene.neil.brown.name>
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


cachefiles_read_waiter() owns a reference to a 'monitor'
object and adds the object to a 'to_do' list *before*
calling fscache_enqueue_retrieval() on it.

The reference is passed to the to_do list, so
cachefiles_read_waiter() no longer owns a reference and shouldn't be
accessing the monitor.
cachefiles_read_copier(), which handles the to_do list, might call
fscache_put_retrieval() *before* fscache_enqueue_retrieval()
takes its own reference.

This can result in fscache_put_retrieval() trying to discard the op
twice, which triggers an assertion failure, and can result in freed
memory be accessed.

The former looks like:

 FS-Cache:
 FS-Cache: Assertion failed
 FS-Cache: 6 =3D=3D 5 is false
 ------------[ cut here ]------------
 kernel BUG at fs/fscache/operation.c:494!

A previous patch from Lei Xue moved the fscache_enqueue_retrieval()
call inside the spin_locked region.  I think it is cleaner to move it
before.

Reported-by: Lei Xue <carmark.dlut@gmail.com>
Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
Reported-by: Anthony DeRobertis <aderobertis@metrics.net>
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

hi Andrew,
 this issue was first mentioned in
   https://lkml.org/lkml/2018/2/22/82
 in February, but David Howells doesn't seem to have responded.
 Can you take the patch?

Thanks,
NeilBrown



 fs/cachefiles/rdwr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 5082c8a49686..553a71a2c9cb 100644
=2D-- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -56,11 +56,12 @@ static int cachefiles_read_waiter(wait_queue_entry_t *w=
ait, unsigned mode,
 	object =3D container_of(monitor->op->op.object,
 			      struct cachefiles_object, fscache);
=20
+	fscache_enqueue_retrieval(monitor->op);
+
 	spin_lock(&object->work_lock);
 	list_add_tail(&monitor->op_link, &monitor->op->to_do);
 	spin_unlock(&object->work_lock);
=20
=2D	fscache_enqueue_retrieval(monitor->op);
 	return 0;
 }
=20
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls8EIAACgkQOeye3VZi
gbm2BxAAr/wWv/kNxmNXceRJn4DDgS/MegfD6iELaykmQu5MMlg5zkqkZBf8vAvn
ONm31Pl3vZ1p6af4Hx74yt/rYyWV2YYV8YqzNlcXLngFN4udth+T1/L4fGJ5qY3j
mXoGyfXgFyxR6dhzOPvDmqiIQ9YO1mVnjCzUBe2eDrIGtEYwARkqOWnCcLuo9yIk
ps5jdTfT/kJhEBtCNHL29CnhN8lytvrpIGbWPh6pGiUnpxc0YkANjT5AnwVZs/sy
lB9ASRaY4q3nApJXIt+ieqTAZP3Qp9liqPkVEOFzxd9FsK15gynJVQAf43DJfdoP
5sl7alwasbmYyQC3NeTbpcqaxs6yeoXJNpsnAVVGZOXebEra21ESlg2/6YRUz767
ggS9sSck61DOvD5ZyUFJcJDlGP5CNteT3tS0BehjFB7gNaBy2W3yVyrDTjruz5BV
UBGLYjM356kbgWt1j9jndgQL7SS0yC3szpgOefvz88KWQ4WUzKQT3mv2+WmIs7K1
jU7RXEsZmvKj2VDUxlK1jVeKw+ydTV2LCQF3vuIBbLcquI1/Gv6LRXAUPCxqSyW0
+UsM5zPhpwGMaq6MH+nvh6n6EwN3you1cvvHI0+suPwB+LsnFc8M4gKzvOm0AjUC
qC8zGPpW8phaxYi0cHozOjAv6y4W0anQdJPlwyLVQbfP/mPmQ+Q=
=KC/0
-----END PGP SIGNATURE-----
--=-=-=--
