Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933372AbeBUKjw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:39:52 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36517 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeBUKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:39:50 -0500
X-Google-Smtp-Source: AG47ELuXJTlGTFYC+/Haq6e5EcD3ETIrhrvhAYHQ6QBvFl04gi/bXxQ3+kR+35cszKznGD3LbXNTeBPUzzATmzBY/BA=
MIME-Version: 1.0
In-Reply-To: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date: Wed, 21 Feb 2018 11:39:49 +0100
Message-ID: <CAM4jgCqPwHiqi9ecehE6wXi1fevSbqUSB3ABVNHXD1NCstGVZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] new driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

I have written a kernel driver [1], some time ago. I did not submit it
for merging in the main-line because I thought that would mess with
user-space drivers. If your driver create an input device, a
user-space driver will have to disable it before creating its own. I
guess libusb based drivers will detach the kernel driver and will be
fine. But it is not as simple if you use hidraw. And there may be some
state problem as Pierre-Loup already said.

A few more tips about your discussion with Pierre-Loup (sorry I am not
replying to the answers directly, it's hard to insert myself in this
long discussion):

Beside Ynsta's driver, you may have a look at my own user-space driver
[2] or Dennis Hamester's library scraw [3].

You can enable and disable the accel and gyro when the separate input
device is opened or closed to save battery. My kernel driver does it,
IIRC I have taken the idea from the wiimote driver. Note that there is
an issue with joydev using the accel/gyro input device. hid-sony
solved it by adding an exception in joydev driver (joydev_blacklist in
drivers/input/joydev.c).

In my driver, I split the left pad and left stick events by looking at
the left pad touch bit. It works well as long as they are not used at
the same time. When they both being used the data alternate between
left pad and left stick data, the touch bit is set accordingly so axis
data is easy to use, but it looks like the left touch pad is being
tapped very fast.

[1]: https://github.com/cvuchener/steamcontroller-linux-kernel
[2]: https://github.com/cvuchener/input-scripts/tree/master/src/daemon/steamcontroller
[3]: https://gitlab.com/dennis-hamester/scraw)

2018-02-20 20:33 GMT+01:00 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>:
> This patchset implements a driver for Valve Steam Controller, based on a
> reverse analysis by myself.
>
> Notable changes from patchset v1:
>  * Remove references to USB. Now the interesting interfaces are selected by
>    looking for the ones with feature reports.
>  * Feature reports buffers are allocated with hid_alloc_report_buf().
>  * Feature report length is checked, to avoid overflows in case of
>    corrupt/malicius USB devices.
>  * Resolution added to the ABS axes.
>  * A lot of minor cleanups.
>
> Rodrigo Rivas Costa (3):
>   HID: add driver for Valve Steam Controller
>   HID: steam: add serial number information.
>   HID: steam: add battery device.
>
>  drivers/hid/Kconfig      |   8 +
>  drivers/hid/Makefile     |   1 +
>  drivers/hid/hid-ids.h    |   4 +
>  drivers/hid/hid-quirks.c |   4 +
>  drivers/hid/hid-steam.c  | 703 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 720 insertions(+)
>  create mode 100644 drivers/hid/hid-steam.c
>
> --
> 2.16.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
