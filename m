Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936526AbeBUQju (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:39:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932674AbeBUQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:39:48 -0500
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org,
        geert@linux-m68k.org, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
 <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
 <6cae85dc-76d5-1b92-ab13-a5e441eb84a0@linux.vnet.ibm.com>
 <faffcd8e-4ef6-64bc-ab11-9b48ca488ed6@de.ibm.com>
 <f658ea9e-0153-a0e3-544a-8ce575284245@de.ibm.com>
 <20180221113217.11bb1c69.cohuck@redhat.com>
 <b742aa29-70b2-42e1-26d2-8ca0c8945863@de.ibm.com>
 <d1a89481-e5c9-b460-ea9c-f796dc28b748@redhat.com>
 <1f8907d4-c4a3-d41b-8834-679dcc85de4a@de.ibm.com>
 <5dfa9213-0e63-54d0-8700-1ced4efd4c28@redhat.com>
 <f6db4d0a-3578-4162-5de7-6e699f7a02c2@de.ibm.com>
 <20180221130755.17d15f89.cohuck@redhat.com>
 <6c1daae4-e1f6-5627-9023-f03d986c5639@de.ibm.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 11:39:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <6c1daae4-e1f6-5627-9023-f03d986c5639@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022116-0048-0000-0000-0000023CF49D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008570; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993029; UDB=6.00504548; IPR=6.00772374;
 MB=3.00019675; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-21 16:39:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022116-0049-0000-0000-0000443525D4
Message-Id: <2170dce6-4456-3ab6-d07c-2169d99c4173@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/21/2018 07:11 AM, Christian Borntraeger wrote:
> 
> 
> On 02/21/2018 01:07 PM, Cornelia Huck wrote:
> [...]
>>>> But if you need to enable PCI to get IOMEM, I wonder why this patch here
>>>> is needed at all? The Graphics menu / VT dummy console should be
>>>> available in the config if IOMEM is enabled anyway?
>>>
>>> That is a good question. With CONFIG_PCI=y I can select virtio-gpu and dummy-console.
>>> IIRC the issue was that with patch 3 we can have the situation where we have
>>> CONFIG_VT = y and CONFIG_DUMMY_CONSOLE=n and this will crash early during boot as
>>> conswitchp is NULL.

Yes, VT layer initializes very early in the boot process and looks for a 
console. If it can't find any it will crash. I believe that was the 
whole point of having the dummy console.

>>
>> So in practice, CONFIG_VT depends on "there's a console available, even
>> if it's only the dummy one"?
> 
> Yes. Maybe we should simple move dummy_console outside of drivers/video/console/Kconfig
> into something that is always available.
> 

I agree, but where should it go? consoles are kinda tightly tied to 
video/Graphics Support.

>>
>>> This patches goal was to always enable dummy console even without
>>> PCI, but it obviously fails to do so.
>>
This patch should enable the dummy console even without PCI but we won't 
have DRM/Virtio GPU.

>> OTOH, the dummy console really should not depend on anything, as it is
>> only doing dummy things.
>>
>>>
>>> So what about allowing CONFIG_VT on s390 only if we have PCI?
>>>
>>>
>>> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
>>> index 84810075a6a0..1c7fe09d6f90 100644
>>> --- a/drivers/tty/Kconfig
>>> +++ b/drivers/tty/Kconfig
>>> @@ -11,7 +11,7 @@ if TTY
>>>   
>>>   config VT
>>>          bool "Virtual terminal" if EXPERT
>>> -       depends on !UML
>>> +       depends on !UML && (!S390 || PCI)
>>>          select INPUT
>>>          default y
>>>          ---help---
>>>
>>
>> Would cover your use case, but feels wrong to me... config dependencies
>> aren't fun :/
>>
