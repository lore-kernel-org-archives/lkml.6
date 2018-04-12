Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDLSnW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753317AbeDLSnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:43:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E444206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 12 Apr 2018 15:43:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
        Maynard Johnson <maynard@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf tools powerpc: Fix callchain ip filtering
Message-ID: <20180412184316.GA10387@kernel.org>
References: <20180412171129.4422-1-sandipan@linux.vnet.ibm.com>
 <20180412171129.4422-2-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412171129.4422-2-sandipan@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 12, 2018 at 10:41:28PM +0530, Sandipan Das escreveu:
> For powerpc64, if a probe is added for a function without specifying
> a line number, the corresponding trap instruction is placed at offset
> 0 (for big endian) or 8 (for little endian) from the start address of
> the function. This address is in the function prologue and the trap
> instruction preceeds the instructions to set up the stack frame.

So, the author for the fixed-by patch here is Sukadev Bhattiprolu
<sukadev@linux.vnet.ibm.com>, and the reporter for the problem that
patch fixed is Maynard Johnson <maynard@us.ibm.com>, who also tested
that patch, I think it'd be better if they get CCed to have the
opportunity to ack/comment, but since everybody is at IBM, perhaps
those guys are not anymore involved with ppc at IBM?

I'm CCing anyway :-)

- Arnaldo
 
> Therefore, at this point during execution, the return address for the
> function is yet to be written to its caller's stack frame. So, the LR
> value at index 2 of the callchain ips provided by the kernel is still
> valid and must not be skipped.
> 
> This can be observed on a powerpc64le system running Fedora 27 as
> shown below.
> 
>  # perf probe -x /usr/lib64/libc-2.26.so -a inet_pton
>  # perf record -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
>  # perf script
> 
> Without this patch, the output is:
> 
>  ping 27909 [007] 532219.943481: probe_libc:inet_pton: (7fff99b0af28)
>                    15af28 __GI___inet_pton (/usr/lib64/libc-2.26.so)
>                    1105b4 getaddrinfo (/usr/lib64/libc-2.26.so)
> 
> With this patch applied, the output is:
> 
>  ping 27909 [007] 532219.943481: probe_libc:inet_pton: (7fff99b0af28)
>                    15af28 __GI___inet_pton (/usr/lib64/libc-2.26.so)
>                    10fa54 gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
>                    1105b4 getaddrinfo (/usr/lib64/libc-2.26.so)
> 
> Fixes: a60335ba3298 ("perf tools powerpc: Adjust callchain based on DWARF debug info")
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 58 ++++++++++++++++-------
>  1 file changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> index 0c370f81e002..f5179f5bb306 100644
> --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> @@ -212,6 +212,37 @@ static int check_return_addr(struct dso *dso, u64 map_start, Dwarf_Addr pc)
>  	return rc;
>  }
>  
> +/*
> + * Return:
> + *	0 if return address for the program counter @pc is on stack
> + *	1 if return address is in LR and no new stack frame was allocated
> + *	2 if return address is in LR and a new frame was allocated (but not
> + *		yet used)
> + *	-1 in case of errors
> + */
> +static int get_return_addr(struct thread *thread, u64 ip)
> +{
> +	struct addr_location al;
> +	struct dso *dso = NULL;
> +	int rc = -1;
> +
> +	thread__find_addr_location(thread, PERF_RECORD_MISC_USER,
> +			MAP__FUNCTION, ip, &al);
> +
> +	if (!al.map || !al.map->dso) {
> +		pr_debug("%" PRIx64 " dso is NULL\n", ip);
> +		return rc;
> +	}
> +
> +	dso = al.map->dso;
> +	rc = check_return_addr(dso, al.map->start, ip);
> +
> +	pr_debug("[DSO %s, sym %s, ip 0x%" PRIx64 "] rc %d\n",
> +				dso->long_name, al.sym->name, ip, rc);
> +
> +	return rc;
> +}
> +
>  /*
>   * The callchain saved by the kernel always includes the link register (LR).
>   *
> @@ -237,32 +268,25 @@ static int check_return_addr(struct dso *dso, u64 map_start, Dwarf_Addr pc)
>   */
>  int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
>  {
> -	struct addr_location al;
> -	struct dso *dso = NULL;
>  	int rc;
> -	u64 ip;
>  	u64 skip_slot = -1;
>  
>  	if (chain->nr < 3)
>  		return skip_slot;
>  
> -	ip = chain->ips[2];
> +	rc = get_return_addr(thread, chain->ips[1]);
>  
> -	thread__find_addr_location(thread, PERF_RECORD_MISC_USER,
> -			MAP__FUNCTION, ip, &al);
> -
> -	if (al.map)
> -		dso = al.map->dso;
> -
> -	if (!dso) {
> -		pr_debug("%" PRIx64 " dso is NULL\n", ip);
> +	if (rc == 1)
> +		/* Return address is still in LR and has not been updated
> +		 * in caller's stack frame. This is because the probe was
> +		 * placed at an offset from the start of the function that
> +		 * comes before the prologue code to set up the stack frame.
> +		 * So, an attempt to skip an entry based on chain->ips[2],
> +		 * i.e. the LR value, should not be made.
> +		 */
>  		return skip_slot;
> -	}
>  
> -	rc = check_return_addr(dso, al.map->start, ip);
> -
> -	pr_debug("[DSO %s, sym %s, ip 0x%" PRIx64 "] rc %d\n",
> -				dso->long_name, al.sym->name, ip, rc);
> +	rc = get_return_addr(thread, chain->ips[2]);
>  
>  	if (rc == 0) {
>  		/*
> -- 
> 2.14.3
