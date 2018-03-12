Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeCLNFu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:05:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751104AbeCLNFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:05:49 -0400
Date: Mon, 12 Mar 2018 14:05:47 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf test: Fix exit code for
 record+probe_libc_inet_pton.sh
Message-ID: <20180312130547.GD23111@krava>
References: <20180312124450.30371-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312124450.30371-1-sandipan@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 06:14:50PM +0530, Sandipan Das wrote:
> This fixes record+probe_libc_inet_pton.sh from always exiting
> with code 0 and making the test pass even if the perf script
> output does not match the expected pattern.
> 
> The issue can be observed if this test is run with the verbose
> flags as shown below:
> 
> 60: probe libc's inet_pton & backtrace it with ping       :
> ...
> ping 19602 [006] 16988.413767: probe_libc:inet_pton: (7fff9a2c42e8)
> 1842e8 __GI___inet_pton (/usr/lib64/libc-2.26.so)
> 130db4 getaddrinfo (/usr/lib64/libc-2.26.so)
> 
> FAIL: expected backtrace entry 3 ".*\(.*/bin/ping.*\)$" got ""
> test child finished with 0
> ...
> probe libc's inet_pton & backtrace it with ping: Ok
> 
> Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 52c3ee701a89..1ecc1f0ff84a 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -47,7 +47,10 @@ trace_libc_inet_pton_backtrace() {
>  		[ -z "${expected[$idx]}" ] && break
>  	done
>  
> -	rm -f $file
> +	# If any statements are executed from this point onwards,
> +	# the exit code of the last among these will be reflected
> +	# in err below. If the exit code is 0, the test will pass
> +	# even if the perf script output does not match.

right :-\ but we still need to delete that $file.. I assume it will
get delete by the 'rm -f ${file}' in the script main body?

thanks,
jirka
