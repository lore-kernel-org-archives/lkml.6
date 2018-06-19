Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47416C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E619A2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jBNMa07T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E619A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755582AbeFSGjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:39:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:15954 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbeFSGjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529390385;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6su3TgDBoT2iYdZEWkZhLkrV+OeqEhAE+p9uxsLAUZg=;
        b=jBNMa07TWffVvxqMmXyfBBezmQ53/oUP7Q9lv6g2zJWz0q0sfGtWeqb7Vsp/IlUDAK
        TLmQQHK6UZ3TdGEbw9JrRakylynSYX8ZF5bWcX+PI75y04w0bLCSfkZpxFB+6ZGcOajm
        MLAL+q9t177oEyV6fG+cK21UCnaN7dp8I5piJ3rizLf7qR+UofRQcey6w2w3mIvOjY+9
        0ibaOcbc5zyVYtDlzIr6cI77jIV+dJCUUbUxJaMyXV8JmrurFZzYpYML4PHKipcC6gxi
        6wZWUoahmUuV4jtBDAHaMV7ha1mLk3L5ZEXHA4ktaaS69be+YSePjBkx/bavNLvgcpBX
        kMKg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdN1FjmY"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5J6daHgv
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 19 Jun 2018 08:39:36 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180619061102.GU112168@atomide.com>
Date:   Tue, 19 Jun 2018 08:39:35 +0200
Cc:     Christ van Willegen <cvwillegen@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4435BD7A-AE0D-45A5-9D6A-277175ABE489@goldelico.com>
References: <20180618091433.GP112168@atomide.com> <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com> <20180618095428.GQ112168@atomide.com> <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com> <20180618115122.GT26255@atomide.com> <CDD8B994-59E9-42DC-A77D-AF4F35EBF101@goldelico.com> <20180618181744.GS112168@atomide.com> <404C63D9-169E-4051-88E0-2856F3602A72@goldelico.com> <20180619043408.GT112168@atomide.com> <631A1D2F-093A-498F-8923-FC9CD20E11A8@goldelico.com> <20180619061102.GU112168@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 19.06.2018 um 08:11 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [180619 04:54]:
>>>> I had seen the call sequence
>>>>=20
>>>>=20
>>>>=20
>>>> w/o any lock inside.
>=20
> So the sequence above has mutex added around adding the pin
> controller specific functions and groups by the patch series
> I posted for both pcs_parse_bits_in_pinctrl_entry() and
> pcs_parse_one_pinctrl_entry(). So I think the above should
> be fixed now. But please confirm to make sure I'm not mistaken.

Ah, now I see.

My dump_stack() added to pinctrl_generic_add_group() reported

[    6.155487] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    6.162048] [<c01106ec>] (unwind_backtrace) from [<c010c058>] =
(show_stack+0x10/0x14)
[    6.170166] [<c010c058>] (show_stack) from [<c074bc28>] =
(dump_stack+0x7c/0x9c)
[    6.177734] [<c074bc28>] (dump_stack) from [<c042bbec>] =
(pinctrl_generic_add_group+0x48/0x90)
[    6.186614] [<c042bbec>] (pinctrl_generic_add_group) from =
[<c043203c>] (pcs_dt_node_to_map+0x4b0/0x81c)
[    6.196441] [<c043203c>] (pcs_dt_node_to_map) from [<c042ffd4>] =
(pinctrl_dt_to_map+0x1ec/0x2b8)
[    6.205535] [<c042ffd4>] (pinctrl_dt_to_map) from [<c042d028>] =
(create_pinctrl+0x58/0x2f8)
[    6.214141] [<c042d028>] (create_pinctrl) from [<c042d388>] =
(devm_pinctrl_get+0x2c/0x6c)
[    6.222625] [<c042d388>] (devm_pinctrl_get) from [<c04f2e9c>] =
(pinctrl_bind_pins+0x3c/0x138)
[    6.231445] [<c04f2e9c>] (pinctrl_bind_pins) from [<c04d3eb8>] =
(driver_probe_device+0xe8/0x318)
[    6.240509] [<c04d3eb8>] (driver_probe_device) from [<c04d4168>] =
(__driver_attach+0x80/0xa4)
[    6.249328] [<c04d4168>] (__driver_attach) from [<c04d264c>] =
(bus_for_each_dev+0x58/0x7c)

Apparently I didn't notice that pcs_parse_*_pinctrl_entry() are called
inside pcs_dt_node_to_map() and are part of the call sequence.

Hence your new mutex locks calls to pinctrl_generic_add_group() as
needed.

Obviously, the compiler has optimized away the nested calls to static
functions and I had no previous experience with how the whole pinctrl =
code
works (learning by debugging :).

So it looks sane and no need for further locks.

BR and thanks,
Nikolaus

