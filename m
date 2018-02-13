Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965349AbeBMRno (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:43:44 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34095 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934279AbeBMRnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:43:43 -0500
X-Google-Smtp-Source: AH8x226fRYSXXVhgIUCjUXGzV3gM557YsoWcRIWFiVIf5SwhgYpnHmezcLgXEzTR+9vy4L+ZSUzTWEZzmQ4YcBbThmw=
MIME-Version: 1.0
In-Reply-To: <be0e422c-465f-954e-254f-21a5b5766bed@lechnology.com>
References: <20180213152524.16620-1-brgl@bgdev.pl> <be0e422c-465f-954e-254f-21a5b5766bed@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 13 Feb 2018 18:43:41 +0100
Message-ID: <CAMRc=Mc_CuwV+N8Kn_qhF8a4ReLPW+AEvDGJe+RVTv_-CKHqzQ@mail.gmail.com>
Subject: Re: [PATCH] reset: add support for non-DT systems
To: David Lechner <david@lechnology.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-13 18:17 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/13/2018 09:25 AM, Bartosz Golaszewski wrote:
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
>
>
> Looks good to me. I just made a few very minor comments. I will
> try to use this in PSC driver later today.
>

Cool, if it works for you - feel free to include it in your series.

>
>>   drivers/reset/core.c             | 43
>> ++++++++++++++++++++++++++++++++++++++--
>>   include/linux/reset-controller.h | 13 ++++++++++++
>>   2 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> index da4292e9de97..ba7011c6e06f 100644
>> --- a/drivers/reset/core.c
>> +++ b/drivers/reset/core.c
>> @@ -493,12 +493,51 @@ struct reset_control *__of_reset_control_get(struct
>> device_node *node,
>>   }
>>   EXPORT_SYMBOL_GPL(__of_reset_control_get);
>>   +static struct reset_control *
>> +__reset_control_get_lookup(struct device *dev, const char *id,
>
>
> Based on the name of the function, I expected this to return
> struct reset_lookup. Perhaps __reset_control_lookup() or
> __reset_control_match_lookup() would be a slightly better name?
>
>
>> +                          bool shared, bool optional)
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
>> +               for (index = 0; lookup->dev; index++, lookup++) {
>> +                       if (strcmp(dev_id, lookup->dev))
>> +                               continue;
>> +
>> +                       if ((!id && !lookup->id) ||
>> +                           (id && lookup->id && !strcmp(id, lookup->id)))
>> {
>> +                               rstc = __reset_control_get_internal(rcdev,
>> +                                                               index,
>> shared);

Ugh, I noticed that this needs a break here, otherwise we'll always
iterate over all the entries.

>> +                       }
>> +               }
>> +       }
>> +
>> +       mutex_unlock(&reset_list_mutex);
>> +
>> +       if (!rstc)
>> +               return optional ? NULL : ERR_PTR(-ENOENT);
>> +
>> +       return rstc;
>> +}
>> +
>>   struct reset_control *__reset_control_get(struct device *dev, const char
>> *id,
>>                                           int index, bool shared, bool
>> optional)
>>   {
>>         if (dev->of_node)
>> -               return __of_reset_control_get(dev->of_node, id, index,
>> shared,
>> -                                             optional);
>> +               return __of_reset_control_get(dev->of_node, id,
>> +                                             index, shared, optional);
>
>
> I don't understand why this line is changed. It is just being rearranged?
>

Yes, but I can leave it out of this patch.

>
>> +       else
>> +               return __reset_control_get_lookup(dev, id, shared,
>> optional);
>>         return optional ? NULL : ERR_PTR(-EINVAL);
>>   }
>> diff --git a/include/linux/reset-controller.h
>> b/include/linux/reset-controller.h
>> index adb88f8cefbc..0c081336e08b 100644
>> --- a/include/linux/reset-controller.h
>> +++ b/include/linux/reset-controller.h
>> @@ -22,6 +22,17 @@ struct reset_control_ops {
>>         int (*status)(struct reset_controller_dev *rcdev, unsigned long
>> id);
>>   };
>>   +/**
>> + * struct reset_lookup - a single entry in a reset lookup table
>> + *
>> + * @dev: name of the device associated with this reset
>> + * @id: additional reset identifier (if the device uses multiple reset
>> lines)
>> + */
>> +struct reset_lookup {
>> +       const char *dev;
>> +       const char *id;
>> +};
>> +
>>   struct module;
>>   struct device_node;
>>   struct of_phandle_args;
>> @@ -34,6 +45,7 @@ struct of_phandle_args;
>>    * @list: internal list of reset controller devices
>>    * @reset_control_head: head of internal list of requested reset
>> controls
>>    * @of_node: corresponding device tree node as phandle target
>> + * @lookup: array of lookup entries associated with this request
>> controller
>
>
> Might be nice to mention that this array must end with an empty struct (i.e.
> lookup->dev == NULL)
>
>
>>    * @of_reset_n_cells: number of cells in reset line specifiers
>>    * @of_xlate: translation function to translate from specifier as found
>> in the
>>    *            device tree to id as given to the reset control ops
>> @@ -45,6 +57,7 @@ struct reset_controller_dev {
>>         struct list_head list;
>>         struct list_head reset_control_head;
>>         struct device_node *of_node;
>> +       const struct reset_lookup *lookup;
>>         int of_reset_n_cells;
>>         int (*of_xlate)(struct reset_controller_dev *rcdev,
>>                         const struct of_phandle_args *reset_spec);
>>
>

Bartosz
