Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04814C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94762089D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94762089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936919AbeF2QX7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:23:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59399 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933566AbeF2QX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:23:58 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fYwBM-0002ew-FQ; Fri, 29 Jun 2018 18:23:36 +0200
Date:   Fri, 29 Jun 2018 18:23:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] x86/split_lock: Enumerate #AC exception for split
 locked access feature
In-Reply-To: <b0267bb2-7d1f-c1d6-cff8-addf358009b3@intel.com>
Message-ID: <alpine.DEB.2.21.1806291813570.1595@nanos.tec.linutronix.de>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com> <1530282807-66555-2-git-send-email-fenghua.yu@intel.com> <b0267bb2-7d1f-c1d6-cff8-addf358009b3@intel.com>
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

On Fri, 29 Jun 2018, Dave Hansen wrote:
> On 06/29/2018 07:33 AM, Fenghua Yu wrote:
> > +/* Detect feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
> > +void detect_ac_split_lock(void)
> > +{
> > +	u64 val, orig_val;
> > +	int ret;
> > +
> > +	/* Attempt to read the MSR. If the MSR doesn't exist, reading fails. */
> > +	ret = rdmsrl_safe(MSR_TEST_CTL, &val);
> > +	if (ret)
> > +		return;
> 
> This is a bit fast and loose with how the feature is detected, which
> might be OK, but can we call out why we are doing this, please?
> 
> Is this MSR not really model-specific?  Is it OK to go poking at it on
> all x86 variants?  Or, do we at _least_ need a check for Intel cpus in here?

That definitely needs a vendor check. Also the whole code needs to be
compiled out if CONFIG_INTEL=n.

Aside of that this wants to be enumerated. CPUID or MISC_FEATURES and not
this guess work detection logic. Why do I have to ask for that for every
other new feature thingy?

And pretty please, can we either stick that stuff into cpu/intel.c or if it
really needs a separate file avoid that horrible test_ctl.c file name? 

Thanks,

	tglx







