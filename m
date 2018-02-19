Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbeBSQlj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:41:39 -0500
Received: from vern.gendns.com ([206.190.152.46]:49018 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753152AbeBSQlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:41:37 -0500
Subject: Re: [PATCH v3] reset: add support for non-DT systems
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
References: <20180219123435.12007-1-brgl@bgdev.pl>
 <1519046007.3408.9.camel@pengutronix.de>
From: David Lechner <david@lechnology.com>
Message-ID: <078f13eb-22ec-e042-827b-f543c9765e9c@lechnology.com>
Date: Mon, 19 Feb 2018 10:41:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519046007.3408.9.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2018 07:13 AM, Philipp Zabel wrote:
> Hi Bartosz,
> 
> On Mon, 2018-02-19 at 13:34 +0100, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> The reset framework only supports device-tree. There are some platforms
>> however, which need to use it even in legacy, board-file based mode.
>>
>> An example of such architecture is the DaVinci family of SoCs which
>> supports both device tree and legacy boot modes and we don't want to
>> introduce any regressions.
>>
>> We're currently working on converting the platform from its hand-crafted
>> clock API to using the common clock framework. Part of the overhaul will
>> be representing the chip's power sleep controller's reset lines using
>> the reset framework.
>>
>> This changeset extends the core reset code with a new field in the
>> reset controller struct which contains an array of lookup entries. Each
>> entry contains the device name, an additional, optional identifier
>> string and the reset id number.
>>
>> Drivers can register a set of reset lines using this lookup table and
>> concerned devices can access them using the regular reset_control API.
>>
>> This new function is only called as a fallback in case the of_node
>> field is NULL and doesn't change anything for current users.
>>
>> Tested with a dummy reset driver with several lookup entries.
>>
>> An example lookup table can look like this:
>>
>> static const struct reset_lookup foobar_reset_lookup[] = {
>> 	{ .dev = "foo",   .reset_id = "foo_id",    .id = 14 },
>> 	{ .dev = "bar",   .id = NULL,              .id = 3  },
>> 	{ }
>> };
> 
> Thank you for the patch. This is a useful addition, but the lookups
> should be added in platform code, not by the reset controller driver.
> 
> I would prefer reset_lookups to follow the patterns set by the other
> subsystem's lookup implementations:
> clk, gpiod, phy, and pwm have lookups that can be created from platform
> code, independently from the drivers (via clkdev_add_table,
> gpiod_add_lookup_table, phy_create_lookup, and pwm_add_table).
> 
> Following this pattern would allow to support reset controllers that are
> implemented as proper device drivers, and reset controllers that are
> reused on multiple platforms.
> 

When testing v2 of this series, I was thinking that having this sort
of separation would be better as well.
