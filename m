Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE7AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B66720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B66720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJZF6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:58:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49214 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeJZF6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:58:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CE19B8084E; Thu, 25 Oct 2018 23:24:28 +0200 (CEST)
Date:   Thu, 25 Oct 2018 23:24:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: More checks for patterns? was: Fix pattern handling optimalization
Message-ID: <20181025212429.GB18016@amd>
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com>
 <20181024083143.GA24165@amd>
 <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com>
 <20181024204439.GA32300@amd>
 <79c29d20-ae6a-4a12-28fa-93d7305a0623@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <79c29d20-ae6a-4a12-28fa-93d7305a0623@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


We don't want brightness < 0, but this may not be best way to do
this. We also don't want brightness > max_brightness, but I'm not sure
this check is effective.

We probably also don't want pattern where all the delta_t s are zero.

I came up with this so far....
   	    	       	    	    	      	  	    Pavel



diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/=
ledtrig-pattern.c
index ce7acd1..bc5f495 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -250,9 +251,16 @@ static ssize_t pattern_trig_store_patterns(struct led_=
classdev *led_cdev,
=20
 	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
 		cr =3D 0;
-		ccount =3D sscanf(buf + offset, "%d %u %n",
+		ccount =3D sscanf(buf + offset, "%u %u %n",
 				&data->patterns[data->npatterns].brightness,
 				&data->patterns[data->npatterns].delta_t, &cr);
+
+		if (data->patterns[data->npatterns].brightness > data->led_cdev->max_bri=
ghtness) {
+			data->npatterns =3D 0;
+			err =3D -EINVAL;
+			goto out;
+		}
+			=20
 		if (ccount !=3D 2) {
 			data->npatterns =3D 0;
 			err =3D -EINVAL;




--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvSNI0ACgkQMOfwapXb+vJyjgCfTl2L83kZog2c6ughpc0RXY6D
+REAn0adMKwNRz617q44ig0s9Mv0EML4
=+wPI
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
