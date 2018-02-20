Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeBTKjt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:39:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35365 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeBTKjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:39:48 -0500
Message-ID: <1519123185.3470.5.camel@pengutronix.de>
Subject: Re: [PATCH v4] reset: add support for non-DT systems
From: Philipp Zabel <p.zabel@pengutronix.de>
To: David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
Date: Tue, 20 Feb 2018 11:39:45 +0100
In-Reply-To: <72cd2af4-ed6b-8c1b-2488-b999976b894a@lechnology.com>
References: <20180219165837.28913-1-brgl@bgdev.pl>
         <72cd2af4-ed6b-8c1b-2488-b999976b894a@lechnology.com>
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

Hi Bartosz, David,

On Mon, 2018-02-19 at 18:21 -0600, David Lechner wrote:
> On 02/19/2018 10:58 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > The reset framework only supports device-tree. There are some platforms
> > however, which need to use it even in legacy, board-file based mode.
> > 
> > An example of such architecture is the DaVinci family of SoCs which
> > supports both device tree and legacy boot modes and we don't want to
> > introduce any regressions.
> > 
> > We're currently working on converting the platform from its hand-crafted
> > clock API to using the common clock framework. Part of the overhaul will
> > be representing the chip's power sleep controller's reset lines using
> > the reset framework.
> > 
> > This changeset extends the core reset code with new reset lookup
> > structures. Each lookup table contains a set of lookup entries which
> > allow the reset core to associate reset lines with devices (by
> > comparing the dev_id and con_id strings).
> > 
> > Machine code can register a set of reset lines using this lookup table
> > and concerned devices can access them using the regular reset_control
> > API.
> > 
> > The new lookup function is only called as a fallback in case the
> > of_node field is NULL and doesn't change anything for current users.
> > 
> > Tested with a dummy reset driver with several lookup entries.
> > 
> > An example lookup table can be found below:
> > 
> > static struct platform_device foobar_reset_dev = {
> >          .name = "foobar-reset",
> > };
> > 
> > static struct reset_lookup_entry foobar_reset_lookup_entries[] = {
> >          { .con_id = "foo",    id = 15 },
> >          { .con_id = "bar",    id = 5  },
> > };
> > 
> > static struct reset_lookup_table foobar_reset_lookup_table = {
> >          .dev_id = "foobar-device",
> >          .entries = foobar_reset_lookup_entries,
> >          .num_entries = ARRAY_SIZE(foobar_reset_lookup_entries),
> >          .dev = &foobar_reset_dev.dev,
> > };
> > 
> 
> This seems like a lot of boilerplate to register a lookup.

This could be shortened a bit by following the gpiod lookup model,
adding a RESET_LOOKUP macro and making the array NULL terminated:

#define RESET_LOOKUP(reset_dev_id, idx, con_id) /*...*/

static struct reset_lookup_table foobar_reset_lookup_table = {
	.dev_id = "foobar-device",
	.entries = {
		RESET_LOOKUP("foobar-reset.0", 15, "foo"),
		RESET_LOOKUP("foobar-reset.0", 5, "bar"),
		{ },
	},
};

	/*...*/
	reset_add_lookup_table(&foobar_reset_lookup_table);

>  Can we have
> something like phy_create_lookup() instead where there is just a single
> function call to register a single lookup? This will be much easier to
> use in the davinci PSC driver.
> 
> void reset_add_lookup(struct reset_controller_dev *rdev, int index,
> 		      const char *dev_id, const char *con_id);

In your case the platform code that adds the lookup may be identical to
the code that registers the struct reset_controller_dev, but that
doesn't have to be the case. I'm not sure how that is supposed to work
for the phy framework (I see no platform code adding phy lookups, only
drivers).

My point was that if the reset controller is registered by a separate
driver, the platform code may not have access to the struct
reset_controller_dev, or even the struct platform_device. I like that
the gpiod lookups can match by dev_id of the gpio chip.

regards
Philipp
