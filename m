Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F634C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C13A20818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C13A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeKHFds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:33:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43562 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKHFds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:33:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3962F145508A2;
        Wed,  7 Nov 2018 12:01:55 -0800 (PST)
Date:   Wed, 07 Nov 2018 12:01:54 -0800 (PST)
Message-Id: <20181107.120154.1747291861102322855.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181107194344.GA29732@krava>
References: <20181106.221349.1296959035550004994.davem@davemloft.net>
        <20181107083217.GA12870@krava>
        <20181107194344.GA29732@krava>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 07 Nov 2018 12:01:55 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Wed, 7 Nov 2018 20:43:44 +0100

> I pushed new version in my perf/fixes branch

Thanks, I'll check it out later today for sure!  This is pretty exciting
work.

Just some random thoughts as I've been thinking about this whole
situation a lot lately:

Something to consider might be consolidating all of the event rings
into one.  This would force perf to process all events in "system
order", ie. what order they actually occurred in the machine.

Yes, this means more contention for the entities inside the kernel
queueing up the events, however the benefits are enormous.

Right now we go forwards and backwards in time as we move from one
event ring to another, as you know.

However, we have to reconcile with the need we have to separate "high
priority" (ie. cannot really lose) events like fork, mmap2, etc.  with
"low priority" ones such as IP samples.

Perhaps another way to think about this is to go to the one huge mmap
ring model, and do the prioritization internally in perf.

Actually, this opens up tons of possibilities in my mind.

Perf can queue to an internal high priority queue for fork and mmap2
events, and never drop them.  Whilst at the same time queueing low
priority events like IP samples into a low priority queue and dropping
with whatever policy it wants when overloaded (f.e. drop older events
before newer ones).

I do not like the overwrite ring buffer mode that was implemented
because it enforeces an entire set of policy decisions upon the user.
Either the model works for you (which it currently does not for perf)
or you can't use it at all.

If the issue is that newer events are more interesting than old ones,
that is entirely perf's businness.  And it can implement this policy
%100 internally to itself.  No kernel changes were ever needed to do
this, as explained above.

Please, let's abandon this whole overwrite mode of the ring buffer.
The old one works perfectly fine, we just have to use it properly.
We should never have to shut off kernel side event queueing just
because we are processing the event ring on the user side.

Thanks.
