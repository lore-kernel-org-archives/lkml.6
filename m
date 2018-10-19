Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299CAECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD2B21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jPpzrL5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD2B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJTCqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:46:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbeJTCqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ksdlofJmQ1QwFGctRYs92LqBXcoHYFmBwsUtc8zGalo=; b=jPpzrL5QV1AjvEsP+t8JnYNIp
        +0p199GgYNX/jZQ/Uu+pZ5XZZwrDS2gk8lW0b60h4J9UWccCv5/xxwTsqaUWLJh/W+7i+VF9pGzsg
        E4rbjpxh9jvC+l9FzuTbYkj/fdNWCp2rUBvSM0wz8A2Fwpws5jcIDGPCqbGCw4iWPnitDH8tqfRZI
        1lCPiiTZmHGMPSvP6v6Ub4gNcBvpALp3LlKEFzo+CfAm6wYGewnMYBLixLRftdd0v184TTqpNz0h1
        zijka/obxactZiEgBb/Pr4sCeldcMb0Vn6VCJb0C8MRdHv2eNAss4dj/b0ClU9GPogp5XQ4L3P9SR
        8vaBVv6wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDZfW-0007uR-Nh; Fri, 19 Oct 2018 18:38:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3443F20297B77; Fri, 19 Oct 2018 20:38:41 +0200 (CEST)
Date:   Fri, 19 Oct 2018 20:38:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 00/13] Provide process property based options to
 enable Spectre v2 userspace-userspace protection
Message-ID: <20181019183841.GB31016@hirez.programming.kicks-ass.net>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
 <20181019075740.GY3121@hirez.programming.kicks-ass.net>
 <591b320f-b3b0-278f-cde9-71a14b5e4d87@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591b320f-b3b0-278f-cde9-71a14b5e4d87@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 09:43:35AM -0700, Tim Chen wrote:
> On 10/19/2018 12:57 AM, Peter Zijlstra wrote:
> > On Wed, Oct 17, 2018 at 10:59:28AM -0700, Tim Chen wrote:
> >> Application to application exploit is in general difficult due to address
> >> space layout randomization in applications and the need to know an
> > 
> > Does the BTB attack on KASLR not work for userspace?
> > 
> 
> With KASLR, you can probe the kernel mapped and unmapped
> addresses with side channels like TLB and infer the kernel mapping
> offsets much more easily, as kernel is in the same address
> space as the attack process.  It is a lot harder to do
> such probing from another process that doesn't share the
> same page tables.

I said BTB; see: http://www.cs.binghamton.edu/~dima/micro16.pdf

From what I understood, local ASLR (of any kind) is a pipe dream.
