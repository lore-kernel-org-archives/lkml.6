Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755966AbeDZUrx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:47:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43401 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeDZUrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:47:52 -0400
X-Google-Smtp-Source: AB8JxZpbADxGCX8Wfuz3lmNrbB57DiL0wkozqitvwMotjqMnsIIXZNGPbzfUxksk4fnhH6ht2FFh0g==
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 26 Apr 2018 22:47:49 +0200
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180426204748.GA7540@gmail.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:22:02PM -0700, Sultan Alsawaf wrote:
> > Hmm, it looks like the multiuser startup is getting blocked on snapd:
> >
> >          29.060s snapd.service
> >
> > graphical.target @1min 32.145s
> > └─multi-user.target @1min 32.145s
> >   └─hddtemp.service @6.512s +28ms
> >     └─network-online.target @6.508s
> >       └─NetworkManager-wait-online.service @2.428s +4.079s
> >         └─NetworkManager.service @2.016s +404ms
> >           └─dbus.service @1.869s
> >             └─basic.target @1.824s
> >               └─sockets.target @1.824s
> >                 └─snapd.socket @1.821s +1ms
> >                   └─sysinit.target @1.812s
> >                     └─apparmor.service @587ms +1.224s
> >                       └─local-fs.target @585ms
> >                         └─local-fs-pre.target @585ms
> >                           └─keyboard-setup.service @235ms +346ms
> >                             └─systemd-journald.socket @226ms
> >                               └─system.slice @225ms
> >                                 └─-.slice @220ms
> >
> > This appears to be some kind of new package management system for
> > Ubuntu:
> >
> > Description-en: Tool to interact with Ubuntu Core Snappy.
> >  Install, configure, refresh and remove snap packages. Snaps are
> >  'universal' packages that work across many different Linux systems,
> >  enabling secure distribution of the latest apps and utilities for
> >  cloud, servers, desktops and the internet of things.
> >
> > Why it the Ubuntu package believes it needs to be fully started before
> > the login screen can display is unclear to me.  It might be worth
> > using systemctl to disable snapd.serivce and see if that makes things
> > work better for you.
> >
> > 				- Ted
> 
> I removed snapd completely which did nothing.
> 
> Here are new logs:
> systemd-analyze blame: https://hastebin.com/edehikuyeb.css
> systemd-analyze critical-chain: https://hastebin.com/vedufafema.pl
> dmesg: https://hastebin.com/zuwuwoxadu.vbs
> 
> I should also note that leaving the system untouched does not result in it booting: I must
> provide a source of entropy, otherwise it just stays stuck. In both of the dmesgs I've given, I

We have observed a similiar problem  with libvirt. As soon as entropy is
provided the boot finishes otherwise it hangs for a long time.
This is not happening with v4.17-rc1 afaict.

Christian

> manually provided entropy to the system after about 5 minutes of waiting.
> 
> Also, regardless of what's hanging on CRNG init, CRNG should be able to init on its own in a timely
> manner without the need for user-provided entropy. Userspace was working fine before the recent CRNG
> kernel changes, so I don't think this is a userspace bug.
> 
> -Sultan
> 
