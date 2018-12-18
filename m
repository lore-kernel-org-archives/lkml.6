Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C61C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC6521873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeLRRoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:44:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbeLRRoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:44:34 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBIHiUFh061539
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 12:44:32 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pf3bqx9sf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 12:44:30 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <farman@linux.ibm.com>;
        Tue, 18 Dec 2018 17:44:23 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 17:44:20 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBIHiJ3j30015682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 17:44:19 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A0246A057;
        Tue, 18 Dec 2018 17:44:19 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6153A6A04D;
        Tue, 18 Dec 2018 17:44:18 +0000 (GMT)
Received: from [9.60.84.101] (unknown [9.60.84.101])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 18 Dec 2018 17:44:18 +0000 (GMT)
Subject: Re: [PATCH v3 2/6] vfio: ccw: Rework subchannel state on setup
To:     Pierre Morel <pmorel@linux.ibm.com>, pasic@linux.vnet.ibm.com
Cc:     cohuck@redhat.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
 <1543408867-16465-3-git-send-email-pmorel@linux.ibm.com>
From:   Eric Farman <farman@linux.ibm.com>
Date:   Tue, 18 Dec 2018 12:44:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543408867-16465-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121817-0036-0000-0000-00000A6C4946
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010244; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01133604; UDB=6.00589329; IPR=6.00913778;
 MB=3.00024739; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-18 17:44:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121817-0037-0000-0000-00004A070192
Message-Id: <ccead686-3c35-9a4a-3d9e-b88fd7170205@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My questions to this patch from the original RFC series are still 
outstanding.  :(

https://marc.info/?l=linux-s390&m=154223063716128&w=2

On 11/28/2018 07:41 AM, Pierre Morel wrote:
> The subchannel enablement and the according setting to the
> VFIO_CCW_STATE_STANDBY state should only be done when all
> parts of the VFIO mediated device have been initialized
> i.e. after the mediated device has been successfully opened.
> 
> Let's stay in VFIO_CCW_STATE_NOT_OPER until the mediated
> device has been opened and set the VFIO_CCW_STATE_STANDBY
> on a successful open.
> 
> On release the state is set back to VFIO_CCW_STATE_NOT_OPER
> by vfio_ccw_sch_quiesce().
> 
> When the mediated device is closed,  disable the sub channel
> by calling vfio_ccw_sch_quiesce().
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_async.c   | 11 +++++++++++

Ah, this series is built on Connie's async changes.  Okay.  [1]

>   drivers/s390/cio/vfio_ccw_drv.c     | 10 +---------
>   drivers/s390/cio/vfio_ccw_ops.c     | 27 +++++++++++++++++++++------
>   drivers/s390/cio/vfio_ccw_private.h |  1 +
>   4 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> index 8c7f51d..033574e 100644
> --- a/drivers/s390/cio/vfio_ccw_async.c
> +++ b/drivers/s390/cio/vfio_ccw_async.c
> @@ -76,6 +76,17 @@ const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
>   	.release = vfio_ccw_async_region_release,
>   };
>   
> +void vfio_ccw_unregister_async_dev_regions(struct vfio_ccw_private *private)
> +{
> +	int i;
> +
> +	for (i = 0; i < private->num_regions; i++)
> +		private->region[i].ops->release(private, &private->region[i]);
> +	private->num_regions = 0;
> +	kfree(private->region);
> +	private->region = NULL;
> +} > +
>   int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private)
>   {
>   	return vfio_ccw_register_dev_region(private,
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index bce7fed..d3527b6 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -133,26 +133,18 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>   	private->sch = sch;
>   	dev_set_drvdata(&sch->dev, private);
>   
> -	spin_lock_irq(sch->lock);
>   	private->state = VFIO_CCW_STATE_NOT_OPER;
>   	sch->isc = VFIO_CCW_ISC;
> -	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
> -	spin_unlock_irq(sch->lock);
> -	if (ret)
> -		goto out_free;
>   
>   	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>   	atomic_set(&private->avail, 1);
> -	private->state = VFIO_CCW_STATE_STANDBY;
>   
>   	ret = vfio_ccw_mdev_reg(sch);
>   	if (ret)
> -		goto out_disable;
> +		goto out_free;
>   
>   	return 0;
>   
> -out_disable:
> -	cio_disable_subchannel(sch);
>   out_free:
>   	dev_set_drvdata(&sch->dev, NULL);
>   	if (private->cmd_region)
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 0e1f7f7b..cc7d46a 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -113,14 +113,11 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   	struct vfio_ccw_private *private =
>   		dev_get_drvdata(mdev_parent_dev(mdev));
>   
> -	if (private->state == VFIO_CCW_STATE_NOT_OPER)
> -		return -ENODEV;
> -
>   	if (atomic_dec_if_positive(&private->avail) < 0)
>   		return -EPERM;
>   
>   	private->mdev = mdev;
> -	private->state = VFIO_CCW_STATE_IDLE;
> +	private->state = VFIO_CCW_STATE_NOT_OPER;
>   
>   	return 0;
>   }
> @@ -148,6 +145,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
>   	struct vfio_ccw_private *private =
>   		dev_get_drvdata(mdev_parent_dev(mdev));
>   	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
> +	struct subchannel *sch = private->sch;
>   	int ret;
>   
>   	private->nb.notifier_call = vfio_ccw_mdev_notifier;
> @@ -159,8 +157,24 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
>   
>   	ret = vfio_ccw_register_async_dev_regions(private);
>   	if (ret)
> -		vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> -					 &private->nb);
> +		goto err_regions;
> +
> +	spin_lock_irq(private->sch->lock);
> +	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
> +	if (ret)
> +		goto err_enable;
> +
> +	private->state = VFIO_CCW_STATE_STANDBY;
> +	spin_unlock_irq(sch->lock);
> +	return 0;
> +
> +err_enable:
> +	spin_unlock_irq(sch->lock);
> +	vfio_ccw_unregister_async_dev_regions(private);
> +
> +err_regions:
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				 &private->nb);
>   	return ret;
>   }
>   
> @@ -170,6 +184,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
>   		dev_get_drvdata(mdev_parent_dev(mdev));
>   	int i;
>   
> +	vfio_ccw_sch_quiesce(private->sch);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>   				 &private->nb);

[1] If Connie's async patches go in first, then the stuff in your 
"vfio_ccw_unregister_async_dev_regions" is also added here.  That could 
be removed and replaced with a call to your new function, yes?

>   
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 1a41a14..5d799b7 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -54,6 +54,7 @@ int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
>   				 size_t size, u32 flags, void *data);
>   
>   int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private);
> +void vfio_ccw_unregister_async_dev_regions(struct vfio_ccw_private *private);
>   
>   /**
>    * struct vfio_ccw_private
> 

