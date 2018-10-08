Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A772C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45BC20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZaNu6uwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45BC20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJIHAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:00:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40435 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIHAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:00:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so8516929pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=hJSvbOD9sUTxL2hxEdVBDL7la7p+E79kN7K2RP/hyDk=;
        b=ZaNu6uwYd4/9NPhY6z8gSixOE5DxCoMZtFpYL5CuYhtAV1PmsaLc/isypk06GxVhj6
         qAYH4ncfQhJ+WAiJZ3204HoDaWtKhDdFy1+7PNZHaBtLJ9+gDl3frfhxYnOPb0kb/i9n
         gORwPbnIGXEkWmlzyRxAC+IXhEFaToxft+HFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=hJSvbOD9sUTxL2hxEdVBDL7la7p+E79kN7K2RP/hyDk=;
        b=BYR5hiY5dYqw3ZepiKwRO3BsVnViZM9uAuB9ndh1YHj8qgbnY80QBygmEAJ2b1Ze5w
         /zNRetxql1k8h4TyCaolCwdn76mkML7B6c+fKF2YKxFg5u6vV1IlYz4jdavENr7fbfMy
         sfNrzC75OKhK6+jK0H5zouXGkWPyluu+fZu24nQgmU2pvnivm5Ahl/MPk9UpFtsGft/K
         eIycxoTaYwIoA9h+sUJEr4Ff0AE1Xiuq66a3hptJTE4ENXRJbwBfXv5maRS+JXnedcsG
         CpRTBuEJ1vPCmrdglQHDqpn81y1WV/Bj4eH9smyXcPl1DU4wGuAsoGk5EHiAUhqrlQjs
         6u6g==
X-Gm-Message-State: ABuFfohnO5YTX4aQcwzSWzMA75g2L3N/4/YHoP10Y4QJEGC76dJZ8bJm
        ZJ6qZt5Qd8PBmA2w/aQsUloPxA==
X-Google-Smtp-Source: ACcGV605I/3ObIOthomKcsDWpWffQUgB32GZn4t3v6SpExWgJUumPHREYct3OI+0xevxcHylC4RgNQ==
X-Received: by 2002:a63:ae4d:: with SMTP id e13-v6mr23253062pgp.315.1539042373138;
        Mon, 08 Oct 2018 16:46:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id q7-v6sm25451574pfd.164.2018.10.08.16.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 16:46:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>, Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181002214709.162330-2-ryandcase@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20181002214709.162330-1-ryandcase@chromium.org>
 <20181002214709.162330-2-ryandcase@chromium.org>
Message-ID: <153904237198.119890.2367876217526144231@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date:   Mon, 08 Oct 2018 16:46:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-10-02 14:47:08)
> From: Girish Mahadevan <girishm@codeaurora.org>
> =

> New driver for Qualcomm QuadSPI(QSPI) controller that is used to
> communicate with slaves such as flash memory devices. The QSPI controller
> can operate in 2 or 4 wire mode but only supports SPI Mode 0. The
> controller can also operate in Single or Dual data rate modes.
> =

> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

One nitpick below. Looks better now, thanks!

> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> new file mode 100644
> index 000000000000..b8163b40bb92
> --- /dev/null
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -0,0 +1,581 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>
[...]
> +
> +struct qspi_xfer {
> +       union {
> +               const void *tx_buf;
> +               void *rx_buf;
> +       };
> +       unsigned int rem_bytes;
> +       unsigned int buswidth;
> +       enum qspi_dir dir;
> +       bool is_last;
> +};
> +
> +enum qspi_clocks {
> +       QSPI_CLK_CORE,
> +       QSPI_CLK_IFACE,
> +       QSPI_NUM_CLKS
> +};
> +
> +struct qcom_qspi {
> +       void __iomem *base;
> +       struct device *dev;
> +       struct clk_bulk_data clks[QSPI_NUM_CLKS];
> +       struct qspi_xfer xfer;
> +       /* Lock to protect data accessed by IRQs */

Nitpick: What data? Registers? The SPI core can't do it?

> +       spinlock_t lock;
> +};
