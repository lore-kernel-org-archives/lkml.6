Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AF0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3ED20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pjixrglp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3ED20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393554AbeKVUYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:24:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387572AbeKVUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nlxKCexDfinQ53v2cJbc6YlU4kK2dKSeKr4YrA6q0xs=; b=pjixrglpTj0KU/biYwq2Tt4oR
        CQxSy813S3hvXat5IXJuLxIza8qRO4hChoImNQaQWmt+SoyvfqJPuF/7FBAVVPtqu+4NWCdpM0Mn8
        wqiGu0tSrVIv9YrwaUroWb+hJyhnYFYvmiTzp9QqfZPGtMJBnGBf4WFDvBrvgCS++ZepE8wkpBU4Y
        +glKTB5rD6ocevGUzAXeQXeS2gTqTNg4m09r0G2QhPDrSVHrC3wkzc4rHSs5FgPrBDqV7u/z671Qx
        U7QNW0KJro3eaMlIAr/SeuoZOBP8Qkfcb5Nyz54V9eQcF7Cox+xJQ986U0f08dE6kNimHjKZALyWK
        lQdsqQEIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPlYR-0005wA-D5; Thu, 22 Nov 2018 09:45:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 095972029FD58; Thu, 22 Nov 2018 10:45:41 +0100 (CET)
Date:   Thu, 22 Nov 2018 10:45:41 +0100
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
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 00/24] x86/speculation: Remedy the STIBP/IBPB overhead
Message-ID: <20181122094540.GL2131@hirez.programming.kicks-ass.net>
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201430.559770965@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:14:30PM +0100, Thomas Gleixner wrote:
> It's based on the x86/pti branch unfortunately, which contains the removal
> of the minimal asm retpoline hackery. I noticed too late. If the minimal
> asm stuff should not be backported it's trivial to rebase that series on
> Linus tree.

I see no problem with backporting those patches; the rationale for them
also holds for the stable trees, people really should have a retpoline
enabled compiler available by now.

Also, that minimal thing provided about as much protection as thinking
happy thoughts.
