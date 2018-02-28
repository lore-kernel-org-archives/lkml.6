Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeB1DG1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 22:06:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:36577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbeB1DGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 22:06:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,403,1515484800";
   d="scan'208";a="23772217"
Message-ID: <1519787186.2797.14.camel@intel.com>
Subject: Re: [RESEND PATCH v3 1/2] acpi: thermal: initialize tz_enabled to 1
From: Zhang Rui <rui.zhang@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <groeck@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sameer Nanda <snanda@chromium.org>, Len Brown <lenb@kernel.org>
Date: Wed, 28 Feb 2018 11:06:26 +0800
In-Reply-To: <CAJZ5v0gOaatHkd8mX88TewnXBsu4gspAb-M3bqzJTDXZ995atg@mail.gmail.com>
References: <20180226144118.24693-1-enric.balletbo@collabora.com>
         <CAJZ5v0gOaatHkd8mX88TewnXBsu4gspAb-M3bqzJTDXZ995atg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-27 at 17:17 +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 26, 2018 at 3:41 PM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> > 
> > From: Sameer Nanda <snanda@chromium.org>
> > 
> > In the acpi_thermal_add path, acpi_thermal_get_info gets called
> > before
> > acpi_thermal_register_thermal_zone.  Since tz_enabled was getting
> > set to
> > 1 only in acpi_thermal_register_thermal_zone, acpi_thermal_get_info
> > ended up disabling thermal polling.
> > 
> > Moved setting of tz_enabled to 1 into acpi_thermal_add itself.
> > 
> > Signed-off-by: Sameer Nanda <snanda@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com
> > >
> > ---
> > That's another attempt to land these to patches that were sent long
> > time
> > ago but never got merged, although, apparently, there is no issue
> > with
> > it. Latest discussion about these here:
> > 
> >  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg14360
> > 81.html
> I can apply this one, but the other one has to go in through the
> Rui's tree.
> 
No, the patch set was queued in my tree and then dropped.

This is because, the second patch makes the assumption that the soc
thermal driver .get_mode() must reflect the real thermal zone status
upon the thermal zone registration, but this is not true after checking
some of the driver code.

To apply patch 2/2, extra effort, which checks and fixes all the
thermal drivers one by one, is needed. It would be nice if someone can
do this, or else I will work on this, but some time later.

thanks,
rui
> > 
> > Changes in v3:
> > - [1/2] Make sure tz->tz_enabled is set properly before registering
> > the
> >   zone (Zhang Rui)
> > 
> > Changes in v2:
> > - [1/2] This patch is new from v1
> >   (https://patchwork.kernel.org/patch/9804229/)
> > 
> >  drivers/acpi/thermal.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 551b71a24b85..1d8f185e96c6 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -930,8 +930,6 @@ static int
> > acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
> >         if (ACPI_FAILURE(status))
> >                 return -ENODEV;
> > 
> > -       tz->tz_enabled = 1;
> > -
> >         dev_info(&tz->device->dev, "registered as
> > thermal_zone%d\n",
> >                  tz->thermal_zone->id);
> >         return 0;
> > @@ -1088,6 +1086,7 @@ static int acpi_thermal_add(struct
> > acpi_device *device)
> >                 return -ENOMEM;
> > 
> >         tz->device = device;
> > +       tz->tz_enabled = 1;
> >         strcpy(tz->name, device->pnp.bus_id);
> >         strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> >         strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> > --
> > 2.16.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
