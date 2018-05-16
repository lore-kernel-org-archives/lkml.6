Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeEPNtN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:49:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752386AbeEPNtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:49:08 -0400
Subject: Re: [PATCH v5 06/13] KVM: s390: interfaces to manage guest's AP
 matrix
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-7-git-send-email-akrowiak@linux.vnet.ibm.com>
 <f2646170-1aaf-8447-4c02-0679909d754f@linux.ibm.com>
 <a9206728-2673-c8de-851b-323027a398fa@linux.vnet.ibm.com>
 <f8c88504-55dc-99a8-90a1-2ddf63a20091@linux.ibm.com>
 <13331f80-8821-6de3-ca29-7a3ea869e4f1@linux.vnet.ibm.com>
 <1891f565-284f-ab30-ebc7-8fef85b5fba7@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 16 May 2018 09:48:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1891f565-284f-ab30-ebc7-8fef85b5fba7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051613-8235-0000-0000-00000D82A8DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009034; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033149; UDB=6.00528242; IPR=6.00812280;
 MB=3.00021145; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 13:49:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051613-8236-0000-0000-000040FD23EC
Message-Id: <a02a8fa0-9b05-41cf-4507-d4540b279247@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 09:15 AM, Pierre Morel wrote:
> On 16/05/2018 15:12, Tony Krowiak wrote:
>> On 05/16/2018 03:48 AM, Pierre Morel wrote:
>>> On 15/05/2018 18:07, Tony Krowiak wrote:
>>>> On 05/15/2018 10:55 AM, Pierre Morel wrote:
>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>> Provides interfaces to manage the AP adapters, usage domains
>>>>>> and control domains assigned to a KVM guest.
>>>>>>
>>>>>> The guest's SIE state description has a satellite structure 
>>>>>> called the
>>>>>> Crypto Control Block (CRYCB) containing three bitmask fields
>>>>>> identifying the adapters, queues (domains) and control domains
>>>>>> assigned to the KVM guest:
>>>>>>
>>> ...snip...
>>>>>> +}
>>>>>
>>>>> This function (ap_validate_queue_sharing) only verifies that VM 
>>>>> don't share queues.
>>>>> What about the queues used by a host application?
>>>>
>>>> How can that be verified from this function? I suppose I could put 
>>>> a check in here to
>>>> verify that the queues are reserved by the vfio_ap device driver, 
>>>> but that would
>>>> be redundant because an AP queue can not be assigned to a mediated 
>>>> matrix device
>>>> via its sysfs attributes unless it is reserved by the vfio_ap 
>>>> device driver (see
>>>> patches 7, 8 and 9).
>>>>
>>>>>
>>>>>
>>>>> I understand that you want to implement  these checks within KVM 
>>>>> but this is
>>>>> related to which queue devices are bound to the matrix and which 
>>>>> one are not.
>>>>
>>>> See my comments above and below about AP queue assignment to the 
>>>> mediated matrix
>>>> device. The one verification we can't do when the devices are 
>>>> assigned is whether
>>>> another guest is using the queue because assignment occurs before 
>>>> the guest using
>>>> the queue is started in which case we have no access to KVM. It 
>>>> makes no sense to
>>>> do so at assignment time anyway because it doesn't matter until the 
>>>> guest using
>>>> the mediated matrix device is started, so that check is done in KVM.
>>>>
>>>>>
>>>>>
>>>>> I think that this should be related somehow to the bounded queue 
>>>>> devices and
>>>>> therefor implemented inside the matrix driver.
>>>>
>>>> As I stated above, when an AP queue is assigned to the mediated 
>>>> matrix device via
>>>> its sysfs attributes, a check is done to verify that it is bound to 
>>>> the vfio_ap
>>>> device driver (see patches 7, 8 and 9). If not, then assignment 
>>>> will be rejected;
>>>> therefore, it will not be possible to configure a CRYCB with AP 
>>>> queues that are
>>>> not bound to the device driver.
>>>
>>> This patch and te followed patches take care that the queues are 
>>> bound to the
>>> matrix driver when they are assigned to the matrix using the sysfs 
>>> entries.
>>>
>>> But they do not take care that the queue can not be unbound before 
>>> you start
>>> the guest, and they are not in the path if the admin decide to 
>>> unbind a queue
>>> at some later time.
>>
>> That is a good point. I need to put a check in the device driver at 
>> the time
>> the mediated device fd is opened to verify that the queues being 
>> configured in
>> the guest's CRYCB are bound to the driver.
>
> not only, you also need to avoid the possibility of unbinding the device.
> For this you need to use the remove callback from the driver.

I thought I addressed this already. The definition of the remove 
callback does
not specify a return value, so there is currently no way to prevent the 
AP bus
from removing the queue device on unbind. I sent an email to Harald to 
discuss
adding a return value to the callback.

>
>
>>
>>>
>>>
>>>>
>>>>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Pierre
>>>>>
>>>>
>>>
>>
>
