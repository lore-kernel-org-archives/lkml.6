Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D4C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163EB20659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163EB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJLDol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:44:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:20288 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeJLDol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:44:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 13:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="264936467"
Received: from kcaccard-mobl3.jf.intel.com ([10.24.8.209])
  by orsmga005.jf.intel.com with ESMTP; 11 Oct 2018 13:15:50 -0700
Message-ID: <1539288950.3566.11.camel@linux.intel.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
From:   Kristen C Accardi <kristen@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Oct 2018 13:15:50 -0700
In-Reply-To: <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
References: <20181011185458.10186-1-kristen@linux.intel.com>
         <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-11 at 12:25 -0700, Andy Lutomirski wrote:
> On Thu, Oct 11, 2018 at 11:55 AM Kristen Carlson Accardi
> <kristen@linux.intel.com> wrote:
> > 
> > This patch aims to make it harder to perform cache timing attacks
> > on data
> > left behind by system calls. If we have an error returned from a
> > syscall,
> > flush the L1 cache.
> > 
> > It's important to note that this patch is not addressing any
> > specific
> > exploit, nor is it intended to be a complete defense against
> > anything.
> > It is intended to be a low cost way of eliminating some of side
> > effects
> > of a failed system call.
> > 
> > A performance test using sysbench on one hyperthread and a script
> > which
> > attempts to repeatedly access files it does not have permission to
> > access
> > on the other hyperthread found no significant performance impact.
> > 
> > +__visible inline void l1_cache_flush(struct pt_regs *regs)
> > +{
> > +       if (IS_ENABLED(CONFIG_SYSCALL_FLUSH) &&
> > +           static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> > +               if (regs->ax == 0 || regs->ax == -EAGAIN ||
> > +                   regs->ax == -EEXIST || regs->ax == -ENOENT ||
> > +                   regs->ax == -EXDEV || regs->ax == -ETIMEDOUT ||
> > +                   regs->ax == -ENOTCONN || regs->ax ==
> > -EINPROGRESS)
> > +                       return;
> > +
> > +               wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> > +       }
> > +}
> 
> Ugh.
> 
> What exactly is this trying to protect against?  And how many cycles
> should we expect L1D_FLUSH to take?

As I mentioned in the commit message, this is not addressing any
specific exploit. It is removing any side effects from a failed system
call in the L1 cache.

> 
> ISTM that, if we have a situation where the L1D can be read by user
> code, we lose, via hyperthreading, successful syscalls, /dev/random,
> and may other vectors.  This seems like a small mitigation at a
> rather
> large cost.

I pinned an evil task to one hyperthread that just caused L1 flushes by
issuing failed system calls. On the other hyperthread, I ran a
performance benchmark (sysbench). I did not see any difference between
the baseline and the kernel with the patch applied. Is there a more
appropriate test you'd be interested in seeing the results of? I'd be
happy to design a different test.
