Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53024C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E17020652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="TY6mbWU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E17020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965644AbeFRKAF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:00:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:12375 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965561AbeFRKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529316000;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=U8r0nHlSYkEDACHu+qVMPtj8IF3PB4pqd5PeG89+KX4=;
        b=TY6mbWU/6EEKhv8VCZoLeOSGk9bXhHi732aMrLuMTqFBgN0Dv5KRUzPvRBaNViVnJf
        Vp8TEKFQERA84/l4OrRwLyJFzJL2J0Xevf3JJiQ/i7ZWX84mXc4wqjnVwDSUXrfmt0wY
        mn0TcXBewScbonU4ThvSxuyn3L1C37tjfNiif/uy4YapVl7i6lEc9xRoxnuD2+T258ww
        izDoJTaW30/4pOLlQ1T/4o6HW99fDKsvGgQ8C/ksV10+MMQtILBwgC/5+mkMf2McNof8
        sFiFBtybOUO+hmg32L4wjmwDWnREk2J7M2UTSG2uDjDNF5NPhr3qGVBZjR8m9xcHwdrA
        2pHw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBi5Qpz9LpBMKeNaHMi3fA="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5I9xtD8Z
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Jun 2018 11:59:55 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180618095428.GQ112168@atomide.com>
Date:   Mon, 18 Jun 2018 11:59:53 +0200
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8867175-055F-47EB-A635-73038AEFA0AF@goldelico.com>
References: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com> <20180614120157.GE112168@atomide.com> <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com> <20180615065810.GI112168@atomide.com> <20180615111318.GJ112168@atomide.com> <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com> <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com> <CAHp75Vf7-xcsoSJ--9nJYbxpwSfDv201UwnxJHoFbwtD187SPw@mail.gmail.com> <20180618091433.GP112168@atomide.com> <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com> <20180618095428.GQ112168@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 18.06.2018 um 11:54 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [180618 09:32]:
>>=20
>>> Am 18.06.2018 um 11:14 schrieb Tony Lindgren <tony@atomide.com>:
>>>=20
>>> * Andy Shevchenko <andy.shevchenko@gmail.com> [180618 08:25]:
>>>> On Sat, Jun 16, 2018 at 2:08 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>>> But it looks as if we still have duplicate assignments by deferred =
probing, i.e. some cleanup is
>>>>> missing (or is this intended behaviour?).
>>>>=20
>>>>> But I think the fundamental problem is that the same driver =
assigns multiple slots if
>>>>> probing is deferred.
>>>>=20
>>>> Indeed.
>>>>=20
>>>> I think there is a simple way to clean up pinctrl stuff on failed =
probe. See
>>>> =
https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/base/dd.c#L416
>>>>=20
>>>> We only bind pins, and do not perform any actions when failure =
happens later on.
>>>=20
>>> Yup seems like a good approach. I'll take a look if we can just
>>> check if the function or group name already exists and return
>>> the existing selector in that case.
>>=20
>> Ok, that would also solve the duplication issue.
>=20
> Below is an incremental patch to check for existing entries.

Thanks!

> Care
> to test again?

Yes, asap. It is the most critical bug I currently know for all our OMAP
devices...

>=20
> If that works, I'll fold it into the patch series and repost the
> whole series.
>=20
>> On the other hand we still have a stale entry if the probing process
>> finally fails after several attempts.
>>=20
>> This may happen if a driver with a valid DT entry is blacklisted in
>> /etc/modprobe.d/blacklist.conf. Then, the kernel will try to modprobe
>> it several times through udev until it gives up. The reason seems to
>> be that the deferred probing thread does not know why the driver did
>> not probe successfully.
>=20
> Hmm I think this might be fixed then too. Then on pinctrl module
> unbind/unload we should free the radix tree entries if that is
> not yet done. Seems we may only free them on -ENOMEM right now.

Yes, that could do proper cleanup.

I think all the issues were introduced by deferred probing and the
pinctrl code is safe if that does not exist... So we probably should
think about backporting to stable. But let's test it outside the
trees and have it mature in linux-next for a while.

BR and thanks,
Nikolaus

