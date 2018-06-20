Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AADFC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFC3208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFC3208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeFTKQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:16:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59753 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753930AbeFTKQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:16:52 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVaAG-0003AF-Rb; Wed, 20 Jun 2018 12:16:37 +0200
Date:   Wed, 20 Jun 2018 12:16:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
In-Reply-To: <20180620101241.5vhmyvdjbenldp4r@shbuild888>
Message-ID: <alpine.DEB.2.21.1806201214310.10546@nanos.tec.linutronix.de>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-8-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de> <20180620101241.5vhmyvdjbenldp4r@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Feng Tang wrote:
> On Wed, Jun 20, 2018 at 01:52:10AM +0200, Thomas Gleixner wrote:
> >  
> >  static DEFINE_STATIC_KEY_FALSE(__use_tsc);
> > +static DEFINE_STATIC_KEY_TRUE(tsc_early_enabled);
> 
> One potential problem may be the several static_keys used here,
> the "__use_tsc", the "__sched_clock_stable", it may not be used
> very early in boot phase. As the the static_branch_enable() will
> use pageing related code while the paging is not setup ready yet.

I know how static keys work and thats the reason for having the extra
conditional. The key is disabled at a point where paging is available.

> >  /*
> >   * Scheduler clock - returns current time in nanosec units.
> >   */
> >  u64 native_sched_clock(void)
> >  {
> > -	if (static_branch_likely(&__use_tsc)) {
> > -		u64 tsc_now = rdtsc();
> > +	if (static_branch_likely(&__use_tsc))
> > +		return cycles_2_ns(rdtsc());
> >  
> > -		/* return the value in ns */
> > -		return cycles_2_ns(tsc_now);
> > +	if (static_branch_unlikely(&tsc_early_enabled)) {
> > +		if (tsc_early_sched_clock)
> > +			return cycles_2_ns(rdtsc());
> >  	}

Thanks,

	tglx
