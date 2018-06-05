Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeFERFP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:05:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44071 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeFERFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:08 -0400
X-Google-Smtp-Source: ADUXVKKhShcXZLE4oTaOO99ZyRpfMK9LZ+UU8OOvAYfDPrV1lh9gzd8oeAzdtmOYxgGHuXnHnm4Fag==
Date: Tue, 5 Jun 2018 10:05:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>,
        Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
        Jason Gerecke <killertofu@gmail.com>,
        Dennis Kempin <denniskempin@google.com>,
        Andrew de los Reyes <adlr@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Message-ID: <20180605170503.GC202428@dtor-ws>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
 <20180601184330.GD222005@dtor-ws>
 <CAO-hwJJPGJzgX+7H1nnpd=OkLZu0q0TuKhvroJ1K3jtnv7t6dg@mail.gmail.com>
 <20180604173339.GB164893@dtor-ws>
 <CAO-hwJ+nzC=i1Jv_yu4vLL6Quw=850HJkOZBKCjFaZaw0-GWOQ@mail.gmail.com>
 <20180604211944.GE164893@dtor-ws>
 <20180604225539.GA13447@jelly>
 <CAO-hwJLzc_bVDLKTExTZLSEYON3zu54Q0COe57xGGQ5AS6OPRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJLzc_bVDLKTExTZLSEYON3zu54Q0COe57xGGQ5AS6OPRw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:50:15PM +0200, Benjamin Tissoires wrote:
> On Tue, Jun 5, 2018 at 12:55 AM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > On Mon, Jun 04, 2018 at 02:19:44PM -0700, Dmitry Torokhov wrote:
> >> On Mon, Jun 04, 2018 at 10:42:31PM +0200, Benjamin Tissoires wrote:
> >> > On Mon, Jun 4, 2018 at 7:33 PM, Dmitry Torokhov
> >> > <dmitry.torokhov@gmail.com> wrote:
> >> > > On Mon, Jun 04, 2018 at 03:18:12PM +0200, Benjamin Tissoires wrote:
> >> > >> On Fri, Jun 1, 2018 at 8:43 PM, Dmitry Torokhov
> >> > >> <dmitry.torokhov@gmail.com> wrote:
> >> > >> > On Fri, Jun 01, 2018 at 04:16:09PM +0200, Benjamin Tissoires wrote:
> >> > >> >> On Fri, Aug 11, 2017 at 2:44 AM, Dmitry Torokhov
> >> > >> >> <dmitry.torokhov@gmail.com> wrote:
> >> > >> >> > According to Microsoft specification [1] for Precision Touchpads (and
> >> > >> >> > Touchscreens) the devices use "confidence" reports to signal accidental
> >> > >> >> > touches, or contacts that are "too large to be a finger". Instead of
> >> > >> >> > simply marking contact inactive in this case (which causes issues if
> >> > >> >> > contact was originally proper and we lost confidence in it later, as
> >> > >> >> > this results in accidental clicks, drags, etc), let's report such
> >> > >> >> > contacts as MT_TOOL_PALM and let userspace decide what to do.
> >> > >> >> > Additionally, let's report contact size for such touches as maximum
> >> > >> >> > allowed for major/minor, which should help userspace that is not yet
> >> > >> >> > aware of MT_TOOL_PALM to still perform palm rejection.
> >> > >> >> >
> >> > >> >> > An additional complication, is that some firmwares do not report
> >> > >> >> > non-confident touches as active. To cope with this we delay release of
> >> > >> >> > such contact (i.e. if contact was active we first report it as still
> >> > >> >> > active MT+TOOL_PALM and then synthesize the release event in a separate
> >> > >> >> > frame).
> >> > >> >>
> >> > >> >> I am not sure I agree with this part. The spec says that "Once a
> >> > >> >> device has determined that a contact is unintentional, it should clear
> >> > >> >> the confidence bit for that contact report and all subsequent
> >> > >> >> reports."
> >> > >> >> So in theory the spec says that if a touch has been detected as a
> >> > >> >> palm, the flow of events should not stop (tested on the PTP of the
> >> > >> >> Dell XPS 9360).
> >> > >> >>
> >> > >> >> However, I interpret a firmware that send (confidence 1, tip switch 1)
> >> > >> >> and then (confidence 0, tip switch 0) a simple release, and the
> >> > >> >> confidence bit should not be relayed.
> >> > >> >
> >> > >> > This unfortunately leads to false clicks: you start with finger, so
> >> > >> > confidence is 1, then you transition the same touch to palm (use your
> >> > >> > thumb and "roll" your hand until heel of it comes into contact with the
> >> > >> > screen). The firmware reports "no-confidence" and "release" in the same
> >> > >> > report and userspace seeing release does not pay attention to confidence
> >> > >> > (i.e. it does exactly "simple release" logic) and this results in UI
> >> > >> > interpreting this as a click. With splitting no-confidence
> >> > >> > (MT_TOOL_PALM) and release event into separate frames we help userspace
> >> > >> > to recognize that the contact should be discarded.
> >> > >>
> >> > >> After further thoughts, I would consider this to be a firmware bug,
> >> > >> and not how the firmware is supposed to be reporting palm.
> >> > >> For the precision touchpads, the spec says that the device "should
> >> > >> clear the confidence bit for that contact report and all subsequent
> >> > >> reports.". And it is how the Dell device I have here reports palms.
> >> > >> The firmware is not supposed to cut the event stream.
> >> > >>
> >> > >> There is a test for that:
> >> > >> https://docs.microsoft.com/en-us/previous-versions/windows/hardware/hck/dn456905%28v%3dvs.85%29
> >> > >> which tells me that I am right here for PTP.
> >> > >>
> >> > >> The touchscreen spec is blurrier however.
> >> > >
> >> > > OK, that is great to know.
> >> > >
> >> > >>
> >> > >> >
> >> > >> >>
> >> > >> >> Do you have any precise example of reports where you need that feature?
> >> > >> >
> >> > >> > It was observed on Pixelbooks which use Wacom digitizers IIRC.
> >> > >>
> >> > >> Pixelbooks + Wacom means that it was likely a touchscreen. I am right
> >> > >> guessing the device did not went through Microsoft certification
> >> > >> process?
> >> > >
> >> > > That would be correct ;) At least the firmware that is shipping with
> >> > > Pixlebooks hasn't, I do now if anyone else sourced these Wacom parts for
> >> > > their MSWin devices.
> >> > >
> >> > >>
> >> > >> I am in favor of splitting the patch in 2. One for the generic
> >> > >> processing of confidence bit, and one for this spurious release. For
> >> > >> the spurious release, I'm more in favor of explicitly quirking the
> >> > >> devices in need of such quirk.
> >> > >
> >> > > Hmm, I am not sure about having specific quirk. It will be hard for
> >> > > users to accurately diagnose the issue if firmware is broken in this way
> >> > > so we could add a new quirk for a new device.
> >> >
> >> > One thing we can do is keep the quirked mechanism as default in
> >> > hid-multitouch, but remove it in hid-core. If people need the quirk,
> >> > they can just use hid-multitouch instead (talking about the long run
> >> > here).
> >>
> >> Hmm, I am confused. My patch did not touch hid-core or hid-input, only
> >> hid-multitouch... So we are already doing what you are proposing?..
> >>
> >> >
> >> > However, I really believe this might only be required for a handful of
> >> > devices, and probably only touchscreens. So I would be tempted to not
> >> > make it default and see how many bug reports we have.
> >>
> >> Up to you but it is hard to detect for users. If just sometimes there
> >> are stray clicks...
> >
> > fwiw, from my POV, if you give me MT_TOOL_PALM in the same frame as the
> > ABS_MT_TRACKING_ID -1 I can work that into libinput to do the right thing.
> 
> This would be a one line change in the kernel, so you got my attention :)

Umm, there are other input stacks beyond libinput.

> 
> > Not 100% whether that already works anyway but probably not. I'd prefer it
> > being fixed in the kernel though, less work for me :)
> 
> What do you mean by "fixed"?
> Is it incorrect to send a tool while tracking ID is set to -1?
> From what I read on multi-touch-protocol.rst this shouldn't be
> violating the protocol, and this would save quite a mess in the kernel
> in which we need to add an artificial event in the queue for the
> release.

Well, we say "A non-negative tracking id is interpreted as a contact,
and the value -1 denotes an unused slot." Unless you are a protocol
lawyer, the most sensible way of interpreting it is to ignore whatever
is transmitted for the slot once receiving tracking ID of -1.

Given that this is particular firmware quirk that sends confidence and
release in the same report, I'd prefer if we had a quirk in driver
rather than pushing the responsibility to userspace.

Thanks.

-- 
Dmitry
