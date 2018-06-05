Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeFENKo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:10:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751732AbeFENKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:10:42 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 06/10] vfio: ccw: Make FSM functions atomic
To: Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1527243678-3140-7-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180605133850.3509a3d3.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 5 Jun 2018 15:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605133850.3509a3d3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060513-0008-0000-0000-000002445EFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060513-0009-0000-0000-000021AA644D
Message-Id: <46613ac7-3156-7a78-7d49-acbc3f615b76@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050151
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2018 13:38, Cornelia Huck wrote:
> On Fri, 25 May 2018 12:21:14 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> We use mutex around the FSM function call to make the FSM
>> event handling and state change atomic.
> I'm still not really clear as to what this mutex is supposed to
> serialize:
>
> - Modification of the state?
> - Any calls in the state machine?
> - A combination? (That would imply that we only deal with the state in
>    the state machine.)

yes to all

>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 3 +--
>>   drivers/s390/cio/vfio_ccw_private.h | 3 +++
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
>> index 6b7112e..98951d5 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -73,8 +73,6 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>>   
>>   	private = container_of(work, struct vfio_ccw_private, io_work);
>>   	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
>> -	if (private->mdev)
>> -		private->state = VFIO_CCW_STATE_IDLE;
> Looks like an unrelated change? If you want to do all state changes
> under the mutex, that should rather be moved than deleted, shouldn't it?

It is moved to fsm_irq() which is called under mutex.
fsm_irq() returns VFIO_CCW_STATE_IDLE.

>
>>   }
>>   
>>   static void vfio_ccw_sch_event_todo(struct work_struct *work)


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
