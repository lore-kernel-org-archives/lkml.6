Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeECO0i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:26:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751236AbeECO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:26:36 -0400
Subject: Re: [PATCH 04/10] vfio: ccw: replace IO_REQ event with SSCH_REQ event
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180426073053.GZ12194@bjsdjshi@linux.vnet.ibm.com>
 <20180426074806.GB12194@bjsdjshi@linux.vnet.ibm.com>
 <20180430173305.632faa80.cohuck@redhat.com>
 <20180502074622.GV5428@bjsdjshi@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 16:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502074622.GV5428@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050314-0012-0000-0000-000005D19525
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050314-0013-0000-0000-0000194EBCB8
Message-Id: <5816643d-5406-06b9-0727-fdcd771aba63@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 09:46, Dong Jia Shi wrote:
> * Cornelia Huck <cohuck@redhat.com> [2018-04-30 17:33:05 +0200]:
>
>> On Thu, 26 Apr 2018 15:48:06 +0800
>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>
>>> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2018-04-26 15:30:54 +0800]:
>>>
>>> [...]
>>>
>>>>> @@ -179,7 +160,7 @@ static int fsm_irq(struct vfio_ccw_private *private,
>>>>>   	if (private->io_trigger)
>>>>>   		eventfd_signal(private->io_trigger, 1);
>>>>>
>>>>> -	return private->state;
>>>>> +	return VFIO_CCW_STATE_IDLE;
>>>> This is not right. For example, if we are in STANDBY state (subch driver
>>>> is probed, but mdev device is not created), we can not jump to IDLE
>>>> state.
>>>>    
>>> I see my problem, for STANDBY state, we should introduce another event
>>> callback for VFIO_CCW_EVENT_INTERRUPT. It doesn't make sense to call
>>> fsm_irq() which tries to signal userspace with interrupt notification
>>> when mdev is not created yet... So we'd need a separated fix for this
>>> issue too.
>> But how do we even get into that situation when we don't have an mdev
>> yet?
>>
> We cann't... So let's assign fsm_nop() as the interrupt callback for
> STANDBY state?
>

:) Isn't it exactly what my patch series handle?


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
