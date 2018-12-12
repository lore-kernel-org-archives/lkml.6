Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B110AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7677A20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkH0o11M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7677A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeLLNsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:48:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38225 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:48:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so8638742plb.5;
        Wed, 12 Dec 2018 05:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bD6irQLCJOg1wqtSOycWNfv90m1OiSWDicagcursKSU=;
        b=bkH0o11MSdOzNvbuRxjPbl1ZKDXjCuHN1b6mQgRrVz9SiD5DPRRJlnIF/xY8iidH5v
         Bg/pQK/62UKB40rIRd1pY1Z8839sXprASdC/YsjS+fqVsBNvCkG0+ob2Dh8J4Py2E1ox
         K+Gxf+7p5Uag+9tY5LzeDFtEZOdU5UmtX3zCnCdHnZStsWCkdhkNrVOskPhg+go3VVOA
         zO5+2dcDUGu3RCGo/6mYH2uhcF+3cXSzSMNg7196BaTHcUFvD13VDrdUK6pgthy9pn+Z
         EHeqTmlp3GnkXnZfuSpbr3bZSoBbS6u3WPwm3upU0NSrCdlg1KUzvQsLB7mrQY3UWJn6
         Hrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bD6irQLCJOg1wqtSOycWNfv90m1OiSWDicagcursKSU=;
        b=rNauk084zUvUkyysPcshWoZk8Og13RmB5JIAP5b+zHiJtrAYA+SvqtVjMwzeQFjUSL
         eeh1y/nTzNpfW27bOc75ZITBMfTYZztF5TOQK46DeOw+UqmeedOGkg0g+vODrEBOzY/B
         YxW7B2pfQUu6ZQrg8hERnc3t3YGLMwVbIIyvP9kyqc9zG+fVmRA69BgPr4onNxqdWeCi
         mrjQsFwlbnj0vil9rWIgNlAEi3wAQv1Tq1kqqH8dbEh+TSbD6c7NIVtnTMAAynLqWUTU
         LaxN9Ekxd60yjF1uAWRQ/biPUEaMO60/bK9YwCwH8xu38lOWce62ORQH5pDtts37sxVO
         X2Tg==
X-Gm-Message-State: AA+aEWa4I8K2gL8PrmWLtr0e3tZxsR+l+6ArztmhBbKGfptcs0FcaOdb
        2ocG0NR5To6REexIl9Rrov+NGqlJjA5kkxFwEII=
X-Google-Smtp-Source: AFSGD/UGVZLeingnOutZwJ/+Ot6k1UXoNbexfUBwsiS+MLQTLw7Vj27v1zBDmtFiQuGR1H3QHBMYMxf3/LCohjC2xKY=
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr20253265pls.12.1544622521615;
 Wed, 12 Dec 2018 05:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20181211060125.28671-1-ayman.bagabas@gmail.com>
 <20181211060125.28671-3-ayman.bagabas@gmail.com> <CAHp75VcNstKd3JW-D8QSQWez-TxrwsKrkA-a1D11kZW72fSqfw@mail.gmail.com>
 <757a7ce6ae8ea5f040fb7bb1bdf9768799d82a11.camel@gmail.com> <s5hh8fjutbx.wl-tiwai@suse.de>
In-Reply-To: <s5hh8fjutbx.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Dec 2018 15:48:29 +0200
Message-ID: <CAHp75VfXJ_LDyWAqgMPPqFMKRcQ1E9FGm5uyobKN7D9ec9Qqyg@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] x86: add support for Huawei WMI hotkeys.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 8:56 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 11 Dec 2018 21:10:07 +0100,
> <ayman.bagabas@gmail.com> wrote:
> >
> >
> > Do I need to resubmit?
>
> Yes, please.
>
> Andy, I think it's better to merge the series through my tree, as it
> uses the new leds audio trigger stuff.
>
> Could you give ACK if the revised one is OK?

For addressed comments
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Then I'll merge them to the immutable branch topic/leds-trigger, so
> that you can merge to your tree cleanly, too.
>
>
> thanks,
>
> Takashi



-- 
With Best Regards,
Andy Shevchenko
