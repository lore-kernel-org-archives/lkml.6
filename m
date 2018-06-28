Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88BEC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C0F27187
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6k3L6jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C0F27187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964904AbeF1Jhu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:37:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54064 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933896AbeF1Jht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vcjno5+1kEEqSTgXKc+BlwgHP3isjLuWVXKbqCOPxPA=; b=i6k3L6jjLRblzvPitPU8HB/jo
        54uzJW3a0Kz32DuXMXL5N56pecHGO3vzH9wPIz5myv5/QDBqHWdUWdjshGsrymKb5aPAgMjCJvv+1
        SBG1VkXOHfcxILFuEXZMYr+kCLJIzFAJmGunsbrHss8Y05Ps48EGm6Gt6AKooCD2vmvl2X5T0LMJd
        QgWY0xsFrSUZ97CPd1qEmpSR4LBm80pVnitAcDoUhf7gLMIT3tH1DHSZ1olXUfwODg7SaleeH1z3v
        WoLzaBGJZDZSlRCVvgTCXCoQuYZItq21IC4zH59c7KX/TcaataLURRIo/9sK9GcjC2w7Ik8iKGOLK
        zqBpR5FpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYTMy-0003Eh-0X; Thu, 28 Jun 2018 09:37:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9EA22029764D; Thu, 28 Jun 2018 11:37:38 +0200 (CEST)
Date:   Thu, 28 Jun 2018 11:37:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/5] kernel/jump_label: implement generic support for
 relative references
Message-ID: <20180628093738.GE2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org>
 <20180628085003.GA2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
 <CAKv+Gu-xPR6UEiP0NT0zYXKRYXqwFCXP=nf0cC87PZdDYBZB4A@mail.gmail.com>
 <20180628092504.GC2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu-bL0neh61=1B=Dja7+tsH_ong731t2Xp17h4E1fjavjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-bL0neh61=1B=Dja7+tsH_ong731t2Xp17h4E1fjavjA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:29:40AM +0200, Ard Biesheuvel wrote:
> On 28 June 2018 at 11:25, Peter Zijlstra <peterz@infradead.org> wrote:
> >> > Meh. I thought IS_ENABLED() was preferred over #ifdef, no?
> >
> > Dunno, I just reacted to the proposed code's uglyness :-)
> >
> 
> I will try to come up with something that rhymes, ok? :-)

:-)

> >> ... and it means the sort() routine will unconditionally perform an
> >> indirect function call even if the arch does not require it.
> >
> > Yeah, not sure I care about that here, this is a one time affair, very
> > far away from any fast paths.
> >
> 
> Fair enough.

I recently had thoughts about doing the sort at link time, but then I
figured I didn't care enough to go write the tool to do that. The reason
was in that other patch-set that might conflict, that wants to use jump
labels _very_ early (for x86), so we had to lift the ideal nops stuff
and the cpu feature bits it relies upon to early code.

All in all the patch wasn't terrible and that made me completely loose
interest about doing the link-time thing again.

However, if someone is 'concerned' about the boot time performance, and
figures avoiding the sort is somehow worth it, they can look into it.
