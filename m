Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeBUK5m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:57:42 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35785 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeBUK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:57:40 -0500
X-Google-Smtp-Source: AH8x2264RDr9tVn4dFT/nMqj23TDguaQ4c/9fZLEjkSKnyV+8Xi+vIQWUGygENrMLdpswQqLFbhczg==
Date: Wed, 21 Feb 2018 11:57:35 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] new driver for Valve Steam Controller
Message-ID: <20180221105735.GA15792@casa>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
 <CAM4jgCqPwHiqi9ecehE6wXi1fevSbqUSB3ABVNHXD1NCstGVZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM4jgCqPwHiqi9ecehE6wXi1fevSbqUSB3ABVNHXD1NCstGVZw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:39:49AM +0100, Clément VUCHENER wrote:
> Hi Rodrigo,

Hello, Clément!

> I have written a kernel driver [1], some time ago. I did not submit it
> for merging in the main-line because I thought that would mess with
> user-space drivers. If your driver create an input device, a
> user-space driver will have to disable it before creating its own. I
> guess libusb based drivers will detach the kernel driver and will be
> fine. But it is not as simple if you use hidraw. And there may be some
> state problem as Pierre-Loup already said.


I not think that is a real problem. You can run this driver and a
user-space driver and the Steam Client all at the same time. You will
have several input devices that represet the same physical device. But
as long as the user client (game) uses only one of them, all will be
fine. That is, as long as the different drivers do not send any stateful
commands, of course.

> A few more tips about your discussion with Pierre-Loup (sorry I am not
> replying to the answers directly, it's hard to insert myself in this
> long discussion):
> 
> Beside Ynsta's driver, you may have a look at my own user-space driver
> [2] or Dennis Hamester's library scraw [3].
> 
> You can enable and disable the accel and gyro when the separate input
> device is opened or closed to save battery. My kernel driver does it,
> IIRC I have taken the idea from the wiimote driver.

Yeah, my future accel/gyro patch does exactly that. I copied the wii
too.

Also, my intention is to add a module variable so that the separate
input device is disabled by default and Steam Client will work properly.

> Note that there is
> an issue with joydev using the accel/gyro input device. hid-sony
> solved it by adding an exception in joydev driver (joydev_blacklist in
> drivers/input/joydev.c).

I don't know about that, I will look into it, thanks.

> In my driver, I split the left pad and left stick events by looking at
> the left pad touch bit. It works well as long as they are not used at
> the same time. When they both being used the data alternate between
> left pad and left stick data, the touch bit is set accordingly so axis
> data is easy to use, but it looks like the left touch pad is being
> tapped very fast.

Actually, there is a proper way to do that, that involves using the
lpad_touch and the lpand_and_joy bits at the same time. I think that I
will split the joystick and left-pad axes definitely. Few problems that
way. Maybe I'll map the left-pad to ABS_HAT1{X,Y}, that will play nicely
with the dpad being ABS_HAT0{X,Y].

Regards.
Rodrigo

> [1]: https://github.com/cvuchener/steamcontroller-linux-kernel
> [2]: https://github.com/cvuchener/input-scripts/tree/master/src/daemon/steamcontroller
> [3]: https://gitlab.com/dennis-hamester/scraw)
