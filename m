Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeD0KOB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:14:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757609AbeD0KN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:13:57 -0400
Date: Fri, 27 Apr 2018 12:13:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com,
        Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/5] vfio: ccw: add traceponits for interesting error
 paths
Message-ID: <20180427121353.4453bdc2.cohuck@redhat.com>
In-Reply-To: <20180423110113.59385-6-bjsdjshi@linux.vnet.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
        <20180423110113.59385-6-bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 13:01:13 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

typo in subject: s/traceponits/tracepoints/

> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> Add some tracepoints so we can inspect what is not working as is should.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/Makefile         |  1 +
>  drivers/s390/cio/vfio_ccw_fsm.c   | 16 +++++++-
>  drivers/s390/cio/vfio_ccw_trace.h | 77 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_trace.h


> @@ -135,6 +142,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  			goto err_out;
>  
>  		io_region->ret_code = cp_prefetch(&private->cp);
> +		trace_vfio_ccw_cp_prefetch(get_schid(private),
> +					   io_region->ret_code);
>  		if (io_region->ret_code) {
>  			cp_free(&private->cp);
>  			goto err_out;
> @@ -142,11 +151,13 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  
>  		/* Start channel program and wait for I/O interrupt. */
>  		io_region->ret_code = fsm_io_helper(private);
> +		trace_vfio_ccw_fsm_io_helper(get_schid(private),
> +					     io_region->ret_code);
>  		if (io_region->ret_code) {
>  			cp_free(&private->cp);
>  			goto err_out;
>  		}
> -		return;
> +		goto out;
>  	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
>  		/* XXX: Handle halt. */
>  		io_region->ret_code = -EOPNOTSUPP;
> @@ -159,6 +170,9 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  
>  err_out:
>  	private->state = VFIO_CCW_STATE_IDLE;
> +out:
> +	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
> +			       io_region->ret_code);
>  }
>  
>  /*

I really don't want to bikeshed, especially as some tracepoints are
better than no tracepoints, but...

We now trace fctl/schid/ret_code unconditionally (good).

We trace the outcome of cp_prefetch() and fsm_io_helper()
unconditionally. We don't, however, trace all things that may go wrong.
We have the tracepoint at the end, but it cannot tell us where the
error came from. Should we have tracepoints in every place (in this
function) that may generate an error? Only if there is an actual error?
Are the two enough for common debug scenarios?

Opinions? We can just go ahead with this and improve things later on, I
guess.
