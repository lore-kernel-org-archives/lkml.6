Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFDEECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA95220657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7RcLyzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA95220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbeJ3DeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJ3DeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:34:21 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C344420657;
        Mon, 29 Oct 2018 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540838666;
        bh=t8Ga+SpI0UaSMXTdp9HoTHqRic9AEDEeTRc8Xd/YbsA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=a7RcLyzlD0IzVtlLeK8TP5r1vk93TApfl7eT4DiBVEp8p5xPwC/ayiLWol4IM0DNv
         vrmQnmY6Y0o+8VLgQ+R+kY7sD4pBLxvCsWWUY60VEx4yGox40JOpXc2UD0eTpsOcBX
         Gv3QcAIPwdzJ+Ik+PuUC4h5km3w7C6GPIZrFuknE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>, tdas@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <360c18d625d6e4792e9ba830c6d0b6ea@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
References: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
 <ba0d7d92-5ad9-2dcf-c5a5-21332df193f0@codeaurora.org>
 <153911832719.119890.11984877060665330428@swboyd.mtv.corp.google.com>
 <7d4012b9-e71d-f114-b228-7198f07ea767@codeaurora.org>
 <153936574404.5275.10513827793530511886@swboyd.mtv.corp.google.com>
 <7ad2344b-2307-3fb3-c34e-7443fb3a1ec8@codeaurora.org>
 <42e20a5e-beb4-fdc1-cf4a-f6329b09a476@codeaurora.org>
 <153978601529.5275.17218656685998024623@swboyd.mtv.corp.google.com>
 <5f1b1ab5-e2eb-05ff-7b6d-8557f6dd2ad9@codeaurora.org>
 <360c18d625d6e4792e9ba830c6d0b6ea@codeaurora.org>
Message-ID: <154083866621.98144.2623382791446489204@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Mon, 29 Oct 2018 11:44:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting tdas@codeaurora.org (2018-10-25 03:51:01)
> On 2018-10-19 16:09, Taniya Das wrote:
> > On 10/17/2018 7:50 PM, Stephen Boyd wrote:
> >> Quoting Taniya Das (2018-10-17 05:04:10)
> >>> =

> >>> =

> >>> =

> >>> But the problem is not during the above. It is the below
> >>> static void clk_disable_unused_subtree(struct clk_core *core)
> >>> {
> >>> ....
> >>> =

> >>>           if (clk_core_is_enabled(core)) {  --> This access fails.
> >>> ....
> >>> =

> >>> }
> >>> =

> >> =

> >> You may need to add some prepare_ops to turn on clks needed to
> >> read/write lpass registers. Or you can look into using some sort of
> >> genpd to enable required clks when these clks are enabled or disabled.
> >> But I suspect it would be easier to just leave the clks in GCC for =

> >> lpass
> >> always enabled and not worry about the complicated genpd things.
> >> =

> > =

> > I need to check if keeping them enabled/marking them CRITICAL could
> > have an impact on the reset of the subsystem.
> =

> I have checked internally with the teams and the GCC LPASS clocks could =

> be left enabled.
> Would submit a patch keeping them CRITICAL.

Awesome! Thanks for checking.

