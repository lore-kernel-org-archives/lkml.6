Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F4AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD0720658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD0720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeIACD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:03:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:36530 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeIACDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:03:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 14:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,313,1531810800"; 
   d="scan'208";a="81989050"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2018 14:53:57 -0700
Message-ID: <1535752180.31230.4.camel@intel.com>
Subject: Re: [RFC PATCH v3 19/24] x86/cet/shstk: Introduce WRUSS instruction
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>, Jann Horn <jannh@google.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Date:   Fri, 31 Aug 2018 14:49:40 -0700
In-Reply-To: <1535646146.26689.11.camel@intel.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
         <20180830143904.3168-20-yu-cheng.yu@intel.com>
         <CAG48ez3uZrC-9uJ0uMoVPTtxRXRN8D+3zs5FknZD2woTT6mazg@mail.gmail.com>
         <CALCETrW78UKt6AQJeN8GkhtxjuASnH1PV5QSpzQtDz9-2d3Asw@mail.gmail.com>
         <1535646146.26689.11.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 09:22 -0700, Yu-cheng Yu wrote:
> On Thu, 2018-08-30 at 08:55 -0700, Andy Lutomirski wrote:
> > 
> > On Thu, Aug 30, 2018 at 8:39 AM, Jann Horn <jannh@google.com>
> > wrote:
> > > 
> > > 
> > > On Thu, Aug 30, 2018 at 4:44 PM Yu-cheng Yu <yu-cheng.yu@intel.c
> > > om
> > > > 
> > > > wrote:
> > > > 
> > > > 
> > > > WRUSS is a new kernel-mode instruction but writes directly
> > > > to user shadow stack memory.  This is used to construct
> > > > a return address on the shadow stack for the signal
> > > > handler.
> > > > 
> > > > This instruction can fault if the user shadow stack is
> > > > invalid shadow stack memory.  In that case, the kernel does
> > > > fixup.
> > > > 
> > > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > [...]
> > > > 
> > > > 
> > > > +static inline int write_user_shstk_64(unsigned long addr,
> > > > unsigned long val)
> > > > +{
> > > > +       int err = 0;
> > > > +
> > > > +       asm volatile("1: wrussq %1, (%0)\n"
> > > > +                    "2:\n"
> > > > +                    _ASM_EXTABLE_HANDLE(1b, 2b,
> > > > ex_handler_wruss)
> > > > +                    :
> > > > +                    : "r" (addr), "r" (val));
> > > > +
> > > > +       return err;
> > > > +}
> > > What's up with "err"? You set it to zero, and then you return
> > > it,
> > > but
> > > nothing can ever set it to non-zero, right?
> > > 
> > > > 
> > > > 
> > > > +__visible bool ex_handler_wruss(const struct
> > > > exception_table_entry *fixup,
> > > > +                               struct pt_regs *regs, int
> > > > trapnr)
> > > > +{
> > > > +       regs->ip = ex_fixup_addr(fixup);
> > > > +       regs->ax = -1;
> > > > +       return true;
> > > > +}
> > > And here you just write into regs->ax, but your "asm volatile"
> > > doesn't
> > > reserve that register. This looks wrong to me.
> > > 
> > > I think you probably want to add something like an explicit
> > > `"+&a"(err)` output to the asm statements.
> > We require asm goto support these days.  How about using
> > that?  You
> > won't even need a special exception handler.

Maybe something like this?  It looks simple now.

static inline int write_user_shstk_64(unsigned long addr, unsigned
long val)
{
	asm_volatile_goto("wrussq %1, (%0)\n"
		     "jmp %l[ok]\n"
		     ".section .fixup,\"ax\"n"
		     "jmp %l[fail]\n"
		     ".previous\n"
		     :: "r" (addr), "r" (val)
		     :: ok, fail);
ok:
	return 0;
fail:
	return -1;
}

