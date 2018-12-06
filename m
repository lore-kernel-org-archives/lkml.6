Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BEB208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BEB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbeLFTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:18:31 -0500
Received: from foss.arm.com ([217.140.101.70]:59094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbeLFTSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:18:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63072EBD;
        Thu,  6 Dec 2018 11:18:30 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33C293F59C;
        Thu,  6 Dec 2018 11:18:30 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 56E061AE0BAD; Thu,  6 Dec 2018 19:18:51 +0000 (GMT)
Date:   Thu, 6 Dec 2018 19:18:51 +0000
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
Message-ID: <20181206191850.GC20796@arm.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
 <20181029105515.GD14127@arm.com>
 <BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
 <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for running these tests and providing the in-depth analysis.

On Mon, Dec 03, 2018 at 09:20:25PM +0000, Alexander Van Brunt wrote:
> > If we roll a TLB invalidation routine without the trailing DSB, what sort of
> > performance does that get you?
> 
> It is not as good. In some cases, it is really bad. Skipping the invalidate was
> the most consistent and fast implementation.

My problem with that is it's not really much different to just skipping the
page table update entirely. Skipping the DSB is closer to what is done on
x86, where we bound the stale entry time to the next context-switch.

Given that I already queued the version without the DSB, we have the choice
to either continue with that or to revert it and go back to the previous
behaviour. Which would you prefer?

Will
