Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeEVSTl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:19:41 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:40204 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEVSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:19:37 -0400
X-Google-Smtp-Source: AB8JxZoooFGB8dxVvin20JB83Qv193mWMf+jhxna72DeKMjebClduy8BilC4xrztSvNedgE/EPniKA==
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
 <20180522145426.GG5512@pd.tnic> <20180522175742.GA3543@agluck-desk>
 <CAJZ5v0j1E-kg3RPcasSJn=uZj9uaZcL4Zw9tp4mJgnsbWcPWbw@mail.gmail.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <5dc58180-d3c0-a9f0-282f-4be433c94052@gmail.com>
Date: Tue, 22 May 2018 13:19:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j1E-kg3RPcasSJn=uZj9uaZcL4Zw9tp4mJgnsbWcPWbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 01:10 PM, Rafael J. Wysocki wrote:
> On Tue, May 22, 2018 at 7:57 PM, Luck, Tony <tony.luck@intel.com> wrote:
>> On Tue, May 22, 2018 at 04:54:26PM +0200, Borislav Petkov wrote:
>>> I especially don't want to have the case where a PCIe error is *really*
>>> fatal and then we noodle in some handlers debating about the severity
>>> because it got marked as recoverable intermittently and end up causing
>>> data corruption on the storage device. Here's a real no-no for ya.
>>
>> All that we have is a message from the BIOS that this is a "fatal"
>> error.  When did we start trusting the BIOS to give us accurate
>> information?
> 
> Some time ago, actually.
> 
> This is about changing the existing behavior which has been to treat
> "fatal" errors reported by the BIOS as good enough reasons for a panic
> for quite a while AFAICS.

Yes, you are correct. I'd actually like to go deeper, and remove the 
policy to panic() on fatal errors. Now whether we blacklist or whitelist 
which errors can go through is up for debate, but the current policy 
seems broken.

>> PCIe fatal means that the link or the device is broken.
> 
> And that may really mean that the component in question is on fire.
> We just don't know.

Should there be a physical fire, we have much bigger issues. At the same 
time, we could retrain the link, call the driver, and release freon gas 
to put out the fire. That's something we don't currently have the option 
to do.

>> But that seems a poor reason to take down a large server that may have
>> dozens of devices (some of them set up specifically to handle
>> errors ... e.g. mirrored disks on separate controllers, or NIC
>> devices that have been "bonded" together).
>>
>> So, as long as the action for a "fatal" error is to mark a link
>> down and offline the device, that seems a pretty reasonable course
>> of action.
>>
>> The argument gets a lot more marginal if you simply reset the
>> link and re-enable the device to "fix" it. That might be enough,
>> but I don't think the OS has enough data to make the call.
> 
> Again, that's about changing the existing behavior or the existing policy even.
> 
> What exactly has changed to make us consider this now?

Firmware started passing "fatal" GHES headers with the explicit intent 
of crashing an OS. At the same time, we've learnt how to handle these 
errors in a number of cases. With DPC (coming soon to firmware-first) 
the error is contained, and a non-issue.

As specs and hardware implementations evolve, we have to adapt. I'm here 
until November, and one of my goals is to involve linux upstream in the 
development of these features so that when the hardware hits the market, 
we're ready. That does mean we have to drop some of the silly things 
we're doing.

Alex

> Thanks,
> Rafael
> 
