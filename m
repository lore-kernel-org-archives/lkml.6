Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEDIZ7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:25:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751598AbeEDIZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:25:53 -0400
Subject: Re: [PATCH 03/10] vfio: ccw: new SCH_EVENT event
To: Cornelia Huck <cohuck@redhat.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180426065954.GP5428@bjsdjshi@linux.vnet.ibm.com>
 <20180430172851.2cb3d550.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 4 May 2018 10:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430172851.2cb3d550.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050408-0008-0000-0000-000004F2E30F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050408-0009-0000-0000-00001E870ED6
Message-Id: <eab19daf-adfb-fa71-d7d6-79439c6763a7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2018 17:28, Cornelia Huck wrote:
> On Thu, 26 Apr 2018 14:59:54 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>
>> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:06 +0200]:
>>
>>> The Sub channel event callback is threaded using workqueues.
>>> The work uses the FSM introducing the VFIO_CCW_EVENT_SCH_EVENT
>>> event.
>>> The update of the SCHIB is now done inside the FSM function.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> ---
>>>   drivers/s390/cio/vfio_ccw_drv.c     | 33 +++++++++++++--------------------
>>>   drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
>>>   drivers/s390/cio/vfio_ccw_private.h |  3 +++
>>>   3 files changed, 39 insertions(+), 20 deletions(-)
>>>
>>> @@ -171,28 +181,11 @@ static void vfio_ccw_sch_shutdown(struct subchannel *sch)
>>>   static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>>>   {
>>>   	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
>>> -	unsigned long flags;
>>>
>>> -	spin_lock_irqsave(sch->lock, flags);
>>>   	if (!device_is_registered(&sch->dev))
>>> -		goto out_unlock;
>>> -
>>> -	if (work_pending(&sch->todo_work))
>>> -		goto out_unlock;
>> Just realized that this has a bug in the orignal implementation. For
>> error out this should return -EAGAIN. We'd need a separated fix on
>> this.
> Indeed. Will you send a patch, or should I hack something up?
>
>>> -
>>> -	if (cio_update_schib(sch)) {
>>> -		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
>>> -		goto out_unlock;
>>> -	}
>>> -
>>> -	private = dev_get_drvdata(&sch->dev);
>>> -	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
>>> -		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
>>> -				 VFIO_CCW_STATE_STANDBY;
>>> -	}
>> This hunk was toatally removed, and this is fine because?
The first part is moved to fsm_sch_event()
The second part disapear per design as state changes are done inside the 
FSM.

>>
>>> -
>>> -out_unlock:
>>> -	spin_unlock_irqrestore(sch->lock, flags);
>>> +		return -1;
>> -1 is not a valid code.
> -ENODEV looks more fitting, if we decide to go with this rework.
:) yes, forgot the -1 from the first tests.

>
>>> +	WARN_ON(work_pending(&private->event_work));
>>> +	queue_work(vfio_ccw_work_q, &private->event_work);
>>>
>>>   	return 0;
>>>   }
> I'm wondering why this should always be done via a workqueue. It seems
> the other subchannel types try to do as much as possible immediately?

Doing things inside the top half is not very friendly with the system.
The goal of the patch is to build a clean atomic state machine.
Allowing the use of mutexes insures atomicity.

I notice that I forgot to point this out in the cover letter although it is
one of the design key.
I will update the cover letter.

> (And returning -EAGAIN already triggers the css code to schedule
> another call later.)

Yes, if(work_pending()) return -EAGAIN

Thanks for the review

Pierre

>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
