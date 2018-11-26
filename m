Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E482EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93A420862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR+JimNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93A420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeK0Gwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbeK0Gwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:52:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7CC20664;
        Mon, 26 Nov 2018 19:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543262249;
        bh=lNGhGzTWpw0qgtqdEHZvw7uKPMnqA1k/BXCI2eFNUcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DR+JimNZvWzwJUHs6wW+jt3v0iVK3pkwUcEVh1Q/EE8Ne2RBnlE9hbEcEkzUKCr+k
         AbTecd6vfHjnjB0IOppK1CNpmIlROLUCuWyt71sBpQikWUgfTxN1lc0ajElT/TSZeX
         CinHAzh2ANvOjUBI6VHPJQiGVb7UsctFKhLlgVM4=
Date:   Mon, 26 Nov 2018 20:57:27 +0100
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
Message-ID: <20181126195727.GA9957@kroah.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
 <20181126192101.GC32208@kroah.com>
 <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:47:41PM +0000, Michael Kelley wrote:
> From: Greg KH <gregkh@linuxfoundation.org>  Monday, November 26, 2018 11:21 AM
> 
> > > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > > index 0d6271cce198..8d97bd3a13a6 100644
> > > --- a/arch/x86/include/asm/mshyperv.h
> > > +++ b/arch/x86/include/asm/mshyperv.h
> > > @@ -109,6 +109,10 @@ void hyperv_vector_handler(struct pt_regs *regs);
> > >  void hv_setup_vmbus_irq(void (*handler)(void));
> > >  void hv_remove_vmbus_irq(void);
> > >
> > > +/* On x86/x64, there isn't a real IRQ to be enabled/disable */
> > > +static inline void hv_enable_vmbus_irq(void) {}
> > > +static inline void hv_disable_vmbus_irq(void) {}
> > > +
> > >  void hv_setup_kexec_handler(void (*handler)(void));
> > >  void hv_remove_kexec_handler(void);
> > >  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> > > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > > index 166c2501de17..d0bb09a4bd73 100644
> > > --- a/drivers/hv/hv.c
> > > +++ b/drivers/hv/hv.c
> > > @@ -307,6 +307,7 @@ int hv_synic_init(unsigned int cpu)
> > >  	hv_set_siefp(siefp.as_uint64);
> > >
> > >  	/* Setup the shared SINT. */
> > > +	hv_enable_vmbus_irq();
> > >  	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> > >
> > >  	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > @@ -434,6 +435,7 @@ int hv_synic_cleanup(unsigned int cpu)
> > >  	/* Disable the global synic bit */
> > >  	sctrl.enable = 0;
> > >  	hv_set_synic_state(sctrl.as_uint64);
> > > +	hv_disable_vmbus_irq();
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.19.1
> > 
> > You created "null" hooks that do nothing, for no one in this patch
> > series, why?
> > 
> 
> hv_enable_vmbus_irq() and hv_disable_vmbus_irq() have non-null
> implementations in the ARM64 code in patch 2 of this series.  The
> implementations are in the new file arch/arm64/hyperv/mshyperv.c.
> Or am I misunderstanding your point?

So you use a hook in an earlier patch and then add it in a later one?

Shouldn't you do it the other way around?  As it is, the earlier patch
should not work properly, right?

thanks,

greg k-h
