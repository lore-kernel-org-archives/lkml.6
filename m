Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeB1Obg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:31:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35411 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeB1Obe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:31:34 -0500
Message-ID: <1519828292.3975.3.camel@pengutronix.de>
Subject: Re: [PATCH v6] reset: add support for non-DT systems
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Date: Wed, 28 Feb 2018 15:31:32 +0100
In-Reply-To: <20180228130857.5342-1-brgl@bgdev.pl>
References: <20180228130857.5342-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-28 at 14:08 +0100, Bartosz Golaszewski wrote:
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
> 	RESET_LOOKUP("foo.0", "foo", 15),
> 	RESET_LOOKUP("bar.0", NULL,   5),
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
> v5 -> v6:
> - fixed a potential crash if one of the strings passed to strcmp is NULL
> - added a check for NULL dev_id when adding the lookup entry

Thanks, applied to reset/next

regards
Philipp
