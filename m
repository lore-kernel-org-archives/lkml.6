Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62EAC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A372086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A372086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeIKVuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:50:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeIKVuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:50:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C0F97A9;
        Tue, 11 Sep 2018 09:50:14 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1AD23F703;
        Tue, 11 Sep 2018 09:50:13 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7B0C81AE3231; Tue, 11 Sep 2018 17:50:30 +0100 (BST)
Date:   Tue, 11 Sep 2018 17:50:30 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>, catalin.marinas@arm.com,
        sudeep.holla@arm.com, ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add NUMA emulation support
Message-ID: <20180911165029.GA15022@arm.com>
References: <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
 <20180905064252.GW14951@dhcp22.suse.cz>
 <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
 <20180907083452.GC19621@dhcp22.suse.cz>
 <e46e715c-f115-f054-eeb2-3cecbcd1192d@kernel.org>
 <20180910134845.GH10951@dhcp22.suse.cz>
 <4d7beb50-f778-507a-4c3c-f6de92f8cfb9@kernel.org>
 <20180911091124.GP10951@dhcp22.suse.cz>
 <86aad702-9f42-c572-a8f1-74983cd1bf33@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86aad702-9f42-c572-a8f1-74983cd1bf33@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:27:49AM -0600, Shuah Khan wrote:
> On 09/11/2018 03:11 AM, Michal Hocko wrote:
> > On Mon 10-09-18 20:02:05, Shuah Khan wrote:
> >> Hi Michal,
> >>
> >> On 09/10/2018 07:48 AM, Michal Hocko wrote:
> >>> On Fri 07-09-18 16:30:59, Shuah Khan wrote:
> >>>> On 09/07/2018 02:34 AM, Michal Hocko wrote:
> >>>>> On Thu 06-09-18 15:53:34, Shuah Khan wrote:
> >> [....]
> >>>>
> >>>> In addition to isolation, being able to reserve a block instead is one of the
> >>>> issues I am looking to address. Unfortunately memory cgroups won't address that
> >>>> issue.
> >>>
> >>> Could you be more specific why you need reservations other than
> >>> isolation.
> >>>
> >>
> >> Taking automotive as a specific example, there are two classes of applications:
> >> 1. critical applications that must run
> >> 2. Infotainment and misc. user-space.
> >>
> >> In this case, being able to reserve a block of memory for critical applications
> >> will ensure the memory is available for them. If a critical application has to
> >> restart and/or when an on-demand critical application starts, it might not be able
> >> to allocate memory if it is not reserved.
> >>
> >> When a flat system has multiple memory blocks, with NUMA emulation in conjunction with
> >> cpusets, one or more block can be reserved for critical applications configuring a set
> >> of cpus and one of more memory nodes for them.
> >>
> >> Memory cgroups will not support such reservation. Hope this helps explain the use-case
> >> I am trying to address with this patch.
> > 
> > OK, that is more clear. I still believe that you either have to have a
> > very good control over memory allocations or a good luck to not see
> > unexpected kernel allocations in your reserved memory which might easily
> > break guarantees you would like to accomplish.
> > 
> 
> Thanks. Right. I am with you on the possibility that root cgroup can eat into
> the reserved memory. However, with this solution I proposed, there is a guarantee
> that the cpuset cgroup that is configured for non-critical Infotainment and misc.
> user-space application will not be able to allocate from the reserved memory node.
> 
> I am hoping the proposed patch will allow critical apps. reserving memory with the
> exception that root cgroup and kernel can still allocate from it when needed. Perhaps
> cpuset exclusive logic could be extended to look for non-exclusive memory nodes first
> if it doesn't already do that. This is inline with the current cpuset approach is that
> the critical kernel allocations aren't starved to ensure memory reservations.
> 
> If you don't think this solution isn't ideal/good, do you have other suggestions
> for solving the problem? If not would it be okay to start with what I proposed and
> build on top of as needed?

I still don't understand why this can't be achieved by faking up some NUMA
entries in the firmware table and just using the existing NUMA code that we
have.

Will
