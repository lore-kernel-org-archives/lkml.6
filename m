Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeBVJKp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:10:45 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34271 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbeBVJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:10:42 -0500
X-Google-Smtp-Source: AH8x224BhHeYPbY7l4Epe/vUW0xcrtXk0dD+6dFm+rsxri7gR6Ne7pTd7DHqlPibOS5j6hefWgmXUuG7vLJcCI1PEjo=
MIME-Version: 1.0
In-Reply-To: <77b62733-a1ed-16f2-f942-39c27c0f5924@valvesoftware.com>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
 <673a2510-7d82-1b24-1085-9f5aa2bb9998@valvesoftware.com> <20180220232035.GA28798@casa>
 <52b10af3-d93b-34b2-e6ba-22621511b16f@valvesoftware.com> <20180221202107.GA21140@casa>
 <77b62733-a1ed-16f2-f942-39c27c0f5924@valvesoftware.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 22 Feb 2018 10:10:40 +0100
Message-ID: <CAO-hwJJe+vUHJJLkpanzo0kgXUpsL4XVm_hU--9BqV458njVrA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] new driver for Valve Steam Controller
To: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 1:13 AM, Pierre-Loup A. Griffais
<pgriffais@valvesoftware.com> wrote:
>
>
> On 02/21/2018 12:21 PM, Rodrigo Rivas Costa wrote:
>>
>> On Tue, Feb 20, 2018 at 04:09:39PM -0800, Pierre-Loup A. Griffais wrote:
>>>
>>> On 02/20/2018 03:20 PM, Rodrigo Rivas Costa wrote:
>>>>
>>>> On Tue, Feb 20, 2018 at 02:29:48PM -0800, Pierre-Loup A. Griffais wrote:
>>>> About the left trackpad/joystick, currently I'm not treating them
>>>> different. I'm out of ABS axes, and anyway, it is not likely that the
>>>> left pad and the joystick be used at the same time (I only have one left
>>>> thumb). Nevertheless, if we really want to make them apart, we can use
>>>> bits 10.3 (lpad_touch) and 10.7 (lpad_and_joy) together. I described the
>>>> details in [2], but I'm not currently doing that in this driver.
>>>
>>>
>>> I didn't necessarily mean exposing it, but in the event a user is using
>>> both
>>> at the same time (it happens, using claw grip with some games is
>>> necessary
>>> to use the D-pad while deflecting the stick), then you'll most likely run
>>> into issues unless you demux the inbound data, since we were also out of
>>> left analog fields and mux them together if used at the same time. Not
>>> sure
>>> if you're already handling that case, but not doing it would result in
>>> the
>>> stick appearing to fully deflect every other input report if the user is
>>> doing both at the same time.
>>
>>
>> "Claw grip"? Is that a real thing? Yes, it is! Well, you're totally
>> right. I think that it will be best to fully separate the left-pad and
>> the joystick. Maybe the left-pad can be mapped to ABS_HAT1{X,Y]...
>>
>>>> About the gyroscope/acceleration/quaternion, you know the issue
>>>> that the wireless gives gyro plus quat but no accel, while the wired
>>>> gives all three. My general idea is to create an additional input device
>>>> with INPUT_PROP_ACCELEROMETER to expose what is available. Pity is that
>>>> the wireless gives no accel, maybe there is some command to enable it?
>>>
>>>
>>> It should be three neighboring bits for that setting; does this not work
>>> for
>>> you?
>>>
>>> // Bitmask that define which IMU features to enable.
>>> typedef enum
>>> {
>>>         SETTING_GYRO_MODE_OFF                           = 0x0000,
>>>         SETTING_GYRO_MODE_STEERING                      = 0x0001,
>>>         SETTING_GYRO_MODE_TILT                          = 0x0002,
>>>         SETTING_GYRO_MODE_SEND_ORIENTATION      = 0x0004,
>>>         SETTING_GYRO_MODE_SEND_RAW_ACCEL        = 0x0008,
>>>         SETTING_GYRO_MODE_SEND_RAW_GYRO         = 0x0010,
>>> } SettingGyroMode;
>>
>>
>> Thanks for that, it will be useful! Those are the values to be written
>> to what I called "register 0x30" with {0x87 0x03 0x30 X 0x00}. Currently
>> I am writing 0x14 to enable and 0x00 to disable. I suspected it was a
>> bit-field...
>>
>>> In general I'm concerned about sending of the gyro-enable message
>>> potentially impairing Steam functionality if it's running at the same
>>> time
>>> (eg. if gyro gets disabled over the radio while Steam still needs it), or
>>> sending any stateful messages to the device. For instance, are you ever
>>> sending the "blank configuration" setting? I assume you must be or users
>>> would still get keyboard/mouse input over these USB endpoints while
>>> trying
>>> to interact with the controller. But sending this after Steam programmed
>>> a
>>> setting, or instructed the controller to go back to lizard mode because
>>> it
>>> was requested by a configuration, would be problematic.
>>
>>
>> Sure, but this patchset should be safe, shouldn't it?
>> Maube future patches that play with the gyro/force-feedback could be
>> disabled by default, and could need a module parameter to be enabled.
>> That way Steam Client will work out-of-the-box anywhere but proficient
>> users could use the extra functionality easily.
>>
>> Related to that, Benjamin Tissoires replied to 1/3:
>>>>
>>>> --- a/drivers/hid/hid-quirks.c
>>>> +++ b/drivers/hid/hid-quirks.c
>>>> @@ -629,6 +629,10 @@ static const struct hid_device_id
>>>> hid_have_special_driver[] = {
>>>>   #if IS_ENABLED(CONFIG_HID_SPEEDLINK)
>>>>          { HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS,
>>>>          USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE) },
>>>>   #endif
>>>> +#if IS_ENABLED(CONFIG_HID_STEAM)
>>>> +       { HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
>>>> USB_DEVICE_ID_STEAM_CONTROLLER) },
>>>> +       { HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
>>>> USB_DEVICE_ID_STEAM_CONTROLLER_WIRELESS) },
>>>> +#endif
>>>
>>>
>>> In addition to the discussion in 0/3, I wonder if you should not
>>> remove this hunk. Unless having hid-generic binding the device before
>>> your hid-steam driver, it would be better not force the Steam boxes to
>>> use your driver.
>>
>>
>> I don't really see the point on that. If we do that I'll have to unbind
>> and bind the device manually, and that is a pain, and impossible without
>> root (my ultimate goal is to use this controller with my Tizen TV ;-P).

I guess you are not running v4.16-rc2 :) (see Clement answers too)

Since v4.16, there is no need to absolutely blacklist the devices in
this list. hid-generic will bind them first, but as soon as an other
driver claims the device, hid-generic unbinds itself and let the other
driver to handle the device. Without any user input!

>>
>> And anyway this driver is mostly harmless, the only visible changes from
>> userspace are the new input and power devices, and that the virtual
>> keyboard/mouse are no more.

Pierre-Loup mentioned that sometime the Steam client needs those
interfaces for the Desktop mode. I have the feeling things are going
to be too intricated for us to gracefully accept the driver unless
there is a clear ACK from Valve that they are happy with the new
driver.

>> If the virtual devices are really missed we
>> could use:
>>
>>         hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>>
>> on them, maybe with a module parameter? Note that one of the first
>> things the Steam Client does is to disable the virtual devices (with a
>> command to the device).
>> (TBH I always had the impression that those virtual devices are there
>> to move the Grub menu...)
>>
>> If Valve people really feel that this driver is not needed for SteamOS,
>> because the Steam Client is always running, then SteamOS can always do
>> CONFIG_HID_STEAM=n.

That is what I was expecting, but if the driver also breaks the
regular Steam client, we have a situation :)

>
>
> Yes, certainly; that isn't really the usecase I'm worried about. What I'm
> worried about is behavior changing for existing users of the controller on
> normal desktop distributions. Currently the Steam client will program these
> pieces of state (enable/disable direct keyboard/mouse HID functionality,
> enable/disable gyro/accel) based on the user's configuration, and a user
> getting a kernel update that includes a driver that also programs that
> without their intervention is bound to affect the behavior. If there was a
> way to make it so the states won't be programmed until it's pretty clear the
> user is trying to use that driver's functionality, that would feel safer.

I do not think there is a way to know beforehand, given that the
kernel module will be loaded first, and sometimes even without the
root file system if the driver has been included in the initramfs
(which is the point of not having the device blacklisted in
hid-quirks.c)

I guess the only reasonable solution would be for the kernel HID
driver to expose all the interfaces (keyboard, touchpad, gyro, etc...)
but not take any action on whether which mode it switches into. Then,
(and unfortunatelly) though a custom sysfs API, we could teach SDL or
any other configurator to change the device into the desired mode.
I would prefer not having a custom sysfs API, but this would allow us
to change the owner to a non-root user while hidraw needs to have the
root access.

An other solution than the sysfs API, would be to have a small driver
in libratbag (or a similar daemon) that sends the mode switch command
as if the joystick where a special gaming mouse.

Cheers,
Benjamin

>
>
> Thanks,
>  - Pierre-Loup
>
>>
>> Regards.
>> Rodrigo
>>
>
