Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031035AbeBNPAw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:00:52 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:63078 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030382AbeBNPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:00:50 -0500
Subject: Re: [PATCH v2] reset: add support for non-DT systems
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
References: <20180213183946.1662-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <65b864b2-e8dc-cf69-5c8e-f94b7f4fd640@ti.com>
Date: Wed, 14 Feb 2018 20:29:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213183946.1662-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 February 2018 12:09 AM, Bartosz Golaszewski wrote:
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
> entry contains the device name and an additional, optional identifier
> string.
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
> 	[FOO_RESET] = { .dev = "foo", .id = "foo_id" },
> 	[BAR_RESET] = { .dev = "bar", .id = NULL },
> 	{ }
> };
> 
> where FOO_RESET and BAR_RESET will correspond with the id parameters
> of reset callbacks.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This should really help get rid of the private
davinci_clk_reset_assert() API. Thanks for getting this done.

I noticed that the array based API still remains DT only. Its not a
concern for DaVinci so it can probably be supported when its really needed.

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
