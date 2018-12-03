Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CA4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B34208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ3SS/sE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B34208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLCTby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCTby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:31:54 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5812146D;
        Mon,  3 Dec 2018 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543865508;
        bh=/tu1B3Tvpt5e9OWM4uOsnuS5dI/SkfzdXsllXp+AuSM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=LZ3SS/sE7WdlrSOAvvai2uJz+RrR6ISX2hCvwVxIDjDCJnTF4HMLJmUwIXwRdEL/g
         hNkBrB0kpEuDuVoO6UeqHwsv3za+SlCs2jaxJg4MrC+bBxhOQ8qvhxk9rj1oM+yfCc
         d3MGfJ+pa7GgWl/b5hqAFSn8yo/6oa9cLnHpY41s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-2-git-send-email-aisheng.dong@nxp.com>
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
 <1542200198-3017-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386550758.88331.8573266036365450221@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 1/9] clk: imx: add gatable clock divider support
Date:   Mon, 03 Dec 2018 11:31:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting A.s. Dong (2018-11-14 05:01:35)
> For dividers with zero indicating clock is disabled, instead of giving a
> warning each time like "clkx: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not
> set" in exist code, we'd like to introduce enable/disable function for it.
> e.g.
> 000b - Clock disabled
> 001b - Divide by 1
> 010b - Divide by 2
> ...
> =

> Set rate when the clk is disabled will cache the rate request and only
> when the clk is enabled will the driver actually program the hardware to
> have the requested divider value. Similarly, when the clk is disabled we'=
ll
> write a 0 there, but when the clk is enabled we'll restore whatever rate
> (divider) was chosen last.
> =

> It does mean that recalc rate will be sort of odd, because when the clk is
> off it will return 0, and when the clk is on it will return the right rat=
e.
> So to make things work, we'll need to return the cached rate in recalc ra=
te
> when the clk is off and read the hardware when the clk is on.
> =

> NOTE for the default off divider, the recalc rate will still return 0 as
> there's still no proper preset rate. Enable such divider will give user
> a reminder error message.
> =

> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> =

> ---

Applied to clk-next

