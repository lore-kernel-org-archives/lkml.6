Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeDLONB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:13:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40333 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbeDLOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:12:57 -0400
X-Google-Smtp-Source: AIpwx4+I5kmMR1rX8JS3Qkb6XznqSKE3JtaKpyTnkDIHzJzvstXovu5VrzXLvwLLUXi6/ntVkaz/UA==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hr2nk8zs5.wl-tiwai@suse.de>
Date: Thu, 12 Apr 2018 22:12:49 +0800
Cc: Lukas Wunner <lukas@wunner.de>, mario.limonciello@dell.com,
        pali.rohar@gmail.com, andy@infradead.org, dvhart@infradead.org,
        mjg59@srcf.ucam.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <018FF40E-B380-4E22-9599-2F4A2A8B51B7@canonical.com>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 6:50 PM, Takashi Iwai <tiwai@suse.de> wrote:

> On Thu, 12 Apr 2018 12:42:39 +0200,
> Kai-Heng Feng wrote:
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
>>
>> Since the discrete audio controller isn't useful when SG enabled, we
>> should just disable the device.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Adding Lukas to Cc.
>
> I thought we manage this better now with runtime PM by Lukas's recent
> patchset?
>

Yes, that's true. I'll update commit log for next iteration.

Nevertheless, the unusable control file and stream still get exposed via  
sysfs.
We should disable them when SG is enabled.

Kai-Heng

>
> thanks,
>
> Takashi
>
>> ---
>> v3: Simplify dell_switchable_gfx_is_enabled() by returning bool instead
>>     of error code.
>>     Use DMI_DEV_TYPE_OEM_STRING to match Dell System.
>>
>> v2: Mario suggested to squash the HDA part into the same series.
>>
>>  sound/pci/hda/hda_intel.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 7720e3102bcc..d9310616d5ca 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -49,6 +49,8 @@
>>  #include <linux/clocksource.h>
>>  #include <linux/time.h>
>>  #include <linux/completion.h>
>> +#include <linux/dell-common.h>
>> +#include <linux/dmi.h>
>>
>>  #ifdef CONFIG_X86
>>  /* for snoop control */
>> @@ -1629,6 +1631,38 @@ static void check_msi(struct azx *chip)
>>  	}
>>  }
>>
>> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
>> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
>> +{
>> +	bool (*dell_switchable_gfx_is_enabled_func)(void);
>> +	bool enabled;
>> +
>> +	/* Only need to check for Dell laptops and AIOs */
>> +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) ||
>> +	    !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
>> +	      dmi_match(DMI_CHASSIS_TYPE, "13")) ||
>> +	    !(pdev->vendor == PCI_VENDOR_ID_ATI ||
>> +	      pdev->vendor == PCI_VENDOR_ID_NVIDIA))
>> +		return false;
>> +
>> +	dell_switchable_gfx_is_enabled_func =
>> +		symbol_request(dell_switchable_gfx_is_enabled);
>> +	if (!dell_switchable_gfx_is_enabled_func)
>> +		return false;
>> +
>> +	enabled = dell_switchable_gfx_is_enabled_func();
>> +
>> +	symbol_put(dell_switchable_gfx_is_enabled);
>> +
>> +	return enabled;
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
>> @@ -1711,6 +1745,11 @@ static int azx_create(struct snd_card *card,  
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
>> 2.17.0
