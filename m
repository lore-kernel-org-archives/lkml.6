Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163917AbeBOWQm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:16:42 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51782 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBOWQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:16:38 -0500
X-Google-Smtp-Source: AH8x227hxXaBn4FGDK8cER3O4WeiI+NK8mThstP6en2XxgjutEmq1SAhWaXCiiva5Nc+C4kpZMUAhQ==
Date: Thu, 15 Feb 2018 23:16:33 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
Message-ID: <20180215221633.GA18755@casa>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
 <20180213120308.23879-2-rodrigorivascosta@gmail.com>
 <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 03:51:31PM +0100, Benjamin Tissoires wrote:
> On Tue, Feb 13, 2018 at 1:03 PM, Rodrigo Rivas Costa
> > +#define STEAM_FEATURE_REPORT_SIZE 65
> > +
> > +static int steam_send_report(struct steam_device *steam,
> > +               u8 *cmd, int size)
> > +{
> > +       int retry;
> > +       int ret;
> > +       u8 *buf = kzalloc(STEAM_FEATURE_REPORT_SIZE, GFP_KERNEL);
> 
> Please use hid_alloc_report_buf() as sometimes we need to allocate a
> slightly bigger report.

I have an issue with this one. The problem is that using
hid_report_len() on the feature report returns 64. But I must call
hid_hw_raw_request() with 65 or it will fail with EOVERFLOW.

Currently I'm allocating a buffer of 65 bytes and all is well.
If I change to hid_alloc_report_buf(), the current implementation
allocates (64+7), so I'm still safe. But I'm worried that the extra
bytes are not guaranteed and a future implementation could return
exactly 64 bytes, leaving me 1 byte short.

About why an array of 65 is required for a report of size 64, I think it
is related to hid_report->id == 0 (so hid_report_enum->numbered == 0).

So what would be the proper solution?

Thanks.
Rodrigo.
