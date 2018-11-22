Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA92C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D76A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIs2m1c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D76A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390529AbeKVVEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:04:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387916AbeKVVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O39YNV2aymG2VkpZWNgmZTwTXceMdVz/pXsat3CB6tU=; b=UIs2m1c78ciJr9mFHasCToI+g
        QaTTJMk8wiSYEM69vXYzz2AQHkjv+rnquRDd99yjpHYWZI0BRUrPPbEQ9akKQwIurGa7ND5zk8Y97
        u68kQVJgy3uoUv1fEWufwb1XT4dgqY6I6OBdEPgwG+iFzP9Sb++CMi5sNBWSzBziJ57w8HmYF1pvv
        u+w4rABbEJ5U4G6N9P/8EsES8KLThmjy+WNBukj9OVHMK/SPfhNHEN6rw2xuGSVeQd3+31k916gW3
        iXK4sJAV2rEBU2p/SPXMF98VdDyUCbkfTLe8H4bSMh/Fhs+nQrglXVsTf4p39D+Tc0fL/ApHedE8Y
        DSiA2HWhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPmBD-0005zP-0S; Thu, 22 Nov 2018 10:25:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1A672029FD58; Thu, 22 Nov 2018 11:25:45 +0100 (CET)
Date:   Thu, 22 Nov 2018 11:25:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Message-ID: <20181122102545.GQ2131@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net>
 <20181121151444.t3zye5l5iycfni2s@queper01-lin>
 <20181122091715.6kvhcbgoqrd54nbs@queper01-lin>
 <20181122093237.goxmr4p5l4h2izid@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122093237.goxmr4p5l4h2izid@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:32:39AM +0000, Quentin Perret wrote:
> Hmm, I went too fast, that's totally broken. But there's still something
> we can do with static_branch_{inc,dec} I think. I'll come back later
> with a better solution.

Right; if you count the rd's that have pd set, it should work-ish. Yes,
much cleaner if you can get it to work.


