Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4D820684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E+/KriRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfBYQhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:37:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41670 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfBYQhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GMwjB0YOeZrQAjzhQaTMpUu1AUhAe5LSmXuz2Kqr6Mg=; b=E+/KriRr/pBGI8/LURR/0dF5ls
        CvJEjpyzo8yXIK4ItZK7IjYHV6Pt1tsNxtznReceG9Egm6DlUX2LsTnsA/DlSy0qwSMFJy7LjCRTa
        P1xmmoa1LEOiQ+qVAo91ql+hXPUz1nbIjCuOeDI387LjPAycCJA7K80tXntmLGweWau3A0e3iSZSj
        JSSiPvRSgNcxD9Ny1HxGkLgiI0xHB/j/6zZjVgAUQ60kGBOVdGq62piyXwLYxojCcTtcOo34PKkSx
        o5fi9a92p2zcq/wbh03nmIWD9s5Vrz+jHaQaAoKtmWP8NQ3ne/jnQ3rkxFHOsxEKDaPiXUUC0i9Uv
        J6AgPXKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyJGF-0007aA-BE; Mon, 25 Feb 2019 16:37:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 050212026BE91; Mon, 25 Feb 2019 17:37:46 +0100 (CET)
Date:   Mon, 25 Feb 2019 17:37:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] x86/ia32: Fix ia32_restore_sigcontext AC leak
Message-ID: <20190225163745.GF32494@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125231.936952143@infradead.org>
 <CALCETrW-p4iF-RMecyNt1JDwKh74c_tw67FCW7Yr_Fd3adtGUw@mail.gmail.com>
 <20190225161003.GL32477@hirez.programming.kicks-ass.net>
 <3F83AE74-3F9E-42BB-8F9C-3033F72B3EF5@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F83AE74-3F9E-42BB-8F9C-3033F72B3EF5@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 08:29:12AM -0800, Andy Lutomirski wrote:

> > diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> > index 321fe5f5d0e9..e04eeeddcc35 100644
> > --- a/arch/x86/ia32/ia32_signal.c
> > +++ b/arch/x86/ia32/ia32_signal.c
> > @@ -53,17 +53,16 @@
> > #define GET_SEG(seg)        ({            \
> >    unsigned short tmp;                \
> >    get_user_ex(tmp, &sc->seg);            \
> > -    tmp;                        \
> > +    tmp | 3;                    \
> > })
> > 
> 
> Drop this part.
> 
> > #define COPY_SEG_CPL3(seg)    do {            \
> > -    regs->seg = GET_SEG(seg) | 3;            \
> > +    regs->seg = GET_SEG(seg);            \
> > } while (0)
> 
> And this.
> 
> Unfortunately, whether we want the | 3 varies by segment. For FS and
> GS, we definitely don’t want it, since 0 is a common and important
> value, and 3 is a deeply screwed up value.  (3 is legal to *write* to
> GS, and it sticks, but IRET silently changes it to 0, because the
> original 386 designers (I assume) confused themselves.

> > 
> > #define RELOAD_SEG(seg)        {        \
> > -    unsigned int pre = GET_SEG(seg);    \
> > +    unsigned int pre = (seg);        \
> >    unsigned int cur = get_user_seg(seg);    \
> > -    pre |= 3;                \

And here ?

> >    if (pre != cur)                \
> >        set_user_seg(seg, pre);        \
> > }

Thing is; afaict the current code _always_ does |3 on any GET_SET()
result.

If you want to change that; I'm fine with that, but lets not do that in
this same patch.

So then?

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 321fe5f5d0e9..4d5fcd47ab75 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -61,9 +61,8 @@
 } while (0)
 
 #define RELOAD_SEG(seg)		{		\
-	unsigned int pre = GET_SEG(seg);	\
+	unsigned int pre = (seg) | 3;		\
 	unsigned int cur = get_user_seg(seg);	\
-	pre |= 3;				\
 	if (pre != cur)				\
 		set_user_seg(seg, pre);		\
 }
@@ -72,6 +71,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 				   struct sigcontext_32 __user *sc)
 {
 	unsigned int tmpflags, err = 0;
+	u16 gs, fs, es, ds;
 	void __user *buf;
 	u32 tmp;
 
@@ -79,16 +79,10 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	current->restart_block.fn = do_no_restart_syscall;
 
 	get_user_try {
-		/*
-		 * Reload fs and gs if they have changed in the signal
-		 * handler.  This does not handle long fs/gs base changes in
-		 * the handler, but does not clobber them at least in the
-		 * normal case.
-		 */
-		RELOAD_SEG(gs);
-		RELOAD_SEG(fs);
-		RELOAD_SEG(ds);
-		RELOAD_SEG(es);
+		gs = GET_SEG(gs);
+		fs = GET_SEG(fs);
+		ds = GET_SEG(ds);
+		es = GET_SEG(es);
 
 		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
 		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
@@ -106,6 +100,17 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 		buf = compat_ptr(tmp);
 	} get_user_catch(err);
 
+	/*
+	 * Reload fs and gs if they have changed in the signal
+	 * handler.  This does not handle long fs/gs base changes in
+	 * the handler, but does not clobber them at least in the
+	 * normal case.
+	 */
+	RELOAD_SEG(gs);
+	RELOAD_SEG(fs);
+	RELOAD_SEG(ds);
+	RELOAD_SEG(es);
+
 	err |= fpu__restore_sig(buf, 1);
 
 	force_iret();
