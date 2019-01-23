Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EB3C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA6C21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgi+EmlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfAWSCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:02:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32783 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:02:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so1563730pfb.0;
        Wed, 23 Jan 2019 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GbS/bw1Q1LNpVWE4WkzTusWZU78c0yUUx2ltlSTZJ1g=;
        b=mgi+EmlEekcISk+dKlOgEB60/d3g+xVxn3Rnm5+K8DwbHdX1phVsdsjqYdpT4zN9Ke
         t0y6cG+RefMrUmvrSxCYx86+xZL+ZNUnIKQPc48NeO5/0D8AHKggaM0NvI4Xxg7UkhUk
         GtkeRfcRd4jHpb4peb3xuOJ+Dt2G21H0FrBbrHiY3hI1A64ZenPzhoaPB48z75XNEDAY
         p+KuSz8MUtxFz1RqqvNcJhopklJ3+dn/GNZuvTI6lj7hkhiIE5m/RHqeHSlGhU7BEFX9
         GbIhPjB271ungELjzhfOotFh4fZfT9lcvUPJZU6DuGAJ/CG2b1VJd4ADWSUAZ7eeHZyR
         KgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GbS/bw1Q1LNpVWE4WkzTusWZU78c0yUUx2ltlSTZJ1g=;
        b=mccSMa05hspZX6mn7l0r1OIW6LZWVOLChyQC/tJfosZJKwEcwogngL7ideX0f9IMvT
         DgCFtkS25MRg47uOhyWCo1ZcZQU9d/No4u+wgsnEasLmVzOX6O/Xr34k7Vzl1hEuzwNe
         JDFS07vJ0a7jI8SeEkmC+mNJdcn/8kBsa+GGJIae78b5s26jfWsFirn5HPQWKq8TOx2W
         jTxzmTXMBGsR3ESqJJetWJZH0NERs1a4Uo5nos4YA7PEoTULkhFZAYiq1czYzbJlp1Ev
         nybsRSS+q159oK2eeRQV9GNbuX53jy6JElWLfuBKS6VSrU/YaS9gUTfONrREr1Hvf19i
         zsOQ==
X-Gm-Message-State: AJcUukcbng6q0gglNiTJo6lRpEFTN5DL5zzU6if/vjyQsaULXdgMUY7p
        A+YL03tddw3jK+8yluM45z2vwhDATdQ=
X-Google-Smtp-Source: ALg8bN6DpZ3VpwhnNT4m9Z/RS4eaFfVgqszbVMmDgu/9GCIh3gQKr/kbRBpUXJvwF2656T3cNPxW2Q==
X-Received: by 2002:a62:1a91:: with SMTP id a139mr3054735pfa.64.1548266518787;
        Wed, 23 Jan 2019 10:01:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u70sm40602011pfa.176.2019.01.23.10.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 10:01:57 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:01:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
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
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
Message-ID: <20190123180155.GB9781@roeck-us.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-6-paul@crapouillou.net>
 <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
 <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
 <1548264353.3173.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548264353.3173.1@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:25:53PM -0300, Paul Cercueil wrote:
> Hi,
> 
> Le mer. 23 janv. 2019 à 11:31, Guenter Roeck <linux@roeck-us.net> a écrit :
> >On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
> >>On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net>
> >>wrote:
> >>>
> >>>From: Maarten ter Huurne <maarten@treewalker.org>
> >>>
> >>>OST is the OS Timer, a 64-bit timer/counter with buffered reading.
> >>>
> >>>SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
> >>>JZ4780 have a 64-bit OST.
> >>>
> >>>This driver will register both a clocksource and a sched_clock to the
> >>>system.
> >>>
> >>>Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> >>>Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>>---
> >>>
> >>>Notes:
> >>>      v5: New patch
> >>>
> >>>      v6: - Get rid of SoC IDs; pass pointer to ingenic_ost_soc_info
> >>>as
> >>>            devicetree match data instead.
> >>>          - Use device_get_match_data() instead of the of_* variant
> >>>          - Handle error of dev_get_regmap() properly
> >>>
> >>>      v7: Fix section mismatch by using
> >>>builtin_platform_driver_probe()
> >>>
> >>>      v8: builtin_platform_driver_probe() does not work anymore in
> >>>          4.20-rc6? The probe function won't be called. Work around
> >>>this
> >>>          for now by using late_initcall.
> >>>
> >
> >Did anyone notice this ? Either something is wrong with the driver, or
> >with the kernel core. Hacking around it seems like the worst possible
> >"solution".
> 
> I can confirm it still happens on 5.0-rc3.
> 
> Just to explain what I'm doing:
> 
> My ingenic-timer driver probes with builtin_platform_driver_probe (this
> works),
> and then calls of_platform_populate to probe its children. This driver,
> ingenic-ost, is one of them, and will fail to probe with
> builtin_platform_driver_probe.
> 

The big question is _why_ it fails to probe.

Guenter
