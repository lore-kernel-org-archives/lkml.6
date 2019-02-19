Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDA52177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfBSKUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:20:49 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44344 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfBSKUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:20:49 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 615bca79ca1cceb2; Tue, 19 Feb 2019 11:20:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
Date:   Tue, 19 Feb 2019 11:19:22 +0100
Message-ID: <5139346.Didr8HbKkM@aspire.rjw.lan>
In-Reply-To: <20190214181249.2749-1-dianders@chromium.org>
References: <20190214181249.2749-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 14, 2019 7:12:48 PM CET Douglas Anderson wrote:
> The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> to of_property_match_string() where the argument is "const char *".
> Adding a const here allows a later patch to add a const to
> dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> that was declared "const" in a driver.
> 
> Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/base/power/domain.c | 2 +-
>  include/linux/pm_domain.h   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 45eafe8cf7dd..2c334c01fc43 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2483,7 +2483,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>   * power-domain-names DT property. For further description see
>   * genpd_dev_pm_attach_by_id().
>   */
> -struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
> +struct device *genpd_dev_pm_attach_by_name(struct device *dev, const char *name)
>  {
>  	int index;
>  
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index dd364abb649a..203be5082f33 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -271,7 +271,7 @@ int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  					 unsigned int index);
>  struct device *genpd_dev_pm_attach_by_name(struct device *dev,
> -					   char *name);
> +					   const char *name);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>  					struct generic_pm_domain *genpd)
> @@ -324,7 +324,7 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  }
>  
>  static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
> -							 char *name)
> +							 const char *name)
>  {
>  	return NULL;
>  }
> 

Both this and the [2/2] applied, thanks!


