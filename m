Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZozrYwlDh2ghsQTRhSY+0gjXTEGHjBk7j5xzigWKPDDvpUwF2C/BY/Cu9wTlfgnp46wREH6
ARC-Seal: i=1; a=rsa-sha256; t=1524769022; cv=none;
        d=google.com; s=arc-20160816;
        b=fg5U8uL9Kdll2q5pf6cmYsol1W9t0eTAjUPG6RQeXcmB6dsnqpuEcyxFDMOze3E6dn
         F1iVC2zjwbse/nEPDPcbuO2ghhneAxuFwraZUIATxIdrMCDTC0rvu1MzndHBsR2HhF4/
         usuqEkiwuuSF/o84C1pG0/5QCe/wUlNNnWt3aj1qh8gpt0FOp6A1q5yZtdfoO2/amBbh
         cPzxT/1u/b/FfVKBJBxMTdAwZrwc3s81RwNmW1fHF+5xipz7SFf97hQNNGl1TudtIXNo
         y1nO5S1xEvcPoXSuV0P8ewTSI8BLfNraApTZK+GD0Rh+Nm3PfDddxLsVWNEXdEuc52fs
         rDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=E8sxLujtOT7mY5WHMTtKHW4oZd3ICXHzRAX6HqemPP4=;
        b=JE81R6buPv5L37PXZYZVSjwmtGyRYIGV9jIBUT41mEcBzqX9Fc50PoIc2quOfIbcr3
         uiNxid0Uqh5ycYI+lCd3couAWZj4winh9SU9K0ijYrkkXSq3kbpUMMKPUOr4LaaaEoHb
         RxWqF033ZqklsU+unzphbyewdX0CCNuKCYAgs4h6GLwZNlnC4sLGOBQbH044/RjWAKSP
         v2QwU5KNejwfe06CLY4I63+l19lbIgdjN0ZTuirYM0MJW7bz1ccPgnn0IbX/KH3s+xiL
         5tO/CiUXaXvWC3pVv/Dr7e2rtYKLreHv31yKB55k16YHRiKuXbJ3AuewYDO9E8F9os4t
         pT8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v8 07/13] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 ard.biesheuvel@linaro.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-8-jeremy.linton@arm.com>
 <c3306746-aacd-5ed8-95d6-a3186ec2089f@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <48bd3299-a95a-8aa6-524d-b3aa01dd9ef2@arm.com>
Date: Thu, 26 Apr 2018 13:57:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <c3306746-aacd-5ed8-95d6-a3186ec2089f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766321415119595?=
X-GMAIL-MSGID: =?utf-8?q?1598836203001449810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 04/26/2018 06:05 AM, Sudeep Holla wrote:
> 
> 
> On 26/04/18 00:31, Jeremy Linton wrote:
>> Call ACPI cache parsing routines from base cacheinfo code if ACPI
>> is enable. Also stub out cache_setup_acpi() so that individual
>> architectures can enable ACPI topology parsing.
>>
> 
> [...]
> 
>> +#ifndef CONFIG_ACPI
>> +static inline int acpi_find_last_cache_level(unsigned int cpu)
>> +{
>> +	/* ACPI kernels should be built with PPTT support */
> 
> This sounds incorrect for x86. But I understand why you have it there.
> Does it makes sense to change above to .. ?
> 
> #if !defined(CONFIG_ACPI) || (defined(CONFIG_ACPI) && !(CONFIG_ACPI_PPTT))
> 
I'm not sure what that buys us, if anything you want more non-users of 
the function to be falling through to the function prototype rather than 
the static inline. The only place any of this matters (as long as the 
compiler/linker is tossing the static inline) is arm64 because its the 
only arch making a call to acpi_find_last_cache_level(). ACPI_PPTT is 
also only visible on arm64 at the moment due to being wrapped in a if 
ARM64 in the Kconfig

Put another way, I wouldn't expect an arch to have a 'user' visible 
option to enable/disable parsing the PPTT. If an arch can handle 
ACPI/PPTT topology then I would expect it to be fixed to the CONFIG_ACPI 
state. What happens when acpi_find_last_cache_level() is called should 
only be dependent on whether ACPI is enabled, the PPTT parser itself 
will handle the cases of a missing table.
