Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9CEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12B920837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UFBJe0u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12B920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeHaSr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:47:58 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:58744 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeHaSr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:47:58 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7VEe1Zx029317;
        Fri, 31 Aug 2018 23:40:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7VEe1Zx029317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535726402;
        bh=XW1a5KoeCokq/PtEBH2hvT7oYoNis3uotFLSjo6cj+8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=UFBJe0u8cbWbMQXAVFdso/GbFkFxRE0JmbMHpb70hIK6DxTDI3nSI0wW6ui90Eavq
         6ObLlsPQobPnm0TC4TK6wtf2qUAP+k+eASPkIvFA06kzjS0Zp9PuZ7fZ5wCoDNbYSm
         FzHIddhvevyVrjsjK+fmr3tTnmkWX1VWkN5KAhXgf0dTanSqldKhOqjklCYe++g0nK
         xrjEcgYpySj4kXgdFgQ7rjupdX0xte5yFAW3tbp965CQulNOW/D6btGsEJTFy7Qqpg
         X9wudKQazpk5yDEzBohWTMxK3GPMWdtOvRTCI+OMkR3GqXQu36XiM4Ei2DXe7aZFJ4
         /wtBTbgx9uzjA==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id w193-v6so5555781vke.2;
        Fri, 31 Aug 2018 07:40:02 -0700 (PDT)
X-Gm-Message-State: APzg51CGFKGLICncyn9zTbJPWT6K1xiX3yBFlBHE6dxKOEZ/pZWmUy65
        Rj5lA/FcJI7xsnyiCUOv/QBwohvNK8tO8jbH2M8=
X-Google-Smtp-Source: ANB0VdYm/auH/3Hh0T4tyf4dWQ5xdwjhoeHD+6UYkC8IGtwKZhTKdjPHlpDI4cNw26WUe1lBP10/hx5i4NTeR+SVHNM=
X-Received: by 2002:a1f:5347:: with SMTP id h68-v6mr967643vkb.141.1535726400881;
 Fri, 31 Aug 2018 07:40:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5155:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 07:39:20
 -0700 (PDT)
In-Reply-To: <20180831095356.ow6nhbx2fhhpuhjj@ninjato>
References: <CAK7LNAQO2aYLrtzg82jgKdKcOw20rNWBEY3DrdLcwOhnF9aa3A@mail.gmail.com>
 <20180831095356.ow6nhbx2fhhpuhjj@ninjato>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 31 Aug 2018 23:39:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQyUa=uDD-vTe32XfHAueqdVtVZP_+imL2-Kh9BeFCG1A@mail.gmail.com>
Message-ID: <CAK7LNAQyUa=uDD-vTe32XfHAueqdVtVZP_+imL2-Kh9BeFCG1A@mail.gmail.com>
Subject: Re: [Question] When should a driver issue STOP condition?
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,


2018-08-31 18:53 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> The problem is, my driver is forcibly setting
>> STOP condition unless the next message is read.
>
> This likely is a problem.


Oh, my drivers were wrong from the beginning.

I've sent patches.


> In Linux I2C terminology, a transfer is everything between a START and a
> STOP. A transfer may consist of multiple messages, connected with
> REP_START [1].
>
> So, a STOP should be generated after the last message of a transfer or
> of I2C_M_STOP is set in a message.

I see.
I hope this is documented somewhere if it has not been yet.


> The latter should be super-rare
> because mostly you should be able to use multiple transfers with a
> regular STOP instead.
>
> [1] Slide 8 illustrates this:
> http://events17.linuxfoundation.org/sites/events/files/slides/ELCE17-WSang-I2C-Fault-Injector.pdf

Awesome!

I should follow "When to not use bus recovery" check-list.

Thanks.

-- 
Best Regards
Masahiro Yamada
