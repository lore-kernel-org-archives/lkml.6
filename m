Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeA3Q27 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:28:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbeA3Q2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:28:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898FC217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x225dtMrnlMPUppppy3XKajDp0V+487KfYNpJeUYrfS7PZatUJxBs9DTnRBgrqCrqQMO/DI7jyvjYY+NEIfzJ7/c=
MIME-Version: 1.0
In-Reply-To: <d009592b-ee82-7706-29ff-2749cd0e3c20@gmail.com>
References: <1517194414-19932-1-git-send-email-frowand.list@gmail.com>
 <CAMuHMdWrhgvLv6syjFxfN42ah7pkO9Ye9SJYDTCwRMQCFrJAeg@mail.gmail.com>
 <df065acc-2479-2513-ac3d-63d065d2ffa1@gmail.com> <d009592b-ee82-7706-29ff-2749cd0e3c20@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 30 Jan 2018 10:28:11 -0600
X-Gmail-Original-Message-ID: <CANk1AXRBe6dmiYRu597+BzVMFnvrTiStoEMKa9XwEK5S5FSfAg@mail.gmail.com>
Message-ID: <CANk1AXRBe6dmiYRu597+BzVMFnvrTiStoEMKa9XwEK5S5FSfAg@mail.gmail.com>
Subject: Re: [PATCH 0/2] of: change overlay apply input data from EDT to FDT
To: Frank Rowand <frowand.list@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 6:35 PM, Frank Rowand <frowand.list@gmail.com> wrote:

Hi Frank,

> Hi Alan,
>
> In this patch series one of the changes was to change some
> devicetree unittest overlay source to use the new sugar syntax to
> specify overlay nodes instead of hand coding the fragment nodes.
>
> One reviewer reminded me to update Documentation/ files that
> show the hand coding of overlay fragment nodes.  One of those
> files is Documentation/devicetree/bindings/fpga/fpga-region.txt.
> I plan to submit a patch to update the example devicetree source
> to use the sugar syntax.  There is one place where I can not
> make that change, which is the "Overlay DTS Format" section.
> In this section, the use of 'target-path="/path" is shown as
> one of two ways to specify the target of the fragment.  The
> sugar syntax creates a fragment using the 'target=<phandle>'
> form instead of 'target-path="/path"' form.  With sugar
> syntax, there is no way to specify target-path.  Is the
> target-path form needed by the fpga subsystem, or can this
> be removed?

Removing target-path won't be a loss of functionality as far as I can see.

Currently the examples in
Documentation/devicetree/bindings/fpga/fpga-region.txt all specify
'target = <phandle> while the descriptive text says that target and
target-path are both options (3 line edits are needed to remove
target-path from this file plus other edits to change it to sugar
format without __overlay__ and 'fragment@0').

Thanks for asking!

Alan

>
> -Frank
>
> On 01/29/18 16:22, Frank Rowand wrote:
>> On 01/29/18 06:08, Geert Uytterhoeven wrote:
>>> Hi Frank,
>>>
>>> On Mon, Jan 29, 2018 at 3:53 AM,  <frowand.list@gmail.com> wrote:
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
>>>> The unflattened device tree (aka expanded device tree, EDT) now
>>>> belongs to devicetree code, which is thus responsible for freeing
>>>> the EDT.
>>>>
>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>> or the EDT, which could result in use after free errors.
>>>>
>>>> These changes led to migrating some unittest overlay data into
>>>> their own devicetree source files, and then converting most of
>>>> them to use sugar syntax instead of hand coding fragments.
>>>
>>> Thanks for your series!
>>>
>>>> Frank Rowand (2):
>>>>   of: change overlay apply input data from EDT to FDT
>>>>   of: convert unittest overlay devicetree source to sugar syntax
>>>
>>> Do you plan to update Documentation/devicetree/overlay-notes.txt
>>> and Documentation/devicetree/bindings/fpga/fpga-region.txt, too?
>>
>> Thanks for the pointers.
>>
>> I will add updates to Documentation/devicetree/overlay-notes.txt in
>> this series.
>>
>> The changes to Documentation/devicetree/bindings/fpga/fpga-region.txt
>> are related to the relatively new sugar syntax in dtc, not to the
>> changes introduced by this patch series.  I'll create a patch outside
>> this series to update this documentation.
>>
>>
>>> Gr{oetje,eeting}s,
>>>
>>>                         Geert
>>>
>>> --
>>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>>
>>> In personal conversations with technical people, I call myself a hacker. But
>>> when I'm talking to journalists I just say "programmer" or something like that.
>>>                                 -- Linus Torvalds
>>>
>>
>>
>
