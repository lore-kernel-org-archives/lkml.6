Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeEGOPI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:15:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752083AbeEGOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:15:04 -0400
Subject: Re: [PATCH v4 08/15] KVM: s390: interfaces to (de)configure guest's
 AP matrix
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-9-git-send-email-akrowiak@linux.vnet.ibm.com>
 <99f4752a-1358-61e4-bf9e-5672b2d4036f@linux.vnet.ibm.com>
 <0f47c442-47b8-ee57-d014-5200c59125d7@linux.vnet.ibm.com>
 <54e4c3ef-0750-981b-7b0e-6b18d1a77c3c@linux.vnet.ibm.com>
 <7a733e41-3956-6828-9efa-899c9a954c20@linux.vnet.ibm.com>
 <829b70c7-1648-f1c3-f656-3dca56bb3d8e@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Mon, 7 May 2018 10:14:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <829b70c7-1648-f1c3-f656-3dca56bb3d8e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050714-2213-0000-0000-000002A04F18
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008986; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01028839; UDB=6.00525667; IPR=6.00807972;
 MB=3.00020970; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-07 14:14:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050714-2214-0000-0000-00005A07BD26
Message-Id: <9baa91c4-bb06-a16e-5f7c-c6dacef6e157@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 12:01 PM, Pierre Morel wrote:
> On 03/05/2018 16:41, Tony Krowiak wrote:
>> On 05/02/2018 10:57 AM, Pierre Morel wrote:
>>> On 25/04/2018 18:21, Tony Krowiak wrote:
>>>> On 04/23/2018 09:46 AM, Pierre Morel wrote:
>>>>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>>>>> Provides interfaces to assign AP adapters, usage domains
>>>>>> and control domains to a KVM guest.
> ...
>> The kvm_ap_configure_matrix(kvm, matrix) interface configures the 
>> APM, AQM and ADM in the
>> guest's CRYCB which implies AP instructions are being interpreted. 
>> There is nothing in SIE
>> precluding the sharing of AP queues between guests using SIE to 
>> interpret AP instructions,
>> it is my opinion - along with several others - that this is not 
>> advisable given the
>> results are not predictable, not to mention the security concerns. If 
>> the protocol to access
>> queues changes, then we create a different interface. The other 
>> option is to include a flag
>> on the kvm_ap_configure_matrix(kvm, matrix) interface to indicate 
>> whether sharing is
>> allowed. I don't like this, because we have no way of knowing if the 
>> caller has taken the
>> proper care to ensure the VM sharing the queue should be allowed 
>> access. Besides, when
>> queue sharing is implemented, it is my opinion that we will intercept 
>> the AP instructions
>> and the matrix will not be configured in the CRYCB. I stick by my 
>> response above.
>
> I mean, validating the queue sharing is a mater of the VFIO driver.
> This code is not needed if the VFIO driver is not used.
> But it is not very important.

Yes, this check could have been implemented in the VFIO driver, but as I 
stated above, that
would require the driver to "know" the internals of KVM. I think the KVM 
logic should
be encapsulated in KVM. If we want to allow sharing of interpreted AP 
devices, then we
can always add a flag to the interface.

>
>
>>
>>>
>>>>>> +static int kvm_ap_matrix_apm_create(struct kvm_ap_matrix 
>>>>>> *ap_matrix,
>>>>>> +                    struct ap_config_info *config)
>>>>>> +{
>>>>>> +    int apm_max = (config && config->apxa) ? config->Na + 1 : 16;
>>>>>
>>>>> At this moment you already know the format of the crycb.
>>>>
>>>> How?
>>>
>>> you calculated this in kvm_ap_build_crycbd() which is called from 
>>> kvm_s390_crypto_init()
>>> itself called from kvm_arch_init_vm().
>>> It is when starting the VM.
>>
>> This structure is used by the vfio_ap driver to store the mediated 
>> matrix device's matrix
>> configuration as well as to configure the CRYCB. The mediated 
>> device's matrix is
>> configured before the guest is started ... it is the means for 
>> configuring the guest's
>> matrix after all. The bottom line is, this function will be called 
>> long before the
>> kvm_ap_build_crycbd() function is called.
>
> you are right, I was thinking about open, should have take more 
> attention.
> Sorry.
>
> Pierre
>
