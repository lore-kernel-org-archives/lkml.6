Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D88C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5153C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5153C2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbeKTJOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:14:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:31026 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbeKTJOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:14:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 14:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,254,1539673200"; 
   d="scan'208";a="93332282"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2018 14:48:48 -0800
Message-ID: <a40c2a60e42b5fdff46275ca42f3e7276bf11258.camel@intel.com>
Subject: Re: [RFC PATCH v6 08/11] x86: Insert endbr32/endbr64 to vDSO
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Date:   Mon, 19 Nov 2018 14:43:31 -0800
In-Reply-To: <CALCETrW9ABDotyM020V147+kuizpTRJUAANn-6kUt6-h0Qn0og@mail.gmail.com>
References: <20181119214934.6174-1-yu-cheng.yu@intel.com>
         <20181119214934.6174-9-yu-cheng.yu@intel.com>
         <CALCETrW9ABDotyM020V147+kuizpTRJUAANn-6kUt6-h0Qn0og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-19 at 14:17 -0800, Andy Lutomirski wrote:
> On Mon, Nov 19, 2018 at 1:55 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > 
> > From: "H.J. Lu" <hjl.tools@gmail.com>
> > 
> > When Intel indirect branch tracking is enabled, functions in vDSO which
> > may be called indirectly must have endbr32 or endbr64 as the first
> > instruction.  Compiler must support -fcf-protection=branch so that it
> > can be used to compile vDSO.
> > 
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> > ---
> >  arch/x86/entry/vdso/.gitignore        |  4 ++++
> >  arch/x86/entry/vdso/Makefile          | 12 +++++++++++-
> >  arch/x86/entry/vdso/vdso-layout.lds.S |  1 +
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/entry/vdso/.gitignore b/arch/x86/entry/vdso/.gitignore
> > index aae8ffdd5880..552941fdfae0 100644
> > --- a/arch/x86/entry/vdso/.gitignore
> > +++ b/arch/x86/entry/vdso/.gitignore
> > @@ -5,3 +5,7 @@ vdso32-sysenter-syms.lds
> >  vdso32-int80-syms.lds
> >  vdso-image-*.c
> >  vdso2c
> > +vclock_gettime.S
> > +vgetcpu.S
> > +vclock_gettime.asm
> > +vgetcpu.asm
> 
> 
> What's this hunk about?

We used to allow using non-CET capable BINUTILS and the Makefile would create
these.  I will remove them from the patch.

Yu-cheng

