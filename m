Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6077C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C8B2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C8B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeKHPiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:38:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51684 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKHPiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:38:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6CF0A1479DEFA;
        Wed,  7 Nov 2018 22:04:25 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:04:24 -0800 (PST)
Message-Id: <20181107.220424.2221817007547297022.davem@davemloft.net>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181107202815.GH18346@kernel.org>
References: <20181107194344.GA29732@krava>
        <20181107.120154.1747291861102322855.davem@davemloft.net>
        <20181107202815.GH18346@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 07 Nov 2018 22:04:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Wed, 7 Nov 2018 17:28:15 -0300

> So perhaps we should tell the kernel that is ok to lose SAMPLEs but not
> the other events, and make userspace ask for PERF_RECORD_!SAMPLE in all
> ring buffers? Duplication wouldn't be that much of a problem?

I think we should strive to keep the policy in userspace.

The kernel simply provides the events that happen, and the user's
job is to take the events in sort of a "high priority interrupt"
context and push the slow path processing to a separate thread of
execution where drop policy can be implemented.

Jiri's work provides a framework for exactly that.

So what we can have is:

	cpu1  cpu2  cpu3  cpu4  cpu5  cpu6 ... cpuN
	|     |     |     |     |     |        |
	----------------------------------------
	                  |
			  |
			  | single event ring buffer
			  |
			  |
		ultra-fast perf event dequeue
	     queues in-order to event processing
		          |
		  event processing slow path
	        prioritization and drop policy
		     histogram insert
		        etc.
