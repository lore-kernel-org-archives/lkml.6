Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEDXdI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:33:08 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34711 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeEDXdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:33:05 -0400
X-Google-Smtp-Source: AB8JxZptsGYUrtUqnTCWY/IO0PRG6+HG/1vAsqOzhQ/jVfnHhlsySEoQEoJ8joFjcfDquC08pvbfxA==
Subject: Re: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
To: Shiju Jose <shiju.jose@huawei.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        gengdongjiu <gengdongjiu@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-2-mr.nuke.me@gmail.com>
 <86258A5CC0A3704780874CF6004BA8A64EE2C974@FRAEML521-MBX.china.huawei.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <796c5f59-ec98-0fca-a9de-012057506843@gmail.com>
Date: Fri, 4 May 2018 18:33:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A64EE2C974@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2018 06:56 AM, Shiju Jose wrote:
> Hi Alex,

Hi

>> -----Original Message-----
>> From: Alexandru Gagniuc [mailto:mr.nuke.me@gmail.com]

[snip]

>> -static inline int ghes_severity(int severity)
>> +static inline int ghes_cper_severity(int severity)
> 
> [...]
>>   	else
>>   		ratelimit = &ratelimit_uncorrected;
>> @@ -705,9 +705,8 @@ static int ghes_proc(struct ghes *ghes)
>>   	if (rc)
>>   		goto out;
>>
>> -	if (ghes_severity(ghes->estatus->error_severity) >=
>> GHES_SEV_PANIC) {
>> +	if (ghes_cper_severity(ghes->estatus->error_severity) >=
>> GHES_SEV_PANIC)
>>   		__ghes_panic(ghes);
> 
> PCIe AER fatal errors result panic here.
> I think ghes_cper_severity to be replaced with ghes_severity in the ghes_proc function as well in the patch
> "acpi: apei: Do not panic() on PCIe errors reported through GHES"?

Hmm.
ghes_proc calls ghes_do_proc, which is not irq safe. So the entire 
concern we had in v1 about deferring to a less restrictive context is 
moot in this case.

ghes_proc is related, but a little beyond the scope of this series. I'd 
love to fix all cases, but I'd prefer someone who has specific interests 
take ownership of changing ghes_proc.

Alex
