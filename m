Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8EBC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AE32081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AE32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLIS6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:58:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38226 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeLIS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:58:49 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6C38580785; Sun,  9 Dec 2018 19:58:44 +0100 (CET)
Date:   Sun, 9 Dec 2018 19:58:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org
Subject: Re: [PATCH 1/2] led: triggers: Break the for loop after default
 trigger is found
Message-ID: <20181209185847.GB6331@amd>
References: <20181209184942.22391-1-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20181209184942.22391-1-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-09 19:49:41, Jacek Anaszewski wrote:
> It is of no avail to continue iterating through registered
> triggers in the led_trigger_set_default() after the trigger to set
> has been found. Add "break" statement to fix this omission.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
> index 17d73db1456e..52b12e601ebe 100644
> --- a/drivers/leds/led-triggers.c
> +++ b/drivers/leds/led-triggers.c
> @@ -200,8 +200,10 @@ void led_trigger_set_default(struct led_classdev *le=
d_cdev)
>  	down_read(&triggers_list_lock);
>  	down_write(&led_cdev->trigger_lock);
>  	list_for_each_entry(trig, &trigger_list, next_trig) {
> -		if (!strcmp(led_cdev->default_trigger, trig->name))
> +		if (!strcmp(led_cdev->default_trigger, trig->name)) {
>  			led_trigger_set(led_cdev, trig);
> +			break;
> +		}
>  	}
>  	up_write(&led_cdev->trigger_lock);
>  	up_read(&triggers_list_lock);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNZecACgkQMOfwapXb+vJqOACgmfbn4ZU0GE/Y4e63y5ciJhEG
6v8An2sq4nj0m5dD04LbNtArKGkfqBZt
=5dK7
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
