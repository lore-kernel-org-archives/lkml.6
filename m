Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10234C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC68521738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550605129;
	bh=HN856G7OScD4ymC2G12gYgRWPPMaBjqzJxKza6+Cwbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0uaERhuo3pjfABQ7BDdgZIFgCTr2TmnlY2XQ+nu61s10iA8b98lfPPeiNaawVEXJq
	 miu0Tl97L0tNDzS91krDuPJ10cZP57NT22id2pkJPqJth6J6zMW184nlPb7+tnvxvO
	 4YnP/mtIp3pwv0Pluit4TBqSEVwyFH/7eAmO639w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfBSTis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:38:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfBSTis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:38:48 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478D020855;
        Tue, 19 Feb 2019 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550605127;
        bh=HN856G7OScD4ymC2G12gYgRWPPMaBjqzJxKza6+Cwbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzKR/lETnvBSR8q6aPJahzpi3LHgLhrlabHxeTU5UGrxS5fD15Yk29ylcvTJ85IlX
         iKXb2hgn8tU0i3/kBY5t01yUxWN+MFp0U8GQQl6Ye1Vvkf15eYxKFfkLKqaGcMhKac
         q8OngXALcJ/9pRaKXz1vkE5z0NMCS/9xIalZTKhE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66E72410D5; Tue, 19 Feb 2019 16:38:44 -0300 (-03)
Date:   Tue, 19 Feb 2019 16:38:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Milian Wolff <milian.wolff@kdab.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf evsel: add support for inlined function in
 callchains
Message-ID: <20190219193844.GB25535@kernel.org>
References: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 19, 2019 at 07:38:08PM +0100, Jonas Rabenstein escreveu:
> Hi,
> sample__fprintf_callchain currently did not use the already available
> code to get the symbols of an inlined function if such information is
> available in a dso. This patchset adds the required logic to add
> appropriate lines.

You forgot to add the person that did lots of work in this area more
recently, Milian, which I'm adding here so that he have the opportunity
to comment on your work,

Thanks for working on this!

- Arnaldo
 
> As I am quite new to the code base of perf I am not sure how to test
> that changeset in a correct way. At least the codes builds and the tools
> that make use of sample__fprintf_callchain (perf-script, perf-trace and
> perf-sched as far as I can see) did not fail to run - also I did not get
> into the details of perf-trace and perf-sched as I have never used them
> before.
> 
> Another thing I am not sure how to deal with are some warnings of
> checkpatch.pl due to the 80 character line limit. Due to the long
> function names in use the current implementation already exceeded that
> limit in the same spots by even more characters as I have taken the
> inner loop and put it into a separate function.
> 
> I hope to expand my work to perf-report but thought it might be usefull
> to get already early feedback on those patches.
> 
> Thank you,
>  Jonas
> 
> Jonas Rabenstein (2):
>   perf evsel: split sample__fprintf_callchain in output and iteration
>   perf evsel: add inline functions to sample callchain output
> 
>  tools/perf/util/evsel_fprintf.c | 157 ++++++++++++++++++++++----------
>  1 file changed, 109 insertions(+), 48 deletions(-)
> 
> -- 
> 2.19.2

-- 

- Arnaldo
