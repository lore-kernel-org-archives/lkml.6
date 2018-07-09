Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A9FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12668208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChK2xu0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12668208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbeGIGPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbeGIGPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:15:36 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6985E208AF;
        Mon,  9 Jul 2018 06:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531116935;
        bh=WEszDx2JbDrsXsI65q6lOjp2oRvvufRl1GmnAppR9D4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ChK2xu0BY77grMF4bingcF33zLhMGQnyKGIlOIPB0r5GAUQcEpDXcpynif3ITT9Ut
         xiWpfoW2Ob7sx2UpdMWFUdod/23vhiF2rS/jNJOo3N7p0LvrfjJ9FkLT+HL06Qc5T9
         ymGfGmvdqwP8eNDKm4MEcMqRyqGu7g6HWHmqfve8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
Message-ID: <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Date:   Sun, 08 Jul 2018 23:15:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-06-06 04:41:46)
> To turn on the gpu_gx_gdsc, there is a hardware requirement to
> turn on the root clock (GFX3D RCG) first which would be the turn
> on signal for the gdsc along with the SW_COLLAPSE. As per the
> current implementation of clk_rcg2_shared_ops, it clears the
> root_enable bit in the enable() and set_rate() clock ops. But due
> to the above said requirement for GFX3D shared RCG, root_enable bit
> would be already set by gdsc driver and rcg2_shared_ops should not clear
> the root unless the disable is called.
> =


It sounds like the GDSC enable is ANDed with the RCG's root enable
bit? Does the RCG need to be clocking for the GDSC to actually turn on?
Or is it purely that the enable bit is logically combined that way so
that if the RCG is parented to a PLL that's off the GDSC will still turn
on?

> Add support for the same by reusing the existing clk_rcg2_shared_ops
> and deriving "clk_rcg2_gfx3d_ops" clk_ops for GFX3D clock to
> take care of the root set/clear requirement.

Anyway, this patch will probably significantly change given that the RCG
is a glorified div-2 that muxes between a safe CXO speed and a
configurable PLL frequency. A lot of the logic can probably just be
hardcoded then.

> =

> Signed-off-by: Amit Nischal <anischal@codeaurora.org>

Patch looks sane.
