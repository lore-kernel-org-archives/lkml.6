Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeCHUrL convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbeCHUrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:47:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C5E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180302164317.10554-11-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-11-ilina@codeaurora.org>
Message-ID: <152054202832.219802.7852347243050168190@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 10/10] drivers: qcom: rpmh-rsc: allow active requests from
 wake TCS
Date: Thu, 08 Mar 2018 12:47:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-03-02 08:43:17)
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index e9f5a1f387fd..d9cfa7aaf49c 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -220,6 +220,7 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>                                         struct tcs_request *msg)
>  {
>         int type;
> +       struct tcs_group *tcs;

const?

>  
>         switch (msg->state) {
>         case RPMH_ACTIVE_ONLY_STATE:
> @@ -235,7 +236,22 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>                 return ERR_PTR(-EINVAL);
>         }
>  
> -       return get_tcs_of_type(drv, type);
> +       /*
> +        * If we are making an active request on a RSC that does not have a
> +        * dedicated TCS for active state use, then re-purpose a wake TCS to
> +        * send active votes.
> +        * NOTE: The driver must be aware that this RSC does not have a
> +        * dedicated AMC, and therefore would invalidate the sleep and wake
> +        * TCSes before making an active state request.
> +        */
> +       tcs = get_tcs_of_type(drv, type);
> +       if (msg->state == RPMH_ACTIVE_ONLY_STATE && IS_ERR(tcs)) {
> +               tcs = get_tcs_of_type(drv, WAKE_TCS);
> +               if (!IS_ERR(tcs))
> +                       rpmh_rsc_invalidate(drv);
> +       }
> +
> +       return tcs;
