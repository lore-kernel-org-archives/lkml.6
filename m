Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF5EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E12820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E12820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeKHFPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:15:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725746AbeKHFPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:15:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12D5E88311;
        Wed,  7 Nov 2018 19:43:47 +0000 (UTC)
Received: from krava (ovpn-204-25.brq.redhat.com [10.40.204.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id 79E5919082;
        Wed,  7 Nov 2018 19:43:45 +0000 (UTC)
Date:   Wed, 7 Nov 2018 20:43:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181107194344.GA29732@krava>
References: <20181105.200321.1569039579935458312.davem@davemloft.net>
 <20181105.205342.1568518551892125916.davem@davemloft.net>
 <20181106204255.GB25020@krava>
 <20181106.221349.1296959035550004994.davem@davemloft.net>
 <20181107083217.GA12870@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107083217.GA12870@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 07 Nov 2018 19:43:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 09:32:17AM +0100, Jiri Olsa wrote:
> On Tue, Nov 06, 2018 at 10:13:49PM -0800, David Miller wrote:
> > From: Jiri Olsa <jolsa@redhat.com>
> > Date: Tue, 6 Nov 2018 21:42:55 +0100
> > 
> > > I pushed that fix in perf/fixes branch, but I'm still occasionaly
> > > hitting the namespace crash.. working on it ;-)
> > 
> > Jiri, how can this new scheme work without setting copy_on_queue
> > for the queued_events we use here?
> 
> aahh.. it won't, setting it up ;-)
> 
> > 
> > I don't see copy_on_queue being set and that means the queued event
> > structures reference the event memory directly in the mmaps, after the
> > mmap thread has released them back to the queue.
> > 
> > That means new events can come in to the mmap ring and overwrite what
> > was there previously, maybe even while deliver_event() is in the
> > middle of parsing the event.
> > 
> > Setting copy_on_queue for data[0] and data[1] makes all of the crashes
> > go away for me.
> > 
> > I get a lot of "[unknown]" shared objects shortly after perf top
> > starts up during a full workload.  I've been wondering about one
> > side effect of how the mmap queues are processed, consider the
> > following:
> > 
> > 	cpu 0			cpu 1
> > 
> > 				exec
> > 				create new mmap2 events
> > 				scheduled to cpu 0 for whatever reason
> > 	sample 1
> > 	sample 2
> > 
> > And let's say that perf top is backlogged processing the mmap ring of
> > events generated for cpu 0, and sees sample 1 and sample 2 before
> > getting to any of cpu 1's events.
> > 
> > This means the thread and map and symbol objects won't exist and
> > we'll get those '[Unknown]' histogram entries, and they won't go
> > away.
> > 
> > When it finally stops looping over the mmap ring for cpu 0's events
> > it gets to cpu 1's mmap ring and sees the exec and mmap2 events
> > but at that point it's far too late.
> > 
> > I surmise from what I see with perf top right now that this happens
> > a lot.
> 
> right, there's no reason why top should have different standards than
> record/report.. above can definitely happen, I'll enable time sample
> type and use ordered events for the queue

I pushed new version in my perf/fixes branch

jirka
