Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AF2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9C02081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9C02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeKHQrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:47:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeKHQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:47:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B763308625C;
        Thu,  8 Nov 2018 07:13:07 +0000 (UTC)
Received: from krava (ovpn-204-110.brq.redhat.com [10.40.204.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7397F1F8;
        Thu,  8 Nov 2018 07:13:05 +0000 (UTC)
Date:   Thu, 8 Nov 2018 08:13:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181108071303.GB29732@krava>
References: <20181106.221349.1296959035550004994.davem@davemloft.net>
 <20181107083217.GA12870@krava>
 <20181107194344.GA29732@krava>
 <20181107.120154.1747291861102322855.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107.120154.1747291861102322855.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 08 Nov 2018 07:13:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 12:01:54PM -0800, David Miller wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Wed, 7 Nov 2018 20:43:44 +0100
> 
> > I pushed new version in my perf/fixes branch
> 
> Thanks, I'll check it out later today for sure!  This is pretty exciting
> work.
> 
> Just some random thoughts as I've been thinking about this whole
> situation a lot lately:
> 
> Something to consider might be consolidating all of the event rings
> into one.  This would force perf to process all events in "system
> order", ie. what order they actually occurred in the machine.
> 
> Yes, this means more contention for the entities inside the kernel
> queueing up the events, however the benefits are enormous.

yes, perf's ring buffer is real fast because it's per-cpu

> 
> Right now we go forwards and backwards in time as we move from one
> event ring to another, as you know.
> 
> However, we have to reconcile with the need we have to separate "high
> priority" (ie. cannot really lose) events like fork, mmap2, etc.  with
> "low priority" ones such as IP samples.
> 
> Perhaps another way to think about this is to go to the one huge mmap
> ring model, and do the prioritization internally in perf.
> 
> Actually, this opens up tons of possibilities in my mind.
> 
> Perf can queue to an internal high priority queue for fork and mmap2
> events, and never drop them.  Whilst at the same time queueing low
> priority events like IP samples into a low priority queue and dropping
> with whatever policy it wants when overloaded (f.e. drop older events
> before newer ones).

I think I can see the processing thread overloaded with data in tests,
I'll add some counters for it some we can see how much behind it gets

we could separated fork/mmaps to separate dummy event map, or just
parse them out in the read thread and create special queue for them
and drop just samples in case we are behind

jirka

> 
> I do not like the overwrite ring buffer mode that was implemented
> because it enforeces an entire set of policy decisions upon the user.
> Either the model works for you (which it currently does not for perf)
> or you can't use it at all.
> 
> If the issue is that newer events are more interesting than old ones,
> that is entirely perf's businness.  And it can implement this policy
> %100 internally to itself.  No kernel changes were ever needed to do
> this, as explained above.
> 
> Please, let's abandon this whole overwrite mode of the ring buffer.
> The old one works perfectly fine, we just have to use it properly.
> We should never have to shut off kernel side event queueing just
> because we are processing the event ring on the user side.
> 
> Thanks.
