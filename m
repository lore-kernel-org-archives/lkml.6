Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeDSOlE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:41:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752958AbeDSOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:40:58 -0400
Subject: Re: [PATCH] vfio-ccw: process ssch with interrupts disabled
To: Cornelia Huck <cohuck@redhat.com>,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180413140509.9042-1-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 19 Apr 2018 16:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413140509.9042-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041914-0012-0000-0000-000005CCAA13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041914-0013-0000-0000-00001949029F
Message-Id: <b52e3aac-208c-8d55-cc77-2534a375fda5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190129
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2018 16:05, Cornelia Huck wrote:
> When we call ssch, an interrupt might already be pending once we
> return from the START SUBCHANNEL instruction. Therefore we need to
> make sure interrupts are disabled until after we're done with our
> processing.
>
> Note that the subchannel lock is the same as the ccwdevice lock that
> is mentioned in the documentation for ccw_device_start() and friends.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_fsm.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index ff6963ad6e39..3c800642134e 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -20,12 +20,12 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>   	int ccode;
>   	__u8 lpm;
>   	unsigned long flags;
> +	int ret;
>
>   	sch = private->sch;
>
>   	spin_lock_irqsave(sch->lock, flags);
>   	private->state = VFIO_CCW_STATE_BUSY;
> -	spin_unlock_irqrestore(sch->lock, flags);
>
>   	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
>
> @@ -38,10 +38,12 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>   		 * Initialize device status information
>   		 */
>   		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
> -		return 0;
> +		ret = 0;
> +		break;
>   	case 1:		/* Status pending */
>   	case 2:		/* Busy */
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		break;
>   	case 3:		/* Device/path not operational */
>   	{
>   		lpm = orb->cmd.lpm;
> @@ -51,13 +53,16 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>   			sch->lpm = 0;
>
>   		if (cio_update_schib(sch))
> -			return -ENODEV;
> -
> -		return sch->lpm ? -EACCES : -ENODEV;
> +			ret = -ENODEV;
> +		else
> +			ret = sch->lpm ? -EACCES : -ENODEV;
> +		break;
>   	}
>   	default:
> -		return ccode;
> +		ret = ccode;
>   	}
> +	spin_unlock_irqrestore(sch->lock, flags);
> +	return ret;
>   }
>
>   static void fsm_notoper(struct vfio_ccw_private *private,


I have been working on a patch to solve this problem between others, I 
provide it soon.
It is much more intrusive, reworking interrupts and state machine.
So may be you do not like it.


If we stay on this patch, even this is quite a long spinlock around ssch 
and stsch,
and we need it in the current implementation.

Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
