Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3887C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EB82084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7T5FsE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EB82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeLKUKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:10:16 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35290 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKUKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:10:13 -0500
Received: by mail-vs1-f66.google.com with SMTP id e7so9678097vsc.2;
        Tue, 11 Dec 2018 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BnF31uVlleUd/QqohHcS7FV9jClDWuHYsgpB7w12Yvs=;
        b=N7T5FsE11V49kC6h4/WGI85oODkVstVFmcPhfI6RAR9nmCA/p+Ya41g/l83jHZIIkN
         uSE64byU08YdMX1BACJJNX94rK2EOidpkPDpJ8nV1xlphDhmpxAmMHfWvdTCie/WjHIq
         JT2ZUKAy7of+H1nQRQBcGPV7079eKh019krPOZ2NdOt90pe7AIaCjAgDGRReSc2NYGgC
         S+CMJugQeewMRrbq/nIGyAC/qKwoegRkXjo4JL5cpPUVxBy3fTBkVe6mDlDGl/ygU4Vb
         UYvbWf4OK64DgbMPQn76AoglO7BjP5V1iCnZK8xmNviU8zQo28jQGNqUXzhlJ/Z9psNr
         yNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BnF31uVlleUd/QqohHcS7FV9jClDWuHYsgpB7w12Yvs=;
        b=SOnZtHL6XpmYq/4qZwFm6gkKUT8d1vilwf6RQau9pWetup/tWy2S8Y5HVF2tajmgeJ
         PsvXYmOkrf/TR3w+SXohp/79U2G/LECX9zuzEmv1MawTAR9eUZc/Bq73wMJpf9g74clh
         ZWA2+Gh796sKzxi5g7IUH6Yrqp7Rvg+iT8dj+NdPPKTOR1qWrj9RCir87/v0g6z2lr/w
         /GOW99V7fHKku5Oxl6xqFwHZkRKZqV4O4o2lUhQPL/hy3GUVJszLcamrqKvGEKOp67fj
         969Bk4fCp6kxg5Pef4/9iRDJQXsHD8slWehQvFAf3OIQK5npfIOxokrubweA0PwZ7k9n
         jWhg==
X-Gm-Message-State: AA+aEWYmw456tD/TaFecGC5sGyptry8OJ4PHrobXNFWqpUjs6HA39NC2
        R5kp1Z3Jd99F9Hh63GSOlQ==
X-Google-Smtp-Source: AFSGD/XosfMLEz0hAEl8xWHKTs17ngyFxk2iBn9P2zlw4RIEaULgUMIpRNIoxI3E1tJjjiQ5qiNtjw==
X-Received: by 2002:a67:3759:: with SMTP id e86mr7747863vsa.69.1544559011156;
        Tue, 11 Dec 2018 12:10:11 -0800 (PST)
Received: from 960 ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id m89sm9588536vsh.22.2018.12.11.12.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 12:10:10 -0800 (PST)
Message-ID: <757a7ce6ae8ea5f040fb7bb1bdf9768799d82a11.camel@gmail.com>
Subject: Re: [PATCH v10 2/3] x86: add support for Huawei WMI hotkeys.
From:   ayman.bagabas@gmail.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Date:   Tue, 11 Dec 2018 15:10:07 -0500
In-Reply-To: <CAHp75VcNstKd3JW-D8QSQWez-TxrwsKrkA-a1D11kZW72fSqfw@mail.gmail.com>
References: <20181211060125.28671-1-ayman.bagabas@gmail.com>
         <20181211060125.28671-3-ayman.bagabas@gmail.com>
         <CAHp75VcNstKd3JW-D8QSQWez-TxrwsKrkA-a1D11kZW72fSqfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 12:14 +0200, Andy Shevchenko wrote:
> On Tue, Dec 11, 2018 at 8:02 AM Ayman Bagabas <
> ayman.bagabas@gmail.com> wrote:
> > This driver adds support for missing hotkeys on some Huawei
> > laptops.
> > Laptops such as the Matebook X have non functioning hotkeys.
> > Whereas
> > newer laptops such as the Matebook X Pro come with working hotkeys
> > out
> > of the box.
> > 
> > Old laptops, such as the Matebook X, report hotkey events through
> > ACPI
> > device "\WMI0". However, new laptops, such as the Matebook X Pro,
> > does not have this WMI device.
> > 
> > All the hotkeys on the Matebook X Pro work fine
> > without this patch except (micmute, wlan, and huawei key). These
> > keys
> > and the brightness keys report events to "\AMW0" ACPI device. One
> > problem is that brightness keys on the Matebook X Pro work without
> > this
> > patch. This results in reporting two brightness key press
> > events one is captured by ACPI and another by this driver.
> > 
> > A solution would be to check if such event came from the "\AMW0"
> > WMI driver
> > then skip reporting event. Another solution would be to leave this
> > to
> > user-space to handle. Which can be achieved by using "hwdb" tables
> > and
> > remap those keys to "unknown". This solution seems more natural to
> > me
> > because it leaves the decision to user-space.
> > 
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> > ---
> >  drivers/platform/x86/Kconfig      |  17 +++
> >  drivers/platform/x86/Makefile     |   1 +
> >  drivers/platform/x86/huawei-wmi.c | 220
> > ++++++++++++++++++++++++++++++
> >  3 files changed, 238 insertions(+)
> >  create mode 100644 drivers/platform/x86/huawei-wmi.c
> > 
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig
> > index 87f70e8f4dd0..45ef4d22f14c 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1292,6 +1292,23 @@ config INTEL_ATOMISP2_PM
> >           To compile this driver as a module, choose M here: the
> > module
> >           will be called intel_atomisp2_pm.
> > 
> > +config HUAWEI_WMI
> > +       tristate "Huawei WMI hotkeys driver"
> > +       depends on ACPI_WMI
> > +       depends on INPUT
> > +       select INPUT_SPARSEKMAP
> > +       select LEDS_CLASS
> > +       select LEDS_TRIGGERS
> > +       select LEDS_TRIGGER_AUDIO
> > +       select NEW_LEDS
> > +       help
> > +         This driver provides support for Huawei WMI hotkeys.
> > +         It enables the missing keys and adds support to the
> > micmute
> > +         LED found on some of these laptops.
> > +
> > +         To compile this driver as a module, choose M here: the
> > module
> > +         will be called huawei-wmi.
> > +
> >  endif # X86_PLATFORM_DEVICES
> > 
> >  config PMC_ATOM
> > diff --git a/drivers/platform/x86/Makefile
> > b/drivers/platform/x86/Makefile
> > index 39ae94135406..d841c550e3cc 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -32,6 +32,7 @@ obj-$(CONFIG_ACERHDF)         += acerhdf.o
> >  obj-$(CONFIG_HP_ACCEL)         += hp_accel.o
> >  obj-$(CONFIG_HP_WIRELESS)      += hp-wireless.o
> >  obj-$(CONFIG_HP_WMI)           += hp-wmi.o
> > +obj-$(CONFIG_HUAWEI_WMI)               += huawei-wmi.o
> >  obj-$(CONFIG_AMILO_RFKILL)     += amilo-rfkill.o
> >  obj-$(CONFIG_GPD_POCKET_FAN)   += gpd-pocket-fan.o
> >  obj-$(CONFIG_TC1100_WMI)       += tc1100-wmi.o
> > diff --git a/drivers/platform/x86/huawei-wmi.c
> > b/drivers/platform/x86/huawei-wmi.c
> > new file mode 100644
> > index 000000000000..89ba7ea33499
> > --- /dev/null
> > +++ b/drivers/platform/x86/huawei-wmi.c
> > @@ -0,0 +1,220 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *  Huawei WMI hotkeys
> > + *
> > + *  Copyright (C) 2018       Ayman Bagabas <
> > ayman.bagabas@gmail.com>
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/input.h>
> > +#include <linux/input/sparse-keymap.h>
> > +#include <linux/leds.h>
> > +#include <linux/module.h>
> > +#include <linux/wmi.h>
> > +
> > +/*
> > + * Huawei WMI GUIDs
> > + */
> > +#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
> > +#define AMW0_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
> > +
> > +#define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
> > +
> > +struct huawei_wmi_priv {
> > +       struct input_dev *idev;
> > +       struct led_classdev cdev;
> > +       acpi_handle handle;
> > +       char *acpi_method;
> > +};
> > +
> > +static const struct key_entry huawei_wmi_keymap[] = {
> > +       { KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
> > +       { KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
> > +       { KE_KEY,    0x284, { KEY_MUTE } },
> > +       { KE_KEY,    0x285, { KEY_VOLUMEDOWN } },
> > +       { KE_KEY,    0x286, { KEY_VOLUMEUP } },
> > +       { KE_KEY,    0x287, { KEY_MICMUTE } },
> > +       { KE_KEY,    0x289, { KEY_WLAN } },
> > +       // Huawei |M| key
> > +       { KE_KEY,    0x28a, { KEY_CONFIG } },
> > +       // Keyboard backlight
> > +       { KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
> > +       { KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
> > +       { KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
> > +       { KE_END,        0 }
> > +};
> > +
> > +static int huawei_wmi_micmute_led_set(struct led_classdev
> > *led_cdev,
> > +               enum led_brightness brightness)
> > +{
> > +       struct huawei_wmi_priv *priv = dev_get_drvdata(led_cdev-
> > >dev->parent);
> > +       acpi_status status;
> > +       union acpi_object args[3];
> > +       struct acpi_object_list arg_list = {
> > +               .pointer = args,
> > +               .count = ARRAY_SIZE(args),
> > +       };
> > +
> > +       args[0].type = args[1].type = args[2].type =
> > ACPI_TYPE_INTEGER;
> > +       args[1].integer.value = 0x04;
> > +
> > +       if (strcmp(priv->acpi_method, "SPIN") == 0) {
> > +               args[0].integer.value = 0;
> > +               args[2].integer.value = brightness ? 1 : 0;
> > +       } else if (strcmp(priv->acpi_method, "WPIN") == 0) {
> > +               args[0].integer.value = 1;
> > +               args[2].integer.value = brightness ? 0 : 1;
> > +       } else {
> > +               return -EINVAL;
> > +       }
> > +
> > +       status = acpi_evaluate_object(priv->handle, priv-
> > >acpi_method, &arg_list, NULL);
> > +       if (ACPI_FAILURE(status))
> > +               return -ENXIO;
> > +
> > +       return 0;
> > +}
> > +
> > +static int huawei_wmi_leds_setup(struct wmi_device *wdev)
> > +{
> > +       struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +       acpi_status status;
> > +
> > +       /* Skip registering LED subsystem if no ACPI method was
> > found.
> > +        * ec_get_handle() returns the first embedded controller
> > device
> > +        * handle which then used to locate SPIN and WPIN methods.
> > +        */
> 
> Comment style is cripple here.
> All issues we may fix when applying.
> 
> > +       priv->handle = ec_get_handle();
> > +       if (!priv->handle)
> > +               return 0;
> > +
> > +       if (acpi_has_method(priv->handle, "SPIN"))
> > +               priv->acpi_method = "SPIN";
> > +       else if (acpi_has_method(priv->handle, "WPIN"))
> > +               priv->acpi_method = "WPIN";
> > +       else
> > +               return 0;
> > +
> > +       priv->cdev.name = "platform::micmute";
> > +       priv->cdev.max_brightness = 1;
> > +       priv->cdev.brightness_set_blocking =
> > huawei_wmi_micmute_led_set;
> > +       priv->cdev.default_trigger = "audio-micmute";
> > +       priv->cdev.brightness =
> > ledtrig_audio_get(LED_AUDIO_MICMUTE);
> > +       priv->cdev.dev = &wdev->dev;
> > +       priv->cdev.flags = LED_CORE_SUSPENDRESUME;
> > +
> > +       return devm_led_classdev_register(&wdev->dev, &priv->cdev);
> > +}
> > +
> > +static void huawei_wmi_process_key(struct wmi_device *wdev, int
> > code)
> > +{
> > +       struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +       const struct key_entry *key;
> > +
> > +       /*
> > +        * WMI0 uses code 0x80 to indicate a hotkey event.
> > +        * The actual key is fetched from the method WQ00
> > +        * using WMI0_EXPENSIVE_GUID.
> > +        */
> > +       if (code == 0x80) {
> > +               struct acpi_buffer response = {
> > ACPI_ALLOCATE_BUFFER, NULL };
> > +               union acpi_object *obj;
> > +               acpi_status status;
> > +
> > +               status = wmi_query_block(WMI0_EXPENSIVE_GUID, 0,
> > &response);
> > +               if (ACPI_FAILURE(status))
> > +                       return;
> > +
> > +               obj = (union acpi_object *)response.pointer;
> > +               if (obj && obj->type == ACPI_TYPE_INTEGER)
> > +                       code = obj->integer.value;
> > +
> > +               kfree(response.pointer);
> > +       }
> > +
> > +       key = sparse_keymap_entry_from_scancode(priv->idev, code);
> > +       if (!key) {
> > +               dev_info(&wdev->dev, "Unknown key pressed, code:
> > 0x%04x\n", code);
> > +               return;
> > +       }
> > +
> > +       sparse_keymap_report_entry(priv->idev, key, 1, true);
> > +}
> > +
> > +static void huawei_wmi_notify(struct wmi_device *wdev,
> > +               union acpi_object *obj)
> > +{
> > +       if (obj->type == ACPI_TYPE_INTEGER)
> > +               huawei_wmi_process_key(wdev, obj->integer.value);
> > +       else
> > +               dev_info(&wdev->dev, "Bad response type %d\n", obj-
> > >type);
> > +}
> > +
> > +static int huawei_wmi_input_setup(struct wmi_device *wdev)
> > +{
> > +       struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +       int err;
> > +
> > +       priv->idev = devm_input_allocate_device(&wdev->dev);
> > +       if (!priv->idev)
> > +               return -ENOMEM;
> > +
> > +       priv->idev->name = "Huawei WMI hotkeys";
> > +       priv->idev->phys = "wmi/input0";
> > +       priv->idev->id.bustype = BUS_HOST;
> > +       priv->idev->dev.parent = &wdev->dev;
> > +
> > +       err = sparse_keymap_setup(priv->idev, huawei_wmi_keymap,
> > NULL);
> > +       if (err)
> > +               return err;
> > +
> > +       err = input_register_device(priv->idev);
> > +       if (err)
> > +               return err;
> > +
> > +       return 0;
> 
> return input_register_device(...);
> 
> > +}
> > +
> > +static int huawei_wmi_probe(struct wmi_device *wdev)
> > +{
> > +       struct huawei_wmi_priv *priv;
> > +       int err;
> > +
> > +       priv = devm_kzalloc(&wdev->dev, sizeof(struct
> > huawei_wmi_priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> 
> + blank line.
> 
> > +       dev_set_drvdata(&wdev->dev, priv);
> > +
> > +       err = huawei_wmi_input_setup(wdev);
> > +       if (err)
> > +               return err;
> > +
> > +       err = huawei_wmi_leds_setup(wdev);
> > +       if (err)
> > +               return err;
> > +
> > +       return 0;
> 
> return huawei_wmi_leds_setup(...);
> 
> > +}
> > +
> > +static const struct wmi_device_id huawei_wmi_id_table[] = {
> > +       { .guid_string = WMI0_EVENT_GUID },
> > +       { .guid_string = AMW0_EVENT_GUID },
> > +       {  }
> > +};
> > +
> > +static struct wmi_driver huawei_wmi_driver = {
> > +       .driver = {
> > +               .name = "huawei-wmi",
> > +       },
> > +       .id_table = huawei_wmi_id_table,
> > +       .probe = huawei_wmi_probe,
> > +       .notify = huawei_wmi_notify,
> > +};
> > +
> > +module_wmi_driver(huawei_wmi_driver);
> > +
> > +MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
> > +MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
> > +MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
> > +MODULE_DESCRIPTION("Huawei WMI hotkeys");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.19.2
> > 
> 
> 

Do I need to resubmit?

