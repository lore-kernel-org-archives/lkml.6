Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E3DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F82420866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmGx6FH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F82420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbeKLJnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:43:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732805AbeKLJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 04:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=th1rmqCpMYiiklaGsc/pvZstvmyZeNYPsd+TYfPYQic=; b=RmGx6FH/lAZmpS0VCBrmIi/gVF
        azPTK5Y+8G84h4tQ+Ecw7SkhS6pK2dlsi0P2AWcxPt95VTcIm0FlmXE/sVoVh697k8zn0RT+9AfBz
        MXKp+lVBCZiP+P2R6ggDLjvkBM4GzFE6bUf+r+BaUxQ999iVkQcSdvfMSt9WEI4JpbtpNKNg2gBaw
        6lQ3lbDjPwUvIKT+nvfgD/Rx2FDlbWx3Eum2fE3jpJZhcZ/3JjlGGUZB7EDHAbhPvcPaw4+wLaL5O
        S4GbMH/w9/u/RQ1e0diSBKTNrGOwHuW16TyyZ8w4xs4lBvY7AHOLw5s0fGMsouWVLkHGF/fUr2dkH
        fbERvxhg==;
Received: from [64.114.255.97] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLzWi-00046q-8u; Sun, 11 Nov 2018 23:52:24 +0000
Received: by worktop (Postfix, from userid 1000)
        id 5E4216E061A; Mon, 12 Nov 2018 00:52:20 +0100 (CET)
Date:   Mon, 12 Nov 2018 00:52:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Message-ID: <20181111235220.GB3056@worktop>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com>
 <20181111145936.GA3021@worktop>
 <43C8C690-F079-4513-82CD-46A62DBA5A3B@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43C8C690-F079-4513-82CD-46A62DBA5A3B@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 08:53:07PM +0000, Nadav Amit wrote:

> >> +	/*
> >> +	 * The lock is not really needed, but this allows to avoid open-coding.
> >> +	 */
> >> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> >> +
> >> +	/*
> >> +	 * If we failed to allocate a PTE, fail. This should *never* happen,
> >> +	 * since we preallocate the PTE.
> >> +	 */
> >> +	if (WARN_ON_ONCE(!ptep))
> >> +		goto out;
> > 
> > Since we hard rely on init getting that right; can't we simply get rid
> > of this?
> 
> This is a repeated complaint of yours, which I do not feel comfortable with.
> One day someone will run some static analysis tool and start finding that
> all these checks are missing.
> 
> The question is why do you care about them.

Mostly because they should not be happening, ever. And if they happen,
there really isn't anything sensible we can do about it.

> If it is because they affect the
> generated code and make it less efficient, I can fully understand and perhaps
> we should have something like PARANOID_WARN_ON_ONCE() which compiles into nothing
> unless a certain debug option is set.
> 
> If it is about the way the source code looks - I guess it doesn’t sore my
> eyes as hard as some other stuff, and I cannot do much about it (other than
> removing it as you asked).

And yes on the above two points. It adds both runtime overhead (albeit
trivially small) and code complexity.

> >> +out:
> >> +	if (memcmp(addr, opcode, len))
> >> +		r = -EFAULT;
> > 
> > How could this ever fail? And how can we reliably recover from that?
> 
> This code has been there before (with slightly uglier code). Before this
> patch, a BUG_ON() was used here. However, I noticed that kgdb actually
> checks that text_poke() succeeded after calling it and gracefully fail.
> However, this was useless, since text_poke() would panic before kgdb gets
> the chance to do anything (see patch 7).

Yes, I know it was there before, and I did see kgdb do it too. But aside
from that out-label case, which we also should never hit, how can we
realistically ever fail that memcmp()?

If we fail here, something is _seriously_ buggered.
