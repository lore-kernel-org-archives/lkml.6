Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeBSNNa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:13:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53445 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeBSNN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:13:29 -0500
Message-ID: <1519046007.3408.9.camel@pengutronix.de>
Subject: Re: [PATCH v3] reset: add support for non-DT systems
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Date: Mon, 19 Feb 2018 14:13:27 +0100
In-Reply-To: <20180219123435.12007-1-brgl@bgdev.pl>
References: <20180219123435.12007-1-brgl@bgdev.pl>
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

Hi Bartosz,

On Mon, 2018-02-19 at 13:34 +0100, Bartosz Golaszewski wrote:
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
> This changeset extends the core reset code with a new field in the
> reset controller struct which contains an array of lookup entries. Each
> entry contains the device name, an additional, optional identifier
> string and the reset id number.
> 
> Drivers can register a set of reset lines using this lookup table and
> concerned devices can access them using the regular reset_control API.
>
> This new function is only called as a fallback in case the of_node
> field is NULL and doesn't change anything for current users.
> 
> Tested with a dummy reset driver with several lookup entries.
> 
> An example lookup table can look like this:
> 
> static const struct reset_lookup foobar_reset_lookup[] = {
> 	{ .dev = "foo",   .reset_id = "foo_id",    .id = 14 },
> 	{ .dev = "bar",   .id = NULL,              .id = 3  },
> 	{ }
> };

Thank you for the patch. This is a useful addition, but the lookups
should be added in platform code, not by the reset controller driver.

I would prefer reset_lookups to follow the patterns set by the other
subsystem's lookup implementations:
clk, gpiod, phy, and pwm have lookups that can be created from platform
code, independently from the drivers (via clkdev_add_table,
gpiod_add_lookup_table, phy_create_lookup, and pwm_add_table).

Following this pattern would allow to support reset controllers that are
implemented as proper device drivers, and reset controllers that are
reused on multiple platforms.

regards
Philipp
