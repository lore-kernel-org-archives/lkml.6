Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426181AbeCBKIr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:08:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1424324AbeCBKIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:08:19 -0500
Subject: Re: [PATCH v2 13/15] KVM: s390: Configure the guest's CRYCB
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <99b24fc7-3df9-6620-d1df-917214fbdda2@redhat.com>
 <fdb264da-dd74-f380-78dc-7abc61f1484b@linux.vnet.ibm.com>
 <081eab40-0bbd-5842-76bc-2974f4544529@redhat.com>
 <4763e223-1c78-c9a3-42bc-2d3569a716ff@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <56f576ba-4eee-696e-45aa-f4db1e96bd57@redhat.com>
Date: Fri, 2 Mar 2018 11:08:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <4763e223-1c78-c9a3-42bc-2d3569a716ff@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.2018 21:42, Tony Krowiak wrote:
> On 03/01/2018 04:37 AM, David Hildenbrand wrote:
>> On 28.02.2018 21:45, Tony Krowiak wrote:
>>> On 02/28/2018 04:49 AM, David Hildenbrand wrote:
>>>>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>>>> +{
>>>>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>>> +	unsigned long events;
>>>>> +	int ret;
>>>>> +
>>>>> +	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
>>>>> +	events = VFIO_GROUP_NOTIFY_SET_KVM;
>>>>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>>> +				     &events, &matrix_mdev->group_notifier);
>>>>> +
>>>>> +	ret = kvm_ap_configure_matrix(matrix_mdev->kvm,
>>>>> +				      matrix_mdev->matrix);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	ret = kvm_ap_enable_ie_mode(matrix_mdev->kvm);
>>>> Can't this happen while the guest is already running? Or what hinders us
>>>> from doing that?
>>> I'm not sure exactly what you're asking here. Are you asking if the
>>> vfio_ap_mdev_open()
>>> function can be called multiple times while the guest is running? AFAIK
>>> this will be
>>> called only once when the mediated device's file descriptor is opened.
>>> This happens in
>>> QEMU when the -device vfio-ap device is realized.
>> Okay, but from a pure interface point of view, this could happen any
>> time, even while the guest is already running. Patching in the SCB of a
>> running VCPU is evil.
> How can this happen while the guest is running? QEMU opens the fd when the
> device is realized and AFAIK vfio mdev will not allow any other process to
> open it until the guest is terminated. What am I missing?

It can't happen right now (the way QEMU uses it), but the kernel
interface allows it, no?

Anyhow, as discussed this should be handled directly while creating a
VCPU. Then also CPU hotplug is properly covered.


-- 

Thanks,

David / dhildenb
