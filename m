Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF13EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878EF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cf+AORGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878EF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeIGRif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:38:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56064 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeIGRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hoYmGDjNXuRQo5qwI6bo14rhQyUc2nn/VukcE2VS5bI=; b=Cf+AORGdO2/34Z52xM61rBPm+
        XDvxGuyq3PDbzPC0Qm//z0QT8g/2CwS1PZy1PMAGuQdJvoVCAZnjsuSmFQzS6rr6NEtUmWIqJPyAC
        lXy2kzO0kfvv1ydGNqj8jVmPRtXg029rJ/B84ggu/4IuJAiVl+9HjjTKQzLmHDNxe6VvBlu6Wu0E5
        6PEFezIY5YfgtA2XOKenPxOizMUK4X9aBVHK74PQ1G8UTXlqWzYbeI9wBbmrNmgHUB5HVtRT6NSk2
        r78CqGz6Ps39kTVuc/mD4D1kxfXwtH0QH6A31cZeU9viQKQ05fMNYLaOlxFJu9V+tAIER7KRPWWFJ
        MqeWBp0ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyGKT-00026Y-Fm; Fri, 07 Sep 2018 12:57:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2252620210312; Fri,  7 Sep 2018 14:57:40 +0200 (CEST)
Date:   Fri, 7 Sep 2018 14:57:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, jhugo@codeaurora.org
Subject: Re: [PATCH] sched/fair: fix load_balance redo for null imbalance
Message-ID: <20180907125740.GJ24142@hirez.programming.kicks-ass.net>
References: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
 <20180907113748.GV24106@hirez.programming.kicks-ass.net>
 <20180907123551.GA9955@linaro.org>
 <20180907125554.GA24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907125554.GA24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 02:55:54PM +0200, Peter Zijlstra wrote:
> > Beside this patch, I'm preparing another patch in fix small imbalance to
> > ensure 1 task per CPU in similar situation but according to the comment above,
> > we can reach this situation because of tasks priority
> 
> Didn't we all hate fix_small_imbalance() ?

That is, all that load_per_task business is complete rubbish in this
cgroup world.
