Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FBBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68FF218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbeLXJSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:18:30 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38338 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbeLXJSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:18:30 -0500
Received: from [46.183.103.8] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gbMNT-0003RC-Ne; Mon, 24 Dec 2018 10:18:23 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: fix frac settings of GPLL clock for rk3328
Date:   Mon, 24 Dec 2018 10:18:22 +0100
Message-ID: <1898630.x4fnsSTjcx@phil>
In-Reply-To: <20181222164249.25620-1-katsuhiro@katsuster.net>
References: <20181222164249.25620-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 22. Dezember 2018, 17:42:49 CET schrieb Katsuhiro Suzuki:
> This patch fixes settings of GPLL frequency in fractional mode for
> rk3328. In this mode, FOUTVCO is calcurated by following formula:
>   FOUTVCO = FREF * FBDIV / REFDIV + ((FREF * FRAC / REFDIV) >> 24)
> 
> The problem is in FREF * FRAC >> 24 term. This result always lacks
> one from target value is specified by rate member. For example first
> itme of rk3328_pll_frac_rate originally has
>   - rate  : 1016064000
>   - refdiv: 3
>   - fbdiv : 127
>   - frac  : 134217
>   - FREF * FBDIV / REFDIV        = 1016000000
>   - (FREF * FRAC / REFDIV) >> 24 = 63999
> Thus calculated rate is 1016063999. It seems wrong.
> 
> If frac has 134218 (it is increased 1 from original value), second
> term is 64000. All other items have same situation. So this patch
> adds 1 to frac member in all items of rk3328_pll_frac_rate.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 4.22 with Elaine's Acked-by

Thanks
Heiko


