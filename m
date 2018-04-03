Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeDCUsW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:48:22 -0400
Received: from smtp-1b.atlantis.sk ([80.94.52.26]:45902 "EHLO
        smtp-1b.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeDCUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:48:21 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Sony Vaio VGN-CS31S touch sensor buttons breaking touchpad
Date: Tue, 3 Apr 2018 22:48:16 +0200
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201804012321.56423.linux@rainbow-software.org> <201804022239.59370.linux@rainbow-software.org>
In-Reply-To: <201804022239.59370.linux@rainbow-software.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201804032248.16465.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 April 2018 22:39:59 Ondrej Zary wrote:
> On Sunday 01 April 2018 23:21:55 Ondrej Zary wrote:
> > Hello,
> > I got a Sony Vaio VGN-CS31S laptop with Synaptics touchpad that exhibits
> > weird behavior. It seems to work until I touch the "Touch Sensor Buttons"
> > bar above the keyboard - then the buttons start to act weirdly: click or
> > remain pressed (sometimes it breaks even without touching the bar).
> >
> > It seems to be a known problem with VGN-CS series:
> > https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-synaptics/+b
> >ug /774877
> > https://wiki.freegeekvancouver.org/article/Laptop_Troubleshooting
> > (mentions nasty partial workaround: psmouse.resetafter=1)
> >
> > Many models of the VGN-CS series have the Touch Sensor Buttons:
> > ftp://124.40.41.224/PUB/MANUALS/SWT/Z009/Z009690111.PDF
> >
> > From the hardware side (can be found in MBX-196 Quanta GD2 schematic),
> > the touch bar is a separate PS/2 device connected to third PS/2 port of
> > the EC (Embedded Controller) WPC775L. The touchpad is on the 1st PS/2
> > port, 2nd port is unused. However, the i8042 does not seem to support
> > multiplexing, the firmware probably combines the data internally somehow.
>
> Good news: it supports multiplexing but i8042_nomux is set because of:
>                 /*
>                  * Most (all?) VAIOs do not have external PS/2 ports nor
>                  * they implement active multiplexing properly, and
>                  * MUX discovery usually messes up keyboard/touchpad.
>                  */
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
>                         DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
>                 },
> in drivers/input/serio/i8042-x86ia64io.h
> (How can this be modified to exclude VGN-CS series?)
>
> Now only to write the touchbar driver... (seems to be detected at serio2 as
> PS/2 Generic Mouse)

The device acts almost as a synaptics touchpad. The 0x47 magic number (used in
detection) is replaced by 0x43.

The absolute packet format is simple:

BYTE  BIT 7 6 5 4 3 2 1 0
  1       1 0 Z Z Z Z Z Z  pressure (left)
  2       0 0 0 0 L L L L  position (left:11-8)
  3       L L L L L L L L  position (left:7-0)
  4       1 1 Z Z Z Z Z Z  pressure (right)
  5       0 0 0 A R R R R  position (right:11-8), A = AV MODE (center "button")
  6       R R R R R R R R  position (right:7-0)

(left = media player part, right = volume part)
maximum observed pressure was 0x38

Now find the command(s) to control the LEDs...

What's the best way to present these controls to user space?
Process the touch/drag actions in kernel. light up corresponding LEDs and
emit key presses?

-- 
Ondrej Zary
