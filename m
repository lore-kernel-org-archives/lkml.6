Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeDVJeK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 05:34:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38498 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbeDVJeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 05:34:07 -0400
X-Google-Smtp-Source: AIpwx48z+fAG9W0uYGI68HqOm4cFk5hz3CQXgIP+NpjalZrwmtCu+5oN3/uttPKiJWyPDL6v4DukjK0cfzReXxxvQlo=
MIME-Version: 1.0
In-Reply-To: <20180420032947.23023-1-msalter@redhat.com>
References: <20180420032947.23023-1-msalter@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 22 Apr 2018 11:34:06 +0200
X-Google-Sender-Auth: d4A243CZhlUGlCLpy33mlERe4jw
Message-ID: <CAJZ5v0g5iB1zoz7S0KBvimqj_ZEQLNX_LZ8g3vBoythJ_ZzjaA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / scan: Fix regression related to X-Gene UARTs
To: Mark Salter <msalter@redhat.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 5:29 AM, Mark Salter <msalter@redhat.com> wrote:
> Commit e361d1f85855 ("ACPI / scan: Fix enumeration for special UART
> devices") caused a regression with some X-Gene based platforms (Mustang
> and M400) with invalid DSDT.

I'm not convinced that making changes to the core ACPI device
enumeration code in order to cover up for firmware bugs is the right
approach.

> The DSDT makes it appear that the UART
> device is also a slave device attached to itself. With the above commit
> the UART won't be enumerated by ACPI scan (slave serial devices shouldn't
> be). So check for X-Gene UART device and skip slace device check on it.
>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  drivers/acpi/scan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index cc234e6a6297..1dcdd0122862 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1551,6 +1551,14 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>              fwnode_property_present(&device->fwnode, "baud")))
>                 return true;
>
> +       /*
> +        * Firmware on some arm64 X-Gene platforms will make the UART
> +        * device appear as both a UART and a slave of that UART. Just
> +        * bail out here for X-Gene UARTs.
> +        */
> +       if (!strcmp(acpi_device_hid(device), "APMC0D08"))
> +               return false;

Is the device ID never to be used outside of the broken configurations?

Even if that's the plan, how are you going to guarantee that anyway?

> +
>         INIT_LIST_HEAD(&resource_list);
>         acpi_dev_get_resources(device, &resource_list,
>                                acpi_check_serial_bus_slave,
> --
