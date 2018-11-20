Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF06C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B245F208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L45uwB9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B245F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeKTSlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:41:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50996 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeKTSle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:41:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id 125so1186515wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ekb0jPEJllaBtKlBGxP5McP2Go4hrPT0m9ss4oDg39o=;
        b=L45uwB9jxslkXs67actwLOnmI3iRxHdU/4UuITrYsboK0RcoysI7wYaOWC4X85j2rd
         EBjfDxUdVC9Bp2bJUpO3lPNDXQU7dK0Nysp9qK51Vnfvor5/hJ9jgFZi84p4+z/oCkTj
         rYkuISlXxI/1OEeOA+6KcY284/n37c1k3C70s6mfohfzNlZ9IhhNk5WwKPyRmfMe81yz
         3NeERbQ8l6V2CjgYyjshDRWcSpkEyrMY+2EMQI28d04NPOymLvHrwQQGZICbsGwoFS2U
         fMwJjhGAvO4NREbTD2fqJ9Tu+bPxLbMsHO3SFsWvV0e2WfpU1weEu7piNNvtW86H6iog
         n7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ekb0jPEJllaBtKlBGxP5McP2Go4hrPT0m9ss4oDg39o=;
        b=X+0CDKt9fejY8yQD+aX0TuSSxvpMp0HhoWGZAFoQMqgKZHrTywfyuAVE+o5u8ExlnT
         bznJ8h2u2kgL3eI7kB9dT2krBoonec0+XwuK1o20TunrZubax99EgIYODlUC8VL+BapT
         CVPnyR4PRpRbQq2xs8dYVopI3SI2InhIVrxzgs/93ra0K91GDHYVg4Qzcakjhigy02kv
         KgwvKLht8yyY5r/jPnV/2iNYB50yreWeV2lSFANb+OXeisSWRgJKZ1mnqYWLUuJt6X3v
         EPSsNHgSPq4TyWglXJgkzCdH0R7n8JvRlygQCV3LtRDHt78/gZHhB7j7QXtq3HpU5zl7
         6rbg==
X-Gm-Message-State: AGRZ1gIYNmm120HVbdX2IbrqxWQqkJ3pkLBeoXs6m3vUXSXE38MAJMD5
        /zHGAqNzMs6YBP7oCWa/ecQ=
X-Google-Smtp-Source: AJdET5fBLwVwcx24lWymE/WDXPT64L3kHzKUWY9nB4aNUnQCHQ/jAja86clr9iptq5kCg931/Sa/Jw==
X-Received: by 2002:a1c:d1cd:: with SMTP id i196mr1177946wmg.107.1542701622945;
        Tue, 20 Nov 2018 00:13:42 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z9sm1528971wrs.63.2018.11.20.00.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 00:13:42 -0800 (PST)
Date:   Tue, 20 Nov 2018 09:13:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 02/13] x86/fault: Check user_mode(regs) when validating a
 stack extension
Message-ID: <20181120081339.GA35948@gmail.com>
References: <cover.1542667307.git.luto@kernel.org>
 <e2e8e92d67d64700ba88aec73a4fc2b7986c0f87.1542667307.git.luto@kernel.org>
 <20181120073925.GC79825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120073925.GC79825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Andy Lutomirski <luto@kernel.org> wrote:
> 
> > The fault handling code tries to validate that a page fault from
> > user mode that would extend the stack is within a certain range of
> > the user SP.  regs->sp is only equal to the user SP if
> > user_mode(regs).  In the extremely unlikely event that that
> > sw_error_code had the USER bit set but the faulting instruction was
> > in the kernel (i.e. the faulting instruction was WRUSS), then the
> > *kernel* stack pointer would have been checked, which would be an
> > info leak.
> > 
> > Note to -stable maintainers: don't backport this unless you backport
> > CET.  The bug it fixes is unobservable in current kernels.
> > 
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  arch/x86/mm/fault.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 91d4d2722f2e..eae7ee3ce89b 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1377,7 +1377,7 @@ void do_user_addr_fault(struct pt_regs *regs,
> >  		bad_area(regs, sw_error_code, address);
> >  		return;
> >  	}
> > -	if (sw_error_code & X86_PF_USER) {
> > +	if (user_mode(regs)) {
> >  		/*
> >  		 * Accessing the stack below %sp is always a bug.
> >  		 * The large cushion allows instructions like enter
> 
> Note that this check is gone now due to:
> 
>   1d8ca3be86eb: x86/mm/fault: Allow stack access below %rsp
> 
> Thanks,

Ok, I like your series - I have applied the first ~7 patches of it to 
tip:x86/mm, the rest is interacting with 1d8ca3be86eb - will apply the 
rest as well once you send a v2.

Thanks,

	Ingo
