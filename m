Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7043C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888EF2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888EF2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJCXKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:10:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:9897 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeJCXKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:10:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 09:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="91865603"
Received: from 2b52.sc.intel.com ([143.183.136.147])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2018 09:16:14 -0700
Message-ID: <9c93e864e5996862cb5fdb66d4140faa634cbc47.camel@intel.com>
Subject: Re: [RFC PATCH v4 06/27] x86/cet: Control protection exception
 handler
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Wed, 03 Oct 2018 09:11:34 -0700
In-Reply-To: <20181003103959.GB7111@asgard.redhat.com>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
         <20180921150351.20898-7-yu-cheng.yu@intel.com>
         <20181003103959.GB7111@asgard.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 12:39 +0200, Eugene Syromiatnikov wrote:
> On Fri, Sep 21, 2018 at 08:03:30AM -0700, Yu-cheng Yu wrote:
> > +dotraplinkage void
> > +do_control_protection(struct pt_regs *regs, long error_code)
> > +{
> > +	struct task_struct *tsk;
> > +
> > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > +	if (notify_die(DIE_TRAP, "control protection fault", regs,
> > +		       error_code, X86_TRAP_CP, SIGSEGV) == NOTIFY_STOP)
> > +		return;
> > +	cond_local_irq_enable(regs);
> > +
> > +	if (!user_mode(regs))
> > +		die("kernel control protection fault", regs, error_code);
> > +
> > +	if (!static_cpu_has(X86_FEATURE_SHSTK) &&
> > +	    !static_cpu_has(X86_FEATURE_IBT))
> > +		WARN_ONCE(1, "CET is disabled but got control "
> > +			  "protection fault\n");
> > +
> > +	tsk = current;
> > +	tsk->thread.error_code = error_code;
> > +	tsk->thread.trap_nr = X86_TRAP_CP;
> > +
> > +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> > +	    printk_ratelimit()) {
> > +		unsigned int max_err;
> > +
> > +		max_err = ARRAY_SIZE(control_protection_err) - 1;
> > +		if ((error_code < 0) || (error_code > max_err))
> > +			error_code = 0;
> > +		pr_info("%s[%d] control protection ip:%lx sp:%lx
> > error:%lx(%s)",
> > +			tsk->comm, task_pid_nr(tsk),
> > +			regs->ip, regs->sp, error_code,
> > +			control_protection_err[error_code]);
> > +		print_vma_addr(KERN_CONT " in ", regs->ip);
> > +		pr_cont("\n");
> > +	}
> > +
> > +	force_sig_info(SIGSEGV, SEND_SIG_PRIV, tsk);
> 
> That way, no information is provided to userspace (both application and
> debugger), which is rather unfortunate. It would be nice if a new SEGV_*
> code was added at least, and CET error (with error code constant provided
> in UAPI) is passed via si_errno. (Having ip/sp/*ssp would be even
> better, but I'm not exactly sure about ramifications of providing this
> kind of information to user space).

Ok, I will add that.

Yu-cheng
