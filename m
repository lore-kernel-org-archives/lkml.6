Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeDLK7P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:59:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40926 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeDLK7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:59:12 -0400
X-Google-Smtp-Source: AIpwx49KWSQGIBM9Wxs1j1tJHVRBFcSE44FBtlLrsGd5EtYIdQFW+HZru4dZHIaRz9u4Aaa7D/bbjg==
Date: Thu, 12 Apr 2018 12:59:09 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>, mario.limonciello@dell.com,
        andy@infradead.org, dvhart@infradead.org, mjg59@srcf.ucam.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180412105909.tbyfcjm55sb47hiq@pali>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hr2nk8zs5.wl-tiwai@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 April 2018 12:50:02 Takashi Iwai wrote:
> > +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
> > +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
> > +{
> > +	bool (*dell_switchable_gfx_is_enabled_func)(void);
> > +	bool enabled;
> > +
> > +	/* Only need to check for Dell laptops and AIOs */
> > +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) ||
> > +	    !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
> > +	      dmi_match(DMI_CHASSIS_TYPE, "13")) ||
> > +	    !(pdev->vendor == PCI_VENDOR_ID_ATI ||
> > +	      pdev->vendor == PCI_VENDOR_ID_NVIDIA))
> > +		return false;
...
> > @@ -1711,6 +1745,11 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
> >  	if (err < 0)
> >  		return err;
> >  
> > +	if (check_dell_switchable_gfx(pci)) {
> > +		pci_disable_device(pci);

Hi!

Now looking at it again... This code disables all ATI and NVIDIA sound
cards available in any Dell System (laptop or AIO) if system says that
SG is enabled, right?

It means that also any external ATI or NVIDIA PCI card with audio device
connected to Thunderbolt (e.g. via PCI <--> TB bridge) is always
unconditionally disabled too?

> > +		return -ENODEV;
> > +	}

-- 
Pali Rohár
pali.rohar@gmail.com
