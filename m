Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD04C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF69721773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550594589;
	bh=3EQiNS8ldx/yNu+QdpNhmCiBMxc5assNF+42bMkaV0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yggVrVeTcR2YOPCHwa0G8suNMWDf30XNEqT/Md7WpZ/12pbYwNR3w25WLQ/X0Qxr/
	 cFvEB9fL1nG6QHMwanQx/5Jc4mStqYAFDZxgT2LtRZKp/kLaWCi65gFMS7fVwxgKGz
	 HqcAPQY+n8KEMtwgf2mrT4p0xXhd3WBe8FeqUtfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfBSQnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBSQnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:43:07 -0500
Received: from quaco.ghostprotocols.net (unknown [179.162.130.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7540C21773;
        Tue, 19 Feb 2019 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550594586;
        bh=3EQiNS8ldx/yNu+QdpNhmCiBMxc5assNF+42bMkaV0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TETTtNeKwtEcVl27Ki5dGNs21kOtf48jrzXVNa7EndmliV3/sluWABHQ9Z/4Dzugc
         vOMwhr4SncE6M/gXkHrFeDKfUnFt/cP9rt9Q4ebnddqfeW6CWrRcPz75UngFEcngsx
         I8FZ9JSvTUz6M383mH+uDrYzl766hxfxjZCwyntc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07147410D5; Tue, 19 Feb 2019 13:43:02 -0300 (-03)
Date:   Tue, 19 Feb 2019 13:43:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Fix failure of test 14 on s390
Message-ID: <20190219164301.GE31177@kernel.org>
References: <20190219153639.31267-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219153639.31267-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 19, 2019 at 04:36:39PM +0100, Thomas Richter escreveu:
> Commit 489338a717a0 ("perf tests evsel-tp-sched: Fix bitwise operator")
> causes test case 14 "Parse sched tracepoints fields" to fail on s390.
> This test succeeds on x86.
> In fact this test now fails on all architectures with type char
> treated as type unsigned char.
> 
> The root cause is the signed-ness of character arrays in the
> tracepoints sched_switch for structure members prev_comm and
> next_comm.
> 
> On s390 the output of
>  [root@m35lp76 perf]# cat /sys/kernel/debug/tracing/events/\
> 				sched/sched_switch/format
>  name: sched_switch
>  ID: 287
>  format:
>    field:unsigned short common_type; offset:0; size:2;	signed:0;
>    ...
>    field:char prev_comm[16]; offset:8; size:16;	signed:0;
>    ...
>    field:char next_comm[16]; offset:40; size:16; signed:0;
> 
> reveals the character arrays prev_comm and next_comm are per
> default unsigned char and have values in the range of 0..255.
> 
> On x86 both fields are signed as this output shows:
>  [root@f29]# cat /sys/kernel/debug/tracing/events/sched/\
> 			sched_switch/format
>  name: sched_switch
>  ID: 287
>  format:
>    field:unsigned short common_type; offset:0; size:2;	signed:0;
>    ...
>    field:char prev_comm[16]; offset:8; size:16;	signed:1;
>    ...
>    field:char next_comm[16]; offset:40; size:16; signed:1;
> 
> and the character arrays prev_comm and next_comm are per
> default signed char and have values in the range of -1..127.
> The implementation of type char is architecture specific.
> 
> Since the character arrays in both tracepoints
> sched_switch and sched_wakeup should contain ascii characters,
> simply omit the check for signedness in the test case.
> 
> Output before:
> [root@m35lp76 perf]# ./perf test -F 14
> 14: Parse sched tracepoints fields                        :
> --- start ---
> sched:sched_switch: "prev_comm" signedness(0) is wrong, should be 1
> sched:sched_switch: "next_comm" signedness(0) is wrong, should be 1
> sched:sched_wakeup: "comm" signedness(0) is wrong, should be 1
> ---- end ----

Please indent command output by two chars to avoid things like lines
starting with '---' to break scripts that expect that to be the marker
for the end of the commit log message as below...

> 14: Parse sched tracepoints fields                        : FAILED!
> [root@m35lp76 perf]#
> 
> Output after:
> [root@m35lp76 perf]# ./perf test -Fv 14
> 14: Parse sched tracepoints fields                        :
> --- start ---
> ---- end ----
> Parse sched tracepoints fields: Ok
> [root@m35lp76 perf]#
> 
> Fixes: 489338a717a0 ("perf tests evsel-tp-sched: Fix bitwise operator")
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---

... here ^^^

I'm fixing this up now.

- Arnaldo



>  tools/perf/tests/evsel-tp-sched.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
> index 5cbba70bcdd0..ea7acf403727 100644
> --- a/tools/perf/tests/evsel-tp-sched.c
> +++ b/tools/perf/tests/evsel-tp-sched.c
> @@ -43,7 +43,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>  		return -1;
>  	}
>  
> -	if (perf_evsel__test_field(evsel, "prev_comm", 16, true))
> +	if (perf_evsel__test_field(evsel, "prev_comm", 16, false))
>  		ret = -1;
>  
>  	if (perf_evsel__test_field(evsel, "prev_pid", 4, true))
> @@ -55,7 +55,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>  	if (perf_evsel__test_field(evsel, "prev_state", sizeof(long), true))
>  		ret = -1;
>  
> -	if (perf_evsel__test_field(evsel, "next_comm", 16, true))
> +	if (perf_evsel__test_field(evsel, "next_comm", 16, false))
>  		ret = -1;
>  
>  	if (perf_evsel__test_field(evsel, "next_pid", 4, true))
> @@ -73,7 +73,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>  		return -1;
>  	}
>  
> -	if (perf_evsel__test_field(evsel, "comm", 16, true))
> +	if (perf_evsel__test_field(evsel, "comm", 16, false))
>  		ret = -1;
>  
>  	if (perf_evsel__test_field(evsel, "pid", 4, true))
> -- 
> 2.19.1

-- 

- Arnaldo
