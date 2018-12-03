Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70EDC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD83208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xxtHWDop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD83208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLCTc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCTc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:32:29 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D73E2081C;
        Mon,  3 Dec 2018 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543865542;
        bh=YavQxUs2aYtJS3H9JApIzgtskWnmMskf54E//MhiYxA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=xxtHWDopi9r4p13gWunA1yjpQsji9gIN0FswBoWsTa7V82w5PmlsqozH9jNfPnYdo
         pT8RxVr8xBaRorub6wW0UEbBhyA9j94GScqPQjiNzXLevwZ/Lr1N3qsn8BYXpbvfHm
         g0Zsv2ZteabsyOOxRUZHGmN1rbsMuPnXpmbSxd8g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-8-git-send-email-aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-8-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386554175.88331.9328534190030483928@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 7/9] clk: imx: make mux parent strings const
Date:   Mon, 03 Dec 2018 11:32:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting A.s. Dong (2018-11-14 05:02:00)
> As the commit 2893c379461a ("clk: make strings in parent name arrays
> const"), let's make the parent strings const, otherwise we may meet
> the following warning when compiling:
> =

> drivers/clk/imx/clk-imx7ulp.c: In function 'imx7ulp_clocks_init':
> drivers/clk/imx/clk-imx7ulp.c:73:35: warning: passing argument 5 of
>         'imx_clk_mux_flags' discards 'const' qualifier from pointer targe=
t type
> =

>   clks[IMX7ULP_CLK_APLL_PRE_SEL] =3D imx_clk_mux_flags("apll_pre_sel", ba=
se + 0x508, 0,
>         1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
>                                    ^
> In file included from drivers/clk/imx/clk-imx7ulp.c:23:0:
> drivers/clk/imx/clk.h:200:27: note: expected 'const char **' but argument=
 is
>  of type 'const char * const*'
> ...
> =

> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> =

> ---

Applied to clk-next

