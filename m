Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23901C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D549021104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqzgXf42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D549021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeK0RRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbeK0RRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:17:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4CFF208E4;
        Tue, 27 Nov 2018 06:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543299660;
        bh=Y8+fsSghj7a6U+nW9R6tZWaPwTjKthOd8ZxhM1P11dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqzgXf420FklRqiXjotB4wmVMsX0X2hSFe54iH1MWHj5sLg1H4jzBzGZzSgNd5pG9
         BkoYvqcdnXSkKJuIadGwwuWIjlEx6yhLnXHu2avB/mcH3ONL4B/QTk0TyY8JXDTNXj
         nGLyan+ftLGLUqnVubmY2hMryxE6jPOhnnmAQPBw=
Date:   Tue, 27 Nov 2018 07:20:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
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
Message-ID: <20181127062056.GA30285@kroah.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
 <20181126192101.GC32208@kroah.com>
 <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20181126195727.GA9957@kroah.com>
 <CY4PR21MB0773AFA3555BC08A4CC129D4D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB0773AFA3555BC08A4CC129D4D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 08:56:50PM +0000, Michael Kelley wrote:
> From: Greg KH <gregkh@linuxfoundation.org>  Monday, November 26, 2018 11:57 AM
> 
> > > > You created "null" hooks that do nothing, for no one in this patch
> > > > series, why?
> > > >
> > >
> > > hv_enable_vmbus_irq() and hv_disable_vmbus_irq() have non-null
> > > implementations in the ARM64 code in patch 2 of this series.  The
> > > implementations are in the new file arch/arm64/hyperv/mshyperv.c.
> > > Or am I misunderstanding your point?
> > 
> > So you use a hook in an earlier patch and then add it in a later one?
> > 
> > Shouldn't you do it the other way around?  As it is, the earlier patch
> > should not work properly, right?
> 
> The earlier patch implements the hook on the ARM64 side but it is
> unused -- it's not called.  The later patch then calls it.  Wouldn't the
> other way around be backwards?

Ah, it wasn't obvious that the previous patch added it at all, why not
just make that addition part of this patch?

> The general approach is for patches 1 and 2 of the series to provide
> all the new code under arch/arm64 to enable Hyper-V.  But the code
> won't get called (or even built) with just these two patches because
> CONFIG_HYPERV can't be selected.  Patch 3 is separate because it
> applies to architecture independent code and arch/x86 code -- I thought
> there might be value in keeping the ARM64 and x86 patches distinct. 
> Patch 4 applies to architecture independent code, and enables the
> ARM64 code in patches 1 and 2 to be compiled and run when
> CONFIG_HYPERV is selected.
> 
> If combining some of the patches in the series is a better approach, I'm
> good with that.

Ok, that makes more sense, if it is easier to get the ARM people to
review this, that's fine.  Doesn't seem like anyone did that yet :(

sorry for the noise,

greg k-h
