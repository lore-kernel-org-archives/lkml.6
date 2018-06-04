Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeFDOXJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:23:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35270 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeFDOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:23:06 -0400
X-Google-Smtp-Source: ADUXVKL8Wg2vMhQFKKKmDjtJcVfljeYEOpcMaGc6mAWQZqAP8XnHaPEHDTeWs8bsjMvAp6CVjczZ9w==
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
To: Daniel Drake <drake@endlessm.com>
Cc: Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
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
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <bad0e19f-e994-110e-fce9-b614233e66aa@redhat.com>
Date: Mon, 4 Jun 2018 16:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD8Lp45FmOMK3B537sKfnC3STtxwspNdoRVKTyaoDnsJ3EMEtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-06-18 15:51, Daniel Drake wrote:
> On Mon, Jun 4, 2018 at 7:22 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Is this really a case of the hardware itself processing the
>> keypress and then changing the brightness *itself* ?
>>
>>  From the "[PATCH 2/2] platform/x86: asus-wmi: Add keyboard backlight
>> toggle support" patch I get the impression that the driver is
>> modifying the brightness from within the kernel rather then the
>> keyboard controller are ACPI embeddec-controller doing it itself.
>>
>> If that is the case then the right fix is for the driver to stop
>> mucking with the brighness itself, it should simply report the
>> right keyboard events and export a led interface and then userspace
>> will do the right thing (and be able to offer flexible policies
>> to the user).
> 
> Before this modification, the driver reports the brightness keypresses
> to userspace and then userspace can respond by changing the brightness
> level, as you describe.
> 
> You are right in that the hardware doesn't change the brightness
> directly itself, which is the normal usage of LED_BRIGHT_HW_CHANGED.
> 
> However this approach was suggested by Benjamin Berg and Bastien
> Nocera in the thread: Re: [PATCH v2] platform/x86: asus-wmi: Add
> keyboard backlight toggle support
> https://marc.info/?l=linux-kernel&m=152639169210655&w=2
> 
> The issue is that we need to support a new "keyboard backlight
> brightness cycle" key (in the patch that follows this one) which
> doesn't fit into any definitions of keys recognised by the kernel and
> likewise there's no userspace code to handle it.
> 
> If preferred we could leave the standard brightness keys behaving as
> they are (input events) and make the new special key type directly
> handled by the kernel?

I'm sorry that Benjamin and Bastien steered you in this direction,
IMHO none of it should be handled in the kernel.

Anytime any sort of input is directly responded to by the kernel
it is a huge PITA to deal with from userspace. The kernel will have
a simplistic implementation which almost always is wrong.

Benjamin, remember the pain we went through with rfkill hotkey
presses being handled in the kernel ?

And then there is the whole acpi_video.brightness_switch_enabled
debacle, which is an option which defaults to true which causes
the kernel to handle LCD brightness key presses, which all distros
have been patching to default to off for ages.

To give a concrete example, we may want to implement software
dimming / auto-off of the kbd backlight when the no keys are
touched for x seconds. This would seriously get in the way of that.

So sorry, but NACK to this series.

###

With that all said lets look at a userspace solution grepping
through the kernel for KEY_KBDILLUMTOGGLE there are 4 users:

1) drivers/platform/x86/toshiba_acpi.c

I don't know how the key on Toshiba's behaves on models where
it is hardwired / under Windows

2) drivers/platform/x86/dell-wmi.c

All Dells I know of have the hotkey do a cycle, not a toggle on/off

3) Some apple specific drivers:

According to:
https://support.apple.com/en-us/HT202310

Apple has separate up/down keys, so no idea why the drivers sometimes
send a KEY_KBDILLUMTOGGLE event

4) drivers/hid/hid-input.c

Okay, so the HUT clearly defines the Consumer Page mapping 0x35
as "OOC – Toggles illumination of consumer control's buttons and controls on/off."
which is a bit of a bummer, because I was hoping that we
could just redefine KEY_KBDILLUMTOGGLE to mean cycle.


Still despite HID HUT being clear about this being an on/off
toggle. I'm thinking that cycling makes more sense everywhere
and that we should simply rename
gnome-settings-daemon/plugins/power/gsd-power-manager.c 's
upower_kbd_toggle() function to upower_kbd_cycle() and make
it behave accordingly. If we device the range up into 8 steps
(if there are more then 8 to being with) then I think this
will be more useful everywhere then just the on/off toggle.

The alternative would be to define a new keycode, but that will be
 > 240 so it will only work on Wayland and not under X11.

Benjamin, Bastien, opinions?

Regards,

Hans
