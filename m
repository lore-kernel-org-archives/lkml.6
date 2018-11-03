Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AAFC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16082081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16082081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeKCPkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 11:40:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46094 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKCPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 11:40:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7882F14525CCC;
        Fri,  2 Nov 2018 23:30:06 -0700 (PDT)
Date:   Fri, 02 Nov 2018 23:30:03 -0700 (PDT)
Message-Id: <20181102.233003.1814045087128749000.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181031.090816.2117345408719881030.davem@davemloft.net>
References: <20181031124306.GA10660@kernel.org>
        <20181031153907.GA29893@krava>
        <20181031.090816.2117345408719881030.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 02 Nov 2018 23:30:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 31 Oct 2018 09:08:16 -0700 (PDT)

> From: Jiri Olsa <jolsa@redhat.com>
> Date: Wed, 31 Oct 2018 16:39:07 +0100
> 
>> it'd be great to make hist processing faster, but is your main target here
>> to get the load out of the reader thread, so we dont lose events during the
>> hist processing?
>> 
>> we could queue events directly from reader thread into another thread and
>> keep it (the reader thread) free of processing, focusing only on event
>> reading/passing 
> 
> Indeed, we could create threads that take samples from the thread processing
> the ring buffers, and insert them into the histogram.

So I played around with some ideas like this and ran into some dead ends.

I ran each mmap ring's processing in a separate thread.

This doesn't help at all, the problem is that all the threads serialize
at the pthread lock for the histogram part of the work.

And the histogram part dominates the cost of processing each sample.

Nevertheless I started work on formally threading all of the code that
the mmap threads operate on, such as symbol processing etc. and while
doing so I came to the conclusion that pushing the histogram processing
only to a separate thread poses it's own set of big challenges.

To make this work we would have to make a piece of transient on-stack
state (the processed event) into allocated persistent state.

These persistent event structures get queued up to the histogram
thread(s).

Therefore, if the histogram thread(s) can't keep up (and as per my
experiment above, it is easy to enter this state because the histogram
code itself is going to run linearly with the histgram lock held),
this persistent event memory will just get larger and larger.

We would have to find some way to parallelize the histgram code to
make any kind of threading worthwhile.
