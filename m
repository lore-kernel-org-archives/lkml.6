Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8BAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835FD2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd7p3DLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835FD2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeHaIy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbeHaIy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:54:57 -0400
Received: from devnote (sp183-74-193-25.msb.spmode.ne.jp [183.74.193.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2A720661;
        Fri, 31 Aug 2018 04:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535690959;
        bh=U0NG9maviC8qqYFqL/KUAaEuRM2wUpLC9+jP34PWwU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pd7p3DLa9B3iUd7rG4kPKGqbMs9UvvpAmTEQvxPPhWIAgVgkjf73F8GLg0gd06VWn
         FkkXWp6zepC+CzzZtQM7Xxw0uaPVFdpr4lBMzSoVNnMv3j9H8S9EDoGi7EtmMba8MS
         dBkc1Lk+IQrJ8hyUyJZrbQGLFE5G4TODBEvCUgUY=
Date:   Fri, 31 Aug 2018 13:49:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] x86/alternatives: text_poke() fixes
Message-Id: <20180831134916.f8c409da94baa492008b188e@kernel.org>
In-Reply-To: <20180831134635.35b6c2a919449adf4b63a133@kernel.org>
References: <20180830173218.238900-1-namit@vmware.com>
        <20180831134635.35b6c2a919449adf4b63a133@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 13:46:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 30 Aug 2018 10:32:12 -0700
> Nadav Amit <namit@vmware.com> wrote:
> 
> > This patch-set addresses some issues that were raised in a recent
> > correspondence and might affect the security and the correctness of code
> > patching. (Note that patching performance is not addressed by this
> > patch-set).
> > 
> > The main issue that the patches deal with is the fact that the fixmap
> > PTEs that are used for patching are available for access from other
> > cores and might be exploited. They are not even flushed from the TLB in
> > remote cores, so the risk is even higher. Address this issue by
> > introducing a temporary mm that is only used during patching.
> > Unfortunately, due to init ordering, fixmap is still used during
> > boot-time patching. Future patches can eliminate the need for it.
> > 
> > The second issue is the missing lockdep assertion to ensure text_mutex
> > is taken. It is actually not always taken, so fix the instances that
> > were found not to take the lock (although they should be safe even
> > without taking the lock).
> > 
> > Finally, try to be more conservative and to map a single page, instead
> > of two, when possible. This helps both security and performance.
> > 
> > In addition, there is some cleanup of the patching code to make it more
> > readable.
> 
> OK, this series looks good to me, and tested with ftracetest, kprobe testsets.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Oh, I missed a note.

To apply this series on -tip tree, we have to revert Jiri's text_mutex
checker.

9222f606506c ("x86/alternatives: Lockdep-enforce text_mutex in text_poke*()")

Thanks!



-- 
Masami Hiramatsu <mhiramat@kernel.org>
