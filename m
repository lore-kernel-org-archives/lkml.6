Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E3ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29F92064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29F92064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeJ1Mlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 08:41:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39448 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeJ1Mlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 08:41:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 432A3148800EB;
        Sat, 27 Oct 2018 20:58:33 -0700 (PDT)
Date:   Sat, 27 Oct 2018 20:58:30 -0700 (PDT)
Message-Id: <20181027.205830.1547905692901578490.davem@davemloft.net>
To:     acme@kernel.org
CC:     linux-kernel@vger.kernel.org, kan.liang@intel.com
Subject: UI messages in event thread hangs perf top
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Oct 2018 20:58:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If I run perf top with a "make -j128" kernel build, I get ring buffer event
processing timeouts which results in:

		ui__warning("Too slow to read ring buffer.\n"
			    "Please try increasing the period (-c) or\n"
			    "decreasing the freq (-F) or\n"
			    "limiting the number of CPUs (-C)\n");

from perf_top__mmap_read().

This hangs the main event thread.  Only the display thread runs after
this point.

We can't issue UI messages from the event thread, because those will
hang waiting for a keypress.  The display thread will eat any keys
we press and the event thread thus hangs forever.

I can tell this is what has happened because the histogram entries
continue to decay, yet the event count stops increasing.

If I put a gdb on the perf process, indeed the backtrace in the event
processing thread is in the select() call done by ui__getch().

Adding insult to injury, the display thread immediately overwrites the
warning message printed by the event thread, and thus the user has no
chance to even see it.

I really wonder how this was tested.

Perhaps we should mark the event thread in a special way and trigger
assertions if UI messages are printed from it.  Again, any such
operation will hang the thread and stop all event processing.
