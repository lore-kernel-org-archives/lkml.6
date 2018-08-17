Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2EFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E76A2152C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E76A2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeHQWev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:34:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33175 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHQWeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:34:50 -0400
Received: by mail-qt0-f193.google.com with SMTP id r37-v6so2741854qtc.0;
        Fri, 17 Aug 2018 12:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM5rFyw7X5vrYt6eyZHgHKGwp/ZAC3VvJwzWj4xXljE=;
        b=J9KgKqrL4Heu+33kuHnsoURiemkHlHzWa7UIGmX01HiG6tflLSCo3O6OFosGmvRs/7
         pcKEmPCH9OU+up4ApdsM/5hE7xICwhVNacpr7sG1TkTBCBPRl3DzhaKuDijNnHuSmeVo
         sNK0jpQ2MtTUmQ+4+p+tH72H4bcecD3iYSYIaRLm+Dps3Sf48yijO25KhqEi0OKvdJhM
         qE70pWgMZyYsC/yNeD8KeahATEoMy3x/fuEKmBrvVRAHWHAwNXHk91HJpTQ4iW3Zkcr2
         BUoe7qm36/Ru9o0kbNtdwYGGgdFeWSjiD58hgBg/ajKi+iGE9jF+BuqsEcdsaHjPwckN
         7TtQ==
X-Gm-Message-State: AOUpUlEcis8I+wWkA9EvynY1FGHYnC7fg485p8vSbuOWvGNf17xza03n
        xuC+sKqUQduD/NfGti5w6mJbLqZlZYAJBPx+kEv/lDx3
X-Google-Smtp-Source: ANB0VdZ4HyLnW852jb92Az0E5vnI0tcx+38zvzucVDWAiQ/UJyUu9yfBHwPE+JwBnKOr1MPUmPxtD0wx53EoMUgdoLM=
X-Received: by 2002:ac8:2f43:: with SMTP id k3-v6mr5938901qta.163.1534534213177;
 Fri, 17 Aug 2018 12:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180815175040.3736548-1-arnd@arndb.de> <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a0f38ev5E4Zvg_3BS+1UN2NzYSw+dyRHXDwLCWgREXJ6g@mail.gmail.com>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073EA26@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a3guebtDLNhbQwNmA2nq=raKiP8ztGRpb03r0XD8h+ZNA@mail.gmail.com>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073EA3B@CHN-SV-EXMX02.mchp-main.com> <20180817162558.GB22210@eeboy>
In-Reply-To: <20180817162558.GB22210@eeboy>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Aug 2018 21:29:56 +0200
Message-ID: <CAK8P3a1XEDzGtxyZ3Q6=jZe+w67r_ZakksAEQVDC8pYSCne55A@mail.gmail.com>
Subject: Re: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Bryan.Whitehead@microchip.com,
        UNGLinuxDriver@microchiptechnology.mail.onmicrosoft.com,
        David Miller <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 6:26 PM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Wed, Aug 15, 2018 at 08:50:03PM +0000, Bryan.Whitehead@microchip.com wrote:
> > Sounds reasonable to me. I will yield to Richard's insight.
> > But it would be nice if requirements like these were documented.
>
> I think the only reason for initializing to the system UTC (as most
> drivers do) is historical.  The first Intel driver was simply copied.
> I've been thinking recently that we should standardize this.  I'm open
> for suggestions on how to do this. Remember that the system time is
> likely wrong at driver initialization time.

Ah, so you mean the other drivers in fact do initialize the hardware clock,
they just set it to UTC instead of TAI? I must have looked wrong then,
but I see it now in most implementations (exceptions include ravb, sfc
and stmmac).

This certainly seems to be an "interesting" problem, given that the Linux
implementations (other than the new lan743x) then start out with UTC,
while the PTP spec mandates TAI. So even if the system clock is
perfectly synchronized to UTC at boot, we set the PTP hardware 37
seconds slow.

It would not be hard to change all PTP drivers to explicitly initialize to
TAI, but that might create its own set of problems if random code
depends on the current behavior.

I also see that "phc_ctl /dev/ptp0 set" defaults to CLOCK_REALTIME
and has no option to use CLOCK_TAI instead. How is this meant to
work? I see a lot of other code that tries to deal with leap seconds and
the tai offset, so I hope I was just misreading that code.

       Arnd
