Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D33C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D040021479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fTtEGEBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D040021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJIRBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:01:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ULsf3qLVKhw0XY+gqJq+0f4hV7OmFUu9a7ZaHIAD8aw=; b=fTtEGEBSgkPPJyjhx3kkikslE
        WC6quQyhJ4pt4jBqN5s2RuLmpLvX/ynKkLttYmtvxbqXo8yHU6Y/ZBloz6xh558Fdb/Reptj4NKd5
        FfWWUtN/vxhwXErn6Rfqh7nETdeRsbHwb5TMh/zUNuIjx6NK5GYQHHspY+DTj8/UKv5an2Dv4AY0I
        LCijSHraTf+/7+llWkLiVvX21v4jPU6EIysoiac6O02waVJcZm/HVjCvjvGBycjWdsixmp5ptOqxq
        RRhx/M/CkhDsoGNwkkNkK0aGcA5OueeQwZwNFNxBGVRTIuOQv+IhqPsdZlIUn4+8cH1eKaHxCYjHx
        UC3JTXGQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9oZJ-00036C-6v; Tue, 09 Oct 2018 09:44:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 441FF20281DC1; Tue,  9 Oct 2018 11:44:41 +0200 (CEST)
Date:   Tue, 9 Oct 2018 11:44:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181009094441.GI5663@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:24:26AM +0200, Juri Lelli wrote:
> The main concerns I have with the current approach is that, being based
> on mutex.c, it's both
> 
>  - not linked with futexes
>  - not involving "legacy" priority inheritance (rt_mutex.c)
> 
> I believe one of the main reasons Peter started this on mutexes is to
> have better coverage of potential problems (which I can assure everybody
> it had). I'm not yet sure what should we do moving forward, and this is
> exactly what I'd be pleased to hear your opinions on.

Well that, and mutex was 'simple', I didn't have to go rip out all the
legacy PI crud.

If this all ends up working well, the solution is 'simple' and we can
simply copy mutex to rt_mutex or something along those lines if we want
to keep the distinction between them. Alternatively we simply delete
rt_mutex.

Thanks for reviving this.. it's been an 'interesting' year and a half
since I wrote all this and I've really not had time to work on it.
