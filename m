Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeCPEmD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:42:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46742 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeCPEmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:42:01 -0400
X-Google-Smtp-Source: AG47ELtHCPRPWCQRUshlsUMjH3L7KTGIRXxhOwqBd+mhu+fUs9uYhjve96CKVIQ7Ld3lnNY46Mi4lw==
Date: Fri, 16 Mar 2018 10:11:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] soc: qcom: rpmpd: Add a max vote on all corners at
 init
Message-ID: <20180316044158.GT15832@vireshk-i7>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-8-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316040824.21472-8-rnayak@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-18, 09:38, Rajendra Nayak wrote:
> As we move from no clients/consumers in kernel voting on corners,
> to *some* voting and some not voting, we might end up in a situation
> where the clients which remove votes can adversly impact others
> who still don't have a way to vote.
> 
> To avoid this situation, have a max vote on all corners at init.
> This should/can be removed once we have all clients moved to
> be able to vote/unvote for themselves.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmpd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 4058c5b450c6..ebdcf9398441 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -304,6 +304,15 @@ static int rpmpd_probe(struct platform_device *pdev)
>  		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
>  
>  		data->domains[i] = &rpmpds[i]->pd;
> +
> +		/*
> +		 * Until we have all consumers voting on corners
> +		 * just vote the max corner on all PDs
> +		 * This should ideally be *removed* once we have
> +		 * all (most) consumers being able to vote
> +		 */
> +		rpmpd_set_performance(&rpmpds[i]->pd, MAX_RPMPD_STATE);
> +		rpmpd_power_on(&rpmpds[i]->pd);
>  	}
>  
>  	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
