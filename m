Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E194C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526AA2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526AA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeKEFei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:34:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeKEFeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:34:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63AA030820D8;
        Sun,  4 Nov 2018 20:18:24 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 829095D75D;
        Sun,  4 Nov 2018 20:18:22 +0000 (UTC)
Date:   Sun, 4 Nov 2018 21:18:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181104201821.GA22049@krava>
References: <20181031124306.GA10660@kernel.org>
 <20181031153907.GA29893@krava>
 <20181031.090816.2117345408719881030.davem@davemloft.net>
 <20181102.233003.1814045087128749000.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102.233003.1814045087128749000.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 04 Nov 2018 20:18:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:30:03PM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 31 Oct 2018 09:08:16 -0700 (PDT)
> 
> > From: Jiri Olsa <jolsa@redhat.com>
> > Date: Wed, 31 Oct 2018 16:39:07 +0100
> > 
> >> it'd be great to make hist processing faster, but is your main target here
> >> to get the load out of the reader thread, so we dont lose events during the
> >> hist processing?
> >> 
> >> we could queue events directly from reader thread into another thread and
> >> keep it (the reader thread) free of processing, focusing only on event
> >> reading/passing 
> > 
> > Indeed, we could create threads that take samples from the thread processing
> > the ring buffers, and insert them into the histogram.
> 
> So I played around with some ideas like this and ran into some dead ends.
> 
> I ran each mmap ring's processing in a separate thread.
> 
> This doesn't help at all, the problem is that all the threads serialize
> at the pthread lock for the histogram part of the work.
> 
> And the histogram part dominates the cost of processing each sample.

yep, it suck.. I was thinking of keeping separate hist objects for
each thread and merge them at the end

> 
> Nevertheless I started work on formally threading all of the code that
> the mmap threads operate on, such as symbol processing etc. and while
> doing so I came to the conclusion that pushing the histogram processing
> only to a separate thread poses it's own set of big challenges.
> 
> To make this work we would have to make a piece of transient on-stack
> state (the processed event) into allocated persistent state.
> 
> These persistent event structures get queued up to the histogram
> thread(s).
> 
> Therefore, if the histogram thread(s) can't keep up (and as per my
> experiment above, it is easy to enter this state because the histogram
> code itself is going to run linearly with the histgram lock held),
> this persistent event memory will just get larger and larger.
> 
> We would have to find some way to parallelize the histgram code to
> make any kind of threading worthwhile.

do you have some code I could check on?

I'm going to make that separate thread to get the processing out
of the reading thread.. I think we need that in any case, so the
ring buffer is kept free as fast as possible

thanks,
jirka
