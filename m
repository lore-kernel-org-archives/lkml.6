Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeFAJb0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:31:26 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35741 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFAJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:31:20 -0400
X-Google-Smtp-Source: ADUXVKKHSfg0Xryw3Hl9i4m6q0H+y5LOKluRjRGBb8wv4x9LkXu4rosWTnTr4tsw17+LVRYB+xSOvdeFba+a9WaClic=
MIME-Version: 1.0
In-Reply-To: <20180530231208.GA19976@jelly>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com> <20180530231208.GA19976@jelly>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 1 Jun 2018 11:31:19 +0200
Message-ID: <CAO-hwJ+ySgHfFRmWBRALL+p64VN_+ox5VALbKOQxRUdJgommMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
        Jason Gerecke <killertofu@gmail.com>,
        Dennis Kempin <denniskempin@google.com>,
        Andrew de los Reyes <adlr@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 1:12 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> Hi Dmitry,
>
> On Thu, Aug 10, 2017 at 05:44:59PM -0700, Dmitry Torokhov wrote:
>> According to Microsoft specification [1] for Precision Touchpads (and
>> Touchscreens) the devices use "confidence" reports to signal accidental
>> touches, or contacts that are "too large to be a finger". Instead of
>> simply marking contact inactive in this case (which causes issues if
>> contact was originally proper and we lost confidence in it later, as
>> this results in accidental clicks, drags, etc), let's report such
>> contacts as MT_TOOL_PALM and let userspace decide what to do.
>> Additionally, let's report contact size for such touches as maximum
>> allowed for major/minor, which should help userspace that is not yet
>> aware of MT_TOOL_PALM to still perform palm rejection.
>>
>> An additional complication, is that some firmwares do not report
>> non-confident touches as active. To cope with this we delay release of
>> such contact (i.e. if contact was active we first report it as still
>> active MT+TOOL_PALM and then synthesize the release event in a separate
>> frame).
>>
>> [1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> This one popped up again in a bug report [1] and it looks like it never
> got merged. fwiw, libinput does support ABS_MT_TOOL_PALM for touchpads as of
> 1.8.0 and just releasing the touch causes fake taps. So you have the green
> light from me to merge this :)
>
> Cheers,
>    Peter
>
> [1] https://bugs.freedesktop.org/show_bug.cgi?id=106716

I can probably integrate this one in the hid-multitouch revamp I am
making, to avoid other the pain of rebasing.

Cheers,
Benjamin

>
>> ---
>>  drivers/hid/hid-multitouch.c | 86 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 77 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index 440b999304a5..c28defe50a10 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -114,6 +114,8 @@ struct mt_device {
>>       struct timer_list release_timer;        /* to release sticky fingers */
>>       struct mt_fields *fields;       /* temporary placeholder for storing the
>>                                          multitouch fields */
>> +     unsigned long *pending_palm_slots; /* slots where we reported palm
>> +                                             and need to release */
>>       unsigned long mt_io_flags;      /* mt flags (MT_IO_FLAGS_*) */
>>       int cc_index;   /* contact count field index in the report */
>>       int cc_value_index;     /* contact count value index in the field */
>> @@ -543,8 +545,12 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>>               case HID_DG_CONFIDENCE:
>>                       if ((cls->name == MT_CLS_WIN_8 ||
>>                               cls->name == MT_CLS_WIN_8_DUAL) &&
>> -                             field->application == HID_DG_TOUCHPAD)
>> +                         field->application == HID_DG_TOUCHPAD) {
>>                               cls->quirks |= MT_QUIRK_CONFIDENCE;
>> +                             input_set_abs_params(hi->input,
>> +                                     ABS_MT_TOOL_TYPE,
>> +                                     MT_TOOL_FINGER, MT_TOOL_PALM, 0, 0);
>> +                     }
>>                       mt_store_field(usage, td, hi);
>>                       return 1;
>>               case HID_DG_TIPSWITCH:
>> @@ -657,6 +663,7 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>>
>>       if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
>>               int active;
>> +             int tool;
>>               int slotnum = mt_compute_slot(td, input);
>>               struct mt_slot *s = &td->curdata;
>>               struct input_mt *mt = input->mt;
>> @@ -671,24 +678,56 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>>                               return;
>>               }
>>
>> +             active = s->touch_state || s->inrange_state;
>> +
>>               if (!(td->mtclass.quirks & MT_QUIRK_CONFIDENCE))
>>                       s->confidence_state = 1;
>> -             active = (s->touch_state || s->inrange_state) &&
>> -                                                     s->confidence_state;
>> +
>> +             if (likely(s->confidence_state)) {
>> +                     tool = MT_TOOL_FINGER;
>> +             } else {
>> +                     tool = MT_TOOL_PALM;
>> +                     if (!active &&
>> +                         input_mt_is_active(&mt->slots[slotnum])) {
>> +                             /*
>> +                              * The non-confidence was reported for
>> +                              * previously valid contact that is also no
>> +                              * longer valid. We can't simply report
>> +                              * lift-off as userspace will not be aware
>> +                              * of non-confidence, so we need to split
>> +                              * it into 2 events: active MT_TOOL_PALM
>> +                              * and a separate liftoff.
>> +                              */
>> +                             active = true;
>> +                             set_bit(slotnum, td->pending_palm_slots);
>> +                     }
>> +             }
>>
>>               input_mt_slot(input, slotnum);
>> -             input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
>> +             input_mt_report_slot_state(input, tool, active);
>>               if (active) {
>>                       /* this finger is in proximity of the sensor */
>>                       int wide = (s->w > s->h);
>>                       int major = max(s->w, s->h);
>>                       int minor = min(s->w, s->h);
>>
>> -                     /*
>> -                      * divided by two to match visual scale of touch
>> -                      * for devices with this quirk
>> -                      */
>> -                     if (td->mtclass.quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
>> +                     if (unlikely(!s->confidence_state)) {
>> +                             /*
>> +                              * When reporting palm, set contact to maximum
>> +                              * size to help userspace that does not
>> +                              * recognize MT_TOOL_PALM to reject contacts
>> +                              * that are too large.
>> +                              */
>> +                             major = input_abs_get_max(input,
>> +                                                       ABS_MT_TOUCH_MAJOR);
>> +                             minor = input_abs_get_max(input,
>> +                                                       ABS_MT_TOUCH_MINOR);
>> +                     } else if (td->mtclass.quirks &
>> +                                     MT_QUIRK_TOUCH_SIZE_SCALING) {
>> +                             /*
>> +                              * divided by two to match visual scale of touch
>> +                              * for devices with this quirk
>> +                              */
>>                               major = major >> 1;
>>                               minor = minor >> 1;
>>                       }
>> @@ -711,6 +750,25 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>>       td->num_received++;
>>  }
>>
>> +static void mt_release_pending_palms(struct mt_device *td,
>> +                                  struct input_dev *input)
>> +{
>> +     int slotnum;
>> +     bool need_sync = false;
>> +
>> +     for_each_set_bit(slotnum, td->pending_palm_slots, td->maxcontacts) {
>> +             clear_bit(slotnum, td->pending_palm_slots);
>> +
>> +             input_mt_slot(input, slotnum);
>> +             input_mt_report_slot_state(input, MT_TOOL_PALM, false);
>> +
>> +             need_sync = true;
>> +     }
>> +
>> +     if (need_sync)
>> +             input_sync(input);
>> +}
>> +
>>  /*
>>   * this function is called when a whole packet has been received and processed,
>>   * so that it can decide what to send to the input layer.
>> @@ -719,6 +777,9 @@ static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
>>  {
>>       input_mt_sync_frame(input);
>>       input_sync(input);
>> +
>> +     mt_release_pending_palms(td, input);
>> +
>>       td->num_received = 0;
>>       if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
>>               set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
>> @@ -903,6 +964,13 @@ static int mt_touch_input_configured(struct hid_device *hdev,
>>       if (td->is_buttonpad)
>>               __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>>
>> +     td->pending_palm_slots = devm_kcalloc(&hi->input->dev,
>> +                                           BITS_TO_LONGS(td->maxcontacts),
>> +                                           sizeof(long),
>> +                                           GFP_KERNEL);
>> +     if (!td->pending_palm_slots)
>> +             return -ENOMEM;
>> +
>>       ret = input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
>>       if (ret)
>>               return ret;
>> --
>> 2.14.0.434.g98096fd7a8-goog
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
