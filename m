Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3676BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C9C20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jxRLfJeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfAVJFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:05:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfAVJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nEOchColTM/3kdo5tv9rkLbmsX1DYi0ROeJ5vx0DwLg=; b=jxRLfJeWQs5cm40aTmQ/pQ/hp
        A9UCxHRXRilBxmDkUNQHugVDyVf1zK29MnFohA7uTF7TP2uCdIOEmb27zp/qBhotGSCl1NjkRESpi
        EA7tWbyJ40puJ3KiCQfeyrmmx0A81bBoEX/9h2sebtOmqpHpr3KXH85aqYlM3/R58vngiTD+7+do3
        8+pppJHz1TqhVqCjgOiQwpVBfyzcXkjoprbBc8uCEsGLYaK5JdWOuWDLTjo40QiNF1ueMzL35NN1w
        JxqTJKvj1XjnAOWh1hsiKZEltEWJnxBQ2e5fyhe61BPu+xTsz08XoTslaw9xeULGH4CNkWVm8fBB8
        jTjP/LfKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glrzO-0000oN-65; Tue, 22 Jan 2019 09:04:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84E4B20D15814; Tue, 22 Jan 2019 10:04:56 +0100 (CET)
Date:   Tue, 22 Jan 2019 10:04:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
Message-ID: <20190122090456.GE13777@hirez.programming.kicks-ass.net>
References: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:05:03AM -0500, Alan Stern wrote:
> On Mon, 21 Jan 2019, Peter Zijlstra wrote:

> > Any additional ordering; like the one you have above; are not strictly
> > required for the proper functioning of the refcount. Rather, you rely on
> > additional ordering and will need to provide this explicitly:
> > 
> > 
> > 	if (refcount_dec_and_text(&x->rc)) {
> > 		/*
> > 		 * Comment that explains what we order against....
> > 		 */
> > 		smp_mb__after_atomic();
> > 		BUG_ON(!x->done*);
> > 		free(x);
> > 	}
> > 
> > 
> > Also; these patches explicitly mention that refcount_t is weaker,
> > specifically to make people aware of this difference.
> > 
> > A full smp_mb() (or two) would also be much more expensive on a number
> > of platforms and in the vast majority of the cases it is not required.
> 
> How about adding smp_rmb() into refcount_dec_and_test()?  That would
> give acq+rel semantics, which seems to be what people will expect.  And
> it wouldn't be nearly as expensive as a full smp_mb().

Yes, that's a very good suggestion.

I suppose we can add smp_acquire__after_ctrl_dep() on the true branch.
Then it reall does become rel_acq.

A wee something like so (I couldn't find an arm64 refcount, even though
I have distinct memories of talk about it).

This isn't compiled, and obviously needs comment/documentation updates
to go along with it.

---
 arch/x86/include/asm/refcount.h | 9 ++++++++-
 lib/refcount.c                  | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index dbaed55c1c24..6f7a1eb345b4 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -74,9 +74,16 @@ bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
-	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
+	bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
 					REFCOUNT_CHECK_LT_ZERO,
 					r->refs.counter, e, "cx");
+
+	if (ret) {
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+
+	return false;
 }
 
 static __always_inline __must_check
diff --git a/lib/refcount.c b/lib/refcount.c
index ebcf8cd49e05..8276ad349d48 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -190,7 +190,12 @@ bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
 
 	} while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
 
-	return !new;
+	if (!new) {
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+
+	return false;
 }
 EXPORT_SYMBOL(refcount_sub_and_test_checked);
 
