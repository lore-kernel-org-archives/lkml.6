Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD34FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA5F2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HC2dqQ1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfB0O0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:26:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfB0O0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qbQmz9O+I+dgWtnEo9CU9Rg6JacoMSsVdHmF0wwTTJw=; b=HC2dqQ1rHujml8ePnxp3PoyzI
        Mtwq1yX4VT778ywrZpGTUx6GVPiVn/uwUuDN+4F7Tzba+cgZaUiSNeUseIquOJSN5/xXBLKXhmmLg
        qAi274xEwg9Zp9DUCzQ6tcZ1CJBIh64BxnSgR3O0j+L1qn8+akNp2wmO+qzDkp17LjF9GOK4R6tHy
        Ekt1Hix3IWkR8ggGhpWXnhXnoU0RTZnYWKvu7cWrdeWtaBFlYbU2fMSksar8PXzyqarbRCaExfJ1r
        aZRk2z3dHfgoo8Jk6HtntwlsO/mM3nZieQl25N8YWAHREuEG9aNERNv+SixtByljeu+ndyIjeAsMo
        pAmE4/Ftg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gz0AC-0004xj-GW; Wed, 27 Feb 2019 14:26:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 088332851B828; Wed, 27 Feb 2019 15:26:23 +0100 (CET)
Date:   Wed, 27 Feb 2019 15:26:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, glider@google.com, dvyukov@google.com
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
Message-ID: <20190227142623.GR32494@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net>
 <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:17:58PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 2/27/19 5:08 PM, Peter Zijlstra wrote:

> > I can't actually find any definitions of those functions, so I can't
> > very well mark the safe, even if we wanted to.
> > 
> 
> They are macro-generated. Use 'git grep DEFINE_ASAN'

Ah, indeed! I'll go have a look.
