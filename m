Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeB0SHh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:07:37 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44592 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeB0SHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:07:36 -0500
X-Google-Smtp-Source: AG47ELt8li7lFmqxkYqZVN5vWgxfUOOOlAgF9VTWlTbKl2BhkC5eec/IOgHqI7I3aadd4CYyLMkIb8qgAOsklQg6BCU=
MIME-Version: 1.0
In-Reply-To: <1519747811.3402.17.camel@pengutronix.de>
References: <20180223113924.28957-1-brgl@bgdev.pl> <1519747811.3402.17.camel@pengutronix.de>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 27 Feb 2018 19:07:34 +0100
Message-ID: <CAMpxmJUVNzv9iQ2VUzOdkvFoknfZWSdkgDViSuDq7Du6AG-igg@mail.gmail.com>
Subject: Re: [PATCH v5] reset: add support for non-DT systems
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
        LKML <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-27 17:10 GMT+01:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Hi Bartosz,
>
> thank you for the update.
>
> On Fri, 2018-02-23 at 12:39 +0100, Bartosz Golaszewski wrote:
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
>> This changeset extends the core reset code with a new reset lookup
>> entry structure. It contains data allowing the reset core to associate
>> reset lines with devices by comparing the dev_id and con_id strings.
>>
>> It also provides a function allowing drivers to register lookup entries
>> with the framework.
>>
>> The new lookup function is only called as a fallback in case the
>> of_node field is NULL and doesn't change anything for current users.
>>
>> Tested with a dummy reset driver with several lookup entries.
>>
>> An example lookup table registration from a driver can be found below:
>>
>> static struct reset_control_lookup foobar_reset_lookup[] = {
>>       RESET_LOOKUP("foo.0", "foo", 15),
>>       RESET_LOOKUP("bar.0", NULL,   5),
>> };
>>
>> foobar_probe()
>> {
>> ...
>>
>>         reset_controller_add_lookup(&rcdev, foobar_reset_lookup,
>>                                     ARRAY_SIZE(foobar_reset_lookup));
>>
>> ...
>> }
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: David Lechner <david@lechnology.com>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>> v1 -> v2:
>> - renamed the new function to __reset_control_get_from_lookup()
>> - added a missing break; when a matching entry is found
>> - rearranged the code in __reset_control_get() - we can no longer get to the
>>   return at the bottom, so remove it and return from
>>   __reset_control_get_from_lookup() if __of_reset_control_get() fails
>> - return -ENOENT from reset_contol_get() if we can't find a matching entry,
>>   prevously returned -EINVAL referred to the fact that we passed a device
>>   without the of_node which is no longer an error condition
>> - add a comment about needing a sentinel in the lookup table
>>
>> v2 -> v3:
>> - added the reset id number field to the lookup struct so that we don't need
>>   to rely on the array index
>>
>> v3 -> v4:
>> - separated the driver and lookup table registration logic by adding a
>>   function meant to be called by machine-specific code that adds a lookup
>>   table to the internal list
>> - the correct reset controller is now found by first finding the lookup
>>   table associated with it, then finding the actual reset controller by
>>   the associated device
>>
>> v4 -> v5:
>> - since the first user of this will be the davinci clk driver and it
>>   already registers clock lookup from within the driver code - allow
>>   drivers to register lookups with the assumption that the code can be
>>   extended to make it possible to register entries from machine code as
>>   well
>
> How do you imagine this may be extended? By adding an rddev_devid field
> to the lookup, similarly to the pwm_lookup?
> I suppose reset_controller_add_lookup could then be called with a NULL
> rcdev to register lookups by id.
>

Yes, this is what I was thinking about more or less.

>> - simplify the code - only expose a single lookup structure and a simply
>>   registration function
>> - add the RESET_LOOKUP macro for brevity
>>
>>  drivers/reset/core.c             | 65 +++++++++++++++++++++++++++++++++++++++-
>>  include/linux/reset-controller.h | 28 +++++++++++++++++
>>  2 files changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> index da4292e9de97..75e54a05147a 100644
>> --- a/drivers/reset/core.c
>> +++ b/drivers/reset/core.c
>> @@ -23,6 +23,9 @@
>>  static DEFINE_MUTEX(reset_list_mutex);
>>  static LIST_HEAD(reset_controller_list);
>>
>> +static DEFINE_MUTEX(reset_lookup_mutex);
>> +static LIST_HEAD(reset_lookup_list);
>> +
>>  /**
>>   * struct reset_control - a reset control
>>   * @rcdev: a pointer to the reset controller device
>> @@ -148,6 +151,30 @@ int devm_reset_controller_register(struct device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(devm_reset_controller_register);
>>
>> +/**
>> + * reset_controller_add_lookup - register a set of lookup entries
>> + * @rcdev: initialized reset controller device owning the reset line
>> + * @lookup: array of reset lookup entries
>> + * @num_entries: number of entries in the lookup array
>> + */
>> +void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
>> +                              struct reset_control_lookup *lookup,
>> +                              unsigned int num_entries)
>> +{
>> +     struct reset_control_lookup *entry;
>> +     unsigned int i;
>> +
>> +     mutex_lock(&reset_lookup_mutex);
>> +     for (i = 0; i < num_entries; i++) {
>> +             entry = &lookup[i];
>> +
>> +             entry->rcdev = rcdev;
>> +             list_add_tail(&entry->list, &reset_lookup_list);
>> +     }
>> +     mutex_unlock(&reset_lookup_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(reset_controller_add_lookup);
>> +
>
> What about reset_controller_remove_lookup?

While I understand that we have those for phy or gpio, I don't really
think they're that useful. Not many users do it anyway. Can we add it
once it's actually needed?

>
>>  static inline struct reset_control_array *
>>  rstc_to_array(struct reset_control *rstc) {
>>       return container_of(rstc, struct reset_control_array, base);
>> @@ -493,6 +520,42 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
>>  }
>>  EXPORT_SYMBOL_GPL(__of_reset_control_get);
>>
>> +static struct reset_control *
>> +__reset_control_get_from_lookup(struct device *dev, const char *con_id,
>> +                             bool shared, bool optional)
>> +{
>> +     const struct reset_control_lookup *lookup;
>> +     const char *dev_id = dev_name(dev);
>> +     struct reset_control *rstc = NULL;
>> +
>> +     if (!dev)
>> +             return ERR_PTR(-EINVAL);
>> +
>> +     mutex_lock(&reset_lookup_mutex);
>> +
>> +     list_for_each_entry(lookup, &reset_lookup_list, list) {
>> +             if (strcmp(lookup->dev_id, dev_id))
>
> This will crash if (lookup->dev_id == NULL).
>

We're stating explicitly that dev_id is required in the kernel doc but
if you insist, I can add a check for that.

>> +                     continue;
>> +
>> +             if ((!con_id && !lookup->con_id) ||
>> +                 !strcmp(con_id, lookup->con_id)) {
>
> This will crash if only one of con_id or lookup->con_id is NULL.
>
> Call strcmp only if both strings are valid.
>

Indeed, will fix it.

>> +                     mutex_lock(&reset_list_mutex);
>> +                     rstc = __reset_control_get_internal(lookup->rcdev,
>> +                                                         lookup->index,
>> +                                                         shared);
>> +                     mutex_unlock(&reset_list_mutex);
>> +                     break;
>> +             }
>> +     }
>> +
>> +     mutex_unlock(&reset_lookup_mutex);
>> +
>> +     if (!rstc)
>> +             return optional ? NULL : ERR_PTR(-ENOENT);
>> +
>> +     return rstc;
>> +}
>> +
>>  struct reset_control *__reset_control_get(struct device *dev, const char *id,
>>                                         int index, bool shared, bool optional)
>>  {
>> @@ -500,7 +563,7 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
>>               return __of_reset_control_get(dev->of_node, id, index, shared,
>>                                             optional);
>>
>> -     return optional ? NULL : ERR_PTR(-EINVAL);
>> +     return __reset_control_get_from_lookup(dev, id, shared, optional);
>>  }
>>  EXPORT_SYMBOL_GPL(__reset_control_get);
>>
>> diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
>> index adb88f8cefbc..25698f6c1fae 100644
>> --- a/include/linux/reset-controller.h
>> +++ b/include/linux/reset-controller.h
>> @@ -26,6 +26,30 @@ struct module;
>>  struct device_node;
>>  struct of_phandle_args;
>>
>> +/**
>> + * struct reset_control_lookup - represents a single lookup entry
>> + *
>> + * @list: internal list of all reset lookup entries
>> + * @rcdev: reset controller device controlling this reset line
>> + * @index: ID of the reset controller in the reset controller device
>> + * @dev_id: name of the device associated with this reset line
>> + * @con_id name of the reset line (can be NULL)
>> + */
>> +struct reset_control_lookup {
>> +     struct list_head list;
>> +     struct reset_controller_dev *rcdev;
>> +     unsigned int index;
>> +     const char *dev_id;
>> +     const char *con_id;
>> +};
>> +
>> +#define RESET_LOOKUP(_dev_id, _con_id, _index)                               \
>> +     {                                                               \
>> +             .dev_id = _dev_id,                                      \
>> +             .con_id = _con_id,                                      \
>> +             .index = _index,                                        \
>> +     }
>> +
>>  /**
>>   * struct reset_controller_dev - reset controller entity that might
>>   *                               provide multiple reset controls
>> @@ -58,4 +82,8 @@ struct device;
>>  int devm_reset_controller_register(struct device *dev,
>>                                  struct reset_controller_dev *rcdev);
>>
>> +void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
>> +                              struct reset_control_lookup *lookup,
>> +                              unsigned int num_entries);
>> +
>>  #endif
>
> regards
> Philipp

Thanks,
Bart
