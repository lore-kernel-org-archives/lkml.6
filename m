Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeBUAJf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:09:35 -0500
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:25694 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751359AbeBUAJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:09:33 -0500
Subject: Re: [PATCH v2 0/3] new driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
CC: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
 <673a2510-7d82-1b24-1085-9f5aa2bb9998@valvesoftware.com>
 <20180220232035.GA28798@casa>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <52b10af3-d93b-34b2-e6ba-22621511b16f@valvesoftware.com>
Date: Tue, 20 Feb 2018 16:09:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220232035.GA28798@casa>
Content-Language: en-US
X-Mlf-Version: 8.3.2.6535
X-Mlf-UniqueId: o201802210009290030196
X-MC-Unique: gLFN7_L9MZW-M9YnmoRj3A-1
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1L09fff002611

On 02/20/2018 03:20 PM, Rodrigo Rivas Costa wrote:
> On Tue, Feb 20, 2018 at 02:29:48PM -0800, Pierre-Loup A. Griffais wrote:
>> Hi Rodrigo,
>>
>> Thanks for working on that! I have a few questions and remarks.
>>
>> For the reverse-engineering part, there's a lot of existing reference in
>> existing (user-space) drivers for the controllers like sc-controller, but
>> feel free to reach out if you have any questions. It's overall pretty simple
>> and there's nothing secret about how it functions; there are some quirks,
>> however. Nothing secret about it, but also no documentation, so might as
>> well be... Have you tried deflecting the analog stick while touching the
>> left trackpad? You'll most likely need special handling there. How are you
>> planning to expose enabling/disabling auxiliary data like gyro over
>> wireless?
> 
> Yeah, I look for information about a year when I started on this. I read
> Ynsta's user-mode driver [1] (I didn't find sc-controller), but I found
> that a bit incomplete, so I wrote my own named `inputmap` [2].
> 
> About the left trackpad/joystick, currently I'm not treating them
> different. I'm out of ABS axes, and anyway, it is not likely that the
> left pad and the joystick be used at the same time (I only have one left
> thumb). Nevertheless, if we really want to make them apart, we can use
> bits 10.3 (lpad_touch) and 10.7 (lpad_and_joy) together. I described the
> details in [2], but I'm not currently doing that in this driver.

I didn't necessarily mean exposing it, but in the event a user is using 
both at the same time (it happens, using claw grip with some games is 
necessary to use the D-pad while deflecting the stick), then you'll most 
likely run into issues unless you demux the inbound data, since we were 
also out of left analog fields and mux them together if used at the same 
time. Not sure if you're already handling that case, but not doing it 
would result in the stick appearing to fully deflect every other input 
report if the user is doing both at the same time.

> About the gyroscope/acceleration/quaternion, you know the issue
> that the wireless gives gyro plus quat but no accel, while the wired
> gives all three. My general idea is to create an additional input device
> with INPUT_PROP_ACCELEROMETER to expose what is available. Pity is that
> the wireless gives no accel, maybe there is some command to enable it?

It should be three neighboring bits for that setting; does this not work 
for you?

// Bitmask that define which IMU features to enable.
typedef enum
{
	SETTING_GYRO_MODE_OFF				= 0x0000,
	SETTING_GYRO_MODE_STEERING			= 0x0001,
	SETTING_GYRO_MODE_TILT				= 0x0002,
	SETTING_GYRO_MODE_SEND_ORIENTATION	= 0x0004,
	SETTING_GYRO_MODE_SEND_RAW_ACCEL	= 0x0008,
	SETTING_GYRO_MODE_SEND_RAW_GYRO		= 0x0010,
} SettingGyroMode;

> 
> Also, ideally, we could expose the quat. data directly to userspace, but
> I see no clear way to do that. Maybe defining INPUT_PROP_QUATERNION? I
> also thought of computing yaw/pitch/roll from the quat. and exposing
> those, but doing that requires atan2() and sin() (16-bit precision), and
> that would be tricky. Any thoughts on that?

I have no useful feedback on the actual shape of the data, but you'll 
want to give careful thought to sending the setting above. The battery 
life of the controller is going to get worse the more data you're 
enabling to be transmitted over the radio. For this reason, Steam only 
selectively enables the data that the current configuration demands, 
dynamically based on what client application has focus. It might make 
sense to expose the quaternion like you describe, but would it be doable 
to have it exposed through a separate device node? This way, I assume 
the driver could properly send the appropriate radio setting to the 
device based on whether that gyro-specific device node is open by an 
interested user or not. It would be unfortunate to enable these data 
channels by default if they're not needed.
>> Will this driver being loaded affect functionality of existing applications
>> that talk to it through HID directly, like Steam or sc-controller? Will they
>> be able to keep getting the same HID data they do today? If so, the extent
>> of the work needed to support it in Steam might just be to ignore the
>> controller device it's exposing, since Steam will expose that itself through
>> its own means.
> 
> As it is, this patchset hould be pretty safe. The only command sent to
> the controller is the get-serial-number, and that seems to do no harm to
> Steam Client. Other than that, it only reads. Moreover, the hidraw
> device is still created, so user-mode driver should keep working
> (but AFAIK, Steam Client uses direct USB access, not hidraw).
> 
> Curiously, Steam Client does not show the new native Steam Controller
> gamepad. That is, if I connect the Steam controller with hid-steam.ko
> and an Acme HID gamepad, then in Steam Client controller settings I
> see only two controllers, the managed Steam Controller (not HID) and the
> Acme HID gamepad. I reckon that Steam Client recognizes that the
> new HID device is a Steam Controller and ignores it in favor of its own
> managed controller.

OK, I can give it a spin to see what Steam thinks about that device. 
Maybe the proper VID/PID being exposed is enough for it to ignore it.

In general I'm concerned about sending of the gyro-enable message 
potentially impairing Steam functionality if it's running at the same 
time (eg. if gyro gets disabled over the radio while Steam still needs 
it), or sending any stateful messages to the device. For instance, are 
you ever sending the "blank configuration" setting? I assume you must be 
or users would still get keyboard/mouse input over these USB endpoints 
while trying to interact with the controller. But sending this after 
Steam programmed a setting, or instructed the controller to go back to 
lizard mode because it was requested by a configuration, would be 
problematic.

Thanks,
  - Pierre-Loup

> Regards.
> Rodrigo
> 
> [1]: https://github.com/ynsta/steamcontroller
> [2]: https://github.com/rodrigorc/inputmap
> 
> 
