Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965ABC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5856E20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5856E20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbeGKPtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:49:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:8554 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732819AbeGKPtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:49:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 08:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="56861618"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2018 08:44:16 -0700
Message-ID: <1531323638.13297.24.camel@intel.com>
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Wed, 11 Jul 2018 08:40:38 -0700
In-Reply-To: <20180711102035.GB8574@gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-26-yu-cheng.yu@intel.com>
         <20180711102035.GB8574@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 12:20 +0200, Ingo Molnar wrote:
> * Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
> > 
> > Add PTRACE interface for CET MSRs.
> Please *always* describe new ABIs in the changelog, in a precise,
> well-documented 
> way.

Ok!

> > 
> > diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> > index e2ee403865eb..ac2bc3a18427 100644
> > --- a/arch/x86/kernel/ptrace.c
> > +++ b/arch/x86/kernel/ptrace.c
> > @@ -49,7 +49,9 @@ enum x86_regset {
> >  	REGSET_IOPERM64 = REGSET_XFP,
> >  	REGSET_XSTATE,
> >  	REGSET_TLS,
> > +	REGSET_CET64 = REGSET_TLS,
> >  	REGSET_IOPERM32,
> > +	REGSET_CET32,
> >  };
> Why does REGSET_CET64 alias on REGSET_TLS?

In x86_64_regsets[], there is no [REGSET_TLS].  The core dump code
cannot handle holes in the array.

> 
> > 
> >  struct pt_regs_offset {
> > @@ -1276,6 +1278,13 @@ static struct user_regset x86_64_regsets[]
> > __ro_after_init = {
> >  		.size = sizeof(long), .align = sizeof(long),
> >  		.active = ioperm_active, .get = ioperm_get
> >  	},
> > +	[REGSET_CET64] = {
> > +		.core_note_type = NT_X86_CET,
> > +		.n = sizeof(struct cet_user_state) / sizeof(u64),
> > +		.size = sizeof(u64), .align = sizeof(u64),
> > +		.active = cetregs_active, .get = cetregs_get,
> > +		.set = cetregs_set
> > +	},
> Ok, could we first please make this part of the regset code more
> readable and 
> start the series with a standalone clean-up patch that changes these
> initializers 
> to something more readable:
> 
> 	[REGSET_CET64] = {
> 		.core_note_type	= NT_X86_CET,
> 		.n		= sizeof(struct cet_user_state) /
> sizeof(u64),
> 		.size		= sizeof(u64),
> 		.align		= sizeof(u64),
> 		.active		= cetregs_active,
> 		.get		= cetregs_get,
> 		.set		= cetregs_set
> 	},
> 
> ? (I'm demonstrating the cleanup based on REGSET_CET64, but this
> should be done on 
> every other entry first.)
> 

I will fix it.

> 
> > 
> > --- a/include/uapi/linux/elf.h
> > +++ b/include/uapi/linux/elf.h
> > @@ -401,6 +401,7 @@ typedef struct elf64_shdr {
> >  #define NT_386_TLS	0x200		/* i386 TLS slots
> > (struct user_desc) */
> >  #define NT_386_IOPERM	0x201		/* x86 io
> > permission bitmap (1=deny) */
> >  #define NT_X86_XSTATE	0x202		/* x86 extended
> > state using xsave */
> > +#define NT_X86_CET	0x203		/* x86 cet state */
> Acronyms in comments should be in capital letters.
> 
> Also, I think I asked this before: why does "Control Flow
> Enforcement" abbreviate 
> to "CET" (which is a well-known acronym for "Central European Time"),
> not to CFE?
> 

I don't know if I can change that, will find out.

Thanks,
Yu-cheng

