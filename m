Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0B5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23B220836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23B220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757201AbeFSKZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:25:11 -0400
Received: from foss.arm.com ([217.140.101.70]:47056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757124AbeFSKZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:25:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C861435;
        Tue, 19 Jun 2018 03:25:08 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCF913F25D;
        Tue, 19 Jun 2018 03:25:04 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:25:03 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
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
Message-ID: <20180619102502.GU17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
 <20180619091841.GD9208@codeaurora.org>
 <20180619094002.GR17720@e108498-lin.cambridge.arm.com>
 <20180619094714.GA13617@localhost.localdomain>
 <20180619100224.GT17720@e108498-lin.cambridge.arm.com>
 <20180619101901.GC13617@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619101901.GC13617@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jun 2018 at 12:19:01 (+0200), Juri Lelli wrote:
> On 19/06/18 11:02, Quentin Perret wrote:
> > On Tuesday 19 Jun 2018 at 11:47:14 (+0200), Juri Lelli wrote:
> > > On 19/06/18 10:40, Quentin Perret wrote:
> > > > Hi Pavan,
> > > > 
> > > > On Tuesday 19 Jun 2018 at 14:48:41 (+0530), Pavan Kondeti wrote:
> > > 
> > > [...]
> > > 
> > > > > There seems to be a sysfs interface exposed by this driver to change cpu_scale.
> > > > > Should we worry about it? I don't know what is the usecase for changing the
> > > > > cpu_scale from user space.
> > > > 
> > > > This is something I've been wondering as well. TBH, I'm not sure what to
> > > > do in this case. And I'm not sure to know what is the use-case either.
> > > > Debugging purpose I assume ?
> > > > 
> > > > Juri, did you have a specific use-case for this feature when the
> > > > arch_topology driver was first introduced ? Or was it just to align
> > > > with the existing arm/arm64 code ?
> > > 
> > > It was requested (IIRC) because DT might have bogus values and not be
> > > easily modifiable. So, this is another way to get things right for your
> > > platform at runtime.
> > 
> > Right, but that also allows you to set different capacities to CPUs
> > inside the same freq domain, which isn't supported by the EM framework,
> > at least for now. So I would prefer to assume that your values in DT must
> > to be correct to use EAS, and leave the code as-is for now.
> 
> It's actually built on the (current) assumption that siblings share
> capacity [1], so it seems to align with what EM requires.
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/base/arch_topology.c#L71

But there is not hard guarantee that the core_sibling mask and the
frequency domains are aligned :-(

Hikey 620 is an example where they might be misaligned (I think)
