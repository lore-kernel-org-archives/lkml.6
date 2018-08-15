Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC87C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BC221534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BC221534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeHOX1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:27:01 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34084 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeHOX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:27:01 -0400
Received: by mail-qt0-f174.google.com with SMTP id m13-v6so2726651qth.1;
        Wed, 15 Aug 2018 13:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qO0fuo4gF18T7amsvw3E373alJg1UWZH1v9tF1iFKTA=;
        b=B8O8kg7gmeK8/jsMYxuCnJavAY9x7BiCHSb3URdjkEFBJToE8QV3+8jc0pigWFKlpv
         SVz4o6UjmJ8O+SBfBNuIUSFiMTFfQWjOMWbYRVf/Wz2Ur7Cdr0KipR7q3Cugs6W5Wpo1
         oKIhAexFANPjuoFieE87XOF6523Y/8zkw5XINCjHygxkjC7MsMOC1T8PPWrlP4vCZJAY
         KzDc2DQD1B/WeaYhDbqogqJVmZUT+xc1dU5LSCx5laXLKg+v6j4sSnA9QORN0SC0X4xb
         MwmEojG4lvkGEpalJtOtGXE9yIUyxJvDnwnD9t5oE5vWmDyqd5N2pn5AT1ZSif17hac9
         wQ+w==
X-Gm-Message-State: AOUpUlEMwzfe1j310YDhzhP0FI90G7Warp6eHW7+ow6Rx9Zb+I96ir+E
        h0N7ImKRLOXTN7i7d+lys8bxPO6AyUosRHxj8pI=
X-Google-Smtp-Source: AA+uWPxR1OW4a4WCSa4lV0HND4zNDZ0mNpnV0h3AKTT97NSg/oaq2za1p4VhMKzAcrlLNpNBwWp8s+WGor5AG9x+Nug=
X-Received: by 2002:a0c:93b3:: with SMTP id f48-v6mr24421404qvf.151.1534365198061;
 Wed, 15 Aug 2018 13:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180815175040.3736548-1-arnd@arndb.de> <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
In-Reply-To: <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Aug 2018 22:33:01 +0200
Message-ID: <CAK8P3a0f38ev5E4Zvg_3BS+1UN2NzYSw+dyRHXDwLCWgREXJ6g@mail.gmail.com>
Subject: Re: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
To:     Bryan.Whitehead@microchip.com
Cc:     UNGLinuxDriver@microchiptechnology.mail.onmicrosoft.com,
        David Miller <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 8:03 PM <Bryan.Whitehead@microchip.com> wrote:
>
> >
> > Question: this is the only ptp driver that sets the hardware time to the
> > current system time in TAI. Why does it do that?
>
> This is done when the driver starts up after reset. Otherwise the clock is off by 48 years.
> It seemed to me that the system time was the most appropriate clock to sync to.
> If my reasoning is incorrect, please enlighten me.

I've never worked with PTP, but my understanding from looking at the other
drivers is that the time normally gets set either from another host through the
PTP protocol, or using clock_settime() from user space with the current time.

       Arnd
