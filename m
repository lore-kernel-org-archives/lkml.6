Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE55EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C22821470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jhR9MZOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C22821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJTBpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:45:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36770 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:45:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id p89-v6so31554547ljb.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7KHiUF44bQRZmdTMHbZLI0eFZBW8U/wdhwfWfOTuAfM=;
        b=jhR9MZOCo3rl8duzGeJEFSuZpC1uu4U/aOSsMgOUhkeqsaTnzZMJGu0Pkbs9obAT/6
         cNjMHnP7yNHC1HyTwHO2dlYEc+JqicZuNsA5xCxYdpjOk1LnSY3xW87EaGUAst0SnIvI
         3Q9z5gIlOztZV+9QYM80nv45lwMXB3XhnbLYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7KHiUF44bQRZmdTMHbZLI0eFZBW8U/wdhwfWfOTuAfM=;
        b=gToaW5/vaA44XLWCJKRY44eSZm2aznPvhvs5My5CnipMCcAmVZnio7Ql6hZiMcxkM3
         7eOU2U8WG4PRNkTEo3tYe5+Aqqf1qgwYUYn7mDl6nQ4ts0tTHtbnKheuXzpxAYc0MG/l
         /ZYl/JxBEZoQdVHJxjMMC/Xxv6Hc3BAW8ujLlODATiDOaX4674JpM21q6uOwffWUzZM3
         GHMtlB8vbRR74Wymzewf0DTuo7eHO5PBQnU305QS3m9w0telHhMYFoeGb7/vE2XAIZtT
         mWfh+3Twc5XEh081+GCMqOd9shusYMXQIWnp2TqH8K5soJLsfkZlqGl5DqfcUQlcZNWh
         E4Ig==
X-Gm-Message-State: ABuFfogZCcICeJigFrE0od/zyunuejx0qTx7MdiAv4mh/kvyD4LkvKll
        w39oJcgwli0r6ioKl5PEaLhZQDczJQo=
X-Google-Smtp-Source: AJdET5frCinIgg3XfZjFcekZJXUSyDBbmqgaMSPZnvtqFGtzpr4UI52ihbsVB5jSlgPKObrzfOvu3g==
X-Received: by 2002:a2e:2997:: with SMTP id p23-v6mr5036602ljp.12.1539970697161;
        Fri, 19 Oct 2018 10:38:17 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 71-v6sm5541029lja.90.2018.10.19.10.38.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 10:38:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id a82-v6so25845629lfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:38:12 -0700 (PDT)
X-Received: by 2002:a19:1cb:: with SMTP id 194mr3571764lfb.61.1539970692112;
 Fri, 19 Oct 2018 10:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180920182903.19991-1-georgi.djakov@linaro.org>
In-Reply-To: <20180920182903.19991-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 19 Oct 2018 10:37:35 -0700
X-Gmail-Original-Message-ID: <CAE=gft4BCgrPCf5UuhxMh8ORCk40C4tnFxWy-QQJ4ag+yObwvg@mail.gmail.com>
Message-ID: <CAE=gft4BCgrPCf5UuhxMh8ORCk40C4tnFxWy-QQJ4ag+yObwvg@mail.gmail.com>
Subject: Re: [RFC] i2c: qup: Use the interconnect API
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 11:29 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> The interconnect API provides an interface for consumer drivers to express
> their bandwidth needs in the SoC. This data is aggregated and the on-chip
> interconnect hardware is configured to the appropriate power/performance
> profile.
>
> Use the interconnect API to get() the path between the endpoints used for
> data transfers by the I2C QUP and report the needed bandwidth based on the
> i2c mode.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>
> This patch depends on the interconnect API: https://lkml.org/lkml/2018/8/31/444
>
> TODO: Use a macro for converting and rounding to icc units instead of
> converting between kilobits, kilobytes etc. in the consumer drivers.
>
>  drivers/i2c/busses/i2c-qup.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index c86c3ae1318f..436747a74dc6 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -14,6 +14,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -280,6 +281,11 @@ struct qup_i2c_dev {
>         void (*read_rx_fifo)(struct qup_i2c_dev *qup);
>         /* function to write tags in tx fifo for i2c read transfer */
>         void (*write_rx_tags)(struct qup_i2c_dev *qup);
> +
> +       /* frequency mode standard */
> +       u32                     clk_freq;
> +       /* interconnect path to scale according to bandwidth needs */
> +       struct icc_path         *path;
>  };
>
>  static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
> @@ -1657,6 +1663,16 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
>         clk_disable_unprepare(qup->pclk);
>  }
>
> +static void qup_i2c_enable_icc(struct qup_i2c_dev *qup)
> +{
> +       icc_set(qup->path, 0, qup->clk_freq / 8000);

So this specifies an average bandwidth of zero, and a peak bandwidth
of freq / 8000? Can you explain why that is the right choice?
Also, where is this 8000 coming from? Can that be a define, and
possibly explained?

> +}
> +
> +static void qup_i2c_disable_icc(struct qup_i2c_dev *qup)
> +{
> +       icc_set(qup->path, 0, 0);
> +}
> +
