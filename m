Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeFASng (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:43:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44322 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbeFASne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:43:34 -0400
X-Google-Smtp-Source: ADUXVKILxVz3Y2HZrQBW96lO9uZQBYf9Jn2utr5F9E+J1H+O6VsKxAPqReLd8Gawr3kC0WkjY38l3g==
Date: Fri, 1 Jun 2018 11:43:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
        Jason Gerecke <killertofu@gmail.com>,
        Dennis Kempin <denniskempin@google.com>,
        Andrew de los Reyes <adlr@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Message-ID: <20180601184330.GD222005@dtor-ws>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 04:16:09PM +0200, Benjamin Tissoires wrote:
> On Fri, Aug 11, 2017 at 2:44 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > According to Microsoft specification [1] for Precision Touchpads (and
> > Touchscreens) the devices use "confidence" reports to signal accidental
> > touches, or contacts that are "too large to be a finger". Instead of
> > simply marking contact inactive in this case (which causes issues if
> > contact was originally proper and we lost confidence in it later, as
> > this results in accidental clicks, drags, etc), let's report such
> > contacts as MT_TOOL_PALM and let userspace decide what to do.
> > Additionally, let's report contact size for such touches as maximum
> > allowed for major/minor, which should help userspace that is not yet
> > aware of MT_TOOL_PALM to still perform palm rejection.
> >
> > An additional complication, is that some firmwares do not report
> > non-confident touches as active. To cope with this we delay release of
> > such contact (i.e. if contact was active we first report it as still
> > active MT+TOOL_PALM and then synthesize the release event in a separate
> > frame).
> 
> I am not sure I agree with this part. The spec says that "Once a
> device has determined that a contact is unintentional, it should clear
> the confidence bit for that contact report and all subsequent
> reports."
> So in theory the spec says that if a touch has been detected as a
> palm, the flow of events should not stop (tested on the PTP of the
> Dell XPS 9360).
> 
> However, I interpret a firmware that send (confidence 1, tip switch 1)
> and then (confidence 0, tip switch 0) a simple release, and the
> confidence bit should not be relayed.

This unfortunately leads to false clicks: you start with finger, so
confidence is 1, then you transition the same touch to palm (use your
thumb and "roll" your hand until heel of it comes into contact with the
screen). The firmware reports "no-confidence" and "release" in the same
report and userspace seeing release does not pay attention to confidence
(i.e. it does exactly "simple release" logic) and this results in UI
interpreting this as a click. With splitting no-confidence
(MT_TOOL_PALM) and release event into separate frames we help userspace
to recognize that the contact should be discarded.

> 
> Do you have any precise example of reports where you need that feature?

It was observed on Pixelbooks which use Wacom digitizers IIRC.

Thanks.

-- 
Dmitry
