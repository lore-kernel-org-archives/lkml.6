Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818BCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A97620820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E7OMEDDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A97620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393322AbeKVTmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:42:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbeKVTmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Md5cnDEdgmtOI9k8aQ7V5KvateY4OALfCMx7IAYt0I=; b=E7OMEDDj3hiuGo5yo6KCT8zSj
        HE9+tLAhzjlDnvO5k1HCzLL19EK9ElSHhN176CHPbM5QE36JLGOgQEoy0+E1d3kGqheGdk0U5HFMK
        UNo1uUv43PfC0d7+6rz16PwwKBIjG59UnbscONy1d6TjIXze2JvwytiLahACBNh9c7eKa2fFLJBI6
        0FQsCviywd+C1W4vYKrh8Csfa0TTtqnQlVnJiKNYyNyIYc9mkHnQmR5SNahKn9wyoAjgECm1pAkRE
        5e6mKX6LEFGdeBglkrCCXs0/utSYzpsRNJnF94A+52RQw9AjdjtY4fbQ2o4BkIu4DHeFkd5ZTir2U
        n7JH/kZuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPktV-0005yK-LM; Thu, 22 Nov 2018 09:03:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 944082029FD58; Thu, 22 Nov 2018 10:03:21 +0100 (CET)
Date:   Thu, 22 Nov 2018 10:03:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 22/24] x86/speculation: Create PRCTL interface to
 restrict indirect branch speculation
Message-ID: <20181122090321.GI2131@hirez.programming.kicks-ass.net>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.414692525@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201724.414692525@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:14:52PM +0100, Thomas Gleixner wrote:
> @@ -1453,6 +1453,8 @@ static inline bool is_percpu_thread(void
>  #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
>  #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
>  #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
> +#define PFA_SPEC_INDIR_BRANCH_DISABLE	5	/* Indirect branch speculation restricted */
> +#define PFA_SPEC_INDIR_BRANCH_FORCE_DISABLE 6	/* Indirect branch speculation permanentely restricted */
>  
>  #define TASK_PFA_TEST(name, func)					\
>  	static inline bool task_##func(struct task_struct *p)		\
> @@ -1484,6 +1486,13 @@ TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ss
>  TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
>  TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
>  
> +TASK_PFA_TEST(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
> +TASK_PFA_SET(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
> +TASK_PFA_CLEAR(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
> +
> +TASK_PFA_TEST(SPEC_INDIR_BRANCH_FORCE_DISABLE, spec_indir_branch_force_disable)
> +TASK_PFA_SET(SPEC_INDIR_BRANCH_FORCE_DISABLE, spec_indir_branch_force_disable)
> +
>  static inline void
>  current_restore_flags(unsigned long orig_flags, unsigned long flags)
>  {

s/INDIR_BRANCH/IB/ would be consistent here with the SSB case.
