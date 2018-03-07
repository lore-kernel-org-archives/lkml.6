Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754841AbeCGVMP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 16:12:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCGVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 16:12:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4611D60398
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anjiandi@codeaurora.org
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
 <20180307185132.GA30102@ziepe.ca>
 <1520448953.10396.565.camel@linux.vnet.ibm.com>
 <1520449719.5558.28.camel@HansenPartnership.com>
 <1520450495.10396.587.camel@linux.vnet.ibm.com>
 <1520451662.24314.5.camel@HansenPartnership.com>
From: Jiandi An <anjiandi@codeaurora.org>
Message-ID: <d4670a63-0363-cf1c-a239-d83b01376d0c@codeaurora.org>
Date: Wed, 7 Mar 2018 15:12:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1520451662.24314.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2018 01:41 PM, James Bottomley wrote:
> On Wed, 2018-03-07 at 14:21 -0500, Mimi Zohar wrote:
>> On Wed, 2018-03-07 at 11:08 -0800, James Bottomley wrote:
>>>
>>> On Wed, 2018-03-07 at 13:55 -0500, Mimi Zohar wrote:
>>>>
>>>> On Wed, 2018-03-07 at 11:51 -0700, Jason Gunthorpe wrote:
>>>>>
>>>>>
>>>>> On Tue, Mar 06, 2018 at 11:26:26PM -0600, Jiandi An wrote:
>>>>>>
>>>>>>
>>>>>> TPM_CRB driver is the TPM support for ARM64.  If it
>>>>>> is built as module, TPM chip is registered after IMA
>>>>>> init.  tpm_pcr_read() in IMA driver would fail and
>>>>>> display the following message even though eventually
>>>>>> there is TPM chip on the system:
>>>>>>
>>>>>> ima: No TPM chip found, activating TPM-bypass! (rc=-19)
>>>>>>
>>>>>> Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
>>>>>> built in kernel and initializes before IMA driver.
>>>>>>
>>>>>> Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
>>>>>>   security/integrity/ima/Kconfig | 1 +
>>>>>>   1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/security/integrity/ima/Kconfig
>>>>>> b/security/integrity/ima/Kconfig
>>>>>> index 35ef693..6a8f677 100644
>>>>>> +++ b/security/integrity/ima/Kconfig
>>>>>> @@ -10,6 +10,7 @@ config IMA
>>>>>>   	select CRYPTO_HASH_INFO
>>>>>>   	select TCG_TPM if HAS_IOMEM && !UML
>>>>>>   	select TCG_TIS if TCG_TPM && X86
>>>
>>> Well, this explains why IMA doesn't work on one of my X86 systems:
>>> it's got a non i2c infineon TPM.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> +	select TCG_CRB if TCG_TPM && ACPI
>>>>>>   	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
>>>>>>   	help
>>>>>>   	  The Trusted Computing Group(TCG) runtime Integrity
>>>>>
>>>>> This seems really weird, why are any specific TPM drivers
>>>>> linked to IMA config, we have lots of drivers..
>>>>>
>>>>> I don't think I've ever seen this pattern in Kconfig before?
>>>>
>>>> As you've seen by the current discussions, the TPM driver needs
>>>> to be initialized prior to IMA.  Otherwise IMA goes into TPM-
>>>> bypass mode.  That implies that the TPM must be builtin to the
>>>> kernel, and not as a kernel module.
>>>
>>> Actually, that's not necessarily true:  If we don't begin appraisal
>>> until after the initrd phase, then the initrd can load TPM modules
>>> before IMA starts.
>>>
>>> This would involve a bit of code rejigging to not require a TPM
>>> until IMA wants to write its first measurement, but it looks doable
>>> and would get us out of having to second guess TPM selections.
>>
>> The question is about measurement, not appraisal.  Although the
>> initramfs might be measured, the initramfs can access files on the
>> real root filesystem.  Those files need to be measured, before they
>> are used/accessed.
> 
> Isn't it a question of threat model?  Because the initrd is measured,
> you know it's the one you specified and you should know its security
> properties, so measurement doesn't really need to begin until the root
> pivots.  At that point you pick up the boot aggregate so the log now is
> tied to the initrd measurement.  Conversely, I can't really see a
> threat model where you could trick a correctly measured initrd into
> subverting IMA, especially because listening network daemons aren't
> usually active at this stage.
> 
> I'm not saying there isn't a use case for wanting your TPM built in,
> I'm just saying I don't think it needs to be required for everyone who
> uses IMA.
> 
> James
> 

ima_init() first calls tpm_pcr_read() which tries to use underlying
registered TPM chip driver and send read PCR TPM command to the TPM
chip. If IMA driver is enabled and ima_init() happens, we see this.

In security/integrity/ima/ima_main.c, init_ima() is in late_initcall.
And it calls ima_init().

late_initcall(init_ima);  /* Start IMA after the TPM is available */

So as long as init_ima() is called, need to at least enable the
TPM driver for the platform right?

I'm just following current IMA Kconfig where it's selecting different
underlying TPM chip drivers for various platforms respectively when
CONFIG_IMA is set to Y because IMA driver init calls tpm_pcr_read()
which needs to use TPM.

-- 
Jiandi An
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
