Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757929AbeBPJbi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:31:38 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43961 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757914AbeBPJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:31:36 -0500
X-Google-Smtp-Source: AH8x226sN4XxqU0duVGt3YMVVoNR0Bo0R7XHf0u+K7ULPvM2HWIi7J1tigu5IejywCV2eqW29L6oY++0Dlfu7qi9sP0=
MIME-Version: 1.0
In-Reply-To: <20180216090243.GB18755@casa>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
 <20180213120308.23879-2-rodrigorivascosta@gmail.com> <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
 <20180215221633.GA18755@casa> <CAO-hwJLjFaP3ZLoM+EDbruoRhOyPPFXmo7FWGoXESc9XgkD4Kg@mail.gmail.com>
 <20180216090243.GB18755@casa>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 16 Feb 2018 10:31:35 +0100
Message-ID: <CAO-hwJKuWWiNX63=X1GSEQQ1cPhi35g6NuX7gsFNGj_s0UdM+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:02 AM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> On Fri, Feb 16, 2018 at 09:44:34AM +0100, Benjamin Tissoires wrote:
>> > I have an issue with this one. The problem is that using
>> > hid_report_len() on the feature report returns 64. But I must call
>> > hid_hw_raw_request() with 65 or it will fail with EOVERFLOW.
>> >
>> > Currently I'm allocating a buffer of 65 bytes and all is well.
>> > If I change to hid_alloc_report_buf(), the current implementation
>> > allocates (64+7), so I'm still safe. But I'm worried that the extra
>> > bytes are not guaranteed and a future implementation could return
>> > exactly 64 bytes, leaving me 1 byte short.
>> >
>> > About why an array of 65 is required for a report of size 64, I think it
>> > is related to hid_report->id == 0 (so hid_report_enum->numbered == 0).
>>
>> That's the other way around actually. If you are just using the output
>> of hid_report_len(), it will take into account the extra byte for the
>> report ID.
>> *But*, given the way implement() is working (see the comment in the
>> implementation of hid_alloc_report()), you need to have up to 7 extra
>> bytes to not have the EOVERFLOW.
>>
>> So if we ever change the implement() function (which is *really*
>> unlikely), we will have to make sure hid_alloc_report() still works,
>> so you are on the safe side if you use hid_alloc_report().
>
> Ok, I'll do that. The weird thing, however, is that:
>
>         hid_hw_raw_request(steam->hid_dev, 0x00,
>                 buf, hid_report_len(r), /* 64 */
>                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>
> fails with EOVERFLOW. I have to use:
>
>         hid_hw_raw_request(steam->hid_dev, 0x00,
>                 buf, 65
>                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>
> which just feels wrong to me.

Indeed

>
> And looking around drivers/hid/*.c I see that most calls to
> hid_hw_raw_request(..., HID_REQ_GET_REPORT) use a buffer allocated with
> {devm_,}kzalloc() and a constant length, never using
> hid_alloc_report_buf() or hid_report_len().

well, hid-input.c and hid-multitouch.c are using
hid_alloc_report_buf() and these two are the most generic ones. We
haven't converted everybody to use hid_alloc_report_buf(), but it's
not a reason to not use it for new drivers :)

>
> Maybe there is a bug in hid_hw_raw_request() and it should add 1 to the
> given buffer len? But then, custom buffer allocations will overflow by
> one!

No, it's unlikely that there is a bug. Can you forward to me the
report descriptors of the Steam controller (ideally with the tool
hid-recorder from http://bentiss.github.io/hid-replay-docs/, so I can
get a few events too)?

Cheers,
Benjamin

>
> Rodrigo.
