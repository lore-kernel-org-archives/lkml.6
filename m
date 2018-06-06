Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35ACD601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeFFOYs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:24:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752004AbeFFOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:24:46 -0400
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <a6bba129-8a3c-a848-65aa-b67816bf2d25@linux.ibm.com>
 <53275110-45fb-d50f-c97e-93141378f094@linux.vnet.ibm.com>
 <89bda651-d465-af50-a737-1900a54b01c8@linux.ibm.com>
 <6f67a282-773d-3fca-5b36-cc23ad49ba5b@linux.vnet.ibm.com>
 <32340d2a-bea6-bdb1-38a6-76afe3d54672@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 6 Jun 2018 10:24:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <32340d2a-bea6-bdb1-38a6-76afe3d54672@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060614-0064-0000-0000-000003171C91
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009139; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043027; UDB=6.00534142; IPR=6.00822157;
 MB=3.00021491; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-06 14:24:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060614-0065-0000-0000-000039809E0F
Message-Id: <624dcbbf-5f40-6f27-b173-a4c533dd7781@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060166
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 08:40 AM, Pierre Morel wrote:
> On 30/05/2018 16:28, Tony Krowiak wrote:
>> On 05/24/2018 05:10 AM, Pierre Morel wrote:
>>> On 23/05/2018 16:38, Tony Krowiak wrote:
>>>> On 05/16/2018 03:55 AM, Pierre Morel wrote:
>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>> Provides a sysfs interface to view the AP matrix configured for the
>>>>>> mediated matrix device.
>>>>>>
>>>>>> The relevant sysfs structures are:
>>>>>>
>>>>>> /sys/devices/vfio_ap
>>>>>> ... [matrix]
>>>>>> ...... [mdev_supported_types]
>>>>>> ......... [vfio_ap-passthrough]
>>>>>> ............ [devices]
>>>>>> ...............[$uuid]
>>>>>> .................. matrix
>>>>>>
>>>>>> To view the matrix configured for the mediated matrix device,
>>>>>> print the matrix file:
>>>>>
>>>>> This is the configured matrix, not the one used by the guest.
>>>>> Nothing in the patches protect against binding a queue and assigning
>>>>> a new AP when the guest runs.
>>>>> The card and queue will be showed by this entry.
>>>>
>>>> Of course, as stated above, this is the matrix configured for the
>>>> mediated matrix device. Are you suggesting here that the driver
>>>> should prevent assigning a new adapter or domain while a guest is
>>>> running? Couldn't this be a step in the process for hot (un)plugging
>>>> AP queues?
>>>
>>> No, I mean what is the point to show this?
>>> It is not what the guest sees.
>>> Has it any use case?
>>
>> The point is to display the matrix so one can view the AP queues that
>> have been assigned to the mediated matrix device. This is the only way
>> to view the matrix. Do you not find value in being able to see what
>> has been assigned to the mediated matrix device?
>
> Two things:
> 1) I think it is better to retrieve the individual masks

I am not certain what you mean by this. Are you suggesting we display the
actual mask? For example, the APM:

08000000000000001000000000000c0000000030000000000800000000000001

If that is the case, I completely disagree as that would be worthless from
a user perspective. Trying to figure out which APs are configured would be
ridiculously complicated.

Or, are you suggesting something like this:

4,67,116,117,154,155,255

Personally, I found viewing the queues to be much more valuable when
configuring the mediated device's matrix. I originally displayed the
individual adapter and domain attributes and found it cumbersome to
mentally configure what the matrix looked like. If you think of the
lszcrypt command, it outputs the adapters and queues which is the model
I used for this.

> 2) As I said above, what you show is not the effective mask used by 
> the guest

Why would a sysfs attribute for the mediated matrix device show the 
effective
mask used by the guest?

>
>
>
>
>
