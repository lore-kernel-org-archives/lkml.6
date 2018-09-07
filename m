Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59B1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BE32075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUAy+xzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BE32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeIGQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:18:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55500 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeIGQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BrRwFvd+XMzlvMR82ih0QvmOuAmnAZiVTkRuSMPMxz0=; b=MUAy+xzYIoGmwYWEquZbt9leZ
        57CQUYALz1RdWthDsOeYknjZP0PFQMQaboCzpMi4L8KaE/uoshNhyjet6fOPoRlFrhBr0CoIyWRi0
        SGliz8bOOV3N41UJcAd+B+u9WpR3ZJxBwxM7GPmHraityZhhn3K/8OwMqgb0h1Kjbf01kG144Twk6
        7d+sGWORb7JbZksK7r0Iwq7/Rx73Q2jL2PJOIMVecy3IxUT4AF8yMSt2d4dzrKdu+1NgwTG6AhNLI
        F265uuC52iAH6iOoSE2vYjC+RQn644M5aslCKfmEpA/bEud67icMF1bUGIpUZjped7QheC0ISQcgC
        lRv22TQgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyF5C-0001Us-BW; Fri, 07 Sep 2018 11:37:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BE372021030F; Fri,  7 Sep 2018 13:37:49 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:37:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, jhugo@codeaurora.org
Subject: Re: [PATCH] sched/fair: fix load_balance redo for null imbalance
Message-ID: <20180907113748.GV24106@hirez.programming.kicks-ass.net>
References: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:51:04AM +0200, Vincent Guittot wrote:
> It can happen that load_balance finds a busiest group and then a busiest rq
> but the calculated imbalance is in fact null.

Cute. Does that happen often?

> If the calculated imbalance is null, it's useless to try to find a busiest
> rq as no task will be migrated and we can return immediately.
> 
> This situation can happen with heterogeneous system or smp system when RT
> tasks are decreasing the capacity of some CPUs.

Is it the result of one of those "force_balance" conditions in
find_busiest_group() ? Should we not fix that to then return NULL
instead?
