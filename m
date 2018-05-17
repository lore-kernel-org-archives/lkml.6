Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeEQVWO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:22:14 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43304 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeEQVWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:22:11 -0400
X-Google-Smtp-Source: AB8JxZpYg1UXfUYJ+YTFVIpUzfwKKm295UVGjVbp+ryBmEyGMCOxbpBCGCgJeGuE9RF4iEnXgNCs3s8hSiy9pmwN/QM=
MIME-Version: 1.0
In-Reply-To: <58bb4f965515a67a6cbbc726b0d7b092c22b79d7.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org> <58bb4f965515a67a6cbbc726b0d7b092c22b79d7.1526088289.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 17 May 2018 14:22:09 -0700
X-Google-Sender-Auth: MY9aaknfyl2NAWnc8VhcNuplgx0
Message-ID: <CAD=FV=Wk_vYcxV+XXvHVdSC4erNB3=_ecMimeUrEw61Po04Rmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: of: add support for allowed modes configuration
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 11, 2018 at 6:46 PM, David Collins <collinsd@codeaurora.org> wrote:
> @@ -136,6 +136,33 @@ static void of_get_regulation_constraints(struct device_node *np,
>                 }
>         }
>
> +       len = of_property_count_elems_of_size(np, "regulator-allowed-modes",
> +                                               sizeof(u32));
> +       if (len > 0) {
> +               if (desc && desc->of_map_mode) {
> +                       for (i = 0; i < len; i++) {
> +                               ret = of_property_read_u32_index(np,
> +                                       "regulator-allowed-modes", i, &pval);
> +                               if (ret) {
> +                                       pr_err("%s: couldn't read allowed modes index %d, ret=%d\n",
> +                                               np->name, i, ret);
> +                                       break;
> +                               }
> +                               mode = desc->of_map_mode(pval);
> +                               if (mode == REGULATOR_MODE_INVALID)
> +                                       pr_err("%s: invalid regulator-allowed-modes element %u\n",
> +                                               np->name, pval);
> +                               else
> +                                       constraints->valid_modes_mask |= mode;
> +                       }
> +                       if (constraints->valid_modes_mask)
> +                               constraints->valid_ops_mask
> +                                       |= REGULATOR_CHANGE_MODE;

Kinda calls into question the value of REGULATOR_CHANGE_MODE in the
valid_ops_mask if it's just set whenever valid_modes_mask is non-zero,
huh?

> +               } else {
> +                       pr_warn("%s: mode mapping not defined\n", np->name);
> +               }
> +       }
> +

This patch seems good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
