Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0316C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16172245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16172245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeKMUi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:38:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbeKMUi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:38:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8668CC02735A;
        Tue, 13 Nov 2018 10:40:57 +0000 (UTC)
Received: from krava (ovpn-204-161.brq.redhat.com [10.40.204.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id C3F425C669;
        Tue, 13 Nov 2018 10:40:55 +0000 (UTC)
Date:   Tue, 13 Nov 2018 11:40:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181113104054.GJ30042@krava>
References: <20181111194132.GA3769@krava>
 <20181111.150801.1421291572221954626.davem@davemloft.net>
 <20181111232627.GC30042@krava>
 <20181111.153259.2003083478035551655.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111.153259.2003083478035551655.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 13 Nov 2018 10:40:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 03:32:59PM -0800, David Miller wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Mon, 12 Nov 2018 00:26:27 +0100
> 
> > On Sun, Nov 11, 2018 at 03:08:01PM -0800, David Miller wrote:
> >> From: Jiri Olsa <jolsa@redhat.com>
> >> Date: Sun, 11 Nov 2018 20:41:32 +0100
> >> 
> >> > On Thu, Nov 08, 2018 at 05:07:21PM -0800, David Miller wrote:
> >> >> From: Jiri Olsa <jolsa@redhat.com>
> >> >> Date: Thu, 8 Nov 2018 08:13:03 +0100
> >> >> 
> >> >> > we could separated fork/mmaps to separate dummy event map, or just
> >> >> > parse them out in the read thread and create special queue for them
> >> >> > and drop just samples in case we are behind
> >> >> 
> >> >> What you say at the end here is basically what I am proposing.
> >> >> 
> >> >> Perf dequeues events from mmap ring as fast as possible.
> >> >> 
> >> >> Perf has two internal queues, high priority and low priority.
> >> >> 
> >> >> High priority events are never dropped.
> >> >> 
> >> >> Low priority events are dropped on overload, oldest first.
> >> > 
> >> > I added the dropping logic, it's simple so far..
> >> 
> >> So for me perf top gets into a state where the samples counter stops
> >> incrementing, but the event counter does keep moving (which is the
> >> histogram code decaying histogram entries from the display thread).
> >> 
> >> Which means the event processing has basically stopped.
> >> 
> >> The event threads are not stuck in a loop, because they respond to
> >> the "q" keypress and we can exit.
> > 
> > is the drop count showing something?
> 
> It does soon after starting up, then it drops to zero.

ok I see it on ~200 cpu server now.. we actuly spawn the
UI message box in the reader thread and wait for user to
press a key with some timeout.. which is not good ;-)

I removed that and add it to bottom line notification line
instead and now under heave load I can see lines updates
together with events being lost/drop

I also changed the lost/drop counts format to:
  lost: current/total

where current is the count within the refresh period
and total is overall counts

I pushed/rebased what I have to perf/fixes branch again

please note I had to change our compile changes, because
they wouldn't compile on x86, but I can't verify on sparc,
so you might see some compile fails again

jirka
