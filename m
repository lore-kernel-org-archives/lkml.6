Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeFEKbF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:31:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34969 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFEKbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:31:03 -0400
X-Google-Smtp-Source: ADUXVKJR9ClC9c+5+VbT9HrrvliT3AiIkzdyl7EEg+fIHKtrE9lHCNCshs855pO2h17SHhryUDZ1Zw==
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
To: Bastien Nocera <hadess@hadess.net>, Chris Chiu <chiu@endlessm.com>,
        Darren Hart <dvhart@infradead.org>
Cc: Daniel Drake <drake@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
References: <20180604123238.82200-1-chiu@endlessm.com>
 <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
 <CAD8Lp45FmOMK3B537sKfnC3STtxwspNdoRVKTyaoDnsJ3EMEtg@mail.gmail.com>
 <bad0e19f-e994-110e-fce9-b614233e66aa@redhat.com>
 <20180605023124.GE47042@localhost.localdomain>
 <CAB4CAwc-J3+xaXzKKpFc-UMeuCsX8zbs0S7-a82x2LJcD5r7jA@mail.gmail.com>
 <38cb3527-8480-bdb9-a5d9-b601bc494a5f@redhat.com>
 <71df09bc89619aba975147e6b07920f1dfc2f46f.camel@hadess.net>
 <cd6a5d86-1fdb-2561-1e29-0553be53c41a@redhat.com>
 <94789b55b88ae5a296e1fca3b0311318e7b507ee.camel@hadess.net>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0443419b-3147-163b-374d-bb8651b08837@redhat.com>
Date: Tue, 5 Jun 2018 12:31:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <94789b55b88ae5a296e1fca3b0311318e7b507ee.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-06-18 12:14, Bastien Nocera wrote:
> On Tue, 2018-06-05 at 12:05 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 05-06-18 11:58, Bastien Nocera wrote:
>>> On Tue, 2018-06-05 at 09:37 +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 05-06-18 05:18, Chris Chiu wrote:
>>>>> On Tue, Jun 5, 2018 at 10:31 AM, Darren Hart <dvhart@infradead.
>>>>> org>
>>>>> wrote:
>>>>>> On Mon, Jun 04, 2018 at 04:23:04PM +0200, Hans de Goede
>>>>>> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 04-06-18 15:51, Daniel Drake wrote:
>>>>>>>> On Mon, Jun 4, 2018 at 7:22 AM, Hans de Goede <hdegoede@r
>>>>>>>> edha
>>>>>>>> t.com> wrote:
>>>>>>>>> Is this really a case of the hardware itself processing
>>>>>>>>> the
>>>>>>>>> keypress and then changing the brightness *itself* ?
>>>>>>>>>
>>>>>>>>>     From the "[PATCH 2/2] platform/x86: asus-wmi: Add
>>>>>>>>> keyboard backlight
>>>>>>>>> toggle support" patch I get the impression that the
>>>>>>>>> driver
>>>>>>>>> is
>>>>>>>>> modifying the brightness from within the kernel rather
>>>>>>>>> then
>>>>>>>>> the
>>>>>>>>> keyboard controller are ACPI embeddec-controller doing
>>>>>>>>> it
>>>>>>>>> itself.
>>>>>>>>>
>>>>>>>>> If that is the case then the right fix is for the
>>>>>>>>> driver to
>>>>>>>>> stop
>>>>>>>>> mucking with the brighness itself, it should simply
>>>>>>>>> report
>>>>>>>>> the
>>>>>>>>> right keyboard events and export a led interface and
>>>>>>>>> then
>>>>>>>>> userspace
>>>>>>>>> will do the right thing (and be able to offer flexible
>>>>>>>>> policies
>>>>>>>>> to the user).
>>>>>>>>
>>>>>>>> Before this modification, the driver reports the
>>>>>>>> brightness
>>>>>>>> keypresses
>>>>>>>> to userspace and then userspace can respond by changing
>>>>>>>> the
>>>>>>>> brightness
>>>>>>>> level, as you describe.
>>>>>>>>
>>>>>>>> You are right in that the hardware doesn't change the
>>>>>>>> brightness
>>>>>>>> directly itself, which is the normal usage of
>>>>>>>> LED_BRIGHT_HW_CHANGED.
>>>>>>>>
>>>>>>>> However this approach was suggested by Benjamin Berg and
>>>>>>>> Bastien
>>>>>>>> Nocera in the thread: Re: [PATCH v2] platform/x86: asus-
>>>>>>>> wmi:
>>>>>>>> Add
>>>>>>>> keyboard backlight toggle support
>>>>>>>> https://marc.info/?l=linux-kernel&m=152639169210655&w=2
>>>>>>>>
>>>>>>>> The issue is that we need to support a new "keyboard
>>>>>>>> backlight
>>>>>>>> brightness cycle" key (in the patch that follows this
>>>>>>>> one)
>>>>>>>> which
>>>>>>>> doesn't fit into any definitions of keys recognised by
>>>>>>>> the
>>>>>>>> kernel and
>>>>>>>> likewise there's no userspace code to handle it.
>>>>>>>>
>>>>>>>> If preferred we could leave the standard brightness keys
>>>>>>>> behaving as
>>>>>>>> they are (input events) and make the new special key type
>>>>>>>> directly
>>>>>>>> handled by the kernel?
>>>>>>>
>>>>>>> I'm sorry that Benjamin and Bastien steered you in this
>>>>>>> direction,
>>>>>>> IMHO none of it should be handled in the kernel.
>>>>>>>
>>>>>>> Anytime any sort of input is directly responded to by the
>>>>>>> kernel
>>>>>>> it is a huge PITA to deal with from userspace. The kernel
>>>>>>> will
>>>>>>> have
>>>>>>> a simplistic implementation which almost always is wrong.
>>>>>>>
>>>>>>> Benjamin, remember the pain we went through with rfkill
>>>>>>> hotkey
>>>>>>> presses being handled in the kernel ?
>>>>>>>
>>>>>>> And then there is the whole
>>>>>>> acpi_video.brightness_switch_enabled
>>>>>>> debacle, which is an option which defaults to true which
>>>>>>> causes
>>>>>>> the kernel to handle LCD brightness key presses, which all
>>>>>>> distros
>>>>>>> have been patching to default to off for ages.
>>>>>>>
>>>>>>> To give a concrete example, we may want to implement
>>>>>>> software
>>>>>>> dimming / auto-off of the kbd backlight when the no keys
>>>>>>> are
>>>>>>> touched for x seconds. This would seriously get in the way
>>>>>>> of
>>>>>>> that.
>>>>>>>
>>>>>>> So sorry, but NACK to this series.
>>>>>>
>>>>>> So if instead of modifying the LED value, the kernel platform
>>>>>> drivers
>>>>>> converted the TOGGLE into a cycle even by converting to an UP
>>>>>> event
>>>>>> based on awareness of the plaform specific max value and the
>>>>>> read
>>>>>> current value, leaving userspace to act on the TOGGLE/UP
>>>>>> events -
>>>>>> would
>>>>>> that be preferable?
>>>>>>
>>>>>> Something like:
>>>>>>
>>>>>>            if (code == TOGGLE && ledval < ledmax)
>>>>>>                    code = UP;
>>>>>>
>>>>>>            sparse_keymap_report_event(..., code, ...)
>>>>>>
>>>>>> }
>>>>>> --
>>>>>> Darren Hart
>>>>>> VMware Open Source Technology Center
>>>>>
>>>>> That's what I was trying to do in  [PATCH v2] platform/x86:
>>>>> asus-
>>>>> wmi: Add
>>>>> keyboard backlight toggle support. However, that brought
>>>>> another
>>>>> problem
>>>>> discussed in the thread.
>>>>> https://marc.info/?l=linux-kernel&m=152639169210655&w=2
>>>>>
>>>>> So I moved the brightness change in the driver without passing
>>>>> to
>>>>> userspace.
>>>>> Per Hans, seems there're some other concerns and I also wonder
>>>>> if
>>>>> the
>>>>> TOGGLE event happens in ASUS HID (asus-hid.c) which also
>>>>> convert
>>>>> and
>>>>> pass the keycode to userspace but no TOGGLE key support yet
>>>>> What
>>>>> should
>>>>> we do then?
>>>>
>>>> As I mentioned in my reply to Darren, there are 2 proper
>>>> solutions to
>>>> this:
>>>>
>>>> 1) Make userspace treat KEY_KBDILLUMTOGGLE as a cycle key, this
>>>> is
>>>> what the kbd-backlight on most laptops with a single hotkey (*)
>>>> does
>>>> in cases where this is handled in firmware, rather then left to
>>>> the
>>>> OS. The handled in firmware is the case which I created the
>>>> led_classdev_notify_brightness_hw_changed() API for. This would
>>>> be
>>>> my preferred solution and I believe that Benjamin is discussing
>>>> this
>>>> with Bastien ATM.
>>>
>>> It isn't on Macs, at least. Toggle is a toggle, not a cycle key. It
>>> turns the keyboard backlight off and on, restoring the backlight
>>> level
>>> when turned back on.
>>>
>>>> 2) Add a new KEY_KBDILLUMCYCLE event
>>>
>>> Which won't be accessible to Xorg.
>>
>> Ok, so what are you suggestion, do you really want to hardcode
>> the cycle behavior in the kernel as these 2 patches are doing,
>> without any option to intervene from userspace?
>>
>> As mentioned before in the thread there are several example
>> of the kernel deciding to handle key-presses itself, putting
>> policy in the kernel and they have all ended poorly (think
>> e.g. rfkill, acpi-video dealing with LC brightnesskey presses
>> itself).
>>
>> I guess one thing we could do here is code out both solutions,
>> have a module option which controls if we:
>>
>> 1) Handle this in the kernel as these patches do
>> 2) Or send a new KEY_KBDILLUMCYCLE event
>>
>> Combined with a Kconfig option to select which is the default
>> behavior. Then Endless can select 1 for now and then in
>> Fedora (which defaults to Wayland now) we could default to
>> 2. once all the code for handling 2 is in place.
>>
>> This is ugly (on the kernel side) but it might be the best
>> compromise we can do.
> 
> I don't really mind which option is used, I'm listing the problems with
> the different options. If you don't care about Xorg, then definitely go
> for adding a new key. Otherwise, processing it in the kernel is the
> least ugly, especially given that the key goes through the same driver
> that controls the brightness anyway. There's no crazy cross driver
> interaction as there was in the other cases you listed.

Unfortunately not caring about Xorg is not really an option.

Ok, new idea, how about we make g-s-d behavior upon detecting a
KEY_KBDILLUMTOGGLE event configurable, if we're on a Mac do a
toggle, otherwise do a cycle.

Or we could do this through hwdb, then we could add a hwdb entry
for this laptop setting the udev property to do a cycle instead of
a toggle on receiving the keypress.

I guess alternatively I could live with hardcoding this in the
kernel as these 2 patches do, but that solves it just for *this*
laptop, I've a feeling that if we do that we end up with similar
code in all laptop vendor drivers under drivers/platform/x86
soon.  Which really is the acpi_video.brightness_event thing
again, where the kernel would handle brightness key-presses
but only if the acpi_video backlight interface was in use
and not on models with a vendor specific or native-hardware
backlight driver.  Hmm, so writing this, I'm still quite sure
the kernel approach is actually a bad idea.

Regards,

Hans
