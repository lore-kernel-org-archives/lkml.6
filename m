Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A741C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A504F23ED3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BLhd8elg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A504F23ED3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeGFPvI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:51:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932849AbeGFPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mVw8H8DAyrXQXAqdKHAg7GhdyvfQl2PiVEYF2sdYozc=; b=BLhd8elgSdi2hU+TmvZ81mJc7
        dAyKiRTQUYkT5Kd/vEywYtUASxVJHT8oXJ/LaFIbTE3XFz1NTXNXS4rqPPSEsICcKZP/EZxzC9tZE
        oeadhI0+hV9h1oRWN/ySE7unhfsrCi6u9kq0haCu1PZBPnZWyPACChbVq3d5D516dzCAg4OwGoGFI
        IXTrdpeJ6fXpsmPetQKaP2LqK7dxe0jo6tHr2/HDSss/VKU7wcOhoZU9ZzQWzZjOZSPXF+atv8xsB
        LzWW/1/kFtMTNYFve8OTzJwivo86KXvvTezg9236r7QQi1mj6Dpfs8rPQQq3Cqjo2xTdccakcsTxy
        wLkRdYo/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbT0c-00068V-0S; Fri, 06 Jul 2018 15:50:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E1C82029764D; Fri,  6 Jul 2018 17:50:56 +0200 (CEST)
Date:   Fri, 6 Jul 2018 17:50:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180706155056.GP2494@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:12:12PM +0100, Quentin Perret wrote:

> I guess it is also worth mentioning that in the case mentioned above the
> scheduling decisions made inside one root domain can indirectly be
> impacted by the scheduling decisions made in another root domain. Some
> CPUs inside one root domain might look expensive to use simply because
> they run at a high OPP because of other CPUs of the same FD being
> over-used in another root domain.

That's simply how it is. There's nothing you can do about it, they share
a clock, teh end.
