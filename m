Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeEPHtD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:49:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751786AbeEPHtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:49:01 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 06/13] KVM: s390: interfaces to manage guest's AP
 matrix
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
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
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 16 May 2018 09:48:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a9206728-2673-c8de-851b-323027a398fa@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051607-0044-0000-0000-00000552F38B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051607-0045-0000-0000-000028945EF5
Message-Id: <f8c88504-55dc-99a8-90a1-2ddf63a20091@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2018 18:07, Tony Krowiak wrote:
> On 05/15/2018 10:55 AM, Pierre Morel wrote:
>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>> Provides interfaces to manage the AP adapters, usage domains
>>> and control domains assigned to a KVM guest.
>>>
>>> The guest's SIE state description has a satellite structure called the
>>> Crypto Control Block (CRYCB) containing three bitmask fields
>>> identifying the adapters, queues (domains) and control domains
>>> assigned to the KVM guest:
>>>
...snip...
>>> +}
>>
>> This function (ap_validate_queue_sharing) only verifies that VM don't 
>> share queues.
>> What about the queues used by a host application?
>
> How can that be verified from this function? I suppose I could put a 
> check in here to
> verify that the queues are reserved by the vfio_ap device driver, but 
> that would
> be redundant because an AP queue can not be assigned to a mediated 
> matrix device
> via its sysfs attributes unless it is reserved by the vfio_ap device 
> driver (see
> patches 7, 8 and 9).
>
>>
>>
>> I understand that you want to implement  these checks within KVM but 
>> this is
>> related to which queue devices are bound to the matrix and which one 
>> are not.
>
> See my comments above and below about AP queue assignment to the 
> mediated matrix
> device. The one verification we can't do when the devices are assigned 
> is whether
> another guest is using the queue because assignment occurs before the 
> guest using
> the queue is started in which case we have no access to KVM. It makes 
> no sense to
> do so at assignment time anyway because it doesn't matter until the 
> guest using
> the mediated matrix device is started, so that check is done in KVM.
>
>>
>>
>> I think that this should be related somehow to the bounded queue 
>> devices and
>> therefor implemented inside the matrix driver.
>
> As I stated above, when an AP queue is assigned to the mediated matrix 
> device via
> its sysfs attributes, a check is done to verify that it is bound to 
> the vfio_ap
> device driver (see patches 7, 8 and 9). If not, then assignment will 
> be rejected;
> therefore, it will not be possible to configure a CRYCB with AP queues 
> that are
> not bound to the device driver.

This patch and te followed patches take care that the queues are bound 
to the
matrix driver when they are assigned to the matrix using the sysfs entries.

But they do not take care that the queue can not be unbound before you 
start
the guest, and they are not in the path if the admin decide to unbind a 
queue
at some later time.

>
>>
>>
>> Regards,
>>
>> Pierre
>>
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
