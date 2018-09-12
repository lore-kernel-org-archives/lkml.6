Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0366C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567FE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RItN4KDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567FE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeIMDep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:34:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbeIMDep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:34:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so1634447plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8KNxWcmZbq/9VcjsM3slaV8Waiw2gwgR9BQDmllszmA=;
        b=RItN4KDTD51nZjyFHVLhPRMoePELeuoPGtxgc2CtUcRrGevidWNbP0IJ+5tXilIOHX
         nSu12ERXo62JjRN/eIr54AMQTvBwXj0Nn22pDqDMc7M6RNRP4NAggbOhYdYevsK/pmfU
         7aT7yvE1Kb0rZpwVwevc7fXbJI5lA3qRdjVG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8KNxWcmZbq/9VcjsM3slaV8Waiw2gwgR9BQDmllszmA=;
        b=ZW+xps86cksXR/pObNeC0foQqjiEDDpf8lyp+BBuctXDeeDjh1SfX2AcyO7AALIvb9
         CgKfO/gEpfhjSgyw/C35BkVaRBykNc4FfOetxzLLGBI6NxaNeuWn1lFGlD4WAqDnCnOg
         uMR0yu5/W6twBGDjjEFx7D5A1XKEd/waduiPCMlHG/IeRyI1z40wk6Tcy27c/GjK46Dc
         42idTqLMrZ9+N1jdPKYISOJvzEy72tVq1Qp6PnmFK8uFSZwK0ArZB5sAxRotWx4Gho9g
         2SSLKwP5YzcPsNPC7SwZWH8ko8NMXPSTdmsR/BM4QeCC84hXgoaAcfNPZ8wA+iOBWMi6
         ln5Q==
X-Gm-Message-State: APzg51AUVI+IIxoVfFMbWTsbfOIqifD+jWM601yhJgK9JvML32jdk/YI
        63nVT42k2mRJbp6dB1q3GWZi9Q==
X-Google-Smtp-Source: ANB0VdZOvU7MGIm82E2tW5MtkesgpMaducpjkAgfWRFMO+AJrC9Jfgn/jUBSpO4Ct3NsTJoC/Dv14g==
X-Received: by 2002:a17:902:4a:: with SMTP id 68-v6mr4274488pla.276.1536791290504;
        Wed, 12 Sep 2018 15:28:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j22-v6sm2932532pfh.45.2018.09.12.15.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 15:28:09 -0700 (PDT)
Date:   Wed, 12 Sep 2018 15:28:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, ilina@codeaurora.org
Subject: Re: [PATCH v2 5/6] drivers: qcom: rpmh-rsc: write PDC data
Message-ID: <20180912222809.GK22824@google.com>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-6-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532685889-31345-6-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:34:48PM +0530, Raju P L S S S N wrote:
> From: Lina Iyer <ilina@codeaurora.org>
> 
> The Power Domain Controller can be programmed to wakeup the RSC and
> setup the resources back in the active state, before the processor is
> woken up by a timer interrupt. The wakeup value from the timer hardware
> can be copied to the PDC which has its own timer and is in an always-on
> power domain. Programming the wakeup value is done through a separate
> register on the RSC.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
> Changes in v2:
>    - Remove unnecessary EXPORT_SYMBOL
> ---
>  drivers/soc/qcom/rpmh-internal.h |  3 +++
>  drivers/soc/qcom/rpmh-rsc.c      | 35 +++++++++++++++++++++++++++++------
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index 6cd2f78..f5359be 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -87,6 +87,7 @@ struct rpmh_ctrlr {
>   * Resource State Coordinator controller (RSC)
>   *
>   * @name:       controller identifier
> + * @base:       start address of the RSC's DRV registers
>   * @tcs_base:   start address of the TCS registers in this controller
>   * @id:         instance id in the controller (Direct Resource Voter)
>   * @num_tcs:    number of TCSes in this DRV
> @@ -97,6 +98,7 @@ struct rpmh_ctrlr {
>   */
>  struct rsc_drv {
>  	const char *name;
> +	void __iomem *base;
>  	void __iomem *tcs_base;
>  	int id;
>  	int num_tcs;
> @@ -111,6 +113,7 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
>  			     const struct tcs_request *msg);
>  int rpmh_rsc_invalidate(struct rsc_drv *drv);
>  bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv);
> +int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg);
>  
>  void rpmh_tx_done(const struct tcs_request *msg, int r);
>  
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 19616c9..c870477 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -60,6 +60,11 @@
>  #define CMD_STATUS_ISSUED		BIT(8)
>  #define CMD_STATUS_COMPL		BIT(16)
>  
> +/* PDC wakeup */
> +#define RSC_PDC_DATA_SIZE		2
> +#define RSC_PDC_DRV_DATA		0x38
> +#define RSC_PDC_DATA_OFFSET		0x08
> +
>  static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
>  {
>  	return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
> @@ -569,6 +574,25 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
>  	return tcs_ctrl_write(drv, msg);
>  }
>  
> +int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg)
> +{
> +	int i;
> +	void __iomem *addr = drv->base + RSC_PDC_DRV_DATA;
> +
> +	if (!msg || !msg->cmds || msg->num_cmds != RSC_PDC_DATA_SIZE)
> +		return -EINVAL;

Is it really always exactly 2 (RSC_PDC_DATA_SIZE) commands?

> +
> +	for (i = 0; i < msg->num_cmds; i++) {
> +		/* Only data is write capable */
> +		writel_relaxed(msg->cmds[i].data, addr);
> +		trace_rpmh_send_msg(drv, RSC_PDC_DRV_DATA, i, 0,
> +				    &msg->cmds[i]);
> +		addr += RSC_PDC_DATA_OFFSET;
> +	}
> +
> +	return 0;
> +}
> +
>  static int rpmh_probe_tcs_config(struct platform_device *pdev,
>  				 struct rsc_drv *drv)
>  {
> @@ -581,21 +605,20 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
>  	int i, ret, n, st = 0;
>  	struct tcs_group *tcs;
>  	struct resource *res;
> -	void __iomem *base;
>  	char drv_id[10] = {0};
>  
>  	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, drv_id);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	drv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(drv->base))
> +		return PTR_ERR(drv->base);
>  
>  	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
>  	if (ret)
>  		return ret;
> -	drv->tcs_base = base + offset;
> +	drv->tcs_base = drv->base + offset;
>  
> -	config = readl_relaxed(base + DRV_PRNT_CHLD_CONFIG);
> +	config = readl_relaxed(drv->base + DRV_PRNT_CHLD_CONFIG);
>  
>  	max_tcs = config;
>  	max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
