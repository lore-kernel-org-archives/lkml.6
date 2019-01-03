Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED17C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232F5218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546556230;
	bh=sVYZSZnSZtHY9vTnHtjEpk8aBl6O5BQi9VAoiasp9aA=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=PVNS55I+e8IsNn56iJHjdwUDakDXv7lFsy+yZgPRjK+k/wQ28nlpeG1RTXwwd9XIZ
	 h6zGfE97W+tH/pxtUfj7TJmdc2ZOrcukO/dIt++chxKoaHQI6REmlSlZOl9aKle2VI
	 GjFuvLYIeD9VcLH4cSEwU42EdyByFmYTnbIesYGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfACW5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfACW5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:57:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFBC21479;
        Thu,  3 Jan 2019 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546556227;
        bh=sVYZSZnSZtHY9vTnHtjEpk8aBl6O5BQi9VAoiasp9aA=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=Z9TTGFEE74nC8MmHYmkPzvzDaE078+CdpAopt+L+1lEx9PHiXuxmCkdvCdbO5A/rD
         oadF2rmkcQT5V/W6SlbCQDiYof5Q0t1KEOH4SHioxEgg/umOyVle4FJZyByGSxfIG2
         YH7MbaWB1ZpSDh+EO9ZgDANrSRPjHK7HI24ACDAs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC RESEND PATCH 3/7] soc: mediatek: add support for the performance state
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Henry Chen <henryc.chen@mediatek.com>
To:     Henry Chen <henryc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com> <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
Message-ID: <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 14:57:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Henry Chen (2019-01-02 06:09:54)
> @@ -187,6 +190,18 @@ struct scp_soc_data {
>         bool bus_prot_reg_update;
>  };
> =20
> +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);

static?

> +
> +int register_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb=
);
> +}
> +
> +int unregister_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, =
nb);
> +}

What is the notifier for?

> +
>  static int scpsys_domain_is_on(struct scp_domain *scpd)
>  {
>         struct scp *scp =3D scpd->scp;
> @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, =
struct clk **clk)
>                 clk[i] =3D devm_clk_get(&pdev->dev, clk_names[i]);
>  }
> =20
> +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> +                                 unsigned int state)
> +{
> +       int i;
> +       struct scp_domain *scpd =3D
> +               container_of(genpd, struct scp_domain, genpd);
> +       struct scp_event_data scpe;
> +       struct scp *scp =3D scpd->scp;
> +       struct genpd_onecell_data *pd_data =3D &scp->pd_data;
> +
> +       for (i =3D 0; i < pd_data->num_domains; i++) {
> +               if (genpd =3D=3D pd_data->domains[i]) {
> +                       dev_dbg(scp->dev, "%d. %s =3D %d\n",
> +                               i, genpd->name, state);
> +                       break;
> +               }
> +       }
> +
> +       scpe.event_type =3D MTK_SCPSYS_PSTATE;
> +       scpe.genpd =3D genpd;
> +       scpe.domain_id =3D i;
> +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> +
> +       return 0;
> +}
> +
> +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *gen=
pd,
> +                                          struct dev_pm_opp *opp)
> +{
> +       struct device_node *np;
> +       unsigned int state;
> +
> +       np =3D dev_pm_opp_get_of_node(opp);
> +
> +       if (of_property_read_u32(np, "mtk,level", &state))
> +               return 0;
> +
> +       of_node_put(np);

The generic API that Rajendra is adding I guess will become even more
generic by assuming some sort of property like 'opp-level' or
'performance-state' that is just some raw number.

> +
> +       return state;
> +}
> +
>  static struct scp *init_scp(struct platform_device *pdev,
>                         const struct scp_domain_data *scp_domain_data, in=
t num,
>                         const struct scp_ctrl_reg *scp_ctrl_reg,
