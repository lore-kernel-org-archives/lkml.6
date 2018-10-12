Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB2DC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430E213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqNoeuFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C430E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeJLWpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:45:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52130 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeJLWpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:45:11 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so19227854itw.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9T+AFo75bq3RNEb3xu6IRsSqbPG2VzNdYksnRLsSQqo=;
        b=XqNoeuFdk7GjsWrrRfzaZ6kjtW/j5p1OFDuPjhh12o2Uiaopjpw4aNUWMyut9K26nW
         K/rcQCXPhpPY6uxjkVlax1N8UVYLpeP6aMQRHlsCyNfMgpwfDrJBzMGC2abTiET176Jz
         aXT46g2e6y7gE/QQovhH06Jo3s4Q1ZFjE9Flg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9T+AFo75bq3RNEb3xu6IRsSqbPG2VzNdYksnRLsSQqo=;
        b=Sf8ZC3+xSBWbtnTzqVgg3ropjvs3Z4PKO8+QA+iNhZJ3dhtZJwie7T8ggxoj6A6YPg
         Eu3AAqCAusjuWITYNhdupC31pwuZI6fSifWZ8Qj4ByUe8Yq40plT7lMhZ055+CgiF0gN
         j8hXaH1YXPafg1YXKpt7kVVlzSpBQkQnPZeVcS9V3J9No1wwTYammzSti0RgnJhjkRUw
         XJe7daGVhcFEmReT5Zn9k3UoNDF2WL/glN4J5PEwtL4rDsi1nGLF1S/2z0ANJaE+Yst7
         vYl8OIiGmW9MEOUWt1KGP6GLXUI92RLlcJI0kXY9hPid4V05c21uBHQhs9+c+Hn+QjHR
         lnRw==
X-Gm-Message-State: ABuFfojrfJ/PGsQYCW5VA6aWmkh5P9x8+PHaK0TVVXgsDyUMDOP0ToG2
        KYj7cauH9sDDVzFEHG8k2WtTJsve07FPm+kje/4qHA==
X-Google-Smtp-Source: ACcGV63rqsw+U/NVp5ZOp0bPnxEYiFlCUmOqNJou5v98MjUbK+At5ttHuOB/xWU8kKju7DmWk7G64sLCLAbnZzWbSIs=
X-Received: by 2002:a24:4795:: with SMTP id t143-v6mr4837042itb.78.1539357135599;
 Fri, 12 Oct 2018 08:12:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 08:11:35
 -0700 (PDT)
In-Reply-To: <55853fb39ed5c7c01ec8dfb78f53a32b5dc98966.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <55853fb39ed5c7c01ec8dfb78f53a32b5dc98966.1539341929.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Oct 2018 17:11:35 +0200
Message-ID: <CAPDyKFqNmRtBDwDFjopMAS0-aNpbSQr948pHrV+NNWNVpyP2QA@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] OPP: Populate required opp tables from
 "required-opps" property
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The current implementation works only for the case where a single
> phandle is present in the "required-opps" property, while DT allows
> multiple phandles to be present there.
>
> This patch adds new infrastructure to parse all the phandles present in
> "required-opps" property and save pointers of the required OPP's OPP
> tables. These will be used by later commits.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/core.c |   2 +
>  drivers/opp/of.c   | 147 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/opp/opp.h  |   8 +++
>  3 files changed, 157 insertions(+)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index ebb3b648e0fd..85174a5c4850 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -901,6 +901,8 @@ static void _opp_table_kref_release(struct kref *kref)
>         struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
>         struct opp_device *opp_dev, *temp;
>
> +       _of_clear_opp_table(opp_table);
> +
>         /* Release clk */
>         if (!IS_ERR(opp_table->clk))
>                 clk_put(opp_table->clk);
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 5f114cd3d88c..b5605196122a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -73,6 +73,147 @@ struct opp_table *_managed_opp(struct device *dev, int index)
>         return managed_table;
>  }
>
> +/* The caller must call dev_pm_opp_put() after the OPP is used */
> +static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
> +                                         struct device_node *opp_np)
> +{
> +       struct dev_pm_opp *opp;
> +
> +       lockdep_assert_held(&opp_table_lock);
> +
> +       mutex_lock(&opp_table->lock);
> +
> +       list_for_each_entry(opp, &opp_table->opp_list, node) {
> +               if (opp->np == opp_np) {
> +                       dev_pm_opp_get(opp);
> +                       mutex_unlock(&opp_table->lock);
> +                       return opp;
> +               }
> +       }
> +
> +       mutex_unlock(&opp_table->lock);
> +
> +       return NULL;
> +}
> +
> +static struct device_node *of_parse_required_opp(struct device_node *np,
> +                                                int index)
> +{
> +       struct device_node *required_np;
> +
> +       required_np = of_parse_phandle(np, "required-opps", index);
> +       if (unlikely(!required_np)) {
> +               pr_err("%s: Unable to parse required-opps: %pOF, index: %d\n",
> +                      __func__, np, index);
> +       }
> +
> +       return required_np;
> +}
> +
> +/* The caller must call dev_pm_opp_put_opp_table() after the table is used */
> +static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
> +{
> +       struct opp_table *opp_table;
> +       struct dev_pm_opp *opp;
> +
> +       lockdep_assert_held(&opp_table_lock);
> +
> +       list_for_each_entry(opp_table, &opp_tables, node) {
> +               opp = _find_opp_of_np(opp_table, opp_np);
> +               if (opp) {
> +                       dev_pm_opp_put(opp);
> +                       _get_opp_table_kref(opp_table);
> +                       return opp_table;
> +               }
> +       }
> +
> +       return ERR_PTR(-ENODEV);
> +}
> +
> +/* Free resources previously acquired by _opp_table_alloc_required_tables() */
> +static void _opp_table_free_required_tables(struct opp_table *opp_table)
> +{
> +       struct opp_table **required_opp_tables = opp_table->required_opp_tables;
> +       int i;
> +
> +       if (!required_opp_tables)
> +               return;
> +
> +       for (i = 0; i < opp_table->required_opp_count; i++) {
> +               if (IS_ERR_OR_NULL(required_opp_tables[i]))
> +                       break;
> +
> +               dev_pm_opp_put_opp_table(required_opp_tables[i]);
> +       }
> +
> +       kfree(required_opp_tables);
> +
> +       opp_table->required_opp_count = 0;
> +       opp_table->required_opp_tables = NULL;
> +}
> +
> +/*
> + * Populate all devices and opp tables which are part of "required-opps" list.
> + * Checking only the first OPP node should be enough.
> + */
> +static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> +                                            struct device *dev,
> +                                            struct device_node *opp_np)
> +{
> +       struct opp_table **required_opp_tables;
> +       struct device_node *required_np, *np;
> +       int count, i;
> +
> +       /* Traversing the first OPP node is all we need */
> +       np = of_get_next_available_child(opp_np, NULL);
> +       if (!np) {
> +               dev_err(dev, "Empty OPP table\n");
> +               return;
> +       }
> +
> +       count = of_count_phandle_with_args(np, "required-opps", NULL);
> +       if (!count)
> +               goto put_np;
> +
> +       required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
> +                                     GFP_KERNEL);
> +       if (!required_opp_tables)
> +               goto put_np;
> +
> +       opp_table->required_opp_tables = required_opp_tables;
> +       opp_table->required_opp_count = count;
> +
> +       for (i = 0; i < count; i++) {
> +               required_np = of_parse_required_opp(np, i);
> +               if (!required_np)
> +                       goto free_required_tables;
> +
> +               required_opp_tables[i] = _find_table_of_opp_np(required_np);
> +               of_node_put(required_np);
> +
> +               if (IS_ERR(required_opp_tables[i]))
> +                       goto free_required_tables;
> +
> +               /*
> +                * We only support genpd's OPPs in the "required-opps" for now,
> +                * as we don't know how much about other cases. Error out if the
> +                * required OPP doesn't belong to a genpd.
> +                */
> +               if (!required_opp_tables[i]->is_genpd) {
> +                       dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> +                               required_np);
> +                       goto free_required_tables;
> +               }
> +       }
> +
> +       goto put_np;
> +
> +free_required_tables:
> +       _opp_table_free_required_tables(opp_table);
> +put_np:
> +       of_node_put(np);
> +}
> +
>  void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
>                         int index)
>  {
> @@ -109,9 +250,15 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
>
>         opp_table->np = opp_np;
>
> +       _opp_table_alloc_required_tables(opp_table, dev, opp_np);
>         of_node_put(opp_np);
>  }
>
> +void _of_clear_opp_table(struct opp_table *opp_table)
> +{
> +       _opp_table_free_required_tables(opp_table);
> +}
> +
>  static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>                               struct device_node *np)
>  {
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index cdb0c2b095e2..024e1be23d37 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -133,6 +133,9 @@ enum opp_table_access {
>   * @parsed_static_opps: True if OPPs are initialized from DT.
>   * @shared_opp: OPP is shared between multiple devices.
>   * @suspend_opp: Pointer to OPP to be used during device suspend.
> + * @required_opp_tables: List of device OPP tables that are required by OPPs in
> + *             this table.
> + * @required_opp_count: Number of required devices.
>   * @supported_hw: Array of version number to support.
>   * @supported_hw_count: Number of elements in supported_hw array.
>   * @prop_name: A name to postfix to many DT properties, while parsing them.
> @@ -172,6 +175,9 @@ struct opp_table {
>         enum opp_table_access shared_opp;
>         struct dev_pm_opp *suspend_opp;
>
> +       struct opp_table **required_opp_tables;
> +       unsigned int required_opp_count;
> +
>         unsigned int *supported_hw;
>         unsigned int supported_hw_count;
>         const char *prop_name;
> @@ -208,9 +214,11 @@ void _put_opp_list_kref(struct opp_table *opp_table);
>
>  #ifdef CONFIG_OF
>  void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
> +void _of_clear_opp_table(struct opp_table *opp_table);
>  struct opp_table *_managed_opp(struct device *dev, int index);
>  #else
>  static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
> +static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
>  static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
>  #endif
>
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
