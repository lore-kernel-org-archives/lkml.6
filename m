Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754971AbeBPIoh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:44:37 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:41385 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbeBPIof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:44:35 -0500
X-Google-Smtp-Source: AH8x227ZpAZV0/T6I/uNUQ0FR3QwzECa3167rIRD5n0+F0V7jkBO1ss1sgqMZzQMPexE8Obj1Jm0zLHhG1rgKHHWzkA=
MIME-Version: 1.0
In-Reply-To: <20180215221633.GA18755@casa>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
 <20180213120308.23879-2-rodrigorivascosta@gmail.com> <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
 <20180215221633.GA18755@casa>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 16 Feb 2018 09:44:34 +0100
Message-ID: <CAO-hwJLjFaP3ZLoM+EDbruoRhOyPPFXmo7FWGoXESc9XgkD4Kg@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 11:16 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> On Wed, Feb 14, 2018 at 03:51:31PM +0100, Benjamin Tissoires wrote:
>> On Tue, Feb 13, 2018 at 1:03 PM, Rodrigo Rivas Costa
>> > +#define STEAM_FEATURE_REPORT_SIZE 65
>> > +
>> > +static int steam_send_report(struct steam_device *steam,
>> > +               u8 *cmd, int size)
>> > +{
>> > +       int retry;
>> > +       int ret;
>> > +       u8 *buf = kzalloc(STEAM_FEATURE_REPORT_SIZE, GFP_KERNEL);
>>
>> Please use hid_alloc_report_buf() as sometimes we need to allocate a
>> slightly bigger report.
>
> I have an issue with this one. The problem is that using
> hid_report_len() on the feature report returns 64. But I must call
> hid_hw_raw_request() with 65 or it will fail with EOVERFLOW.
>
> Currently I'm allocating a buffer of 65 bytes and all is well.
> If I change to hid_alloc_report_buf(), the current implementation
> allocates (64+7), so I'm still safe. But I'm worried that the extra
> bytes are not guaranteed and a future implementation could return
> exactly 64 bytes, leaving me 1 byte short.
>
> About why an array of 65 is required for a report of size 64, I think it
> is related to hid_report->id == 0 (so hid_report_enum->numbered == 0).

That's the other way around actually. If you are just using the output
of hid_report_len(), it will take into account the extra byte for the
report ID.
*But*, given the way implement() is working (see the comment in the
implementation of hid_alloc_report()), you need to have up to 7 extra
bytes to not have the EOVERFLOW.

So if we ever change the implement() function (which is *really*
unlikely), we will have to make sure hid_alloc_report() still works,
so you are on the safe side if you use hid_alloc_report().

>
> So what would be the proper solution?

hid_alloc_report() is the one you want :)
And generally speaking, using the internal API to deal with reports
and others is the safe bet, as you are guaranteed to not being broken
if the API changes (or it'll be a regression and we will have to take
this as high priority).

Cheers,
Benjamin

>
> Thanks.
> Rodrigo.
