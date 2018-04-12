Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDLOPv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:15:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40406 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbeDLOPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:15:49 -0400
X-Google-Smtp-Source: AIpwx49LcDzqhcBgESFgLaExcmRs0KVoIb4NVTa7oGz3UeDQp1P8LgnyWwdZx6mzTWqh7T3n6/lcDg==
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180412105909.tbyfcjm55sb47hiq@pali>
Date: Thu, 12 Apr 2018 22:15:41 +0800
Cc: Takashi Iwai <tiwai@suse.de>, Lukas Wunner <lukas@wunner.de>,
        mario.limonciello@dell.com, andy@infradead.org, dvhart@infradead.org,
        mjg59@srcf.ucam.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de> <20180412105909.tbyfcjm55sb47hiq@pali>
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 6:59 PM, Pali Rohár <pali.rohar@gmail.com> wrote:

> On Thursday 12 April 2018 12:50:02 Takashi Iwai wrote:
>>> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
>>> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
>>> +{
>>> +	bool (*dell_switchable_gfx_is_enabled_func)(void);
>>> +	bool enabled;
>>> +
>>> +	/* Only need to check for Dell laptops and AIOs */
>>> +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) ||
>>> +	    !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
>>> +	      dmi_match(DMI_CHASSIS_TYPE, "13")) ||
>>> +	    !(pdev->vendor == PCI_VENDOR_ID_ATI ||
>>> +	      pdev->vendor == PCI_VENDOR_ID_NVIDIA))
>>> +		return false;
> ...
>>> @@ -1711,6 +1745,11 @@ static int azx_create(struct snd_card *card,  
>>> struct pci_dev *pci,
>>>  	if (err < 0)
>>>  		return err;
>>>
>>> +	if (check_dell_switchable_gfx(pci)) {
>>> +		pci_disable_device(pci);
>
> Hi!
>
> Now looking at it again... This code disables all ATI and NVIDIA sound
> cards available in any Dell System (laptop or AIO) if system says that
> SG is enabled, right?

Yes.

>
> It means that also any external ATI or NVIDIA PCI card with audio device
> connected to Thunderbolt (e.g. via PCI <--> TB bridge) is always
> unconditionally disabled too?

I never thought of this case, thanks for bringing this up.
Do you have any suggestion to check if it connects to the system via  
Thunderbolt?

Kai-Heng

>
>>> +		return -ENODEV;
>>> +	}
>
> -- 
> Pali Rohár
> pali.rohar@gmail.com
