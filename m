Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF90CC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8B220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5ADW9mS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8B220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeIKTSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:18:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TaMBiqVHv5sEYdqa06OfwkrAEsSBO3zFrhAYZsnN2Y4=; b=K5ADW9mSjcenMYtLgTCN+16Iw
        J0ZZBrbXvkvK19GEzu7anPSQ4nBggT0IsG9l+MPToM+vHQvTtYpdHX0QcS59UOuI5Ia3D3zXtXnK/
        cQ7Zq/KSQZLfHe4H+ObhCYw2lZF/xhz73+GKv1ON+hEyY21ruVItosG0rBy1ZUe2/3gcjQGdU+1vx
        PuY7FYGzdT9cTeSSY9SaGmiKiqPX53mD495ZZAgNs4mI8KhxiQa1VHO5q3pHUxYmo5Txn3iQhvlzV
        FhWrmdR52T6wevA71sRLo1JenPKb7qbLU5xJdh1w8t6PIy/eyPFL2pEWqeyQVh3/6hIpnrNHAofZV
        9hvYbRVKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzjVW-0006H5-BW; Tue, 11 Sep 2018 14:19:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EF202057F82F; Tue, 11 Sep 2018 16:19:08 +0200 (CEST)
Date:   Tue, 11 Sep 2018 16:19:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180911141907.GV24106@hirez.programming.kicks-ass.net>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <2c5d4b01-0eb8-f97e-6a70-44be7961d7f8@linux.intel.com>
 <20180910120643.GA4217@gmail.com>
 <1ad36918-ddd0-aa3c-c52e-e4e419409dd4@linux.intel.com>
 <20180911063512.GA130116@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911063512.GA130116@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:35:12AM +0200, Ingo Molnar wrote:
> > Well, explicit threading in the tool for AIO, in the simplest case, means 
> > incorporating some POSIX API implementation into the tool, avoiding 
> > code reuse in the first place. That tends to be error prone and costly.
> 
> It's a core competency, we better do it right and not outsource it.
> 
> Please take a look at Jiri's patches (once he re-posts them), I think it's a very good 
> starting point.

There's another reason for doing custom per-cpu threads; it avoids
bouncing the buffer memory around the machine. If the task doing the
buffer reads is the exact same as the one doing the writes, there's less
memory traffic on the interconnects.

Also, I think we can avoid the MFENCE in that case, but I'm not sure
that one is hot enough to bother about on the perf reading side of
things.
