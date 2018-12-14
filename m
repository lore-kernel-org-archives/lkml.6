Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6926EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B682A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeLNSZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:25:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56170 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbeLNSZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:25:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50698EBD;
        Fri, 14 Dec 2018 10:25:22 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C1483F575;
        Fri, 14 Dec 2018 10:25:20 -0800 (PST)
Date:   Fri, 14 Dec 2018 18:25:18 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Hayward <Alan.Hayward@arm.com>
Subject: Re: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Message-ID: <20181214182518.GH3505@e103592.cambridge.arm.com>
References: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
 <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 06:13:33PM +0000, Szabolcs Nagy wrote:
> On 11/12/2018 19:26, Dave Martin wrote:
> > This patch refactors the UAPI header definitions for the Arm SVE
> > extension to avoid multiple-definition problems when userspace mixes its
> > own sigcontext.h definitions with the kernel's ptrace.h (which is
> > apparently routine).
> > 
> > A common backend header is created to hold common definitions, suitably
> > namespaced, and with an appropriate header guard.
> > 
> > See the commit message in patch 3 for further explanation of why this
> > is needed.
> > 
> > Because of the non-trivial header guard in the new sve_context.h, patch
> > 1 adds support to headers_install.sh to munge #if defined(_UAPI_FOO) in
> > a similar way to the current handling of #ifndef _UAPI_FOO.
> > 
> 
> thanks for doing this.
> 
> the patches fix the gdb build issue on musl libc with an
> additional gdb patch:
> https://sourceware.org/ml/gdb-patches/2018-12/msg00152.html
> (in userspace i'd expect users relying on signal.h providing
> whatever is in asm/sigcontext.h.)
> 
> i think sve_context.h could be made to work with direct include,
> even if that's not useful because there is no public api there.
> (and then you dont need the first patch)

My general view is that if you want the sigframe types userspace should
usually include <ucontext.h> and refer to mcontext_t.

Because the prototype for sa_sigaction() specifies a void * for the
ucontext argument, I've generally assumed that <signal.h> is not
sufficient to get ucontext_t (or mcontext_t) (but maybe I'm too paranoid
there).

Non-POSIX-flavoured software might include <asm/sigcontext.h> directly.
In glibc/musl libc will that conflict with <signal.h>, or can the two
coexist?

Cheers
---Dave
