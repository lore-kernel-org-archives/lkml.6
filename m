Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B8FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA11121570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jmzn1ipG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA11121570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeHTOTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:19:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xtHmHAVF7pnDJTgigaQXYkhAdYbKy1SNx2gDcWyB5IY=; b=Jmzn1ipGkJ+AlJ9SsFAhm4iJj
        oX6a7Sia+ZgASiJ53sNZdHNp2W6pICkQ3swEWny3NhN5B7iu+x/eHAtDrp6jIpMnghGcrWyFTWADE
        YBMjrZ+gu54WUMq1vGGcM5uSruSTPE6Qd+kpKVQHKgMAl26XVjZtectnufvgFegZvtX0JkjKQHASG
        tp88bCtKnP+JwNLW97q2ZlcksjUVXxXf7UkTOzHARKr0gDuOqpd0tEZRzFwmlReNnHg9I0HT8sWDB
        6vfu33HFg7BTKQlUGbtZt/CsjGcZThiuAaseWqKU+pcaQdUcrAbAJNBmB83415tWRt8sD66EP5YJU
        QPh7CO8Ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frhyl-0001kz-Jj; Mon, 20 Aug 2018 11:04:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A06820267B13; Mon, 20 Aug 2018 13:04:10 +0200 (CEST)
Date:   Mon, 20 Aug 2018 13:04:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     leo.yan@linaro.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v5] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180820110410.GY2494@hirez.programming.kicks-ass.net>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan>
 <1582055.9b67urWYFa@aspire.rjw.lan>
 <1572343.jWaXB8XNF1@aspire.rjw.lan>
 <20180814154441.GA13920@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814154441.GA13920@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:44:41PM +0800, leo.yan@linaro.org wrote:
> I agree this patch can resolve the issue you mentioned in the commit
> log, but this patch will be fragile for below case, so it will select
> state1 but not state2, how about you think for this case?
> 
> Idle_state0::
> target_residency   TICK_USEC   Prediction
>     |                 |       /
>     V                 V      /
> -----------------------------------------------------> Time length
>                                 ^                 ^
>                                 |                 |
>                             Idle_state1:       Idle_state2:
>                             target_residency   target_residency

If someone can demonstate this is an actual problem; then we need to fix
it I suppose. But it would be very good to have a real world
need/reproducer for it first.
