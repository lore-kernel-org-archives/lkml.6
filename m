Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3B5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDC22082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="L32ktgCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfBDQFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:05:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52936 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731157AbfBDQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:05:09 -0500
Received: from zn.tnic (p200300EC2BC6E200ECEE10EFADD37342.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:e200:ecee:10ef:add3:7342])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CBF621EC05DE;
        Mon,  4 Feb 2019 17:05:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549296308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3AIdePTllVGNB2q8FLpzQAUdwmv5WRTEywP7Gg0EOCw=;
        b=L32ktgCSjfQuP/LluoA5SuDDUGyyAVdi1ETBuDusUA5paROh1Pqzp7sr+fzh12Q7D8TRkd
        xzp39ay2fy6uCyBQ1LNq3J82GwcgGW11C/w/mxvf92BZWJFLIs0LQ0wcemsU25D0jqCgKv
        jCSXRLCg8DgS8v0/FXI7qgQl0AM4JCw=
Date:   Mon, 4 Feb 2019 17:04:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204160454.GE29639@zn.tnic>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:57:32AM -0500, Liang, Kan wrote:
> 
> 
> On 2/4/2019 10:44 AM, Peter Zijlstra wrote:
> > On Mon, Feb 04, 2019 at 04:38:27PM +0100, Peter Zijlstra wrote:
> > > +static const struct x86_cpu_desc isolation_ucodes[] = {
> > > +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
> > > +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
> > > +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
> > > +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
> > 
> > > +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	10, 0x0000004e),
> > > +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	11, 0x0000004e),
> > > +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	12, 0x0000004e),
> > > +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	13, 0x0000004e),
> > 
> > Do we want a special stepping (0 / -1) to be able to denote 'all' ?
> > 
> 
> Something like as below?
> #define X86_STEPPING_ANY	0xff
> 
> As my understanding, the microcode version for each stepping is independent
> and irrelevant.

Huh?

Why are we looking at the stepping then?

x86_match_cpu_with_stepping() <---

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
