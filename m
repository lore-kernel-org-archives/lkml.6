Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C38BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1D4214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JaekJboJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1D4214FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeHBLvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:51:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40343 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeHBLvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:51:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so1485032wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YTZpyDRPSSkeekFr1TmLJS58WUqFsB2ps+vZ7KocaOE=;
        b=JaekJboJni4OdPdqM7QHrVUcoiphlsaGWRbbwU2YID3lkAurYN3gGlIdbQtnWY75+j
         cy9xdsSl0T+amu1tf5N5VddvylxEuxnJSq9MaODbPyELenljOZYBMTNj5BjVB51M53kF
         dOREYvU2lZSPCYQZpGzdS7byelJNhNIeDXE78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YTZpyDRPSSkeekFr1TmLJS58WUqFsB2ps+vZ7KocaOE=;
        b=LY+ZiO3BtmEy4TY/b6iD0HV1gPuvv04UauNhr8nbkrlmvZO+F9+mcAvwF9wm5+iSTm
         FHm20MeUnx608am/pklL0TGQzAogG2I2oC6LpXrWoq7bi+lSEZXp533oVnW6IY3D0NfR
         OmD8CzqDI5U39e0BJWLCbmMp0JmZzjI1ueyS5x0iU0Tx6J6dfm0wqW6TfRickQyz61tq
         JPhT6hneP/3ILmAIEUOrAQtpwY/6Gid8QhhL7ayT4JEKGCvwVWPq6OJl67qiopVkFTrN
         EK/UAuODyxk427tSSUbw4HvnUGErYwTrUQwKBEXYqWSyA8xwU/RZCZHVPUOikm8BxluD
         Wafw==
X-Gm-Message-State: AOUpUlGU1x2/VKQAeAvdEoWzvNlfZ8ItwKGsl9f5EnWMAZ0Ymr65uNbG
        sY7qOoBMA2AXuq48qML/wutDHA==
X-Google-Smtp-Source: AAOMgpdo4Ut2E+oiEwQQyxFh4lAOKnFe7sxmcAR56NLXrpIIK6Q2Hc3cIdW2gmyayyI/Ra5+XBYnJg==
X-Received: by 2002:adf:ce88:: with SMTP id r8-v6mr1428997wrn.112.1533204079889;
        Thu, 02 Aug 2018 03:01:19 -0700 (PDT)
Received: from dell ([95.149.160.4])
        by smtp.gmail.com with ESMTPSA id a84-v6sm1457631wmh.27.2018.08.02.03.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 03:01:19 -0700 (PDT)
Date:   Thu, 2 Aug 2018 11:01:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
Message-ID: <20180802100117.GQ4662@dell>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180802080525.GM4662@dell>
 <74081a83-abcf-5529-babb-83a7b5242f68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74081a83-abcf-5529-babb-83a7b5242f68@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2018, Srinivas Kandagatla wrote:

> Thanks for the review,
> 
> On 02/08/18 09:05, Lee Jones wrote:
> > On Fri, 27 Jul 2018, Srinivas Kandagatla wrote:
> > 
> > > WCD9335 supports two lines of irqs INTR1 and INTR2.
> > > Multiple interrupts are muxed via these lines.
> > > INTR1 consists of all possible interrupt sources like:
> > > Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
> > > INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   drivers/mfd/Makefile                |   2 +-
> > >   drivers/mfd/wcd9335-core.c          |   9 ++
> > >   drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
> > 
> > Any particular reason for separating out IRQ handling?
> No particular reason, I tried to follow what other codecs like wm8994,
> wm8350 and 14 others do.

I haven't look at them in a while, but maybe theirs are optional?

Either way, I don't think you need to do it.

> > >   include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
> > >   include/linux/mfd/wcd9335/wcd9335.h |   3 +
> > >   5 files changed, 228 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/mfd/wcd9335-irq.c
> > >   create mode 100644 include/dt-bindings/mfd/wcd9335.h
> > > 
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index a4697370640b..210875afe78a 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -58,7 +58,7 @@ obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
> > >   endif
> > >   obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
> > > -wcd9335-objs			:= wcd9335-core.o
> > > +wcd9335-objs			:= wcd9335-core.o wcd9335-irq.o
> > >   obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
> > >   wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
> > > diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
> > > index 8f746901f4e9..6299dfb63aca 100644
> > > --- a/drivers/mfd/wcd9335-core.c
> > > +++ b/drivers/mfd/wcd9335-core.c
> > > @@ -243,12 +243,20 @@ static int wcd9335_slim_status(struct slim_device *sdev,
> > >   		return ret;
> > >   	}
> > > +	wcd9335_irq_init(wcd);
> > 
> > Why don't you check the return value?
> > 
> > What happens if it defers?
> > 
> It would not defer here as the regmaps are already setup in probe and the
> status callback is only invoked when the SLIMbus device is up.

I guess now you have seen my comment below, you know that it can
defer, right?

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Copyright (c) 2018, Linaro Limited
> > > +//
> > 
> > Blank line?
> > 
> Yep.

Does "yep" mean, "I'll fix it"?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
