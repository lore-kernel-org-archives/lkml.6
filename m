Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeDYIlr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:41:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751271AbeDYIll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:41:41 -0400
Date: Wed, 25 Apr 2018 10:41:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 04/10] vfio: ccw: replace IO_REQ event with SSCH_REQ
 event
Message-ID: <20180425104138.1337aff5.cohuck@redhat.com>
In-Reply-To: <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 16:48:07 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> This patch simplifies the IO request handling to handle the only
> implemented request: SSCH.

I *really* need to post my halt/clear patches soon, I think.

> Other request are invalid and get a return value of -EINVAL.

This is an user api change: We got -EOPNOTSUPP in the region's return
code before.

> 
> This patch change the event name to VFIO_CCW_EVENT_SSCH_REQ to reflect
> what is done and prepare for future implementation of other requests.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c     | 63 +++++++++++++------------------------
>  drivers/s390/cio/vfio_ccw_ops.c     |  9 ++++--
>  drivers/s390/cio/vfio_ccw_private.h |  2 +-
>  3 files changed, 29 insertions(+), 45 deletions(-)

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 41eeb57..4da7b61 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -188,19 +188,22 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>  {
>  	struct vfio_ccw_private *private;
>  	struct ccw_io_region *region;
> +	union scsw *scsw;
>  
>  	if (*ppos + count > sizeof(*region))
>  		return -EINVAL;
>  
>  	private = dev_get_drvdata(mdev_parent_dev(mdev));
> -	if (private->state != VFIO_CCW_STATE_IDLE)
> -		return -EACCES;
>  
>  	region = &private->io_region;
>  	if (copy_from_user((void *)region + *ppos, buf, count))
>  		return -EFAULT;
>  
> -	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
> +	scsw = (union scsw *) &region->scsw_area;
> +	if ((scsw->cmd.fctl & SCSW_FCTL_START_FUNC) != SCSW_FCTL_START_FUNC)

You should not allow the halt/clear functions to be specified, if you
go that route. The precedence order needs to be clear -> halt -> start.

> +		return -EINVAL;

As said, that's a user api change. Previously, user space could detect
whether halt/clear are supported or not by simply specifying the
halt/clear function and checking for -EOPNOTSUPP in the region's return
code. Now they get -EINVAL (which I think is not a good return code,
even if we did not have the api breakage).

> +
> +	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SSCH_REQ);
>  	if (region->ret_code != 0) {
>  		private->state = VFIO_CCW_STATE_IDLE;
>  		return region->ret_code;
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 3284e64..93aab87 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -76,7 +76,7 @@ enum vfio_ccw_state {
>   */
>  enum vfio_ccw_event {
>  	VFIO_CCW_EVENT_NOT_OPER,
> -	VFIO_CCW_EVENT_IO_REQ,
> +	VFIO_CCW_EVENT_SSCH_REQ,
>  	VFIO_CCW_EVENT_INTERRUPT,
>  	VFIO_CCW_EVENT_SCH_EVENT,
>  	/* last element! */

I don't think we should separate the ssch handling. The major
difference to halt/clear is that it needs channel program translation.
Everything else (issuing the instruction and processing the interrupt)
are basically the same. If we just throw everything at the hardware and
let the host's channel subsystem figure it out, we already should be
fine with regard to most of the races.
