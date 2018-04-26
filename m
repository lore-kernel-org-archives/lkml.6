Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeDZRpJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:45:09 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37767 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbeDZRpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:45:05 -0400
X-Google-Smtp-Source: AIpwx4/yS+AiE9+Y6tib0QQkBZllHrjCQrX+NwcE6N9Ey8yS1mNw8l6q57zdHXBRaEam4gDjNoW/fQ==
Subject: Re: [RFC PATCH v3 2/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org,
        devel@acpica.org, austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        shyam_iyer@dell.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-3-mr.nuke.me@gmail.com>
 <20180426111946.GA15009@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <d193d219-0e2a-4a5c-b838-b5ea042bfab8@gmail.com>
Date: Thu, 26 Apr 2018 12:44:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180426111946.GA15009@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 04/26/2018 06:19 AM, Borislav Petkov wrote:
> On Wed, Apr 25, 2018 at 03:39:50PM -0500, Alexandru Gagniuc wrote:
>> @@ -932,7 +971,7 @@ static void __process_error(struct ghes *ghes)
>>   static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>   {
>>   	struct ghes *ghes;
>> -	int sev, ret = NMI_DONE;
>> +	int sev, asev, ret = NMI_DONE;
>>   
>>   	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>>   		return ret;
>> @@ -945,8 +984,9 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>   			ret = NMI_HANDLED;
>>   		}
>>   
>> +		asev = ghes_actual_severity(ghes);
>>   		sev = ghes_severity(ghes->estatus->error_severity);
> 
> So renaming ghes_deferrable_severity() to ghes_actual_severity() is not
> a big change. And that's not what I meant.

I'm sorry I misunderstood you.

> I'd like to see here:
> 
> 		 sev = ghes_severity(ghes);

		 sev = ghes_severity(ghes);


> and inside you do all the required mapping/severity processing/etc. And
> you can rename the current ghes_severity() to ghes_map_cper_severity()
> or whatever...

I agree that the current ghes_severity() name is vague. I'll get it done 
properly in v4 (next week).

>> -		if (sev >= GHES_SEV_PANIC) {
>> +		if ((sev >= GHES_SEV_PANIC) && (asev >= GHES_SEV_PANIC)) {
> 
> ... so that this change doesn't happen and there are not two severities
> queried but a single one.

Two severities is a result of the wanky GHES data structure. Nothing 
says we have to use the severity field in the header... if you're okay 
with just ignoring it.

Alex
