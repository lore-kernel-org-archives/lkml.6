Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933628AbeBPKiO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:38:14 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:39064 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933559AbeBPKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:38:12 -0500
X-Google-Smtp-Source: AH8x224YvxB3AzIgqOxuVcLcWx797Ei4c5z3qJ0UZWgvpHhqOuCwJi5EOzNZZNzbYY6sVUyhwYxRz4YITmvxZNqp/S4=
MIME-Version: 1.0
In-Reply-To: <20180216095722.GC18755@casa>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
 <20180213120308.23879-2-rodrigorivascosta@gmail.com> <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
 <20180215221633.GA18755@casa> <CAO-hwJLjFaP3ZLoM+EDbruoRhOyPPFXmo7FWGoXESc9XgkD4Kg@mail.gmail.com>
 <20180216090243.GB18755@casa> <CAO-hwJKuWWiNX63=X1GSEQQ1cPhi35g6NuX7gsFNGj_s0UdM+Q@mail.gmail.com>
 <20180216095722.GC18755@casa>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 16 Feb 2018 11:38:11 +0100
Message-ID: <CAO-hwJ+9Jvd8x5dRaerstzeNNgY4_mUar77BB1k2ctxaOCJLtQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:57 AM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> On Fri, Feb 16, 2018 at 10:31:35AM +0100, Benjamin Tissoires wrote:
>> > Ok, I'll do that. The weird thing, however, is that:
>> >
>> >         hid_hw_raw_request(steam->hid_dev, 0x00,
>> >                 buf, hid_report_len(r), /* 64 */
>> >                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>> >
>> > fails with EOVERFLOW. I have to use:
>> >
>> >         hid_hw_raw_request(steam->hid_dev, 0x00,
>> >                 buf, 65
>> >                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>> >
>> > which just feels wrong to me.
>>
>> Indeed
>>
>> >
>> > And looking around drivers/hid/*.c I see that most calls to
>> > hid_hw_raw_request(..., HID_REQ_GET_REPORT) use a buffer allocated with
>> > {devm_,}kzalloc() and a constant length, never using
>> > hid_alloc_report_buf() or hid_report_len().
>>
>> well, hid-input.c and hid-multitouch.c are using
>> hid_alloc_report_buf() and these two are the most generic ones. We
>> haven't converted everybody to use hid_alloc_report_buf(), but it's
>> not a reason to not use it for new drivers :)
>
> Agreed. And they use hid_report_len() on the hid_hw_raw_request().
>
> Now my guess is that hid_report_len() should return 65 instead of 64.
> And it would do that if the report.id would be >0, but, alas, it is =0.
> Maybe feature reports should add 1 without checking id>0? Or maybe
> the Steam report descriptor is wrong and I should use report_fixup or
> something?
>
>> No, it's unlikely that there is a bug. Can you forward to me the
>> report descriptors of the Steam controller (ideally with the tool
>> hid-recorder from http://bentiss.github.io/hid-replay-docs/, so I can
>> get a few events too)?
>
> Sure, see the attached file. It is the wired one, I opened jstest and
> moved the joystick around to get a few events. Unfortunately the
> HID_REQ_GET_REPORT are not recorded.
>
> For the casual reader, here is the decoded report descriptor [1]:
>
> 0x06, 0x00, 0xFF,  // Usage Page (Vendor Defined 0xFF00)
> 0x09, 0x01,        // Usage (0x01)
> 0xA1, 0x01,        // Collection (Application)
> 0x15, 0x00,        //   Logical Minimum (0)
> 0x26, 0xFF, 0x00,  //   Logical Maximum (255)
> 0x75, 0x08,        //   Report Size (8)
> 0x95, 0x40,        //   Report Count (64)
> 0x09, 0x01,        //   Usage (0x01)
> 0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
> 0x95, 0x40,        //   Report Count (64)
> 0x09, 0x01,        //   Usage (0x01)
> 0x91, 0x02,        //   Output (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
> 0x95, 0x40,        //   Report Count (64)
> 0x09, 0x01,        //   Usage (0x01)
> 0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
> 0xC0,              // End Collection
>

>
> [1]: http://eleccelerator.com/usbdescreqparser/


Thanks.

Arf, looks like usbhid expects the buffer to start with 0x00 when the
report is not numbered, thus adding one to the report length.

I guess that nobody tried to recently set/get reports on a device
without a report ID. And hidraw matches this behavior too, which means
it's hard to change.

One thing I'd like to try to change is the result of hid_report_len.
If everybody expects the size to be of one more when the report is
unnumbered, maybe we could simply add this placeholder in the report
size from the beginning.

We'd need more testing though that just my gut feeling that it's the
right thing to do.

Cheers,
Benjamin
