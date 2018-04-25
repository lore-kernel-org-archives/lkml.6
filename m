Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeDYOAV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:00:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753509AbeDYOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:00:18 -0400
Subject: Re: [PATCH 10/10] vfio: ccw: Let user wait when busy on IO
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-11-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180425104841.758a314d.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 25 Apr 2018 16:00:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425104841.758a314d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18042514-0020-0000-0000-00000415AE72
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042514-0021-0000-0000-000042AA1B00
Message-Id: <d20bbfac-f97b-c1f5-3b1d-3bf66502e93b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2018 10:48, Cornelia Huck wrote:
> On Thu, 19 Apr 2018 16:48:13 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> In the current implementation, we do not want to start a new SSCH
>> command before the last one ends.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_fsm.c     |  3 +++
>>   drivers/s390/cio/vfio_ccw_ops.c     | 21 ++++++++++++++++++++-
>>   drivers/s390/cio/vfio_ccw_private.h |  4 +++-
>>   3 files changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
>> index b77b8ad..4140292 100644
>> --- a/drivers/s390/cio/vfio_ccw_fsm.c
>> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
>> @@ -195,6 +195,9 @@ static int fsm_irq(struct vfio_ccw_private *private)
>>   	if (private->io_trigger)
>>   		eventfd_signal(private->io_trigger, 1);
>>   
>> +	if (private->io_completion)
>> +		complete(private->io_completion);
>> +
>>   	return VFIO_CCW_STATE_IDLE;
>>   }
>>   
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index f0f4071..346532d 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -171,6 +171,8 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>>   	struct vfio_ccw_private *private;
>>   	struct ccw_io_region *region;
>>   	union scsw *scsw;
>> +	int max_retries = 5;
>> +	DECLARE_COMPLETION_ONSTACK(completion);
>>   
>>   	if (*ppos + count > sizeof(*region))
>>   		return -EINVAL;
>> @@ -185,7 +187,24 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>>   	if ((scsw->cmd.fctl & SCSW_FCTL_START_FUNC) != SCSW_FCTL_START_FUNC)
>>   		return -EINVAL;
>>   
>> -	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SSCH_REQ);
>> +	do {
>> +		switch (private->state) {
>> +		case VFIO_CCW_STATE_BUSY:
>> +			private->io_completion = &completion;
>> +			wait_for_completion(&completion);
>> +			break;
>> +		case VFIO_CCW_STATE_IDLE:
>> +			if (!vfio_ccw_fsm_event(private,
>> +						VFIO_CCW_EVENT_SSCH_REQ))
>> +				return count;
>> +			break;
>> +		default:
>> +			return -EBUSY;
>> +		}
>> +	} while (max_retries--);
> I really don't think we want to go there. If we are busy, generate an
> indication to that respect, but don't retry. My preferred approach
> would be to keep the "we're busy" times as small as possible and let
> the host channel subsystem handle any further races. We can't make that
> bulletproof anyway, so no reason to make life more difficult for us.

OK, clear.

Thanks

Pierre

>
>> +
>> +	if (max_retries <= 0)
>> +		return -EBUSY;
>>   	if (region->ret_code != 0)
>>   		return region->ret_code;
>>   
>> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
>> index dbef727..7cca078 100644
>> --- a/drivers/s390/cio/vfio_ccw_private.h
>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>> @@ -39,6 +39,7 @@ struct vfio_ccw_private {
>>   	struct subchannel	*sch;
>>   	int			state;
>>   	struct completion	*completion;
>> +	struct completion	*io_completion;
>>   	atomic_t		avail;
>>   	struct mdev_device	*mdev;
>>   	struct notifier_block	nb;
>> @@ -93,12 +94,13 @@ enum vfio_ccw_event {
>>   typedef int (fsm_func_t)(struct vfio_ccw_private *);
>>   extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
>>   
>> -static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
>> +static inline int vfio_ccw_fsm_event(struct vfio_ccw_private *private,
>>   				     int event)
>>   {
>>   	mutex_lock(&private->state_mutex);
>>   	private->state = vfio_ccw_jumptable[private->state][event](private);
>>   	mutex_unlock(&private->state_mutex);
>> +	return private->io_region.ret_code;
>>   }
>>   
>>   extern struct workqueue_struct *vfio_ccw_work_q;


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
