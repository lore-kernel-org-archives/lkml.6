Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1758C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D31020883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Stc7DE4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D31020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeGKJdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:33:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeGKJdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HNfZeAyOUk6CW6jcqB/Fxzu6JdX1Qdcn48KtH6knTyA=; b=Stc7DE4qm7DUgMExJifJ6g72m
        XRgpSoJ3tR8xnZSiD/MA19wKq1as9PGJlZgRMdgbh6Aa5A41PJ9Bpa1tuq8+sF2x5RcizJv4qzBlc
        Qeb5RtPLCdq61vOAD4Zd/OyBPfDtEbpXx9iv/hvQ4IJB1gtDqflOMzAUtIb92QBOh0JDQVzJxR9T7
        VTh82WrAgibyqXydHugtAuZB2poqrHr+2UpnaSAOmw9QoVDF68nFoxpSUKMMHTw+8oAzEEwBKgsYa
        I29JIkNLAXIxrnW/RFkjiaEjg+gkEZ/ze42j8X6bW1xO1LWXYHKPYdPK+d4GaO0gHBkTYtLvhb6z2
        KsKwToA1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdBRZ-0004eh-67; Wed, 11 Jul 2018 09:29:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F2F820291063; Wed, 11 Jul 2018 11:29:51 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:29:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 16/27] mm: Modify can_follow_write_pte/pmd for
 shadow stack
Message-ID: <20180711092951.GW2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-17-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710222639.8241-17-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:26:28PM -0700, Yu-cheng Yu wrote:
> There are three possible shadow stack PTE settings:
> 
>   Normal SHSTK PTE: (R/O + DIRTY_HW)
>   SHSTK PTE COW'ed: (R/O + DIRTY_HW)
>   SHSTK PTE shared as R/O data: (R/O + DIRTY_SW)

I count _2_ distinct states there.

> Update can_follow_write_pte/pmd for the shadow stack.

So the below disallows can_follow_write when shstk && _PAGE_DIRTY_SW,
but this here Changelog doesn't explain why. Doesn't even get close.

Also, the code is a right mess :/ Can't we try harder to not let this
shadow stack stuff escape arch code.
