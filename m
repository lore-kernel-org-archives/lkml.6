Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeBSMfm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:35:42 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43416 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeBSMfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:35:41 -0500
X-Google-Smtp-Source: AH8x224IWncv38/5+R7avNP5UA/kGnC+cwYsjTxkBlJo8qpq742iRysFxnqwdeJYf6bBZUQq2bFK4e1fGOpozOQBfsg=
MIME-Version: 1.0
In-Reply-To: <bf7fad44-b652-586d-bd20-8afdf6edcdf0@lechnology.com>
References: <20180213183946.1662-1-brgl@bgdev.pl> <bf7fad44-b652-586d-bd20-8afdf6edcdf0@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2018 13:35:40 +0100
Message-ID: <CAMRc=MczTtPeWaUN3M5d45ueUeFoZ4BcsvSuJ6FPTnPi_YjqFw@mail.gmail.com>
Subject: Re: [PATCH v2] reset: add support for non-DT systems
To: David Lechner <david@lechnology.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-17 3:01 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/13/2018 12:39 PM, Bartosz Golaszewski wrote:
>>
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
>> entry contains the device name and an additional, optional identifier
>> string.
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
>>         [FOO_RESET] = { .dev = "foo", .id = "foo_id" },
>>         [BAR_RESET] = { .dev = "bar", .id = NULL },
>>         { }
>> };
>>
>> where FOO_RESET and BAR_RESET will correspond with the id parameters
>> of reset callbacks.
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: David Lechner <david@lechnology.com>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>> v1 -> v2:
>> - renamed the new function to __reset_control_get_from_lookup()
>> - added a missing break; when a matching entry is found
>> - rearranged the code in __reset_control_get() - we can no longer get to
>> the
>>    return at the bottom, so remove it and return from
>>    __reset_control_get_from_lookup() if __of_reset_control_get() fails
>> - return -ENOENT from reset_contol_get() if we can't find a matching
>> entry,
>>    prevously returned -EINVAL referred to the fact that we passed a device
>>    without the of_node which is no longer an error condition
>> - add a comment about needing a sentinel in the lookup table
>>
>>   drivers/reset/core.c             | 40
>> +++++++++++++++++++++++++++++++++++++++-
>>   include/linux/reset-controller.h | 14 ++++++++++++++
>>   2 files changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> index da4292e9de97..b104a0c5c511 100644
>> --- a/drivers/reset/core.c
>> +++ b/drivers/reset/core.c
>> @@ -493,6 +493,44 @@ struct reset_control *__of_reset_control_get(struct
>> device_node *node,
>>   }
>>   EXPORT_SYMBOL_GPL(__of_reset_control_get);
>>   +static struct reset_control *
>> +__reset_control_get_from_lookup(struct device *dev, const char *id,
>> +                               bool shared, bool optional)
>> +{
>> +       struct reset_controller_dev *rcdev;
>> +       const char *dev_id = dev_name(dev);
>> +       struct reset_control *rstc = NULL;
>> +       const struct reset_lookup *lookup;
>> +       int index;
>> +
>> +       mutex_lock(&reset_list_mutex);
>> +
>> +       list_for_each_entry(rcdev, &reset_controller_list, list) {
>> +               if (!rcdev->lookup)
>> +                       continue;
>> +
>> +               lookup = rcdev->lookup;
>> +               for (index = 0; lookup->dev; index++, lookup++) {> +
>> if (strcmp(dev_id, lookup->dev))
>> +                               continue;
>> +
>> +                       if ((!id && !lookup->id) ||
>> +                           (id && lookup->id && !strcmp(id, lookup->id)))
>> {
>> +                               rstc = __reset_control_get_internal(rcdev,
>> +                                                               index,
>> shared);
>> +                               break;
>> +                       }
>> +               }
>> +       }
>
>
>
> This method of determining the index is not very useful. In the case of the
> DSP
> reset on OMAP-L138, the index *must* be the LPSC module domain number, which
> is
> 15. This would require us to create 15 dummy entries in the rcdev->lookup
> array
> so that we get the correct index in order to get the correct reset control.
>
> I think it would be better to just store the index in struct reset_lookup.
>
> Another option would be to require the length of lookup to be
> rcdev->nr_resets
> instead of using a sentinel.

Indeed. Please take a look at v3.

Thanks,
Bartosz
