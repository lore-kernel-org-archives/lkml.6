Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756132AbeDXIW0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:22:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755887AbeDXIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:22:23 -0400
Subject: Re: [PATCH 02/10] vfio: ccw: Transform FSM functions to return state
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-3-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180424072550.GW12194@bjsdjshi@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 10:22:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424072550.GW12194@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18042408-0012-0000-0000-000005CE1B20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042408-0013-0000-0000-0000194A896B
Message-Id: <047dd088-6cba-c1fa-2295-05d31d7f4f2d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240083
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2018 09:25, Dong Jia Shi wrote:
> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:05 +0200]:
>
>> We change the FSM functions to return the next state,
>> and adapt the fsm_func_t function type.
> I think I'd need to read the rest patches to understand why we need this
> one, but no hurt to write some ideas that I noticed at my first glance.
> See below please.
>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 24 ++++++++++++++++--------
>>   drivers/s390/cio/vfio_ccw_private.h |  5 +++--
>>   2 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
>> index af88551..2f3108d 100644
>> --- a/drivers/s390/cio/vfio_ccw_fsm.c
>> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
>> @@ -60,7 +60,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>>   	}
>>   }
>>
>> -static void fsm_notoper(struct vfio_ccw_private *private,
>> +static int fsm_notoper(struct vfio_ccw_private *private,
>>   			enum vfio_ccw_event event)
>>   {
>>   	struct subchannel *sch = private->sch;
>> @@ -71,30 +71,34 @@ static void fsm_notoper(struct vfio_ccw_private *private,
>>   	 */
>>   	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>>   	private->state = VFIO_CCW_STATE_NOT_OPER;
> Here..
>
>> +	return private->state;
>>   }
>>
>>   /*
>>    * No operation action.
>>    */
>> -static void fsm_nop(struct vfio_ccw_private *private,
>> +static int fsm_nop(struct vfio_ccw_private *private,
>>   		    enum vfio_ccw_event event)
>>   {
>> +	return private->state;
>>   }
>>
>> -static void fsm_io_error(struct vfio_ccw_private *private,
>> +static int fsm_io_error(struct vfio_ccw_private *private,
>>   			 enum vfio_ccw_event event)
>>   {
>>   	pr_err("vfio-ccw: FSM: I/O request from state:%d\n", private->state);
>>   	private->io_region.ret_code = -EIO;
>> +	return private->state;
>>   }
>>
>> -static void fsm_io_busy(struct vfio_ccw_private *private,
>> +static int fsm_io_busy(struct vfio_ccw_private *private,
>>   			enum vfio_ccw_event event)
>>   {
>>   	private->io_region.ret_code = -EBUSY;
>> +	return private->state;
>>   }
>>
>> -static void fsm_disabled_irq(struct vfio_ccw_private *private,
>> +static int fsm_disabled_irq(struct vfio_ccw_private *private,
>>   			     enum vfio_ccw_event event)
>>   {
>>   	struct subchannel *sch = private->sch;
>> @@ -104,12 +108,13 @@ static void fsm_disabled_irq(struct vfio_ccw_private *private,
>>   	 * successful - should not happen, but we try to disable again.
>>   	 */
>>   	cio_disable_subchannel(sch);
>> +	return private->state;
>>   }
>>
>>   /*
>>    * Deal with the ccw command request from the userspace.
>>    */
>> -static void fsm_io_request(struct vfio_ccw_private *private,
>> +static int fsm_io_request(struct vfio_ccw_private *private,
>>   			   enum vfio_ccw_event event)
>>   {
>>   	union orb *orb;
>> @@ -141,7 +146,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>   			cp_free(&private->cp);
>>   			goto err_out;
>>   		}
>> -		return;
>> +		return private->state;
>>   	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
>>   		/* XXX: Handle halt. */
>>   		io_region->ret_code = -EOPNOTSUPP;
>> @@ -154,12 +159,13 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>
>>   err_out:
>>   	private->state = VFIO_CCW_STATE_IDLE;
> Here..
>
>> +	return private->state;
>>   }
>>
>>   /*
>>    * Got an interrupt for a normal io (state busy).
>>    */
>> -static void fsm_irq(struct vfio_ccw_private *private,
>> +static int fsm_irq(struct vfio_ccw_private *private,
>>   		    enum vfio_ccw_event event)
>>   {
>>   	struct irb *irb = &private->irb;
>> @@ -172,6 +178,8 @@ static void fsm_irq(struct vfio_ccw_private *private,
>>
>>   	if (private->io_trigger)
>>   		eventfd_signal(private->io_trigger, 1);
>> +
>> +	return private->state;
>>   }
>>
>>   /*
>> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
>> index 78a66d9..f526b18 100644
>> --- a/drivers/s390/cio/vfio_ccw_private.h
>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>> @@ -83,13 +83,14 @@ enum vfio_ccw_event {
>>   /*
>>    * Action called through jumptable.
>>    */
>> -typedef void (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
>> +typedef int (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
>>   extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
>>
>>   static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
>>   				     int event)
>>   {
>> -	vfio_ccw_jumptable[private->state][event](private, event);
>> +	private->state = vfio_ccw_jumptable[private->state][event](private,
>> +								   event);
> Since here it assigns new value to private->state, there is no need to
> do that inside each fsm_func?
Absolutely.
I just kept the previous code, just adding the return private->state in 
the functions
in this patch.
merging the state and the return value is done in a later patch.
If you prefer I can do it in this patch.

>
>>   }
>>
>>   extern struct workqueue_struct *vfio_ccw_work_q;
>> -- 
>> 2.7.4
>>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
