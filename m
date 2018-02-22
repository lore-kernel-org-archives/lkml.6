Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBVAV7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:21:59 -0500
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:23175 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751158AbeBVAV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:21:57 -0500
Subject: Re: [PATCH 1/3] HID: add driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
 <CAO-hwJKmrapd-VtbRgsM_zr6mHDvG8eyvdmo=56W_kmURjvX4g@mail.gmail.com>
 <20180214232957.GB3741@casa>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <38f5205a-c40a-8052-b7a8-5693032cafc8@valvesoftware.com>
Date: Wed, 21 Feb 2018 16:19:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214232957.GB3741@casa>
Content-Language: en-US
X-Mlf-Version: 8.3.2.6535
X-Mlf-UniqueId: o201802220021540050492
X-MC-Unique: y743T2ZRMea7C9dXdA7rcw-1
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1M0M3HE006317

On 02/14/2018 03:29 PM, Rodrigo Rivas Costa wrote:
> On Wed, Feb 14, 2018 at 03:45:14PM +0100, Benjamin Tissoires wrote:
>> I think I had a look at this a while ago, and didn't want to interfere
>> with SteamOS regarding this. I think your patch should be fine in that
>> regard, but have you tried SteamOS on a kernel patched with your
>> series? Does it behave properly or will it break?
> 
> Well, SteamOS is just a modified Debian with the Steam Client running in
> Big Picture mode (fullscreen). I tried the Steam Client with this driver
> and it works just fine:
> - The first thing the Steam Client (SC) does is to disable the virtual
>    keyboard and mouse, so not creating those input devices make no
>    difference.

There's a bit more to it than that; for example, on SteamOS, the virtual 
keyboard/mouse will be re-enabled when switching to Desktop Mode.

In addition, chord configurations can include a bindable action that 
temporarily programs the controller to re-enable the virtual 
keyboard/mouse (what we call "Lizard Mode"). People use this to navigate 
around cases where our software input doesn't cut it, like a launcher 
pop-up window that Steam isn't able to hook into for whatever reason.

That behavior will also change over time since the client is often 
updated with support for new controller features.

Thanks,
  - Pierre-Loup

> - Input events are sent both to the libusb (or whatever SC uses) and
>    this driver.
> - The only source of conflict would be in sending commands to the
>    controller. But currently the only command sent is the get_serial, and
>    that seems to do no harm.
> 
>>> +
>>> +       hid_info(hdev, "Steam Controller connected");
>>> +
>>> +       input = input_allocate_device();
>>
>> Don't you need one input node per wireless gamepad too?
>>
> No, the wired and wireless methods are two different USB devices.
> The wireless adaptor is a small usb device that creates 4 HID interfaces
> for the 4 to-be-connected controllers. When the 'connected' event
> arrives on one of those interfaces we will create one input device.
> Another controller connected will use a different interface so another
> unrelated input device will be created.
> 
> The wired adaptor is the controller connected directly to USB: it
> creates one HID inteface and one input device directly.
> 
> Anyway, one steam_device will contain 0 or 1 input_device.
> 
>>> +       input->name = "Steam Controller";
>>
>> In case of the wireless controllers, you might want to personalize this a bit.
> 
> Do you mean e.g. "Wireless Steam Controller"? Would be wise to add the serial
> number here (from PATCH 2/3?)? Or is the 'uniq' enough for that?
> 
>>> +       input_set_abs_params(input, ABS_Z, 0, 255, 0, 0);
>>> +       input_set_abs_params(input, ABS_RZ, 0, 255, 0, 0);
>>> +       input_set_abs_params(input, ABS_X, -32767, 32767, 0, 0);
>>> +       input_set_abs_params(input, ABS_Y, -32767, 32767, 0, 0);
>>
>> You are also probably missing the resolution bits. We need to
>> accurately report the physical dimensions to the user space (thanks to
>> the resolution)
>>
>>> +       input_set_abs_params(input, ABS_RX, -32767, 32767, 0, 0);
>>> +       input_set_abs_params(input, ABS_RY, -32767, 32767, 0, 0);
>>
>> What do RX/RY correspond to?
> 
> This gamepad has 1 joystick and 2 touchpads (lpad and rpad).
> I'm mapping the joystick/lpad to ABS_X/ABS_Y and the rpad to
> ABS_RX/ABS_RY.
> 
> About the resolution, I looked around other drivers and many have 0 as
> resolution... is it necessary only in the pads or the joystick too?
> And what are the units of that value?
> For reference, the pads are round and exactly 40 mm in diameter.
> 
> Why the lpad and the joystick are mapped to the same axes? Well, because
> the device returns them at the same offset. We could make them
> apart by using bits 10.3 (lpad_touch) and 10.7 (lpad_and_joy) but I
> don't think it is worth it... you use the joystick and the lpad with the
> same thumb!
> 
>> Anyway. Thanks for the driver, there are a few bits to fix, nothing
>> scary though.
> 
> Great, I'll correct all those issues and resubmit the patches in a few
> days. It is my very first driver and I'm still a bit slow...
> 
> Thank you for your attention!
> Rodrigo.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
