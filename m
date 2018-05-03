Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeECKfb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:35:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751847AbeECKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:35:29 -0400
Subject: Re: [PATCH 05/10] vfio: ccw: Suppress unused event parameter
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-6-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180426073618.GA12194@bjsdjshi@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 12:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426073618.GA12194@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050310-0040-0000-0000-0000045481E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050310-0041-0000-0000-000020F8A792
Message-Id: <24fb88a3-450c-01d3-c00a-2b4bcbe10ca6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2018 09:36, Dong Jia Shi wrote:
> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:08 +0200]:
>
>> The fsm_func_t function type definition does not need the event
>> parameter since all functions are in a state/event table.
> Not sure if this will still be right after you addressed all of the
> comments on this version. But no hurt to point out some nits that I
> noticed below.
>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 34 +++++++++++-----------------------
>>   drivers/s390/cio/vfio_ccw_private.h |  5 ++---
>>   2 files changed, 13 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
>> index f9855cd..f8ded70 100644
>> --- a/drivers/s390/cio/vfio_ccw_fsm.c
>> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
>> @@ -55,8 +55,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>>   	}
>>   }
>>
>> -static int fsm_notoper(struct vfio_ccw_private *private,
>> -			enum vfio_ccw_event event)
>> +static int fsm_notoper(struct vfio_ccw_private *private)
>>   {
>>   	struct subchannel *sch = private->sch;
>>
>> @@ -65,36 +64,31 @@ static int fsm_notoper(struct vfio_ccw_private *private,
>>   	 * Probably we should send the machine check to the guest.
>>   	 */
>>   	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>> -	private->state = VFIO_CCW_STATE_NOT_OPER;
>> -	return private->state;
>> +	return VFIO_CCW_STATE_NOT_OPER;
> This change should belong to a former patch.
>
> [...]
>
>> @@ -109,17 +103,14 @@ static int fsm_disabled_irq(struct vfio_ccw_private *private,
>>   /*
>>    * Deal with the ccw command request from the userspace.
>>    */
>> -static int fsm_io_request(struct vfio_ccw_private *private,
>> -			   enum vfio_ccw_event event)
>> +static int fsm_io_request(struct vfio_ccw_private *private)
>>   {
>> -	union orb *orb;
>>   	struct ccw_io_region *io_region = &private->io_region;
>> +	union orb *orb = (union orb *)io_region->orb_area;
>>   	struct mdev_device *mdev = private->mdev;
>>
>>   	private->state = VFIO_CCW_STATE_BOXED;
>>
>> -	orb = (union orb *)io_region->orb_area;
>> -
> Irrelevant change for this patch.
>
>>   	io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev), orb);
>>   	if (io_region->ret_code)
>>   		goto err_out;
>> @@ -139,15 +130,13 @@ static int fsm_io_request(struct vfio_ccw_private *private,
>>   	return VFIO_CCW_STATE_BUSY;
>>
>>   err_out:
>> -	private->state = VFIO_CCW_STATE_IDLE;
>> -	return private->state;
>> +	return VFIO_CCW_STATE_IDLE;
> Should move to other patch.
>
> [...]
>
OK, I will move these changes in patch 4/10.

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
