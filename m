Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AB92151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0rzE2JKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AB92151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJQPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeJQPWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:22:39 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E359D2151D;
        Wed, 17 Oct 2018 07:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539761299;
        bh=W6x5JRvHd9CwWDYeQh25O+q4n4MqnjaAVACdOieQUBA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0rzE2JKA89GyY3DY7lUckCBp0ZgB7vYIez/XDEMP0LV3RD2D+lLS9NSe0IlJhE8Ud
         0mBYHRP4p35W/9P1kHfnb+YUNOqW7x4CpcQDqrjHmtu3kbz8r/JKMu4Jb6KAuxqnhN
         ZCxYkO3UiTfAa9lUiSb8oUJ4UtiN68uoyfrhE8ro=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sodagudi Prasad <psodagud@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <91594b8e6578d542dc7cbebf34458b0c@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <9aec322678417753fe4022691f4bfdbe@codeaurora.org>
 <153897864285.119890.13024399324598460044@swboyd.mtv.corp.google.com>
 <5848ff92c1388b7d6904e88b57bbfec8@codeaurora.org>
 <91594b8e6578d542dc7cbebf34458b0c@codeaurora.org>
Message-ID: <153976129822.5275.14566790707614483813@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: protected pins and debugfs
Date:   Wed, 17 Oct 2018 00:28:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sodagudi Prasad (2018-10-16 19:00:45)
> On 2018-10-10 12:40, Sodagudi Prasad wrote:
> > On 2018-10-07 23:04, Stephen Boyd wrote:
> >> Quoting Sodagudi Prasad (2018-10-03 05:38:24)
> >>> =

> >>>          for (i =3D 0; i < chip->ngpio; i++, gpio++) {
> >>> +               label =3D gpiochip_is_requested(chip, i);
> >>> +               if (!label)
> >>> +                       continue;
> >>>                  msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
> >>> -               seq_puts(s, "\n");
> >>>          }
> >>>   }
> >>> =

> >> =

> >> Does something not work with the following code in
> >> msm_gpio_dbg_show_one()?
> >> =

> >> =

> >>         if (!gpiochip_line_is_valid(chip, offset))
> >>              return;
> > =

> > Hi Stephen,
> > I didnt realize that these changes are merged on tip. I was testing on
> > 4.14 kernel.
> > =

> > https://lore.kernel.org/patchwork/patch/878107/
> > https://lore.kernel.org/patchwork/patch/878106/
> > https://lore.kernel.org/patchwork/patch/878109/
> =

> =

> Hi Stephen,
> =

> After checking this further, adding "gpio-reserved-ranges" in not good =

> option. Because of the following reasons.
> 1) These gpio information changes from platform to platform. So need to =

> maintain reserved-range properly for each platform.

This was known. The best approach was to populate this based on what the
firmware chooses to lock down, which didn't seem to change very often
from what I recall being told.

> 2) Also some of the gpio can be changed to secure/protected gpio =

> dynamically based on the use case.

This is new information. How exactly do these pins change dynamically?
Perhaps gpiolib needs to gain more support for the mask to change at
runtime instead of being populated once at boot time from DT.  Seems
like a patch could be written for gpiolib to handle that if it really is
something that needs to be done.

> =

> It looks adding the "gpio-reserved-ranges" ranges is not good option for =

> most of the platforms.
> =

> Can you please check the initial patch suggested in this thread? Please =

> let me know if you have any other options for the above points.
> =


The initial patch in this thread takes a Qualcomm centric approach to
the problem, which probably works just fine, but we would like to push
the solution to problem into the core framework so that other SoCs can
benefit from common code. Please look into handling the runtime swapping
in the gpiolib core so that we don't have a one-off solution for
Qualcomm here.

