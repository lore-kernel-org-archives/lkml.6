Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeC0OpQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:45:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752210AbeC0OpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:45:12 -0400
Subject: Re: [PATCH v3 05/14] s390: vfio-ap: base implementation of VFIO AP
 device driver
To: Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1d5a5e18-1886-dd73-a17e-9bec617507ba@linux.vnet.ibm.com>
 <e4d7621c-a09c-bdfd-ffe2-35c5ea3acdc7@linux.vnet.ibm.com>
 <20180327131705.46fded40.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 16:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327131705.46fded40.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18032714-0008-0000-0000-000004E2D502
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032714-0009-0000-0000-00001E760FFD
Message-Id: <29443c81-19b4-5811-798c-e324b34c083a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2018 13:17, Cornelia Huck wrote:
> On Thu, 15 Mar 2018 13:25:25 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 03/15/2018 09:25 AM, Pierre Morel wrote:
>>> On 14/03/2018 19:25, Tony Krowiak wrote:
>>>> +config VFIO_AP
>>>> +    def_tristate m
>>> not sure it must be module by default.
>>> I would not set it by default.
>> Connie also asked about this in the last review, so I will go ahead
>> and change it.
>>>   
>>>> +    prompt "VFIO support for AP devices"
>>>> +    depends on ZCRYPT && VFIO_MDEV_DEVICE
>>> VFIO_MDEV_DEVICE is a general feature *needed* by VFIO_AP
>>> and has no use case by its own. If it is set it is obviously because some
>>> mediated device drivers needs it.
>>> while ZCRYPT is a Z feature which may be set without VFIO_AP.
>>>
>>> So you need:
>>>
>>> config VFIO_AP
>>>      def_tristate n
>>>      prompt "VFIO support for AP devices"
>>>      depends on ZCRYPT
>>>      select VFIO_MDEV
>>>      select VFIO_MDEV_DEVICE
>>> ...
>> I was thinking the same just yesterday and I agree, this makes sense.
> OTOH, nobody else seems to do a select on these symbols so far.
>
> If you decide to go that route, you'll also need to depend on VFIO

I think a select is better (again).

> (otherwise you could end up selecting symbols with unmet dependencies).
> All in all, I prefer the 'depends' approach.
>
Why do you prefer this approach?


I can tell you why I prefer a mixed approach:

We have two tools, depends and select.

It seems to me that depends should be used for things we can not choose 
to be there or not, but things that just are there, like hardware 
dependencies. For example MMU, CPU type, CRYPTO hardware...

Select on the other hand is useful to choose things that we need like 
libraries, VFIO, VIRTIO, crypto libraries etc.

Using this policy is clear and makes easy to choose functionalities and 
get the utilities automatically.

On the other hand, only using depends makes things to hide the 
functionalities behind the utilities.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
