Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71EBECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C972146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="rVH6+yom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C972146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeINWR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:17:59 -0400
Received: from one.firstfloor.org ([193.170.194.197]:52544 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeINWR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:17:59 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id C1E9D868D7; Fri, 14 Sep 2018 19:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1536944556;
        bh=apiZP0/lCgt59mhj8khXtpmXIo5n4GKp1s2p2uH0ipg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVH6+yom45gBSZI7pCa2640YyPotHT0ORmQ+wocL0E7AYFNIpyIMwDViReczBLKq3
         89HKwNFtQoAVePVpsBb4cnuDna33Rq+ryqtWr9Ll7NIgJYZbiDHqgy11qxNWh2Y/Jf
         mKim8cJYsPZJd+cScVIs5yeKDZUnVH9pYUQUD0/M=
Date:   Fri, 14 Sep 2018 10:02:36 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914170236.y5olkroo7ydthtvi@two.firstfloor.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In big picture this patchset adds perf record --threads
> option that allows to create threads in following modes:
> 
> 1) single thread mode (current)
> 
>   $ perf record ...
>   $ perf record --threads=1 ...
> 
>   - all maps are read/stored under process thread
> 
> 2) mode with specific (X) number of threads
> 
>   $ perf record --threads=X ...
> 
>   - maps are spread equaly among threads
> 
> 3) mode that creates thread for every monitored memory map
> 
>   $ perf record --threads ...
> 
>   - which in perf record is equal to number of CPUs, and
>     it pins each thread to its map's cpu:

We need some way to flush data on a different thread than
what is processing the perf data, so essentially more threads than
CPUs. Something like this is needed for PT where even a single CPU can
generate so much data that it may take longer and longer to flush. You end up
with long gaps in the PT collection then because PT stays disabled
while the flushing happens on the same thread. If it was done
in the background in another thread these gaps would be much smaller.


Of course if Linux would finally get real file system AIO that wouldn't
be needed ...


-Andi
