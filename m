Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D28C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B543220868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B543220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeLGRxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:53:11 -0500
Received: from foss.arm.com ([217.140.101.70]:50670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbeLGRxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:53:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB68A165C;
        Fri,  7 Dec 2018 09:53:09 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B9BE3F5AF;
        Fri,  7 Dec 2018 09:53:09 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 21FFC1AE0BA4; Fri,  7 Dec 2018 17:53:31 +0000 (GMT)
Date:   Fri, 7 Dec 2018 17:53:31 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Alexander Van Brunt <avanbrunt@nvidia.com>
Cc:     Ashish Mhetre <amhetre@nvidia.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sachin Nikam <Snikam@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Message-ID: <20181207175330.GC11430@edgewater-inn.cambridge.arm.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
 <20181029105515.GD14127@arm.com>
 <BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
 <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>
 <20181206191850.GC20796@arm.com>
 <BYAPR12MB271239AAF4A0B79D756850C6CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
 <BYAPR12MB27120C304F7B085A0CA36124CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR12MB27120C304F7B085A0CA36124CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:42:03PM +0000, Alexander Van Brunt wrote:
> > > > If we roll a TLB invalidation routine without the trailing DSB, what sort of
> > > > performance does that get you?
> > > 
> > > It is not as good. In some cases, it is really bad. Skipping the invalidate was
> > > the most consistent and fast implementation.
> 
> > My problem with that is it's not really much different to just skipping the
> > page table update entirely. Skipping the DSB is closer to what is done on
> > x86, where we bound the stale entry time to the next context-switch.
> 
> Which of the three implementations is the "that" and "it" in the first sentence?

that = it = skipping the whole invalidation + the DSB

> > Given that I already queued the version without the DSB, we have the choice
> > to either continue with that or to revert it and go back to the previous
> > behaviour. Which would you prefer?
> 
> To me, skipping the DSB is a win over doing the invalidate and the DSB because
> it is faster on average.
> 
> DSBs have a big impact on the performance of other CPUs in the inner shareable
> domain because of the ordering requirements. For example, we have observed
> Cortex A57s stalling all CPUs in the cluster until Device accesses complete.
> 
> Would you be open to a patch on top of the DSB skipping patch that skips the
> whole invalidate?

I don't think so; we don't have an upper bound on how long we'll have a
stale TLB if remove the invalidation completely.

Will
