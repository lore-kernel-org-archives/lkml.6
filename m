Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeA3NOe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:14:34 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44483 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeA3NOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:14:31 -0500
X-Google-Smtp-Source: AH8x224kFTMgdwH1ZsQZ9JD67CJ0wIXICpbgFIryFaEvFQ/jhK9RsYbklAzFeKRHPlbWE3uzu2xQWPRqhv9bQBI/1rA=
MIME-Version: 1.0
In-Reply-To: <1565457.zQ5DZdIQMY@amdc3058>
References: <1479153557-20849-1-git-send-email-malat@debian.org>
 <CGME20171221220824epcas3p1cd1ac40219c9b8bf7be52bc104e31918@epcas3p1.samsung.com>
 <20171221220757.24672-1-malat@debian.org> <1565457.zQ5DZdIQMY@amdc3058>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 30 Jan 2018 14:14:10 +0100
X-Google-Sender-Auth: PCxmYGzxBvGRPJ3lfMrfK3gExC8
Message-ID: <CA+7wUsxXE=QDsGvYOPzW+kdd1OjHnEikUjusQXNNFUuTbdbQTQ@mail.gmail.com>
Subject: Re: [PATCH v3] Fix loading of module radeonfb on PowerMac
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej,

On Wed, Jan 3, 2018 at 3:47 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> On Thursday, December 21, 2017 11:07:56 PM Mathieu Malaterre wrote:
>> When the linux kernel is build with (typical kernel ship with Debian
>> installer):
>>
>> CONFIG_FB_OF=y
>> CONFIG_VT_HW_CONSOLE_BINDING=y
>> CONFIG_FB_RADEON=m
>>
>> The offb driver takes precedence over module radeonfb. It is then
>> impossible to load the module, error reported is:
>>
>> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
>> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
>> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
>> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
>>
>> This patch reproduce the behavior of the module radeon, so as to make it
>> possible to load radeonfb when offb is first loaded.
>>
>> It should be noticed that `offb_destroy` is never called which explain the
>> need to skip error detection on the radeon side.
>
> This still needs to be explained more, from my last mail:
>
> "The last put_fb_info() on fb_info should call ->fb_destroy
> (offb_destroy in our case) and remove_conflicting_framebuffers()
> is calling put_fb_info() so there is some extra reference on
> fb_info somewhere preventing it from going away.
>
> Please look into fixing this."

I am not familiar with the fb stuff internals but here is what I see:

# modprobe radeonfb

leads to:

[   52.058546] bus: 'pci': add driver radeonfb
[   52.058588] bus: 'pci': driver_probe_device: matched device
0000:00:10.0 with driver radeonfb
[   52.058595] bus: 'pci': really_probe: probing driver radeonfb with
device 0000:00:10.0
[   52.058608] devices_kset: Moving 0000:00:10.0 to end of list
[   52.058613] radeonfb_pci_register BEGIN
[   52.058634] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
<at this point radeon_kick_out_firmware_fb is called>
[   52.058666] checking generic (9c008000 96000) vs hw (98000000 8000000)
[   52.058667] fb: switching to radeonfb from OFfb ATY,RockHo
[   52.058844] Console: switching to colour dummy device 80x25
[   52.058860] device: 'fb0': device_unregister
[   52.058956] PM: Removing info for No Bus:fb0
[   52.059014] device: 'fb0': device_create_release
<a call to do_unregister_framebuffer is done>
<put_fb_info is done with a count=2 and dev=NULL>
[   52.059048] device: 'vtcon1': device_unregister
[   52.059076] PM: Removing info for No Bus:vtcon1
[   52.059091] device: 'vtcon1': device_create_release
[   52.059107] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem
0x98000000-0x9fffffff pref]
[   52.256151] aper_base: 98000000 MC_FB_LOC to: 9bff9800, MC_AGP_LOC
to: ffffa000
[   52.256157] radeonfb (0000:00:10.0): Found 32768k of DDR 64 bits
wide videoram

I can confirm that offb_destroy is never called (not sure exactly
why), but in any case the call to radeon_kick_out_firmware_fb happen
much earlier, at least before the put_fb_info.

Could you describe a bit more the chain of calls you were thinking of ?

>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> Link: https://bugs.debian.org/826629#57
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=119741
>> Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
>> ---
>> v2: Only fails when CONFIG_PCC is not set
>> v3: Only fails when CONFIG_FB_OF is not set, CONFIG_PCC was too broad. Since the conflicts in region is due to OFfb explicitly refers to it.
>
> It seems that there may still be configurations when this is
> incorrect -> when offb drives primary (non-radeon) card and radeonfb
> drives secondary (radeon) card..
>
>>  drivers/video/fbdev/aty/radeon_base.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
>> index 4d77daeecf99..221879196531 100644
>> --- a/drivers/video/fbdev/aty/radeon_base.c
>> +++ b/drivers/video/fbdev/aty/radeon_base.c
>> @@ -2259,6 +2259,22 @@ static const struct bin_attribute edid2_attr = {
>>       .read   = radeon_show_edid2,
>>  };
>>
>> +static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
>> +{
>> +     struct apertures_struct *ap;
>> +
>> +     ap = alloc_apertures(1);
>> +     if (!ap)
>> +             return -ENOMEM;
>> +
>> +     ap->ranges[0].base = pci_resource_start(pdev, 0);
>> +     ap->ranges[0].size = pci_resource_len(pdev, 0);
>> +
>> +     remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
>> +     kfree(ap);
>> +
>> +     return 0;
>> +}
>>
>>  static int radeonfb_pci_register(struct pci_dev *pdev,
>>                                const struct pci_device_id *ent)
>> @@ -2312,19 +2328,27 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
>>       rinfo->fb_base_phys = pci_resource_start (pdev, 0);
>>       rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
>>
>> +     ret = radeon_kick_out_firmware_fb(pdev);
>> +     if (ret)
>> +             return ret;
>> +
>>       /* request the mem regions */
>>       ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
>>       if (ret < 0) {
>> +#ifndef CONFIG_FB_OF
>>               printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
>>                       pci_name(rinfo->pdev));
>>               goto err_release_fb;
>> +#endif
>>       }
>>
>>       ret = pci_request_region(pdev, 2, "radeonfb mmio");
>>       if (ret < 0) {
>> +#ifndef CONFIG_FB_OF
>>               printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
>>                       pci_name(rinfo->pdev));
>>               goto err_release_pci0;
>> +#endif
>>       }
>>
>>       /* map the regions */
>> @@ -2509,10 +2533,12 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
>>       iounmap(rinfo->mmio_base);
>>  err_release_pci2:
>>       pci_release_region(pdev, 2);
>> +#ifndef CONFIG_FB_OF
>>  err_release_pci0:
>>       pci_release_region(pdev, 0);
>>  err_release_fb:
>>          framebuffer_release(info);
>> +#endif
>>  err_disable:
>>  err_out:
>>       return ret;
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>

Thanks,
-M
