Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984312145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RT3/NDDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984312145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbeKTEDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:03:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389738AbeKTEDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VH8Js/f79sDvzte9nhjFucLKZjxH/ybNk99a1CltyQQ=; b=RT3/NDDgmC54ZKZpYDKoINbYm
        PvYy5lzui9So6NLuAaKeeEPl1xrTE2pYsjbMr8OhxNM+3+hCUG8FFwzFyZGWbpbH9NGQttAsSz098
        fYvZx36ALRks9891os3F21ieypjF8l7KejUXbc8IpdkXqmf3UPz9dB0fcEqpYgZkFNjPYaSv653V8
        0rWT+ZtDIORyk9SdbvWh0EIRq9PUHSjWNr6Zq6hTVYiebQbWRx9P5Pmq3+FQgxVfzzIPven4r3PaL
        eIwckW0iB1G6zJKfsWnvqmpd6rcVxj7EcVqYkJyHRY1OROFuF1wW8rMB5CswH6HXLZ2/HOECr8wPS
        /jI98ZXgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOnVq-0004vP-SD; Mon, 19 Nov 2018 17:39:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DEA32029FD58; Mon, 19 Nov 2018 18:39:04 +0100 (CET)
Date:   Mon, 19 Nov 2018 18:39:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
Message-ID: <20181119173904.GC2131@hirez.programming.kicks-ass.net>
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 07:00:07AM +0800, Aubrey Li wrote:
> Add a /proc/<pid>/arch_state interface to expose per-task cpu specific
> state values.
> 
> Exposing AVX-512 Hi16_ZMM registers usage is for the user space job
> scheduler to cluster AVX-512 using tasks together, because these tasks
> could cause core turbo frequency drop.

I still don't much like the name; how about arch_simd_state ? Also,
since we're printing an integer, I still prefer we go print the turbo
license level. I know level 1 isn't too interesting atm, but consider
future hardware widening the thing again and us growing level 3 or
something.

Also; you were going to shop around with the other architectures to see
what they want/need for this interface. I see nothing on that.
