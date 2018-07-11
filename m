Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C53C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663A520C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663A520C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbeGKPPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:15:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:12957 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732916AbeGKPPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:15:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 08:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="56086848"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2018 08:10:32 -0700
Message-ID: <1531321615.13297.9.camel@intel.com>
Subject: Re: [RFC PATCH v2 18/27] x86/cet/shstk: Introduce WRUSS instruction
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Wed, 11 Jul 2018 08:06:55 -0700
In-Reply-To: <20180711094448.GZ2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-19-yu-cheng.yu@intel.com>
         <20180711094448.GZ2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 11:44 +0200, Peter Zijlstra wrote:
> On Tue, Jul 10, 2018 at 03:26:30PM -0700, Yu-cheng Yu wrote:
> > 
> > WRUSS is a new kernel-mode instruction but writes directly
> > to user shadow stack memory.  This is used to construct
> > a return address on the shadow stack for the signal
> > handler.
> > 
> > This instruction can fault if the user shadow stack is
> > invalid shadow stack memory.  In that case, the kernel does
> > fixup.
> > 
> > 
> > +static inline int write_user_shstk_64(unsigned long addr, unsigned
> > long val)
> > +{
> > +	int err = 0;
> > +
> > +	asm volatile("1: wrussq %[val], (%[addr])\n"
> > +		     "xor %[err], %[err]\n"
> this XOR is superfluous, you already cleared @err above.

I will fix it.

> 
> > 
> > +		     "2:\n"
> > +		     ".section .fixup,\"ax\"\n"
> > +		     "3: mov $-1, %[err]; jmp 2b\n"
> > +		     ".previous\n"
> > +		     _ASM_EXTABLE(1b, 3b)
> > +		     : [err] "=a" (err)
> > +		     : [val] "S" (val), [addr] "D" (addr));
> > +
> > +	return err;
> > +}
> > +#endif /* CONFIG_X86_INTEL_CET */
> > +
> >  #define nop() asm volatile ("nop")
> What happened to:
> 
>   https://lkml.kernel.org/r/1528729376.4526.0.camel@2b52.sc.intel.com

Yes, I put that in once and realized we only need to skip the
instruction and return err.  Do you think we still need a handler for
that?

Yu-cheng
