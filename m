Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F6C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4137B2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4137B2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeKUIFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:05:18 -0500
Received: from anholt.net ([50.246.234.109]:52614 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbeKUIFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:05:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DB72610A15B1;
        Tue, 20 Nov 2018 13:34:05 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ZRdAyeA9lA9h; Tue, 20 Nov 2018 13:34:04 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9781910A0396;
        Tue, 20 Nov 2018 13:34:04 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 145342FE1FE6; Tue, 20 Nov 2018 13:34:04 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 0/8] BCM2835 PM driver
In-Reply-To: <1299453058.112996.1542736171394@email.ionos.de>
References: <20181120172000.15102-1-eric@anholt.net> <1299453058.112996.1542736171394@email.ionos.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 20 Nov 2018 13:34:03 -0800
Message-ID: <87o9aj77sk.fsf@anholt.net>
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
>> Eric Anholt <eric@anholt.net> hat am 20. November 2018 um 18:19 geschrie=
ben:
>>=20
>>=20
>> This series moves the BCM2835 WDT driver that controls a fraction of
>> the PM block out to soc/ and adds most of the rest of its
>> functionality.  My motivation has been to have V3D be functional
>> without firmware calls, probably improve its interactivity (since
>> we'll be able to power on/off without RPC to the firmware that may be
>> busy with other tasks), and (in a patch not submitted in this series)
>> extend its binding to use the reset controller instead of trying to
>> reset by toggling its power domain.
>>=20
>> I've tested V3D with a few hours of running a V3D test, sleep(1) (to
>> trigger PM domain off); running a GPU hang job (to trigger reset);
>> sleep(1).  The non-hanging success-case job always passed, and dmesg
>> had no complaints from bcm2835-pm.  The other power domains are not
>> tested, but I've done my best.
>>=20
>> This series will probably also be of interest to the
>> https://github.com/christinaa/rpi-open-firmware project for enabling USB.
>>=20
>
> apologize to give you my feedback after you send out the series.
>
> I know you won't be happy about it, but i think we need a little more
> complex but future proof solution for this power driver. According to
> the register definition of the PM block, we have multiple functions
> here (power domains, watchdog, pads/pinctrl, ...). Since this is
> common for ARM SoCs there is a subsystem called mfd (multi function
> device) [1] to abstract all resources of the IP block.
>
> This has the advantage that we don't need a monolithic driver which
> takes care of all functions.

I consider your "advantage" to be a disadvantage.  By forcing the split,
you end up having more driver files to manage, more platform devices,
and more error-prone code to get the resources from the parent down into
the client.  It feels like writing software for the sake of writing
software, rather than solving a concrete problem.

My original series:

 10 files changed, 951 insertions(+), 273 deletions(-)

The MFD series:

 12 files changed, 882 insertions(+), 25 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlv0fcsACgkQtdYpNtH8
nuhtnA/9Gb7dE1/tAPnRIwQSyv9Tmo2ZshqHyZLW6c6vfC0BFKOUT84RzXbFYJZG
QlNJHW3e1I3OjqRvDkt8MqilpmG8n7vJxQFpPvWzeXYynNRR6WGwlzClNwtkX70c
BFmEqfuKZ7WzorUkcLvmBSShH/EbRyz+BPzhpLl6N/3/iv5lJBLSRc0Djg9+FUSN
TEiYLA/RgzfQozowv69Q46F40RmEpcoR4FH7TJQqmodaMn79A7Ti/4nhJdrayTir
hHF0476vZTkSktRaL6Tv6RKOCCQNUSlDpfu2zG6dMhtTuPJjSdHLgjRtSnEE1cLP
y1Fqp13spoZdzQgUc9u1Ka5Unm9LmKjdPNM+oBlsXstGhziZSklNL65nKvd9TESk
BPtRmPtdN05gLcEJ9wpLc0KsoCHKdZKGuXZHoyalGZBDJ9HeHK/iP6zaXXTg2fqh
ulpMeht+aTMUAjs8wUisykDkjbw8J4FThyBMf4nlQF9TpD4HYw75+fP74HnS2X7e
OokRG80Ecap8cRVnsl+o69pZJwAhn1LSAsCGR9X8m2FC8YMF8pyDtCAvjQDAGYCZ
kPzrPv3uNi954baPkQcFYJiv2AtzWVbWT3vXwFSMDh8tuKQBgwkdmdxnKZ/qbJJQ
awlFooEpyKf9fp9J8TzjbprEyT+anEama+triXKopjae0jIjX2U=
=Rn7A
-----END PGP SIGNATURE-----
--=-=-=--
