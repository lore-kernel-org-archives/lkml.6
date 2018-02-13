Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbeBMTRg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:17:36 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:37102 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754221AbeBMTRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:17:34 -0500
X-Google-Smtp-Source: AH8x227p4jAQMbJFBQYLJ/dI2Fdgq1SxgRj2V8faK/sf1MmK8kDtvvwQUs3EX9/xTHQog0roxtx96XmpCeH0BihkbqQ=
MIME-Version: 1.0
In-Reply-To: <20180213183946.1662-1-brgl@bgdev.pl>
References: <20180213183946.1662-1-brgl@bgdev.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 21:17:33 +0200
Message-ID: <CAHp75VeqaOwaAriXw3Ppvi6dtcK+yyTJUUpmj6gaxY8PLtzwpA@mail.gmail.com>
Subject: Re: [PATCH v2] reset: add support for non-DT systems
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 8:39 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
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
>         [FOO_RESET] = { .dev = "foo", .id = "foo_id" },
>         [BAR_RESET] = { .dev = "bar", .id = NULL },
>         { }
> };
>
> where FOO_RESET and BAR_RESET will correspond with the id parameters
> of reset callbacks.

> +static struct reset_control *
> +__reset_control_get_from_lookup(struct device *dev, const char *id,
> +                               bool shared, bool optional)
> +{
> +       struct reset_controller_dev *rcdev;
> +       const char *dev_id = dev_name(dev);
> +       struct reset_control *rstc = NULL;
> +       const struct reset_lookup *lookup;
> +       int index;
> +
> +       mutex_lock(&reset_list_mutex);
> +
> +       list_for_each_entry(rcdev, &reset_controller_list, list) {
> +               if (!rcdev->lookup)
> +                       continue;
> +
> +               lookup = rcdev->lookup;

> +               for (index = 0; lookup->dev; index++, lookup++) {
> +                       if (strcmp(dev_id, lookup->dev))
> +                               continue;
> +
> +                       if ((!id && !lookup->id) ||
> +                           (id && lookup->id && !strcmp(id, lookup->id))) {
> +                               rstc = __reset_control_get_internal(rcdev,
> +                                                               index, shared);
> +                               break;
> +                       }

Wouldn't be slightly more readable

      if (id && lookup->id) {
        if (strcmp(id, lookup->id))
          continue;
      } else if (id || lookup->id) {
        continue;
      }

      rstc = __reset_control_get_internal(rcdev, index, shared);
      break;

> +               }
> +       }
> +
> +       mutex_unlock(&reset_list_mutex);
> +

> +       if (!rstc)
> +               return optional ? NULL : ERR_PTR(-ENOENT);

Isn't simpler

if (!optional && !rstc) // or other way around, depending which might
be more offten
 return ERR_PTR(...);

> +       return rstc;
> +}

-- 
With Best Regards,
Andy Shevchenko
