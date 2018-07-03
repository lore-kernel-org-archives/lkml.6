Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411DDC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F088220BED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F088220BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeGCPDz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:03:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50816 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932273AbeGCPDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:03:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D24907A9;
        Tue,  3 Jul 2018 08:03:53 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13DB53F5AD;
        Tue,  3 Jul 2018 08:03:51 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:03:49 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>, will.deacon@arm.com,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, alex.popov@linux.com
Subject: Re: [PATCH] arm64: Clear the stack
Message-ID: <20180703150349.fndcq7h5hl3mtain@armageddon.cambridge.arm.com>
References: <20180629190553.7282-1-labbott@redhat.com>
 <9733d929-3c6a-40e1-6110-8f79975323d3@linux.com>
 <1b97aa7d-2b6c-a5df-0caa-1cd16e18a816@redhat.com>
 <20180703121440.v4olvwqb3ykgt5fm@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703121440.v4olvwqb3ykgt5fm@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:14:41PM +0100, Mark Rutland wrote:
> On Mon, Jul 02, 2018 at 11:48:05AM -0700, Laura Abbott wrote:
> > On 07/02/2018 06:02 AM, Alexander Popov wrote:
> > > On 29.06.2018 22:05, Laura Abbott wrote:
> > > > Implementation of stackleak based heavily on the x86 version
> > > > 
> > > > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > > > ---
> > > > Changes since last time:
> > > > - Minor name change in entry.S
> > > > - Converted to use the generic interfaces so there's minimal additions.
> > > > - Added the fast syscall path.
> > > > - Addition of on_thread_stack and current_top_of_stack
> > > > - Disable stackleak on hyp per suggestion
> > > > - Added a define for check_alloca. I'm still not sure about keeping it
> > > >    since the x86 version got reworked?
> > > > 
> > > > I've mostly kept this as one patch with a minimal commit text. I can
> > > > split it up and elaborate more before final merging.
> > > > ---
> 
> [...]
> 
> > > > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > > > index ec2ee720e33e..31c9da7d401e 100644
> > > > --- a/arch/arm64/kernel/entry.S
> > > > +++ b/arch/arm64/kernel/entry.S
> > > > @@ -401,6 +401,11 @@ tsk	.req	x28		// current thread_info
> > > >   	.text
> > > > +	.macro	stackleak_erase
> > > 
> > > Could you rename the macro to STACKLEAK_ERASE for similarity with x86?
> > > 
> > 
> > Mark Rutland had previously asked for this to be lowercase.
> > I really don't care one way or the other so I'll defer to
> > someone else to have the final word.
> 
> Will, Catalin, could you chime in either way?
> 
> I'd previously asked for lower-case for consistency with our other
> assembly macros.

I'd keep it lowercase as the other arm64 macros in this file.

-- 
Catalin
