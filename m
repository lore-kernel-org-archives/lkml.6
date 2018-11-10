Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91534C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4B921104
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6Lp8smm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4B921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeKKIaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 03:30:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50608 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeKKIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 03:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iXbJAAf6dw5cHeYZwX8Tjg68v2kN4R31IKI6Ae3Jy3w=; b=C6Lp8smmx9hrYYxiDs2enilZ6
        n70/Euj1pazHujtZ8Hee3lcRslCvWEqkdjmwpNUMwJbuQIxFP1atW3LiTVtsC04oJEgDXr/EnUTZa
        EiEkqusjXrNvivNxmhJaMIjDJjkcArmHPZ0ZOtofM5c4Yn+f/E5EoGxBYhq5+TMYYQxNQItI6edli
        dhszMnvScNBIY8K3tRtbGNZiramwCSBguk14ux9tNoMWJACCiIkKvnkIFHANIDMRZIe/V3T2NxZA3
        a9T9VNzewCbvOaKu2+9z792csNI9zeqraKbPhnaK2538qeimV9joDBDA27uMgSBfQOMzlgYQ0SrgL
        OAH1RkFWQ==;
Received: from [64.114.255.114] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLbyE-0000gI-Ck; Sat, 10 Nov 2018 22:43:15 +0000
Received: by worktop (Postfix, from userid 1000)
        id 9C6AF6E07E7; Sat, 10 Nov 2018 15:10:45 +0100 (CET)
Date:   Sat, 10 Nov 2018 15:10:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/12] locking/lockdep: Add a new class of terminal
 locks
Message-ID: <20181110141045.GD3339@worktop.programming.kicks-ass.net>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <20181109080412.GC86700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109080412.GC86700@gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:04:12AM +0100, Ingo Molnar wrote:
> BTW., if you are interested in more radical approaches to optimize 
> lockdep, we could also add a static checker via objtool driven call graph 
> analysis, and mark those locks terminal that we can prove are terminal.
> 
> This would require the unified call graph of the kernel image and of all 
> modules to be examined in a final pass, but that's within the principal 
> scope of objtool. (This 'final pass' could also be done during bootup, at 
> least in initial versions.)

Something like this is needed for objtool LTO support as well. I just
dread the build time 'regressions' this will introduce :/

The final link pass is already by far the most expensive part (as
measured in wall-time) of building a kernel, adding more work there
would really suck :/
