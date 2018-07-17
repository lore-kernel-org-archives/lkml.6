Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB8FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32CC20850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ne0Ga0qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32CC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeGQPvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:51:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44012 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeGQPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T7QQXWJik7DIMUKOPsZKkZ2/AC27bc8CIYb94GWwwTA=; b=Ne0Ga0qAPKBQCjZK8R17N0XCO
        RBiAEIDk2nJ58HvJr2wtPmomGJXKqRPFJGuQ+K6y5j2nAMhumZAYeJYONf9LSNChxETxrzDSNnT2g
        juDgHnZXP3/GKVz/5n9hY+Cx/AYHeWZDvtgbIOT4EE4TY2GjCj0WLKdOWjO6+dTifjHT3qZgoLG2B
        Pia0hQ/7S8y+ITNwDe50HS8Hu5r0FQJEXio74ntjwEpSs/f9GSUeqfpWDqOGA4UzeeGJHsdj2Ft6r
        ipNHqdprVX0L4Z0gr2w/WE9JfQL/8Irl8XVYHSctnlzKd3xn0F/5kvxXXWv7JaSKVnIcT43xsZbnE
        ilySMeVmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffRjk-0001GW-0H; Tue, 17 Jul 2018 15:18:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB5BF20289332; Tue, 17 Jul 2018 17:17:58 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:17:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
  psi-pressure-stall-information-for-cpu-memory-and-io-fix-fix-fix
Message-ID: <20180717151758.GI2494@hirez.programming.kicks-ass.net>
References: <20180717135133.3627980-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717135133.3627980-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:51:24PM +0200, Arnd Bergmann wrote:
> The addition of do_div() did not do the right thing, as it assigned the
> result of the multiplication to an 'unsigned long', which truncates
> it before the division. GCC warns in various ways about this depending
> on the architecuture, e.g.
> 
> arch/arm/include/asm/div64.h:33:45: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'long unsigned int *'
> 
> This uses div_u64() instead. This is probably still a bad idea since
> we should avoid 64-bit division altogether in the scheduler, but at
> least it does the correct calculation.
> 
> Fixes: 13a67bcb35f5 ("psi-pressure-stall-information-for-cpu-memory-and-io-fix-fix")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Please fold into the fix

Please drop the entire PSI series instead.
