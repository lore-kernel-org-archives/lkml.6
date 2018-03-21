Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeCUUR7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:17:59 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:40867 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeCUURw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:17:52 -0400
X-Google-Smtp-Source: AG47ELtpWJN4njv2GR9m7fYL6DcoXgeJUlK6uSuifFpEZV9fasiUoAhcgD6N/q4pmwZAjXJL9hdAmA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180321165848.89751-4-swboyd@chromium.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
Message-ID: <152166346979.154352.7302935269984897659@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be requested
Date: Wed, 21 Mar 2018 13:17:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2LKIMdf000585

Quoting Stephen Boyd (2018-03-21 09:58:48)
> +       ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
> +       if (ret > 0 && ret < max_gpios) {
> +               u16 *tmp;
> +
> +               len = ret;
> +               tmp = kmalloc_array(len, sizeof(tmp[0]), GFP_KERNEL);
> +               if (!tmp)
> +                       return -ENOMEM;
> +
> +               ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp,
> +                                                    len);
> +               if (ret < 0) {
> +                       dev_err(pctrl->dev, "could not read list of GPIOs\n");
> +                       kfree(tmp);
> +                       return ret;
> +               }
> +
> +               bitmap_zero(chip->valid_mask, max_gpios);
> +               for (i = 0; i < len; i++)
> +                       set_bit(tmp[i], chip->valid_mask);

This leaks tmp too.. I'll fix that in v4 and resend tomorrow if there
aren't more comments.
