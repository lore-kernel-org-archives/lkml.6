Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC7FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE6C20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE6C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeFTK1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:27:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:31036 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeFTK1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:27:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 03:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="50809752"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2018 03:27:33 -0700
Date:   Wed, 20 Jun 2018 18:29:46 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
Message-ID: <20180620102946.jdvyvv7jvhhjvskv@shbuild888>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-8-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de>
 <20180620101241.5vhmyvdjbenldp4r@shbuild888>
 <alpine.DEB.2.21.1806201214310.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806201214310.10546@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:16:36PM +0200, Thomas Gleixner wrote:
> On Wed, 20 Jun 2018, Feng Tang wrote:
> > On Wed, Jun 20, 2018 at 01:52:10AM +0200, Thomas Gleixner wrote:
> > >  
> > >  static DEFINE_STATIC_KEY_FALSE(__use_tsc);
> > > +static DEFINE_STATIC_KEY_TRUE(tsc_early_enabled);
> > 
> > One potential problem may be the several static_keys used here,
> > the "__use_tsc", the "__sched_clock_stable", it may not be used
> > very early in boot phase. As the the static_branch_enable() will
> > use pageing related code while the paging is not setup ready yet.
> 
> I know how static keys work and thats the reason for having the extra
> conditional. The key is disabled at a point where paging is available.

Maybe I'm wrong, for printk timestamp, it uses the local_clock() thus
    sched_clock_cpu()
	sched_clock_stable
	    check the static_key "__sched_clock_stable" which is
	    defined FALSE, and need a static_branch_enable() to
	    take effect

Thanks,
Feng

> 
> > >  /*
> > >   * Scheduler clock - returns current time in nanosec units.
> > >   */
> > >  u64 native_sched_clock(void)
> > >  {
> > > -	if (static_branch_likely(&__use_tsc)) {
> > > -		u64 tsc_now = rdtsc();
> > > +	if (static_branch_likely(&__use_tsc))
> > > +		return cycles_2_ns(rdtsc());
> > >  
> > > -		/* return the value in ns */
> > > -		return cycles_2_ns(tsc_now);
> > > +	if (static_branch_unlikely(&tsc_early_enabled)) {
> > > +		if (tsc_early_sched_clock)
> > > +			return cycles_2_ns(rdtsc());
> > >  	}
> 
> Thanks,
> 
> 	tglx
