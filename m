Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeFDWOm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 18:14:42 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46752 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeFDWOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 18:14:40 -0400
X-Google-Smtp-Source: ADUXVKIcrYD9BKD8Tr+MHCepoXoQ0ApDIPKoFk84wQ41h+3nrRX36S88FRuQuvhyGsF2+QaYYGDlsz0rttLR+nvBXm8=
MIME-Version: 1.0
In-Reply-To: <20180604213255.GF164893@dtor-ws>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
 <20180601184330.GD222005@dtor-ws> <72b7120a-d304-0b2f-d04a-473631623f72@bitmath.org>
 <CAO-hwJKibKvqviLZ5SSYR_X3yLTzJrr0G4d6svM3FtgJ6AfvQQ@mail.gmail.com>
 <20180604172759.GA164893@dtor-ws> <994e5698-fbdf-05c8-b0b6-3df6af1b3dbc@bitmath.org>
 <20180604182658.GC164893@dtor-ws> <CAO-hwJK3h8xjuO=GQRT0prdbXURCTinkQg4i7N8ScPOig1KTYw@mail.gmail.com>
 <20180604213255.GF164893@dtor-ws>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 5 Jun 2018 00:14:38 +0200
Message-ID: <CAO-hwJ+tc_nFYiGMNfnFkpGyB7P+R+fH2SnZntq7MQ1CAoSdpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Jiri Kosina <jikos@kernel.org>,
        Jason Gerecke <killertofu@gmail.com>,
        Dennis Kempin <denniskempin@google.com>,
        Andrew de los Reyes <adlr@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 11:32 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jun 04, 2018 at 10:59:16PM +0200, Benjamin Tissoires wrote:
>> On Mon, Jun 4, 2018 at 8:26 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Mon, Jun 04, 2018 at 07:55:57PM +0200, Henrik Rydberg wrote:
>> >> Hi Dmitry,
>> >>
>> >> > > > Logically, the confidence state is a property of a contact, not a new type
>> >> > > > of contact. Trying to use it in any other way is bound to lead to confusion.
>> >> > > >
>> >> > > > Problem is that MT_TOOL_PALM has been introduced in the kernel since
>> >> > > > v4.0 (late 2015 by a736775db683 "Input: add MT_TOOL_PALM").
>> >> > > > It's been used in the Synaptics RMI4 driver since and by hid-asus in late 2016.
>> >> > > > I can't find any other users in the current upstream tree, but those
>> >> > > > two are already making a precedent and changing the semantic is a
>> >> > > > little bit late :/
>> >> > I am sorry I did not respond and lost track of this issue back then, but
>> >> > I disagree with Henrik here. While confidence is a property of contact,
>> >> > so is the type of contact and it can and will change throughout life of
>> >> > a contact, especially if we will continue adding new types, such as, for
>> >> > example, thumb. In this case the firmware can transition through
>> >> > finger->thumb or finger->thumb->palm or finger->palm as the nature of
>> >> > contact becomes better understood. Still it is the same contact and we
>> >> > should not attempt to signal userspace differently.
>> >> We agree that the contact should stay the same, but the fear, and I think
>> >> somewhere along the blurry history of this thread, the problem was that
>> >> userspace interpreted the property change as a new contact (lift up/double
>> >> click/etc). Finger/thumb/palm is one set of hand properties, but what about
>> >> Pen? It would be hard for an application to consider a switch from finger to
>> >> pen as the same contact, which is where the natural implementation starts to
>> >> diverge from the intention.
>> >
>> > I think the userspace has to trust our tracking ID to decide whether it
>> > is a same contact or not. The current issue is that kernel is forcing
>> > tracking ID change on tool type change, and one of the 2 patches that I
>> > posted fixed that, allowing us to keep the tracking ID for finger->palm
>> > transitions.
>>
>> I think I missed those 2 patches, can you point a LKML link?
>
> Sorry, I thought I sent it out with the patch we are talking about here,
> but I did not. See below. Note that it doe snot have any protections on
> finger->pen transitions and I am not sure any are needed at the moment.
> We can add them wither to MT core or to drivers if we see issues with
> devices.

For what it worth, after a quick reading of the patch, it would be:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I can't remember exactly why we checked for the tool in the first place.

>
>> Also, note that libevdev discards the tracking ID change now (it
>> shouts at the user in the logs). So that means that it will now be
>> hard to force libevdev to trust the kernel again for the tracking ID.
>> The current rule is:
>> - tracking ID >= 0 -> new touch
>> - any subsequent tracking ID >= 0 -> discarded
>> - tracking ID == -1 -> end of touch
>
> Well, I guess it is like synaptics driver that used to dump core
> whenever it saw tracking ID change for the same slot (not going though
> -1 sequence). It only mattered to Synaptics PS/2 having only 2 slots and
> us having to produce weird results when users would use fancy gestures
> with 3+ fingers.
>
> It probably does not matter with devices with 5+ slots. We should pretty
> much always have free slot for new contact.

On Win 8 devices, we can safely expect the firmware to have a correct
maximum contact number information (there is no point reporting 5
fingers and saying you can support only 2). So if we try to add a new
slot and we are out of them, it's pretty much down to a firmware bug
or a touch we missed to release.

>
>>
>> >
>> > I think it is kernel task to not signal transitions that do not make
>> > sense, such as finger->pen or palm->pen etc.
>>
>> I fully agree, though there is currently no such guard in the kernel
>> (maybe it's part of your series). I am worried about the RMI4 F12
>> driver that automatically forward the info from the firmware, so if
>> the firmware does something crazy, it will be exported to user space.
>> But I guess it might be better to treat that on a per driver basis.
>
> Yeah, I think so.
>
>>
>> >
>> >>
>> >> > We could introduce the ABS_MT_CONFIDENCE (0/1 or even 0..n range), to
>> >> > complement ABS_MT_TOOL, but that would not really solve the issue with
>> >> > Wacom firmware (declaring contact non-confident and releasing it right
>> >> > away) and given MS explanation of the confidence as "contact is too big"
>> >> > MT_TOOL_PALM fits it perfectly.
>> >> Indeed, the Wacom firmware seems to need some special handling, which should
>> >> be fine by everyone. I do think it would make sense to add
>> >> ABS_MT_TOOL_TOO_BIG, or something, and use it if it exists. This would apply
>>
>> Except we are already running out of ABS_* axes.
>
> Sorry, meants MT_TOOL_TO_BIG, not a new axis.
>
>>
>> >> also to a pen lying down on a touchpad, for instance.
>> >
>> > OK, I can see that for Pens, if we have firmware that would recognize
>> > such condition, it would be weird to report PALM. We could indeed have
>> > ABS_MT_TOOL_TOO_BIG, but on the other hand it is still a pen (as long as
>> > the hardware can recognize it as such). Maybe we'd be better off just
>> > having userspace going by contact size for pens. Peter, any suggestions
>> > here?
>>
>> I don't think we have size handling in the tablet implementation in
>> libinput. I do not see it as a big issue to add such axes from a
>> libinput point of view. However, there is no existing hardware that
>> would provide such information, so I guess this will be a 'no' until
>> actual hardware comes in.
>>
>> Also note that the MT_TOOL_PEN implementation is limited (even
>> non-existant if I remember correctly). Peter and I do not have access
>> to any device that support such multi pen, so AFAICT, there is no code
>> to handle this in libinput.
>>
>> One last point from libinput, the pen device would need to be on its
>> separate kernel node for the protocol to be smoothly handled. So
>> basically, even the transition from MT_TOOL_FINGER to MT_TOOL_PEN
>> would not be handled properly right now. The Pen event will be treated
>> as a touch.
>
> I think normally pen and touch a separate controllers, so we have that
> going for us...

The problem is for devices like the N-trig DualSense or the Wacom AES
where only one sensor handles both pen and touch. For now, given that
MS says it supports only one pen we are on the safe side, but things
might gets scarier in the future :)

Cheers,
Benjamin

>
> Thanks.
>
> --
> Dmitry
>
>
> Input: do not assign new tracking ID when changing tool type
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> We allow changing tool type (from MT_TOOL_FINGER to MT_TOOL_PALM) so we
> should not be forcing new tracking ID for the slot.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/input-mt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index a1bbec9cda8d4..7ca4b318ed419 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -151,7 +151,7 @@ void input_mt_report_slot_state(struct input_dev *dev,
>         }
>
>         id = input_mt_get_value(slot, ABS_MT_TRACKING_ID);
> -       if (id < 0 || input_mt_get_value(slot, ABS_MT_TOOL_TYPE) != tool_type)
> +       if (id < 0)
>                 id = input_mt_new_trkid(mt);
>
>         input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, id);
>
