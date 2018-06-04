Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeFDM55 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:57:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38638 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeFDM5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:57:55 -0400
X-Google-Smtp-Source: ADUXVKL5bUm+i5eAJjinCwlL1pBS/DpRoiqbUY65l5J1HBS0faFDsPr8/vYrZl+MASBF0n8FWZNEAmvYCTKMb0Bc+PE=
MIME-Version: 1.0
In-Reply-To: <72b7120a-d304-0b2f-d04a-473631623f72@bitmath.org>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
 <20180601184330.GD222005@dtor-ws> <72b7120a-d304-0b2f-d04a-473631623f72@bitmath.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 4 Jun 2018 14:57:54 +0200
Message-ID: <CAO-hwJKibKvqviLZ5SSYR_X3yLTzJrr0G4d6svM3FtgJ6AfvQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>,
        Dennis Kempin <denniskempin@google.com>,
        Andrew de los Reyes <adlr@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 9:03 PM, Henrik Rydberg <rydberg@bitmath.org> wrote:
>
>>> However, I interpret a firmware that send (confidence 1, tip switch 1)
>>> and then (confidence 0, tip switch 0) a simple release, and the
>>> confidence bit should not be relayed.
>>
>> This unfortunately leads to false clicks: you start with finger, so
>> confidence is 1, then you transition the same touch to palm (use your
>> thumb and "roll" your hand until heel of it comes into contact with the
>> screen). The firmware reports "no-confidence" and "release" in the same
>> report and userspace seeing release does not pay attention to confidence
>> (i.e. it does exactly "simple release" logic) and this results in UI
>> interpreting this as a click. With splitting no-confidence
>> (MT_TOOL_PALM) and release event into separate frames we help userspace
>> to recognize that the contact should be discarded.
>
> This is in part why I objected to this patch on August 11th, 2017.
> Logically, the confidence state is a property of a contact, not a new type
> of contact. Trying to use it in any other way is bound to lead to confusion.

Problem is that MT_TOOL_PALM has been introduced in the kernel since
v4.0 (late 2015 by a736775db683 "Input: add MT_TOOL_PALM").
It's been used in the Synaptics RMI4 driver since and by hid-asus in late 2016.
I can't find any other users in the current upstream tree, but those
two are already making a precedent and changing the semantic is a
little bit late :/

Cheers,
Benjamin

>
> Henrik
>
