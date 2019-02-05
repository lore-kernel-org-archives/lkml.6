Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAF4C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5634D218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PoMhzwSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBENaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:30:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46096 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBENa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CVKHIuEvj5JGw+bPxiuecR8XPRMXnKXfH5LmqCODJr0=; b=PoMhzwScDlbzVjbkRBMfS4MZr
        XfllCw3u9d26TcsNbDc093sC1RxuPXDZdQHSK2vTbLzwL0ojT3aZp0xe4o9jyt6A0d5fQOCSYHUih
        6CF3lbljAfVseZghqn6Pau0P5tXLAO6zQQcAGTTjRx862pUtQgZIEQwub/rYZPsmd6yqPnj0TGBVs
        ElzmBbTUGISW5G0NVPgVofxdS7/o1cgNo8R1wO/E43lLvGAy0Ljfc0lF85dD8t8x/RDAE29wcXiT0
        YTsQpytF2iY8zJOfEEnJwEpajF0ODa1Q2SMkWVJhldOFAkFR5r6YXvmenPbdZ7AVxX3z7cOOCcMxP
        ophLotiNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gr0nT-00047L-1s; Tue, 05 Feb 2019 13:29:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C67B82029F1D6; Tue,  5 Feb 2019 14:29:53 +0100 (CET)
Date:   Tue, 5 Feb 2019 14:29:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 06/20] x86/alternative: use temporary mm for text
 poking
Message-ID: <20190205132953.GF17582@hirez.programming.kicks-ass.net>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-7-rick.p.edgecombe@intel.com>
 <20190205095853.GJ21801@zn.tnic>
 <20190205113146.GP17528@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205113146.GP17528@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:31:46PM +0100, Peter Zijlstra wrote:
> In general, text_poke() cannot fail:
> 
>  - suppose changing a single jump label requires poking multiple sites
>    (not uncommon), we fail halfway through and then have to undo the
>    first pokes, but those pokes fail again.
> 
>  - this then leaves us no way forward and no way back, we've got
>    inconsistent text state -> FAIL.

Note that this exact fail scenario still exists in the CPU hotplug code.
See kernel/cpu.c:cpuhp_thread_fun():

		/*
		 * If we fail on a rollback, we're up a creek without no
		 * paddle, no way forward, no way back. We loose, thanks for
		 * playing.
		 */
		WARN_ON_ONCE(st->rollback);
