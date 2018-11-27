Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD7AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696AD2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696AD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeK0VQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:16:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeK0VQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:16:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4063563;
        Tue, 27 Nov 2018 02:18:47 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9D703F575;
        Tue, 27 Nov 2018 02:18:47 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6D20C1AE0A0D; Tue, 27 Nov 2018 10:19:05 +0000 (GMT)
Date:   Tue, 27 Nov 2018 10:19:05 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "catalin.marinas@armm.com" <catalin.marinas@armm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Message-ID: <20181127101904.GA2928@arm.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
 <20181126192101.GC32208@kroah.com>
 <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20181126195727.GA9957@kroah.com>
 <CY4PR21MB0773AFA3555BC08A4CC129D4D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20181127062056.GA30285@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127062056.GA30285@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 07:20:56AM +0100, Greg KH wrote:
> On Mon, Nov 26, 2018 at 08:56:50PM +0000, Michael Kelley wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>  Monday, November 26, 2018 11:57 AM
> > 
> > > > > You created "null" hooks that do nothing, for no one in this patch
> > > > > series, why?
> > > > >
> > > >
> > > > hv_enable_vmbus_irq() and hv_disable_vmbus_irq() have non-null
> > > > implementations in the ARM64 code in patch 2 of this series.  The
> > > > implementations are in the new file arch/arm64/hyperv/mshyperv.c.
> > > > Or am I misunderstanding your point?
> > > 
> > > So you use a hook in an earlier patch and then add it in a later one?
> > > 
> > > Shouldn't you do it the other way around?  As it is, the earlier patch
> > > should not work properly, right?
> > 
> > The earlier patch implements the hook on the ARM64 side but it is
> > unused -- it's not called.  The later patch then calls it.  Wouldn't the
> > other way around be backwards?
> 
> Ah, it wasn't obvious that the previous patch added it at all, why not
> just make that addition part of this patch?
> 
> > The general approach is for patches 1 and 2 of the series to provide
> > all the new code under arch/arm64 to enable Hyper-V.  But the code
> > won't get called (or even built) with just these two patches because
> > CONFIG_HYPERV can't be selected.  Patch 3 is separate because it
> > applies to architecture independent code and arch/x86 code -- I thought
> > there might be value in keeping the ARM64 and x86 patches distinct. 
> > Patch 4 applies to architecture independent code, and enables the
> > ARM64 code in patches 1 and 2 to be compiled and run when
> > CONFIG_HYPERV is selected.
> > 
> > If combining some of the patches in the series is a better approach, I'm
> > good with that.
> 
> Ok, that makes more sense, if it is easier to get the ARM people to
> review this, that's fine.  Doesn't seem like anyone did that yet :(

It's on the list, but thanks for having a look as well!

Will
