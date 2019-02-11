Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43C0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E03F20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBKJPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:15:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfBKJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:15:07 -0500
Received: from [5.158.153.53] (helo=nanos.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gt7g8-0000Zl-9H; Mon, 11 Feb 2019 10:15:04 +0100
Date:   Mon, 11 Feb 2019 10:15:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/alternatives: check int3 breakpoint physical
 addresses
In-Reply-To: <8995b3b4-b805-c8c7-95a8-a39ab000f289@oracle.com>
Message-ID: <alpine.DEB.2.21.1902111012130.1728@nanos.tec.linutronix.de>
References: <1548428249-8258-1-git-send-email-alexandre.chartre@oracle.com> <alpine.DEB.2.21.1902102221500.8784@nanos.tec.linutronix.de> <8995b3b4-b805-c8c7-95a8-a39ab000f289@oracle.com>
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

On Mon, 11 Feb 2019, Alexandre Chartre wrote:
> On 02/10/2019 10:23 PM, Thomas Gleixner wrote:
> > On Fri, 25 Jan 2019, Alexandre Chartre wrote:
> > > Note that this issue has been observed and reproduced with a custom kernel
> > > with some code mapped to different virtual addresses and using jump labels
> > > As jump labels use text_poke_bp(), crashes were sometimes observed when
> > > updating jump labels.
> > 
> > Rightfully so. text_poke_bp() pokes at the kernels text mapping which is
> > very well defined and unique. Why would you map the same text to different
> > virtual addresses and then use a randomly chosen one to poke at it?
> > 
> 
> As an example, we used to have per-CPU SYSCALL entry trampoline [1] where the
> entry_SYSCALL_64_trampoline function was mapped to a different virtual address
> for each CPU. So, a syscall would execute entry_SYSCALL_64_trampoline() from a
> different virtual address depending on the CPU being used. With that code,
> adding a jump label in entry_SYSCALL_64_trampoline() causes the described
> issue.

Right, but we knew that and there was no reason to put a jump label into
that. AFAICT we don't have anything like this in the kernel.

That said, I'm not opposed to apply the patch as is, I just wanted to get a
better understanding about the background.

Thanks,

	tglx
