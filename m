Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2093EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D760A2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D760A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeHaUcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:32:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:34744 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeHaUcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:32:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 09:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,312,1531810800"; 
   d="scan'208";a="229243768"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2018 09:24:34 -0700
Message-ID: <1535732418.3789.7.camel@intel.com>
Subject: Re: [RFC PATCH v3 06/24] x86/cet: Control protection exception
 handler
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromium.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Date:   Fri, 31 Aug 2018 09:20:18 -0700
In-Reply-To: <CAG48ez0jvsDw189=YoCCa8tmJUENeUd_ypcP5bYJ+eLMPCYCOQ@mail.gmail.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
         <20180830143904.3168-7-yu-cheng.yu@intel.com>
         <CAG48ez0jvsDw189=YoCCa8tmJUENeUd_ypcP5bYJ+eLMPCYCOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 17:01 +0200, Jann Horn wrote:

> Is there a reason why all the code in this patch isn't #ifdef'ed
> away
> on builds that don't support CET? It looks like the CET handler is
> hooked up to the IDT conditionally, but the handler code is always
> built?

Yes, in idt.c, it should have been:

#ifdef CONFIG_X86_64
	INTG(X86_TRAP_CP,		control_protection),
#endif

I will fix it.

> > +dotraplinkage void
> > +do_control_protection(struct pt_regs *regs, long error_code)
> > +{
> > +       struct task_struct *tsk;
> > +
> > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't
> > wake RCU");
> > +       if (notify_die(DIE_TRAP, "control protection fault", regs,
> > +                      error_code, X86_TRAP_CP, SIGSEGV) ==
> > NOTIFY_STOP)
> > +               return;
> > +       cond_local_irq_enable(regs);
> > +
> > +       if (!user_mode(regs))
> > +               die("kernel control protection fault", regs,
> > error_code);
> > +
> > +       if (!static_cpu_has(X86_FEATURE_SHSTK) &&
> > +           !static_cpu_has(X86_FEATURE_IBT))
> > +               WARN_ONCE(1, "CET is disabled but got control "
> > +                         "protection fault\n");
> > +
> > +       tsk = current;
> > +       tsk->thread.error_code = error_code;
> > +       tsk->thread.trap_nr = X86_TRAP_CP;
> > +
> > +       if (show_unhandled_signals && unhandled_signal(tsk,
> > SIGSEGV) &&
> > +           printk_ratelimit()) {
> > +               unsigned int max_err;
> > +
> > +               max_err = ARRAY_SIZE(control_protection_err) - 1;
> > +               if ((error_code < 0) || (error_code > max_err))
> > +                       error_code = 0;
> > +               pr_info("%s[%d] control protection ip:%lx sp:%lx
> > error:%lx(%s)",
> > +                       tsk->comm, task_pid_nr(tsk),
> > +                       regs->ip, regs->sp, error_code,
> > +                       control_protection_err[error_code]);
> > +               print_vma_addr(" in ", regs->ip);
> Shouldn't this be using KERN_CONT, like other callers of
> print_vma_addr(), to get the desired output?

I will change it.

