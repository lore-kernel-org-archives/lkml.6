Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeEVSNS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:13:18 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43966 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeEVSNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:13:14 -0400
X-Google-Smtp-Source: AB8JxZoTXu/FwAp2om6HF4CC/IAp45gfpHfSHlpQxaL55RC6RkgNlbYvaUfMmbgA6IpFPTlYI2ONkg==
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, alex_gagniuc@dellteam.com,
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
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <1071d2a4-486a-e2e1-5273-1d0bbe807beb@gmail.com>
Date: Tue, 22 May 2018 13:13:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180522175742.GA3543@agluck-desk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 12:57 PM, Luck, Tony wrote:
> On Tue, May 22, 2018 at 04:54:26PM +0200, Borislav Petkov wrote:
>> I especially don't want to have the case where a PCIe error is *really*
>> fatal and then we noodle in some handlers debating about the severity
>> because it got marked as recoverable intermittently and end up causing
>> data corruption on the storage device. Here's a real no-no for ya.
> 
> All that we have is a message from the BIOS that this is a "fatal"
> error.  When did we start trusting the BIOS to give us accurate
> information?

When we merged ACPI handling.

> PCIe fatal means that the link or the device is broken. But that
> seems a poor reason to take down a large server that may have
> dozens of devices (some of them set up specifically to handle
> errors ... e.g. mirrored disks on separate controllers, or NIC
> devices that have been "bonded" together).
> 
> So, as long as the action for a "fatal" error is to mark a link
> down and offline the device, that seems a pretty reasonable course
> of action.
> 
> The argument gets a lot more marginal if you simply reset the
> link and re-enable the device to "fix" it. That might be enough,
> but I don't think the OS has enough data to make the call.

I'm not 100% satisfied with how AER handler works, and how certain 
drivers (nvme!!!) interface with AER handling. But this is an arguments 
that belongs in PCI code, and a fight I will fight with Bjorn and Keith. 
The issue we're having with Borislav and Rafael's estate is that we 
can't make it to PCI land.

I'm seeing here the same fight that I saw with firmware vs OS, where fw 
wants to have control, and OS wants to have control. I saw the same with 
ME/CSE/CSME team vs ChromeOS team, where ME team did everything possible 
to make sure only they can access the boot vector and boot the 
processor, and ChromeOS team couldn't use this approach because they 
wanted their own root of trust. I've seen this in other places as well, 
though confidentiality agreements prevent me from talking about it.

It's the issue of control, and it's a fact of life. Borislav and Rafael 
don't want to relinquish control until they can be 100% certain that 
going further will result in 100% recovery. That is a goal I aspire to 
as well, but an unachievable ideal nonetheless.

I thought the best compromise would be to be as close as possible to 
native handling. That is, if AER can't recover, we don't recover the 
device, but the machine keeps running. I think there's some deeper 
history to GHES handling, which I didn't take into consideration. The 
fight is to convince appropriate parties to share the responsibility in 
a way which doesn't kill the machine. We still have a ways to go until 
we get there.

Alex

> -Tony
> 
> P.S. I deliberately put "fatal" in quotes above because to
> quote "The Princess Bride" -- "that word, I do not think it
> means what you think it means". :-)
> 
