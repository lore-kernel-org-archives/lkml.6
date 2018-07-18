Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF84ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421272075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvgfEQOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbeGRRFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:05:37 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38690 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeGRRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:05:37 -0400
Received: by mail-ua0-f195.google.com with SMTP id o11-v6so3305625uak.5;
        Wed, 18 Jul 2018 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1aVhptxZzVOVOzIOvZ6SP8W/ei+PNltIiTaCYhkH5t0=;
        b=VvgfEQOdz7AFq9xek1v4OhQhJHy4OA9ASVI+KjoN4nSn1FfY5FMhfe8SMXVYRIBOBq
         8cUy640SWiPU5l3lCsS6WIDR510AvR7AseRGwOjOx9rXl+7ClJAdH2CBO78KyKvejRCF
         h0tH+kggFKwB7I4vWKtiDGmOs+vQgdPzpueHwhbCmlgGwFNsIOVb1ihPqhDa+mrBiZe9
         MXKG9O1NvBnzKILikgs1jsZG2f1nnf+xhZK25XmLfn+JwGGlwQiPPpquPurmNiKfZxRx
         eD2Yz1R+xGtTHt8IHm3qF+TVQHkM6zpHW1tgkGryqzzY0G7wjqiQabRgBeZksla4SV1l
         edew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1aVhptxZzVOVOzIOvZ6SP8W/ei+PNltIiTaCYhkH5t0=;
        b=FwcNzh1XdlKlt995LZTw/ayl2TLsUYOvf1Ys1SEfdkbpTrITI/quAsssWkdcHxYgNE
         itHXAYLHwp2jHxoP6PKT5U/vcc+xdeQr1yph0tyeywOykj78LgzX2RaFKchrlmmOiu4H
         dNCuz6lRn0Qld7RfZOtSbCeEcWqkP0AP2+01vemjpFVNPw0C/gASoD6CxJkXvgr0b2Wk
         YOGkUV4pRTAWeHK+sRGLUSChS75xiEzaDR0eqBSjA/pAi89PRXJ0MIkW5wXimRvqBDZd
         mHR93OJ4+CAPLSoWi4c4T4wav4pgN8DSvOyvsMPY20AKXLNmdPQSlpByT903vkhWaGjo
         ti4A==
X-Gm-Message-State: AOUpUlFA82Rz5PmHyKrEN+9SW1tDxN9uw2jvHpcsekDHRfRSPTH5IahO
        UakWOZrGuoig89WSHiePdSRmvtKSUbgKouBPlKo=
X-Google-Smtp-Source: AAOMgpd8yejC7Ol20qfMX1PD6kCLFy5H3gqtDZnxOP7vTXdNGr6+dda0QDtuurg6HT9yuzJa+6CMndpRjENZP5Z0wQk=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr4389759ual.28.1531931216591;
 Wed, 18 Jul 2018 09:26:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 09:26:56
 -0700 (PDT)
In-Reply-To: <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com> <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 19:26:56 +0300
Message-ID: <CAHp75VeR8H-XhqkrSxBKoaVwcTx6__w4xpR0x2tm-0dxq9tZrw@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 5:09 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> On m41txx you can enable open-drain OUT pin to check if offset is ok.
> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
> 512 times faster than 1s tick base.
>
> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.

Taking into consideration the amount of patches per hour you need to
slow down a bit.

-- 
With Best Regards,
Andy Shevchenko
