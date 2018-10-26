Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4CECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774902084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774902084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJ0CXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:23:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47062 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJ0CXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:23:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8E52E148A4D2E;
        Fri, 26 Oct 2018 10:45:14 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:45:13 -0700 (PDT)
Message-Id: <20181026.104513.2239058788450235574.davem@davemloft.net>
To:     acme@kernel.org
CC:     linux-kernel@vger.kernel.org
Subject: A concern about overflow ring buffer mode
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Oct 2018 10:45:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since the last time I looked deeply into perf I notice that
perf top now uses a new ring buffer mode by default.

Basically, events are written in reverse order, and when fetching
events the tool uses an ioctl to "pause" the ring buffer.

I understand some of the reasons for pursing this kind of scheme but I
think there may be a huge downside to this design.

Yes, if the tool can't keep up with the kernel, we'd rather see newer
rather than older events.

However, pausing the ring buffer during the fetch is going to
virtually guaratee that we lose critical events that impact
interpretation of future events in a non-recoverable way.

The thing is, the new scheme causes events to be lost even if the tool
can keep up with the kernel.

Any event that happens while the tool is fetching the ring entries
will be lost forever.  The kernel simply skips queuing up the event
and increments a lost counter.  During a kernel build, I typically see
9 or so events lost each fetch.

Ok, if this is just a SAMPLE then fine, it's not a big deal.

But what if the lost event is a FORK or an EXEC or the worst one to
lose, an MMAP?

Now we can't even match up events properly and we get tons of those
dreaded "Unknown" symbols and DSOs.  The output looks terrible and the
tool becomes useless.

And yes this happens frequently.

I think the overwrite ring buffer mode should be seriously
reconsidered.  The "I'd rather see new than old events" part is fine,
but the "pause" part is not.  You can't turn event recording off on
the kernel side while you fetch some events, because it means that
critical events that allow us to properly interpret future events will
be lost.
