Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3107C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9430D21906
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545337182;
	bh=2nqRhJSlr9agMfKMbFNYNNDKgT2IFpoT2MJ0/QxOcQI=;
	h=To:References:Cc:From:In-Reply-To:Subject:Date:List-ID:From;
	b=QKPnS5B3phFWtrFsQ5VdoFnxA2eagQbR/8lSJQRrYmPLIUnBm2AsOtPLL7kXAkdMG
	 WbSuDeDt5wIwcSSiME+jHtf5fLr9UTLT+WcKlreasSbCKF8zZo/R4BeVpwl13tndwm
	 Z6yxQBydV5C8ve8qFCrukbQiKZ69+goExp5wutnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbeLTUTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:19:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeLTUTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:19:41 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41DC721905;
        Thu, 20 Dec 2018 20:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545337180;
        bh=2nqRhJSlr9agMfKMbFNYNNDKgT2IFpoT2MJ0/QxOcQI=;
        h=To:References:Cc:From:In-Reply-To:Subject:Date:From;
        b=CvDVP86+gaL0j7BToqTOLswR6S5Q7EnnwlT8+ev904KCllkoC0DYMlpPex3FLctLr
         IfWSFT67X+Q7POCdabHYHFCDIX8pRnZF6ZEJzX2b1El5YrFYNFaEzwBLnMxerrnCaM
         4edIovr9S5dQcSQnLGBq80NdgTaiMgKL7od1gGUM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        marc.zyngier@arm.com
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-4-ilina@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181219221105.3004-4-ilina@codeaurora.org>
Message-ID: <154533717951.79149.1309452983166815703@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 3/7] drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs
Date:   Thu, 20 Dec 2018 12:19:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-12-19 14:11:01)
> diff --git a/drivers/irqchip/qcom-pdc-data.c b/drivers/irqchip/qcom-pdc-d=
ata.c
> new file mode 100644
> index 000000000000..99b4be0af5db
> --- /dev/null
> +++ b/drivers/irqchip/qcom-pdc-data.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include "qcom-pdc.h"
> +
> +static const struct pdc_gpio_pin_map sdm845_gpio_pdc_map[] =3D {
> +       { 1, 30 },
> +       { 3, 31 },
> +       { 5, 32 },
> +       { 10, 33 },
> +       { 11, 34 },
> +       { 20, 35 },
> +       { 22, 36 },
> +       { 24, 37 },
> +       { 26, 38 },
> +       { 30, 39 },
> +       { 31, 117 },
> +       { 32, 41 },
> +       { 34, 42 },
> +       { 36, 43 },
> +       { 37, 44 },
> +       { 38, 45 },
> +       { 39, 46 },
> +       { 40, 47 },
> +       { 41, 115 },
> +       { 43, 49 },
> +       { 44, 50 },
> +       { 46, 51 },
> +       { 48, 52 },
> +       { 49, 118 },
> +       { 52, 54 },
> +       { 53, 55 },
> +       { 54, 56 },
> +       { 56, 57 },
> +       { 57, 58 },
> +       { 58, 59 },
> +       { 59, 60 },
> +       { 60, 61 },
> +       { 61, 62 },
> +       { 62, 63 },
> +       { 63, 64 },
> +       { 64, 65 },
> +       { 66, 66 },
> +       { 68, 67 },
> +       { 71, 68 },
> +       { 73, 69 },
> +       { 77, 70 },
> +       { 78, 71 },
> +       { 79, 72 },
> +       { 80, 73 },
> +       { 84, 74 },
> +       { 85, 75 },
> +       { 86, 76 },
> +       { 88, 77 },
> +       { 89, 116 },
> +       { 91, 79 },
> +       { 92, 80 },
> +       { 95, 81 },
> +       { 96, 82 },
> +       { 97, 83 },
> +       { 101, 84 },
> +       { 103, 85 },
> +       { 104, 86 },
> +       { 115, 90 },
> +       { 116, 91 },
> +       { 117, 92 },
> +       { 118, 93 },
> +       { 119, 94 },
> +       { 120, 95 },
> +       { 121, 96 },
> +       { 122, 97 },
> +       { 123, 98 },
> +       { 124, 99 },
> +       { 125, 100 },
> +       { 127, 102 },
> +       { 128, 103 },
> +       { 129, 104 },
> +       { 130, 105 },
> +       { 132, 106 },
> +       { 133, 107 },
> +       { 145, 108 },
> +};
> +
> +static const struct pdc_gpio_pin_data sdm845_gpio_data =3D {
> +       .size =3D ARRAY_SIZE(sdm845_gpio_pdc_map),
> +       .map =3D sdm845_gpio_pdc_map,
> +};
> +
> +const struct of_device_id pdc_gpio_match_table[] =3D {
> +       { .compatible =3D "qcom,845-pdc", .data =3D &sdm845_gpio_data },

Why not qcom,sdm845-pdc?

> +       { },
> +};

I wonder why we wouldn't just put this all into the qcom-pdc.c file at
the bottom and then have that IRQCHIP_DECLARE() macros call small
functions that pass the pdc to gpio mapping table to qcom_pdc_init()
that takes a third argument?

I really hope that in the future all the gpios can be wakeup capable so
that we don't need to have the table at all!

