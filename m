Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeFDR2F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:28:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36609 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeFDR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:28:03 -0400
X-Google-Smtp-Source: ADUXVKJZ33lksu2k0P4me37DxHoJCMzAnjF+rtomzu1rRr9hNLcJJk6nPIVm1+GFZEdGRhLXKLjfNg==
Date: Mon, 4 Jun 2018 10:27:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Jiri Kosina <jikos@kernel.org>,
        Jason Gerecke <killertofu@gmail.com>,
        Dennis Kempin <denniskempin@google.com>,
        Andrew de los Reyes <adlr@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Message-ID: <20180604172759.GA164893@dtor-ws>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
 <20180601184330.GD222005@dtor-ws>
 <72b7120a-d304-0b2f-d04a-473631623f72@bitmath.org>
 <CAO-hwJKibKvqviLZ5SSYR_X3yLTzJrr0G4d6svM3FtgJ6AfvQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJKibKvqviLZ5SSYR_X3yLTzJrr0G4d6svM3FtgJ6AfvQQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 02:57:54PM +0200, Benjamin Tissoires wrote:
> On Fri, Jun 1, 2018 at 9:03 PM, Henrik Rydberg <rydberg@bitmath.org> wrote:
> >
> >>> However, I interpret a firmware that send (confidence 1, tip switch 1)
> >>> and then (confidence 0, tip switch 0) a simple release, and the
> >>> confidence bit should not be relayed.
> >>
> >> This unfortunately leads to false clicks: you start with finger, so
> >> confidence is 1, then you transition the same touch to palm (use your
> >> thumb and "roll" your hand until heel of it comes into contact with the
> >> screen). The firmware reports "no-confidence" and "release" in the same
> >> report and userspace seeing release does not pay attention to confidence
> >> (i.e. it does exactly "simple release" logic) and this results in UI
> >> interpreting this as a click. With splitting no-confidence
> >> (MT_TOOL_PALM) and release event into separate frames we help userspace
> >> to recognize that the contact should be discarded.
> >
> > This is in part why I objected to this patch on August 11th, 2017.
> > Logically, the confidence state is a property of a contact, not a new type
> > of contact. Trying to use it in any other way is bound to lead to confusion.
> 
> Problem is that MT_TOOL_PALM has been introduced in the kernel since
> v4.0 (late 2015 by a736775db683 "Input: add MT_TOOL_PALM").
> It's been used in the Synaptics RMI4 driver since and by hid-asus in late 2016.
> I can't find any other users in the current upstream tree, but those
> two are already making a precedent and changing the semantic is a
> little bit late :/

I am sorry I did not respond and lost track of this issue back then, but
I disagree with Henrik here. While confidence is a property of contact,
so is the type of contact and it can and will change throughout life of
a contact, especially if we will continue adding new types, such as, for
example, thumb. In this case the firmware can transition through
finger->thumb or finger->thumb->palm or finger->palm as the nature of
contact becomes better understood. Still it is the same contact and we
should not attempt to signal userspace differently.

We could introduce the ABS_MT_CONFIDENCE (0/1 or even 0..n range), to
complement ABS_MT_TOOL, but that would not really solve the issue with
Wacom firmware (declaring contact non-confident and releasing it right
away) and given MS explanation of the confidence as "contact is too big"
MT_TOOL_PALM fits it perfectly.

Thanks.

-- 
Dmitry
