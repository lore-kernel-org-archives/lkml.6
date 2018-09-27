Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E957C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C0B2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ObuFSdcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C0B2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeI0J2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:28:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36941 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0J2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:28:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id c13-v6so730285qkm.4;
        Wed, 26 Sep 2018 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFwqrzzDr3xGOOs7mqhftLHkD8lxO4pi0kmhvhoCsM4=;
        b=ObuFSdcBvXNwY/MeYSXYaQTb1uiDhiGnxvV90FGneI6FWC2ybHb4C3dKrfAIDxBQrT
         OzW9xx8KaZVDlZ8kKF1Y1bXt/GNabZ25N9R7suIeo92u/rvFclM4xuvggCNAssaPoBvO
         l/Q1RIAAAiweKSm+1NQ1xAJgphBY8iwz8BaqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFwqrzzDr3xGOOs7mqhftLHkD8lxO4pi0kmhvhoCsM4=;
        b=drN1x0Ck+qmSUUg4She9TwBSKmzhyFqAde3ixjhMbFK6e0IIGcE5XAQF4+e/M43ey4
         X3TH1RAEVPJWnuz8CAQzmFplYYov5i06o3isKlJ0dgA42SmBVR0wEvNvcM7UJXDM0oHS
         HSueRdcO7T2lgFr7zOpHUxGDT9o4ClHB66DehQjf4iz+ON7US2kIEW5musTZiMEyvxRT
         NVxocDMwAYvNpCDKgyjLbqItuwmGHSlxGhhlCNzgopeasVlhFHinIcgzYelqTBnJ/atK
         +hC8XdmyIfmRJ/xVf2wvBDmnmUR5D8lwmPrUEmWnSqsy9oI9NjtqeFTrnbfyUNitjFfs
         /ubg==
X-Gm-Message-State: ABuFfojvXTQfUZSDt8tUq7enl6uIlePRjQnokG8VkcMm/LRfreXKhHDF
        TG+loLzOXHmMppLJwZGaMKn/qsTQ1hH92hNCwrZWEKej+bE=
X-Google-Smtp-Source: ACcGV62F6xgJagmjKzKPpVuZgcdocY8LC/5KOOEVeU3N+9/lJsOrB+p28TvR3nXa3C+KLXeMekoWg4TJoAPT326tJD8=
X-Received: by 2002:a37:ae86:: with SMTP id x128-v6mr6541286qke.25.1538017932456;
 Wed, 26 Sep 2018 20:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com> <20180926215842.23125-3-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20180926215842.23125-3-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 27 Sep 2018 07:11:59 +0400
Message-ID: <CACPK8XcKms88EcpT3soE6wLyAmvyiLfVkNeOQT0FgmY4eZoDrw@mail.gmail.com>
Subject: Re: [PATCH i2c-next v3 2/3] i2c: aspeed: Add 'aspeed,timeout' DT
 property reading code
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 at 01:58, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds reading code of the 'aspeed,timeout' DT property
> to set 'timeout' value in adapter configuration. This value still
> case be configured through an I2C_TIMEOUT ioctl on cdev too.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 8dc9161ced38..0d934ce0c028 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -115,6 +115,9 @@
>  /* 0x18 : I2CD Slave Device Address Register   */
>  #define ASPEED_I2CD_DEV_ADDR_MASK                      GENMASK(6, 0)
>
> +/* Timeout */
> +#define ASPEED_I2C_BUS_TIMEOUT_US_DEFAULT              (5 * 1000 * 1000)

The 5 seconds time out is way too long. On a system that doesn't have
functional i2c, this holds up boot for a long time as most i2c client
drivers try to initialise their device and fail. I realise you're not
changing the value, but we should pick a better default. 1 second?
Half a second?

> +
>  enum aspeed_i2c_master_state {
>         ASPEED_I2C_MASTER_INACTIVE,
>         ASPEED_I2C_MASTER_START,
> @@ -885,6 +888,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         struct clk *parent_clk;
>         struct resource *res;
>         int irq, ret;
> +       u32 timeout_us;
>
>         bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>         if (!bus)
> @@ -918,6 +922,11 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>                 bus->bus_frequency = 100000;
>         }
>
> +       ret = of_property_read_u32(pdev->dev.of_node, "aspeed,timeout",
> +                                  &timeout_us);

Can we make this binding generic? It's not specific to aspeed's
hardware. Getting the value could even part of the i2c core.

I read the previous thread with Wolfram. I think this would still fit
with what Wolfram suggested, but please forgive my jetlagged brain if
I've missed something.

Cheers,

Joel
> +       if (ret)
> +               timeout_us = ASPEED_I2C_BUS_TIMEOUT_US_DEFAULT;
> +
>         match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);
>         if (!match)
>                 bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
> @@ -930,7 +939,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         init_completion(&bus->cmd_complete);
>         bus->adap.owner = THIS_MODULE;
>         bus->adap.retries = 0;
> -       bus->adap.timeout = 5 * HZ;
> +       bus->adap.timeout = usecs_to_jiffies(timeout_us);
>         bus->adap.algo = &aspeed_i2c_algo;
>         bus->adap.dev.parent = &pdev->dev;
>         bus->adap.dev.of_node = pdev->dev.of_node;
> --
> 2.19.0
>
