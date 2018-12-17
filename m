Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F2FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFD820675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqRwdMOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbeLQSPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:15:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37520 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeLQSPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:15:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so4991911pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=og8Wglg/epenP0vUaoDaHpm/GgULb0XrG6CiyNfFsw8=;
        b=CqRwdMOi3FTGPV8digQwTckVl+iQKi95bj/38WqLqyx5TAgcbc3KYk9j8OqWK3L0kK
         441PC+QMhCld2Cu46N9MCq2abk9xxyCKOO6ANQUxtJTe5mc9CjgFw7dve/wXTS9o4drm
         vtAwnuQO56PbSsNsWrC7u2YlR6THHSaVT5nUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=og8Wglg/epenP0vUaoDaHpm/GgULb0XrG6CiyNfFsw8=;
        b=ObiBuDeoXRXBbkAIg1t2gcZNVc7grh4JIeqH8xrxspx8p1++DRdzBRQLGSwtC9iuq1
         Ol8cRT5GOBepko11yCRa9u+LlRsXEFvoCXDpck/GHidzo/ui2kcieuGfWF9TZEiXyoTS
         YSJmjsP02zElxev0Mh275usl7NVpLpUVw80QSC5thTiGpZkAgNL2h6pNiUFboCLJt5+v
         EQrr4ZeSl5PYAVyPP39q5VeZOwBuu2Ilx5y1G0hE9AnDwOZHf93w7ZTY7ZC6sZx1KzeS
         MGVmfOYPuq7i5mrhNlXa++iRmkFSVTwzo/RelxmSjXwueenDD/s8rsm0z2IjKuwj64/D
         YGrA==
X-Gm-Message-State: AA+aEWbR50uDzRnETT8ApY11QeoQjvd0FD7Xzfe2JbjAz/B9GlAjT23h
        p72GAP7JAJiTmFs6xnZTXk0/Qw==
X-Google-Smtp-Source: AFSGD/VEob1yLIEfHiOO9uf3rnKAEVvnoiDpvrGP0cYIoBq/a83twp+OQwF08oDpvgb23ffgyHcjIQ==
X-Received: by 2002:a65:500c:: with SMTP id f12mr12338572pgo.226.1545070544172;
        Mon, 17 Dec 2018 10:15:44 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x3sm42603674pgt.45.2018.12.17.10.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 10:15:43 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:15:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Gospodarek <gospo@broadcom.com>,
        Anup Patel <anup.patel@broadcom.com>,
        Caesar Wang <wxt@rock-chips.com>, CK Hu <ck.hu@mediatek.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, Duc Dang <dhdang@apm.com>,
        Eric Anholt <eric@anholt.net>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Feng Kan <fkan@apm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Lee Jones <lee.jones@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Ley Foon Tan <lftan@altera.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ray Jui <ray.jui@broadcom.com>,
        Rob Rice <rob.rice@broadcom.com>,
        Ruyi Wang <wangruyi@huawei.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Steve Lin <steven.lin1@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v2 01/19] mailbox: Add device-managed registration
 functions
Message-ID: <20181217181540.GC12886@minitux>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150217.32435-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 07:01 PST 2018, Thierry Reding wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> Add device-managed equivalents of the mbox_controller_register() and
> mbox_controller_unregister() functions that can be used to have the
> devres infrastructure automatically unregister mailbox controllers on
> driver probe failure or driver removal. This can help remove a lot of
> boiler plate code from drivers.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mailbox/mailbox.c          | 70 ++++++++++++++++++++++++++++++
>  include/linux/mailbox_controller.h |  5 +++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 674b35f402f5..eb781e2b19cb 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -515,3 +515,73 @@ void mbox_controller_unregister(struct mbox_controller *mbox)
>  	mutex_unlock(&con_mutex);
>  }
>  EXPORT_SYMBOL_GPL(mbox_controller_unregister);
> +
> +static void __devm_mbox_controller_unregister(struct device *dev, void *res)
> +{
> +	struct mbox_controller *mbox = res;
> +
> +	mbox_controller_unregister(mbox);
> +}
> +
> +static int devm_mbox_controller_match(struct device *dev, void *res, void *data)
> +{
> +	struct mbox_controller **mbox = res;
> +
> +	if (WARN_ON(!mbox || !*mbox))
> +		return 0;
> +
> +	return *mbox == data;
> +}
> +
> +/**
> + * devm_mbox_controller_register() - managed mbox_controller_register()
> + * @dev: device owning the mailbox controller being registered
> + * @mbox: mailbox controller being registered
> + *
> + * This function adds a device-managed resource that will make sure that the
> + * mailbox controller, which is registered using mbox_controller_register()
> + * as part of this function, will be unregistered along with the rest of
> + * device-managed resources upon driver probe failure or driver removal.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int devm_mbox_controller_register(struct device *dev,
> +				  struct mbox_controller *mbox)
> +{
> +	struct mbox_controller **ptr;
> +	int err;
> +
> +	ptr = devres_alloc(__devm_mbox_controller_unregister, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	err = mbox_controller_register(mbox);
> +	if (err < 0) {
> +		devres_free(ptr);
> +		return err;
> +	}
> +
> +	devres_add(dev, ptr);
> +	*ptr = mbox;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_mbox_controller_register);
> +
> +/**
> + * devm_mbox_controller_unregister() - managed mbox_controller_unregister()
> + * @dev: device owning the mailbox controller being unregistered
> + * @mbox: mailbox controller being unregistered
> + *
> + * This function unregisters the mailbox controller and removes the device-
> + * managed resource that was set up to automatically unregister the mailbox
> + * controller on driver probe failure or driver removal. It's typically not
> + * necessary to call this function.
> + */
> +void devm_mbox_controller_unregister(struct device *dev, struct mbox_controller *mbox)
> +{
> +	WARN_ON(devres_release(dev, __devm_mbox_controller_unregister,
> +			       devm_mbox_controller_match, mbox));
> +}
> +EXPORT_SYMBOL_GPL(devm_mbox_controller_unregister);
> diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
> index 74deadb42d76..9b0b21207345 100644
> --- a/include/linux/mailbox_controller.h
> +++ b/include/linux/mailbox_controller.h
> @@ -131,4 +131,9 @@ void mbox_controller_unregister(struct mbox_controller *mbox); /* can sleep */
>  void mbox_chan_received_data(struct mbox_chan *chan, void *data); /* atomic */
>  void mbox_chan_txdone(struct mbox_chan *chan, int r); /* atomic */
>  
> +int devm_mbox_controller_register(struct device *dev,
> +				  struct mbox_controller *mbox);
> +void devm_mbox_controller_unregister(struct device *dev,
> +				     struct mbox_controller *mbox);
> +
>  #endif /* __MAILBOX_CONTROLLER_H */
> -- 
> 2.19.1
> 
