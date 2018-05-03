Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeECKbv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:31:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751776AbeECKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:31:48 -0400
Subject: Re: [PATCH 07/10] vfio: ccw: Introduce the INIT event
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-8-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180430173910.31f13a3a.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 12:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430173910.31f13a3a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050310-0040-0000-0000-00000454819B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050310-0041-0000-0000-000020F8A743
Message-Id: <70fdc9d5-2cdb-3721-8c9b-5d5fead72739@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030098
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2018 17:39, Cornelia Huck wrote:
> On Thu, 19 Apr 2018 16:48:10 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> The VFIO_CCW_EVENT_INIT event allows to export the initial state
>> into the FSM.
> I don't know, that feels a bit unintuitive to me. I would naively
> expect initialization to be done _before_ we activate processing via
> the state machine.
>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 26 +++++++++++---------------
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 21 +++++++++++++++++++++
>>   drivers/s390/cio/vfio_ccw_ops.c     | 11 -----------
>>   drivers/s390/cio/vfio_ccw_private.h |  1 +
>>   4 files changed, 33 insertions(+), 26 deletions(-)
>>   /*
>>    * Device statemachine
>>    */
>>   fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>>   	[VFIO_CCW_STATE_NOT_OPER] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_init,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
>>   		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_nop,
>>   	},
>>   	[VFIO_CCW_STATE_STANDBY] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>>   		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>>   	},
>>   	[VFIO_CCW_STATE_IDLE] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_request,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>>   		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>>   	},
>>   	[VFIO_CCW_STATE_BOXED] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>>   		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>>   	},
>>   	[VFIO_CCW_STATE_BUSY] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> ...especially as you only call it if in the NOT_OPER state. Why should
> this event be generated in any case but in the very beginning?
>
It is the only way to go out of the NOT_OPER state.

The idea is to introduce recoverycode in a later version.

However, no problem to suppress this state until we get there so I will 
remove it in V2.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
