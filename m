Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeDZTZd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:25:33 -0400
Received: from imap.thunk.org ([74.207.234.97]:35396 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbeDZTZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:25:32 -0400
Date: Thu, 26 Apr 2018 15:25:24 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180426192524.GD5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 08:17:34AM -0700, Sultan Alsawaf wrote:
> > Hmm, can you let the boot hang for a while?  It should continue after
> > a few minutes if you wait long enough, but wait a minute or two, then
> > give it entropy so the boot can continue.  Then can you use
> > "systemd-analyze blame" or "systemd-analyize critical-chain" and we
> > can see what process was trying to get randomness during the boot
> > startup and blocking waiting for the CRNG to be fully initialized.
> >
> > 	    	     	     	     - Ted
> 
> systemd-analyze blame: https://hastebin.com/ikipavevew.css
> systemd-analyze critical-chain: https://hastebin.com/odoyuqeges.pl
> dmesg: https://hastebin.com/waracebeja.vbs
>

Hmm, it looks like the multiuser startup is getting blocked on snapd:

         29.060s snapd.service

graphical.target @1min 32.145s
└─multi-user.target @1min 32.145s
  └─hddtemp.service @6.512s +28ms
    └─network-online.target @6.508s
      └─NetworkManager-wait-online.service @2.428s +4.079s
        └─NetworkManager.service @2.016s +404ms
          └─dbus.service @1.869s
            └─basic.target @1.824s
              └─sockets.target @1.824s
                └─snapd.socket @1.821s +1ms
                  └─sysinit.target @1.812s
                    └─apparmor.service @587ms +1.224s
                      └─local-fs.target @585ms
                        └─local-fs-pre.target @585ms
                          └─keyboard-setup.service @235ms +346ms
                            └─systemd-journald.socket @226ms
                              └─system.slice @225ms
                                └─-.slice @220ms

This appears to be some kind of new package management system for
Ubuntu:

Description-en: Tool to interact with Ubuntu Core Snappy.
 Install, configure, refresh and remove snap packages. Snaps are
 'universal' packages that work across many different Linux systems,
 enabling secure distribution of the latest apps and utilities for
 cloud, servers, desktops and the internet of things.

Why it the Ubuntu package believes it needs to be fully started before
the login screen can display is unclear to me.  It might be worth
using systemctl to disable snapd.serivce and see if that makes things
work better for you.

				- Ted
