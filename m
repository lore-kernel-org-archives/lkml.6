Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeBTXUm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:20:42 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34121 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeBTXUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:20:40 -0500
X-Google-Smtp-Source: AH8x226y4eMhU0GWg+h4tfPPRMp94Fk76nSg3Ob+0v+++fErbKxbjg9rD9bJNDSKxkpn0CTRMOtsWA==
Date: Wed, 21 Feb 2018 00:20:35 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 0/3] new driver for Valve Steam Controller
Message-ID: <20180220232035.GA28798@casa>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
 <673a2510-7d82-1b24-1085-9f5aa2bb9998@valvesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673a2510-7d82-1b24-1085-9f5aa2bb9998@valvesoftware.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:29:48PM -0800, Pierre-Loup A. Griffais wrote:
> Hi Rodrigo,
> 
> Thanks for working on that! I have a few questions and remarks.
> 
> For the reverse-engineering part, there's a lot of existing reference in
> existing (user-space) drivers for the controllers like sc-controller, but
> feel free to reach out if you have any questions. It's overall pretty simple
> and there's nothing secret about how it functions; there are some quirks,
> however. Nothing secret about it, but also no documentation, so might as
> well be... Have you tried deflecting the analog stick while touching the
> left trackpad? You'll most likely need special handling there. How are you
> planning to expose enabling/disabling auxiliary data like gyro over
> wireless?

Yeah, I look for information about a year when I started on this. I read
Ynsta's user-mode driver [1] (I didn't find sc-controller), but I found
that a bit incomplete, so I wrote my own named `inputmap` [2]. 

About the left trackpad/joystick, currently I'm not treating them
different. I'm out of ABS axes, and anyway, it is not likely that the
left pad and the joystick be used at the same time (I only have one left
thumb). Nevertheless, if we really want to make them apart, we can use
bits 10.3 (lpad_touch) and 10.7 (lpad_and_joy) together. I described the
details in [2], but I'm not currently doing that in this driver.

About the gyroscope/acceleration/quaternion, you know the issue
that the wireless gives gyro plus quat but no accel, while the wired
gives all three. My general idea is to create an additional input device
with INPUT_PROP_ACCELEROMETER to expose what is available. Pity is that
the wireless gives no accel, maybe there is some command to enable it?

Also, ideally, we could expose the quat. data directly to userspace, but
I see no clear way to do that. Maybe defining INPUT_PROP_QUATERNION? I
also thought of computing yaw/pitch/roll from the quat. and exposing
those, but doing that requires atan2() and sin() (16-bit precision), and
that would be tricky. Any thoughts on that?

> Will this driver being loaded affect functionality of existing applications
> that talk to it through HID directly, like Steam or sc-controller? Will they
> be able to keep getting the same HID data they do today? If so, the extent
> of the work needed to support it in Steam might just be to ignore the
> controller device it's exposing, since Steam will expose that itself through
> its own means.

As it is, this patchset hould be pretty safe. The only command sent to
the controller is the get-serial-number, and that seems to do no harm to
Steam Client. Other than that, it only reads. Moreover, the hidraw
device is still created, so user-mode driver should keep working
(but AFAIK, Steam Client uses direct USB access, not hidraw).

Curiously, Steam Client does not show the new native Steam Controller
gamepad. That is, if I connect the Steam controller with hid-steam.ko
and an Acme HID gamepad, then in Steam Client controller settings I
see only two controllers, the managed Steam Controller (not HID) and the
Acme HID gamepad. I reckon that Steam Client recognizes that the
new HID device is a Steam Controller and ignores it in favor of its own
managed controller.

Regards.
Rodrigo

[1]: https://github.com/ynsta/steamcontroller
[2]: https://github.com/rodrigorc/inputmap
