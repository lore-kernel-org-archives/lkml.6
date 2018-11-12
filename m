Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E759C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A2320866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCznycJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A2320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeKLK1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:27:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35318 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbeKLK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pzpoDWHhT7ek0tQS7IcyOew/G2DS0MvOWPxB8UkCUDo=; b=XCznycJ6e4KEyqWZUxBnAherQ8
        f8Sh1QV43lDk8t1pGI9NKMtSvwMl4rcxB/jmBusPGkE9+yuv4NGpyU0/GKxU3vperh1XEu4+fUbAP
        or5FUnMer3GtSL8FWbPAqNIiaEn8vDGQsi+RTI2HJoXhB6/t6ms6AMvM/4vdM2hR7SZNrcxXqdoTg
        jKd1zpq4zQNrr+0QWW5W6+hkRhQ2hWzdXcLW22MLbQSn5jVrxef3o98Llkki9A1S5n1tJ1wVmfVxw
        eqggsexVtyKyRuK2FM6thSdZZCUJank44Vo2L+uiJ9KbuR9z3609wdV6Gkdb8/EKM1j+auc+L6Qne
        v9dpDPIg==;
Received: from [64.114.255.97] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM0DX-0004WC-EF; Mon, 12 Nov 2018 00:36:39 +0000
Received: by worktop (Postfix, from userid 1000)
        id 8CECA6E061A; Mon, 12 Nov 2018 01:36:38 +0100 (CET)
Date:   Mon, 12 Nov 2018 01:36:38 +0100
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
Message-ID: <20181112003638.GA3082@worktop>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com>
 <20181111145936.GA3021@worktop>
 <43C8C690-F079-4513-82CD-46A62DBA5A3B@vmware.com>
 <20181111235220.GB3056@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181111235220.GB3056@worktop>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:52:20AM +0100, Peter Zijlstra wrote:
> On Sun, Nov 11, 2018 at 08:53:07PM +0000, Nadav Amit wrote:
> 
> > >> +	/*
> > >> +	 * The lock is not really needed, but this allows to avoid open-coding.
> > >> +	 */
> > >> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> > >> +
> > >> +	/*
> > >> +	 * If we failed to allocate a PTE, fail. This should *never* happen,
> > >> +	 * since we preallocate the PTE.
> > >> +	 */
> > >> +	if (WARN_ON_ONCE(!ptep))
> > >> +		goto out;
> > > 
> > > Since we hard rely on init getting that right; can't we simply get rid
> > > of this?

> > If it is about the way the source code looks - I guess it doesn’t sore my
> > eyes as hard as some other stuff, and I cannot do much about it (other than
> > removing it as you asked).

FWIW per the same argument we should be checking if poking_mm is !NULL.
We also don't do that.
