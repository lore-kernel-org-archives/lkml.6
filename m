Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeEVOdB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:33:01 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41059 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeEVOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:32:58 -0400
X-Google-Smtp-Source: AB8JxZrt32PZzjOcdrIE9VCXDw5YBayCD2IZJxP17j+tcvd0ZhQsPPFtU80Q0G8/9DvCjIuX+26Tag==
Subject: Re: [PATCH v6 2/2] acpi: apei: Do not panic() on PCIe errors reported
 through GHES
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-3-mr.nuke.me@gmail.com>
 <CAJZ5v0h+U1zNK+LdOH_pU7kb+c6VK7erZCRqaV2WauDE2cwc6w@mail.gmail.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <5a72a503-e8d5-c317-89b4-86e574c48064@gmail.com>
Date: Tue, 22 May 2018 09:32:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h+U1zNK+LdOH_pU7kb+c6VK7erZCRqaV2WauDE2cwc6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 04:02 AM, Rafael J. Wysocki wrote:
> On Mon, May 21, 2018 at 3:49 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>> The policy was to panic() when GHES said that an error is "Fatal".
>> This logic is wrong for several reasons, as it doesn't account for the
>> cause of the error.
>>
>> PCIe fatal errors indicate that the link to a device is either
>> unstable or unusable. They don't indicate that the machine is on fire,
> 
> But they very well may indicate just that AFAICS.

I guess it's possible to set a machine on fire, and get a PCIe error as
one of the links melts. Although in that case, I doubt how we try to
handle the error makes a difference. Sarcasm aside, my point is that it
makes little sense to crash a machine when we lose a PCIe link.


>> and they are not severe enough to justify a panic(). Do not blindly
>> rely on firmware to evaluate the severity for us. Instead, look at
>> the error severity based on what caused the error (GHES subsections).
> 
> Which bit also comes from the firmware, right?  So why is it regarded
> as a better source of information?

It's less bad (not using 'better') because it relates more closely to
the error than the specific mechanism through which it is reported. The
header severity is an artificial concept that firmware has to make up,
whereas the subsection severity usually comes directly from hardware.

> Or are you trying to say that both of the pieces of information in
> question should be consistent with each other?  But if they aren't,
> which one should we trust more and why?

The header severity is letting someone else make the decisions for you.

(snip)
>> +/* PCIe errors should not cause a panic. */
> 
> This comment is not sufficient and it should go inside of the function.

What would make a "sufficient" comment?

>> +static int ghes_sec_pcie_severity(struct acpi_hest_generic_data *gdata)
>> +{
>> +       struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>> +
>> +       if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
>> +           pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO &&
>> +           IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER))
>> +               return GHES_SEV_RECOVERABLE;
> 
> You have not explained convincingly enough why the above condition
> makes sense at all.

Is this a test? I think it's self-explanatory:
How can you invoke a handler when you don't have a source for the error?
Or how can you invoke a handler when you don't have that handler?

>> +
>> +       return ghes_cper_severity(gdata->error_severity);
>> +}
>> +
>> +/*
>> + * The severity field in the status block is an unreliable metric for the
>> + * severity. A more reliable way is to look at each subsection and see how safe
>> + * it is to call the approproate error handler.
>> + * We're not conerned with handling the error. We're concerned with being able
>> + * to notify an error handler by crossing the NMI/IRQ boundary, being able to
>> + * schedule_work, and so forth.
>> + *   - SEC_PCIE: All PCIe errors can be handled by AER.
> 
> Make this comment a proper kerneldoc or move it inside of the function.

I don't like moving long comments inside a function, as it breaks code
flow. Above-function explanation is also consistent with how
ghes_handle_aer() is documented.

Rafael, thank you very much for taking the time to review these patches.
Although, after reading through your emails, I'm at a loss on how you
want to to solve the problem. It appears everyone has a very strong and
different opinion how to proceed.

I think the biggest problem is having a policy to panic on "fatal"
errors, instead of letting the error handler make that decision. I'd
much rather kill that stupid policy, but people seem to like it for some
reason.

Alex
