Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BDDC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFE620989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBkD0tjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFE620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeKUGDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:03:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36578 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeKUGDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:03:41 -0500
Received: by mail-pl1-f194.google.com with SMTP id y6-v6so1772306plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MfJuV/kPywVsq2lO72pmZlqYwz9D4tmMU5AAwbuO3qM=;
        b=VBkD0tjRvkTHWccoytap9FlKB5rxqnY7khjTYfFwOheswGPxcxBDbBFcPVhylwL02H
         L8L9en6EXdEpTE9H8rGhLwdYyd3oFQVREFvNqJzjMvo/fK+RCT6tjONZZFLPfLkZODgo
         ozHclt6GTvp1IAqZI8RQs8AmVJkg/MNJmsijQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MfJuV/kPywVsq2lO72pmZlqYwz9D4tmMU5AAwbuO3qM=;
        b=buH2w28wfsFW8oILqx280QU6QGc2W7AVdjtGNg3aiw1AEVDP7igFPjSzUQKZ1tm6bZ
         4tfuawcwh19iOUEKmbf4foaLcUAlCQroTmxKaVfWnXb5jAcP1pslln8NL+VAAqcfEYY2
         Wk0tmgrCHbH1eb1EFA99OVWuXI0r3CFFL8UR/BA4G5hLpo/KsuR0+4ola2MQCLs0vT8l
         hyxZQ5ir9STqPw//hQrO31ryNXK4yROjEUvy2iS63Cfcezeqxf9pjHYEr2F/KtLzAW4E
         iEPwgSNqyvGgjgHFmjd69O8acFla7GLPMQ09l9p72l6St00fkNdiYXw/Cl0E5YBrmVep
         dffQ==
X-Gm-Message-State: AA+aEWZRaIyzENQqIQywcMRNCU8Nk3FkrFyV3E2LRaKAhHqbSHUSr330
        XCb37PRn10kW9gzywiB74HiO
X-Google-Smtp-Source: AFSGD/VoKrLPmTkATBeVlFOMW58bKsxBxKTyqFftjfwtqO6p3zy+TSew3srD2k2S5XodeHqf4QhNFQ==
X-Received: by 2002:a63:9e58:: with SMTP id r24mr3173726pgo.264.1542742375595;
        Tue, 20 Nov 2018 11:32:55 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6008:86c4:249a:6443:23f2:61f3])
        by smtp.gmail.com with ESMTPSA id j197sm62407233pgc.76.2018.11.20.11.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 11:32:55 -0800 (PST)
Date:   Wed, 21 Nov 2018 01:02:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 04/16] arm: dts: Add devicetree for RDA8810PL SoC
Message-ID: <20181120193245.GC16122@Mani-XPS-13-9360>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
 <CAK8P3a1ZOTrUFKvBCdMX-1Fj5Pnk__+GJdee7pOieb2oiWkpuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1ZOTrUFKvBCdMX-1Fj5Pnk__+GJdee7pOieb2oiWkpuQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Nov 19, 2018 at 08:37:14PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 19, 2018 at 6:11 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add initial device tree for RDA8810PL SoC from RDA Microelectronics.
> 
> > +       aliases {
> > +               serial0 = &uart0;
> > +               serial1 = &uart1;
> > +               serial2 = &uart2;
> > +       };
> 
> Better move the aliases into the board file, there might be boards
> that only expose one or two of them on physical connectors,
> or that count them in a different order from the SoC.
> 

Sure, will move the aliases node to board DTS files.

Thanks,
Mani

>       Arnd
