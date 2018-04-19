Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbeDSWzP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:55:15 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:44097 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753792AbeDSWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:55:11 -0400
X-Google-Smtp-Source: AIpwx48oz+nNH0quBqtaGWagvT7ztQzt3s3dR28x4OxAajOZq4fpAYLyn+k11nw6XISKh+IdsASjSw==
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-4-mr.nuke.me@gmail.com> <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
 <20180419154006.GE3600@pd.tnic>
 <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
 <20180419164528.GD5635@pd.tnic>
 <ffe6b459-c80a-d3c0-451d-0d21ae63da54@gmail.com>
 <20180419190323.GF5635@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <dba07329-2f85-2bde-85ea-5bdf26fb8df2@gmail.com>
Date: Thu, 19 Apr 2018 17:55:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180419190323.GF5635@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/19/2018 02:03 PM, Borislav Petkov wrote:
> (snip useful explanation).
> 
> On Thu, Apr 19, 2018 at 12:40:54PM -0500, Alex G. wrote:
>> On the r740xd, FW just hides those errors from the OS with no further
>> notification. On this machine BIOS sets things up such that non-posted
>> requests report fatal (PCIe) errors. FW still tries very hard to hide
>> this from the OS, and I think the heuristic is that if the drive
>> physical presence is gone, don't even report the error.
> 
> Ok, second question: can you detect from the error signatures alone that
> it was a surprise removal? 

I suppose you could make some inference, given the timing of other
events going on around the the crash. It's not uncommon to see a "Card
not present" event around drive removal.

Since the presence detect pin breaks last, you might not get that
interrupt for a long while. In that case it's much harder to determine
if you're seeing a SURPRISE!!! removal or some other fault.

I don't think you can use GHES alone to determine the nature of the
event. There is not a 1:1 mapping from the set of things going wrong to
the set of PCIe errors.

> How does such an error look like, in detail?

It's green on the soft side, with lots of red accents, as well as some
textured white shades:

[   51.414616] pciehp 0000:b0:06.0:pcie204: Slot(176): Link Down
[   51.414634] pciehp 0000:b0:05.0:pcie204: Slot(179): Link Down
[   52.703343] FIRMWARE BUG: Firmware sent fatal error that we were able
to correct
[   52.703345] BROKEN FIRMWARE: Complain to your hardware vendor
[   52.703347] {1}[Hardware Error]: Hardware error from APEI Generic
Hardware Error Source: 1
[   52.703358] pciehp 0000:b0:06.0:pcie204: Slot(176): Link Up
[   52.711616] {1}[Hardware Error]: event severity: fatal
[   52.716754] {1}[Hardware Error]:  Error 0, type: fatal
[   52.721891] {1}[Hardware Error]:   section_type: PCIe error
[   52.727463] {1}[Hardware Error]:   port_type: 6, downstream switch port
[   52.734075] {1}[Hardware Error]:   version: 3.0
[   52.738607] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
[   52.744786] {1}[Hardware Error]:   device_id: 0000:b0:06.0
[   52.750271] {1}[Hardware Error]:   slot: 4
[   52.754371] {1}[Hardware Error]:   secondary_bus: 0xb3
[   52.759509] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x9733
[   52.766123] {1}[Hardware Error]:   class_code: 000406
[   52.771182] {1}[Hardware Error]:   bridge: secondary_status: 0x0000,
control: 0x0003
[   52.779038] pcieport 0000:b0:06.0: aer_status: 0x00100000, aer_mask:
0x01a10000
[   52.782303] nvme0n1: detected capacity change from 3200631791616 to 0
[   52.786348] pcieport 0000:b0:06.0:    [20] Unsupported Request
[   52.786349] pcieport 0000:b0:06.0: aer_layer=Transaction Layer,
aer_agent=Requester ID
[   52.786350] pcieport 0000:b0:06.0: aer_uncor_severity: 0x004eb030
[   52.786352] pcieport 0000:b0:06.0:   TLP Header: 40000001 0000020f
e12023bc 01000000
[   52.786357] pcieport 0000:b0:06.0: broadcast error_detected message
[   52.883895] pci 0000:b3:00.0: device has no driver
[   52.883976] pciehp 0000:b0:06.0:pcie204: Slot(176): Link Down
[   52.884184] pciehp 0000:b0:06.0:pcie204: Slot(176): Link Down event
queued; currently getting powered on
[   52.967175] pciehp 0000:b0:06.0:pcie204: Slot(176): Link Up


> Got error logs somewhere to dump?

Sure [1]. They have the ANSI sequences, so you might want to wget and
grep them in a color terminal.

Alex

[1] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180416-1919.log
