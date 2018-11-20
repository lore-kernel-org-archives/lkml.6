Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EA4C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7107208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PBpq6Tmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7107208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKUEvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:51:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeKUEvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yYG2/dt+yey+HN1j3OMMn3FS9wio/UPftluKiMcmkbE=; b=PBpq6TmuNJc4PQ/ATCAFj5CcS
        NHZ/sRhge+W/70n4H2YTH99T3Qlcm9pDkw32baZPmshbIs/en1xdf20fl5L2Yi6qLuuyQYko/sCxD
        fOf0d0tx/d4AcnweInnYHIshtYYsDnMSErg5GqxYJFIiCbCKId/tkPC+n9Us6cXbSlUqFtOEbmPVr
        JwlR01j1d4JhC5mL9dBR0CB+TtdmlorPP+WTZXjSz1QgMBK+7aSK6qyXyOXvJ0vQxekm94IcGqg3z
        0u3g6FNGsW/3MfXhh8JLCWLQ5t5UnecTAV6u/Mzt4VfCRe6w3pe1TC+Z5HTLgIH0IzdDdHcBiEo0T
        IRj6+ISsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPAbg-0000KW-Pq; Tue, 20 Nov 2018 18:18:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55DFD2029FD58; Tue, 20 Nov 2018 19:18:30 +0100 (CET)
Date:   Tue, 20 Nov 2018 19:18:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v5 02/10] x86/jump_label: Use text_poke_early() during
 early init
Message-ID: <20181120181830.GB2131@hirez.programming.kicks-ass.net>
References: <20181113130730.44844-1-namit@vmware.com>
 <20181113130730.44844-3-namit@vmware.com>
 <76c41854-b12d-5c4e-cfa4-f448e102860b@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c41854-b12d-5c4e-cfa4-f448e102860b@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:10:14AM -0800, H. Peter Anvin wrote:
> On 11/13/18 5:07 AM, Nadav Amit wrote:
> > There is no apparent reason not to use text_poke_early() while we are
> > during early-init and we do not patch code that might be on the stack
> > (i.e., we'll return to the middle of the patched code). This appears to
> > be the case of jump-labels, so do so.
> > 
> > This is required for the next patches that would set a temporary mm for
> > patching, which is initialized after some static-keys are
> > enabled/disabled.
> > 
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Co-Developed-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Nadav Amit <namit@vmware.com>
> > ---
> >  arch/x86/kernel/jump_label.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> > index aac0c1f7e354..ed5fe274a7d8 100644
> > --- a/arch/x86/kernel/jump_label.c
> > +++ b/arch/x86/kernel/jump_label.c
> > @@ -52,7 +52,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
> >  	jmp.offset = jump_entry_target(entry) -
> >  		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
> >  
> > -	if (early_boot_irqs_disabled)
> > +	/*
> > +	 * As long as we're UP and not yet marked RO, we can use
> > +	 * text_poke_early; SYSTEM_BOOTING guarantees both, as we switch to
> > +	 * SYSTEM_SCHEDULING before going either.
> > +	 */
> > +	if (system_state == SYSTEM_BOOTING)
> >  		poker = text_poke_early;
> >  
> >  	if (type == JUMP_LABEL_JMP) {
> > 
> 
> Can't we make this test in text_poke() directly, please?

He does that in 9/10 iirc.
