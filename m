Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A701D214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A701D214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeIQRHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:07:46 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:60527 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726169AbeIQRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:07:46 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 17 Sep 2018 20:40:48 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.151 with ESMTP; 17 Sep 2018 20:40:48 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 17 Sep 2018 20:40:48 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 47/48] perf record: Spread maps for --threads option
Message-ID: <20180917114048.GF18395@sejong>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-48-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180913125450.21342-48-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 02:54:49PM +0200, Jiri Olsa wrote:
> Currently we assign all maps to main thread. Adding
> code that spreads maps for --threads option.
> 
> For --thread option we create as many threads as there
> are memory maps in evlist, which is the number of CPUs
> in the system or CPUs we monitor. Each thread gets a
> single data mmap to read.
> 
> In addition we have also same amount of tracking mmaps
> for auxiliary events which we don't create special thread
> for. Instead we assign the to the main thread, because
> there's not much traffic expected there.
> 
> The assignment is visible from --thread-stats output:
> 
>           pid      write       poll       skip  maps (size 20K)
>     1s   9770       144B          1          0   19K   19K   19K   18K   19K
>          9772         0B          1          0   18K
>          9773         0B          1          0   19K
>          9774         0B          1          0   19K
> 
> There are 5 maps for thread 9770 (1 data map and 4 auxiliary)
> and one data map for every other thread. Each thread writes
> data to the separate data file.

Hmm.. not sure it'll work well for large machines with 1000+ cpus.
What about giving each thread a data mmap and a tracking mmap?

Thanks,
Namhyung


> 
> In addition we also pin every thread to the cpu that
> the data map belongs to in order to keep both writer
> (kernel) and reader (perf tool thread) on the same CPU.
> 
> Link: http://lkml.kernel.org/n/tip-ghcsnp3b73innq2gkl1lkfbz@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

