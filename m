Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeEKPyO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:54:14 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37295 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEKPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:54:12 -0400
X-Google-Smtp-Source: AB8JxZoh0WxXFOJmHDuCn2wEtIBbp/IFZLBDZgZt8wNswhiGRW8+18J4egqvGnqxYE2ZXTC9JTWz2w==
Subject: Re: [RFC PATCH v4 3/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
To: Borislav Petkov <bp@alien8.de>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-3-mr.nuke.me@gmail.com> <20180511154039.GD12705@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <8e3c0cc6-9c5c-85ce-650c-8f498f5907da@gmail.com>
Date: Fri, 11 May 2018 10:54:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180511154039.GD12705@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2018 10:40 AM, Borislav Petkov wrote:
> On Mon, Apr 30, 2018 at 04:33:52PM -0500, Alexandru Gagniuc wrote:
>> The policy was to panic() when GHES said that an error is "Fatal".
>> This logic is wrong for several reasons, as it doesn't take into
>> account what caused the error.
>>
>> PCIe fatal errors indicate that the link to a device is either
>> unstable or unusable. They don't indicate that the machine is on fire,
>> and they are not severe enough that we need to panic(). Instead of
>> relying on crackmonkey firmware, evaluate the error severity based on
> 	     ^^^^^^^^^^^^
> 
> Please keep the smartass formulations for the ML only and do not let
> them leak into commit messages.

You're right. The monkeys are not crack. Instead, what a lot of
manufacturers do is maintain large monkey farms with electronic
typewriters. Given a sufficiently large farm, they take those results
which compile. Of those results, they pick and ship the one that takes
longest to boot, without the customers complaining.

That being clarified, should I replace "crackmonkey" with "broken" in
the commit message?

(snip)

>> +/* PCIe errors should not cause a panic. */
>> +static int ghes_sec_pcie_severity(struct acpi_hest_generic_data *gdata)
>> +{
>> +	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>> +
>> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
>> +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO &&
>> +	    IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER))
> 
> How is PCIe error severity dependent on whether the AER error reporting
> driver is enabled (and possibly not even loaded) on the system?

Borislav, I sense some confusion. AER is not a "reporting" driver. It
handles the errors. You can't leave these errors unhandled. They
propagate to the root complex and can cause fatal MCEs when not handled.
The window to handle the error is pretty large, so it's not a concern
when you're handling it.

Alex

>> +		return CPER_SEV_RECOVERABLE;
>> +
>> +	return ghes_cper_severity(gdata->error_severity);
>> +}
>> +/*
> 
