Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeERTVJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeERTVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:21:06 -0400
Date: Fri, 18 May 2018 16:21:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        tmricht@linux.ibm.com
Subject: Re: [PATCH] perf tests: Fix regex for record+probe_libc_inet_pton.sh
Message-ID: <20180518192102.GB5001@kernel.org>
References: <20180518072417.1498-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518072417.1498-1-sandipan@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 18, 2018 at 12:54:17PM +0530, Sandipan Das escreveu:
> This test currently fails because the regular expressions for
> matching the output of perf script do not consider the symbol
> offsets to be part of the output.
> 
> The symbol offsets are seen because of the default behaviour
> introduced by commit 4140d2ea74b3 ("perf script: Show symbol
> offsets by default").
> 
> Before applying this patch:
> 
>   # perf test -v "probe libc's inet_pton & backtrace it with ping"
> 
>   62: probe libc's inet_pton & backtrace it with ping       :
>   --- start ---
>   test child forked, pid 30389
>   ping 30406 [002] 307144.280983: probe_libc:inet_pton: (7f4117adf220)
>   7f4117adf220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)
>   FAIL: expected backtrace entry 1 ".*inet_pton[[:space:]]\(/usr/lib64/libc-2.25.so|inlined\)$" got "7f4117adf220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)"
>   test child finished with -1
>   ---- end ----
>   probe libc's inet_pton & backtrace it with ping: FAILED!
> 
> After applying this patch:
> 
>   # perf test -v "probe libc's inet_pton & backtrace it with ping"
> 
>   62: probe libc's inet_pton & backtrace it with ping       :
>   --- start ---
>   test child forked, pid 30539
>   ping 30556 [003] 307254.313217: probe_libc:inet_pton: (7fe19ab10220)
>   7fe19ab10220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)
>   7fe19aad5ebd getaddrinfo+0x11d (/usr/lib64/libc-2.25.so)
>   56351e3c1c71 main+0x891 (/usr/bin/ping)
>   test child finished with 0
>   ---- end ----
>   probe libc's inet_pton & backtrace it with ping: Ok

Here it went from failing with:

[root@seventh ~]# perf test -v pton
64: probe libc's inet_pton & backtrace it with ping       :
--- start ---
test child forked, pid 22590
ping 22607 [001] 12782.425689: probe_libc:inet_pton: (7f8686da4e40)
7f8686da4e40 __GI___inet_pton+0x0 (/usr/lib64/libc-2.26.so)
FAIL: expected backtrace entry 1 ".*inet_pton[[:space:]]\(/usr/lib64/libc-2.26.so|inlined\)$" got "7f8686da4e40 __GI___inet_pton+0x0 (/usr/lib64/libc-2.26.so)"
test child finished with -1
---- end ----
probe libc's inet_pton & backtrace it with ping: FAILED!
[root@seventh ~]# 

To failing with:

[root@seventh ~]# perf test -v pton
64: probe libc's inet_pton & backtrace it with ping       :
--- start ---
test child forked, pid 28954
ping 28971 [002] 14277.711200: probe_libc:inet_pton: (7fc9d66e3e40)
7fc9d66e3e40 __GI___inet_pton+0x0 (/usr/lib64/libc-2.26.so)
7fc9d66b02b4 getaddrinfo+0x124 (/usr/lib64/libc-2.26.so)
56075cb98f40 [unknown] (/usr/bin/ping)
FAIL: expected backtrace entry 3 ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" got "56075cb98f40 [unknown] (/usr/bin/ping)"
test child finished with -1
---- end ----
probe libc's inet_pton & backtrace it with ping: FAILED!
[root@seventh ~]# 

Trying to figure this out...

- Arnaldo
