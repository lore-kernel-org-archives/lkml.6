Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A411FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724FE206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfAIR2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:28:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfAIR2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9868E8E3DE;
        Wed,  9 Jan 2019 17:28:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id BBD535D762;
        Wed,  9 Jan 2019 17:28:43 +0000 (UTC)
Date:   Wed, 9 Jan 2019 18:28:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190109172843.GE19455@krava>
References: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 09 Jan 2019 17:28:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 04:21:33PM +0300, Alexey Budankov wrote:
> 
> The patch set implements runtime record trace compression accompanied by 
> trace file decompression implemented in the tool report mode. Zstandard 
> library API [1] is used for compression/decompression of data that come 
> from perf_events kernel data buffers.
> 
> Realized -z,--compression_level=n option provides ~3-5x avg. trace file 
> size reduction on the tested workloads what significantly saves user's 
> storage space on larger server systems where trace file size can easily 
> reach several tens or even hundreds of GiBs, especially when profiling 
> with stacks for later dwarf unwinding, context-switches tracing and etc.
> 
> The option is effective jointly with asynchronous trace writing because 
> compression requires auxiliary memory buffers to operate on and memory 
> buffers for asynchronous trace writing serve that purpose.

I dont like that it's onlt for aio only, I can't really see why it's
a problem for normal data.. can't we just have one layer before and
stream the data to the compress function instead of the file (or aio
buffers).. and that compress functions would spit out 64K size COMPRESSED
events, which would go to file (or aio buffers)

the report side would process them (decompress) on the session layer
before the tool callbacks are called

jirka
