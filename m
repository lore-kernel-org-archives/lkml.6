Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeBQCBD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 21:01:03 -0500
Received: from vern.gendns.com ([206.190.152.46]:53105 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeBQCBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 21:01:02 -0500
Subject: Re: [PATCH v2] reset: add support for non-DT systems
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
References: <20180213183946.1662-1-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <bf7fad44-b652-586d-bd20-8afdf6edcdf0@lechnology.com>
Date: Fri, 16 Feb 2018 20:01:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180213183946.1662-1-brgl@bgdev.pl>
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

On 02/13/2018 12:39 PM, Bartosz Golaszewski wrote:
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
> ---
> v1 -> v2:
> - renamed the new function to __reset_control_get_from_lookup()
> - added a missing break; when a matching entry is found
> - rearranged the code in __reset_control_get() - we can no longer get to the
>    return at the bottom, so remove it and return from
>    __reset_control_get_from_lookup() if __of_reset_control_get() fails
> - return -ENOENT from reset_contol_get() if we can't find a matching entry,
>    prevously returned -EINVAL referred to the fact that we passed a device
>    without the of_node which is no longer an error condition
> - add a comment about needing a sentinel in the lookup table
> 
>   drivers/reset/core.c             | 40 +++++++++++++++++++++++++++++++++++++++-
>   include/linux/reset-controller.h | 14 ++++++++++++++
>   2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index da4292e9de97..b104a0c5c511 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -493,6 +493,44 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
>   }
>   EXPORT_SYMBOL_GPL(__of_reset_control_get);
>   
> +static struct reset_control *
> +__reset_control_get_from_lookup(struct device *dev, const char *id,
> +				bool shared, bool optional)
> +{
> +	struct reset_controller_dev *rcdev;
> +	const char *dev_id = dev_name(dev);
> +	struct reset_control *rstc = NULL;
> +	const struct reset_lookup *lookup;
> +	int index;
> +
> +	mutex_lock(&reset_list_mutex);
> +
> +	list_for_each_entry(rcdev, &reset_controller_list, list) {
> +		if (!rcdev->lookup)
> +			continue;
> +
> +		lookup = rcdev->lookup;
> +		for (index = 0; lookup->dev; index++, lookup++) {> +			if (strcmp(dev_id, lookup->dev))
> +				continue;
> +
> +			if ((!id && !lookup->id) ||
> +			    (id && lookup->id && !strcmp(id, lookup->id))) {
> +				rstc = __reset_control_get_internal(rcdev,
> +								index, shared);
> +				break;
> +			}
> +		}
> +	}


This method of determining the index is not very useful. In the case of the DSP
reset on OMAP-L138, the index *must* be the LPSC module domain number, which is
15. This would require us to create 15 dummy entries in the rcdev->lookup array
so that we get the correct index in order to get the correct reset control.

I think it would be better to just store the index in struct reset_lookup.

Another option would be to require the length of lookup to be rcdev->nr_resets
instead of using a sentinel.
