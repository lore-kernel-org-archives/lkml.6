Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273BBECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE46A20877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXtrluCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE46A20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbeISVGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:06:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46113 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbeISVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:06:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so5431837ljj.13;
        Wed, 19 Sep 2018 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYtbsgXM6faHoFVqp/DjvrR0gMlEmUGq2FFKHj3xnp0=;
        b=YXtrluCn27KB2tSF8+bhBVcnMsJKFT7AhjP3WWD3H+uRzrqXmuBCwIeGNYGhUBLRjU
         yyhXCwp+qIi64iPNCmMhw7PpjkZgb1CCViqgW6jZv/fsqXOyVqWBcnh8O6p/2SC/Yf+g
         Y4BQ8Vfz/pnH1gq+divxOXKWrxIWA3WPwUVGWcBGB4f5N8CCMG7TXBf4bSLr8iRhMB+R
         UmIJdHlz5Ug/xrPnHkAh2AaguekPP4pOFg85uDABmPxlhBEd4srD4gqmxeDpXDUgFAWO
         wNBBqfQmXHNDCNKwOGuCwV4ImY9swL166cbZHHyVitRxSCyjxQCuMkcQmUTGta9BciH1
         0IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYtbsgXM6faHoFVqp/DjvrR0gMlEmUGq2FFKHj3xnp0=;
        b=Fmtnncz8M847ZhuxaN1UPjZ5gM2iovpNlQ7fsAMxeydn1rIoSE+d/05+j7ewSuGnyK
         VXLtM82e6fcvUkP/M8awV52XKQAZ+AMUJrBHdSMSNBSAt5Y/+KyRg3gwpAU4b+/gwBg4
         8SrgnFtXlg+4eG3j5hy8s1mdmrD3xV8s/mD9A6Mqc3oledjAPIZVcZnjOdznva0K1Ch3
         X7WrrLig7t8Z5Vm1DurAdjppTYXR/EE2TZ6kNfBkunTHzqebqlaFsRqJpGT0dGVL43Cd
         vxsSMuIXc0idWZ7nFf6qGA8CJsMu8+nmSVUdtYxpaGzWTs6ABVQvBtODcRo6am6WqKgV
         oeVg==
X-Gm-Message-State: APzg51CLxMsr444pZ0P/TS1ImRUJNPpevZZFTxLwETDurpmNdBY4aoli
        CTv55FpfM0DAHBn4/a1jq3E52pkHh7lEB7g3knQ=
X-Google-Smtp-Source: ANB0VdbkryfVk28HTEaE4mKEqIFGAfdkUam3a9JGfPsVyuztqGsdCnQ2hj3a3Sxho7JXqMtAYYES12oPS7ITjDLEqBY=
X-Received: by 2002:a2e:2025:: with SMTP id g37-v6mr6538057ljg.40.1537370863756;
 Wed, 19 Sep 2018 08:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com> <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com> <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org>
In-Reply-To: <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 19 Sep 2018 17:27:26 +0200
Message-ID: <CAPybu_39xtDfoHVo2dv2GZcU5hCQYjBpU7tW2hf3vfUwbUK1mQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     timur@kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@codeaurora.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timur
On Wed, Sep 19, 2018 at 1:50 PM Timur Tabi <timur@kernel.org> wrote:
>
> On 9/18/18 11:04 PM, Ricardo Ribalda Delgado wrote:
> > And should't that be tacked in qcom hardware with something like:
> >
> > if (!priv->initialized)
> >     return INPUT;
> >
> > if you or Timur point me to the harware that was crashing I would not
> > mind looking into that, but the current situations seems to me like a
> > hack.
>
> I'd say the previous code was the hack.  My comment about not touching
> the hardware until it is properly claimed is valid, and it applies to
> all platforms.

Let me explain my current setup

I have a board with input and output gpios, the direction is defined
via pdata. When I run gpioinfo all the gpios are shown as input,
regardless if they are input or outputs: Eg:

root@qt5022:/tmp# ./gpioinfo

gpiochip0 - 16 lines:
        line   0:     "PROG_B"       unused   input  active-high
        line   1:         "M0"       unused   input  active-high
        line   2:         "M1"       unused   input  active-high
        line   3:         "M2"       unused   input  active-high
        line   4:        "DIN"       unused   input  active-high
        line   5:       "CCLK"       unused   input  active-high
        line   6:      unnamed       unused   input  active-high
        line   7:      unnamed       unused   input  active-high
        line   8:       "DONE"       unused   input  active-high
        line   9:     "INIT_B"       unused   input  active-high
        line  10:      unnamed       unused   input  active-high
        line  11:      unnamed       unused   input  active-high
        line  12:      unnamed       unused   input  active-high
        line  13:      unnamed       unused   input  active-high
        line  14:      unnamed       unused   input  active-high
        line  15:      unnamed       unused   input  active-high

That is wrong and very confusing to the user, it can also lead to a
mayor fuckup if the user decides to connect two output gpio pins
because he expects that both are input. (This is the programming port,
but I also have 24 V -high current GPIOs)

There is a function in the API to tell libgpio if a gpio is out our
in. Why not use it?
- If the configuration is hardcoded, the driver will return a fixed value
- If it is cheap to query the hardware, the driver will query the hardware,
- If it is expensive to query the hardware the driver can either
return a cached value or a fake value (current situation)


From my point of view:  "The get_direction callback normally triggers
a  read/write to hardware, but we shouldn't be touching the hardware
for   an individual GPIO until after it's been properly claimed." is
an statement specific for your platform and should be fixed in your
driver.

Either that, or I have completely missunderstund the purpouse of gpiod
:), and that could easily be the case.

Regards!

-- 
Ricardo Ribalda
