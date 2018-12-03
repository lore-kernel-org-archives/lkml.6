Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106D9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA433214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1VavgUKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA433214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeLCTcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:32:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCTcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:32:45 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA417208A3;
        Mon,  3 Dec 2018 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543865559;
        bh=4bP7New99I5IjCoQ+tB0VrAfQHewIzJFR3Qi+YsKEt8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=1VavgUKdYWRYlHHR3Y23oMB+HnM54kz8Jq1di0yR18QZX+FWSFXEY7nJkB6ZihZS7
         ykqg/6TKlTWyeW7KYLGSVI9dgzHbaSp0N4IgDUg/1+oljXSUw8XIx7GW+/Yl05OnzH
         +j6n8tTXD7IURGTW1rfXI6JBHZWz0/PEL+TsUzik=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-10-git-send-email-aisheng.dong@nxp.com>
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
 <1542200198-3017-10-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386555833.88331.17771094561482296098@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 9/9] clk: imx: add imx7ulp clk driver
Date:   Mon, 03 Dec 2018 11:32:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting A.s. Dong (2018-11-14 05:02:08)
> i.MX7ULP Clock functions are under joint control of the System
> Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> modules, and Core Mode Controller (CMC)1 blocks
> =

> The clocking scheme provides clear separation between M4 domain
> and A7 domain. Except for a few clock sources shared between two
> domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> and and the Fast IRC clock (FIRCLK), clock sources and clock
> management are separated and contained within each domain.
> =

> M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> =

> This driver only adds clock support in A7 domain.
> =

> Note that most clocks required to be operated when gated, e.g. pll,
> pfd, pcc. And more special cases that scs/ddr/nic mux selecting
> different clock source requires that clock to be enabled first,
> then we need set CLK_OPS_PARENT_ENABLE flag for them properly.
> =

> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> =

> ---

Applied to clk-next

