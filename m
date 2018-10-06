Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B17C67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B05A2064E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="jl1SI7Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B05A2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJGBT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 21:19:27 -0400
Received: from one.firstfloor.org ([193.170.194.197]:41102 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeJGBT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 21:19:27 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id BF7698685A; Sat,  6 Oct 2018 20:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1538849707;
        bh=+ktsTVUoJoStPSD6DIjCujmVck2OP9oLOzqisvTCh1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jl1SI7Tz/0qcLIMnHEx/yWbzIJV49gvk/hQ/KDFyRAwZZDf70QUw0hXwCaTWufySR
         HZFyQlQd8MO6r8YtbmmqIZF93KIcQkcvKg03m821zQ5hxPeR8mGW7PXoVb7ZWZakG7
         Bx27UAqjmFqIPv2sHB6SwLoOfew9SyzUaKX4yAl4=
Date:   Sat, 6 Oct 2018 11:15:07 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        kan.liang@intel.com, isaku.yamahata@intel.com, kvm@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 1/2] x86/cpufeature: Add facility to match microcode
 revisions
Message-ID: <20181006181506.7cycnsg5gtoavtmx@two.firstfloor.org>
References: <20181006001928.28097-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1810061555270.5454@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810061555270.5454@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 04:14:54PM +0200, Thomas Gleixner wrote:
> On Fri, 5 Oct 2018, Andi Kleen wrote:
> > +/*
> > + * Match specific microcodes or steppings.
> 
> What means microcodes or steppings? If you mean microcode revisions then
> please spell it out and use it all over the place. steppings is confusing
> at best as its associated to the CPU stepping.

The matcher can be used to match specific hardware steppings by setting
the min/max_ucode to 0 or specific microcode revisions 
(which are associated with steppings) 

> > +const struct x86_ucode_id *x86_match_ucode_all(const struct x86_ucode_id *match)
> 
> Can you please name that so it's obvious that this checks all cpus, but
> aside of that, why would a system ever end up with different microcode
> revisions at all? The changelog is not mentioning any reason for this
> function and "/* Check all CPUs */" is not helpful either.

We still support the old microcode interface that allows updates
per CPU, and also it could happen during CPU hotplug.

> 
> > +	int cpu;
> > +	const struct x86_ucode_id *all_m = NULL;
> > +	bool first = true;
> > +
> > +	for_each_online_cpu(cpu) {
> 
> What guarantees that CPUs cannot be plugged? You either need to have
> cpus_read_lock() in this function or a lockdep_assert_cpus_held().

In my case the caller, but yes should be documented.

-Andi
