Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E5ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2342148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijeoNveq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2342148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeJRCV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:21:57 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35368 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJRCV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:21:57 -0400
Received: by mail-ua1-f67.google.com with SMTP id m18so5142114uaq.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SozD2VkWu3kOznglb4i/Yn8g0EXryUxNOc54g0sYTY8=;
        b=ijeoNveq0dzLyqkBiF3PKLwyPkIjBWr49LQNaQupNbl9We+qz3ScwTL0Zp45/0roaI
         Uw16fusthVEGhh+dzx8Rm0L9xZrWAIMOKA6tvwCYroH1m8PnJYJaGBdOjHw3Cg70R1Ek
         xPIMIhZgh1eX/1QS8DyKmlLwMbzuTl2TMYIFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SozD2VkWu3kOznglb4i/Yn8g0EXryUxNOc54g0sYTY8=;
        b=lK3NTGWfMtVOPY4iFdmQRi381nXcbm7XOO9K9Uq9zi1cxPlrBDQjDynIJW6chdL26O
         obS1tWwn9jiCU1lr9aoqyNVwxjH+UYROZ7ZLBAC2dMYiG5Uiqh872doYR9lzQHTvd/MZ
         6YqicI5GnJzvNqfHEszPmzVyRpVEv5WU4x04LHJBWz7TetyYe44iZoh4/2cpBBU1ToiJ
         QZVn5o1sGWVn7SMPOfFh2MFAe7lTTBaprIddcyunt34jwQgDGHrZSMNq9mORRESprTI0
         eTA70IAgzrQXa2NAVLL5re+9lW76c28Q6GWxgdfTgOPocwTbi59rnQ8zX/l2tYAoCSsI
         8LLA==
X-Gm-Message-State: ABuFfojl3YZTSDK01Kie9iVSlU5O5U/hg9nKSiOi0ulWMXBxHr5pcQ0P
        icMs15RSH6KYDmSVe5i2vU7qZrZ18FM=
X-Google-Smtp-Source: ACcGV61Sfm3iYbX/S1pMbuscWFQbfgj9rGP+IIFjWxQcBk0CUzFp6bfU9eK2vwv75nHxyhTb4XJicw==
X-Received: by 2002:ab0:54d4:: with SMTP id q20mr11938516uaa.53.1539800702010;
        Wed, 17 Oct 2018 11:25:02 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id s6sm3633066vkd.36.2018.10.17.11.25.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:25:01 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id e126so21403639vsc.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:25:00 -0700 (PDT)
X-Received: by 2002:a67:1144:: with SMTP id 65mr3126405vsr.213.1539800700406;
 Wed, 17 Oct 2018 11:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180316145511.28362-1-marc.zyngier@arm.com> <20180316145511.28362-3-marc.zyngier@arm.com>
In-Reply-To: <20180316145511.28362-3-marc.zyngier@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Oct 2018 11:24:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmiOh0Mg0f4a=W0NCH8eb--OQhP2jNAv2ZMpUBOn9n6Q@mail.gmail.com>
Message-ID: <CAD=FV=XmiOh0Mg0f4a=W0NCH8eb--OQhP2jNAv2ZMpUBOn9n6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip/gic-v3: Loudly complain about the use of IRQ_TYPE_NONE
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 16 Mar 2018 at 11:02 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> There is a huge number of broken device trees out there. Just
> grepping through the tree for the use of IRQ_TYPE_NONE in conjunction
> with the GIC is scary.
>
> People just don't realise that IRQ_TYPE_NONE just doesn't exist, and
> you just get whatever junk was there before. So let's make them aware
> of the issue.

I'm late to the party here and this patch has already landed.

I'm a bit curious.  You say "you just get whatever junk was there
before", I think you're implying that if you specify "IRQ_TYPE_NONE"
in the device tree then you'll be left with whatever the default
trigger was: either however the hardware was initted or how the
bootloader left it.

...but from my recollection that's not the case and someone from stack
overflow seems to have nicely documented how I think this works:

https://stackoverflow.com/questions/40011799/mapping-device-tree-interrupt-flags-to-devm-request-irq

Specifically it's my understanding that the irq_flags in the device
tree rarely have any impact on reality because most drivers specify
how they want the interrupt configured anyway.  The device tree flags
will only ever be used if the client code didn't specify.


Assuming my understanding is correct, then I guess it calls into
question a bit the requirement that the device tree _must_ specify the
IRQ trigger type.  For the most part the code know (and needs to know)
what the IRQ trigger type is.  In cases where the code is really
generic (like an i2c device) and needs to run on lots of platforms
where not all triggers might be available, it's nice if the trigger
type _can_ be specified in the device tree, but does it need to be
mandatory?


Downsides of forcing everyone to start specifying their trigger type
in the device tree:

* There's no double-checking.  You can totally put something bogus
there and it will have no impact on your system whatsoever.  AKA I
just changed a whole pile of defines in my device tree from
IRQ_TYPE_LEVEL_HIGH to IRQ_TYPE_LEVEL_LOW and it had no impact on my
system.  That's because the drivers all passed "IRQF_TRIGGER_HIGH" to
request_irq.

* Developers will think that they can change the value in the device
tree and it will have an effect.  It won't.


-Doug
