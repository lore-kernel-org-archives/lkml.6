Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBBPyk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:54:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34662 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeBBPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:54:33 -0500
Date: Fri, 2 Feb 2018 18:53:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>, Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: hypercall: fix out-of-bounds memcpy
Message-ID: <20180202155309.2xg2gjcp7wb7bbpe@mwanda>
References: <20180202153240.1190361-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202153240.1190361-1-arnd@arndb.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 04:32:31PM +0100, Arnd Bergmann wrote:
> The legacy hypercall handlers were originally added with
> a comment explaining that "copying the argument structures in
> HYPERVISOR_event_channel_op() and HYPERVISOR_physdev_op() into the local
> variable is sufficiently safe" and only made sure to not write
> past the end of the argument structure, the checks in linux/string.h
> disagree with that, when link-time optimizations are used:
> 
> In function 'memcpy',
>     inlined from 'pirq_query_unmask' at drivers/xen/fallback.c:53:2,
>     inlined from '__startup_pirq' at drivers/xen/events/events_base.c:529:2,
>     inlined from 'restore_pirqs' at drivers/xen/events/events_base.c:1439:3,
>     inlined from 'xen_irq_resume' at drivers/xen/events/events_base.c:1581:2:
> include/linux/string.h:350:3: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
>    __read_overflow2();
>    ^
> make[3]: *** [ccLujFNx.ltrans15.ltrans.o] Error 1
> make[3]: Target 'all' not remade because of errors.
> lto-wrapper: fatal error: make returned 2 exit status
> compilation terminated.
> ld: error: lto-wrapper failed
> 

It was a more naive era.  :P

> This changes the functions so that each argument is accessed with
> exactly the correct length based on the command code.
> 
> Fixes: cf47a83fb06e ("xen/hypercall: fix hypercall fallback code for very old hypervisors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/xen/fallback.c | 94 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 53 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/xen/fallback.c b/drivers/xen/fallback.c
> index b04fb64c5a91..eded8dd821ad 100644
> --- a/drivers/xen/fallback.c
> +++ b/drivers/xen/fallback.c
> @@ -7,75 +7,87 @@
>  
>  int xen_event_channel_op_compat(int cmd, void *arg)
>  {
> -	struct evtchn_op op;
> +	struct evtchn_op op = { .cmd = cmd, };
> +	size_t len;
>  	int rc;
>  
> -	op.cmd = cmd;
> -	memcpy(&op.u, arg, sizeof(op.u));
> -	rc = _hypercall1(int, event_channel_op_compat, &op);
> -
>  	switch (cmd) {
> +	case EVTCHNOP_bind_interdomain:
> +		len = sizeof(struct evtchn_bind_interdomain);
> +		break;

This was in the original code, but I'm slightly surpprised that we're
using a switch statement here instead of a table.  I would have thought
this is a fast path but I don't know xen at all.

regards,
dan carpenter
