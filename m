Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4988FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260A02083B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404966AbfBMS3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:29:02 -0500
Received: from anholt.net ([50.246.234.109]:39224 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389802AbfBMS3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:29:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3475710A2C82;
        Wed, 13 Feb 2019 10:29:01 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hdbGv0NGadzd; Wed, 13 Feb 2019 10:28:59 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DE28610A2A32;
        Wed, 13 Feb 2019 10:28:59 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 6BC1E2FE464C; Wed, 13 Feb 2019 10:28:59 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 2/2] soc: bcm: bcm2835-pm: Fix error paths of initialization.
In-Reply-To: <648bbc3e-6690-9b05-cae5-bf81edbec74a@i2se.com>
References: <20190213003324.15224-1-eric@anholt.net> <20190213003324.15224-2-eric@anholt.net> <648bbc3e-6690-9b05-cae5-bf81edbec74a@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 13 Feb 2019 10:28:58 -0800
Message-ID: <87tvh7v8yd.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
> Am 13.02.19 um 01:33 schrieb Eric Anholt:
>> The clock driver may probe after ours and so we need to pass the
>> -EPROBE_DEFER out.  Fix the other error path while we're here.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domain=
s under a new binding.")
>> ---
>>  drivers/soc/bcm/bcm2835-power.c | 30 +++++++++++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-p=
ower.c
>> index 4a1b99b773c0..11f9469423f7 100644
>> --- a/drivers/soc/bcm/bcm2835-power.c
>> +++ b/drivers/soc/bcm/bcm2835-power.c
>> @@ -485,7 +485,7 @@ static int bcm2835_power_pd_power_off(struct generic=
_pm_domain *domain)
>>  	}
>>  }
>>=20=20
>> -static void
>> +static int
>>  bcm2835_init_power_domain(struct bcm2835_power *power,
>>  			  int pd_xlate_index, const char *name)
>>  {
>> @@ -493,6 +493,12 @@ bcm2835_init_power_domain(struct bcm2835_power *pow=
er,
>>  	struct bcm2835_power_domain *dom =3D &power->domains[pd_xlate_index];
>>=20=20
>>  	dom->clk =3D devm_clk_get(dev->parent, name);
>> +	if (IS_ERR(dom->clk)) {
>> +		int ret =3D PTR_ERR(dom->clk);
>> +
>> +		if (ret =3D=3D -EPROBE_DEFER)
>> +			return ret;
> is it safe to proceed in the other error cases?
> Even it would be more consistent with clk_prepare_enable() to print an
> error here.

Yes, not all domains have a clk, so we want to ignore the other error.
And we shouldn't print for defers, generally.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxkYesACgkQtdYpNtH8
nuj6YQ/+OhOzNEN9E3pEImKm3B4WL05UYLLa9M2P4TqsnIjKehEPo4zm8Kj46oNG
B7VtJqh/Tm9z6UiLTgnUmmBm9cXWFac2qB5VV2eQcg5waDa33MkpAvXjaDsj/UeJ
m7Ky8X/bvmVKvKmGulcw2qyLnuu4kp0Rhswf8C4LfHkHZ/xDy0EXDk89A82EqnAy
YmKLhte/nlxzCNuUz/itxNI2aeJ8g/sWoSgZuffTZAYqrnzs7M7CNX6sgqsNrV2R
SQJ/moNMhPnj2pv7FaV9Tz226XCRb9Lqy8BDDkVePDV9biqJc0oTRREVWmJtFdKQ
o+5gt7v5BJt3LNnJKsE2PY+j4HmX+WB3et4VhxKWFis4rVjpBEm9ZSDVcu+AEPgM
cg3tO6I1KvJXBZN6RNWDLfZWRJSEQLIJMyienZfF56OMQDda0RRtBe9Vx2UTLQ3h
XfEKVGsDLprQo3t1ZxIxe0dmPZbb6nj3YWlpeWEw0pLrmJOWtqUV4YamvKo39v+1
jjzKmeVodo0eX/BCldfG7UzmwclOEvbmz7PmVTTcuNB+Pnu24W6zsvjNYewh9eAX
jaVnEnQsE5vxfMjZcYSvW2ZcbS/RFq07MW3WoCBfMaZxDMoSuGRrWYBalkduv4/s
1Kf63SO2s6Q7pIh2J16WQCGlmLhcJoeCfOuWrRI8nSKYypfU1pY=
=r9eC
-----END PGP SIGNATURE-----
--=-=-=--
