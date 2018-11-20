Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98367C41537
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C10220671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUExi1JK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C10220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbeKTWiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:38:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38704 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbeKTWiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:38:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so825949pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lYB4xqSJtkzhhD7ckpSBmuTLtmqzQ+/DBGZbGVQg8ro=;
        b=hUExi1JK5WhH41XsKdVxt9hNA2nMaPU1u7lopJNUtboAe8znTyudRBbnT1RFo+GeoM
         CvjztmVsrHkR1bJCRxiw9gxb7qPqL36WPIlJP9z3fvyOE2f1mF/jC/GEwsqHgkVYsxye
         gbzLsXZ7VT8QXTCqxp2SEEhdRqe+C7Tr4ga38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lYB4xqSJtkzhhD7ckpSBmuTLtmqzQ+/DBGZbGVQg8ro=;
        b=GPllnctpasgMUscqEtjL7chm4KsMBz+ZW9yPJvAQbiWGMvf+IRPz4rvJ1VazrrKbdt
         4ZkC+rkFh2JanUR2Sa9bUiO75EVtMGltK8feTKI9fT9lMZ4Hj9RQ4oinrux8upCfs9hd
         60bOHSSw/i9Gf2Yeso1emcfzhk1B0E1ShQrjCztq04NprfWwXlHPl4ET1hG63ad8X0qC
         ZWlT05WcAxhHYG51Y2WHfq778yoFir3H/T6+DRrMC6/68e7ixvOdc5gX25Qa7jt1GH1G
         PnQl4Bpc5y/rl39lSGu42Xh26hK/qNWACbImBBKwOTzoYod+NoHGz1PCEDQcbzj257bY
         qctQ==
X-Gm-Message-State: AGRZ1gLWeoIL7Wxzh/oVXCa5V46JejbAbQn5Ki1OuDmIOnUhP1ME9j8T
        OdSLdXCxkGbtljdrK4/IVrrp
X-Google-Smtp-Source: AJdET5e80tM12Hq/mf3N/w3vMJY2SAUNQV8kQ+SpLg+WGJEKs8y2uthcHRCsyAQlitlY7vuPs/EyPA==
X-Received: by 2002:a62:6981:: with SMTP id e123-v6mr1911576pfc.104.1542715760805;
        Tue, 20 Nov 2018 04:09:20 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id m3sm68668940pgl.69.2018.11.20.04.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 04:09:19 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:39:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, zhao_steven@263.net,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
Message-ID: <20181120120910.GA13485@mani>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
 <e9b208ff-327e-860a-6ef0-15bf797dc6b2@arm.com>
 <20181120050650.GC5885@Mani-XPS-13-9360>
 <86pnv0rwna.wl-marc.zyngier@arm.com>
 <CACRpkdan96Vj58s=g9jiAoyLBpZqPCKcjqD82mgDj5WqRP7vDQ@mail.gmail.com>
 <e732ad15-b778-1c84-ad47-5770ee66688b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e732ad15-b778-1c84-ad47-5770ee66688b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:05:41AM +0000, Marc Zyngier wrote:
> On 20/11/2018 08:56, Linus Walleij wrote:
> > On Tue, Nov 20, 2018 at 9:17 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
> > 
> >> How does this change anything with the fact that the above code is
> >> broken? 56 or 64 bit, you cannot read this counter with a single
> >> access, or two. The canonical way of reading such a counter is
> >> something like this:
> >>
> >>         do {
> >>                 lo = readl_relaxed(LO);
> >>                 hi = readl_relaxed(HI);
> >>         } while (hi != read_relaxed(HI));
> > 
> > To be fair, I have seen hardware that employ a logic latch
> > such that when a read access is done to the LO register,
> > the value of the whole counter is latched, also for the HI
> > register, so when you read the HI register in the second
> > step, it is never subject to wrapping. (Conversely reading
> > the HI before the LO will always give you insane values
> > :D)
> 
> I've seen such HW indeed, and I've also seen it being broken... ;-)
> 
> It this timer is built around such a (non-broken) logic, I'd really like
> to see it spelled out. It will otherwise be a real pain to debug...
>

There is no information about HW latch in datasheet and vendor code. But the
vendor driver doesn't use any logic to prevent wrapping. However, this doesn't
mean that we can assume that the hardware is capable of preventing overrun.
So I guess it is best to go with Marc's suggestion here.

Thanks,
Mani

> > However the above code should be fine unless you know
> > for sure the hardware was constructed with a clever latch.
> 
> Let's find out!
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
