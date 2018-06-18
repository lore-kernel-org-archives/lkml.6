Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9541CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EC020874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EC020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbeFRHWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:22:47 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42060 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754973AbeFRHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:22:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DEFCB608D738;
        Mon, 18 Jun 2018 09:22:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YKte6Gqq596F; Mon, 18 Jun 2018 09:22:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 95A0660A3578;
        Mon, 18 Jun 2018 09:22:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IksMrOumVY2g; Mon, 18 Jun 2018 09:22:44 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 7419B60A3568;
        Mon, 18 Jun 2018 09:22:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kbuild@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 3/3] mtd: rawnand: denali: optimize timing parameters for data interface
Date:   Mon, 18 Jun 2018 09:22:44 +0200
Message-ID: <34780659.LX1KsSZy9L@blindfold>
In-Reply-To: <1529025532-22087-4-git-send-email-yamada.masahiro@socionext.com>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com> <1529025532-22087-4-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Juni 2018, 03:18:52 CEST schrieb Masahiro Yamada:
> This commit improves the ->setup_data_interface() hook.
> 
> The denali_setup_data_interface() needs the frequency of clk_x
> and the ratio of clk_x / clk.
> 
> The latter is currently hardcoded in the driver, like this:
> 
>   #define DENALI_CLK_X_MULT       6
> 
> The IP datasheet requires that clk_x / clk be 4, 5, or 6.  I just
> chose 6 because it is the most defensive value, but it is not optimal.
> By getting the clock rate of both "clk" and "clk_x", the driver can
> compute the timing values more precisely.

What datasheet do you have, is it public?
Mine clearly states that the factor is 4.
"The frequency of nand_x_clk is four times the frequency of nand_clk."

> To not break the existing platforms, the fallback value, 50 MHz is
> provided.  It is true for all upstreamed platforms.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
