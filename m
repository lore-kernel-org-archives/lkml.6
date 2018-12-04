Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C70C20672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C70C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeLDRNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:13:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:34123 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDRNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:13:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 09:13:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="127031778"
Received: from unknown (HELO yyu32-desk1) ([143.183.136.51])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2018 09:13:43 -0800
Message-ID: <752c38422a6536d8df99b619214f935e4bc882ad.camel@intel.com>
Subject: Re: [RFC PATCH v6 04/26] x86/fpu/xstate: Introduce XSAVES system
 states
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
Date:   Tue, 04 Dec 2018 09:08:11 -0800
In-Reply-To: <20181204160144.GG11803@zn.tnic>
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
         <20181119214809.6086-5-yu-cheng.yu@intel.com>
         <20181204160144.GG11803@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 17:01 +0100, Borislav Petkov wrote:
> On Mon, Nov 19, 2018 at 01:47:47PM -0800, Yu-cheng Yu wrote:
> > Control-flow Enforcement (CET) MSR contents are XSAVES system states.
> > To support CET, introduce XSAVES system states first.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  arch/x86/include/asm/fpu/internal.h |  3 +-
> >  arch/x86/include/asm/fpu/xstate.h   |  4 +-
> >  arch/x86/kernel/fpu/core.c          |  6 +-
> >  arch/x86/kernel/fpu/init.c          | 10 ---
> >  arch/x86/kernel/fpu/xstate.c        | 94 +++++++++++++++++++----------
> >  5 files changed, 69 insertions(+), 48 deletions(-)
> 
> ...
> 
> > @@ -704,6 +710,7 @@ static int init_xstate_size(void)
> >   */
> >  static void fpu__init_disable_system_xstate(void)
> >  {
> > +	xfeatures_mask_all = 0;
> >  	xfeatures_mask_user = 0;
> >  	cr4_clear_bits(X86_CR4_OSXSAVE);
> >  	fpu__xstate_clear_all_cpu_caps();
> > @@ -717,6 +724,8 @@ void __init fpu__init_system_xstate(void)
> >  {
> >  	unsigned int eax, ebx, ecx, edx;
> >  	static int on_boot_cpu __initdata = 1;
> > +	u64 cpu_system_xfeatures_mask;
> > +	u64 cpu_user_xfeatures_mask;
> 
> So what I had in mind is to not have those local vars but use
> xfeatures_mask_user and xfeatures_mask_system here directly...

Ok, I will re-write it.

...

> >  
> > @@ -739,10 +748,23 @@ void __init fpu__init_system_xstate(void)
> >  		return;
> >  	}
> >  
> > +	/*
> > +	 * Find user states supported by the processor.
> > +	 * Only these bits can be set in XCR0.
> > +	 */
> >  	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
> > -	xfeatures_mask_user = eax + ((u64)edx << 32);
> > +	cpu_user_xfeatures_mask = eax + ((u64)edx << 32);
> >  
> > -	if ((xfeatures_mask_user & XFEATURE_MASK_FPSSE) !=
> > XFEATURE_MASK_FPSSE) {
> > +	/*
> > +	 * Find system states supported by the processor.
> > +	 * Only these bits can be set in IA32_XSS MSR.
> > +	 */
> > +	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
> > +	cpu_system_xfeatures_mask = ecx + ((u64)edx << 32);
> > +
> > +	xfeatures_mask_all = cpu_user_xfeatures_mask |
> > cpu_system_xfeatures_mask;
> 
> ... and not introduce xfeatures_mask_all at all but everywhere you need
> all features, to do:
> 
> 	(xfeatures_mask_user | xfeatures_mask_system)
> 
> and work with that.

Then we will do this very often.  Why don't we create all three in the
beginning: xfeatures_mask_all, xfeatures_mask_user, and xfeatures_mask_system?

> ...
> 
> > @@ -1178,7 +1208,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave,
> > const void *kbuf)
> >  	 * The state that came in from userspace was user-state only.
> >  	 * Mask all the user states out of 'xfeatures':
> >  	 */
> > -	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
> > +	xsave->header.xfeatures &= (xfeatures_mask_all &
> > ~xfeatures_mask_user);
> 
> ... and this would be
> 
> 	xsave->header.xfeatures &= xfeatures_mask_system;

Yes.

> 
> >  
> >  	/*
> >  	 * Add back in the features that came in from userspace:
> > @@ -1234,7 +1264,7 @@ int copy_user_to_xstate(struct xregs_state *xsave,
> > const void __user *ubuf)
> >  	 * The state that came in from userspace was user-state only.
> >  	 * Mask all the user states out of 'xfeatures':
> >  	 */
> > -	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
> > +	xsave->header.xfeatures &= (xfeatures_mask_all &
> > ~xfeatures_mask_user);
> 
> Ditto here.
> 
> This way you have *two* mask variables and code queries them only.
> 
> Hmmm?
> 
> Or am I missing something?

We actually have three.

Yu-cheng

