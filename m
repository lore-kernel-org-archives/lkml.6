Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A34C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 04:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FDB24946
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 04:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FDB24946
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbeFWEVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 00:21:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:24346 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbeFWEVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 00:21:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 21:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,260,1526367600"; 
   d="scan'208";a="65619580"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2018 21:21:03 -0700
Date:   Fri, 22 Jun 2018 21:20:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
Message-ID: <20180623042033.GF18979@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:49:00PM +0200, Thomas Gleixner wrote:
> On Sun, 27 May 2018, Fenghua Yu wrote:
> > +static void wait_for_reexecution(void)
> > +{
> > +	while (time_before(jiffies, disable_split_lock_jiffies +
> > +			   reenable_split_lock_delay))
> > +		cpu_relax();
> > +}
> > +
> > +/*
> > + * TEST_CTL MSR is shared among threads on the same core. To simplify
> > + * situation, disable_split_lock_jiffies is global instead of per core.
> 
> This patch surely earns extra points in the trainwreck engineering contest,
> but that's not taking place on LKML.
> 
> The whole thing is simply:
> 
> handle_ac()
> {
> 	if (user_mode(regs)) {
> 		 do_trap(AC, SIGBUS, ...);
> 	} else {
> 		disable_ac_on_local_cpu();
> 		WARN_ONCE(1);
> 	}
> }

Should I add kernel parameter or control knob to opt-out the feature?
I'm afraid firmware may hang system after handling split lock if the
feature is enabled by kernel, e.g. "reboot" hits split lock in firmware
and firmware hangs the system after handling #AC.

Thanks.

-Fenghua
