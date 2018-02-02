Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeBBXdL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:33:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46812 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeBBXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:33:03 -0500
Subject: Re: [PATCH] xen: hypercall: fix out-of-bounds memcpy
To: Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <20180202153240.1190361-1-arnd@arndb.de>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
Date: Fri, 2 Feb 2018 18:33:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180202153240.1190361-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020284
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 10:32 AM, Arnd Bergmann wrote:
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
> +	case EVTCHNOP_bind_virq:
> +		len = sizeof(struct evtchn_bind_virq);
> +		break;
> +	case EVTCHNOP_bind_pirq:
> +		len = sizeof(struct evtchn_bind_pirq);
> +		break;
>  	case EVTCHNOP_close:
> +		len = sizeof(struct evtchn_close);
> +		break;
>  	case EVTCHNOP_send:
> +		len = sizeof(struct evtchn_send);
> +		break;
> +	case EVTCHNOP_alloc_unbound:
> +		len = sizeof(struct evtchn_alloc_unbound);
> +		break;
> +	case EVTCHNOP_bind_ipi:
> +		len = sizeof(struct evtchn_bind_ipi);
> +		break;
> +	case EVTCHNOP_status:
> +		len = sizeof(struct evtchn_status);
> +		break;
>  	case EVTCHNOP_bind_vcpu:
> +		len = sizeof(struct evtchn_bind_vcpu);
> +		break;
>  	case EVTCHNOP_unmask:
> -		/* no output */
> +		len = sizeof(struct evtchn_unmask);
>  		break;
> -
> -#define COPY_BACK(eop) \
> -	case EVTCHNOP_##eop: \
> -		memcpy(arg, &op.u.eop, sizeof(op.u.eop)); \
> -		break
> -
> -	COPY_BACK(bind_interdomain);
> -	COPY_BACK(bind_virq);
> -	COPY_BACK(bind_pirq);
> -	COPY_BACK(status);
> -	COPY_BACK(alloc_unbound);
> -	COPY_BACK(bind_ipi);
> -#undef COPY_BACK
> -
>  	default:
> -		WARN_ON(rc != -ENOSYS);
> -		break;
> +		return -ENOSYS;
>  	}
>  
> +	memcpy(&op.u, arg, len);
> +	rc = _hypercall1(int, event_channel_op_compat, &op);
> +	memcpy(arg, &op.u, len);


We don't copy back for all commands, only those that are COPY_BACK.



> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(xen_event_channel_op_compat);
>  
>  int xen_physdev_op_compat(int cmd, void *arg)
>  {
> -	struct physdev_op op;
> +	struct physdev_op op = { .cmd = cmd, };
> +	size_t len;
>  	int rc;
>  
> -	op.cmd = cmd;
> -	memcpy(&op.u, arg, sizeof(op.u));
> -	rc = _hypercall1(int, physdev_op_compat, &op);
> -
>  	switch (cmd) {
>  	case PHYSDEVOP_IRQ_UNMASK_NOTIFY:
> +		len = 0;
> +		break;
> +	case PHYSDEVOP_irq_status_query:
> +		len = sizeof(struct physdev_irq_status_query);
> +		break;
>  	case PHYSDEVOP_set_iopl:
> +		len = sizeof(struct physdev_set_iopl);
> +		break;
>  	case PHYSDEVOP_set_iobitmap:
> +		len = sizeof(struct physdev_set_iobitmap);
> +		break;
> +	case PHYSDEVOP_apic_read:
>  	case PHYSDEVOP_apic_write:
> -		/* no output */
> +		len = sizeof(struct physdev_apic);
>  		break;
> -
> -#define COPY_BACK(pop, fld) \
> -	case PHYSDEVOP_##pop: \
> -		memcpy(arg, &op.u.fld, sizeof(op.u.fld)); \
> -		break
> -
> -	COPY_BACK(irq_status_query, irq_status_query);
> -	COPY_BACK(apic_read, apic_op);
> -	COPY_BACK(ASSIGN_VECTOR, irq_op);
> -#undef COPY_BACK
> -
> -	default:
> -		WARN_ON(rc != -ENOSYS);
> +	case PHYSDEVOP_ASSIGN_VECTOR:
> +		len = sizeof(struct physdev_irq);
>  		break;
> +	default:
> +		return -ENOSYS;
>  	}
>  
> +	memcpy(&op.u, arg, len);
> +	rc = _hypercall1(int, physdev_op_compat, &op);
> +	memcpy(arg, &op.u, len);

And the same is true here.

-boris

> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(xen_physdev_op_compat);
