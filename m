Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5816C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE1720834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE1720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeLAI1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:27:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59950 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:27:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CFB3714E0EF4B;
        Fri, 30 Nov 2018 13:16:48 -0800 (PST)
Date:   Fri, 30 Nov 2018 13:16:48 -0800 (PST)
Message-Id: <20181130.131648.1001002082761494151.davem@davemloft.net>
To:     thierry.reding@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: Move debugfs init/exit to
 ->probe()/->remove()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181127132143.10473-1-thierry.reding@gmail.com>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
        <20181127132143.10473-1-thierry.reding@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Nov 2018 13:16:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 27 Nov 2018 14:21:43 +0100

> From: Thierry Reding <treding@nvidia.com>
> 
> Setting up and tearing down debugfs is current unbalanced, as seen by
> this error during resume from suspend:
> 
>     [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to create debugfs directory
>     [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: failed debugFS registration
> 
> The imbalance happens because the driver creates the debugfs hierarchy
> when the device is opened and tears it down when the device is closed.
> There's little gain in that, and it could be argued that it is even
> surprising because it's not usually done for other devices. Fix the
> imbalance by moving the debugfs creation and teardown to the driver's
> ->probe() and ->remove() implementations instead.
> 
> Note that the ring descriptors cannot be read while the interface is
> down, so make sure to return an empty file when the descriptors_status
> debugfs file is read.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> This applies on top of net-next.
> 
> Changes in v2:
> - avoid access to ring descriptors when interface is down

Applied, thanks.
