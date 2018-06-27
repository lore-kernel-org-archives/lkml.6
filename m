Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC57C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB4526671
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB4526671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934313AbeF0KAw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:00:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934289AbeF0KAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:00:49 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R9xI0W063787
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 06:00:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jv8dhg46h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 06:00:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 27 Jun 2018 11:00:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 11:00:43 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RA0gJZ31719578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 10:00:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0810A406E;
        Wed, 27 Jun 2018 11:00:33 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51EF2A4069;
        Wed, 27 Jun 2018 11:00:33 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 11:00:33 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state machine
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
 <20180613165151.056ecaec.cohuck@redhat.com>
 <bd5fb44e-3395-63bc-23a5-b9b6a8a8f1ef@linux.ibm.com>
 <20180619160045.13caf12e.cohuck@redhat.com>
 <63d1948a-3844-26e3-fc4f-0e7da7b4f515@linux.ibm.com>
 <20180626180052.7412ee79.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 27 Jun 2018 12:00:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626180052.7412ee79.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18062710-0028-0000-0000-000002D5710A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062710-0029-0000-0000-0000238CD8A1
Message-Id: <3406a24b-1e3a-ac23-c5d0-87c9a3b5515c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2018 18:00, Cornelia Huck wrote:
> On Tue, 26 Jun 2018 13:04:12 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 19/06/2018 16:00, Cornelia Huck wrote:
>>> On Thu, 14 Jun 2018 10:06:31 +0200
>>> Pierre Morel<pmorel@linux.ibm.com>  wrote:
>>>   
...snip...
>> The goal of the state machine is to describe the device driver state.
>> Not the device state which is hold by the CIO level.
> I don't think there really is such a thing as "device driver state" (or
> maybe I don't understand what you mean by it). The state is attached to
> the individual device, isn't it?
Yes but it is related to the software handling the device and not to the 
device.
This is a difference between QEMU, Linux VFIO driver and Hardware.

In my point of view:

QEMU                  : Emulates a device, internal state is state of 
the device
Linux VFIO driver: Handle the device, internal state is driver state
Hardware            : obviously get the device state


>
>> I think this has lead to some confusion since I tried to keep the old
>> naming convention.
>> So, I agree that a state named "NON_INIT" or "UNCONFIGUED" would be better
>> to distinguish it from the device state "NOT_OPERATIONAL"
>>
>>> Also, we need to be careful with the virtual machine vs. guest
>>> terminology. The only thing that has an impact from the guest is when
>>> it does I/O and when an interrupt is generated as a result (i.e., the
>>> IDLE/BUSY transitions). The other transitions are triggered by virtual
>>> machine setup.
>> Absolutely.
>>
>>>> ------------------------------------------------------------
>>>> | STANDBY          | A guest is associated but not started |
>>> This is basically "device is bound to driver, but no mdev has been set
>>> up".
>> When the device is bound to the driver, the device driver
>> is still in NOT_OPERATIONAL state.
>>
>> The transition to STANDBY is done when the virtual machine starts and
>> opens the mediated device.
>> Note that the device is still not usable until it is reseted.
> Hm, isn't that transition happening when the mdev is created?
No, when the mdev is created the VM is not started.
The STANDBY state is entered when the mdev_open is called,
this is when the VFIO framework is initialized as QEMU starts.

When the mdev is created the mdev_create is called but do not
induce any state change.

>
...snip...
>> Now you are talking about the driver :) This should probably be done
>>> for the other states as well.
>> Ill update the description to make clear that the state is the
>> driver state (device driver) and not the device state.
>> The device state is handled by the firmware.
> Now you have managed to confuse me completely... isn't the firmware
> only handling the (real) subchannel state?

Yes and QEMU the virtual one.
But the driver does not need to handle the device state
but the driver state. Which is quite different.

>

>>> Isn't that rather "an mdev is created"?
>> No, ONLINE is triggered by VFIO_RESET, after the mdev has been created
>> and when the VM is started or restarted by QEMU.
>>
>> I see that I did not do a good job describing what triggers the events.
>> I will try again in a dedicated document.
> It might be good to combine the two.

When mdev is created the VM does not exist, it is created by the admin.

The mdev_open() is called once when the VM starts.
VFIO_RESET is called on start and every time the VM is reseted.

These are three different events occuring in the life of the driver.
mdev creation do not influence the way the driver works.
mdev open does, and issues the INIT event
VFIO_RESET does and issues the ONLINE event

>
>>>   
>>>> | |                                       |
>>>> |                  | triggered by: vfio_reset              |
>>>> |                  | action: enable SC                     |
>>>> |                  | state on success: IDLE                |
>>>> |                  | state on error  : STANDBY             |
>>> What happens if the subchannel is not operational when we try to get it
>>> ready? Can it go to NOT_OPERATIONAL in that case?
>> I think we have a confusion between the sub-channel being non operational
>> and the device driver being non operational.
>> Here, the device driver is operational, even the device may not.
> How can something be operational if the device is not? It could be in a
> state like the ccw device's disconnected state, but it's certainly not
> ready for requests.

The driver may be operational even the device is not.
Depending on the protocol between device and driver it allows
the driver to reset the device.
We have two drivers here speaking with the device, the one in the guest
and the VFIO driver.
The VFIO driver works is to handle the virtualization infrastructure,
not to handle the device. Handling the device is done by the guest
driver.

>
>> For the VM perspective, if the device is not operational we send a RESET.
>>
>> For the guest perspective we can do what ever instruction we needs to
>> get the device operational, therefor we need the driver to be operational
>> to process the instruction.
> Ah, do you mean 'subchannel enabled'? I was thinking about 'device
> dead, we get cc 3 or somesuch'.

What can we do on the host level that the guest can not do?
If we have a way to retrieve a dead device in the host, shouldn't
we give the guest this possibility?

Speaking about sub-channel enabled:

We currently have very restricted possibilities for the guest
to manage the sub-channel or even to get real information
on the sub-channel.
Dong-Jia began working in this direction with his last patch series
and I think it is a way to follow.
My point of view is that we should not do too much in the VFIO
driver but only take care of the virtualization of the SCHIB.
But this is beyond the scope of this patch .

>

>>>> |                  | state on error  : IDLE                |
>>> Should there be any way to drop to NOT_OPERATIONAL as well? We'll
>>> probably get a notification from the common I/O layer if that happens,
>>> though.
>> I think this is the duty of the guest to handle this kind of thing.
>> The device driver must stay operational.
> See above. I think we'll get a notification from the common I/O layer,
> and it probably makes sense to inject the same notification (CRW) into
> the guest.

Absolutely, I agree 100%

>
>>>   

...snip...

  

>>> This is the common I/O layer's sch_event callback. That can mean
>>> different things:
>>> - Something regarding the paths to the device changed. We can translate
>>>     that to "schib updated".
>>> - Device is gone. This is a different situation; we may either try to
>>>     implement the disconnected state, or we may give up the device.
>>>
>>> Also, can't we get this event in QUIESCING or STANDBY as well?
>> I think it should be ignored in STANDBY as we did not even
>> start to use the sub-channel we have no information on it
>> at that moment.
> As long as we do update it some time before we need the information, ok.

AFAIK we currently never forward this information to the guest,
when we do it we will need to virtualize this information.


>
>> In QUIESCING we may have to handle it for internal purpose
>> to make sure to shutdown smoothly.
>> I will work on this again.
>> (Still this OFFLINE refactoring)
>>
>>>   
>>>> | |                                       |
>>>> |                  | triggered by: sch_event               |
>>>> |                  | action: Store the SCHIB in IO region  |
>>>> |                  | state on success: no change           |
>>> As said, we may want some different handling for "device gone"
>>> situations.
>>>
>>> Also, what happens if we get that event in BUSY? Is the I/O still
>>> running?
>> AFAIK yes, it is an asynchronous event.
>> It can happen during BUSY.
>> However AFAIU we still get an IRQ even we get the device gone
>> during I/O operation.
> It depends. We either get a deferred cc 3, or a machine check (but no
> interrupt).

I understood from current code that all kind of CRW do not
imply that the sub-channel is gone.
I must investigate a little more.

Anyway, the CRW should be handled and forwarded to the guest
but I would prefer not to change too much in this series,
shouldn't this changes be part of a next series?

best regards,

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

