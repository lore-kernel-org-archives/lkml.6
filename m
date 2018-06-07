Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IPIvEDtwGVvtaAAAmS7hNA
	; Thu, 07 Jun 2018 17:50:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4A50060590; Thu,  7 Jun 2018 17:50:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AC8FE606DD;
	Thu,  7 Jun 2018 17:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC8FE606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbeFGRuG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:50:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:19069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753698AbeFGRuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:50:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 10:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="57401979"
Received: from 2b52.sc.intel.com (HELO [143.183.136.51]) ([143.183.136.51])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2018 10:50:02 -0700
Message-ID: <1528393611.4636.70.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 01/10] x86/cet: User-mode shadow stack support
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Date: Thu, 07 Jun 2018 10:46:51 -0700
In-Reply-To: <CALCETrX4ALKbphJiZs4MXWtRFvQYD905bNAMTogbOeLh0Pp6xw@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-2-yu-cheng.yu@intel.com>
         <CALCETrX4ALKbphJiZs4MXWtRFvQYD905bNAMTogbOeLh0Pp6xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 09:37 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > This patch adds basic shadow stack enabling/disabling routines.
> > A task's shadow stack is allocated from memory with VM_SHSTK
> > flag set and read-only protection.  The shadow stack is
> > allocated to a fixed size and that can be changed by the system
> > admin.
> 
> How do threads work?  Can a user program mremap() its shadow stack to
> make it bigger?

A pthread's shadow stack is allocated/freed by the kernel.  This patch
has the supporting routines that handle both non-pthread and pthread.

In [PATCH 04/10] "Handle thread shadow stack", we allocate pthread
shadow stack in copy_thread_tls(), and free it in deactivate_mm().

If clone of a pthread fails, shadow stack is freed in
cet_disable_free_shstk() below (I will add more comments):

If (Current thread existing)
	Disable and free shadow stack

If (Clone of a pthread fails)
	Free the pthread shadow stack

We block mremap, mprotect, madvise, and munmap on a vma that has
VM_SHSTK (in separate patches).

> Also, did you add all the needed checks to make get_user_pages(),
> access_process_vm(), etc fail when called on the shadow stack?  (Or at
> least fail if they're requesting write access and the FORCE bit isn't
> set.)

Currently if FORCE bit is set, these functions can write to shadow
stack, otherwise write access will fail.  I will test it.

> > +#define SHSTK_SIZE (0x8000 * (test_thread_flag(TIF_IA32) ? 4 : 8))
> 
> Please don't add more mode-dependent #defines.  Also, please try to
> avoid adding any new code that looks at TIF_IA32 or similar.  Uses of
> that bit are generally bugs, and the bit itself should get removed
> some day.  If you need to make a guess, use in_compat_syscall() or
> similar if appropriate.

OK.

> 
> > +
> > +static inline int cet_set_shstk_ptr(unsigned long addr)
> > +{
> > +       u64 r;
> > +
> > +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> > +               return -1;
> > +
> > +       if ((addr >= TASK_SIZE) || (!IS_ALIGNED(addr, 4)))
> > +               return -1;'
> 
> TASK_SIZE_MAX, please.  TASK_SIZE is weird and is usually the wrong
> thing to use.

OK.

> 
> > +static unsigned long shstk_mmap(unsigned long addr, unsigned long len)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +       unsigned long populate;
> > +
> > +       down_write(&mm->mmap_sem);
> > +       addr = do_mmap(NULL, addr, len, PROT_READ,
> > +                      MAP_ANONYMOUS | MAP_PRIVATE, VM_SHSTK,
> > +                      0, &populate, NULL);
> > +       up_write(&mm->mmap_sem);
> > +
> > +       if (populate)
> > +               mm_populate(addr, populate);
> 
> Please don't populate if do_mmap() failed.

I will fix it.

> 
> > +int cet_setup_shstk(void)
> > +{
> > +       unsigned long addr, size;
> > +
> > +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> > +               return -EOPNOTSUPP;
> > +
> > +       size = SHSTK_SIZE;
> > +       addr = shstk_mmap(0, size);
> > +
> > +       if (addr >= TASK_SIZE)
> > +               return -ENOMEM;
> 
> Please check the actual value that do_mmap() would return on error.
> (IS_ERR, 0, MAP_FAILED -- I don't remember.)

OK.

> 
> > +
> > +       cet_set_shstk_ptr(addr + size - sizeof(void *));
> > +       current->thread.cet.shstk_base = addr;
> > +       current->thread.cet.shstk_size = size;
> > +       current->thread.cet.shstk_enabled = 1;
> > +       return 0;
> > +}
> > +
> > +void cet_disable_shstk(void)
> > +{
> > +       u64 r;
> > +
> > +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> > +               return;
> > +
> > +       rdmsrl(MSR_IA32_U_CET, r);
> > +       r &= ~(MSR_IA32_CET_SHSTK_EN);
> > +       wrmsrl(MSR_IA32_U_CET, r);
> > +       wrmsrl(MSR_IA32_PL3_SSP, 0);
> > +       current->thread.cet.shstk_enabled = 0;
> > +}
> > +
> > +void cet_disable_free_shstk(struct task_struct *tsk)
> > +{
> > +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
> > +           !tsk->thread.cet.shstk_enabled)
> > +               return;
> > +
> > +       if (tsk == current)
> > +               cet_disable_shstk();
> 
> if tsk != current, then this will malfunction, right?  What is it
> intended to do?

We get here when clone fails.  In this condition, we don't disable the
calling task's shadow stack.  I will add comments.

> 
> > +
> > +       /*
> > +        * Free only when tsk is current or shares mm
> > +        * with current but has its own shstk.
> > +        */
> > +       if (tsk->mm && (tsk->mm == current->mm) &&
> > +           (tsk->thread.cet.shstk_base)) {
> > +               vm_munmap(tsk->thread.cet.shstk_base,
> > +                         tsk->thread.cet.shstk_size);
> > +               tsk->thread.cet.shstk_base = 0;
> > +               tsk->thread.cet.shstk_size = 0;
> > +       }
> 
> I'm having trouble imagining why the kernel would ever want to
> automatically free the shadow stack vma.  What is this for?

This is for pthreads.  When a pthread exits, its shadow stack needs to
be freed.
