Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965597AbeCHKiz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:38:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47693 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934957AbeCHKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:38:53 -0500
X-Google-Smtp-Source: AG47ELvNN53X7vonxxIqiguiq0GhXLWNcxmJAdynzCsQt72oe2wjIggBjfzJ+lEOGBw5QWc4B+0rmA==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.15\))
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180308093848.GA24068@wunner.de>
Date: Thu, 8 Mar 2018 18:38:45 +0800
Cc: mjg59@srcf.ucam.org, pali.rohar@gmail.com, dvhart@infradead.org,
        andy@infradead.org, Mario Limonciello <mario.limonciello@dell.com>,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1A1B9259-DC5B-4C1A-96BD-7FCACDBFFBB3@canonical.com>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180308093848.GA24068@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
X-Mailer: Apple Mail (2.3445.6.15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 8, 2018, at 5:38 PM, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Mar 08, 2018 at 05:10:23PM +0800, Kai-Heng Feng wrote:
>> Some Dell platforms (Preicsion 7510/7710/7520/7720) have a BIOS option
>> "Switchable Graphics" (SG).
>>
>> When SG is enabled, we have:
>> 00:02.0 VGA compatible controller: Intel Corporation Device 591b (rev 04)
>> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.   
>> [AMD/ATI] Ellesmere [Polaris10]
>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere  
>> [Radeon RX 580]
>>
>> The Intel Audio outputs all the sound, including HDMI audio. The audio
>> controller comes with AMD graphics doesn't get used.
>>
>> When SG is disabled, we have:
>> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.   
>> [AMD/ATI] Ellesmere [Polaris10]
>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere  
>> [Radeon RX 580]
>>
>> Now it's a typical discrete-only system. HDMI audio comes from AMD audio
>> controller, others from Intel audio controller.
>>
>> When SG is enabled, the unused AMD audio controller still exposes its
>> sysfs, so userspace still opens the control file and stream. If
>> userspace tries to output sound through the stream, it hangs when
>> runtime suspend kicks in:
>> [ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
>> [ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
>
> This should be fixed by the following series:
> https://lists.freedesktop.org/archives/dri-devel/2018-March/168012.html
>
> Please verify that by testing the series on the machine in question.
> I'm hoping to get those patches in for 4.17.  I suspect that your
> patch may not be necessary then.

I no longer see the warning message with your patch. Thanks!

>
>
>> Since the discrete audio controller isn't useful when SG enabled, we
>> should just disable the device.
>
> I don't quite follow, when SG is enabled but hda_intel doesn't bind
> to the AMD audio device, how are you going to stream audio to
> external displays?  Are external DP/HDMI ports muxed to the integrated
> GPU when SG is enabled?

Yes. It's a muxed port.
The can directly output via integrated Intel GPU when SG is enabled.
The discrete audio controller never gets used when SG is enabled.

The unused discrete audio controller still gets opened by userspace:
# lsof /dev/snd/controlC1
COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF  NODE NAME
pulseaudi  965  gdm   18u   CHR  116,2      0t0 17913 /dev/snd/controlC1
pulseaudi 1423    u   17u   CHR  116,2      0t0 17913 /dev/snd/controlC1
pulseaudi 1423    u   24u   CHR  116,2      0t0 17913 /dev/snd/controlC1

Also pcms:
# ls /dev/snd/pcmC1*
/dev/snd/pcmC1D10p  /dev/snd/pcmC1D11p  /dev/snd/pcmC1D3p   
/dev/snd/pcmC1D7p  /dev/snd/pcmC1D8p  /dev/snd/pcmC1D9p

So I think my patch is still needed.

>
> Thanks,
>
> Lukas
>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2: Mario suggested to squash the HDA part into the same series.
>>
>>  sound/pci/hda/hda_intel.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 96143df19b21..8e3e8b88624a 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -49,6 +49,7 @@
>>  #include <linux/clocksource.h>
>>  #include <linux/time.h>
>>  #include <linux/completion.h>
>> +#include <linux/dell-common.h>
>>
>>  #ifdef CONFIG_X86
>>  /* for snoop control */
>> @@ -1620,6 +1621,35 @@ static void check_msi(struct azx *chip)
>>  	}
>>  }
>>
>> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
>> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
>> +{
>> +	static int (*dell_switchable_gfx_enabled_func)(bool *);
>> +	bool enabled;
>> +	int err;
>> +
>> +	if (pdev->vendor != PCI_VENDOR_ID_ATI ||
>> +	    pdev->subsystem_vendor != PCI_VENDOR_ID_DELL)
>> +		return false;
>> +
>> +	dell_switchable_gfx_enabled_func =
>> +		symbol_request(dell_switchable_gfx_enabled);
>> +	if (!dell_switchable_gfx_enabled_func)
>> +		return false;
>> +
>> +	err = dell_switchable_gfx_enabled_func(&enabled);
>> +
>> +	symbol_put(dell_switchable_gfx_enabled);
>> +
>> +	return !err ? enabled : false;
>> +}
>> +#else
>> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>  /* check the snoop mode availability */
>>  static void azx_check_snoop_available(struct azx *chip)
>>  {
>> @@ -1702,6 +1732,11 @@ static int azx_create(struct snd_card *card,  
>> struct pci_dev *pci,
>>  	if (err < 0)
>>  		return err;
>>
>> +	if (check_dell_switchable_gfx(pci)) {
>> +		pci_disable_device(pci);
>> +		return -ENODEV;
>> +	}
>> +
>>  	hda = kzalloc(sizeof(*hda), GFP_KERNEL);
>>  	if (!hda) {
>>  		pci_disable_device(pci);
>> -- 
>> 2.15.1
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
