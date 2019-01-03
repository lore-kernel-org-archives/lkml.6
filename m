Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95D52073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfACOQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:16:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37988 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726710AbfACOQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:16:37 -0500
X-UUID: 7a2009ed0fdf4d60bb27d221510e87db-20190103
X-UUID: 7a2009ed0fdf4d60bb27d221510e87db-20190103
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1859930055; Thu, 03 Jan 2019 22:16:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 22:16:28 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 22:16:28 +0800
Message-ID: <1546524988.6818.54.camel@mtksdaap41>
Subject: Re: [RFC PATCH 3/7] soc: mediatek: add support for the performance
 state
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        "James Liao" <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Thu, 3 Jan 2019 22:16:28 +0800
In-Reply-To: <CANMq1KCNSRv36L7mFNDEwFEdHm+q8cYz7GmfQZJQSGboe36vKQ@mail.gmail.com>
References: <1546436644-19234-1-git-send-email-henryc.chen@mediatek.com>
         <1546436644-19234-4-git-send-email-henryc.chen@mediatek.com>
         <CANMq1KCNSRv36L7mFNDEwFEdHm+q8cYz7GmfQZJQSGboe36vKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 20133DFCC9BD558BAEE30AE3E94BE961769B75F3AC7540A52EECFF7041C9A3C32000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 09:48 +0800, Nicolas Boichat wrote:
> On Wed, Jan 2, 2019 at 10:01 PM Henry Chen <henryc.chen@mediatek.com> wrote:
> >
> > Support power domain performance state, add header file for scp event.
> >
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c | 60 +++++++++++++++++++++++++++++++++++++++
> >  drivers/soc/mediatek/mtk-scpsys.h | 22 ++++++++++++++
> >  2 files changed, 82 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 58d84fe..90102ae 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -11,7 +11,9 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> > +#include <linux/pm_opp.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> >  #include <linux/soc/mediatek/infracfg.h>
> >  #include <linux/soc/mediatek/scpsys-ext.h>
> >
> > @@ -22,6 +24,7 @@
> >  #include <dt-bindings/power/mt7623a-power.h>
> >  #include <dt-bindings/power/mt8173-power.h>
> >  #include <dt-bindings/power/mt8183-power.h>
> > +#include "mtk-scpsys.h"
> >
> >  #define MTK_POLL_DELAY_US   10
> >  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> > @@ -187,6 +190,18 @@ struct scp_soc_data {
> >         bool bus_prot_reg_update;
> >  };
> >
> > +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
> > +
> > +int register_scpsys_notifier(struct notifier_block *nb)
> > +{
> > +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
> > +}
> > +
> > +int unregister_scpsys_notifier(struct notifier_block *nb)
> > +{
> > +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
> > +}
> > +
> >  static int scpsys_domain_is_on(struct scp_domain *scpd)
> >  {
> >         struct scp *scp = scpd->scp;
> > @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
> >                 clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> >  }
> >
> > +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> > +                                 unsigned int state)
> > +{
> > +       int i;
> > +       struct scp_domain *scpd =
> > +               container_of(genpd, struct scp_domain, genpd);
> 
> nit: This (just) fits in 80 chars.
Try again and get 81 chars :)
> 
> > +       struct scp_event_data scpe;
> > +       struct scp *scp = scpd->scp;
> > +       struct genpd_onecell_data *pd_data = &scp->pd_data;
> > +
> > +       for (i = 0; i < pd_data->num_domains; i++) {
> > +               if (genpd == pd_data->domains[i]) {
> > +                       dev_dbg(scp->dev, "%d. %s = %d\n",
> > +                               i, genpd->name, state);
> > +                       break;
> > +               }
> > +       }
> 
> Do we need a sanity check here, if i == pd_data->num_domains?
Oops. It needed, thanks for remind.
> 
> > +
> > +       scpe.event_type = MTK_SCPSYS_PSTATE;
> > +       scpe.genpd = genpd;
> > +       scpe.domain_id = i;
> > +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> > +
> > +       return 0;
> > +}
> > +
> > +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
> > +                                          struct dev_pm_opp *opp)
> > +{
> > +       struct device_node *np;
> > +       unsigned int state;
> > +
> > +       np = dev_pm_opp_get_of_node(opp);
> > +
> > +       if (of_property_read_u32(np, "mtk,level", &state))
> > +               return 0;
> > +
> > +       of_node_put(np);
> > +
> > +       return state;
> > +}
> > +
> >  static struct scp *init_scp(struct platform_device *pdev,
> >                         const struct scp_domain_data *scp_domain_data, int num,
> >                         const struct scp_ctrl_reg *scp_ctrl_reg,
> > @@ -659,6 +716,9 @@ static struct scp *init_scp(struct platform_device *pdev,
> >                 genpd->power_on = scpsys_power_on;
> >                 if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
> >                         genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> > +
> > +               genpd->set_performance_state = mtk_pd_set_performance;
> > +               genpd->opp_to_performance_state = mtk_pd_get_performance;
> >         }
> >
> >         return scp;
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
> > new file mode 100644
> > index 0000000..c1e8325
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Copyright (c) 2018 MediaTek Inc.
> > + */
> > +
> > +#ifndef __MTK_SCPSYS_H__
> > +#define __MTK_SCPSYS_H__
> > +
> > +struct scp_event_data {
> > +       int event_type;
> > +       int domain_id;
> > +       struct generic_pm_domain *genpd;
> > +};
> > +
> > +enum scp_event_type {
> > +       MTK_SCPSYS_PSTATE,
> > +};
> > +
> > +int register_scpsys_notifier(struct notifier_block *nb);
> > +int unregister_scpsys_notifier(struct notifier_block *nb);
> > +
> > +#endif /* __MTK_SCPSYS_H__ */
> > --
> > 1.9.1
> >


