Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9D3C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8427020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="cEzj8ERz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8427020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965947AbeFRJ3n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:29:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:17751 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965795AbeFRJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529314175;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=H0E3ZocxlplOSMipf87iLjMSJYBycfQmrfHDfDwvSO0=;
        b=cEzj8ERzFq/4NzJsxZIjoU8XKPRV/dZsgeiYEo56/nh032mGJ8BtS34r7LmefclIDV
        GbwQ3L/Qj2FsorUfQlO87VwsLlSuMxNx5PnCDOXKX/HJX8afcrITimYFqdO9t2Vpvyy6
        TgY4pDb4nV+fdBA8w5bYUukExaQJn/5UBvnzDz31rDhArrpywt5O0fuHQszizRLi2E9b
        mX1MmoXlttrMZ3xXciuf54HI0jX11bbJmTPwfXA/jo0cEwUQkqcjv+mnNekva9gcKclc
        0TehFEvob6X60qKFTYRkrGydWNJYGP+lHTCYMZQ9HqW8vC/Yp7Jj8IXQiPW5OciWnGgn
        27bg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qEjr9Tw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5I9TVCtI
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Jun 2018 11:29:31 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180618091433.GP112168@atomide.com>
Date:   Mon, 18 Jun 2018 11:29:30 +0200
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com>
References: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com> <20180614120157.GE112168@atomide.com> <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com> <20180615065810.GI112168@atomide.com> <20180615111318.GJ112168@atomide.com> <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com> <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com> <CAHp75Vf7-xcsoSJ--9nJYbxpwSfDv201UwnxJHoFbwtD187SPw@mail.gmail.com> <20180618091433.GP112168@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 18.06.2018 um 11:14 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * Andy Shevchenko <andy.shevchenko@gmail.com> [180618 08:25]:
>> On Sat, Jun 16, 2018 at 2:08 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>> But it looks as if we still have duplicate assignments by deferred =
probing, i.e. some cleanup is
>>> missing (or is this intended behaviour?).
>>=20
>>> But I think the fundamental problem is that the same driver assigns =
multiple slots if
>>> probing is deferred.
>>=20
>> Indeed.
>>=20
>> I think there is a simple way to clean up pinctrl stuff on failed =
probe. See
>> =
https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/base/dd.c#L416
>>=20
>> We only bind pins, and do not perform any actions when failure =
happens later on.
>=20
> Yup seems like a good approach. I'll take a look if we can just
> check if the function or group name already exists and return
> the existing selector in that case.

Ok, that would also solve the duplication issue.

On the other hand we still have a stale entry if the probing process
finally fails after several attempts.

This may happen if a driver with a valid DT entry is blacklisted in
/etc/modprobe.d/blacklist.conf. Then, the kernel will try to modprobe
it several times through udev until it gives up. The reason seems to
be that the deferred probing thread does not know why the driver did
not probe successfully.

BR and thanks,
Nikolaus

>=20
> Regards,
>=20
> Tony

