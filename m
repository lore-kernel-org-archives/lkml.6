Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E363EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC7420644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXd2UJ+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC7420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJCWop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:44:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39867 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJCWoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:44:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so5986310wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1dGS1NALP+2OX5gaLTHaQH87HUaSgs9arqA+sQaP0xc=;
        b=IXd2UJ+J4qVPoQrxkAPpeEjK1nVyGIF2qDVbrpao/rrG24hsMTuBIxcJr/bqkQnpsl
         yLXcgC3EkWpqvbCnwnCdevnC+HG+2old8rvnvbVivG/AbCv8fA2HTPXKsYzSUBiJAkP0
         5ddY/LkN9B8tmMDCWRDhnZIvTGtWf1WEZQDcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1dGS1NALP+2OX5gaLTHaQH87HUaSgs9arqA+sQaP0xc=;
        b=V5iwkemRFo7QqAzxyednxNfxmKTnCdKdi6lFwmrFz/LFy70ssjwEB6tn2UhTYL4vfd
         esX5eykf8dKZo0cRF743SWU6WYYFMraCYEt/rvhKXtYjZp0OkfZbJ/w3cjf0eADMzvau
         B08OW7sZajoZxLZKjHVDwUYAG/4bJfQJJxo1GVnXru0N5SpkketQE3mXfHEVvRTHMR4L
         USIb6eGM/RRmy5KrYCf6xMS9egB20uCAASqmHA+Mfcz2mKpILYi2Vyj1Rqu6PzwUmT7/
         JYwpCzVGYpRCZOTNbaYlZ4NBWGyDOyMKCwXd5Dz44pHULegj7RI6FgDz6wQg7SMXpJHg
         uPWA==
X-Gm-Message-State: ABuFfoigLBvtOrnTGpi0pOQJ2DJjx2KF3rBsw/we5b41Lf6PNpAXaNpb
        GSpzDNq95vMtxxmbdOQky7OwOw==
X-Google-Smtp-Source: ACcGV61Y1DvDx5Dyfoea/tGs6ESN7cjbwdt7JVn3v5fbk4pGoum3qqlA02K2MXWKmuWVJNVlw11SDg==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13-v6mr1667028wrt.120.1538582144517;
        Wed, 03 Oct 2018 08:55:44 -0700 (PDT)
Received: from [192.168.43.112] ([31.157.182.99])
        by smtp.gmail.com with ESMTPSA id x16-v6sm991380wro.84.2018.10.03.08.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:55:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
Date:   Wed, 3 Oct 2018 17:55:41 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 03 ott 2018, alle ore 13:49, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hi.
>=20
> On 03.10.2018 08:29, Paolo Valente wrote:
>> As also Linus Torvalds complained [1], people feel lost among
>> I/O-scheduler options.  Actual differences across I/O schedulers are
>> basically obscure to non experts.  In this respect, Linux-kernel
>> 'users' are way more than a few top-level distros that can afford a
>> strong performance team, and that, basing on the input of such a =
team,
>> might venture light-heartedly to change a critical component like an
>> I/O scheduler.  Plus, as Linus Walleij pointed out, some users simply
>> are not distros that use udev.
>=20
> I feel a contradiction in this counter-argument. On one hand, there =
are lots of, let's call them, home users, that use major distributions =
with udev, so the distribution maintainers can reasonably decide which =
scheduler to use for which type of device based on the udev rule and =
common sense provided via Documentation/ by linux-block devs. Moreover, =
most likely, those rules should be similar or the same across all the =
major distros and available via some (systemd?) upstream.
>=20

Let me basically repeat Mark's answer here, with my words.

Unfortunately, facts mismatch with your optimistic view: after so many
years and concordant test results, only very few distributions
switched to bfq, no major distribution did (AFAIK).  As I already
wrote, the reason is the one pointed out by Torvalds [1].  Do you want
a simple example?  Take the last sentence in Jan's email in this
thread: "I *personally would* consider bfq a safer default ...  but *I
don't feel too strongly* about it." And he is definitely a storage
expert.

The problem, in particular, is that bfq is a complex beast, fighting
against a jungle of I/O issues.  You have to be really into bfq, even
to just know all of its features!

> On another hand, the users of embedded devices, mentioned by Linus, =
should already know what scheduler to choose because dealing with =
embedded world assumes the person can decide this on their own, or with =
the help of abovementioned udev scripts and/or Documentation/ as a =
reference point.
>=20

Same situation for embedded devices, if not even worse.  Again for the
same reasons above.  In the end, it is hard even for a kernel expert
to be an in-depth expert of every possible complex component.

> So I see no obstacles here, and the choice to rely on udev by default =
sounds reasonable.
>=20
> The question that remain is whether it is really important to mount a =
root partition while already using some specific scheduler? Why it =
cannot be done with "none", for instance?
>=20
>> So, probably 99% of Linux-kernel users will just stick to the default
>> I/O scheduler, mq-deadline, assuming that the algorithm by which that
>> scheduler was chosen was not "pick the scheduler with the longest
>> name", but "pick the best scheduler for most cases".  The problem is
>> that, for single-queue devices with a speed below 400/500 KIOPS, the
>> default scheduler is apparently incomparably worse than bfq in terms
>> of responsiveness and latency for time-sensitive applications [2], =
and
>> in terms of throughput reached while controlling I/O [3].  And, in =
all
>> other tests ran so far, by any entity or group I'm aware of, bfq
>> results basically on par with or better than mq-deadline.
>=20
> And that's why major distributions are likely to default to BFQ via =
udev. No one argues with BFQ superiority here =E2=98=BA.
>=20
>> So, I do understand your need for conservativeness, but, after so =
much
>> evidence on single-queue devices, and so many years! :), what's the
>> point in keeping Linux worse for virtually everybody, by default?
>=20
> =46rom my point of view this is not a conservative approach at all. On =
contrary, offloading decisions to userspace aligns pretty well with =
recent trends like pressure metrics/userspace OOM killer, eBPF etc. The =
less unnecessary logic the kernel handles, the more flexibility it =
affords.
>=20

To not answer too seriously here, let me answer with a quote that is
still missing a clear paternity: "Everything should be made as simple
as possible, but not simpler." :)

Thanks,
Paolo

> --=20
>  Oleksandr Natalenko (post-factum)

