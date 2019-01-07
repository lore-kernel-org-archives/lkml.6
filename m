Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99872147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfAGLGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:06:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12387 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbfAGLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:06:41 -0500
X-UUID: c588567d3af34ac49ad05aa871210393-20190107
X-UUID: c588567d3af34ac49ad05aa871210393-20190107
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1233337545; Mon, 07 Jan 2019 19:06:35 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:06:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 19:06:34 +0800
Message-ID: <1546859194.6818.129.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 3/7] soc: mediatek: add support for the
 performance state
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Mon, 7 Jan 2019 19:06:34 +0800
In-Reply-To: <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
         <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 14:57 -0800, Stephen Boyd wrote:
> Quoting Henry Chen (2019-01-02 06:09:54)
> > @@ -187,6 +190,18 @@ struct scp_soc_data {
> >         bool bus_prot_reg_update;
> >  };
> >  
> > +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
> 
> static?
OK
> 
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
> 
> What is the notifier for?
It used to notifier the DVFSRC driver that performance stat was changed.
> 
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
> 
> The generic API that Rajendra is adding I guess will become even more
> generic by assuming some sort of property like 'opp-level' or
> 'performance-state' that is just some raw number.
ok, I will follow the new property from Rajendra.

> > +
> > +       return state;
> > +}
> > +
> >  static struct scp *init_scp(struct platform_device *pdev,
> >                         const struct scp_domain_data *scp_domain_data, int num,
> >                         const struct scp_ctrl_reg *scp_ctrl_reg,


