Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 79706C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2633A208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA7erfXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2633A208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755844AbeFOHGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755565AbeFOHGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:06:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8233208B5;
        Fri, 15 Jun 2018 07:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529046402;
        bh=B40kC/LmBEJkJJ8hduzBceZ6bX7bIjll5zl6fEAsbAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DA7erfXUmYvjF3sP5pH7c7L5WXoH7UmJe0AwYn9L53deuyl7O4YC2SfKAQQfdxUOH
         muty40qnHTqbKjvXJR+kXjfH0DZjzFvESOrsz95jo8ElFWWF9bHeAtNfPebKR9fMl4
         W/jVtEHiES1GuY6xIvckFMFfNz5gcKLOIghIq9a0=
Date:   Fri, 15 Jun 2018 09:06:19 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        'Andy Lutomirski' <luto@kernel.org>,
        'Rik van Riel' <riel@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'Brian Gerst' <brgerst@gmail.com>,
        'Dave Hansen' <dave.hansen@linux.intel.com>,
        'Denys Vlasenko' <dvlasenk@redhat.com>,
        'Fenghua Yu' <fenghua.yu@intel.com>,
        "'H. Peter Anvin'" <hpa@zytor.com>,
        'Josh Poimboeuf' <jpoimboe@redhat.com>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Oleg Nesterov' <oleg@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Quentin Casasnovas' <quentin.casasnovas@oracle.com>,
        'Thomas Gleixner' <tglx@linutronix.de>, pbonzini@redhat.com,
        'Ingo Molnar' <mingo@kernel.org>
Subject: Re: [PATCH 4.4 10/24] x86/fpu: Hard-disable lazy FPU mode
Message-ID: <20180615070619.GA25325@kroah.com>
References: <20180614132724.483802160@linuxfoundation.org>
 <20180614132724.905032027@linuxfoundation.org>
 <000c01d40460$bfc97710$3f5c6530$@toshiba.co.jp>
 <20180615045604.GA8664@kroah.com>
 <000d01d40468$f2109570$d631c050$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01d40468$f2109570$d631c050$@toshiba.co.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 02:23:08PM +0900, Daniel Sangorrin wrote:
> > -----Original Message-----
> > From: stable-owner@vger.kernel.org [mailto:stable-owner@vger.kernel.org] On
> > Behalf Of 'Greg Kroah-Hartman'
> > Sent: Friday, June 15, 2018 1:56 PM
> > To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> > Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; 'Andy Lutomirski'
> > <luto@kernel.org>; 'Rik van Riel' <riel@redhat.com>; 'Borislav Petkov'
> > <bp@alien8.de>; 'Brian Gerst' <brgerst@gmail.com>; 'Dave Hansen'
> > <dave.hansen@linux.intel.com>; 'Denys Vlasenko' <dvlasenk@redhat.com>;
> > 'Fenghua Yu' <fenghua.yu@intel.com>; 'H. Peter Anvin' <hpa@zytor.com>; 'Josh
> > Poimboeuf' <jpoimboe@redhat.com>; 'Linus Torvalds'
> > <torvalds@linux-foundation.org>; 'Oleg Nesterov' <oleg@redhat.com>; 'Peter
> > Zijlstra' <peterz@infradead.org>; 'Quentin Casasnovas'
> > <quentin.casasnovas@oracle.com>; 'Thomas Gleixner' <tglx@linutronix.de>;
> > pbonzini@redhat.com; 'Ingo Molnar' <mingo@kernel.org>
> > Subject: Re: [PATCH 4.4 10/24] x86/fpu: Hard-disable lazy FPU mode
> > 
> > On Fri, Jun 15, 2018 at 01:24:27PM +0900, Daniel Sangorrin wrote:
> > > Hi Greg,
> > >
> > > >  /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
> > > > --- a/arch/x86/include/asm/fpu/internal.h
> > > > +++ b/arch/x86/include/asm/fpu/internal.h
> > > > @@ -58,7 +58,7 @@ extern u64 fpu__get_supported_xfeatures_
> > > >   */
> > > >  static __always_inline __pure bool use_eager_fpu(void)
> > > >  {
> > > > -	return static_cpu_has_safe(X86_FEATURE_EAGER_FPU);
> > > > +	return true;
> > > >  }
> > >
> > > Since this function returns always true then we can remove the code depending on
> > lazy FPU mode.
> > > Actually this has already been done in "x86/fpu: Remove use_eager_fpu()"
> > > Ref: https://patchwork.kernel.org/patch/9365883/
> > >
> > > >  static void __init fpu__init_parse_early_param(void)
> > > >  {
> > > > -	if (cmdline_find_option_bool(boot_command_line, "eagerfpu=off")) {
> > > > -		eagerfpu = DISABLE;
> > > > -		fpu__clear_eager_fpu_features();
> > > > -	}
> > >
> > > Since this patch removes the kernel boot parameter "eagerfpu", maybe we should
> > remove it from the Documentation.
> > > This has also been done by commit "x86/fpu: Finish excising 'eagerfpu'"
> > > Ref: https://patchwork.kernel.org/patch/9380673/
> > >
> > > I will try backporting those patches unless anyone has any objections.
> > 
> > What are the git commit ids of those patches in Linus's tree?  No need
> > to point to patchwork links, I don't use that tool.
> 
> OK, I got it.
> 
> "x86/fpu: Remove use_eager_fpu()": c592b57347069abfc0dcad3b3a302cf882602597
> "x86/fpu: Finish excising 'eagerfpu'": e63650840e8b053aa09ad934877e87e9941ed135

Minor nit.  For kernel commits, the "normal" way we reference them looks
like this:
	c592b5734706 ("x86/fpu: Remove use_eager_fpu()")
	e63650840e8b ("x86/fpu: Finish excising 'eagerfpu'")

Which makes it much easier to read and understand.  That's what we use
for the "Fixes:" tag in commits and in other places (text in commit
messages.)

To automatically generate that format, you can just do:
	git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"

I recommend just setting up an alias for the above line, otherwise it's
a pain to have to remember how to do it all the time.  Here's what I do:
	$ alias gsr='git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'
	$ gsr c592b57347069abfc0dcad3b3a302cf882602597
	c592b5734706 ("x86/fpu: Remove use_eager_fpu()")

> Unfortunately, they don't apply cleanly to stable kernels.

Should be very simple to backport if you want to.  Also I need copies
for the 4.9.y tree as well if you do so.

thanks,

greg k-h
