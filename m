Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB4EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321B3208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uv2fhSVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321B3208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeGKIwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:52:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeGKIwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P4+VFJrW/P2Cuw5bL4OTQdc6VUhjyL2TUYyqkrFBUIQ=; b=uv2fhSVzfbvhgIWTQUia0j1Pl
        KQAicZXqwWIvD5zyxxxiMgYnW7KkX9a8TcD6XYnAtSfy7jot5AE6ysI9x3iRa4RgQH0ylr/4btv34
        v8D00WhaIXJu1MrQpR141RWFFRQAXFDOnzsPE5AM3bKdjXT2DUr60fYqU/IgZftr6iWiFoIsy/xmu
        6fMV60APqp4nYJfvDgoYn2gWkozy/ioozkJjEsJrLkNY2JsrXpwV+X4lV9FIIRLmJC1al6TKLxGEY
        uIYifAnGOytqCNpFZYkMCyHr8evOjCyXiOqL15o0slAc1cYihczSv5extaKiUsrU0vgFLKff0Uhc8
        mzkVJS+VA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdAnj-0001B0-Uy; Wed, 11 Jul 2018 08:48:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B4F520291063; Wed, 11 Jul 2018 10:48:42 +0200 (CEST)
Date:   Wed, 11 Jul 2018 10:48:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 11/27] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
Message-ID: <20180711084842.GR2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-12-yu-cheng.yu@intel.com>
 <fbf45667-5388-44a6-1f22-07bcc03e1804@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf45667-5388-44a6-1f22-07bcc03e1804@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:44:32PM -0700, Dave Hansen wrote:
> On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > +	/*
> > +	 * On platforms before CET, other threads could race to
> > +	 * create a RO and _PAGE_DIRTY_HW PMD again.  However,
> > +	 * on CET platforms, this is safe without a TLB flush.
> > +	 */
> 
> If I didn't work for Intel, I'd wonder what the heck CET is and what the
> heck it has to do with _PAGE_DIRTY_HW.  I think we need a better comment

And Changelog, the provided one is abysmal.

> than this.  How about:
> 
> 	Some processors can _start_ a write, but end up seeing
> 	a read-only PTE by the time they get to getting the
> 	Dirty bit.  In this case, they will set the Dirty bit,
> 	leaving a read-only, Dirty PTE which looks like a Shadow
> 	Stack PTE.
> 
> 	However, this behavior has been improved and will *not* occur on
> 	processors supporting Shadow Stacks.  Without this guarantee, a
> 	transition to a non-present PTE and flush the TLB would be
> 	needed.

I'm still struggling. I think I get the first paragraph, but then what?
