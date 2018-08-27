Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACD9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE8A208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2EIVQAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE8A208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeH0XUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:20:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32906 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeH0XUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:20:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so57349pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrw0gMp7VbCFPTnFnSIL0AYMTTvr965NAQ+XZOpw6fA=;
        b=r2EIVQAqJo2DAjx4BXrrOT2vwSlgiYz0RezfknL9PnErcm3/CBqXm5d9PUlzkuWf30
         wRIEL9NuUCXujeWGgGceRT4nRGTC1e7uI9is6hubxOW4pHQBFvv9lOLNL0UJWHfMAUNV
         McJOo7uK6CsWUBi2uiRS/veFOxmFNlKoE1U9ayqJErTNX8LZQC5C73N+QWdKOrcGIBM2
         gArOnjnOi32R0Q/73Z0s7msddmcFEn/mgbb7QLtk/ZESAa4EMr4cuw/bXdzv8XN4VZJr
         hhTmGSlejyJMx88r37DNMwcp1+/rsVs6b1hYWAnWN6alCPYVnxCunPAtdmFKwoovA1JF
         /YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrw0gMp7VbCFPTnFnSIL0AYMTTvr965NAQ+XZOpw6fA=;
        b=F6PXgBO5/dRZOp58D+m6SVB+0XJ4beqVWAjIOt/oUeGMuVfdiisLYwj8W7MgmujHDE
         pvNJswFSClYKKiZfOCLwLWY5I25DVa5RDOBxdyd5EFUGCQygEk7VsLQZoSzB33smv9SL
         5KOqGsaYcggdwilZH3wmOdCdqe3S19AdW/fvUk/pJJeE9K9aPI3YwuBg8XF2YjXrKJUv
         ObP961CZdHz/jDIcOwqn3n8NK/2qAH1xgPugPX9w2jAdPOxWit29GMGr9m8uNZuE6D0S
         RDHgnum2iSrRhiAIP57b0Sq3RyR5cfws3IHbra77KKk2/jNrmK4vp0+Fx1h2mJ42H+Ld
         WIGg==
X-Gm-Message-State: APzg51B9mq+YrsdnQUMEvDlwJghKPha9SzEY3rrygd49YDDSwJPsNogE
        XkAoTrkMxl9a2BLR32ey/F5LeFLd
X-Google-Smtp-Source: ANB0VdaBRFxvlcBYczNRjU3mmNurYNaItx40hrBH8zuwU42y61jVyMqlmRocDg5NdgtXQ1fMjd9SbQ==
X-Received: by 2002:a63:4506:: with SMTP id s6-v6mr13639108pga.422.1535398338491;
        Mon, 27 Aug 2018 12:32:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y4-v6sm51965pfm.137.2018.08.27.12.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:32:17 -0700 (PDT)
Date:   Mon, 27 Aug 2018 12:32:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.19-rc1
Message-ID: <20180827193215.GA18363@roeck-us.net>
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
 <20180827134459.GA16094@roeck-us.net>
 <20180827154641.GA17201@infradead.org>
 <20180827171152.GA2705@roeck-us.net>
 <20180827181311.GA24778@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827181311.GA24778@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:13:11AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 27, 2018 at 10:11:52AM -0700, Guenter Roeck wrote:
> > When building sparc32 images, this results in the following
> > error.
> > 
> > drivers/base/platform.c: In function 'setup_pdev_archdata':
> > drivers/base/platform.c:235:22: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
> >    pdev->dev.dma_mask = &pdev->dma_mask;
> > 
> > pdev->dev.dma_mask is u64 *, pdev->dma_mask is dma_addr_t which in turn
> > is either u32 or u64 depending on the architecture.
> 
> Yes, I've fixed this up to be a u64.
> 
> > 
> > > +++ b/include/linux/platform_device.h
> > > @@ -25,6 +25,7 @@ struct platform_device {
> > >  	int		id;
> > >  	bool		id_auto;
> > >  	struct device	dev;
> > > +	dma_addr_t	dma_mask;
> > 
> > ... so this will have to be u64, or the pointer in struct device would
> > have to be fixed.
> > 
> > However, even changing the definition to u64 does not help: The warnings
> > are still reported. This is because setup_pdev_archdata() is not called
> > for any of the affected devices. That is kind of interesting since it
> > means that arch_setup_pdev_archdata() won't be called for those devices
> > either.
> 
> Yeah, this is odd.  I'll need some more time to figure out where
> the platform devices for sbus are allocated.

I think it is scan_one_device() in arch/sparc/kernel/of_device_32.c
and arch/sparc/kernel/of_device_64.c.

Guenter
