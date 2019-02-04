Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17FBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FBA214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0GrOLa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfBDQXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:23:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfBDQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YbPoXZT4tPvaLyEp61mquF5320JlhgAg1QgXPcoiUzw=; b=l0GrOLa/LoGXOZ/F75y4kLSmF
        ZIGeEcuReljGzr6QwY01ZkEj623q+U2VPfn5kL1EpeDJ3AEkrOXe+0sWNwdMKnecmMHB7nfgw2s8r
        Clsk9sUMYRJ0p13aIejmhNV4B19Cz3XPOa6BxJoESIBEggebNlhu1eblds9AECgzpBKk+mkB1XXCw
        saHHkYmPquowY2eUmN5EGkQiW2ijj68XLiSfhsLwmPiavbM57wCjlTSOOk6TElfECy38+b4oWfh17
        a9yPQOvH4vak/hlNxcK+E3itJKMJ6czFgvAzE5++pKUwITchtdstWnTIukYF0R0rXHQXyxf2U9IuI
        o95eRFJwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqh1d-0007GT-Tg; Mon, 04 Feb 2019 16:23:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F9712029FA06; Mon,  4 Feb 2019 17:23:12 +0100 (CET)
Date:   Mon, 4 Feb 2019 17:23:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204162312.GJ17528@hirez.programming.kicks-ass.net>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> and irrelevant. The 0x0000004e should be just coincidence.
> If so, I don't think X86_STEPPING_ANY is very useful.

Sure; but since we have this happy accident, we can still use it for a
notational convenience, right?
