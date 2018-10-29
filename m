Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A82C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B6620870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1J1Fw3MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B6620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeJ2VOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbeJ2VOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:14:02 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6002082B;
        Mon, 29 Oct 2018 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540815934;
        bh=MATkEiWkKx28l5r1eAGqGiGrnlmfPr/t2d4/AdsICcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1J1Fw3MZQ4J1cKen2RoBq+G+RYn+spkH5+bnbUhP/+vv9xpbjAPIxCLCdKiQxQXud
         D9NKfA/11vjfsYd7NY0CoM534fhxmjjtO3QgRTHyMMHIqUhOpD8wdWCu6cldMTOcfC
         iB0/64MNeWIWorC4eRRU/8hiRf4f9rfI0gGQu6Bw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id EDC54142C5F; Mon, 29 Oct 2018 09:25:28 -0300 (-03)
Date:   Mon, 29 Oct 2018 09:25:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, kan.liang@intel.com
Subject: Re: UI messages in event thread hangs perf top
Message-ID: <20181029122528.GA20813@kernel.org>
References: <20181027.205830.1547905692901578490.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027.205830.1547905692901578490.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 27, 2018 at 08:58:30PM -0700, David Miller escreveu:
> 
> If I run perf top with a "make -j128" kernel build, I get ring buffer event
> processing timeouts which results in:
> 
> 		ui__warning("Too slow to read ring buffer.\n"
> 			    "Please try increasing the period (-c) or\n"
> 			    "decreasing the freq (-F) or\n"
> 			    "limiting the number of CPUs (-C)\n");
> 
> from perf_top__mmap_read().
> 
> This hangs the main event thread.  Only the display thread runs after
> this point.
> 
> We can't issue UI messages from the event thread, because those will
> hang waiting for a keypress.  The display thread will eat any keys
> we press and the event thread thus hangs forever.
> 
> I can tell this is what has happened because the histogram entries
> continue to decay, yet the event count stops increasing.
> 
> If I put a gdb on the perf process, indeed the backtrace in the event
> processing thread is in the select() call done by ui__getch().
> 
> Adding insult to injury, the display thread immediately overwrites the
> warning message printed by the event thread, and thus the user has no
> chance to even see it.
> 
> I really wonder how this was tested.
> 
> Perhaps we should mark the event thread in a special way and trigger
> assertions if UI messages are printed from it.  Again, any such
> operation will hang the thread and stop all event processing.

Right, I thought about marking a flag in the main event thread that then
gets picked up by the display thread, I'll try and write a patch for
that, if none has been submitted, I'm still downloading this weekend's
messages.

- Arnaldo

P.S. I was busy working as a volunteer in the brazilian elections :-\
