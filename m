Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965414AbeBMSTt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:19:49 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43686 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965217AbeBMSTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:19:47 -0500
X-Google-Smtp-Source: AH8x226LEWyTjRGZhZn6+sVzMrHkVvDMTfbafp6CI6BP6NpVB+cBOPAXzXGz1QUx8ptn120sgmGjhG8YhYWDoEv2ruQ=
MIME-Version: 1.0
In-Reply-To: <20180213170018.9780-17-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com> <20180213170018.9780-17-mika.westerberg@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 20:19:45 +0200
Message-ID: <CAHp75VePM_zL-zyZSO+3BN1O3KhWpeKKsKg_V2XKFD4+yfpVrA@mail.gmail.com>
Subject: Re: [PATCH 16/18] thunderbolt: Add support for preboot ACL
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Preboot ACL is a mechanism that allows connecting Thunderbolt devices
> boot time in more secure way than the legacy Thunderbolt boot support.
> As with the legacy boot option, this also needs to be enabled from the
> BIOS before booting is allowed. Difference to the legacy mode is that
> the userspace software explicitly adds device UUIDs by sending a special
> message to the ICM firmware. Only the devices listed in the boot ACL are
> connected automatically during the boot. This works in both "user" and
> "secure" security levels.
>
> We implement this in Linux by exposing a new sysfs attribute (boot_acl)
> below each Thunderbolt domain. The userspace software can then update
> the full list as needed.

> +       if (mutex_lock_interruptible(&tb->lock)) {
> +               ret = -ERESTARTSYS;
> +               goto out;
> +       }

> +       ret = tb->cm_ops->get_boot_acl(tb, uuids, tb->nboot_acl);
> +       mutex_unlock(&tb->lock);
> +
> +       if (ret)
> +               goto out;

Can we use more traditional pattern, i.e.
mutex_lock();
ret = ...;
if (ret) {
 ...
 mutex_unlock();
 goto ...;
}
mutex_unlock();

?

> +       for (ret = 0, i = 0; i < tb->nboot_acl; i++) {

Wouldn't be slightly better to check for overflow beforehand

i < min(PAGE_SIZE / (UUID_STRING_LEN + 1), tb->nboot_acl)

and then simple

ret = sprintf(buf + ret, "%pUb", &uuids[i]);

?

> +               if (!uuid_is_null(&uuids[i]))
> +                       ret += snprintf(buf + ret, PAGE_SIZE - ret, "%pUb",
> +                                       &uuids[i]);
> +
> +               ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s",
> +                              i < tb->nboot_acl - 1 ? "," : "\n");
> +       }


> +static ssize_t boot_acl_store(struct device *dev, struct device_attribute *attr,
> +                             const char *buf, size_t count)
> +{

> +       int i = 0;

> +       uuid_str = strim(str);

> +       while ((s = strsep(&uuid_str, ",")) != NULL && i < tb->nboot_acl) {

for (i = 0; (s = strsep(&uuid_str, ",")) != NULL && i < tb->nboot_acl; i++) {
  size_t len = strlen(s);

  if (!len)
    continue;
...
}

?

Btw, nboot_acl can be 0, right? Perhaps check it first? (Or in other
words: which one is anticipated to be more frequent: nboot_acl = 0, or
string w/o any ',' in it?)

> +               size_t len = strlen(s);
> +
> +               if (len) {


> +                       if (len != UUID_STRING_LEN) {
> +                               ret = -EINVAL;
> +                               goto err_free_acl;
> +                       }

uuid_parse() does this check. No need to duplicate.

> +                       ret = uuid_parse(s, &acl[i]);
> +                       if (ret)
> +                               goto err_free_acl;
> +               }
> +
> +               i++;
> +       }

-- 
With Best Regards,
Andy Shevchenko
