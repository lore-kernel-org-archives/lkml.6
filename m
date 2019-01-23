Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83775C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECE3217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mKL7qPey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAWR0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:26:18 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35228 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548264374; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8HbjGDteo+6JpL2EkbWp1H5bMYz35iLdatBc+j8QCQ=;
        b=mKL7qPeyAvviLaEFk/hlLBWyJB1mexdKWJnESSOtbBglRiNMPJznFe0yTvYny9fz9JE4ZK
        cCO6vaVKJUHtkXkylOWPKgxr7Zmewuo4H8mazsg2PGuMUmFhr+jfx6FSwz/N0Qc4V4EPll
        DqOowrshKf5MK99IJEDb91WF+xptKM0=
Date:   Wed, 23 Jan 2019 14:25:53 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me,
        Maarten ter Huurne <maarten@treewalker.org>
Message-Id: <1548264353.3173.1@crapouillou.net>
In-Reply-To: <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-6-paul@crapouillou.net>
        <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
        <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer. 23 janv. 2019 =E0 11:31, Guenter Roeck <linux@roeck-us.net> a=20
=E9crit :
> On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
>> On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil=20
>> <paul@crapouillou.net> wrote:
>>>=20
>>> From: Maarten ter Huurne <maarten@treewalker.org>
>>>=20
>>> OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>>>=20
>>> SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
>>> JZ4780 have a 64-bit OST.
>>>=20
>>> This driver will register both a clocksource and a sched_clock to=20
>>> the
>>> system.
>>>=20
>>> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>=20
>>> Notes:
>>>       v5: New patch
>>>=20
>>>       v6: - Get rid of SoC IDs; pass pointer to=20
>>> ingenic_ost_soc_info as
>>>             devicetree match data instead.
>>>           - Use device_get_match_data() instead of the of_* variant
>>>           - Handle error of dev_get_regmap() properly
>>>=20
>>>       v7: Fix section mismatch by using=20
>>> builtin_platform_driver_probe()
>>>=20
>>>       v8: builtin_platform_driver_probe() does not work anymore in
>>>           4.20-rc6? The probe function won't be called. Work around=20
>>> this
>>>           for now by using late_initcall.
>>>=20
>=20
> Did anyone notice this ? Either something is wrong with the driver, or
> with the kernel core. Hacking around it seems like the worst possible
> "solution".

I can confirm it still happens on 5.0-rc3.

Just to explain what I'm doing:

My ingenic-timer driver probes with builtin_platform_driver_probe (this=20
works),
and then calls of_platform_populate to probe its children. This driver,
ingenic-ost, is one of them, and will fail to probe with
builtin_platform_driver_probe.

-Paul
=

