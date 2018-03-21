Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeCUPsC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:48:02 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:45649 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeCUPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:47:55 -0400
X-Google-Smtp-Source: AG47ELv0uiQguUDGCGgiIyWJZ0XoKHYa13ZC9iD7EQojDZaBKMqfL2R0JUi7ViKr6UzkRqCMLFYqM8hHQJ1BpRSoKz4=
MIME-Version: 1.0
In-Reply-To: <20180319200813.GA18746@casa>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
 <CAM4jgCq5UT0SBKA1DMfsAKd8R+yn0ViPr0U-iE8-tWjgA9hTTQ@mail.gmail.com>
 <20180312205158.GB21621@casa> <CAO-hwJJqDM5Y7t-hpZ_s7EzjVki00ME7fd_7iUWcgaTZ9o906g@mail.gmail.com>
 <20180315210659.GA16037@casa> <1c75c511-eada-585e-297f-e90feb17ac8c@valvesoftware.com>
 <20180319200813.GA18746@casa>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 21 Mar 2018 16:47:53 +0100
Message-ID: <CAO-hwJK3x-tgzqy_MOSfPCpeyAuJ1+uCcatY+vAf7Q16_P73Mg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] new driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

On Mon, Mar 19, 2018 at 9:08 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> On Sat, Mar 17, 2018 at 02:54:07PM -0700, Pierre-Loup A. Griffais wrote:
>>
>>
>> On 03/15/2018 02:06 PM, Rodrigo Rivas Costa wrote:
>> > On Wed, Mar 14, 2018 at 05:39:25PM +0100, Benjamin Tissoires wrote:
>> > > On Mon, Mar 12, 2018 at 9:51 PM, Rodrigo Rivas Costa
>> > > <rodrigorivascosta@gmail.com> wrote:
>> > > > On Mon, Mar 12, 2018 at 03:30:43PM +0100, Clément VUCHENER wrote:
>> > > > > 2018-03-11 20:58 GMT+01:00 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>:
>> > > > > > This patchset implements a driver for Valve Steam Controller, based on a
>> > > > > > reverse analysis by myself.
>> > > > > >
>> > > > > > Sorry, I've been out of town for a few weeks and couldn't keep up with this...
>> > > > > >
>> > > > > > @Pierre-Loup and @Clément, could you please have another look at this and
>> > > > > > check if it is worthy? Benjamin will not commit it without an express ACK from
>> > > > > > Valve. Of course he is right to be cautious, but I checked this driver with
>> > > > > > the Steam Client and all seems to go just fine. I think that there is a lot of
>> > > > > > Linux out of the desktop that could use this driver and cannot use the Steam
>> > > > > > Client. Worst case scenario, this driver can now be blacklisted, but I hope
>> > > > > > that will not be needed.
>> > > > >
>> > > > > I tested the driver with my 4.15 fedora kernel (I only built the
>> > > > > module not the whole kernel) and I got double inputs (your driver
>> > > > > input device + steam uinput device) when testing Shovel Knight with
>> > > > > Steam Big Picture. It seems to work fine when the inputs are the same,
>> > > > > but after changing the controller configuration in Steam, the issue
>> > > > > became apparent.
>> > > >
>> > > > I assumed that when several joysticks are available, games would listen
>> > > > to one one of them. It looks like I'm wrong, and some (many?) games will
>> > > > listen to all available joysticks at the same time. Thus having two
>> > > > logical joysticks that represent the same physical one is not good.
>> > >
>> > > Yeah, the general rule of thumb is "think of the worst thing that can
>> > > happen, someone will do something worst".
>> > >
>> > > >
>> > > > An easy solution would be that Steam Client grabs this driver
>> > > > (ioctl(EVIOCGRAB)) when creating the uinput device. Another solution
>> > > > would be that Steam Client blacklists this driver, of course.
>> > >
>> > > This is 2 solutions that rely on a userspace change, and this is not
>> > > acceptable in its current form. What if people do not upgrade Steam
>> > > client but upgrade their kernel? Well, Steam might be able to force
>> > > people to always run the latest shiny available version, but for other
>> > > games, you can't expect people to have a compatible version of the
>> > > userspace stack.
>> >
>> > Well, if you don't have Steam then you don't have the double input in
>> > the first place. Unless you are using a different user-mode driver, of
>> > course.
>> > >
>> > > Also, "blacklisting the driver" from Steam client is something the OS
>> > > can do, but not the client when you run on a different distribution.
>> > > You need root for that, and I don't want to give root permissions to
>> > > Steam (or to any user space client that shouldn't have root privileges
>> > > for what it matters).
>> >
>> > Actually Steam needs a system installation that adds udev rules to grant
>> > uaccess to /dev/uinput and the USB raw device for the controller.
>> > Adding a /etc/modprobe.d/steam.conf should be possible, too. It would be
>> > a bit inconvenient because you'll need a distro update of the steam
>> > package, not just the usual user-mode-only auto-update.
>>
>> It's definitely a bit tricky; we've rolled out an update to our reference
>> package whenever we've added support for new devices (the final Steam
>> Controller, direct PS4 gamepad led/gyro access through HID, HTC Vive and its
>> myriad of onboard devices, bootloaders of all these things for firmware
>> updates, etc). Whenever we have to do that, the rollout never is as smooth
>> as desired: many users aren't using our own package; even on the
>> distributions we support directly. Then downstream distributions adopt these
>> udev changes with various delays (sometimes never), and port them to their
>> own mechanism of doing things, since everyone has their own idea of a robust
>> security model. I wish local sessions always had proper access to HID
>> devices connected to the physical computer the user is sitting at, but I
>> realize that the basic gaming desktop is just one of many usecases distros
>> out there have to support and it'd be unreasonable to expect them to focus
>> exclusively on it.
>
> I was afraid of something like that. Let's forget about that option for
> the moment.
>
>> > > > > And without Steam and your external tool, you get double inputs too. I
>> > > > > tried RetroArch and it was unusable because of the keyboard inputs
>> > > > > from the lizard mode (e.g. pressing B also presses Esc and quits
>> > > > > RetroArch). Having to download and compile an external tool to make
>> > > > > the driver work properly may be too difficult for the user. Your goal
>> > > > > was to provide an alternative to user space drivers but now you
>> > > > > actually depend on (a very simple) one.
>> > > >
>> > > > Yes, I noticed that. TBH, this driver without Steam Client or the
>> > > > user-space tool is not very nice, precisely because you'll get constant
>> > > > Escape and Enter presses, and most games react to those.
>> > > >
>> > > > Frankly speaking, I'm not sure how to proceed. I can think of the
>> > > > following options:
>> > > >   1.Steam Client installation could add a file to blacklist
>> > > >     hid-steam, just as it adds a few udev rules.
>> > >
>> > > But what about RetroArch? And what if you install Steam but want to
>> > > play SDL games that could benefit from your driver?
>> >
>> > That is an issue of solution 1. I actually have the module blacklisted
>> > in my PC, and run `sudo modprobe hid-steam` to use SDL.
>> >
>> > > >   2.The default CONFIG_HID_STEAM can be changed to "n". Maybe only
>> > > >     on the architectures for which there is a Steam Client available.
>> > > >     This way DIY projects will still be able to use it.
>> > >
>> > > But this will make the decision to include or not the driver in
>> > > distributions harder. And if no distribution uses it, you won't have
>> > > free tests, and you will be alone to maintain it. So that's not ideal
>> > > either
>> >
>> > Could we set the default to 'y' in non-PC systems. It would be enabled
>> > in my Raspbian, for example... better than nothing.
>> > >
>> > > >   3.This driver could be abandoned :-(. Just use Steam Client if possible or
>> > > >     any of the user-mode drivers available.
>> > >
>> > > This would be a waste for everybody as it's always better when we share.
>> >
>> > Indeed!
>> >
>> > I tried a new option:
>> >    4. The driver detects whether the DEVUSB/HIDRAW device is in use, and
>> >       if that is the case it will disable itself. If the DEVUSB/HIDRAW is
>> >       not in use, then the driver will work normally. A bit hackish maybe
>> >       but it should work.
>> >
>> > I tried doing this option 4, but I'm unable to do it properly. I don't
>> > even know if it is possible...
>> >
>> > > >
>> > > > If we decide for 1 or 2, then the lizard mode could be disabled without
>> > > > ill effects. We could even enable the gyro and all the other gadgets
>> > > > without worring about current compatibility.
>> > >
>> > > To me, 1 is out of the question. The kernel can't expect a user space
>> > > change especially if you are knowingly introducing a bug for the end
>> > > user.
>> > >
>> > > 2 is still on the table IMO, and 3 would be a shame.
>> > >
>> > > I know we already discussed about sysfs and module parameters, but if
>> > > the driver will conflict with a userspace stack, the only way would be
>> > > to have a (dynamic) parameter "enhanced_mode" or
>> > > "kernel_awesome_support" or whatever which would be a boolean, that
>> > > defaults to false that Steam can eventually lookup if they want so in
>> > > the future we can default it to true. When this parameter is set, the
>> > > driver will create the inputs and toggle the various modes, while when
>> > > it's toggled off, it'll clean up itself and keep the device as if it
>> > > were connected to hid-generic. Bonus point, this removes the need for
>> > > the simple user space tool that enables the mode.
>> >
>> > That is doable, but that sysfs/parameter can be changed by a non-root
>> > user? I looked for a udev rule to grant access to those but found
>> > nothing.
>> >
>> > IIUC, when this parameter is false the driver will do nothing, right?
>> > The user will just need to change it to true to be able to use it, but
>> > that will have to be done by root.
>> >
>> > I'll try doing this, but I'd appreciate your advice about what approach
>> > would be better: sysfs? a module parameter? a cdev? or even a EV_MSC?
>> >
>> > > > At the end of the day, I think that it is up to Valve what to do.
>> > >
>> > > Again, Valve is a big player here, but do not underestimate other
>> > > projects (like RetroArch mentioned above) because if you break their
>> > > workflow, they will have the right to request a revert of the commit
>> > > because it breaks some random user playing games in the far end of
>> > > Antarctica (yes, penguins do love to play games :-P )
>> >
>> > And everybody loves penguins! If we take away Steam (say a RaspberryPi
>> > as a canonical example) and disable the lizard mode, then this driver is
>> > just a regular gamepad. RetroArch should be happy with that. Unless they
>> > already have an user mode driver for the steam-controller, of course...
>>
>> Both of these things seem reasonable to me, with a few caveats:
>>
>>  - If there's an opt-in mechanism available, it would be good to ensure we
>> have a way to reliably query its state without requiring extra permissions.
>> This way, if we know it's likely to affect Steam client functionality, we'll
>> have the right mechanism to properly message the situation to users.
>>
>>  - If you find a way for the client to be able to program an opt out when
>> it's running that is not automatic (eg. by detecting the hidraw device being
>> opened), we'd be happy to participate with that scheme assuming it doesn't

The only concern I have with detecting if hidraw is opened or not is
that there are other tools that will want to open hidraw to do
something entirely different. But I agree, this is the least intrusive
solution as far as I can see.

>> require extra permissions. As soon as the API is figured out, we can include
>> it in the client, just send me a heads-up. The one thing that I'd be
>> cautious of is robust behavior against abnormal client termination. If it's
>> a sysfs entry we have to poke, I'm worried that if the client crashes we
>> might not always be able to opt the driver back out. It'd be nice if it was
>> based on opening an fd instead, this way the kernel would robustly clean up
>> after us and your driver would kick back in.
>
> Ok, I've written the following scheme:
>  * I've added a member to struct steam_device: int hid_usage_count.
>  * Whenver I call hid_hw_open(), hid_usage_count is incremented.
>  * Whenver I call hid_hw_close(), hid_usage_count is decremented.
>
> Now, with this little function:
>
> static bool steam_is_only_client(struct steam_device *steam)
> {
>         unsigned int count = steam->hdev->ll_open_count;
>         return count == steam->hid_usage_count;
> }
>
> I can check if the hidraw device is opened from user-space. It is nice
> because it works not only for SteamClient, but any other user-space
> hid driver. And it is resistent to crashes, too.
>
> It is a bit hacky because I don't think ll_open_count is intended for

Definitively too hacky for me :)
It seems to be working, but AFAIU, there is still the emulated
keyboard/mouse in place that call hid_hw_open() when they are opened.
So you do not really know if the mismatch comes from extra eyes on the
other hidinput devices or from hidraw.

> that, and it is usually protected by a mutex...  The proper way, IMO,
> would be to have a callback for when the hidraw is first opened/last
> closed, but that does not exist, AFAICT.

The callback doesn't exists because no one actually had the need to.
This particular use case could be a reason to implement such system.
However, I think we should think of the design of the 'callback'
really carefully so it is generic enough to be reused for other cases.

One thing that would be of a help here would be if you overwrite the
low-level transport driver (struct hid_ll_driver) in hid-steam
directly. You basically just duplicate the current ll_driver and
overwrite only the functions you are interested in.
If, for instance, you add a hint to hid_hw_open/close() telling who
opened/closed the device, you could create some new entries in
hid_ll_driver .opening and .closed that would be called before
entering/leaving hid_hw_open/close().
You could even snoop the various requests in hid_hw_(raw_)request() in
case you know what to expect from the client.

This is just an idea and not a formal ack, but it might worth
investigating this path.

>
> But hey, it works. The mutexless access is not a big deal, because I
> call this function on every input report, so I will get the right value
> eventually.

ouch. That's a no from me for this implementation then. Testing it for
every input report seems overkill. Also, I do not understand correctly
how you will send your own commands if the hidraw node is opened.
Could you send the patch as an RFC so we have a good idea of what we
are talking here. But from what I understand, it would be wiser to
have the infrastructure to get notified when the hidraw node is used
by Steam or any other client and do your magic here.

[sometime later]
Actually, if there is no magic command involved to "disable" hid-steam
and let Steam handle the touchpad itself it should be fine. But if the
touchpad is configured in a non default mode, will Steam reset the
controller when it opens the hidraw node? (talking about the current
Steam client, not possible future changes)

>
> Then if I am the only user, I can disable/enable the lizard mode when
> opening/closing the input device. Moreover if hidraw is opened, then I
> bypass the input events, and this gamepad goes idle, preventing the
> double input problem. It's a bit tricky in the details, but I think I
> got it right.

Wouldn't it be better to actually kill the extra input nodes instead
of keeping them around? This way users will only see one Steam
controller joystick. Also, this would prevent the use case where you
open Steam, minimize it (so the joystick are disabled), and then start
an SDL game to wait until you download the latest patch for your
favorite game.
Of course Steam could close the hidraw node on minimize, but it'll be
better IMO to be explicit in this particular case.

>
> If you don't think this solution is too hacky, I'll post a reroll with
> this code, in a few days. I still have to do a few more tests.

Please send the reroll, even if not entirely tested. It'll allow
everyone involved to have a better idea of the solution and will help
everyone to find the correct solution.

Cheers,
Benjamin

>
> Now, what I would really want is a review by Valve of my set-lizard function:
>
> static void steam_set_lizard_mode(struct steam_device *steam, bool enabled)
> {
>         if (enabled) {
>                 steam_send_report_byte(steam, 0x8e); //enable mouse
>                 steam_send_report_byte(steam, 0x85); //enable esc, enter and cursor keys
>         } else {
>                 steam_send_report_byte(steam, 0x81); //disable esc, enter and cursor keys
>                 steam_write_register(steam, 0x08, 0x07); //disable mouse (cmd: 0x87)
>         }
> }
>
> While it works, I find its asymmetry quite uncanny. I'm afraid that some
> of these are there for a side effect, this is not their real purpose.
> Could you give me a hint about this?
>
>> Note that there's a general desire on our side to create a reference
>> userspace implementation that would more or less have the current
>> functionality of the Steam client, but would be easily usable from other
>> platforms where the client doesn't currentl run. Unfortunately it's quite a
>> bit of work, so it's unclear what the timeframe would be, if it ever does
>> happen.
>
> Do you mean the piece of Steam Client that does input-mapping, but as a
> portable program without the full client? That would be awesome! And if
> open-sourced, even awesomer!!
>
> Thank you all.
> Rodrigo
>
>> Thanks,
>>  - Pierre-Loup
>>
>> >
>> > Best regards.
>> > Rodrigo
>> >
>> > > Cheers,
>> > > Benjamin
>> > >
>> > > > Best Regards.
>> > > > Rodrigo.
>> > > >
>> > > > > Also the button and axis codes do not match the gamepad API doc
>> > > > > (https://www.kernel.org/doc/Documentation/input/gamepad.txt).
>> > > > >
>> > > > > >
>> > > > > > For full reference, I'm adding a full changelog of this patchset.
>> > > > > >
>> > > > > > Changes in v5:
>> > > > > >   * Fix license SPDX to GPL-2.0+.
>> > > > > >   * Minor stylistic changes (BIT(3) instead 0x08 and so on).
>> > > > > >
>> > > > > > Changes in v4:
>> > > > > >   * Add command to check the wireless connection status on probe, without
>> > > > > >     waiting for a message (thanks to Clément Vuchener for the tip).
>> > > > > >   * Removed the error code on redundant connection/disconnection messages. That
>> > > > > >     was harmless but polluted dmesg.
>> > > > > >   * Added buttons for touching the left-pad and right-pad.
>> > > > > >   * Fixed a misplaced #include from 2/4 to 1/4.
>> > > > > >
>> > > > > > Changes in v3:
>> > > > > >   * Use RCU to do the dynamic connec/disconnect of wireless devices.
>> > > > > >   * Remove entries in hid-quirks.c as they are no longer needed. This allows
>> > > > > >     this module to be blacklisted without side effects.
>> > > > > >   * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
>> > > > > >     existing use cases (lizard mode). A user-space tool to do that is
>> > > > > >     linked.
>> > > > > >   * Fully separated axes for joystick and left-pad. As it happens.
>> > > > > >   * Add fuzz values for left/right pad axes, they are a little wiggly.
>> > > > > >
>> > > > > > Changes in v2:
>> > > > > >   * Remove references to USB. Now the interesting interfaces are selected by
>> > > > > >     looking for the ones with feature reports.
>> > > > > >   * Feature reports buffers are allocated with hid_alloc_report_buf().
>> > > > > >   * Feature report length is checked, to avoid overflows in case of
>> > > > > >     corrupt/malicius USB devices.
>> > > > > >   * Resolution added to the ABS axes.
>> > > > > >   * A lot of minor cleanups.
>> > > > > >
>> > > > > > Rodrigo Rivas Costa (4):
>> > > > > >    HID: add driver for Valve Steam Controller
>> > > > > >    HID: steam: add serial number information.
>> > > > > >    HID: steam: command to check wireless connection
>> > > > > >    HID: steam: add battery device.
>> > > > > >
>> > > > > >   drivers/hid/Kconfig     |   8 +
>> > > > > >   drivers/hid/Makefile    |   1 +
>> > > > > >   drivers/hid/hid-ids.h   |   4 +
>> > > > > >   drivers/hid/hid-steam.c | 794 ++++++++++++++++++++++++++++++++++++++++++++++++
>> > > > > >   4 files changed, 807 insertions(+)
>> > > > > >   create mode 100644 drivers/hid/hid-steam.c
>> > > > > >
>> > > > > > --
>> > > > > > 2.16.2
>> > > > > >
>> >
>>
