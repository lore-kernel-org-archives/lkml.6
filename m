Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81280ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3403120824
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3403120824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJ1NYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 09:24:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39738 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJ1NYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 09:24:30 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E6C65148800FD;
        Sat, 27 Oct 2018 21:41:05 -0700 (PDT)
Date:   Sat, 27 Oct 2018 21:41:02 -0700 (PDT)
Message-Id: <20181027.214102.1558835285408950686.davem@davemloft.net>
To:     acme@kernel.org
CC:     linux-kernel@vger.kernel.org, kan.liang@intel.com
Subject: perf synthesized mmap timeouts
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Oct 2018 21:41:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If I understand the commit message for:

commit 8cc42de736b617827a4e7664fb8d7a325bc125bc
Author: Kan Liang <kan.liang@intel.com>
Date:   Thu Jan 18 13:26:32 2018 -0800

    perf top: Check the latency of perf_top__mmap_read()

properly, the problem is that a malicious or out of control
app can be doing endless mmaps causing perf to loop forever
processing the /proc/$PID/maps file.

But that is not what this commit is handling at all.

It is instead applying a large hammer which quits if it is taking a
long time to process the maps, not if the process's mmap list is
growing endlessly while we process it.

This triggers any time I run perf top on a fully loaded system making
perf less useful than it should be.

And it triggers simply because the perf synthesize threads have to
share the cpu with the workload already running.

So it takes more than half a second to process emacs's 527 maps when
the number of running processes is ~NCPUS?  Big deal.  We should let
it finish....

The tradeoff choosen here is really bad.

Guess what happens if you don't have maps for a given process?

What happens is that for every single sample we get within that range,
we get a completely unique histogram entry.

This means potentially millions and millions of histogram entries
where there should only be a few hundred.

This makes the histogram rbtree huge, and slow to process.

So not only is top unable to provide correct histogram output, it is
also running sluggishly.

A way to mitigate the actual problem would be to snapshot the maps
file into a large buffer, if possible.  We can get the full contents
faster than the process in question can make more maps.  At most we
will do one additional read at the end if they were able to sneak in
one new mmap during the initial read.

No timeout necessary.  We have the complete maps file, our processing
time is therefore bounded.

Thanks.
