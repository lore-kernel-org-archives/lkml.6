Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1EEC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F287F20824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F287F20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeJZOwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 10:52:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbeJZOwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 10:52:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C88BDAF04;
        Fri, 26 Oct 2018 06:16:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Howells <dhowells@redhat.com>
Date:   Fri, 26 Oct 2018 17:16:29 +1100
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: fix race between enablement and dropping of object
Message-ID: <87r2gd44hu.fsf@notabene.neil.brown.name>
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


It was observed that a process blocked indefintely in
__fscache_read_or_alloc_page(), waiting for FSCACHE_COOKIE_LOOKING_UP
to be cleared via fscache_wait_for_deferred_lookup().

At this time, ->backing_objects was empty, which would normaly prevent
__fscache_read_or_alloc_page() from getting to the point of waiting.
This implies that ->backing_objects was cleared *after*
__fscache_read_or_alloc_page was was entered.

When an object is "killed" and then "dropped",
FSCACHE_COOKIE_LOOKING_UP is cleared in fscache_lookup_failure(), then
KILL_OBJECT and DROP_OBJECT are "called" and only in DROP_OBJECT is
=2D>backing_objects cleared.  This leaves a window where
something else can set FSCACHE_COOKIE_LOOKING_UP and
__fscache_read_or_alloc_page() can start waiting, before
=2D>backing_objects is cleared

There is some uncertainty in this analysis, but it seems to be fit the
observations.  Adding the wake in this patch will be handled correctly
by __fscache_read_or_alloc_page(), as it checks if ->backing_objects
is empty again, after waiting.

Customer which reported the hang, also report that the hang cannot be
reproduced with this fix.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/fscache/object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 9edc920f651f..6d9cb1719de5 100644
=2D-- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -730,6 +730,9 @@ static const struct fscache_state *fscache_drop_object(=
struct fscache_object *ob
=20
 	if (awaken)
 		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
+
=20
 	/* Prevent a race with our last child, which has to signal EV_CLEARED
 	 * before dropping our spinlock.
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvSsT4ACgkQOeye3VZi
gbksGg//Tuf2Di28jhOfaY/k1ZGTzIlv2r1c0c/kryjUdWpkeI+d2LBgrO3SoY4l
oC737NpNMDznq0Gqcrmd5Gf3D3pYGeocqbWlu/Dd1JmK/DIrNdxPXHHrpjFpqysp
JguoyQfXM8OfDkvd8kOpRMoqDVM76Yj5Ya7LXfVmut9VG7t/bJ1Ratfww02mxOV7
yDZTAAualnTzTjLqaYsdlQVC3/1Lf+/9y5B5hCp7I09yUzFpDRJUfHwkomWfO6fn
iVRolRCRmw8mjEHtWQ7RLxIvtCWDolgeKrBiF19Pf/ypm/aMW4xzMEf3RB3HAyLA
euGAcZNoBovp060h64ymTJDGohBOGQIwpTsHDuBn0aPmNPIIhr8bb1kUdhX/F10R
18ZLMtxPMWlmrEDe2cNPz5uBTH28D7e9gvsDg5DLORI6tNqyES+SxMX6F9v4usET
arVKXvBvuwozD8CGB9GFLb9AQk0iSMMjBhHaAbDUyQRXM/2fXCEU330333FeTOWM
sAMTGvvUAyDkfMPj2HEfAsLr993Bp32QZ1mJ+R7LCAXYTxJ30wLwnXRrNNsPm3yG
F/ziONrx8ZaE+iASmdESyCEamciyUHQ5060WHaYq3qHRkTx3EDybOIgvKW5LIjun
MkoF8e4uxOnt/VxNIUZFVxQJsjkgOe3m0YKJnsVk42nBmOTslMg=
=INvw
-----END PGP SIGNATURE-----
--=-=-=--
