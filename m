Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965282AbeE3JRY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:17:24 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39425 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965050AbeE3JRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:17:16 -0400
X-Google-Smtp-Source: ADUXVKJIZHrE2oND5MLld+6bUgw46KAAf/xVCXiytRgBcbCtqX+WjFPBOzaz/ajZh+g16dpIkIIhRP6Nf6ZnvUN9b2A=
MIME-Version: 1.0
In-Reply-To: <20180525100121.28214-2-rnayak@codeaurora.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org> <20180525100121.28214-2-rnayak@codeaurora.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 May 2018 11:17:15 +0200
Message-ID: <CAPDyKFoAJjZknWtbbQLn0Hnc3Du_1vnSUnqfwZLYK76j2rg52g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] soc: qcom: rpmpd: Add a powerdomain driver to
 model corners
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        collinsd@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2018 at 12:01, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> The powerdomains for corners just pass the performance state set by the
> consumers to the RPM (Remote Power manager) which then takes care
> of setting the appropriate voltage on the corresponding rails to
> meet the performance needs.
>
> We add all powerdomain data needed on msm8996 here. This driver can easily
> be extended by adding data for other qualcomm SoCs as well.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.txt  |  55 ++++

Please split DT doc changes into separate patches, to simplify review.

>  drivers/soc/qcom/Kconfig                      |   9 +
>  drivers/soc/qcom/Makefile                     |   1 +
>  drivers/soc/qcom/rpmpd.c                      | 299 ++++++++++++++++++
>  4 files changed, 364 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>  create mode 100644 drivers/soc/qcom/rpmpd.c
>

[...]

> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_domain.h>
> +#include <linux/mfd/qcom_rpm.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +#include <dt-bindings/mfd/qcom-rpm.h>
> +
> +#define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
> +
> +/* Resource types */
> +#define RPMPD_SMPA 0x61706d73
> +#define RPMPD_LDOA 0x616f646c
> +
> +/* Operation Keys */
> +#define KEY_CORNER             0x6e726f63 /* corn */
> +#define KEY_ENABLE             0x6e657773 /* swen */
> +#define KEY_FLOOR_CORNER       0x636676   /* vfc */
> +
> +#define DEFINE_RPMPD_CORN_SMPA(_platform, _name, _active, r_id)                \
> +       static struct rpmpd _platform##_##_active;                      \
> +       static struct rpmpd _platform##_##_name = {                     \
> +               .pd = { .name = #_name, },                              \
> +               .peer = &_platform##_##_active,                         \
> +               .res_type = RPMPD_SMPA,                                 \
> +               .res_id = r_id,                                         \
> +               .key = KEY_CORNER,                                      \
> +       };                                                              \
> +       static struct rpmpd _platform##_##_active = {                   \
> +               .pd = { .name = #_active, },                            \
> +               .peer = &_platform##_##_name,                           \
> +               .active_only = true,                                    \
> +               .res_type = RPMPD_SMPA,                                 \
> +               .res_id = r_id,                                         \
> +               .key = KEY_CORNER,                                      \
> +       }
> +
> +#define DEFINE_RPMPD_CORN_LDOA(_platform, _name, r_id)                 \
> +       static struct rpmpd _platform##_##_name = {                     \
> +               .pd = { .name = #_name, },                              \
> +               .res_type = RPMPD_LDOA,                                 \
> +               .res_id = r_id,                                         \
> +               .key = KEY_CORNER,                                      \
> +       }
> +
> +#define DEFINE_RPMPD_VFC(_platform, _name, r_id, r_type)               \
> +       static struct rpmpd _platform##_##_name = {                     \
> +               .pd = { .name = #_name, },                              \
> +               .res_type = r_type,                                     \
> +               .res_id = r_id,                                         \
> +               .key = KEY_FLOOR_CORNER,                                \
> +       }
> +
> +#define DEFINE_RPMPD_VFC_SMPA(_platform, _name, r_id)                  \
> +       DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_SMPA)
> +
> +#define DEFINE_RPMPD_VFC_LDOA(_platform, _name, r_id)                  \
> +       DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_LDOA)
> +
> +struct rpmpd_req {
> +       __le32 key;
> +       __le32 nbytes;
> +       __le32 value;
> +};
> +
> +struct rpmpd {
> +       struct generic_pm_domain pd;
> +       struct rpmpd *peer;
> +       const bool active_only;
> +       unsigned long corner;
> +       bool enabled;
> +       const char *res_name;
> +       const int res_type;
> +       const int res_id;
> +       struct qcom_smd_rpm *rpm;
> +       __le32 key;
> +};
> +
> +struct rpmpd_desc {
> +       struct rpmpd **rpmpds;
> +       size_t num_pds;
> +};
> +
> +static DEFINE_MUTEX(rpmpd_lock);
> +
> +/* msm8996 RPM powerdomains */
> +DEFINE_RPMPD_CORN_SMPA(msm8996, vddcx, vddcx_ao, 1);
> +DEFINE_RPMPD_CORN_SMPA(msm8996, vddmx, vddmx_ao, 2);
> +DEFINE_RPMPD_CORN_LDOA(msm8996, vddsscx, 26);
> +
> +DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
> +DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
> +
> +static struct rpmpd *msm8996_rpmpds[] = {
> +       [0] = &msm8996_vddcx,
> +       [1] = &msm8996_vddcx_ao,
> +       [2] = &msm8996_vddcx_vfc,
> +       [3] = &msm8996_vddmx,
> +       [4] = &msm8996_vddmx_ao,
> +       [5] = &msm8996_vddsscx,
> +       [6] = &msm8996_vddsscx_vfc,
> +};

It's not my call, but honestly the above all macros makes the code
less readable.

Anyway, I think you should convert to allocate these structs
dynamically from the heap (kzalloc/kcalloc), instead of statically as
above.

> +
> +static const struct rpmpd_desc msm8996_desc = {
> +       .rpmpds = msm8996_rpmpds,
> +       .num_pds = ARRAY_SIZE(msm8996_rpmpds),
> +};
> +
> +static const struct of_device_id rpmpd_match_table[] = {
> +       { .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, rpmpd_match_table);

[...]

> +static int rpmpd_aggregate_corner(struct rpmpd *pd)
> +{

Isn't the aggregation of the performance states in genpd sufficient
for your case?

I guess this is SoC specific and needed anyways, but then could you
perhaps add a few comments about what goes on here?

> +       int ret;
> +       struct rpmpd *peer = pd->peer;
> +       unsigned long active_corner, sleep_corner;
> +       unsigned long this_corner = 0, this_sleep_corner = 0;
> +       unsigned long peer_corner = 0, peer_sleep_corner = 0;
> +
> +       to_active_sleep(pd, pd->corner, &this_corner, &this_sleep_corner);
> +
> +       if (peer && peer->enabled)
> +               to_active_sleep(peer, peer->corner, &peer_corner,
> +                               &peer_sleep_corner);
> +
> +       active_corner = max(this_corner, peer_corner);
> +
> +       ret = rpmpd_send_corner(pd, QCOM_RPM_ACTIVE_STATE, active_corner);
> +       if (ret)
> +               return ret;
> +
> +       sleep_corner = max(this_sleep_corner, peer_sleep_corner);
> +
> +       return rpmpd_send_corner(pd, QCOM_RPM_SLEEP_STATE, sleep_corner);
> +}

[...]

> +static int rpmpd_probe(struct platform_device *pdev)
> +{
> +       int i;
> +       size_t num;
> +       struct genpd_onecell_data *data;
> +       struct qcom_smd_rpm *rpm;
> +       struct rpmpd **rpmpds;
> +       const struct rpmpd_desc *desc;
> +
> +       rpm = dev_get_drvdata(pdev->dev.parent);
> +       if (!rpm) {
> +               dev_err(&pdev->dev, "Unable to retrieve handle to RPM\n");
> +               return -ENODEV;
> +       }
> +
> +       desc = of_device_get_match_data(&pdev->dev);
> +       if (!desc)
> +               return -EINVAL;
> +
> +       rpmpds = desc->rpmpds;
> +       num = desc->num_pds;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
> +                                    GFP_KERNEL);
> +       data->num_domains = num;
> +
> +       for (i = 0; i < num; i++) {
> +               if (!rpmpds[i])
> +                       continue;
> +
> +               rpmpds[i]->rpm = rpm;
> +               rpmpds[i]->pd.power_off = rpmpd_power_off;
> +               rpmpds[i]->pd.power_on = rpmpd_power_on;
> +               pm_genpd_init(&rpmpds[i]->pd, NULL, true);

Question: Is there no hierarchical topology of the PM domains. No
genpd subdomains?

> +
> +               data->domains[i] = &rpmpds[i]->pd;
> +       }
> +
> +       return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> +}
> +
> +static int rpmpd_remove(struct platform_device *pdev)
> +{
> +       of_genpd_del_provider(pdev->dev.of_node);
> +       return 0;
> +}
> +
> +static struct platform_driver rpmpd_driver = {
> +       .driver = {
> +               .name = "qcom-rpmpd",
> +               .of_match_table = rpmpd_match_table,
> +       },
> +       .probe = rpmpd_probe,
> +       .remove = rpmpd_remove,
> +};
> +
> +static int __init rpmpd_init(void)
> +{
> +       return platform_driver_register(&rpmpd_driver);
> +}
> +core_initcall(rpmpd_init);
> +
> +static void __exit rpmpd_exit(void)
> +{
> +       platform_driver_unregister(&rpmpd_driver);
> +}
> +module_exit(rpmpd_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm RPM Power Domain Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom-rpmpd");
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Besides the minor things above, this looks good to me.

Kind regards
Uffe
