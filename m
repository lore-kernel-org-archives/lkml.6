Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeCLXjL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:39:11 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36356 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeCLXjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:39:10 -0400
X-Google-Smtp-Source: AG47ELty+mL5tMWo+t93LGDFMYJUe3HvO54vCkLpxveqQ6PN05K8BLQyqSVBhB6A4XwR+Curr8WtXA==
Date: Tue, 13 Mar 2018 00:39:05 +0100
From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: linux-next on thinkpad x60: full battery is indicated as battery
 error in mate
Message-ID: <20180312233905.ulb4zrr7dphy2l3i@thinkpad>
References: <20180312194715.GA3992@amd>
 <20180312194944.GA3979@amd>
 <CAJZ5v0gWd7OCy+P41CFWJ1E9Tzw++Ok=YmjQwLk+iSZutBzphA@mail.gmail.com>
 <20180312223521.vzccevf6z7ik5ysf@thinkpad>
 <20180312230407.GA7612@amd>
 <CAJZ5v0irEfMxURr2c8VZ=SZhsW+MWxRd4OwDH5bS6P=R3a0REw@mail.gmail.com>
 <20180312231847.GB7612@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312231847.GB7612@amd>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 12:18:47AM +0100, Pavel Machek wrote:
> Hi!
> 
> > >> > >> Fully charged
> > >> > >> battery shows as empty battery with red "x" in Mate desktop. After
> > >> > >> reboot to recent mainline problem goes away. Tooltip says "battery
> > >> > >> waiting to charge".
> > >> > >>
> > >>
> > >> For the MATE bug see:
> > >> https://github.com/mate-desktop/mate-power-manager/pull/251
> > >>
> > >> The problem is in the new composite battery system in UPower, it
> > >> "merges" two external batteries into a single one for reporting. That
> > >> battery does not understand "Not Charging" inside the MATE Power
> > >> Manager. The above patch fixes that in MATE.
> > >
> > > Ok, so problem is 91eea70e5e5ce12eb1c7cd922e561fab43e201bd.
> > >
> > > And now, I see that MATE should be improved.
> > >
> > > But what I also see is that kernel is changing its interface in a way
> > > that (while making sense) breaks existing application. And we don't
> > > break existing applications.
> > >
> > > [Now... maybe if the fix for the application is available for long
> > > long time and noone is really looking and everyone already has new
> > > application version, maybe ... But pull request for MATE is 9 days
> > > old, and not even merged. So there is no way this is suitable for
> > > 4.17.]

It's not a bug in the kernel, it's a very subtle cosmetic bug in MATE.
If you can, please test that MATE patch and report back to Github
if it works, as I wrote that patch and they are waiting for someone with
a ThinkPad to test the patch. If it works, it will get merged and
everyone will be happy.

This is far from "breaking applications", it's just a cosmetic bug with
a single icon in a single application that has a simple fix.

The upstream underlying UPower system reports it properly, as
UP_DEVICE_STATE_PENDING_CHARGE, it's just that the MATE/GNOME developers did
not handle that scenario due to poor testing and use case analysis, even
when that state is in the UpDeviceState enumeration.

See:
https://upower.freedesktop.org/docs/UPower-up-types.html#UpDeviceState

UPower correctly returns UP_DEVICE_STATE_PENDING_CHARGE, its just that
the MATE Power Manager discards that and assumes
UP_DEVICE_STATE_UNKNOWN.

> > 
> > Right.
> > 
> > This basically means that we will have to defer the battery changes
> > until user space is ready and not just upstream, but also in distro
> > packages.
> 
> Yes please.

No. See below.

> 
> Note that only 91eea70e5e5ce12eb1c7cd922e561fab43e201bd should break
> anything, the others should be safe AFAICT?

Again, nothing is broken here, the kernel is *currently* broken as it
shows that the battery state is "Unknown" and MATE assumes a broken
kernel and returns a simple charging icon.

> 
> 								Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
