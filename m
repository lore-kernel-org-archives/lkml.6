Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7569BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABB1218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0WrUlOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfBZXeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:34:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41309 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfBZXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:34:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so6956454pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n8P1R9OyXHB7VHmonbdf5o5d5UZLIcR5uQjnpwS7Rxs=;
        b=R0WrUlOibSuPQgcyO2hHr4f/HTwGABPIQ/KdpA9Xvgmjfc5nJyHn7/W27Uzqynszmi
         eIokDHbySLPsLO7ocFqxfuD1xf7fhUDQkMD58mXscM/BnWgxpCPalmFTqM0UcWVXm3Js
         zcurYfA8ql9oiKS5la61WSzQcVNmdAGwL0Hvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8P1R9OyXHB7VHmonbdf5o5d5UZLIcR5uQjnpwS7Rxs=;
        b=bLCfFoucJePcd1ESCBuQO4EGQdhJ0GLD/z+OG1tXrRV42sPbVMDzTBalmFW9MuQj8t
         DIerFHgBxMfdi5i+VKEB/vdkq1XzoBJHi89DAU+uzB5NiJ7dEhBKajREOLSOp0JP54+A
         8G3HASfhyEtsDx6lgym0KNDZTrHSUYsXGAcNmwA91FLakq+loI2lJt6n3rYF9dZwWFfb
         aBKpiH/Y2XM6n/C/V0H60dU9JdGKUpwMfyRK3HRgSSTV8aJ/odZKeexaPJZ2Q/hzjRAo
         cfhXZytgiBgTqQlUndEQZ/6VHc6f+CqGuz1+sSvLmKFMkZdGWd18VWMR6Ae83n2suM+f
         pc0A==
X-Gm-Message-State: AHQUAuaSnNhZd3o+WXczCaEPreJ2FSHpx999Hbg22jkP6WKld5AGEuJO
        9Zhby44KNuMFyjXIcAUUdRECnQ==
X-Google-Smtp-Source: AHgI3IZx/l9x7PyCNpPE3Gv0+b01BmZTP6CBrJzUZgTSbtd/AkFWEJ9sOsJtS774d9kZWUOj57TVcg==
X-Received: by 2002:aa7:8150:: with SMTP id d16mr28898496pfn.172.1551224057414;
        Tue, 26 Feb 2019 15:34:17 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id p34sm28840880pgb.18.2019.02.26.15.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 15:34:16 -0800 (PST)
Date:   Tue, 26 Feb 2019 15:34:14 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/4] mwifiex: Flag wake-up interrupt as IRQ_NOAUTOEN
 rather than disabling it too late
Message-ID: <20190226233413.GC174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190224140426.3267-4-marc.zyngier@arm.com>
 <20190226233130.GB174696@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226233130.GB174696@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:31:31PM -0800, Brian Norris wrote:
> Hi Marc,
> 
> On Sun, Feb 24, 2019 at 02:04:25PM +0000, Marc Zyngier wrote:
> > The mwifiex driver makes unsafe assumptions about the state of the
> > wake-up interrupt. It requests it and only then disable it. Of
> > course, the interrupt may be screaming for whatever reason at that
> > time, and the handler will then be called without the interrupt
> > having been registered with the PM/wakeup subsystem. Oops.
> > 
> > The right way to handle this kind of situation is to flag the
> > interrupt with IRQ_NOAUTOEN before requesting it. It will then
> > stay disabled until someone (the wake-up subsystem) enables it.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> This could be:
> 
> Fixes: 853402a00823 ("mwifiex: Enable WoWLAN for both sdio and pcie")

Also, this comes after a different change (that's not quite as clearly a
backport-able bugfix). Perhaps it should go first in the series?

Brian

> although, that was just borrowing the existing antipattern from SDIO
> code..
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> Thanks.
> 
> > ---
> >  drivers/net/wireless/marvell/mwifiex/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> > index 2105c2b7c627..82cf35e50579 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > @@ -1610,6 +1610,7 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
> >  			 "wake-up interrupt outside 'wake-up' subnode of %pOF\n",
> >  			 adapter->dt_node);
> >  
> > +	irq_set_status_flags(adapter->irq_wakeup, IRQ_NOAUTOEN);
> >  	ret = devm_request_irq(dev, adapter->irq_wakeup,
> >  			       mwifiex_irq_wakeup_handler, IRQF_TRIGGER_LOW,
> >  			       "wifi_wake", adapter);
> > @@ -1619,7 +1620,6 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
> >  		goto err_exit;
> >  	}
> >  
> > -	disable_irq(adapter->irq_wakeup);
> >  	if (device_init_wakeup(dev, true)) {
> >  		dev_err(dev, "fail to init wakeup for mwifiex\n");
> >  		goto err_exit;
> > -- 
> > 2.20.1
> > 
