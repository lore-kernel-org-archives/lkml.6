Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeDVJ1O (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 05:27:14 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:35959 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbeDVJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 05:27:11 -0400
X-Google-Smtp-Source: AB8JxZqAlZqC8fhaD2BqIU9voxRn6yroKqUxFJc+rh0KmQjVTp3EQq068mIZrzFB+XuEgQmgNyb6qvPj/a202CkrS+s=
MIME-Version: 1.0
In-Reply-To: <20180419165825.13008-1-ard.biesheuvel@linaro.org>
References: <20180419165825.13008-1-ard.biesheuvel@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 22 Apr 2018 11:27:10 +0200
X-Google-Sender-Auth: TtTyHigl2aovAbglCE-G9XA8qxY
Message-ID: <CAJZ5v0jE4Ler2OWeKEWuHwEwM4RHYC5r8BwgcPrT6XBxFjnSNw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / bus: ignore rather than fail bus driver
 registrations on non-ACPI boot
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bill.fletcher@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 6:58 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> When building ACPI bus drivers such as button.ko into the core kernel,
> other drivers that depend on its symbols are loadable even when booting
> with ACPI disabled. For instance, nouveau.ko has a link time dependency
> on acpi_lid_open() on ACPI capable kernels, and calls it regardless of
> whether the system booted via ACPI.
>
> However, when building button.ko as a module, it will refuse to load if
> the system did not boot in ACPI mode, which subsequently prevents the
> nouveau driver from loading as well, resulting in broken graphics.
>
> Given that returning an error from an initcall() is ignored for drivers
> that are built into the kernel,

Which makes sense, because they are present in the kernel anyway.

> let's align the module case with this,
> and not return an error when registering an ACPI bus driver on a system
> that did not boot via ACPI.

But why is loading a module that's never going to be used actually OK?

Isn't this a problem with the assumptions made by the nouveau driver
that need not be met depending on what configuration the kernel is run
in?

Honestly, it doesn't appear quite right to try to change the rest of
the kernel to follow the nouveau's expectations.

Thanks,
Rafael
