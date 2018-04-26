Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755855AbeDZUWH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:22:07 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33762 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeDZUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:22:06 -0400
X-Google-Smtp-Source: AIpwx48AtbqxnW1Lsak3Iiyb7kZvmjMNGVUO3aqW/mI9SFbHK9DdxB0+3QRK548eqw4P5NqfEo+oVg==
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
From: Sultan Alsawaf <sultanxda@gmail.com>
Message-ID: <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
Date: Thu, 26 Apr 2018 13:22:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426192524.GD5965@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, it looks like the multiuser startup is getting blocked on snapd:
>
>          29.060s snapd.service
>
> graphical.target @1min 32.145s
> └─multi-user.target @1min 32.145s
>   └─hddtemp.service @6.512s +28ms
>     └─network-online.target @6.508s
>       └─NetworkManager-wait-online.service @2.428s +4.079s
>         └─NetworkManager.service @2.016s +404ms
>           └─dbus.service @1.869s
>             └─basic.target @1.824s
>               └─sockets.target @1.824s
>                 └─snapd.socket @1.821s +1ms
>                   └─sysinit.target @1.812s
>                     └─apparmor.service @587ms +1.224s
>                       └─local-fs.target @585ms
>                         └─local-fs-pre.target @585ms
>                           └─keyboard-setup.service @235ms +346ms
>                             └─systemd-journald.socket @226ms
>                               └─system.slice @225ms
>                                 └─-.slice @220ms
>
> This appears to be some kind of new package management system for
> Ubuntu:
>
> Description-en: Tool to interact with Ubuntu Core Snappy.
>  Install, configure, refresh and remove snap packages. Snaps are
>  'universal' packages that work across many different Linux systems,
>  enabling secure distribution of the latest apps and utilities for
>  cloud, servers, desktops and the internet of things.
>
> Why it the Ubuntu package believes it needs to be fully started before
> the login screen can display is unclear to me.  It might be worth
> using systemctl to disable snapd.serivce and see if that makes things
> work better for you.
>
> 				- Ted

I removed snapd completely which did nothing.

Here are new logs:
systemd-analyze blame: https://hastebin.com/edehikuyeb.css
systemd-analyze critical-chain: https://hastebin.com/vedufafema.pl
dmesg: https://hastebin.com/zuwuwoxadu.vbs

I should also note that leaving the system untouched does not result in it booting: I must
provide a source of entropy, otherwise it just stays stuck. In both of the dmesgs I've given, I
manually provided entropy to the system after about 5 minutes of waiting.

Also, regardless of what's hanging on CRNG init, CRNG should be able to init on its own in a timely
manner without the need for user-provided entropy. Userspace was working fine before the recent CRNG
kernel changes, so I don't think this is a userspace bug.

-Sultan
