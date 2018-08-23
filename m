Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88534C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BDF20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BDF20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeHWM5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:57:25 -0400
Received: from foss.arm.com ([217.140.101.70]:43506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbeHWM5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:57:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22F3780D;
        Thu, 23 Aug 2018 02:28:35 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83A4F3F2EA;
        Thu, 23 Aug 2018 02:28:33 -0700 (PDT)
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     Tyler Baicar <tbaicar@codeaurora.org>
Cc:     Borislav Petkov <bp@alien8.de>, harba@qti.qualcomm.com,
        mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wufan@codeaurora.org
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
Date:   Thu, 23 Aug 2018 10:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

(CC: +Fan Wu)

On 19/07/18 19:36, Tyler Baicar wrote:
> On 7/19/2018 10:46 AM, James Morse wrote:
>> On 19/07/18 15:01, Borislav Petkov wrote:
>>> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
>>>> Enable per-layer error reporting for ARM systems so that the error
>>>> counters are incremented per-DIMM.

This 'layer' term seems to be EDAC's artificial view of memory.


>> I'm guessing this is the mapping between CPER records and the DMItable data.

> Unfortunately the DMI table doesn't actually have channel and DIMM number values
> which makes this more complicated than I originally thought...

>>>> information and enable per layer error reporting for ARM systems so that
>>>> the EDAC error counters are incremented based on DIMM number as per the
>>>> SMBIOS table rather than just incrementing the noinfo counters on the
>>>> memory controller.

>> Does this work on x86, and its just the dmi/cper fields have a subtle difference?

> There are CPU specific EDAC drivers for a lot of x86 folks and those drivers
> populate the layer information in a custom way.

Not for GHES surely?


> With more investigation and testing it turns out a simple patch like this is not
> going to work. This worked for
> me on a 1DPC board since the card number turned out to always be the same as the
> index into the DMI table
> to find the proper DIMM. On a 2DPC board this fails completely. The ghes_edac
> driver only sets up a single
> layer so it is only using the card number with this patch.

(DPC == DIMM per Channel?)


> So it is only setting up a single layer with all the DIMMs on that layer. In
> order to properly enable the layers
> to represent channel and DIMM number on that channel, we would need to have a
> way of determining the
> number of channels (which would be layers[0].size) and the number of DIMMs each
> channel supported
> (layers[1].size). There doesn't appear to be a way to determine that information
> at this point.

So, we're after a mapping for EDAC:layers that includes 'channel'?

What would you do with a channel counter? Isn't that part of the SoC? (it can't
be replaced!)


> The goal is to be able to enable the per layer error reporting in the ghes_edac
> driver so that the per dimm counters exposed in the EDAC sysfs nodes are properly
> updated.

What do you mean by layer? I can't find anything in the ACPI/UEFI/SMBIOS specs
that uses this term...

If its just 'per dimm counters' you're after, this looks straightforward.


> The other obvious but more messy way would be to have notifiers register to be called
> by ghes_edac and have a custom EDAC driver for each CPU to properly populate their layer
> information.

Yuck. This isn't platform specific, its firmware specific. You're hooking the
driver to say "my firmware thinks 'card' means this".

Where would this information come from? We don't want
per-soc,per-firmware-version code mangling what was supposed to be a standard
interface.

... we can't be the first people to try and do this ...

[re-ordered hunk:]
> This seems pretty hacky to me, so if anyone has other suggestions please share
> them.

CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE should provide
the information necessary to identify the failing FRU". As EDAC has three
'levels', these are what they should correspond to for ghes-edac.

I assume NODE means rack/chassis in some distributed system. Lets ignore it as
it doesn't seem to map to anything in the SMBIOS table.

The CPER record's card and module numbers are useless to us, as we need to know
how many there will be in advance. (does this version of firmware count from 0
or 1?)

... but CPER also gives us a 'Card Handle' and 'Module Handle'.
'Module Handle' maps to SMBIOS:17 Memory Device (aka, a DIMM). The Handle is a
word-value in the structure, so it doesn't depend on the layout/parse-order of
the SMBIOS tables. When we count the DIMMs in edac-ghes we can give them some
level-idx, then use the handle to find which level-idx to use for this DIMM.

ghes_edac_report_mem_error() already picks up the module-handle, but only uses
it to print the bank/device.


'Card' doesn't mean much to me, but it maps to SMBIOS:17 "Memory Array
Structure", which the Memory Device structure also points to.
Card then must mean "a collection of memory devices (DIMMs) that operate
together to form an address space".

This might be what I think of as a memory-controller, or it might be something
more complicated. Regardless, the CPER records think its relevant.

For the edac:layers, we could walk the DMI table to find these structures, and
build the layers from them. If the Memory-array-structures are missing, we can
use the existing 1:NUM_DIMMS approach.


Hope this makes sense!


Thanks,

James
