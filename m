Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeBVJGC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:06:02 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:39827 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeBVJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:06:00 -0500
X-Google-Smtp-Source: AH8x226YH63+olaE6W0/4qGfptETacD+W/ugPpgl5AyjDVSV3UW8O3TFeTSCEcQkLXhGyMUDNfiX5E0sQCF56LDaCT4=
MIME-Version: 1.0
In-Reply-To: <77b62733-a1ed-16f2-f942-39c27c0f5924@valvesoftware.com>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
 <673a2510-7d82-1b24-1085-9f5aa2bb9998@valvesoftware.com> <20180220232035.GA28798@casa>
 <52b10af3-d93b-34b2-e6ba-22621511b16f@valvesoftware.com> <20180221202107.GA21140@casa>
 <77b62733-a1ed-16f2-f942-39c27c0f5924@valvesoftware.com>
From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date: Thu, 22 Feb 2018 10:05:59 +0100
Message-ID: <CAM4jgCpjdpA=DHftCfs7PA3yCO+v8h9NWXF-7hd4DVVKaLd7rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] new driver for Valve Steam Controller
To: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-22 1:13 GMT+01:00 Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>:
>
> On 02/21/2018 12:21 PM, Rodrigo Rivas Costa wrote:
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
>>
>> And anyway this driver is mostly harmless, the only visible changes from
>> userspace are the new input and power devices, and that the virtual
>> keyboard/mouse are no more. If the virtual devices are really missed we
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

hid_have_special_driver is no longer required (see patch "HID: core:
remove the absolute need of hid_have_special_driver[]" [1]). If I
understand Benjamin's intent correctly, the driver will still be used,
but if you have a conflict you can simply unload/blacklist the special
driver module and hid-generic will handle the device. This way there
is no need to recompile the kernel to disable the special driver while
keeping standard HID features working. User-space driver packagers
(e.g. steam packagers) could simply add a modprobe conf file to
blacklist the module and avoid conflicts.

[1]: https://patchwork.kernel.org/patch/10066303/
