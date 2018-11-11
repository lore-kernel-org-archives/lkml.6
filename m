Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D68BC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308352084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308352084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbeKLJXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:23:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42328 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388702AbeKLJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 04:23:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5F2D014A6DA69;
        Sun, 11 Nov 2018 15:33:00 -0800 (PST)
Date:   Sun, 11 Nov 2018 15:32:59 -0800 (PST)
Message-Id: <20181111.153259.2003083478035551655.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181111232627.GC30042@krava>
References: <20181111194132.GA3769@krava>
        <20181111.150801.1421291572221954626.davem@davemloft.net>
        <20181111232627.GC30042@krava>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Nov 2018 15:33:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Mon, 12 Nov 2018 00:26:27 +0100

> On Sun, Nov 11, 2018 at 03:08:01PM -0800, David Miller wrote:
>> From: Jiri Olsa <jolsa@redhat.com>
>> Date: Sun, 11 Nov 2018 20:41:32 +0100
>> 
>> > On Thu, Nov 08, 2018 at 05:07:21PM -0800, David Miller wrote:
>> >> From: Jiri Olsa <jolsa@redhat.com>
>> >> Date: Thu, 8 Nov 2018 08:13:03 +0100
>> >> 
>> >> > we could separated fork/mmaps to separate dummy event map, or just
>> >> > parse them out in the read thread and create special queue for them
>> >> > and drop just samples in case we are behind
>> >> 
>> >> What you say at the end here is basically what I am proposing.
>> >> 
>> >> Perf dequeues events from mmap ring as fast as possible.
>> >> 
>> >> Perf has two internal queues, high priority and low priority.
>> >> 
>> >> High priority events are never dropped.
>> >> 
>> >> Low priority events are dropped on overload, oldest first.
>> > 
>> > I added the dropping logic, it's simple so far..
>> 
>> So for me perf top gets into a state where the samples counter stops
>> incrementing, but the event counter does keep moving (which is the
>> histogram code decaying histogram entries from the display thread).
>> 
>> Which means the event processing has basically stopped.
>> 
>> The event threads are not stuck in a loop, because they respond to
>> the "q" keypress and we can exit.
> 
> is the drop count showing something?

It does soon after starting up, then it drops to zero.
