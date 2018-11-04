Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4BAC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FAA2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FAA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeKEGOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 01:14:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33428 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeKEGOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 01:14:49 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJPTR-0002P5-ML; Sun, 04 Nov 2018 21:58:22 +0100
Date:   Sun, 4 Nov 2018 21:58:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <namit@vmware.com>
cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/7] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
In-Reply-To: <20181102232946.98461-2-namit@vmware.com>
Message-ID: <alpine.DEB.2.21.1811042153430.10744@nanos.tec.linutronix.de>
References: <20181102232946.98461-1-namit@vmware.com> <20181102232946.98461-2-namit@vmware.com>
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

On Fri, 2 Nov 2018, Nadav Amit wrote:

> text_mutex is expected to be held before text_poke() is called, but we
> cannot add a lockdep assertion since kgdb does not take it, and instead
> *supposedly* ensures the lock is not taken and will not be acquired by
> any other core while text_poke() is running.
> 
> The reason for the "supposedly" comment is that it is not entirely clear
> that this would be the case if gdb_do_roundup is zero.
> 
> Add a comment to clarify this behavior, and restore the assertions as
> they were before the recent commit.

It restores nothing. It just removes the assertion.

> This partially reverts commit 9222f606506c ("x86/alternatives:
> Lockdep-enforce text_mutex in text_poke*()")

That opens up the same can of worms again, which took us a while to close.

Can we please instead split out the text_poke() code into a helper function
and have two callers:

    text_poke() which contains the assert

    text_poke_kgdb() which does not

Thanks,

	tglx
