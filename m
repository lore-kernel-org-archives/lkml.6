Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E004C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0279520874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0279520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937544AbeFSKbO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:31:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37009 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757187AbeFSKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:31:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id d8-v6so19996382wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 03:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vvfqD06WnBfaT1SWOrgpphzJ8/RrMmgTL13+2TaiuDo=;
        b=ALOrW/ndbUBsvDwDp1rPmHbrlqsiaHEhd7J3e+kD0Fj7VlU4zZ0MFmBaF5y5n3OUuE
         oabneJePUyVNZdHyaJPdttDJDperkSqrVVC8bL3UZh5+ZLxUc5mJnCqInX7gPPBPI4V4
         sBxXs77p+pWVrSJKJe4VtpsSjdYjoFZrEaIMnkDljQLw4gdip1ZH9/Dexqt7pMcOGZnr
         2NCvyudteWXv43RPeWd2dr3QHFpsEELEl4ddF4LBJPLrzTFOTD97uA/88V63tzOUrKgy
         kebKrNRh0Tub74sLSaiZPckaXvnL6jF51bBzkKHXCp4174xqnU1lrgbCxRwUstlovbvb
         aqMA==
X-Gm-Message-State: APt69E1ImomptbhvpPOetby/Je8cZDnM9MqNJXsD0XHKI54VZzJNFLS1
        FB56atpl2rKl+/0gk0Eau+MBVA==
X-Google-Smtp-Source: ADUXVKJzsuewlww2SSGtyTBLP9KSVJoEGpR7WJ4jcMo4jxcDTb17NL3/weSydbEDdKIwGmMOw0PnBA==
X-Received: by 2002:adf:a18f:: with SMTP id u15-v6mr13291475wru.194.1529404271186;
        Tue, 19 Jun 2018 03:31:11 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id f81-v6sm16936799wmh.32.2018.06.19.03.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 03:31:10 -0700 (PDT)
Date:   Tue, 19 Jun 2018 12:31:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Message-ID: <20180619103108.GD13617@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
 <20180619091841.GD9208@codeaurora.org>
 <20180619094002.GR17720@e108498-lin.cambridge.arm.com>
 <20180619094714.GA13617@localhost.localdomain>
 <20180619100224.GT17720@e108498-lin.cambridge.arm.com>
 <20180619101901.GC13617@localhost.localdomain>
 <20180619102502.GU17720@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619102502.GU17720@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/18 11:25, Quentin Perret wrote:
> On Tuesday 19 Jun 2018 at 12:19:01 (+0200), Juri Lelli wrote:
> > On 19/06/18 11:02, Quentin Perret wrote:
> > > On Tuesday 19 Jun 2018 at 11:47:14 (+0200), Juri Lelli wrote:
> > > > On 19/06/18 10:40, Quentin Perret wrote:
> > > > > Hi Pavan,
> > > > > 
> > > > > On Tuesday 19 Jun 2018 at 14:48:41 (+0530), Pavan Kondeti wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > There seems to be a sysfs interface exposed by this driver to change cpu_scale.
> > > > > > Should we worry about it? I don't know what is the usecase for changing the
> > > > > > cpu_scale from user space.
> > > > > 
> > > > > This is something I've been wondering as well. TBH, I'm not sure what to
> > > > > do in this case. And I'm not sure to know what is the use-case either.
> > > > > Debugging purpose I assume ?
> > > > > 
> > > > > Juri, did you have a specific use-case for this feature when the
> > > > > arch_topology driver was first introduced ? Or was it just to align
> > > > > with the existing arm/arm64 code ?
> > > > 
> > > > It was requested (IIRC) because DT might have bogus values and not be
> > > > easily modifiable. So, this is another way to get things right for your
> > > > platform at runtime.
> > > 
> > > Right, but that also allows you to set different capacities to CPUs
> > > inside the same freq domain, which isn't supported by the EM framework,
> > > at least for now. So I would prefer to assume that your values in DT must
> > > to be correct to use EAS, and leave the code as-is for now.
> > 
> > It's actually built on the (current) assumption that siblings share
> > capacity [1], so it seems to align with what EM requires.
> > 
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/base/arch_topology.c#L71
> 
> But there is not hard guarantee that the core_sibling mask and the
> frequency domains are aligned :-(
> 
> Hikey 620 is an example where they might be misaligned (I think)

Yep. In this case you'd need to write cpu_capacity twice (for each
cluster). I think.
