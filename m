Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC700C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3375272DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dKoAnec0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3375272DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965645AbeF1LrH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:47:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933933AbeF1LrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TcAM7vpWeW9JbkdbBEj1QaU68boBMzAQSJAhI1EDWOU=; b=dKoAnec0CaNRMfEK51clWgjMd
        NKxr6cR5C4quKtH0bxmTsW1AfkIT/CsNCK97v4gRxZFLbWDTYNt43DmAAiLv4KBwPoFOclrlNNzW4
        fv7Is1Gxq0TcgAlNUikLASOj07ticyMEPXvU37N7maQnPmUHq9IF/W8ORU93WkIFOd8AC2CwpCcWU
        kMnVoBJmUNnznlDuO+TKy4ZRSpiJOVR727nAwL9OzXTxIQLst/+vcImw3oJovP6GlPFdbz4wbbKWY
        mY/eCt0TIs7AVvyidElMrc83CegCyiy72aK/SHfNGAdgETBHrk90kLjJbfJ/f/OcwImzmWdDn1NPm
        zqva22NUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYVNT-0002jb-93; Thu, 28 Jun 2018 11:46:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4D2220289CE5; Thu, 28 Jun 2018 13:46:15 +0200 (CEST)
Date:   Thu, 28 Jun 2018 13:46:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        douly.fnst@cn.fujitsu.com, Prarit Bhargava <prarit@redhat.com>,
        feng.tang@intel.com, Petr Mladek <pmladek@suse.com>,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
Message-ID: <20180628114615.GF2494@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
 <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
 <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:43:59PM +0200, Thomas Gleixner wrote:
> 	init_hypervisor_platform()
> 	   vmware:
> 	           Retrieves frequency and store it for the
> 		   calibration function
> 
> 		   khz = vmware_get_khz_magic()
> 		   vmware_tsc_khz = khz
> 		   calibrate_cpu = vmware_get_tsc_khz
> 	   	   calibrate_tsc = vmware_get_tsc_khz
> 		   preset_lpj(khz)
> 
>  	   hyperv:
> 		   if special hyperv MSRs are available:
> 
> 		      calibrate_cpu = hv_get_tsc_khz
> 		      calibrate_tsc = hv_get_tsc_khz
> 
> 		   MSR is readable already in this function
> 
> 	   jailhouse:
> 	   
> 		   Frequency is available in this function and store
> 		   in a variable for the calibration function
> 
> 		   calibrate_cpu	= jailhouse_get_tsc
> 		   calibrate_tsc	= jailhouse_get_tsc
> 
> 	...
> 	
> 	kvmclock_init()
> 
> 		if (magic_conditions)
> 			calibrate_tsc = kvm_get_tsc_khz
> 			calibrate_cpu = kvm_get_tsc_khz
> 
> 			kvm_get_preset_lpj()
> 			   khz = kvm_get_tsc_khz()
> 			   preset_lpj(khz);

Note that all these which get TSC values from a HV _should_ set
X86_FEATURE_TSC_KNOWN_FREQ to avoid the late recalibrate.

Calibrating against a virtual PIT/HPET/PMTIMER is utterly pointless.

> The generic initilizaiton does everything twice, which makes no sense,
> except for the unlikely case were no fast functions are available and the
> quick PIT calibration fails (PMTIMER/HPET) are not available in early
> calibration. HPET 

Incomplete; but I suspect you want to talk about how we can make HPET
available early by putting it in a fixmap.

And only if we fail, do we at a later stage try again using PMTIMER.

Currently it all works by accident, since !hpet and acpi_pm_read_early()
returns 0, but really we should not be running the fallback crap at all
that early.
