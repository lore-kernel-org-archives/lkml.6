Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60391C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1231020C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1231020C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbeGKVFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:05:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:23333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733021AbeGKVFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:05:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 13:59:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,339,1526367600"; 
   d="scan'208";a="66205693"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2018 13:59:22 -0700
Message-ID: <1531342544.15351.37.camel@intel.com>
Subject: Re: [RFC PATCH v2 27/27] x86/cet: Add arch_prctl functions for CET
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
Date:   Wed, 11 Jul 2018 13:55:44 -0700
In-Reply-To: <CAG48ez2cY1CPTTfDnV5yZyHVPXP787=fR1+G_D7tR5VYXdjFmQ@mail.gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-28-yu-cheng.yu@intel.com>
         <CAG48ez2cY1CPTTfDnV5yZyHVPXP787=fR1+G_D7tR5VYXdjFmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 12:45 -0700, Jann Horn wrote:
> On Tue, Jul 10, 2018 at 3:31 PM Yu-cheng Yu <yu-cheng.yu@intel.com>
> wrote:
> > 
> > 
> > arch_prctl(ARCH_CET_STATUS, unsigned long *addr)
> >     Return CET feature status.
> > 
> >     The parameter 'addr' is a pointer to a user buffer.
> >     On returning to the caller, the kernel fills the following
> >     information:
> > 
> >     *addr = SHSTK/IBT status
> >     *(addr + 1) = SHSTK base address
> >     *(addr + 2) = SHSTK size
> > 
> > arch_prctl(ARCH_CET_DISABLE, unsigned long features)
> >     Disable SHSTK and/or IBT specified in 'features'.  Return
> > -EPERM
> >     if CET is locked out.
> > 
> > arch_prctl(ARCH_CET_LOCK)
> >     Lock out CET feature.
> > 
> > arch_prctl(ARCH_CET_ALLOC_SHSTK, unsigned long *addr)
> >     Allocate a new SHSTK.
> > 
> >     The parameter 'addr' is a pointer to a user buffer and
> > indicates
> >     the desired SHSTK size to allocate.  On returning to the caller
> >     the buffer contains the address of the new SHSTK.
> > 
> > arch_prctl(ARCH_CET_LEGACY_BITMAP, unsigned long *addr)
> >     Allocate an IBT legacy code bitmap if the current task does not
> >     have one.
> > 
> >     The parameter 'addr' is a pointer to a user buffer.
> >     On returning to the caller, the kernel fills the following
> >     information:
> > 
> >     *addr = IBT bitmap base address
> >     *(addr + 1) = IBT bitmap size
> > 
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> [...]
> > 
> > diff --git a/arch/x86/kernel/cet_prctl.c
> > b/arch/x86/kernel/cet_prctl.c
> > new file mode 100644
> > index 000000000000..86bb78ae656d
> > --- /dev/null
> > +++ b/arch/x86/kernel/cet_prctl.c
> > @@ -0,0 +1,141 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/prctl.h>
> > +#include <linux/compat.h>
> > +#include <asm/processor.h>
> > +#include <asm/prctl.h>
> > +#include <asm/elf.h>
> > +#include <asm/elf_property.h>
> > +#include <asm/cet.h>
> > +
> > +/* See Documentation/x86/intel_cet.txt. */
> > +
> > +static int handle_get_status(unsigned long arg2)
> > +{
> > +       unsigned int features = 0;
> > +       unsigned long shstk_base, shstk_size;
> > +
> > +       if (current->thread.cet.shstk_enabled)
> > +               features |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
> > +       if (current->thread.cet.ibt_enabled)
> > +               features |= GNU_PROPERTY_X86_FEATURE_1_IBT;
> > +
> > +       shstk_base = current->thread.cet.shstk_base;
> > +       shstk_size = current->thread.cet.shstk_size;
> > +
> > +       if (in_ia32_syscall()) {
> > +               unsigned int buf[3];
> > +
> > +               buf[0] = features;
> > +               buf[1] = (unsigned int)shstk_base;
> > +               buf[2] = (unsigned int)shstk_size;
> > +               return copy_to_user((unsigned int __user *)arg2,
> > buf,
> > +                                   sizeof(buf));
> > +       } else {
> > +               unsigned long buf[3];
> > +
> > +               buf[0] = (unsigned long)features;
> > +               buf[1] = shstk_base;
> > +               buf[2] = shstk_size;
> > +               return copy_to_user((unsigned long __user *)arg2,
> > buf,
> > +                                   sizeof(buf));
> > +       }
> Other places in the kernel (e.g. the BPF subsystem) just
> unconditionally use u64 instead of unsigned long to avoid having to
> switch between different sizes. I wonder whether that would make
> sense
> here?

Yes, that simplifies the code.  I will make that change.

Yu-cheng
