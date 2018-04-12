Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeDLNKU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbeDLNKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:10:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A581217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 12 Apr 2018 10:10:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Martin Vuille <jpmv27@aim.com>, Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Adapt test case
 record+probe_libc_inet_pton.sh for s390
Message-ID: <20180412131012.GC9818@kernel.org>
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412081959.85193-1-tmricht@linux.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 12, 2018 at 10:19:59AM +0200, Thomas Richter escreveu:
> perf test case 58 (record+probe_libc_inet_pton.sh)
> executed on s390x using kernel 4.16.0rc3
> displays this result:
>  # ./perf trace --no-syscalls
>            -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
>      probe_libc:inet_pton: (3ffa0240448)
> 	      __GI___inet_pton (/usr/lib64/libc-2.26.so)
> 	      gaih_inet (inlined)
> 	      __GI_getaddrinfo (inlined)
> 	      main (/usr/bin/ping)
> 	      __libc_start_main (/usr/lib64/libc-2.26.so)
> 	     _start (/usr/bin/ping)
> 
> After I installed kernel 4.16.0 the same tests uses
> commands
>  # perf record -e probe_libc:inet_pton/call-graph=dwarf/
>       -o /tmp/perf.data.abc ping -6 -c 1 ::1
>  # perf script -i /tmp/perf.data.abc
> and displays:
>  ping 39048 [006] 84230.381198: probe_libc:inet_pton: (3ffa0240448)
> 	       140448 __GI___inet_pton (/usr/lib64/libc-2.26.so)
> 	       fbde1 gaih_inet (inlined)
> 	       fe2b9 __GI_getaddrinfo (inlined)
> 	        398d main (/usr/bin/ping)
> 
> Nothing else changed including glibc elfutils and other libraries
> picked up by the build.
> The entries for __libc_start_main and _start are missing.
> 
> I bisected missing __libc_start_main and _start to commit
> 3d20c6246690219881786de10d2dda93f616d0ac
> ("perf unwind: Unwind with libdw doesn't take symfs into account")

You forgot to add the author of that changeset to the CC list. Doing so
will give him the chance to look at this unintended consequence of his
work and maybe allow him to comment on your fix or provide an
alternative solution.

I've added him to the CC list now, Martin, can you please comment on
this?

- Arnaldo

> When I undo this commit I get this call stack on s390:
>  [root@s35lp76 perf]# ./perf script  -i /tmp/perf.data.abc
>  ping 39048 [006] 84230.381198: probe_libc:inet_pton: (3ffa0240448)
> 	140448 __GI___inet_pton (/usr/lib64/libc-2.26.so)
> 	 fbde1 gaih_inet (inlined)
> 	 fe2b9 __GI_getaddrinfo (inlined)
> 	  398d main (/usr/bin/ping)
> 	 22fbd __libc_start_main (/usr/lib64/libc-2.26.so)
> 	  457b _start (/usr/bin/ping)
> 
> Looks like dwarf functions dwfl_xxx  create different call back
> stack trace when using file
> /usr/lib/debug/usr/bin/ping-20161105-7.fc27.s390x.debug instead of
> file /usr/bin/ping.
> 
> Fix this test case on s390 and do not expect any call back stack
> entry after the main() function. Also be more robust and accept a
> leading __GI_ prefix in front of getaddrinfo.
> 
> On x86 this test case shows the same call stack using
> both kernel versions 4.16.0rc3 and 4.16.0 and also
> stops at main:
> 
> [root@f27 perf]# ./perf script -i /tmp/perf.data.tmr
> ping  4446 [000]   172.027088: probe_libc:inet_pton: (7fdfa08c93c0)
> 	           1393c0 __GI___inet_pton (/usr/lib64/libc-2.26.so)
> 	            fe60d getaddrinfo (/usr/lib64/libc-2.26.so)
> 	             2f40 main (/usr/bin/ping)
> 
> [root@f27 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 1ecc1f0ff84a..016882dbbc16 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -19,12 +19,10 @@ trace_libc_inet_pton_backtrace() {
>  	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
>  	case "$(uname -m)" in
>  	s390x)
> -		eventattr='call-graph=dwarf'
> +		eventattr='call-graph=dwarf,max-stack=4'
>  		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
> -		expected[3]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
> +		expected[3]="(__GI_)?getaddrinfo[[:space:]]\($libc|inlined\)$"
>  		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
> -		expected[5]="__libc_start_main[[:space:]]\($libc\)$"
> -		expected[6]="_start[[:space:]]\(.*/bin/ping.*\)$"
>  		;;
>  	*)
>  		eventattr='max-stack=3'
> -- 
> 2.14.3
