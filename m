Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750836AbeBPU7q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:59:46 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51082 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeBPU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:59:44 -0500
X-Google-Smtp-Source: AH8x227SlV81pyqCgSlAx2WuEkgxAAcqwz99D0rSqXIBsUvK7VqajRz3MhTekXOt2/vhTIFi6qNW+A==
Date: Fri, 16 Feb 2018 21:59:39 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
Message-ID: <20180216205939.GA17329@casa>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
 <20180213120308.23879-2-rodrigorivascosta@gmail.com>
 <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
 <20180215221633.GA18755@casa>
 <CAO-hwJLjFaP3ZLoM+EDbruoRhOyPPFXmo7FWGoXESc9XgkD4Kg@mail.gmail.com>
 <20180216090243.GB18755@casa>
 <CAO-hwJKuWWiNX63=X1GSEQQ1cPhi35g6NuX7gsFNGj_s0UdM+Q@mail.gmail.com>
 <20180216095722.GC18755@casa>
 <CAO-hwJ+9Jvd8x5dRaerstzeNNgY4_mUar77BB1k2ctxaOCJLtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+9Jvd8x5dRaerstzeNNgY4_mUar77BB1k2ctxaOCJLtQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:38:11AM +0100, Benjamin Tissoires wrote:
> On Fri, Feb 16, 2018 at 10:57 AM, Rodrigo Rivas Costa
> <rodrigorivascosta@gmail.com> wrote:
> > On Fri, Feb 16, 2018 at 10:31:35AM +0100, Benjamin Tissoires wrote:
> >> > Ok, I'll do that. The weird thing, however, is that:
> >> >
> >> >         hid_hw_raw_request(steam->hid_dev, 0x00,
> >> >                 buf, hid_report_len(r), /* 64 */
> >> >                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> >> >
> >> > fails with EOVERFLOW. I have to use:
> >> >
> >> >         hid_hw_raw_request(steam->hid_dev, 0x00,
> >> >                 buf, 65
> >> >                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> >> >
> >> > which just feels wrong to me.
> >>
> >> Indeed
> >>
> 
> Arf, looks like usbhid expects the buffer to start with 0x00 when the
> report is not numbered, thus adding one to the report length.
> 
> I guess that nobody tried to recently set/get reports on a device
> without a report ID. And hidraw matches this behavior too, which means
> it's hard to change.
> 
> One thing I'd like to try to change is the result of hid_report_len.
> If everybody expects the size to be of one more when the report is
> unnumbered, maybe we could simply add this placeholder in the report
> size from the beginning.

I've been trying to make sense of all this numbered/buf++/count-- stuff,
and I admit I don't understand half of it...

But about that +7 in hid_alloc_report_buf(), isn't it to make room for
the implement()/extract() functions? And IIUIC those are not used for
raw_requests... they are instead passed directly to usb_control_msg()
(or whatever the ll driver does). That's the point of being raw, isn't
it?

If I'm right with that, would it make sense to go back to kzalloc(65)?

If I'm wrong, then if you agree, I'll default to:

	hid_hw_raw_request(steam->hid_dev, 0x00,
		buf, hid_report_len(r) + 1, /* count the request number	*/
		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);

Then, if hid_report_len() is ever updated to return the +1, this one
should be removed. And even if it is not, we still have +6 extra bytes
from hid_alloc_report_buf(), so no real harm done.

Regards.
Rodrigo
