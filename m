Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D018E21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeLRQFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:05:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbeLRQE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:04:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCF64A78;
        Tue, 18 Dec 2018 08:04:58 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCA903F5C0;
        Tue, 18 Dec 2018 08:04:52 -0800 (PST)
Date:   Tue, 18 Dec 2018 16:04:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Gospodarek <gospo@broadcom.com>,
        Anup Patel <anup.patel@broadcom.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 01/19] mailbox: Add device-managed registration
 functions
Message-ID: <20181218160445.GA32237@e107155-lin>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150217.32435-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:01:59PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add device-managed equivalents of the mbox_controller_register() and
> mbox_controller_unregister() functions that can be used to have the
> devres infrastructure automatically unregister mailbox controllers on
> driver probe failure or driver removal. This can help remove a lot of
> boiler plate code from drivers.
> 
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

This looks wrong to me. See below for details.

[...]

> +int devm_mbox_controller_register(struct device *dev,
> +				  struct mbox_controller *mbox)
> +{
> +	struct mbox_controller **ptr;
> +	int err;
> +
> +	ptr = devres_alloc(__devm_mbox_controller_unregister, sizeof(*ptr),
> +			   GFP_KERNEL);

devres_alloc returns devres->data as ptr above

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

And ...release is called with devres->data so we need *ptr
in devm_mbox_controller_unregister and not ptr itself something like:

	struct mbox_controller **mbox = res;
	mbox_controller_unregister(*mbox);

With above fixed:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

