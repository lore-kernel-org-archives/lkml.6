Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B680C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E082D21524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JyS5UCmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E082D21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbeITNjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:39:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeITNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7E0FRItJ2432DffZFxbBE3fsZ6GvjipO9a8Ko3bTbQw=; b=JyS5UCmOyVqOiVJ4acQgghl2F
        s3tqb5RHjspwqyu0vkLz9OZ9jh3iuidCNq3w7b1+aPeXyFZhVUtNpUVYHoc3MjwZneuz58I2gOu2Z
        LqD4AUOjwXvXHkc55fdDJq2jRkw6J7iH85STFnhMjXKi+Va1+o+h/m53vnBO0lcE+yntEc+RtYrEh
        rSDQ/0hWJihJaaR8DbbSpGdm1WHgFe/kkOkkkQJ3r4W1FKia1g4WLF58qhmfBuadYU5ZcohDi31ub
        C+fvGSgx0ZUNIkmmDHNWF1SopNaYem028fZUPAwKid5Gn2TZL+T/Gh3QUghtM6BGKLs3IjDpwjDKI
        DbHCwkwUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tpw-0005UE-Rm; Thu, 20 Sep 2018 07:57:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 491ED201EC166; Thu, 20 Sep 2018 09:57:17 +0200 (CEST)
Date:   Thu, 20 Sep 2018 09:57:17 +0200
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
Subject: Re: [PATCH 2/2] x86/speculation: Provide application property based
 STIBP protection
Message-ID: <20180920075717.GL24124@hirez.programming.kicks-ass.net>
References: <cover.1537392876.git.tim.c.chen@linux.intel.com>
 <0c55c162a077aadbfd57878e2694e35292c1a29c.1537392876.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c55c162a077aadbfd57878e2694e35292c1a29c.1537392876.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 02:35:30PM -0700, Tim Chen wrote:
> +	if (get_dumpable(tsk->mm) != SUID_DUMP_USER)
> +		test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
> +	else
> +		test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
> +}

s/test_and_//
