Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972399AbeCSWOy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:14:54 -0400
Received: from vern.gendns.com ([206.190.152.46]:52006 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S972389AbeCSWOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:14:43 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v8_00/42]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
To: Alexandre Bailon <abailon@baylibre.com>
Cc: Adam Ford <aford173@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-clk@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <CAMpxmJX-AxhpPpCnWoaSGYmNh3o8iRjdKacnmozsPWmhpcGdTg@mail.gmail.com>
 <af89be8d-04dd-e845-1d5b-afdd7e55629f@lechnology.com>
 <CAHCN7xKQ47DnVXiZTJ-0myoth2SJ3wnyvDb2i07uKZDgomhgwQ@mail.gmail.com>
From: David Lechner <david@lechnology.com>
Message-ID: <831be3a1-8878-9f6b-374b-3ed77adda7ef@lechnology.com>
Date: Mon, 19 Mar 2018 17:14:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7xKQ47DnVXiZTJ-0myoth2SJ3wnyvDb2i07uKZDgomhgwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 11:11 AM, Adam Ford wrote:
> On Mon, Mar 19, 2018 at 10:59 AM, David Lechner <david@lechnology.com> wrote:
>> On 03/19/2018 08:17 AM, Bartosz Golaszewski wrote:
>>>
>>> 2018-03-16 3:52 GMT+01:00 David Lechner <david@lechnology.com>:
>>>>
>>>> This series converts mach-davinci to use the common clock framework.
>>>>
>>>> The series works like this, the first 19 patches create new clock drivers
>>>> using the common clock framework. There are basically 3 groups of clocks
>>>> -
>>>> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each
>>>> have
>>>> unique init data, which is the reason for so many patches.
>>>>
>>>> Then, starting with "ARM: davinci: pass clock as parameter to
>>>> davinci_timer_init()", we get the mach code ready for the switch by
>>>> adding the
>>>> code needed for the new clock drivers and adding #ifndef
>>>> CONFIG_COMMON_CLK
>>>> around the legacy clocks so that we can switch easily between the old and
>>>> the
>>>> new.
>>>>
>>>> "ARM: davinci: switch to common clock framework" actually flips the
>>>> switch
>>>> to start using the new clock drivers. Then the next 8 patches remove all
>>>> of the old clock code.
>>>>
>>>> The final three patches add device tree clock support to the one SoC that
>>>> supports it.
>>>>
>>>> This series has been tested on LEGO MINDSTORMS EV3 (device tree) and TI
>>>> OMAP-L138 LCDK (both device tree and legacy board file).
>>>>
>>>
>>> Hi David,
>>>
>>> thanks, with the u-boot fix everything seems to work fine. I tested
>>> da850-lcdk and da850-evm boards in DT and board file modes.
>>>
> 
> I tested MMC and Ethernet.  Both appear to be operating normally, but
> I have having USB issues.
> 
> Should I be testing cpufreq?  I noticed that when changing the
> frequencies, the USB appears to stop recognizing connections and
> disconnections.
> 
> I did some testing on the DA850-EVM with USB from your repo, and I'm
> getting some crashing on MUSB unplug that do not appear in the
> 4.16-RC6 from linux-stable:
> 
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 13 at drivers/dma/cppi41.c:694
> cppi41_stop_chan+0x1f4/0x378 [cppi41]
> Modules linked in: evbug evdev mousedev hid_generic usbhid hid
> usb_f_ss_lb g_zero libcomposite configfs ofpart cmdlinepart m25p80
> spi_nor cppi41 adv7343 tvp514x vpif_display vpif_capture
> videobuf2_dma_con
> tig videobuf2_memops videobuf2_v4l2 videobuf2_common v4l2_fwnode
> v4l2_common snd_soc_simple_card tilcdc spi_davinci
> snd_soc_simple_card_utils videodev pwm_tiecap spi_bitbang da8xx
> drm_kms_helper phy_gener
> ic syscopyarea ohci_da8xx musb_hdrc sysfillrect sysimgblt fb_sys_fops
> ohci_hcd udc_core drm usbcore drm_panel_orientation_quirks usb_common
> snd_soc_tlv320aic3x vpif snd_soc_davinci_mcasp snd_soc_edma snd_
> soc_core snd_pcm_dmaengine snd_pcm rtc_omap snd_timer snd soundcore
> phy_da8xx_usb davinci_nand nand nand_ecc mtd pwm_bl backlight
> cpufreq_dt ti_aemif
> CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 4.16.0-rc5-g291ba8b-dirty #3
> Hardware name: Generic DA850/OMAP-L138/AM18x
> Workqueue: usb_hub_wq hub_event [usbcore]
> Backtrace:
> [<c000df94>] (dump_backtrace) from [<c000e264>] (show_stack+0x18/0x1c)
>   r7:00000009 r6:00000000 r5:bf339ad0 r4:00000000
> [<c000e24c>] (show_stack) from [<c04864c0>] (dump_stack+0x20/0x28)
> [<c04864a0>] (dump_stack) from [<c001ac38>] (__warn+0xd4/0xfc)
> [<c001ab64>] (__warn) from [<c001ad7c>] (warn_slowpath_null+0x44/0x50)
>   r8:c6c43080 r7:c05f1008 r6:bf338744 r5:000002b6 r4:bf339ad0
> [<c001ad38>] (warn_slowpath_null) from [<bf338744>]
> (cppi41_stop_chan+0x1f4/0x378 [cppi41])
>   r6:c5e59410 r5:c5e59420 r4:c5feca50
> [<bf338550>] (cppi41_stop_chan [cppi41]) from [<bf213dac>]
> (cppi41_dma_channel_abort+0xe0/0x2a8 [musb_hdrc])
>   r8:c6929180 r7:00000000 r6:c5c67290 r5:bf2175a0 r4:00000008
> [<bf213ccc>] (cppi41_dma_channel_abort [musb_hdrc]) from [<bf20c4bc>]
> (musb_cleanup_urb+0x60/0x210 [musb_hdrc])
>   r10:00000001 r9:c5fca010 r8:c5c67290 r7:a0000093 r6:00000080 r5:c55b5100
>   r4:c5fca5a8
> [<bf20c45c>] (musb_cleanup_urb [musb_hdrc]) from [<bf20ca8c>]
> (musb_urb_dequeue+0xfc/0x164 [musb_hdrc])
>   r10:00000001 r9:40408280 r8:c5fca010 r7:a0000093 r6:00000000 r5:c55b5380
>   r4:c55b5100
> [<bf20c990>] (musb_urb_dequeue [musb_hdrc]) from [<bf10fd7c>]
> (unlink1+0x34/0x13c [usbcore])
>   r10:00000100 r9:c5cb2a00 r8:c55b5100 r7:ffffff94 r6:c5c6c000 r5:c5dd2380
>   r4:c55b5100 r3:bf20c990
> [<bf10fd48>] (unlink1 [usbcore]) from [<bf112424>]
> (usb_hcd_flush_endpoint+0x164/0x1a4 [usbcore])
>   r9:c5cb2a00 r8:c55b5100 r7:c5c6c000 r6:c5dd2398 r5:c5dd2380 r4:ffffe000
> [<bf1122c0>] (usb_hcd_flush_endpoint [usbcore]) from [<bf11563c>]
> (usb_disable_endpoint+0x50/0x94 [usbcore])
>   r9:c5cb2a00 r8:bf39e898 r7:00000000 r6:c5c43000 r5:c5c43000 r4:c5dd2380
> [<bf1155ec>] (usb_disable_endpoint [usbcore]) from [<bf1156c4>]
> (usb_disable_interface+0x44/0x58 [usbcore])
>   r5:c5dd2348 r4:00000000
> [<bf115680>] (usb_disable_interface [usbcore]) from [<bf118044>]
> (usb_unbind_interface+0x1c0/0x268 [usbcore])
>   r7:c5cb2c00 r6:bf39e898 r5:c5cb2c20 r4:c5cb2c20
> [<bf117e84>] (usb_unbind_interface [usbcore]) from [<c02ce180>]
> (device_release_driver_internal+0x160/0x208)
>   r10:00000100 r9:c5cb2a00 r8:00000034 r7:00000000 r6:bf39e898 r5:c5cb2c54
>   r4:c5cb2c20
> [<c02ce020>] (device_release_driver_internal) from [<c02ce240>]
> (device_release_driver+0x18/0x1c)
>   r9:c5cb2a00 r8:c05f1008 r7:c5c43070 r6:bf12895c r5:c5cb2c20 r4:c5dc91ac
> [<c02ce228>] (device_release_driver) from [<c02ccf70>]
> (bus_remove_device+0xd0/0x100)
> [<c02ccea0>] (bus_remove_device) from [<c02c9c60>] (device_del+0x120/0x378)
>   r7:c5c43070 r6:c5cb2c28 r5:00000000 r4:c5cb2c20
> [<c02c9b40>] (device_del) from [<bf11576c>]
> (usb_disable_device+0x94/0x1d8 [usbcore])
>   r10:00000100 r9:c5cb2a00 r8:c5cb2c00 r7:c5c6c000 r6:00000001 r5:00000000
>   r4:c5c43000
> [<bf1156d8>] (usb_disable_device [usbcore]) from [<bf10bccc>]
> (usb_disconnect+0xb4/0x244 [usbcore])
>   r9:c5cb2a00 r8:c5c2d600 r7:c5c430a4 r6:c5c43070 r5:c5c43000 r4:00000000
> [<bf10bc18>] (usb_disconnect [usbcore]) from [<bf10d788>]
> (hub_event+0x678/0x11dc [usbcore])
>   r10:00000100 r9:c05f1008 r8:c5c2dcf8 r7:c68fc400 r6:00000001 r5:40000000
>   r4:00000000
> [<bf10d110>] (hub_event [usbcore]) from [<c0031db0>]
> (process_one_work+0x1d8/0x41c)
>   r10:00000008 r9:00000000 r8:c060b1d0 r7:00000000 r6:c7ede200 r5:c6882480
>   r4:c5c2dcf8
> [<c0031bd8>] (process_one_work) from [<c0032030>] (worker_thread+0x3c/0x670)
>   r10:00000008 r9:c060b1e4 r8:c061ab60 r7:c6882498 r6:ffffe000 r5:c060b1d0
>   r4:c6882480
> [<c0031ff4>] (worker_thread) from [<c0038270>] (kthread+0x134/0x14c)
>   r10:c683fe90 r9:c0031ff4 r8:c6882480 r7:c6896000 r6:00000000 r5:c687bd80
>   r4:c6803e80
> [<c003813c>] (kthread) from [<c00090e0>] (ret_from_fork+0x14/0x34)
> Exception stack(0xc6897fb0 to 0xc6897ff8)
> 7fa0:                                     00000000 00000000 00000000 00000000
> 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>   r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c003813c
>   r4:c687bd80
> ---[ end trace cb9c7f93aaa3ed36 ]---
> ------------[ cut here ]------------
> 
> 

Hi Alexandre,

Do you have any insight on this error? I seem to recall something like this
when you were working on DA8xx MUSB last year.

I am wondering if this warning should be a warning in the kernel since it
seems like stopping CPPI when you unplug a cable even if it is busy is a
legitimate thing to do.
