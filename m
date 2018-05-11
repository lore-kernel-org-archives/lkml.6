Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeEKJdq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:33:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752476AbeEKJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:33:44 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
To: Cornelia Huck <cohuck@redhat.com>,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-3-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 11 May 2018 11:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509154822.23510-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051109-0044-0000-0000-000005517AA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051109-0045-0000-0000-00002892CB0F
Message-Id: <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110092
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 17:48, Cornelia Huck wrote:
> Currently, vfio-ccw only relays start subchannel requests to the real
> hardware, which is enough in many cases but falls short e.g. during
> error recovery.
>
> Fortunately, it is easy to add support for halt and clear subchannel
> requests to the existing infrastructure. User space can detect
> support for halt/clear subchannel easily, as we always returned
> -EOPNOTSUPP before and therefore we do not need any capability to
> make this support discoverable.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_drv.c | 10 ++++-
>   drivers/s390/cio/vfio_ccw_fsm.c | 94 ++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 92 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index ea6a2d0b2894..6212d577117f 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -76,8 +76,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>   	irb = &private->irb;
>   
>   	if (scsw_is_solicited(&irb->scsw)) {
> -		cp_update_scsw(&private->cp, &irb->scsw);
> -		cp_free(&private->cp);
> +		/*
> +		 * For the start function, we need to update based on the
> +		 * channel program. Nothing needs to be done for halt/clear.
> +		 */
> +		if (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC) {
> +			cp_update_scsw(&private->cp, &irb->scsw);
> +			cp_free(&private->cp);
> +		}
>   	}
>   	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
>   
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index 3c800642134e..94cae2984c35 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -3,8 +3,10 @@
>    * Finite state machine for vfio-ccw device handling
>    *
>    * Copyright IBM Corp. 2017
> + * Copyright Red Hat, Inc. 2018
>    *
>    * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> + *            Cornelia Huck <cohuck@redhat.com>
>    */
>   
>   #include <linux/vfio.h>
> @@ -65,6 +67,70 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>   	return ret;
>   }
>   
> +static int fsm_halt_helper(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch;
> +	int ccode;
> +	unsigned long flags;
> +	int ret;
> +
> +	sch = private->sch;
> +
> +	spin_lock_irqsave(sch->lock, flags);
> +	private->state = VFIO_CCW_STATE_BUSY;
> +
> +	/* Issue "Halt Subchannel" */
> +	ccode = hsch(sch->schid);
> +
> +	switch (ccode) {
> +	case 0:
> +		/*
> +		 * Initialize device status information
> +		 */
> +		sch->schib.scsw.cmd.actl |= SCSW_ACTL_HALT_PEND;
> +		ret = 0;
> +		break;
> +	case 1:		/* Status pending */

shouldn't we make a difference between status pending
and having halt in progress?

The guest can examine the SCSW, but couldn't it introduce
a race condition?


> +	case 2:		/* Busy */
> +		ret = -EBUSY;
> +		break;
> +	default:	/* Device not operational */
> +		ret = -ENODEV;
> +	}
> +	spin_unlock_irqrestore(sch->lock, flags);
> +	return ret;
> +}
> +
> +static int fsm_clear_helper(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch;
> +	int ccode;
> +	unsigned long flags;
> +	int ret;
> +
> +	sch = private->sch;
> +
> +	spin_lock_irqsave(sch->lock, flags);
> +	private->state = VFIO_CCW_STATE_BUSY;
> +
> +	/* Issue "Clear Subchannel" */
> +	ccode = csch(sch->schid);
> +
> +	switch (ccode) {
> +	case 0:
> +		/*
> +		 * Initialize device status information
> +		 */
> +		sch->schib.scsw.cmd.actl |= SCSW_ACTL_CLEAR_PEND;
> +		ret = 0;
> +		break;
> +	default:	/* Device not operational */
> +		ret = -ENODEV;
> +	}
> +	spin_unlock_irqrestore(sch->lock, flags);
> +	return ret;
> +}
> +
>   static void fsm_notoper(struct vfio_ccw_private *private,
>   			enum vfio_ccw_event event)
>   {
> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>   
>   	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>   
> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> +	/*
> +	 * Start processing with the clear function, then halt, then start.
> +	 * We may still be start pending when the caller wants to clean
> +	 * up things via halt/clear.
> +	 */

hum. The scsw here does not reflect the hardware state but the
command passed from the user interface.
Can we and should we authorize multiple commands in one call?

If not, the comment is not appropriate and a switch on cmd.fctl
would be a clearer.

> +	if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> +		/* issue clear and wait for interupt */
> +		io_region->ret_code = fsm_clear_helper(private);
> +		if (io_region->ret_code)
> +			goto err_out;
> +		return;
> +	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> +		/* issue halt and wait for interrupt */
> +		io_region->ret_code = fsm_halt_helper(private);
> +		if (io_region->ret_code)
> +			goto err_out;
> +		return;
> +	} else if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>   		orb = (union orb *)io_region->orb_area;
>   
>   		/* Don't try to build a cp if transport mode is specified. */
> @@ -152,16 +235,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>   			goto err_out;
>   		}
>   		return;
> -	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> -		/* XXX: Handle halt. */
> -		io_region->ret_code = -EOPNOTSUPP;
> -		goto err_out;
> -	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> -		/* XXX: Handle clear. */
> -		io_region->ret_code = -EOPNOTSUPP;
> -		goto err_out;
>   	}
> -
>   err_out:
>   	private->state = VFIO_CCW_STATE_IDLE;
>   }


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
