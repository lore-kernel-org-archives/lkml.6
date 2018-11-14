Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34573C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F388421780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F388421780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeKOG3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:29:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:13145 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725757AbeKOG3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:29:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 12:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,233,1539673200"; 
   d="scan'208";a="108104052"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.51])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2018 12:24:54 -0800
Message-ID: <307b6162b0270871e664ca88a96b4ea0d1b3f65b.camel@intel.com>
Subject: Re: [PATCH v5 06/27] x86/cet: Control protection exception handler
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
        Eugene Syromiatnikov <esyr@redhat.com>,
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
Date:   Wed, 14 Nov 2018 12:19:42 -0800
In-Reply-To: <20181114184436.GK13926@zn.tnic>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
         <20181011151523.27101-7-yu-cheng.yu@intel.com>
         <20181114184436.GK13926@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 19:44 +0100, Borislav Petkov wrote:
> That subject needs a verb:
> 
> Subject: [PATCH v5 06/27] x86/cet: Add control protection exception handler
> 
> On Thu, Oct 11, 2018 at 08:15:02AM -0700, Yu-cheng Yu wrote:
> > A control protection exception is triggered when a control flow transfer
> > attempt violated shadow stack or indirect branch tracking constraints.
> > For example, the return address for a RET instruction differs from the
> > safe copy on the shadow stack; or a JMP instruction arrives at a non-
> > ENDBR instruction.
> > 
> > The control protection exception handler works in a similar way as the
> > general protection fault handler.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  arch/x86/entry/entry_64.S          |  2 +-
> >  arch/x86/include/asm/traps.h       |  3 ++
> >  arch/x86/kernel/idt.c              |  4 ++
> >  arch/x86/kernel/signal_compat.c    |  2 +-
> >  arch/x86/kernel/traps.c            | 64 ++++++++++++++++++++++++++++++
> >  include/uapi/asm-generic/siginfo.h |  3 +-
> >  6 files changed, 75 insertions(+), 3 deletions(-)
> 
> A *lot* of style problems here. Please use checkpatch and then common
> sense to check your patches before sending. All those below are valid,
> AFAICT:
> 
> WARNING: function definition argument 'struct pt_regs *' should also have an
> identifier name
> #76: FILE: arch/x86/include/asm/traps.h:81:
> +dotraplinkage void do_control_protection(struct pt_regs *, long);
> 
> WARNING: function definition argument 'long' should also have an identifier
> name
> #76: FILE: arch/x86/include/asm/traps.h:81:
> +dotraplinkage void do_control_protection(struct pt_regs *, long);

Yes, I was not sure if the addition should follow the existing style (which does
not have identifier names).  What do you think is right?

Thanks,
Yu-cheng
