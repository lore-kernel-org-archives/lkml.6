Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbeDWNwX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:52:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46517 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754981AbeDWNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:52:19 -0400
X-Google-Smtp-Source: AB8JxZp/qO9x2CufmKdQeqBabB1kGDZXLCXBqynKfb27pH3v5y4KuBFFsTzsJRFAoOlAPrWExo6/DcMapdx3O78RQos=
MIME-Version: 1.0
In-Reply-To: <20180420094432.13133-3-kai.heng.feng@canonical.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com> <20180420094432.13133-3-kai.heng.feng@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Apr 2018 16:52:18 +0300
Message-ID: <CAHp75VfBW_Ypka92qVK0sF1Rke=Yx8ZWoXmQ2RG6+Aw7+A2Vaw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Takashi Iwai <tiwai@suse.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 12:44 PM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
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
> When SG is enabled, the unused AMD audio contoller still exposes its
> sysfs, so userspace still opens the control file and stream. If
> userspace tries to output sound through the stream, it hangs the system.
>
> Since the discrete audio controller isn't useful when SG is enabled, we
> should just disable the device.

> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)

Yeah, as following existing naming scheme in the driver
(check_hdmi_disabled(), for example)
I would rather call it similar:

check_switchable_gfx_enabled()

> +{
> +       bool (*dell_switchable_gfx_is_enabled_func)(void);
> +       bool enabled;
> +
> +       /* Thunderbolt devices won't be switchable */
> +       if (pci_is_thunderbolt_attached(pdev))
> +               return false;
> +
> +       /* Only check for Dell laptops and AIOs */

> +       if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) ||
> +           !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
> +             dmi_match(DMI_CHASSIS_TYPE, "13")) ||

Can't we do it in more flexible way, i.e. using struct dmi_system_id
table and dmi_check_system() ?

> +           !(pdev->vendor == PCI_VENDOR_ID_ATI ||
> +             pdev->vendor == PCI_VENDOR_ID_NVIDIA))
> +               return false;

I would rather split DMI and PCI checks.

> +
> +       dell_switchable_gfx_is_enabled_func =
> +               symbol_request(dell_switchable_gfx_is_enabled);
> +       if (!dell_switchable_gfx_is_enabled_func)
> +               return false;
> +
> +       enabled = dell_switchable_gfx_is_enabled_func();
> +
> +       symbol_put(dell_switchable_gfx_is_enabled);
> +
> +       return enabled;
> +}
> +#else
> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)

inline

> +{
> +       return false;
> +}
> +#endif

-- 
With Best Regards,
Andy Shevchenko
