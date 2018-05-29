Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936836AbeE2PGw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:06:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33000 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935282AbeE2PGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:06:36 -0400
X-Google-Smtp-Source: ADUXVKI8DnldwNYBC18DWnCgjbuQzjSPfJe9Keiyvt5kU0xk5XoJDNOiYHOYInuKfs8fwxTX++ze3oJhXzvovNU76Tk=
MIME-Version: 1.0
In-Reply-To: <a6f0601c-fd8b-2a16-6f66-77f350f114b5@butterbrot.org>
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com> <a6f0601c-fd8b-2a16-6f66-77f350f114b5@butterbrot.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 29 May 2018 17:06:34 +0200
Message-ID: <CAO-hwJJb54s14htqbaX-+LdPQpuFNa+Vf-fmw+ZJWkrTDZMN+g@mail.gmail.com>
Subject: Re: [PATCH 0/9] Hid multitouch rewrite, support os system multi-axis devices
To: Florian Echtler <floe@butterbrot.org>
Cc: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, May 29, 2018 at 12:38 PM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello Benjamin,
>
> I have a side question about your patchset: for the SUR40 touchscreen, we had a
> discussion a while ago about how to support the different object types which the
> firmware can detect (plain touch contact, printed token with ID, generic blob
> outline).

Plain touch contact should already be reported by MT_TOOL_FINGER.
Printed token with ID seems challenging as even if it is a different
tool (not a finger) I am not sure we can convey which ID is which.
And generic blob is even worse because we need a tracking ID that
would regroup the various touch points, and it doesn't reflect a
particular tool.

> Would the pass-through for the tool type allow us to differentiate
> those, once we define suitable tool types for each object class?

I am honestly puzzled by this and can't do much for you here. Could
you please re-tell us the specific use cases, so we can think about
the solutions?

Cheers,
Benjamin

>
> Thanks & best regards, Florian
>
> On 29.05.2018 11:57, Benjamin Tissoires wrote:
>> Hi Jiri,
>>
>> this heavy rewrite of hid-multitouch serves two main purposes:
>> - the first point is to enable the support of the Totem on the Dell Canvas 27.
>>   This new type of devices (System Multi Axis) is used by Microsoft to show
>>   a new circular menu that is used by the second hand while you interact with
>>   your preferred hand with your tool.
>>   I couldn't enable it before because hid-multitouch expected to have only one
>>   multitouch collection, and this device is exported as a separate multitouch
>>   collextion in the same HID device than the one containing the touch sensor.
>>
>> - the second point is to streamline the process of the multitouch events. We
>>   used to temporary store the events in a struct as they come in, and then do
>>   the processing on the cache we just made. When doing the processing was also
>>   not very clear. This made that even if hid-multitouch should IMO be merged in
>>   hid-core, we couldn't.
>>
>>   The new processing of the events here adds a preparsing of the report in
>>   one HID collection (application usage), and from now on, the processing
>>   of the report is cleaner IMO. I still haven't merged hid-mt into hid-core,
>>   because even if I wrote a bunch of unit tests trying to not break any devices,
>>   we are not protected from a weird thing that magically happened before but is
>>   now broken.
>>
>> I must say that when I worked on the tests, I came to realise that some legacy
>> Win7 devices were better handled now. Initially I thought my new code broke them
>> but comparing the outputs from https://github.com/bentiss/hid-devices before
>> and after the changes, the new changes are closer to what I would expect by
>> looking at the raw HID events.
>>
>> I also included 2 patches to enable the Surface Dial. It's a BLE device similar
>> to the Totem from Dell, except that you can buy it for roughly $80 instead of
>> $1800 for the Canvas.
>>
>>
>> Dmitry, 2 patches are of interest for you:
>> - 1/9 Input: mt - export MT_TOOL in input_mt_init_slot()
>> - 7/9 HID: input: enable Totem on the Dell Canvas 27
>>
>> The second one exports a new MT_TOOL. In theory, I think patch 1/9 could be
>> carried through your tree but it'll be better to have the full series applied
>> at once.
>>
>> Cheers,
>> Benjamin
>>
>> Benjamin Tissoires (9):
>>   Input: mt - export MT_TOOL in input_mt_init_slot()
>>   HID: multitouch: make sure the static list of class is not changed
>>   HID: multitouch: Store per collection multitouch data
>>   HID: multitouch: store a per application quirks value
>>   HID: multitouch: ditch mt_report_id
>>   HID: multitouch: remove one copy of values
>>   HID: input: enable Totem on the Dell Canvas 27
>>   HID: core: do not upper bound the collection stack
>>   HID: microsoft: support the Surface Dial
>>
>>  drivers/hid/hid-core.c                   |  17 +-
>>  drivers/hid/hid-input.c                  |   3 +
>>  drivers/hid/hid-microsoft.c              |  49 +-
>>  drivers/hid/hid-multitouch.c             | 941 ++++++++++++++++++-------------
>>  drivers/input/input-mt.c                 |   1 +
>>  drivers/input/rmi4/rmi_2d_sensor.c       |   2 -
>>  drivers/input/touchscreen/atmel_mxt_ts.c |   2 -
>>  drivers/input/touchscreen/hideep.c       |   2 -
>>  drivers/input/touchscreen/wacom_w8001.c  |   2 -
>>  include/linux/hid.h                      |  15 +-
>>  include/uapi/linux/input.h               |   3 +-
>>  11 files changed, 616 insertions(+), 421 deletions(-)
>>
>
>
> --
> SENT FROM MY DEC VT50 TERMINAL
>
