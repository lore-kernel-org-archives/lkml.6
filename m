Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCD8217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549405105;
	bh=1KxpbNDUtd9p0XTakha1cU6vHm25z1i9tDxWJUMCw7c=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=YT21b5KJT5wCpX1mTiAbXjTxUD6V+XmbCfp1Fn/D/8+wPIu2NwC+Cc7GLDmDrdAdL
	 YNy/Z6LvsKj9ETvOxoANePeD2EzfR6sA6Ff8Rq4yURnxN+48GIrLhUtbAa8TBljzvP
	 NmhuL+KcW9zgdfZnYFWB0Z7H22cPb6Pod/GOvxNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfBEWSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfBEWSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:18:22 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD1620823;
        Tue,  5 Feb 2019 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549405102;
        bh=1KxpbNDUtd9p0XTakha1cU6vHm25z1i9tDxWJUMCw7c=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=oyFrFIcjMJYaAxzblv5l42Ewz9cWQvg6oEI2bptKXchFWFQCpUblc+uLViq4T3g+m
         3P+M0u3c6VkENXBTac+6SwKXxgtjOrtm1tuNlTOBleL9ol1BPl3gLnLfvbb8aaXaPl
         7dy9LFyEhAmmqtyt94msYQhGfs4WNHosJ6bS0uQE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] clk: meson: Add G12A AO Clock + Reset Controller
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940510132.169292.12584338453129084603@swboyd.mtv.corp.google.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190204091331.9298-1-narmstrong@baylibre.com> <20190204091331.9298-3-narmstrong@baylibre.com>
User-Agent: alot/0.8
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
In-Reply-To: <20190204091331.9298-3-narmstrong@baylibre.com>
Date:   Tue, 05 Feb 2019 14:18:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-02-04 01:13:30)
> + * Register offsets from the data sheet must be multiplied by 4.
> + */
> +#define AO_RTI_STATUS_REG3     0x0C
> +#define AO_RTI_PWR_CNTL_REG0   0x10
> +#define AO_RTI_GEN_CNTL_REG0   0x40
> +#define AO_CLK_GATE0           0x4c
> +#define AO_CLK_GATE0_SP                0x50
> +#define AO_OSCIN_CNTL          0x58
> +#define AO_CEC_CLK_CNTL_REG0   0x74
> +#define AO_CEC_CLK_CNTL_REG1   0x78
> +#define AO_SAR_CLK             0x90
> +#define AO_RTC_ALT_CLK_CNTL0   0x94
> +#define AO_RTC_ALT_CLK_CNTL1   0x98
> +
> +#define AXG_AO_GATE(_name, _reg, _bit)                                 \
> +static struct clk_regmap g12a_aoclk_##_name =3D {                       =
         \
> +       .data =3D &(struct clk_regmap_gate_data) {                       =
 \
> +               .offset =3D (_reg),                                      =
 \
> +               .bit_idx =3D (_bit),                                     =
 \
> +       },                                                              \
> +       .hw.init =3D &(struct clk_init_data) {                           =
 \
> +               .name =3D  "g12a_ao_" #_name,                            =
 \
> +               .ops =3D &clk_regmap_gate_ops,                           =
 \
> +               .parent_names =3D (const char *[]){ IN_PREFIX "mpeg-clk" =
}, \
> +               .num_parents =3D 1,                                      =
 \
> +               .flags =3D CLK_IGNORE_UNUSED,                            =
 \

Can you please add a comment explaining why CLK_IGNORE_UNUSED is here?
It will help future readers know what's going on with this special flag.

