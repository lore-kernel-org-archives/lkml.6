Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeDQSO6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 14:14:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752732AbeDQSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 14:14:57 -0400
Subject: Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
 available function
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, freude@de.ibm.com,
        buendgen@de.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <77bbd4ca-8412-e59d-e1ca-9a114cf495a6@linux.vnet.ibm.com>
 <20180416141136.04be5558.cohuck@redhat.com>
 <e2738909-bc81-4299-a25a-cb4b3cfad69c@linux.vnet.ibm.com>
 <20180417185646.5b43c911.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 14:14:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180417185646.5b43c911.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041718-0044-0000-0000-000004060EE1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008872; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019322; UDB=6.00520008; IPR=6.00798563;
 MB=3.00020619; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 18:14:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041718-0045-0000-0000-000008381345
Message-Id: <812e4644-6315-7ec9-6eac-17bfd3b68f20@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 12:56 PM, Cornelia Huck wrote:
> On Tue, 17 Apr 2018 09:31:00 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> My preference would be one of the following:
>>
>> 1. All of the interfaces defined in arch/s390/include/asm/ap.h
>>      are implemented in a file that is built whether ZCRYPT is
>>      built or not.
>>
>> 2. The drivers/s390/crypto/ap_asm.h file containing the functions
>>      that execute the AP instructions are made available outside of
>>      the AP bus, for example; arch/s390/include/asm
>>
>> I requested this from the maintainer but was told we don't want to
>> have any crypto adapter support when the host AP functionality is
>> disabled (CONFIG_ZCRYPT=n). This makes sense, however; I think it is
>> a bit confusing to have a header file (arch/s390/include/asm/ap.h)
>> with interfaces that are conditionally built.
>>
>> This is why I chose the ifdeffery (as you call it) approach. The
>> only other solution I can conjure is to duplicate the asm code for
>> the AP instructions needed in KVM and bypass using the AP bus
>> interfaces.
> I think at the root of this is an unfortunate mixup in the
> architecture: The format of the crycb changes depending on some ap
> feature being installed. Providing the crycb does not have anything to
> do with ap device usage in the host, but we need to issue an ap
> instruction to get this right. [Correct me if I'm wrong; but that's
> what I get without being able to consult the actual architecture.]

That sums it up.

>
> So, exporting *all* of the interfaces is probably not needed anyway. I
> think it boils down to either "export the interfaces where a mixup
> happened, and keep the rest to zcrypt only", or "duplicate the
> instructions for kvm usage".

I only suggested exporting all of the interfaces because the others may
be needed down the road when interception is implemented for full
virtualization of AP devices.

>
> I hope we can find a solution here, as this seems to be one of the main
> discussion points :/ (FWIW, I think the basic driver interface is sane.)

I will work on coming up with something that attempts to take into 
consideration
all of the comments thus far. In the meantime, I will keep my eyes on this
space if anybody comes up with a better, concrete resolution.

>
