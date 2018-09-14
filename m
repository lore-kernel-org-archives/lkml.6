Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34071FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31F221476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T1xFGiNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31F221476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeINSYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:24:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeINSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NF29tKOzYCiURtg4l6vs2wbn0JpKa4nWYshkG8p/AJs=; b=T1xFGiNm/wC6y9OWIc0HMg4HG
        wJcVuJ5hFiP+bE/ICETitQQhwEn3W1YbOqi/0wqLNJROb0B7r3mjQmM7xgI5AX/Gq3iXBRo9Fy+Hw
        2Nh++CEGikarvaha1glOPx/DjcktyX4s5nkSp4kL/eHratF31cjZxvjSJrvNQkJ4t+PldqwRY1tKG
        zHUVEmGjDstjClLZGsuPfxt5pb/SZhXkKUMPmnUtNLzgrnFRP3EEs7Nh3epW+JzyvEt22sqXQewbf
        //VeT3PARv0WINsYt+3FJo0xukJqWtby9A1gj1CVtghrQ8SLqZhOG+pbI7argCvwmA5GqHDgvV1St
        5DgV/aK1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0nqk-0002ah-0s; Fri, 14 Sep 2018 13:09:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA74A202B2E3B; Fri, 14 Sep 2018 15:09:27 +0200 (CEST)
Date:   Fri, 14 Sep 2018 15:09:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
Message-ID: <20180914130927.GK24124@hirez.programming.kicks-ass.net>
References: <20180914125006.349747096@linutronix.de>
 <2f723b28-8f81-4b02-861c-42f756a8825a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f723b28-8f81-4b02-861c-42f756a8825a@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 02:56:46PM +0200, Florian Weimer wrote:
> On 09/14/2018 02:50 PM, Thomas Gleixner wrote:
> > Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> > implementation, which extended the clockid switch case and added yet
> > another slightly different copy of the same code.
> > 
> > Especially the extended switch case is problematic as the compiler tends to
> > generate a jump table which then requires to use retpolines.
> 
> Does vDSO code really have to use retpolines?  It's in userspace, after all.

Userspace is equally susceptible to spectre-v2. Ideally we'd recompile
world with retpoline, but given the amount of inline asm in say things
like openssl and similar projects, validating that there are indeed no
indirect calls/jumps left is nontrivial.

There are currently pending patches to otherwise address user-user
spectre-v2 attacks.

