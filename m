Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeCUIAE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:00:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37258 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeCUIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:00:00 -0400
X-Google-Smtp-Source: AG47ELvIqkF+4MRu/I7fIJKrYsRmJ7ohsWIzHFXveRg4ngef+2PX8YE26kDOqIwo57XmGtUxJ0Zrn6ORcf22EBTDQeg=
MIME-Version: 1.0
In-Reply-To: <20180318224736.GK5626@tuxbook-pro>
References: <1515590259-24304-1-git-send-email-anup@brainfault.org> <20180318224736.GK5626@tuxbook-pro>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 21 Mar 2018 13:29:58 +0530
Message-ID: <CAAhSdy31EEJYHn2qoWiCeRJfhLqPmyxVKU83RSrzozgWig86tw@mail.gmail.com>
Subject: Re: [PATCH RESEND] rpmsg: Add driver_override device attribute for rpmsg_device
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 4:17 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 10 Jan 05:17 PST 2018, Anup Patel wrote:
>
>> This patch adds "driver_override" device attribute for rpmsg_device which
>> will allow users to explicitly specify the rpmsg_driver to be used via
>> sysfs entry.
>>
>> The "driver_override" device attribute implemented here is very similar
>> to "driver_override" implemented for platform, pci, and amba bus types.
>>
>> One important use-case of "driver_override" device attribute is to force
>> use of rpmsg_chrdev driver for certain rpmsg_device instances.
>>
>
> I assume you mean specifically for the case where you want to prevent
> some kernel driver to probe for some given channel?

Yes, there are few use-cases where we want to prevent kernel
driver and rather access rpmsg device from user-space using
rpmsg_chrdev driver.

>
> The intention with rpmsg_char is that you through the rpmsg_ctrlX
> interface create and destroy endpoints dynamically, so you wouldn't need
> to use this mechanism to bind some specific channel to rpmsg_char.
>
>
> That said, this does make sense for completeness sake.
>
> [..]
>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>> index dffa3aa..9a25e42 100644
>> --- a/drivers/rpmsg/rpmsg_core.c
>> +++ b/drivers/rpmsg/rpmsg_core.c
>> @@ -321,11 +321,11 @@ struct device *rpmsg_find_device(struct device *parent,
>>  }
>>  EXPORT_SYMBOL(rpmsg_find_device);
>>
>> -/* sysfs show configuration fields */
>> +/* sysfs configuration fields */
>>  #define rpmsg_show_attr(field, path, format_string)                  \
>>  static ssize_t                                                               \
>>  field##_show(struct device *dev,                                     \
>> -                     struct device_attribute *attr, char *buf)       \
>> +          struct device_attribute *attr, char *buf)                  \
>
> Seems unnecessary.

OK, I will drop these changes.

>
>>  {                                                                    \
>>       struct rpmsg_device *rpdev = to_rpmsg_device(dev);              \
>>                                                                       \
>> @@ -333,11 +333,52 @@ field##_show(struct device *dev,                                        \
>>  }                                                                    \
>>  static DEVICE_ATTR_RO(field);
>>
>> +#define rpmsg_string_attr(field, path)                                       \
>
> "path" is an odd name for these, I think it's a "member".
>
>> +static ssize_t                                                               \
>> +field##_store(struct device *dev,                                    \
>> +           struct device_attribute *attr, const char *buf, size_t sz)\
>
> field##_store(struct device *dev, struct device_attribute *attr,        \
>               const char *buf, size_t sz)                               \
>
> Is prettier

OK, I will update this.

>
>> +{                                                                    \
>> +     struct rpmsg_device *rpdev = to_rpmsg_device(dev);              \
>> +     char *new, *old, *cp;                                           \
>> +                                                                     \
>> +     new = kstrndup(buf, sz, GFP_KERNEL);                            \
>> +     if (!new)                                                       \
>> +             return -ENOMEM;                                         \
>> +                                                                     \
>> +     cp = strchr(new, '\n');                                         \
>> +     if (cp)                                                         \
>> +             *cp = '\0';                                             \
>
> I prefer
>
>         new[strcspn(new, "\n")] = '\0';

Sure, I will update this.

Thanks,
Anup
