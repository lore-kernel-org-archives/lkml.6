Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD008C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9002E204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9002E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeH3U2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:28:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:63242 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH3U2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:28:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="81589067"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2018 09:25:10 -0700
Message-ID: <1535646055.26689.10.camel@intel.com>
Subject: Re: [RFC PATCH v3 18/24] x86/cet/shstk: User-mode shadow stack
 support
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
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Date:   Thu, 30 Aug 2018 09:20:55 -0700
In-Reply-To: <CAG48ez0d8+E_O-9u6ZHZ6dQO55Ui2ydV_kia-EEhyYeB_w4r2g@mail.gmail.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
         <20180830143904.3168-19-yu-cheng.yu@intel.com>
         <CAG48ez0d8+E_O-9u6ZHZ6dQO55Ui2ydV_kia-EEhyYeB_w4r2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 18:10 +0200, Jann Horn wrote:
> On Thu, Aug 30, 2018 at 4:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com>
> wrote:
> > 
> > 
> > This patch adds basic shadow stack enabling/disabling routines.
> > A task's shadow stack is allocated from memory with VM_SHSTK
> > flag set and read-only protection.  The shadow stack is
> > allocated to a fixed size of RLIMIT_STACK.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> [...]
> > 
> > +static int set_shstk_ptr(unsigned long addr)
> > +{
> > +       u64 r;
> > +
> > +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> > +               return -1;
> > +
> > +       if ((addr >= TASK_SIZE_MAX) || (!IS_ALIGNED(addr, 4)))
> > +               return -1;
> > +
> > +       rdmsrl(MSR_IA32_U_CET, r);
> > +       wrmsrl(MSR_IA32_PL3_SSP, addr);
> > +       wrmsrl(MSR_IA32_U_CET, r | MSR_IA32_CET_SHSTK_EN);
> > +       return 0;
> > +}
> Here's a really stupid question: Where is the logic for switching
> those MSRs on task switch? MSR_IA32_PL3_SSP contains a userspace
> pointer, so it has to be switched on task switch, right? I'm sure
> I'm
> missing something obvious, but grepping for places that set
> MSR_IA32_PL3_SSP to nonzero values through the entire patchset, I
> only
> see set_shstk_ptr(), which is called from:
> 
>  - cet_setup_shstk() (called from arch_setup_features(), which is
> called from load_elf_binary())
>  - cet_restore_signal() (called on signal handler return)
>  - cet_setup_signal() (called from signal handling code)

The MSR is in the XSAVES buffer and switched by XSAVES/XRSTORS.

Yu-cheng
