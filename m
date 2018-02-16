Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757499AbeBPJCu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:02:50 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:45943 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757485AbeBPJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:02:47 -0500
X-Google-Smtp-Source: AH8x227X6CpmWvxXiNBK5L+i5k3/K/At+43VEMrT8eWlztaVvpE5EBo7ylXUh97YIPaHJqCJ8Kt+aQ==
Date: Fri, 16 Feb 2018 10:02:43 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
Message-ID: <20180216090243.GB18755@casa>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
 <20180213120308.23879-2-rodrigorivascosta@gmail.com>
 <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
 <20180215221633.GA18755@casa>
 <CAO-hwJLjFaP3ZLoM+EDbruoRhOyPPFXmo7FWGoXESc9XgkD4Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJLjFaP3ZLoM+EDbruoRhOyPPFXmo7FWGoXESc9XgkD4Kg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 09:44:34AM +0100, Benjamin Tissoires wrote:
> > I have an issue with this one. The problem is that using
> > hid_report_len() on the feature report returns 64. But I must call
> > hid_hw_raw_request() with 65 or it will fail with EOVERFLOW.
> >
> > Currently I'm allocating a buffer of 65 bytes and all is well.
> > If I change to hid_alloc_report_buf(), the current implementation
> > allocates (64+7), so I'm still safe. But I'm worried that the extra
> > bytes are not guaranteed and a future implementation could return
> > exactly 64 bytes, leaving me 1 byte short.
> >
> > About why an array of 65 is required for a report of size 64, I think it
> > is related to hid_report->id == 0 (so hid_report_enum->numbered == 0).
> 
> That's the other way around actually. If you are just using the output
> of hid_report_len(), it will take into account the extra byte for the
> report ID.
> *But*, given the way implement() is working (see the comment in the
> implementation of hid_alloc_report()), you need to have up to 7 extra
> bytes to not have the EOVERFLOW.
> 
> So if we ever change the implement() function (which is *really*
> unlikely), we will have to make sure hid_alloc_report() still works,
> so you are on the safe side if you use hid_alloc_report().

Ok, I'll do that. The weird thing, however, is that:

	hid_hw_raw_request(steam->hid_dev, 0x00,
		buf, hid_report_len(r), /* 64 */
		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);

fails with EOVERFLOW. I have to use:

	hid_hw_raw_request(steam->hid_dev, 0x00,
		buf, 65
		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);

which just feels wrong to me.

And looking around drivers/hid/*.c I see that most calls to
hid_hw_raw_request(..., HID_REQ_GET_REPORT) use a buffer allocated with
{devm_,}kzalloc() and a constant length, never using
hid_alloc_report_buf() or hid_report_len().

Maybe there is a bug in hid_hw_raw_request() and it should add 1 to the
given buffer len? But then, custom buffer allocations will overflow by
one!

Rodrigo.
