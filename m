Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E6A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLqN7+vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E6A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJJSTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:19:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJSTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=63oqnFkd/F82AU79+z6Cbi920zPcIqocGOCjN9vvNc4=; b=dLqN7+vkdknSBIvASrNv5pEtG
        fsF2Mdg6ZIp9dgoRrKJJn++2QK/Hii9Sdfc/FH3WygBoloM/fzZYZifcj9kD0I208DcgT1+BuzHfr
        OZk3MqbskBwsxaoiluYCwqBTRL/Q1/Twj/MJ5rEmisL5qVbqQ0ghcg2mpjgR79CCzxiJIE/HgvRLD
        TPIkSKFXmMzGtlc8Tg8djq2JPCsOarEaCoqZOAlgCD3YHOMLKXRKgr1M/m7SxFspCdj04XFA1HAsk
        MhSHsIS/qZiSr5IikPpo7ILSi37SwuVUYOfekDLu5xsHF9zi/09udUMkHgqdTqJS66S0aqM0rMN/d
        f3T3+V/rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gACAy-0004e2-5r; Wed, 10 Oct 2018 10:57:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCEDE20298C11; Wed, 10 Oct 2018 12:57:10 +0200 (CEST)
Date:   Wed, 10 Oct 2018 12:57:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181010105710.GP5728@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010123417.26c682ef@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010123417.26c682ef@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 12:34:17PM +0200, luca abeni wrote:
> So, I would propose to make the proxy() function of patch more generic,
> and not strictly bound to mutexes. Maybe a task structure can contain a
> list of tasks for which the task can act as a proxy, and we can have a
> function like "I want to act as a proxy for task T" to be invoked when
> a task blocks?

Certainly possible, but that's something I'd prefer to look at after it
all 'works'. The mutex blocking thing doesn't require external
interfaces etc..
