Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A0ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D48D20832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D48D20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJYFOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:14:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39513 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJYFOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:14:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CD8AA80806; Wed, 24 Oct 2018 22:44:38 +0200 (CEST)
Date:   Wed, 24 Oct 2018 22:44:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix pattern handling optimalization
Message-ID: <20181024204439.GA32300@amd>
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com>
 <20181024083143.GA24165@amd>
 <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Check for zero duration before skipping step. This fixes pattern
   =20
    echo "0 1000 10 2550 0 1000" > pattern
   =20
which should do [  .-xXx-.] but does [   Xx-.]
   =20
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Suggested-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>


diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/=
ledtrig-pattern.c
index ce7acd1..bc5f495 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -87,9 +87,10 @@ static void pattern_trig_timer_function(struct timer_lis=
t *t)
 					   data->curr->brightness);
 			mod_timer(&data->timer,
 				  jiffies + msecs_to_jiffies(data->curr->delta_t));
-
-			/* Skip the tuple with zero duration */
-			pattern_trig_update_patterns(data);
+			if (!data->next->delta_t) {
+				/* Skip the tuple with zero duration */
+				pattern_trig_update_patterns(data);
+			}
 			/* Select next tuple */
 			pattern_trig_update_patterns(data);
 		} else {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQ2bcACgkQMOfwapXb+vKyowCgmQw1KOCxLLu4I87qhZA1qRqC
5SgAn1uGctB8Vfbn0/8DL1CPCrFjOLb+
=WJ0K
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
