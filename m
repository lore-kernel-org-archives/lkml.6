Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD6AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628B420839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+KW0AIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628B420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeLLKxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:53:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37725 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:53:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so15166131edb.4;
        Wed, 12 Dec 2018 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vfxc41MQev2It2ciz0QezWf41v+v1Xv6kL1HJQbfvPU=;
        b=A+KW0AIAFZ8sEtFVRS398SnlU9X5dNc2YSAXZgY/ysns2oJYwGbWtFpegzSkpTAu5D
         yY2q6lvXMqX0KnPO/BtW0pGBwWNBLTiHrxonxQu1DI640h/cufUd4wAiDvRWFgslny8G
         9DC8DkgX6/0nvljvpI8kOI6N7NN8VoASn0oEGyxyZ0i4MkNxKYt6nChEnbBWMJb77MNF
         A0N5cQidjDiuWoh4crYv1JBL9jboPQDL196n/SBUdTbspf0+adOrlZ9l9U5utvmopEDN
         xE+HDkeAzohBrnXYY0pkYtGdHwO5FzZN1v7fytAPiA1UhvPd630B5tRByBb5g9vBkEsB
         /2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vfxc41MQev2It2ciz0QezWf41v+v1Xv6kL1HJQbfvPU=;
        b=ajNkaIaxEXcWmiARBFSW12L5owISw6SAr16h9comny7XBhEnIUSyh8NnM7jedf2a0u
         6Q16aAqtK6sv2T8JaT2XIzy7G+rDM2CyfIIEQl3rYzluqfsIz8uPFCSY8HzywXc+FW5W
         TGknmUqJitN8zKlYl7yU2QgeyKRodZ4lbhHxU1bv61eTLgIj+KVdE89Cjp8eBFLbwhLV
         ydI0dRbYvGsAAQ4llzv5aepYFK9V5mK9W6x/1PM38nIuEbffj5Be+C1+QesYF+vHywBf
         9sziRH02BGUJT+unJBg+ToeG5puBXB7Nr7714ragsREK3R7WWqhBwSRI9GFlZKmrxsTe
         s/8g==
X-Gm-Message-State: AA+aEWYxg/6MqIuPe1rA0dHnPWz8D1UKCUSsr6WBi+lK/ghwwKWpIu9j
        xoRuQlYVAbfGmWU89jPrROQq8Nqo
X-Google-Smtp-Source: AFSGD/Wf608l6aa7QXnONKAPT5x0H2eJHJf9FVM/R7oa+ITzb9IkVdR+d6wvvTxa1tq3nTEBVsSptQ==
X-Received: by 2002:a50:a974:: with SMTP id m49mr19004254edc.220.1544611985878;
        Wed, 12 Dec 2018 02:53:05 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id j31sm5018451eda.46.2018.12.12.02.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:53:05 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:53:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm: imx: Use bitops and bitfield macros to define
 register values
Message-ID: <20181212105304.GC17654@ulmo>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
 <1538403588-68850-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <1538403588-68850-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 04:19:47PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Use existing macros to define register fields instead of manually shifting
> the bit masks. Also define some more register bits.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  drivers/pwm/pwm-imx.c | 78 ++++++++++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 58 insertions(+), 20 deletions(-)

Applied, thanks.

Thierry

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ6JAACgkQ3SOs138+
s6FWHg//XmrkBX1MOHOJxSKNoeDjxd7tnUqJ7BBL474nB+urg+LI8a1V8mdD/JQJ
/gQsfU5Fzj4SN8aPCCCagZ3VfTdpBNlU1zdyn/VLZSxsDcS5lBbjD3xj+VMrNwGF
J2hsSYnPVRtkUKhXjTAduFjkvj3z8wTr6JdXH3TFOGlB4xuNkQ/yYsi+9PYNdbSg
0Dlo44y9XsNOoWSk9he9/X3hI7zoy94RYsREGaQ7JUKRV0RVLwI/EmoDycuoX3Ao
QTs65BxCbF80OsRmRtUBnFQm9Hm+vXkYQOq29bwC10j96lvGQrB/96nlyu9QuBoo
SZ0BJXaZ2gCmMCVHDiWo9YLT9iF2hSJtgxuRktH2xgm3qLOEJ0wPhIPmz3h8keIu
FXm6g3KhO8cxI13tVYLLao4P1wmgWsAvoBdSr3aItSJYEajThxsrajuLUe7FAC+W
c2mjOPvi5s3fUWVJX889kFFcGV8D9N/asV71R8cyJkqNO1P3BDClZIn1Y5JUJ9/m
j31X9KwHB21aoe7Vh8j5Ilq9xyYvYzZTCfrsFw57O3Hd9qBpIl1OV2afiEEGHf0l
82mcGyxN2KvI3sonc2yp1f4GEofryEHr9XEfFLroV6VeXs0/7RFUI9kRWXFITuQU
EdjOAATNiNR3Z++cF2nt0++TFD4TvS3s5li5moBxitwLe21ojpg=
=X4Yq
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
