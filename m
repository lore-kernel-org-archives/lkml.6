Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1625C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E1721709
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E1721709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbeHNSwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbeHNSwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:52:22 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BE3215E5;
        Tue, 14 Aug 2018 16:04:35 +0000 (UTC)
Date:   Tue, 14 Aug 2018 12:04:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: implement ftrace with regs
Message-ID: <20180814120433.1f5e8da1@gandalf.local.home>
In-Reply-To: <a19d9e23-3dfa-ba9b-a177-cdc0d1035964@arm.com>
References: <20180810160043.9E45568C76@newverein.lst.de>
        <20180810160223.D360D68C76@newverein.lst.de>
        <2b5c1092-2cc0-00ec-ba3d-341dc61452b4@arm.com>
        <20180813220315.6e8dfc9c@vmware.local.home>
        <a19d9e23-3dfa-ba9b-a177-cdc0d1035964@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 09:33:52 +0100
Julien Thierry <julien.thierry@arm.com> wrote:

> On 14/08/18 03:03, Steven Rostedt wrote:
> > On Mon, 13 Aug 2018 11:54:06 +0100
> > Julien Thierry <julien.thierry@arm.com> wrote:
> >   
> >>> --- a/arch/arm64/Makefile
> >>> +++ b/arch/arm64/Makefile
> >>> @@ -78,6 +78,15 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
> >>>    KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
> >>>    endif
> >>>    
> >>> +ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >>> +  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> >>> +  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> >>> +  ifeq ($(call cc-option,-fpatchable-function-entry=2),)
> >>> +    $(warning Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
> >>> +             -fpatchable-function-entry not supported by compiler)  
> >>
> >> Shouldn't this be an error? The option -fpatchable-function-entry has
> >> been added to the CC_FLAGS_FTRACE, so any call to the compiler is gonna
> >> break anyway. Or am I missing something?  
> > 
> > I'm guessing this adds a more informative message on that error. One
> > will know why -fpatchable-function-entry was added to the CFLAGS. I'm
> > for more informative error messages being a victim of poor error
> > messages causing me to dig deep into the guts of the build
> > infrastructure to figure out simple issues.
> >   
> 
> Yes, I agree it is better to have this message. My point was that we 
> could have "$error" instead of "$warning" to stop the compilation right 
> away since we know everything is gonna break (and on parallel builds 
> this warning is gonna be drowned in compiler errors).
> 

OK, I see what you mean. If the resulting build wont boot, then yes
this should be an error and not a warning.

-- Steve
