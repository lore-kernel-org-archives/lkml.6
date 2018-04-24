Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeDXIlK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:41:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932850AbeDXIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:41:03 -0400
Subject: Re: [PATCH 01/10] vfio: ccw: Moving state change out of IRQ context
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-2-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180424065442.GV12194@bjsdjshi@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 10:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424065442.GV12194@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18042408-0012-0000-0000-000005CE1CE0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042408-0013-0000-0000-0000194A8B57
Message-Id: <ac4b7441-2d17-922b-695e-98c01d87cd42@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240086
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2018 08:54, Dong Jia Shi wrote:
> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:04 +0200]:
>
> [...]
>
>> @@ -94,9 +83,15 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>>   static void vfio_ccw_sch_irq(struct subchannel *sch)
>>   {
>>   	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
>> +	struct irb *irb = this_cpu_ptr(&cio_irb);
>>
>>   	inc_irq_stat(IRQIO_CIO);
>> -	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
>> +	memcpy(&private->irb, irb, sizeof(*irb));
>> +
>> +	WARN_ON(work_pending(&private->io_work));
> Hmm, why do we need this?

The current design insure that we have not two concurrent SSCH requests.
How ever I want here to track spurious interrupt.
If we implement cancel, halt or clear requests, we also may trigger (AFAIU)
a second interrupts depending on races between instructions, controller 
and device.

We do not need it strongly.

>
>> +	queue_work(vfio_ccw_work_q, &private->io_work);
>> +	if (private->completion)
>> +		complete(private->completion);
>>   }
>>
>>   static int vfio_ccw_sch_probe(struct subchannel *sch)
> [...]
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
