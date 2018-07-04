Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73473C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2599D2411C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2599D2411C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeGDUHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:07:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeGDUHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:07:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC86B5D5EE;
        Wed,  4 Jul 2018 20:07:44 +0000 (UTC)
Received: from localhost (ovpn-116-35.gru2.redhat.com [10.97.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A6DB611A1;
        Wed,  4 Jul 2018 20:07:43 +0000 (UTC)
Date:   Wed, 4 Jul 2018 17:07:42 -0300
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] x86/split_lock: Enumerate #AC exception for split
 locked access feature
Message-ID: <20180704200742.GD7451@localhost.localdomain>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-2-git-send-email-fenghua.yu@intel.com>
 <b0267bb2-7d1f-c1d6-cff8-addf358009b3@intel.com>
 <alpine.DEB.2.21.1806291813570.1595@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806291813570.1595@nanos.tec.linutronix.de>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 04 Jul 2018 20:07:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 06:23:35PM +0200, Thomas Gleixner wrote:
> On Fri, 29 Jun 2018, Dave Hansen wrote:
> > On 06/29/2018 07:33 AM, Fenghua Yu wrote:
> > > +/* Detect feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
> > > +void detect_ac_split_lock(void)
> > > +{
> > > +	u64 val, orig_val;
> > > +	int ret;
> > > +
> > > +	/* Attempt to read the MSR. If the MSR doesn't exist, reading fails. */
> > > +	ret = rdmsrl_safe(MSR_TEST_CTL, &val);
> > > +	if (ret)
> > > +		return;
> > 
> > This is a bit fast and loose with how the feature is detected, which
> > might be OK, but can we call out why we are doing this, please?
> > 
> > Is this MSR not really model-specific?  Is it OK to go poking at it on
> > all x86 variants?  Or, do we at _least_ need a check for Intel cpus in here?
> 
> That definitely needs a vendor check. Also the whole code needs to be
> compiled out if CONFIG_INTEL=n.
> 
> Aside of that this wants to be enumerated. CPUID or MISC_FEATURES and not
> this guess work detection logic. Why do I have to ask for that for every
> other new feature thingy?

Yes, please.  KVM hosts normally expect guests to not touch MSRs
unless we explicitly tell them the MSR is available (normally
through CPUID).  This is important to ensure live migration
between different host kernel versions works reliably.

-- 
Eduardo
