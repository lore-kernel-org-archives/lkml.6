Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932116AbeDVOxK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 10:53:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757195AbeDVOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 10:53:03 -0400
Subject: Re: [PATCH v4 03/15] KVM: s390: refactor crypto initialization
To: Cornelia Huck <cohuck@redhat.com>
Cc: Harald Freudenberger <FREUDE@de.ibm.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>, alex.williamson@redhat.com,
        alifm@linux.vnet.ibm.com, berrange@redhat.com,
        bjsdjshi@linux.vnet.ibm.com, borntrae@linux.ibm.com,
        fiuczy@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, kvm@vger.kernel.org, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        mjrosato@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com,
        Reinhard Buendgen <BUENDGEN@de.ibm.com>, thuth@redhat.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-4-git-send-email-akrowiak@linux.vnet.ibm.com>
 <4fb50a31-1893-5cfb-0f35-fb2501c2afa8@linux.vnet.ibm.com>
 <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
 <20180417121044.5c8f2182.cohuck@redhat.com>
 <2ac8b862-e2dc-843e-a0b8-906fa32b42f4@linux.vnet.ibm.com>
 <20180417172139.0a2b148b.cohuck@redhat.com>
 <7276785e-2183-3204-ec80-99fba1546364@linux.vnet.ibm.com>
 <20180418094949.0403dcaf.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Sun, 22 Apr 2018 10:52:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180418094949.0403dcaf.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18042214-0044-0000-0000-00000409281B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008900; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021655; UDB=6.00521396; IPR=6.00800890;
 MB=3.00020714; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-22 14:53:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042214-0045-0000-0000-0000083B30B5
Message-Id: <470d8af7-b9f6-0ab7-9bfa-351fbeaa079c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804220167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 03:49 AM, Cornelia Huck wrote:
> On Tue, 17 Apr 2018 14:08:59 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 04/17/2018 11:21 AM, Cornelia Huck wrote:
>>> On Tue, 17 Apr 2018 10:26:57 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>   
>>>> On 04/17/2018 06:10 AM, Cornelia Huck wrote:
>>>>> On Tue, 17 Apr 2018 09:49:58 +0200
>>>>> "Harald Freudenberger" <FREUDE@de.ibm.com> wrote:
>>>>>      
>>>>>> Didn't we say that when APXA is not available there is no Crypto support
>>>>>> for KVM ?
>>>>> [Going by the code, as I don't have access to the architecture]
>>>>>
>>>>> Current status seems to be:
>>>>> - setup crycb if facility 76 is available (that's MSAX3, I guess?)
>>>> The crycb is set up regardless of whether STFLE.76 (MSAX3) is
>>>> installed or not.
>>> Hm, the current code does a quick exit if bit 76 is not set, doesn't
>>> it?
>> I guess that depends upon what you mean by current code. If you are talking
>> about the code as it is distributed today - i.e., before my patch series -
>> then you are correct. This patch changes that; it initializes the
>> kvm->arch.crypto.crycbd to point to the CRYCB, then clears the format bits
>> (kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT_MASK)) which is the same as
>> setting the CRYCB format to format 0. It is only after this that the
>> check is done to determine whether STFLE.76 is set.
> Ah yes, with "current" I referred to current upstream.
>
>>>   
>>>>> - use format 2 if APXA is available, else use format 1
>>>> Use format 0 if MSAX3 is not available
>>>> Use format 1 if MSAX3 is available but APXA is not
>>>> Use format 2 if MSAX3 and APXA is available
>>>>   
>>>>>    From Tony's patch description, the goal seems to be:
>>>>> - setup crycb even if MSAX3 is not available
>>>> Yes, that is true
>>>>   
>>>>> So my understanding is that we use APXA only to decide on the format of
>>>>> the crycb, but provide it in any case?
>>>> Yes, that is true
>>> With the format selection you outlined above, I guess. Makes sense from
>>> my point of view (just looking at the source code).
>> It also implements what is stated in the architecture doc.
> OK, great.
>
>>>   
>>>>> (Not providing a crycb if APXA is not available would be loss of
>>>>> functionality, I guess? Deciding not to provide vfio-ap if APXA is not
>>>>> available is a different game, of course.)
>>>> This would require a change to enabling the CPU model feature for
>>>> AP.
>>> But would it actually make sense to tie vfio-ap to APXA? This needs to
>>> be answered by folks with access to the architecture :)
>> I don't see any reason to do that from an architectural perspective.
>> One can access AP devices whether APXA is installed or not, it just limits
>> the range of devices that can be addressed
> So I guess we should not introduce a tie-in then (unless it radically
> simplifies the code...)

I'm not clear about what you mean by introducing a tie-in. Can you 
clarify that?

>
