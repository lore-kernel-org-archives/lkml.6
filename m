Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeCIJCb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:02:31 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36056 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeCIJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:02:27 -0500
X-Google-Smtp-Source: AG47ELtigiIPQU/aSWCBb/fM6VYWXxQxF+Oebz66va2Xce/+Myq4LtpWr+BdRYlGft30d29o+KNE1A==
Date: Fri, 9 Mar 2018 10:02:23 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, dvhart@infradead.org, andy@infradead.org,
        mario.limonciello@dell.com, tiwai@suse.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180309090223.xb55ltac4pfesdrh@pali>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308091023.9061-3-kai.heng.feng@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 March 2018 17:10:23 Kai-Heng Feng wrote:
> Some Dell platforms (Preicsion 7510/7710/7520/7720) have a BIOS option
> "Switchable Graphics" (SG).
> 
> When SG is enabled, we have:
> 00:02.0 VGA compatible controller: Intel Corporation Device 591b (rev 04)
> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.  [AMD/ATI] Ellesmere [Polaris10]
> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 580]
> 
> The Intel Audio outputs all the sound, including HDMI audio. The audio
> controller comes with AMD graphics doesn't get used.
> 
> When SG is disabled, we have:
> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.  [AMD/ATI] Ellesmere [Polaris10]
> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 580]
> 
> Now it's a typical discrete-only system. HDMI audio comes from AMD audio
> controller, others from Intel audio controller.
> 
> When SG is enabled, the unused AMD audio controller still exposes its
> sysfs, so userspace still opens the control file and stream. If
> userspace tries to output sound through the stream, it hangs when
> runtime suspend kicks in:
> [ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
> [ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
> 
> Since the discrete audio controller isn't useful when SG enabled, we
> should just disable the device.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2: Mario suggested to squash the HDA part into the same series.
> 
>  sound/pci/hda/hda_intel.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 96143df19b21..8e3e8b88624a 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -49,6 +49,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/time.h>
>  #include <linux/completion.h>
> +#include <linux/dell-common.h>
>  
>  #ifdef CONFIG_X86
>  /* for snoop control */
> @@ -1620,6 +1621,35 @@ static void check_msi(struct azx *chip)
>  	}
>  }
>  
> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
> +{
> +	static int (*dell_switchable_gfx_enabled_func)(bool *);
> +	bool enabled;
> +	int err;
> +
> +	if (pdev->vendor != PCI_VENDOR_ID_ATI ||
> +	    pdev->subsystem_vendor != PCI_VENDOR_ID_DELL)
> +		return false;

Are you sure that you want to do this check unconditionally on all
machines which have enabled CONFIG_DELL_LAPTOP?

Subvendor ID_DELL for dell specific code is not suspicious, but ID_ATI
is. What would happen if ATI vendor changes to NVIDIA or other which is
not related to Dell?

Interesting question would be, how handle this situation Windows?

> +	dell_switchable_gfx_enabled_func =
> +		symbol_request(dell_switchable_gfx_enabled);
> +	if (!dell_switchable_gfx_enabled_func)
> +		return false;
> +
> +	err = dell_switchable_gfx_enabled_func(&enabled);
> +
> +	symbol_put(dell_switchable_gfx_enabled);
> +
> +	return !err ? enabled : false;
> +}
> +#else
> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
> +{
> +	return false;
> +}
> +#endif
> +
>  /* check the snoop mode availability */
>  static void azx_check_snoop_available(struct azx *chip)
>  {
> @@ -1702,6 +1732,11 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
>  	if (err < 0)
>  		return err;
>  
> +	if (check_dell_switchable_gfx(pci)) {
> +		pci_disable_device(pci);
> +		return -ENODEV;
> +	}
> +
>  	hda = kzalloc(sizeof(*hda), GFP_KERNEL);
>  	if (!hda) {
>  		pci_disable_device(pci);

-- 
Pali Rohár
pali.rohar@gmail.com
