Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeEWHuL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:50:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754082AbeEWHuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:50:09 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 04/10] vfio: ccw: replace IO_REQ event with SSCH_REQ event
To: Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180426073053.GZ12194@bjsdjshi@linux.vnet.ibm.com>
 <20180426074806.GB12194@bjsdjshi@linux.vnet.ibm.com>
 <20180430173305.632faa80.cohuck@redhat.com>
 <20180502074622.GV5428@bjsdjshi@linux.vnet.ibm.com>
 <5816643d-5406-06b9-0727-fdcd771aba63@linux.vnet.ibm.com>
 <20180504011916.GA26081@bjsdjshi@linux.ibm.com>
 <8c75acd1-c00b-4d7f-ea4b-d32e9b05989b@linux.vnet.ibm.com>
 <20180522174120.2a56adb7.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 23 May 2018 09:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522174120.2a56adb7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18052307-0040-0000-0000-0000043CE3AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052307-0041-0000-0000-000026421AA4
Message-Id: <86a4be7f-6c4c-19db-f743-ed4af0173125@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230077
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2018 17:41, Cornelia Huck wrote:
> On Fri, 4 May 2018 13:02:36 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 04/05/2018 03:19, Dong Jia Shi wrote:
>>> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-05-03 16:26:29 +0200]:
>>>   
>>>> On 02/05/2018 09:46, Dong Jia Shi wrote:
>>>>> * Cornelia Huck <cohuck@redhat.com> [2018-04-30 17:33:05 +0200]:
>>>>>   
>>>>>> On Thu, 26 Apr 2018 15:48:06 +0800
>>>>>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>>>>>   
>>>>>>> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2018-04-26 15:30:54 +0800]:
>>>>>>>
>>>>>>> [...]
>>>>>>>   
>>>>>>>>> @@ -179,7 +160,7 @@ static int fsm_irq(struct vfio_ccw_private *private,
>>>>>>>>>    	if (private->io_trigger)
>>>>>>>>>    		eventfd_signal(private->io_trigger, 1);
>>>>>>>>>
>>>>>>>>> -	return private->state;
>>>>>>>>> +	return VFIO_CCW_STATE_IDLE;
>>>>>>>> This is not right. For example, if we are in STANDBY state (subch driver
>>>>>>>> is probed, but mdev device is not created), we can not jump to IDLE
>>>>>>>> state.
>>>>>>> I see my problem, for STANDBY state, we should introduce another event
>>>>>>> callback for VFIO_CCW_EVENT_INTERRUPT. It doesn't make sense to call
>>>>>>> fsm_irq() which tries to signal userspace with interrupt notification
>>>>>>> when mdev is not created yet... So we'd need a separated fix for this
>>>>>>> issue too.
>>>>>> But how do we even get into that situation when we don't have an mdev
>>>>>> yet?
>>>>>>   
>>>>> We cann't... So let's assign fsm_nop() as the interrupt callback for
>>>>> STANDBY state?
>>>>>   
>>>> :) Isn't it exactly what my patch series handle?
>>> As far as I see, that's not true. ;)
>>>
>>> After this series applied,
>>> vfio_ccw_jumptable[VFIO_CCW_STATE_STANDBY][VFIO_CCW_EVENT_INTERRUPT] is
>>> still fsm_irq().
>>>   
>>
>> What I mean is, this code tries to handle design problems
>> without changing too much of the original code at first.
>>
>> The problem here is not that the fsm_irq function is called on interrupt,
>> if we have an interrupt it must be signaled to user land.
>> The problem is that this state is entered at the wrong moment.
>>
>> STANDBY should be entered, during the mdev_open when we realize the QEMU
>> device,
>> and not during the probe, in which we should stay in NOT_OPER until we
>> get the QEMU device.
>>
>> The probe() and mdev_open() function should be modified, not the state
>> table.
> So, the takeaway is that we should handle starting via the init
> callbacks and not via the state machine?
>
hum, sorry, I think that my previous answer was not completely right,
and did not really answer to Dong Jia comment, yes fsm_irq was not
at its place, thinking again about the comments of both of you
I think that we can suppress the INIT event.

I would like to rebase the patch to include the comments you both did.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
