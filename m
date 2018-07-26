Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3677C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A90720673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yaYTGkJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A90720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbeGZIqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbeGZIqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:46:55 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9FE20883;
        Thu, 26 Jul 2018 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532590283;
        bh=YTt4Ti+XMXqNqX6Gav4Kf8NBmK8ci95gbpQEY9plqhQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=yaYTGkJrlnGpnFUNl2jw0m9NX/5DMgHfBMc3PzjP5izPyx+O6ZkKgNE/SKVviHfqj
         LL97aR7W85r25VvIS9CU5y9/q4axxEkO3iIgsCBRTv1GhVUliV4VWluwWVV7pKG28y
         0PFl69pns1K7SJVQZLjMrH95nVLO7XG9eEDX0kZc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b202fe11-108f-c62c-bb6d-9e3a7de5a964@gmail.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <20180720075422.26563-1-marcel@ziswiler.com>
 <153256109511.48062.12389268791907553857@swboyd.mtv.corp.google.com>
 <b202fe11-108f-c62c-bb6d-9e3a7de5a964@gmail.com>
Message-ID: <153259028259.48062.10565668407094066922@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: tegra: probe deferral error reporting
Date:   Thu, 26 Jul 2018 00:31:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Geis (2018-07-25 16:42:34)
> On 7/25/2018 7:24 PM, Stephen Boyd wrote:
> > Quoting Marcel Ziswiler (2018-07-20 00:54:22)
> >> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >>
> >> Actually report the error code from devm_regulator_get() which may as
> >> well just be a probe deferral.
> >>
> >> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >>
> >> ---
> >>
> >>   drivers/clk/tegra/clk-dfll.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll=
.c
> >> index 48ee43734e05..b2123084e175 100644
> >> --- a/drivers/clk/tegra/clk-dfll.c
> >> +++ b/drivers/clk/tegra/clk-dfll.c
> >> @@ -1609,8 +1609,9 @@ int tegra_dfll_register(struct platform_device *=
pdev,
> >>   =

> >>          td->vdd_reg =3D devm_regulator_get(td->dev, "vdd-cpu");
> >>          if (IS_ERR(td->vdd_reg)) {
> >> -               dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
> >> -               return PTR_ERR(td->vdd_reg);
> >> +               ret =3D PTR_ERR(td->vdd_reg);
> >> +               dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n=
", ret);
> > =

> > Do you want to know that a probe defer is happening? Usually patches are
> > sent to make that error path silent.
> > =

> =

> Just asking as the newbie here, but shouldn't probe deferral be =

> regulated to dev_debug?
> Then pass any other error code as dev_err.

Yes probe defer should be relegated to debug level prints. Or really, we
should introduce a more complicated system to make debugging probe defer
errors simpler by informing us which driver is probe defering on what
resource by putting debug prints in each framework that returns probe
defer errors instead of updating each driver that uses these frameworks
and thinks it needs to print errors in these cases. And hide all that
behind some kernel commandline parameter and/or Kconfig option that lets
us turn the prints off all the time if we're not developing drivers or
testing things.

