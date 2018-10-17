Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738CFECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4A821526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ4qvd5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4A821526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeJQX2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbeJQX2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:28:19 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 188232150C;
        Wed, 17 Oct 2018 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539790326;
        bh=W4wduh4CjJnVogAUXOi+A23JhsE6uRKABB3hOgRrwb4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=DZ4qvd5yKxW/h9dIE3Y7n+EiI0s6x0d+m6h8CJfOoINnXcqzazndoSgQ0oM2thhm/
         peNM1sNnFaQYIpVnSBNASv03UXqoSIUYU5GZyRH6+gTex9SPyetJwmcYBhFU6wA6aO
         cMYYPA2hZ7S8hU7SH6eG5ra0aycLM/ahdm6wX9d0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     ilia.lin@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180614215358.11264-7-ilia.lin@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-7-ilia.lin@gmail.com>
Message-ID: <153979032539.5275.12064078400966025600@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v13 6/8] clk: qcom: cpu-8996: Add support to switch to alternate
 PLL
Date:   Wed, 17 Oct 2018 08:32:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ilia.lin@gmail.com (2018-06-14 14:53:53)
> @@ -227,6 +232,26 @@ clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, s=
truct clk_rate_request *req)
>         return 0;
>  }
>  =

> +int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,

static? And name it something like clk_cpu_8996_notifier?

> +                       void *data)
> +{
> +       int ret;
> +       struct clk_cpu_8996_mux *cpuclk =3D to_clk_cpu_8996_mux_nb(nb);
> +
> +       switch (event) {
> +       case PRE_RATE_CHANGE:
> +               ret =3D clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT=
_INDEX);
> +               break;
> +       case POST_RATE_CHANGE:
> +               ret =3D clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, PLL=
_INDEX);
> +               break;
> +       default:
> +               ret =3D 0;
> +               break;
> +       }
> +
> +       return notifier_from_errno(ret);
> +};
