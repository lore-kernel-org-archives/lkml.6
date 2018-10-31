Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9612BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9412082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9412082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbeKABG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:06:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48864 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeKABG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:06:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0AFF01461FA4A;
        Wed, 31 Oct 2018 09:08:19 -0700 (PDT)
Date:   Wed, 31 Oct 2018 09:08:16 -0700 (PDT)
Message-Id: <20181031.090816.2117345408719881030.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181031153907.GA29893@krava>
References: <20181030.220328.833911429549884471.davem@davemloft.net>
        <20181031124306.GA10660@kernel.org>
        <20181031153907.GA29893@krava>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Oct 2018 09:08:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Wed, 31 Oct 2018 16:39:07 +0100

> it'd be great to make hist processing faster, but is your main target here
> to get the load out of the reader thread, so we dont lose events during the
> hist processing?
> 
> we could queue events directly from reader thread into another thread and
> keep it (the reader thread) free of processing, focusing only on event
> reading/passing 

Indeed, we could create threads that take samples from the thread processing
the ring buffers, and insert them into the histogram.

In fact, since there is pthread locking already around the histogram
datastructures we could parallelize that as much as we want.

If beneficial we could also parallelize the ring buffer processing
into a small number of threads too.

My understanding is that in it's default mode perf gets one event ring
buffer per cpu being analyzed.  So we could divide that number of
rings by some factor, like 16 or something, and thus divide the rings
into groups of 16 with one thread assigned to each group.

There is one major concern about this though.  Creating threads makes
perf a bit more "invasive" to the workload it is observing.  And that
is something we've always worked to minimize.

I think your idea to add threads for the histogram work is great.

But I still think that the histogram code is really bloated, and doing
a full 262 byte memset on every histogram lookup is unnecessary
overhead.

