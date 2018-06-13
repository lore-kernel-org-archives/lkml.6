Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 747B2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354C620020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354C620020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935588AbeFMNCA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:02:00 -0400
Received: from foss.arm.com ([217.140.101.70]:47304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935351AbeFMNB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:01:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE941529;
        Wed, 13 Jun 2018 06:01:59 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D23F03F25D;
        Wed, 13 Jun 2018 06:01:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C45E31AE53AB; Wed, 13 Jun 2018 14:02:32 +0100 (BST)
Date:   Wed, 13 Jun 2018 14:02:32 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Agustin Vega-Frias <agustinv@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        timur@codeaurora.org
Subject: Re: [RFC V2 3/3] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION
 DEFINED event support
Message-ID: <20180613130232.GA27675@arm.com>
References: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
 <1528379808-27970-4-git-send-email-agustinv@codeaurora.org>
 <20180612144055.m2h26n64spfm6k6o@lakrids.cambridge.arm.com>
 <9957219b64252d3b2e19724db04a1179@codeaurora.org>
 <20180613103555.GC26280@arm.com>
 <06c81a64-904f-59fa-5751-62818d6d2107@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c81a64-904f-59fa-5751-62818d6d2107@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 01:59:58PM +0100, Marc Zyngier wrote:
> On 13/06/18 11:35, Will Deacon wrote:
> > On Tue, Jun 12, 2018 at 04:41:32PM -0400, Agustin Vega-Frias wrote:
> >> On 2018-06-12 10:40, Mark Rutland wrote:
> >>> On Thu, Jun 07, 2018 at 09:56:48AM -0400, Agustin Vega-Frias wrote:
> >>>> Selection of these events can be envisioned as indexing them from
> >>>> a 3D matrix:
> >>>> - the first index selects a Region Event Selection Register
> >>>> (PMRESRx_EL0)
> >>>> - the second index selects a group from which only one event at a time
> >>>>  can be selected
> >>>> - the third index selects the event
> >>>>
> >>>> The event is encoded into perf_event_attr.config as 0xPRCCG, where:
> >>>>  P  [config:16   ] = prefix   (flag that indicates a matrix-based
> >>>> event)
> >>>>  R  [config:12-15] = register (specifies the PMRESRx_EL0 instance)
> >>>>  G  [config:0-3  ] = group    (specifies the event group)
> >>>>  CC [config:4-11 ] = code     (specifies the event)
> >>>>
> >>>> Events with the P flag set to zero are treated as common PMUv3 events
> >>>> and are directly programmed into PMXEVTYPERx_EL0.
> >>>>
> >>>> The first two indexes are set combining the RESR and group number with
> >>>> a base number and writing it into the architected PMXEVTYPER_EL0
> >>>> register.
> >>>> The third index is set by writing the code into the bits corresponding
> >>>> with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
> >>>> register.
> >>>
> >>> When are the IMP DEF registers accessible at EL0? Are those goverend by
> >>> the same controls as the architected registers?
> >>
> >> No, there is a separate IMP DEF register to control access.
> > 
> > Great :( We need to make sure we disable EL0 access during boot then, but
> > that means we need to prove for the existence of this thing in head.S
> > (since the PMU driver might not get loaded).
> > 
> > Also, what's the kvm story here so that we don't accidentally open up a
> > VM-VM side-channel via these registers? How do the EL1 trapping controls
> > work?
> 
> We'd trap the IMPDEF register access and inject an UNDEF (assuming that
> the IMPDEF trapping works correctly). I have strictly no plan to support
> this in a guest.

Ah, so we could actually configure that in el2_setup and solve the host
problem if we're entered at EL2. Agustin -- does that work, and what do we
need to do if the host is entered at EL1?

Will
