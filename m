Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD30C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F2720862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WyLPlEiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F2720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeKEWul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:50:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38062 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeKEWul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7q3qQsrEV0c0vXgpBQ/CPUcok1k4P+DxyQ3B9rtSBog=; b=WyLPlEiFh0tmydKtdUIDjlE9P
        3qc/3ssuRPuT8+D/+BVEONpr7DCS/K7ei0YjYxpys2qLuTC5e7fahALcSHAITBihJY7/WkBicZ16M
        T8BMCSYDr8R/VoI4IZdq4VhRtda5WbnFFxb8e3catiTwono/Vmf3GELZNKVk+jlLMGKhpB0Q7ELy/
        +OII9UHZLQ8/6BwwJUUKGFtZ2giTP4AXHyfG6RGyqXXVNH69rgOYhsRarF2eycF+SVidsDXRHiT7P
        vWvrSs6dsdaj4dhaThUSJKEn17wab1Ki7pdminT94pPWSwAv3G429NvQ8KN0cV5LsjtXnFUq4B50f
        RCmlzeUpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJexm-0006LS-SH; Mon, 05 Nov 2018 13:30:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49A662029F9FF; Mon,  5 Nov 2018 14:30:41 +0100 (CET)
Date:   Mon, 5 Nov 2018 14:30:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text poking
Message-ID: <20181105133041.GC22467@hirez.programming.kicks-ass.net>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-7-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102232946.98461-7-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:29:45PM -0700, Nadav Amit wrote:
> +	unuse_temporary_mm(prev);
> +
> +	pte_unmap_unlock(ptep, ptl);

That; that does kunmap_atomic() on 32bit.

I've been thinking that the whole kmap_atomic thing on x86_32 is
terminally broken, and with that most of x86_32 is.

kmap_atomic does the per-cpu fixmap pte fun-and-games we're here saying
is broken. Yes, only the one CPU will (explicitly) use those fixmap PTEs
and thus the local invalidate _should_ work. However nothing prohibits
speculation on another CPU from using our fixmap addresses. Which can
lead to the remote CPU populating its TLBs for our fixmap entry.

And, as we've found, there are AMD parts that #MC when there are
mis-matched TLB entries.

So what do we do? mark x86_32 SMP broken?
