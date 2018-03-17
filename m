Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCQWAS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:00:18 -0400
Received: from us-smtp-delivery-172.mimecast.com ([63.128.21.172]:25320 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751697AbeCQWAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:00:14 -0400
Subject: Re: [PATCH v5 0/4] new driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: =?UTF-8?Q?Cl=c3=a9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
 <CAM4jgCq5UT0SBKA1DMfsAKd8R+yn0ViPr0U-iE8-tWjgA9hTTQ@mail.gmail.com>
 <20180312205158.GB21621@casa>
 <CAO-hwJJqDM5Y7t-hpZ_s7EzjVki00ME7fd_7iUWcgaTZ9o906g@mail.gmail.com>
 <20180315210659.GA16037@casa>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <1c75c511-eada-585e-297f-e90feb17ac8c@valvesoftware.com>
Date: Sat, 17 Mar 2018 14:54:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315210659.GA16037@casa>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-Mlf-Version: 8.3.2.6535
X-Mlf-UniqueId: o201803172154020005389
X-MC-Unique: s7u7FGz-NJ2ZJ14BSPUurw-1
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2HM0QnU019103



On 03/15/2018 02:06 PM, Rodrigo Rivas Costa wrote:
> On Wed, Mar 14, 2018 at 05:39:25PM +0100, Benjamin Tissoires wrote:
>> On Mon, Mar 12, 2018 at 9:51 PM, Rodrigo Rivas Costa
>> <rodrigorivascosta@gmail.com> wrote:
>>> On Mon, Mar 12, 2018 at 03:30:43PM +0100, Clément VUCHENER wrote:
>>>> 2018-03-11 20:58 GMT+01:00 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>:
>>>>> This patchset implements a driver for Valve Steam Controller, based on a
>>>>> reverse analysis by myself.
>>>>>
>>>>> Sorry, I've been out of town for a few weeks and couldn't keep up with this...
>>>>>
>>>>> @Pierre-Loup and @Clément, could you please have another look at this and
>>>>> check if it is worthy? Benjamin will not commit it without an express ACK from
>>>>> Valve. Of course he is right to be cautious, but I checked this driver with
>>>>> the Steam Client and all seems to go just fine. I think that there is a lot of
>>>>> Linux out of the desktop that could use this driver and cannot use the Steam
>>>>> Client. Worst case scenario, this driver can now be blacklisted, but I hope
>>>>> that will not be needed.
>>>>
>>>> I tested the driver with my 4.15 fedora kernel (I only built the
>>>> module not the whole kernel) and I got double inputs (your driver
>>>> input device + steam uinput device) when testing Shovel Knight with
>>>> Steam Big Picture. It seems to work fine when the inputs are the same,
>>>> but after changing the controller configuration in Steam, the issue
>>>> became apparent.
>>>
>>> I assumed that when several joysticks are available, games would listen
>>> to one one of them. It looks like I'm wrong, and some (many?) games will
>>> listen to all available joysticks at the same time. Thus having two
>>> logical joysticks that represent the same physical one is not good.
>>
>> Yeah, the general rule of thumb is "think of the worst thing that can
>> happen, someone will do something worst".
>>
>>>
>>> An easy solution would be that Steam Client grabs this driver
>>> (ioctl(EVIOCGRAB)) when creating the uinput device. Another solution
>>> would be that Steam Client blacklists this driver, of course.
>>
>> This is 2 solutions that rely on a userspace change, and this is not
>> acceptable in its current form. What if people do not upgrade Steam
>> client but upgrade their kernel? Well, Steam might be able to force
>> people to always run the latest shiny available version, but for other
>> games, you can't expect people to have a compatible version of the
>> userspace stack.
> 
> Well, if you don't have Steam then you don't have the double input in
> the first place. Unless you are using a different user-mode driver, of
> course.
>>
>> Also, "blacklisting the driver" from Steam client is something the OS
>> can do, but not the client when you run on a different distribution.
>> You need root for that, and I don't want to give root permissions to
>> Steam (or to any user space client that shouldn't have root privileges
>> for what it matters).
> 
> Actually Steam needs a system installation that adds udev rules to grant
> uaccess to /dev/uinput and the USB raw device for the controller.
> Adding a /etc/modprobe.d/steam.conf should be possible, too. It would be
> a bit inconvenient because you'll need a distro update of the steam
> package, not just the usual user-mode-only auto-update.

It's definitely a bit tricky; we've rolled out an update to our 
reference package whenever we've added support for new devices (the 
final Steam Controller, direct PS4 gamepad led/gyro access through HID, 
HTC Vive and its myriad of onboard devices, bootloaders of all these 
things for firmware updates, etc). Whenever we have to do that, the 
rollout never is as smooth as desired: many users aren't using our own 
package; even on the distributions we support directly. Then downstream 
distributions adopt these udev changes with various delays (sometimes 
never), and port them to their own mechanism of doing things, since 
everyone has their own idea of a robust security model. I wish local 
sessions always had proper access to HID devices connected to the 
physical computer the user is sitting at, but I realize that the basic 
gaming desktop is just one of many usecases distros out there have to 
support and it'd be unreasonable to expect them to focus exclusively on it.

> 
>>>
>>>> And without Steam and your external tool, you get double inputs too. I
>>>> tried RetroArch and it was unusable because of the keyboard inputs
>>>> from the lizard mode (e.g. pressing B also presses Esc and quits
>>>> RetroArch). Having to download and compile an external tool to make
>>>> the driver work properly may be too difficult for the user. Your goal
>>>> was to provide an alternative to user space drivers but now you
>>>> actually depend on (a very simple) one.
>>>
>>> Yes, I noticed that. TBH, this driver without Steam Client or the
>>> user-space tool is not very nice, precisely because you'll get constant
>>> Escape and Enter presses, and most games react to those.
>>>
>>> Frankly speaking, I'm not sure how to proceed. I can think of the
>>> following options:
>>>   1.Steam Client installation could add a file to blacklist
>>>     hid-steam, just as it adds a few udev rules.
>>
>> But what about RetroArch? And what if you install Steam but want to
>> play SDL games that could benefit from your driver?
> 
> That is an issue of solution 1. I actually have the module blacklisted
> in my PC, and run `sudo modprobe hid-steam` to use SDL.
> 
>>>   2.The default CONFIG_HID_STEAM can be changed to "n". Maybe only
>>>     on the architectures for which there is a Steam Client available.
>>>     This way DIY projects will still be able to use it.
>>
>> But this will make the decision to include or not the driver in
>> distributions harder. And if no distribution uses it, you won't have
>> free tests, and you will be alone to maintain it. So that's not ideal
>> either
> 
> Could we set the default to 'y' in non-PC systems. It would be enabled
> in my Raspbian, for example... better than nothing.
>>
>>>   3.This driver could be abandoned :-(. Just use Steam Client if possible or
>>>     any of the user-mode drivers available.
>>
>> This would be a waste for everybody as it's always better when we share.
> 
> Indeed!
> 
> I tried a new option:
>    4. The driver detects whether the DEVUSB/HIDRAW device is in use, and
>       if that is the case it will disable itself. If the DEVUSB/HIDRAW is
>       not in use, then the driver will work normally. A bit hackish maybe
>       but it should work.
> 
> I tried doing this option 4, but I'm unable to do it properly. I don't
> even know if it is possible...
> 
>>>
>>> If we decide for 1 or 2, then the lizard mode could be disabled without
>>> ill effects. We could even enable the gyro and all the other gadgets
>>> without worring about current compatibility.
>>
>> To me, 1 is out of the question. The kernel can't expect a user space
>> change especially if you are knowingly introducing a bug for the end
>> user.
>>
>> 2 is still on the table IMO, and 3 would be a shame.
>>
>> I know we already discussed about sysfs and module parameters, but if
>> the driver will conflict with a userspace stack, the only way would be
>> to have a (dynamic) parameter "enhanced_mode" or
>> "kernel_awesome_support" or whatever which would be a boolean, that
>> defaults to false that Steam can eventually lookup if they want so in
>> the future we can default it to true. When this parameter is set, the
>> driver will create the inputs and toggle the various modes, while when
>> it's toggled off, it'll clean up itself and keep the device as if it
>> were connected to hid-generic. Bonus point, this removes the need for
>> the simple user space tool that enables the mode.
> 
> That is doable, but that sysfs/parameter can be changed by a non-root
> user? I looked for a udev rule to grant access to those but found
> nothing.
> 
> IIUC, when this parameter is false the driver will do nothing, right?
> The user will just need to change it to true to be able to use it, but
> that will have to be done by root.
> 
> I'll try doing this, but I'd appreciate your advice about what approach
> would be better: sysfs? a module parameter? a cdev? or even a EV_MSC?
> 
>>> At the end of the day, I think that it is up to Valve what to do.
>>
>> Again, Valve is a big player here, but do not underestimate other
>> projects (like RetroArch mentioned above) because if you break their
>> workflow, they will have the right to request a revert of the commit
>> because it breaks some random user playing games in the far end of
>> Antarctica (yes, penguins do love to play games :-P )
> 
> And everybody loves penguins! If we take away Steam (say a RaspberryPi
> as a canonical example) and disable the lizard mode, then this driver is
> just a regular gamepad. RetroArch should be happy with that. Unless they
> already have an user mode driver for the steam-controller, of course...

Both of these things seem reasonable to me, with a few caveats:

  - If there's an opt-in mechanism available, it would be good to ensure 
we have a way to reliably query its state without requiring extra 
permissions. This way, if we know it's likely to affect Steam client 
functionality, we'll have the right mechanism to properly message the 
situation to users.

  - If you find a way for the client to be able to program an opt out 
when it's running that is not automatic (eg. by detecting the hidraw 
device being opened), we'd be happy to participate with that scheme 
assuming it doesn't require extra permissions. As soon as the API is 
figured out, we can include it in the client, just send me a heads-up. 
The one thing that I'd be cautious of is robust behavior against 
abnormal client termination. If it's a sysfs entry we have to poke, I'm 
worried that if the client crashes we might not always be able to opt 
the driver back out. It'd be nice if it was based on opening an fd 
instead, this way the kernel would robustly clean up after us and your 
driver would kick back in.

Note that there's a general desire on our side to create a reference 
userspace implementation that would more or less have the current 
functionality of the Steam client, but would be easily usable from other 
platforms where the client doesn't currentl run. Unfortunately it's 
quite a bit of work, so it's unclear what the timeframe would be, if it 
ever does happen.

Thanks,
  - Pierre-Loup

> 
> Best regards.
> Rodrigo
> 
>> Cheers,
>> Benjamin
>>
>>> Best Regards.
>>> Rodrigo.
>>>
>>>> Also the button and axis codes do not match the gamepad API doc
>>>> (https://www.kernel.org/doc/Documentation/input/gamepad.txt).
>>>>
>>>>>
>>>>> For full reference, I'm adding a full changelog of this patchset.
>>>>>
>>>>> Changes in v5:
>>>>>   * Fix license SPDX to GPL-2.0+.
>>>>>   * Minor stylistic changes (BIT(3) instead 0x08 and so on).
>>>>>
>>>>> Changes in v4:
>>>>>   * Add command to check the wireless connection status on probe, without
>>>>>     waiting for a message (thanks to Clément Vuchener for the tip).
>>>>>   * Removed the error code on redundant connection/disconnection messages. That
>>>>>     was harmless but polluted dmesg.
>>>>>   * Added buttons for touching the left-pad and right-pad.
>>>>>   * Fixed a misplaced #include from 2/4 to 1/4.
>>>>>
>>>>> Changes in v3:
>>>>>   * Use RCU to do the dynamic connec/disconnect of wireless devices.
>>>>>   * Remove entries in hid-quirks.c as they are no longer needed. This allows
>>>>>     this module to be blacklisted without side effects.
>>>>>   * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
>>>>>     existing use cases (lizard mode). A user-space tool to do that is
>>>>>     linked.
>>>>>   * Fully separated axes for joystick and left-pad. As it happens.
>>>>>   * Add fuzz values for left/right pad axes, they are a little wiggly.
>>>>>
>>>>> Changes in v2:
>>>>>   * Remove references to USB. Now the interesting interfaces are selected by
>>>>>     looking for the ones with feature reports.
>>>>>   * Feature reports buffers are allocated with hid_alloc_report_buf().
>>>>>   * Feature report length is checked, to avoid overflows in case of
>>>>>     corrupt/malicius USB devices.
>>>>>   * Resolution added to the ABS axes.
>>>>>   * A lot of minor cleanups.
>>>>>
>>>>> Rodrigo Rivas Costa (4):
>>>>>    HID: add driver for Valve Steam Controller
>>>>>    HID: steam: add serial number information.
>>>>>    HID: steam: command to check wireless connection
>>>>>    HID: steam: add battery device.
>>>>>
>>>>>   drivers/hid/Kconfig     |   8 +
>>>>>   drivers/hid/Makefile    |   1 +
>>>>>   drivers/hid/hid-ids.h   |   4 +
>>>>>   drivers/hid/hid-steam.c | 794 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>   4 files changed, 807 insertions(+)
>>>>>   create mode 100644 drivers/hid/hid-steam.c
>>>>>
>>>>> --
>>>>> 2.16.2
>>>>>
> 
