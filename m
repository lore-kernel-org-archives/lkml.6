Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CE78FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73406208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="nUhDczoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73406208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965772AbeFOLSh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:18:37 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:29578 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965635AbeFOLSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529061511;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=us0IcibdIYqD1PcP0OYHAtDCRvr6D+YQWKZZ3VaqBDc=;
        b=nUhDczoW63/pgexqes+peOZVvhC8KNVG1BGTgAhJP/ylP8skD1PHnkl8rgolwauIgo
        tQ8q4/T5tmA6EOLrX5ILe9w7bm9FEoFi9eEEo/LxjenlE8kzK19GAEW9XOY4XBZbZ10Z
        nQniyyI2qJxThbhnHLygFfxi27xb6Tpr8OMK8i4diIflE8avUtcpzjLy1XbCy72Jyh53
        EKDq8OXKRJV3jiLAGO05O0yGXU9VIGOE3xKqePy/TD4iX7PYK/fit7nADrX1txe75hzq
        ycwH4qWQWjdpcD56lpreN6fiAEy4yn3JDGcSu9BhJQE+yk7oPHXw4CKlC8GVzZWDeLp4
        vLLw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdN3GFM="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5FBIS3vA
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 15 Jun 2018 13:18:28 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180615111318.GJ112168@atomide.com>
Date:   Fri, 15 Jun 2018 13:18:27 +0200
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com>
References: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com> <20180614120157.GE112168@atomide.com> <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com> <20180615065810.GI112168@atomide.com> <20180615111318.GJ112168@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 15.06.2018 um 13:13 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * Tony Lindgren <tony@atomide.com> [180615 07:00]:
>> * H. Nikolaus Schaller <hns@goldelico.com> [180614 12:15]:
>>> Hi Tony,
>>>=20
>>>> Am 14.06.2018 um 14:01 schrieb Tony Lindgren <tony@atomide.com>:
>>>>=20
>>>> * H. Nikolaus Schaller <hns@goldelico.com> [180613 12:41]:
>>>>>=20
>>>>> Now if I look into pinctrl_generic_add_group() and =
pinctrl_generic_get_group_name(),
>>>>> pctldev->num_groups++ is not protected if =
pinctrl_generic_add_group() may be called by
>>>>> two threads in parallel for the same pctldev. Hence a second =
thread may try to insert
>>>>> a different node into the radix tree at the same selector index. =
This fails but there
>>>>> is no error check - and the second entry is completely missing =
(but probably assumed to
>>>>> be there).
>>>>=20
>>>> Sounds like pinctrl-single.c is missing mutex around calls to
>>>> pinctrl_generic_add_group()?
>>>=20
>>> Yes, that could be. I didn't research the call path, just the one of
>>> devm_pinctrl_get(). That uses a mutex in
>>=20
>> In addition to missing mutex lock around the generic pinctrl =
functions
>> we also have racy helpers pinctrl_generic_remove_last_group() and
>> pinmux_generic_remove_last_function() like you pointed out. I'll post
>> a patch for you later on today to test.
>=20
> OK I posted a series to fix these issues hopefully as thread
> "[PATCH 0/5] pinctrl fixes for generic functions and groups".

Fine, I have located them.

>=20
> Can you please test and see if that is enough to fix the issues
> you're seeing?

Yes, I'll try asap.

BR and thanks,
Nikolaus

