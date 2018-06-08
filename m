Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +qQzBWtLGluvUgAAmS7hNA
	; Fri, 08 Jun 2018 09:24:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EC7DE607DC; Fri,  8 Jun 2018 09:24:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 798E960290;
	Fri,  8 Jun 2018 09:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 798E960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeFHJY4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:24:56 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:43017 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750993AbeFHJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:24:53 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 62904987C6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 09:24:52 +0000 (UTC)
Received: (qmail 6897 invoked from network); 8 Jun 2018 09:24:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 8 Jun 2018 09:24:52 -0000
Date: Fri, 8 Jun 2018 10:24:51 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180608092451.mwzr6pvxh2cprzju@techsingularity.net>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <20180607123915.avrqbpp4adgj7ck4@techsingularity.net>
 <CAE4VaGBAZ0HCy-M2rC3ce9ePOBhE6H-LDVBuJDJMNFf40j70Aw@mail.gmail.com>
 <20180608074057.jtxczsw3jwx6boti@techsingularity.net>
 <CAE4VaGAgC7vDwaa-9AzJYst9hdQ5KbnrBUnk_mfp=NeTEe5dAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGAgC7vDwaa-9AzJYst9hdQ5KbnrBUnk_mfp=NeTEe5dAQ@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 10:49:03AM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> automatic NUMA balancing doesn't run long enough to migrate all the
> > memory. That would definitely be the case for STREAM.
> 
> This could explain the behavior we observe. stream is running ~20 seconds
> at the moment. I can easily change the runtime by changing the number of
> iterations. What is the time period when you expect the memory to be fully
> migrated?
> 

Unknown and unknowable. It depends entirely on the reference pattern of
the different threads. If they are fully parallelised with private buffers
that are page-aligned then I expect it to be quick (to pass the 2-reference
filter). If threads are sharing data on a 4K (base page case) or 2M boundary
(THP enabled) then it may take longer as two or more threads will disagree
on what the appropriate placement for a page is.

> I have now checked numastat logs and after 15 seconds I see roughly 80MiB
> out of 200MiB of the allocated memory migrated for each of 10 processes
> which have changed the NUMA CPU node after started. This is on 2
> socket Gold 6126 CPU @ 2.60GHz server with DDR4 2666 MHz. That's 800 MiB of
> memory migrated in 15 seconds which is results in the average migration
> rate of 50MiB/s - is this an expected value?
> 

I expect that to be far short of the capabilities of the machine.
Again, migrations can be delayed indefinitely if threads have buffers
that are not page-aligned (4K or 2M depending).

-- 
Mel Gorman
SUSE Labs
