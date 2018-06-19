Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60104C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089F4204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089F4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966534AbeFSPCm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:02:42 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:57355 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965681AbeFSPCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:02:41 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fVI9Q-0003SP-TD; Tue, 19 Jun 2018 16:02:33 +0100
Message-ID: <1529420551.19394.2.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 10/24] x86/fpu: Hard-disable lazy FPU mode
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, 'Andy Lutomirski' <luto@kernel.org>,
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
Date:   Tue, 19 Jun 2018 16:02:31 +0100
In-Reply-To: <000c01d40460$bfc97710$3f5c6530$@toshiba.co.jp>
References: <20180614132724.483802160@linuxfoundation.org>
         <20180614132724.905032027@linuxfoundation.org>
         <000c01d40460$bfc97710$3f5c6530$@toshiba.co.jp>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-15 at 13:24 +0900, Daniel Sangorrin wrote:
> Hi Greg,
> 
> >  /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
> > --- a/arch/x86/include/asm/fpu/internal.h
> > +++ b/arch/x86/include/asm/fpu/internal.h
> > @@ -58,7 +58,7 @@ extern u64 fpu__get_supported_xfeatures_
> >   */
> >  static __always_inline __pure bool use_eager_fpu(void)
> >  {
> > -	return static_cpu_has_safe(X86_FEATURE_EAGER_FPU);
> > +	return true;
> >  }
> 
> Since this function returns always true then we can remove the code depending on lazy FPU mode.
> Actually this has already been done in "x86/fpu: Remove use_eager_fpu()"
> Ref: https://patchwork.kernel.org/patch/9365883/
>
> >  static void __init fpu__init_parse_early_param(void)
> >  {
> > -	if (cmdline_find_option_bool(boot_command_line, "eagerfpu=off")) {
> > -		eagerfpu = DISABLE;
> > -		fpu__clear_eager_fpu_features();
> > -	}
> 
> Since this patch removes the kernel boot parameter "eagerfpu", maybe we should remove it from the Documentation.
> This has also been done by commit "x86/fpu: Finish excising 'eagerfpu'"
> Ref: https://patchwork.kernel.org/patch/9380673/
> 
> I will try backporting those patches unless anyone has any objections.

This does seem like a good idea—there is quite a bit of dead code left
and it may be hard to backport any further bug fixes in this area
without that removal.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
