Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeFEHfJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:35:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55110 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeFEHfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:35:06 -0400
X-Google-Smtp-Source: ADUXVKL/9EFHxGRwqMXZ1adeonw+fRNVmAOZ1Bz6xjRlTWhe61zvzxW9cm+wUMjLiHloK53OwACeoA==
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
To: Darren Hart <dvhart@infradead.org>
Cc: Daniel Drake <drake@endlessm.com>, Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <benjamin@sipsolutions.net>
References: <20180604123238.82200-1-chiu@endlessm.com>
 <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
 <CAD8Lp45FmOMK3B537sKfnC3STtxwspNdoRVKTyaoDnsJ3EMEtg@mail.gmail.com>
 <bad0e19f-e994-110e-fce9-b614233e66aa@redhat.com>
 <20180605023124.GE47042@localhost.localdomain>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <85865f59-18bc-fb41-3a9d-30570647ec8e@redhat.com>
Date: Tue, 5 Jun 2018 09:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605023124.GE47042@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-06-18 04:31, Darren Hart wrote:
> On Mon, Jun 04, 2018 at 04:23:04PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 04-06-18 15:51, Daniel Drake wrote:
>>> On Mon, Jun 4, 2018 at 7:22 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Is this really a case of the hardware itself processing the
>>>> keypress and then changing the brightness *itself* ?
>>>>
>>>>   From the "[PATCH 2/2] platform/x86: asus-wmi: Add keyboard backlight
>>>> toggle support" patch I get the impression that the driver is
>>>> modifying the brightness from within the kernel rather then the
>>>> keyboard controller are ACPI embeddec-controller doing it itself.
>>>>
>>>> If that is the case then the right fix is for the driver to stop
>>>> mucking with the brighness itself, it should simply report the
>>>> right keyboard events and export a led interface and then userspace
>>>> will do the right thing (and be able to offer flexible policies
>>>> to the user).
>>>
>>> Before this modification, the driver reports the brightness keypresses
>>> to userspace and then userspace can respond by changing the brightness
>>> level, as you describe.
>>>
>>> You are right in that the hardware doesn't change the brightness
>>> directly itself, which is the normal usage of LED_BRIGHT_HW_CHANGED.
>>>
>>> However this approach was suggested by Benjamin Berg and Bastien
>>> Nocera in the thread: Re: [PATCH v2] platform/x86: asus-wmi: Add
>>> keyboard backlight toggle support
>>> https://marc.info/?l=linux-kernel&m=152639169210655&w=2
>>>
>>> The issue is that we need to support a new "keyboard backlight
>>> brightness cycle" key (in the patch that follows this one) which
>>> doesn't fit into any definitions of keys recognised by the kernel and
>>> likewise there's no userspace code to handle it.
>>>
>>> If preferred we could leave the standard brightness keys behaving as
>>> they are (input events) and make the new special key type directly
>>> handled by the kernel?
>>
>> I'm sorry that Benjamin and Bastien steered you in this direction,
>> IMHO none of it should be handled in the kernel.
>>
>> Anytime any sort of input is directly responded to by the kernel
>> it is a huge PITA to deal with from userspace. The kernel will have
>> a simplistic implementation which almost always is wrong.
>>
>> Benjamin, remember the pain we went through with rfkill hotkey
>> presses being handled in the kernel ?
>>
>> And then there is the whole acpi_video.brightness_switch_enabled
>> debacle, which is an option which defaults to true which causes
>> the kernel to handle LCD brightness key presses, which all distros
>> have been patching to default to off for ages.
>>
>> To give a concrete example, we may want to implement software
>> dimming / auto-off of the kbd backlight when the no keys are
>> touched for x seconds. This would seriously get in the way of that.
>>
>> So sorry, but NACK to this series.
> 
> So if instead of modifying the LED value, the kernel platform drivers
> converted the TOGGLE into a cycle even by converting to an UP event
> based on awareness of the plaform specific max value and the read
> current value, leaving userspace to act on the TOGGLE/UP events - would
> that be preferable?

I was thinking about doing that as a workaround myself, but I'm not sure
that is a good idea (because of e.g. races with userspace auto-correcting
the brightness based on ambient light and/or keyboard activity).

As I see it there are 2 proper solutions to this:

1) Make userspace treat KEY_KBDILLUMTOGGLE as a cycle key, this is
what the kbd-backlight on most laptops with a single hotkey (*) does
in cases where this is handled in firmware, rather then left to the
OS. The handled in firmware is the case which I created the
led_classdev_notify_brightness_hw_changed() API for. This would be
my preferred solution and I believe that Benjamin is discussing this
with Bastien ATM.

2) Add a new KEY_KBDILLUMCYCLE event and send that for the TOGGLE code
on these laptops.

Regards,

Hans



*) Rather then separate up / down hotkeys


> 
> Something like:
> 
> 	if (code == TOGGLE && ledval < ledmax)
> 		code = UP;
> 
> 	sparse_keymap_report_event(..., code, ...)
> 
> }
> 
