Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A41CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02818218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392740AbfBMWtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:49:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47447 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfBMWtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:49:02 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 68E6B802DD; Wed, 13 Feb 2019 23:48:53 +0100 (CET)
Date:   Wed, 13 Feb 2019 23:48:59 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] pre-shared passcode: secure pairing for "no keyboard, no
 display" devices
Message-ID: <20190213224859.GA7151@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Currently, "no keyboard, no display" devices can be paired, but
pairing is not secure against active attacker.

Can we do better? Not for the first pairing; but for the next ones --
yes, I believe we can.

BLE device in this case has internal storage, and Linux running
there. From factory, random 6-digit number is stored in the
flash. Legitimate user knows the number, and system is manipulated so
that pairing passkey will be this pre-shared passkey. After pairing,
user is allowed to change it.

[Or maybe passkey is 000000 from the factory; this is still win for
the user, as long as he can change the key to something random in a
secure cave.]

Fortunately, kernel support for this is rather easy; patch is attached
below.

Does someone see a security issue with proposal above?

What would be suitable interface for setting pre-shared passkey?
Module parameter is really easy.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 621146d..7a2b06595 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2674,6 +2674,11 @@ static u8 sc_select_method(struct smp_chan *smp)
 	return method;
 }
=20
+static int preshared_passkey =3D -1;
+
+module_param(preshared_passkey, int, 0600);
+MODULE_PARM_DESC(preshared_passkey, "Preshared passkey for device w/o keyb=
oard or display");
+
 static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_public_key *key =3D (void *) skb->data;
@@ -2752,9 +2757,11 @@ static int smp_cmd_public_key(struct l2cap_conn *con=
n, struct sk_buff *skb)
 		set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
=20
 	if (smp->method =3D=3D DSP_PASSKEY) {
 		get_random_bytes(&hcon->passkey_notify,
 				 sizeof(hcon->passkey_notify));
+		if (preshared_passkey !=3D -1)
+			hcon->passkey_notify =3D preshared_passkey;
 		hcon->passkey_notify %=3D 1000000;
 		hcon->passkey_entered =3D 0;
 		smp->passkey_round =3D 0;
 		if (mgmt_user_passkey_notify(hdev, &hcon->dst, hcon->type,




--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxkntsACgkQMOfwapXb+vKt1ACdEdWMXJbwcY4nEoON81kJvwGH
7K8AoJJDg2oeh8zFZpa3xAMZxzTnpiOO
=Yhc6
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
