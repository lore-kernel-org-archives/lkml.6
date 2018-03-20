Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeCTNjB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753170AbeCTNjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:39:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642E021716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 20 Mar 2018 10:38:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jan-Oliver Kaiser <janno@mpi-sws.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, milian.wolff@kdab.com
Subject: Re: `perf report` about 1000x(!) slower in linux 4.15
Message-ID: <20180320133851.GB3784@kernel.org>
References: <c6aa77d0-3d0c-bd03-aaa9-f1c33eff277f@mpi-sws.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6aa77d0-3d0c-bd03-aaa9-f1c33eff277f@mpi-sws.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 20, 2018 at 12:57:29PM +0100, Jan-Oliver Kaiser escreveu:
> After upgrading my system to linux 4.15 (from 4.14), `perf report` became
> unusably slow. I estimate a decrease in performance by a factor of
> 100x-1000x. Some 21M perf.data files take about 30 seconds in the
> "Processing events" step.  `git bisect` points to
 
> commit d8a88dd243a170a226aba33e7c53704db2f82aa6 (HEAD, refs/bisect/bad)
> Author: Milian Wolff <milian.wolff@kdab.com>
>     perf util: Enable handling of inlined frames by default
 
> The slowdown can be worked around with `--no-inline`. If the slowdown is
> expected, I would suggest reverting the default setting here or maybe
> printing a warning if a lot of time is spent on this feature.
 
> Do you need any additional information about my system or the recorded data
> I am looking at?

Can you try with the latest perf tool? 

[acme@jouet perf]$ make perf-tarxz-src-pkg ; ls -la perf-4*
  TAR
  PERF_VERSION = 4.16.rc6.gecd380
-rw-rw-r--. 1 acme acme 1323568 Mar 20 10:30 perf-4.16.0-rc6.tar.xz
[acme@jouet perf]$

With a recently checked out kernel sources, or, as a convenience, I'm
pushing this to:

  http://vger.kernel.org/~acme/perf/perf-4.16.0-rc6.tar.xz

You just expand it and then:

[acme@jouet tmp]$ tar xf perf-4.16.0-rc6.tar.xz 
[acme@jouet tmp]$ cd perf-4.16.0-rc6/
[acme@jouet perf-4.16.0-rc6]$ make -C tools/perf install-bin


And check if the problem is present there as well.

If it is, please tell us what is your distro, the output of:

perf report --header-only

Thanks,

- Arnaldo
