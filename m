Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E5208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388E5208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbeGMR41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:56:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:20375 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbeGMR41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:56:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 10:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,348,1526367600"; 
   d="scan'208";a="64505102"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2018 10:40:50 -0700
Message-ID: <1531503430.11680.2.camel@intel.com>
Subject: Re: [RFC PATCH v2 18/27] x86/cet/shstk: Introduce WRUSS instruction
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Fri, 13 Jul 2018 10:37:10 -0700
In-Reply-To: <166536e2-b296-7be5-d1b7-982cf56f1f9b@linux.intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-19-yu-cheng.yu@intel.com>
         <166536e2-b296-7be5-d1b7-982cf56f1f9b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 05:12 -0700, Dave Hansen wrote:
> On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > 
> > +static int is_wruss(struct pt_regs *regs, unsigned long error_code)
> > +{
> > +	return (((error_code & (X86_PF_USER | X86_PF_SHSTK)) ==
> > +		(X86_PF_USER | X86_PF_SHSTK)) && !user_mode(regs));
> > +}
> > +
> >  static void
> >  show_fault_oops(struct pt_regs *regs, unsigned long error_code,
> >  		unsigned long address)
> > @@ -848,7 +859,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
> >  	struct task_struct *tsk = current;
> >  
> >  	/* User mode accesses just cause a SIGSEGV */
> > -	if (error_code & X86_PF_USER) {
> > +	if ((error_code & X86_PF_USER) && !is_wruss(regs, error_code)) {
> >  		/*
> >  		 * It's possible to have interrupts off here:
> >  		 */
> Please don't do it this way.
> 
> We have two styles of page fault:
> 1. User page faults: find a VMA, try to handle (allocate memory et al.),
>    kill process if we can't handle.
> 2. Kernel page faults: search for a *discrete* set of conditions that
>    can be handled, including faults in instructions marked in exception
>    tables.
> 
> X86_PF_USER *means*: do user page fault handling.  In the places where
> the hardware doesn't set it, but we still want user page fault handling,
> we manually set it, like this where we "downgrade" an implicit
> supervisor access to a user access:
> 
>         if (user_mode(regs)) {
>                 local_irq_enable();
>                 error_code |= X86_PF_USER;
>                 flags |= FAULT_FLAG_USER;
> 
> So, just please *clear* X86_PF_USER if !user_mode(regs) and X86_PF_SS.
> We do not want user page fault handling, thus we should not keep the bit
> set.

Agree.  I will change that.

Yu-cheng

