Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeEBKv1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:51:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60017 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeEBKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:51:24 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: prefer bool over int for predicates
Date: Wed, 02 May 2018 12:51:05 +0200
Message-ID: <1824583.Oe7ze6gOva@aspire.rjw.lan>
In-Reply-To: <20180408084627.xignebybfxyds2t5@gmail.com>
References: <20180408084627.xignebybfxyds2t5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 8, 2018 10:46:27 AM CEST Joey Pabalinas wrote:
> 
> --dohnnvt2hwn6rmo4
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Prefer bool over int for variables / returns which are
> predicate expressions to make it explicit that these
> expressions are evaluating simple "yes or no?" queries.

In new code - yes.

But changing old code just for this purpose is at least questionable.

> This makes it more obvious which expressions are _not_
> that simple and require more attention, e.g. an `int ret`
> meant to hold 0 or -ENOENT as a return value or an
> `unsigned nmemb` meant to refer to the number of valid
> members in some arbitrary array.
> 
> Change relevant variable / return types from int to bool and
> prefer a true / false value for predicate expressions versus
> a plain 1 / 0 value.

This makes a bunch of unrelated changes without a clear pattern
in many places and I'm not convinced that the reason is good enough.

> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> 
>  drivers/acpi/battery.c  |  4 ++--
>  drivers/acpi/ec.c       | 20 +++++++++-----------
>  drivers/acpi/pci_root.c | 17 ++++++-----------
>  drivers/acpi/scan.c     |  6 +++---
>  include/acpi/acpi_bus.h |  2 +-
>  5 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index bdb24d636d9acc9c1a..f1a5fb5252969f0478 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1416,7 +1416,7 @@ static int acpi_battery_add(struct acpi_device *devic=
> e)
>  	battery->pm_nb.notifier_call =3D battery_notify;
>  	register_pm_notifier(&battery->pm_nb);
> =20

Broken whitespace.

> -	device_init_wakeup(&device->dev, 1);
> +	device_init_wakeup(&device->dev, true);
> =20
>  	return result;
> =20
> @@ -1434,7 +1434,7 @@ static int acpi_battery_remove(struct acpi_device *de=
> vice)
> =20
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> -	device_init_wakeup(&device->dev, 0);
> +	device_init_wakeup(&device->dev, false);
>  	battery =3D acpi_driver_data(device);
>  	unregister_pm_notifier(&battery->pm_nb);
>  #ifdef CONFIG_ACPI_PROCFS_POWER
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 30a5729565575f83cb..d4a564ab9cdd53046c 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -350,7 +350,7 @@ static inline bool acpi_ec_is_gpe_raised(struct acpi_ec=
>  *ec)
>  	acpi_event_status gpe_status =3D 0;
> =20
>  	(void)acpi_get_gpe_status(NULL, ec->gpe, &gpe_status);
> -	return (gpe_status & ACPI_EVENT_FLAG_STATUS_SET) ? true : false;
> +	return gpe_status & ACPI_EVENT_FLAG_STATUS_SET;

And this isn't entirely correct even.

You should apply !! to the expression to get the same result really.

Thanks,
Rafael
