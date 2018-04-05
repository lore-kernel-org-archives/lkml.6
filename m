Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeDET2i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:28:38 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:44459 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeDET2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:28:36 -0400
X-Google-Smtp-Source: AIpwx49FS7fco7DxVWzjopg6GXmKBB6uhZ8ARZdC5GwwwnMN8MRpl6FAOOKVX7hpCT7OOxgvxo5PBQ==
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Jan Kiszka <jan.kiszka@web.de>, Rob Herring <robh+dt@kernel.org>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
 <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
Date: Thu, 5 Apr 2018 12:28:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 12:13, Jan Kiszka wrote:
> On 2018-04-05 20:59, Frank Rowand wrote:
>> Hi Jan,
>>
>> On 04/04/18 15:35, Jan Kiszka wrote:
>>> Hi Frank,
>>>
>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>> (FDT) into the overlay application code.  To accomplish this,
>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>
>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>> original FDT.
>>>>
>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>> thus responsible for freeing the unflattened devicetree.
>>>>
>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>> or the unflattened devicetree, which could result in use after free
>>>> errors.
>>>>
>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>> overlay loader.
>>>
>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>> device during hypervisor activation with Linux. The DT overlay is
>>> created from a a template but modified prior to application to account
>>> for runtime-specific parameters. See [1] for the current implementation.
>>>
>>> I'm now wondering how to model that scenario best with the new API.
>>> Given that the loader lost ownership of the unflattened tree but the
>>> modification API exist only for the that DT state, I'm not yet seeing a
>>> clear solution. Should we apply the template in disabled form (status =
>>> "disabled"), modify it, and then activate it while it is already applied?
>>
>> Thank you for the pointer to the driver - that makes it much easier to
>> understand the use case and consider solutions.
>>
>> If you can make the changes directly on the FDT instead of on the
>> expanded devicetree, then you could move to the new API.
> 
> Are there some examples/references on how to edit FDTs in-place in the
> kernel? I'd like to avoid writing the n-th FDT parser/generator.

I don't know of any existing in-kernel edits of the FDT (but they might
exist).  The functions to access an FDT are in libfdt, which is in
scripts/dtc/libfdt/.


>>
>> Looking at the driver, I see one potential issue with that approach.
>> The property "interrupt-map" is added directly to the changeset
>> instead of being an existing property in the overlay.  Is it possible
>> to have this property in the overlay when needed?
> 
> Well, the size of that property has a runtime dependency on the gic's
> #address-cells. If that is easy to account for depends a bit on the
> available FDT manipulation services. Or it would take multiple templates
> to handle the different cases (0, 1, or 2 IIRC).

If I understand create_vpci_of_overlay() correctly, it is assuming a
fixed size of 4 cells.  Line 314 is: for (n = 0, cell = 0; n < 4; n++) {

Off the top of my head, it is theoretically possible to create a property
that can contain the largest possible size for the property, then shrink
the size by inserting NOPs at the end of the property to shrink it.


>>
>> I'll also reply to other comments in this thread.
> 
> TIA!
> 
> Jan
> 
