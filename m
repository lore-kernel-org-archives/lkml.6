Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeBWNNn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:13:43 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38132 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBWNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:13:42 -0500
X-Google-Smtp-Source: AG47ELuzcfrC5QQcDvfY2cr/sZeQUddfWt6AOSYP7G8/w30gsNPHds83WF1lDuAnL4Sf5q+H5nMWBtv+pfqlSZ6L5ko=
MIME-Version: 1.0
In-Reply-To: <20180223113924.28957-1-brgl@bgdev.pl>
References: <20180223113924.28957-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Feb 2018 14:13:41 +0100
Message-ID: <CAMRc=MdVAkgpdUJKedLq24tbN-GbUgJEz9E7f0fyj=tW3TtBRg@mail.gmail.com>
Subject: Re: [PATCH v5] reset: add support for non-DT systems
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-23 12:39 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The reset framework only supports device-tree. There are some platforms
> however, which need to use it even in legacy, board-file based mode.
>
> An example of such architecture is the DaVinci family of SoCs which
> supports both device tree and legacy boot modes and we don't want to
> introduce any regressions.
>
> We're currently working on converting the platform from its hand-crafted
> clock API to using the common clock framework. Part of the overhaul will
> be representing the chip's power sleep controller's reset lines using
> the reset framework.
>
> This changeset extends the core reset code with a new reset lookup
> entry structure. It contains data allowing the reset core to associate
> reset lines with devices by comparing the dev_id and con_id strings.
>
> It also provides a function allowing drivers to register lookup entries
> with the framework.
>
> The new lookup function is only called as a fallback in case the
> of_node field is NULL and doesn't change anything for current users.
>
> Tested with a dummy reset driver with several lookup entries.
>
> An example lookup table registration from a driver can be found below:
>
> static struct reset_control_lookup foobar_reset_lookup[] = {
>         RESET_LOOKUP("foo.0", "foo", 15),
>         RESET_LOOKUP("bar.0", NULL,   5),
> };
>
> foobar_probe()
> {
> ...
>
>         reset_controller_add_lookup(&rcdev, foobar_reset_lookup,
>                                     ARRAY_SIZE(foobar_reset_lookup));
>
> ...
> }
>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> v1 -> v2:
> - renamed the new function to __reset_control_get_from_lookup()
> - added a missing break; when a matching entry is found
> - rearranged the code in __reset_control_get() - we can no longer get to the
>   return at the bottom, so remove it and return from
>   __reset_control_get_from_lookup() if __of_reset_control_get() fails
> - return -ENOENT from reset_contol_get() if we can't find a matching entry,
>   prevously returned -EINVAL referred to the fact that we passed a device
>   without the of_node which is no longer an error condition
> - add a comment about needing a sentinel in the lookup table
>
> v2 -> v3:
> - added the reset id number field to the lookup struct so that we don't need
>   to rely on the array index
>
> v3 -> v4:
> - separated the driver and lookup table registration logic by adding a
>   function meant to be called by machine-specific code that adds a lookup
>   table to the internal list
> - the correct reset controller is now found by first finding the lookup
>   table associated with it, then finding the actual reset controller by
>   the associated device
>
> v4 -> v5:
> - since the first user of this will be the davinci clk driver and it
>   already registers clock lookup from within the driver code - allow
>   drivers to register lookups with the assumption that the code can be
>   extended to make it possible to register entries from machine code as
>   well
> - simplify the code - only expose a single lookup structure and a simply
>   registration function
> - add the RESET_LOOKUP macro for brevity
>
>  drivers/reset/core.c             | 65 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/reset-controller.h | 28 +++++++++++++++++
>  2 files changed, 92 insertions(+), 1 deletion(-)

Also: I decided not to go the phy way of allocating memory dynamically
for lookup entries - I believe this is overkill and makes the code
more complicated with all the error checking required.

Instead, the lookup entries structs should be provided by the caller.

Bart
