Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624F9C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5F82146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5F82146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbeGKVDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:03:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:64723 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeGKVDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:03:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 13:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="66205150"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2018 13:57:02 -0700
Message-ID: <1531342404.15351.35.camel@intel.com>
Subject: Re: [RFC PATCH v2 20/27] x86/cet/shstk: ELF header parsing of CET
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
        Andy Lutomirski <luto@amacapital.net>, bsingharora@gmail.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Date:   Wed, 11 Jul 2018 13:53:24 -0700
In-Reply-To: <CAG48ez3DYQtgk_WfOwbFFeuWJmzwZhH-DkDT1UKYVZaYi6V_Pg@mail.gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-21-yu-cheng.yu@intel.com>
         <CAG48ez3DYQtgk_WfOwbFFeuWJmzwZhH-DkDT1UKYVZaYi6V_Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 12:37 -0700, Jann Horn wrote:
> On Tue, Jul 10, 2018 at 3:31 PM Yu-cheng Yu <yu-cheng.yu@intel.com>
> wrote:
> > 
> > 
> > Look in .note.gnu.property of an ELF file and check if shadow stack
> > needs
> > to be enabled for the task.
> > 
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> [...]
> > 
> > diff --git a/arch/x86/kernel/elf.c b/arch/x86/kernel/elf.c
> > new file mode 100644
> > index 000000000000..233f6dad9c1f
> > --- /dev/null
> > +++ b/arch/x86/kernel/elf.c
> [...]
> > 
> > +#define NOTE_SIZE_BAD(n, align, max) \
> > +       ((n->n_descsz < 8) || ((n->n_descsz % align) != 0) || \
> > +        (((u8 *)(n + 1) + 4 + n->n_descsz) > (max)))
> Please do not compute out-of-bounds pointers and then compare them
> against an expected maximum pointer. Computing an out-of-bounds
> pointer is undefined behavior according to the C99 specification,
> section "6.5.6 Additive operators", paragraph 8; and in this case,
> n->n_descsz is 32 bits wide, which means that even if the compiler
> isn't doing anything funny, if you're operating on addresses in the
> last 4GiB of virtual memory and the pointer wraps around, this could
> break.
> In particular, if anyone ever uses this code in a 32-bit kernel, this
> is going to blow up.
> Please use size comparisons instead of pointer comparisons.

I will fix it.

> [...]
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 0ac456b52bdd..3395f6a631d5 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1081,6 +1081,22 @@ static int load_elf_binary(struct
> > linux_binprm *bprm)
> >                 goto out_free_dentry;
> >         }
> > 
> > +#ifdef CONFIG_ARCH_HAS_PROGRAM_PROPERTIES
> > +
> > +       if (interpreter) {
> > +               retval = arch_setup_features(&loc->interp_elf_ex,
> > +                                            interp_elf_phdata,
> > +                                            interpreter, true);
> > +       } else {
> > +               retval = arch_setup_features(&loc->elf_ex,
> > +                                            elf_phdata,
> > +                                            bprm->file, false);
> > +       }
> So for non-static binaries, the ELF headers of ld.so determine
> whether
> CET will be on or off for the entire system, right? Is the intent
> here
> that ld.so should start with CET enabled, and then either use the
> compatibility bitmap or turn CET off at runtime if the executable or
> one of the libraries doesn't actually work with CET?


The kernel command-line options "no_cet_shstk" and "no_cet_ibt" turn
off CET features for the whole system.  The GLIBC tunable
"glibc.tune.hwcap=-SHSTK,-IBT" turns off CET features for the current
shell.  Another GLIBC tunable "glibc.tune.x86_shstk=<on, permissive>"
determines, in the current shell, how dlopen() deals with SHSTK legacy
lib's.

So, if ld.so's ELF header has SHSTK/IBT, and CET is enabled in the
current shell, it will run with CET enabled.  If the application
executable and all its dependent libraries have CET, ld.so runs the
application with CET enabled.  Otherwise ld.so turns off SHSTK (and/or
sets up legacy bitmap for IBT) before passing to the application.

Yu-cheng
