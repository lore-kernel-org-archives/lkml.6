Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeEQJLw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:11:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751367AbeEQJLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:11:49 -0400
Subject: Re: [PATCH v5 01/13] KVM: s390: Interface to test whether APXA
 installed
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180516122116.4c3b10a1.cohuck@redhat.com>
 <20e26cf4-84fe-b681-15e9-59bc113a3828@linux.vnet.ibm.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Thu, 17 May 2018 11:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20e26cf4-84fe-b681-15e9-59bc113a3828@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051709-0020-0000-0000-0000041E2942
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051709-0021-0000-0000-000042B34AC7
Message-Id: <637083a9-49ea-b6e3-604a-58528dfe5aaf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.2018 12:45, Tony Krowiak wrote:
> On 05/16/2018 06:21 AM, Cornelia Huck wrote:
>> On Mon,  7 May 2018 11:11:40 -0400
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>
>>> Relocates an existing static function that tests whether
>>> the AP extended addressing facility (APXA) is installed on
>>> the linux host. The primary reason for relocating this
>>> function is because a new compilation unit (arch/s390/kvm/kvm-ap.c)
>>> is being created to contain all of the interfaces and logic
>>> for configuring an AP matrix for a KVM guest. Some of its
>>> functions will also need to determine whether APXA is installed,
>>> so, let's go ahead and relocate this static function as a
>>> public interface in kvm-ap.c.
>>>
>>> Notes:
>>> ----
>>> 1. The interface to determine whether APXA is installed on the linux
>>>     host the information returned from the AP Query Configuration
>>>     Information (QCI) function. This function will not be available
>>>     if the AP instructions are not installed on the linux host, so a check
>>>     will be included to verify that.
>>>
>>> 2. Currently, the AP bus interfaces accessing the AP instructions will
>>>     not be accessible if CONFIG_ZCRYPT=n, so the relevant code will be
>>>     temporarily contained in the new arch/s390/kvm/kvm-ap.c file until
>>>     the patch(es) to statically build the required AP bus interfaces are
>>>     available.
>> Any ETA for those interfaces? Would be nice if we could avoid
>> introducing temporary interfaces (but I'm certainly not opposing this
>> patch).
>
> I'll check with the developer.
The proposal is out on the internal mailing list. I'd like to release it (internal) tomorrow or start
next week. Already talked with Christian about this because we need to align it somehow with
kvm and s390 kernel development.

regards
Harald Freudenberger
>
>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>>   MAINTAINERS                    |    1 +
>>>   arch/s390/include/asm/kvm-ap.h |   60 +++++++++++++++++++++++++++++
>>>   arch/s390/kvm/Makefile         |    2 +-
>>>   arch/s390/kvm/kvm-ap.c         |   83 ++++++++++++++++++++++++++++++++++++++++
>>>   arch/s390/kvm/kvm-s390.c       |   42 +-------------------
>>>   5 files changed, 147 insertions(+), 41 deletions(-)
>>>   create mode 100644 arch/s390/include/asm/kvm-ap.h
>>>   create mode 100644 arch/s390/kvm/kvm-ap.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index eab763f..224e97b 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7792,6 +7792,7 @@ M:    Christian Borntraeger <borntraeger@de.ibm.com>
>>>   M:    Janosch Frank <frankja@linux.ibm.com>
>>>   R:    David Hildenbrand <david@redhat.com>
>>>   R:    Cornelia Huck <cohuck@redhat.com>
>>> +R:    Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> Don't you want to drop the 'vnet' from your address, as the vnet-less
>> form seems to be the one that will continue working from what I've
>> heard?
>>
>>>   L:    linux-s390@vger.kernel.org
>>>   W:    http://www.ibm.com/developerworks/linux/linux390/
>>>   T:    git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>> No objection against this patch, although I still hope it will not be
>> needed :)
>>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
