Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeEWM3k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:29:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932070AbeEWM3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:29:35 -0400
Subject: Re: [PATCH v4 0/2] vfio/mdev: Device namespace protection
To: Cornelia Huck <cohuck@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: kwankhede@nvidia.com, Dong Jia <bjsdjshi@linux.vnet.ibm.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180518190145.3187.7620.stgit@gimli.home>
 <c666f6b7-bd49-79e4-703d-2724f7549c53@linux.ibm.com>
 <20180522123829.4e758646@w520.home>
 <20180523105641.0d89701b.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 23 May 2018 14:29:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523105641.0d89701b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052312-0012-0000-0000-000005D9BECF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052312-0013-0000-0000-00001957092A
Message-Id: <dfeb44cc-39bf-1015-62d4-4644e6a8cf7b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/23/2018 10:56 AM, Cornelia Huck wrote:
> On Tue, 22 May 2018 12:38:29 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Tue, 22 May 2018 19:17:07 +0200
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>>   From vfio-ccw perspective I join Connie's assessment: vfio-ccw should
>>> be fine with these changes. I'm however not too deeply involved with
>>> the mdev framework, thus I don't feel comfortable r-b-ing. That results
>>> in
>>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>>> for both patches.
>>>
>>> While at it I have would like to ask about the semantics and intended
>>> use of the mdev interfaces.
>>>
>>> static int vfio_ccw_sch_probe(struct subchannel *sch)
>>> {
>>>
>>> /* HALIL: 8< Not so interesting stuff happens here. >8 */
>>
>> This was interesting:
>>
>> 	private->state = VFIO_CCW_STATE_NOT_OPER;
>>
>>>           ret = vfio_ccw_mdev_reg(sch);
>>>           if (ret)
>>>                   goto out_disable;
>>> /*
>>>    * HALIL:
>>>    * This might be racy. Somewhere in vfio_ccw_mdev_reg() the create attribute
>>>    * is made available (it calls mdev_register_device()). For instance create will
>>>    * attempt to decrement private->avail which is initialized below. I fail to
>>>    * understand how is  this well synchronized.
>>>    */
>>>           INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>>>           atomic_set(&private->avail, 1);
>>>           private->state = VFIO_CCW_STATE_STANDBY;
>>>
>>>           return 0;
>>>
>>> out_disable:
>>>           cio_disable_subchannel(sch);
>>> out_free:
>>>           dev_set_drvdata(&sch->dev, NULL);
>>>           kfree(private);
>>>           return ret;
>>> }
>>>
>>> Should not initialization  of go before mdev_register_device(), and then rolled
>>> back if necessary if mdev_register_device() fails?
>>>
>>> In practice it does not seem very likely that userspace can trigger
>>> mdev_device_create() before vfio_ccw_sch_probe() finishes so it should
>>> not be a practical problem. But I would like to understand how synchronization
>>> is supposed to work.
>>>
>>> [Added Dong Jia, maybe he is also able to answer my question.]
>>
>> vfio_ccw_mdev_create() requires that private->state is not
>> VFIO_CCW_STATE_NOT_OPER but vfio_ccw_sch_probe() explicitly sets state
>> to this value before calling vfio_ccw_mdev_reg(), so a create should
>> return -ENODEV if racing with parent registration.  Is there something
>> else that I'm missing?  Thanks,
>>


Disclaimer: I did not do much kernel work up until now. I still have
much to learn.

I mostly agree with your analysis but I'm not sure if the conclusion should be
'and thus everything is good' or 'and thus indeed we do have a race, a
poorly handled one'.

One thing I'm not sure about is: can atomic_set(&private->avail, 1) and
private->state = VFIO_CCW_STATE_STANDBY be perceived as reordered by
e.g. some other cpu and thus vfio_ccw_mdev_create() or not. I tried to
figure it out based on Documentation/atomic_t.txt but was not very successful.
If these can be reordered we could observe -EPERM instead of -ENODEV, I
think.

Furthermore from your analysis I deduce that the client code (I think mdev
calls it vendor code) may rely on mdev_register_device() containing a
(RELEASE) barrier. We use a mutex in there so the barrier is there. And
the client code may rely on a (ACQUIRE) barrier before the create callback
is called. That should also be true and was true in the past too again because
of mutex usage.


>> Alex
> 
> No, I think your understanding is correct. We move the state from
> NOT_OPER to STANDBY only after we're set up completely, so our create
> callback will simply fail early with -ENODEV. This looks fine to me.
> 

This -ENODEV looks strange to me. Which device does not exist?  The
userspace were supposed to retry on this? It's not even -EAGAIN. Is it
documented somewhere?

If it's unavoidable (which I don't see why) I would prefer -EAGAIN. I
think throwing an -ENODEV at our userspace once in a blue moon (if ever)
because that is the way we 'handle' races in our code instead of avoiding
them is not very friendly.

And I'm not sure -EPERM is not possible (see my statement
about reordering of the writes above).


Regards,
Halil
