Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541EFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2615E20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547213527;
	bh=cmZKf2wkusTxzdB1yzxbqR7LWETTrx9cTnqsLgpJrU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NRI/+50Dfbwmq9irNj/P+tx+UzZFltq+eKpwJ89GjTPXuGVfaNSbJgpGY/B38mVTt
	 E4rJEgTKqrlJL4Hh0VoNm44IpmoI/8PufAQWj8AqGH6S7FJeS47S3nbrLnJGLaZh9f
	 Pd1AiR2ATZ2rzlyx6qW+QNA2qBR96Kx6uxFPL7A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfAKNcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfAKNcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:32:05 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCBBA20874;
        Fri, 11 Jan 2019 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547213525;
        bh=cmZKf2wkusTxzdB1yzxbqR7LWETTrx9cTnqsLgpJrU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgLWLz7kSc7vRnF7ddSNAHt3Mv/1atecrU9MV0cxJK+4AmVHr7Ys3l9vU4oSKqAH1
         2fDrfpQS2CtWv2gNb1CwERfxfkiaHURZvHX9HvqkAcIW5mvbDtiqGE9aVlDvy+dzWF
         MV1smrxungpS2HoTxUrIAo14imP84DZ9fjL9r73U=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7878641AB5; Fri, 11 Jan 2019 10:32:02 -0300 (-03)
Date:   Fri, 11 Jan 2019 10:32:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: replace automatic const char[] variables by statics
Message-ID: <20190111133202.GS22483@kernel.org>
References: <20181102230624.20064-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102230624.20064-1-linux@rasmusvillemoes.dk>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 03, 2018 at 12:06:23AM +0100, Rasmus Villemoes escreveu:
> An automatic const char[] variable gets initialized at runtime, just
> like any other automatic variable. For long strings, that uses a lot of
> stack and wastes time building the string; e.g. for the "No %s
> allocation events..." case one has
> 
>   444516:       48 b8 4e 6f 20 25 73 20 61 6c   movabs $0x6c61207325206f4e,%rax # "No %s al"
>   ...
>   444674:       48 89 45 80                     mov    %rax,-0x80(%rbp)
>   444678:       48 b8 6c 6f 63 61 74 69 6f 6e   movabs $0x6e6f697461636f6c,%rax # "location"
>   444682:       48 89 45 88                     mov    %rax,-0x78(%rbp)
>   444686:       48 b8 20 65 76 65 6e 74 73 20   movabs $0x2073746e65766520,%rax # " events "
>   444690:       66 44 89 55 c4                  mov    %r10w,-0x3c(%rbp)
>   444695:       48 89 45 90                     mov    %rax,-0x70(%rbp)
>   444699:       48 b8 66 6f 75 6e 64 2e 20 20   movabs $0x20202e646e756f66,%rax
> 
> Make them all static so that the compiler just references objects in .rodata.
> 

Ok, using dwarves's codiff tool:

  $ codiff --functions /tmp/perf.before ~/bin/perf
builtin-sched.c:
  cmd_sched                 |  -48
 1 function changed, 48 bytes removed, diff: -48

builtin-report.c:
  cmd_report                |  -32
 1 function changed, 32 bytes removed, diff: -32

builtin-kmem.c:
  cmd_kmem                  |  -64
  build_alloc_func_list     |  -50
 2 functions changed, 114 bytes removed, diff: -114

builtin-c2c.c:
  perf_c2c__report          | -390
 1 function changed, 390 bytes removed, diff: -390

ui/browsers/header.c:
  tui__header_window        | -104
 1 function changed, 104 bytes removed, diff: -104

/home/acme/bin/perf:
 9 functions changed, 688 bytes removed, diff: -688

Thanks, applied.

- Arnaldo
