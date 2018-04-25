Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754868AbeDYPBG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:01:06 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:45812 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbeDYPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:00:58 -0400
X-Google-Smtp-Source: AB8JxZoBxbnRaQ0gEm8VCyiJOQy0+1FsxpAL6MbOGr0Otnwenuit/ZgDEIq6VaGX2dIOM4wXpaT/Mg==
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
 <20180419154006.GE3600@pd.tnic>
 <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
 <20180419164528.GD5635@pd.tnic>
 <ffe6b459-c80a-d3c0-451d-0d21ae63da54@gmail.com>
 <20180419190323.GF5635@pd.tnic>
 <dba07329-2f85-2bde-85ea-5bdf26fb8df2@gmail.com>
 <20180422104849.GA32754@pd.tnic>
 <70c43399-e8e5-5061-b5a5-451deb5f02fa@gmail.com>
 <20180425140108.GA2597@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <48944beb-4e29-05cc-857b-7698e3dbe89b@gmail.com>
Date: Wed, 25 Apr 2018 10:00:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425140108.GA2597@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 09:01 AM, Borislav Petkov wrote:
> On Mon, Apr 23, 2018 at 11:19:25PM -0500, Alex G. wrote:
>> That tells you what FFS said about the error.
> 
> I betcha those status and command values have a human-readable counterparts.
> 
> Btw, what do you abbreviate with "FFS"?

Firmware-first.

>> It's immediately obvious if there's a glaring FFS bug and if we get bogus
>> data. If you distrust firmware as much as I do, then you will find great
>> value in having such info in the logs. It's probably not too useful to a
>> casual user, but then neither is a majority of the system log.
> 
> No no, you're missing the point - I *want* all data in the error log
> which helps debug a hardware issue. I just want it humanly readable so
> that I don't have to jot down the values and go scour the manuals to map
> what it actually means.

We could probably use more of the native AER print functions, but that's
beyond the scope of this patch. I tried something like this [1], but
have given up following the PCI maintainer's radio silence. I don't care
_that_ much about the log format.

[1] http://www.spinics.net/lists/linux-pci/msg71422.html

>> You're missing the timing and assuming you will get the hotplug interrupt.
>> In this example, you have 22ms between the link down and presence detect
>> state change. This is a fairly fast removal.
>>
>> Hotplug dependencies aside (you can have the kernel run without PCIe hotplug
>> support), I don't think you want to just linger in NMI for dozens of
>> milliseconds waiting for presence detect confirmation.
> 
> No, I don't mean that. I mean something like deferred processing:

Like the exact thing that this patch series implements? :)

> you
> get an error, you notice it is a device which supports physical removal
> so you exit the NMI handler and process the error in normal, process
> context which allows you to query the device and say, "Hey device, are
> you still there?"

Like the exact way the AER handler works?

> If it is not, you drop all the hw I/O errors reported for it.

Like the PCI error recovery mechanisms that AER invokes?

> Hmmm?
Hmmm
