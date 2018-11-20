Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF64C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883662075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PROhLoyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883662075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeKTWkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:40:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47025 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbeKTWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:40:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so899181ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gCcw7MN6qkoDs4X0IDlObJgLgWIeo6hhbO50aVJaj4s=;
        b=PROhLoygR80X/t/uEFI3iPh41J+/KT1bMtj3zN7XggIb6vP0XDuTUysL2QruXjjjN+
         TKrvHmNcPYpMSDxGHgWBMZnuT6/7LTAOWXfws3O+ksV1LemrRS4Uyq17eXWzoWGQ9nFS
         onWY5iNRl2FD6LHClrVad72Kxk1Ku1mOvuJ9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gCcw7MN6qkoDs4X0IDlObJgLgWIeo6hhbO50aVJaj4s=;
        b=U18bPD3g8GIql2KspYWt+yESmKpunBUNnaiSrIazo1Zn2K+2iY3dh2UVAh3OfWkyc2
         MJpXLqf4wQPJvlqsmzdqMCcpEdJ/tkd1snDnhPyCxDsNYfW8GCJuepKtqXqAG7dFh/7h
         OBX8MLynzJE1XrgXXIuHsgYSVEthlATa6DkKqOUxb4nd2vhswXlqrvTUu66/KD86xYGL
         f5dp92iN3f+QWayZBZJn+xDPhzZfMN4tvQ3GV7vORHUGIiAqir0WeRpi/iXiyapvVykb
         CbRflHpXOyZNM0BoTahjEy/bgbhHGEVlwnDoIRJD2XrJKSoUN3g41jPvNzRy4X7lJVGJ
         Hn0w==
X-Gm-Message-State: AA+aEWaOu55TAdhwicpyYrgaCH7V0SWRz1xMDh6IFz49Tb1nerw1plFm
        t5H7UggIr3PuW8+qXgcTKcEq
X-Google-Smtp-Source: AFSGD/XV9aTJBGRlwII+LVqYMLsymcCGVJAkDWhYSVGVFdue6/VAHx9reaGbnSuB1XQmk54PSr+KGw==
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr2010033plz.80.1542715910932;
        Tue, 20 Nov 2018 04:11:50 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 64sm11769456pff.101.2018.11.20.04.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 04:11:50 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:41:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
Message-ID: <20181120121139.GB13485@mani>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
 <0df98ec5-1189-7297-b58d-8c0f5cbfa2ac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0df98ec5-1189-7297-b58d-8c0f5cbfa2ac@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Nov 20, 2018 at 11:32:52AM +0100, Daniel Lezcano wrote:
> 
> Hi Manivannan,
> 
> 
> On 19/11/2018 18:09, Manivannan Sadhasivam wrote:
> > Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
> > and HWTIMER.
> 
> As it is a new driver, can you elaborate the log and describe the timer.
>

Sure, will add the brief in commit description and also in driver.
 
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> [ ... ]
> 
> > +static int __init rda_timer_init(struct device_node *node)
> > +{
> > +	unsigned long rate = 2000000;
> > +	int ostimer_irq, ret;
> > +
> > +	rda_timer_base = of_io_request_and_map(node, 0, "rda-timer");
> > +	if (IS_ERR(rda_timer_base)) {
> > +		pr_err("Can't map timer registers");
> > +		return PTR_ERR(rda_timer_base);
> > +	}
> > +
> > +	ostimer_irq = of_irq_get_byname(node, "ostimer");
> > +	if (ostimer_irq <= 0) {
> > +		pr_err("Can't parse ostimer IRQ");
> > +		return -EINVAL;
> > +	}
> > +
> > +	clocksource_register_hz(&rda_clocksource, rate);
> > +
> > +	ret = request_irq(ostimer_irq, rda_ostimer_interrupt, IRQF_TIMER,
> > +			  "rda-ostimer", &rda_clockevent);
> > +	if (ret) {
> > +		pr_err("failed to request irq %d\n", ostimer_irq);
> > +		return ret;
> > +	}
> > +
> 
> Use the timer-of API.
> 

Okay, will use it for both IO and IRQ requests.

Thanks,
Mani

> > +
> > +TIMER_OF_DECLARE(rda8810pl, "rda,8810pl-timer", rda_timer_init);
> 
> 
> Thanks
> 
>   -- Daniel
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
