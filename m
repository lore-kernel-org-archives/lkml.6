Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983B0204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983B0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeKAKhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:37:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAKhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:37:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FC7C14712FCD;
        Wed, 31 Oct 2018 18:36:29 -0700 (PDT)
Date:   Wed, 31 Oct 2018 18:36:28 -0700 (PDT)
Message-Id: <20181031.183628.2259691990575006225.davem@davemloft.net>
To:     niklas.cassel@linaro.org
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com, vkoul@kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Fix stmmac_mdio_reset() when building
 stmmac as modules
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181031150810.16665-1-niklas.cassel@linaro.org>
References: <20181031150810.16665-1-niklas.cassel@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Oct 2018 18:36:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>
Date: Wed, 31 Oct 2018 16:08:10 +0100

> When building stmmac, it is only possible to select CONFIG_DWMAC_GENERIC,
> or any of the glue drivers, when CONFIG_STMMAC_PLATFORM is set.
> The only exception is CONFIG_STMMAC_PCI.
> 
> When calling of_mdiobus_register(), it will call our ->reset()
> callback, which is set to stmmac_mdio_reset().
> 
> Most of the code in stmmac_mdio_reset() is protected by a
> "#if defined(CONFIG_STMMAC_PLATFORM)", which will evaluate
> to false when CONFIG_STMMAC_PLATFORM=m.
> 
> Because of this, the phy reset gpio will only be pulled when
> stmmac is built as built-in, but not when built as modules.
> 
> Fix this by using "#if IS_ENABLED()" instead of "#if defined()".
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Applied and queued up for -stable, thanks.
